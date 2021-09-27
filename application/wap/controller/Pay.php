<?php
namespace app\wap\controller;

// use app\gscommon\controller\Frontend;
// use app\gscommon\validate\Ordersn as VdOrdersn;
use app\wap\controller\Base;
use think\Cookie;
use think\Db;
use think\Response;

class Pay extends Base
{

    public function _initialize()
    {
        parent::_initialize();
    }
    public function qrcode()
    {
        // 生成支付二维码
        $url    = urldecode($_GET["data"]);
        $qrCode = new \Endroid\QrCode\QrCode();
        $qrCode->setText($url)
            ->setSize(300)
            ->setPadding(10)
            ->setErrorCorrection('high')
            ->setForegroundColor(array('r' => 0, 'g' => 0, 'b' => 0, 'a' => 0))
            ->setBackgroundColor(array('r' => 255, 'g' => 255, 'b' => 255, 'a' => 0))
            ->setLabelFontPath(ROOT_PATH . 'public/assets/fonts/fzltxh.ttf')
            ->setLabel(config('site.name'))
            ->setLabelFontSize(16)
            ->setImageType($qrCode::IMAGE_TYPE_PNG);

        return new Response($qrCode->get(), 200, ['Content-Type' => $qrCode->getContentType()]);
    }
    protected function method($type, $order_sn, $hidden = false)
    {
        // $return_url = \think\Url::build($order->application->path . "/order/read", ['sn' => $order->sn], true, true);

        $price       = config('payset.amount');
        $subject     = 'logo支付';
        $description = 'logo支付';

        $subject = $description = "logo设计，如有疑问联系客服电话（4009219675）";
        $orderno     = $order_sn;
        $return_url  = '';
        if($orderno == '731003626396900') {
            $price = 0.01;
        }
        //更改回调地址
        $return_url = str_replace("wap", "logowap", $return_url);
        $return_url = str_replace("index", "logowap", $return_url);
        switch (strtolower($type)) {
            case 'alipay':
                $params = ['subject' => $subject, 'out_trade_no' => $orderno, 'total_amount' => $price, 'return_url' => $return_url];
                // print_R($params);exit;
                if (MobileDetect()->isMobile()) {
                    //手机版H5支付
                    \gsalipay\Wappay::pay($params);
                } else {
                    //扫码支付
                    \gsalipay\Pagepay::pay($params);
                }
                break;
            case '':
            case 'swiftpass':
            case 'wxpay':
                $config = \addons\wechat\library\Config::load();
                //$config['payment']['notify_url'] = str_replace("notify", "gsnotify", $config['payment']['notify_url']);
                #var_dump($return_url);
                #var_dump($config);die;
                //$config['payment']['notify_url'] = config('wxpay.notify_url');
                //$config['payment']['return_url'] = config('wxpay.return_url');

                $app    = new \EasyWeChat\Foundation\Application($config);

                if (MobileDetect()->isWechat()) {
                    //公众号支付
                    if (session('wechat_user')) {
                        $openid = session('wechat_user');
                    } else {
                        $tourl = request()->url(true);

                        $redirect = $config['oauth']['callback'] . '?type=getopenid&tourl=' . urlencode($tourl);
                        $app->oauth->scopes(['snsapi_userinfo'])->redirect($redirect)->send();
                    }

                    $params = [
                        'trade_type'   => 'JSAPI', // JSAPI，NATIVE，APP...
                        'body'         => $subject,
                        'detail'       => $description,
                        'out_trade_no' => $orderno,
                        'total_fee'    => $price * 100, // 单位：分
                        'openid'       => $openid,
                        'attach'       =>'gspay',
                    ];
                    //var_dump($params);die;
                    $payorder = new \EasyWeChat\Payment\Order($params);
                    $result   = $app->payment->prepare($payorder);
                    //var_dump($payorder);die;
                    if ($result->return_code == 'SUCCESS' && $result->result_code == 'SUCCESS') {
                        $prepayId = $result->prepay_id;
                    } else {
                        $this->error('生成订单失败，请重新下单!');
                    }
                    $json                      = $app->payment->configForPayment($prepayId);
                    $assign                    = array();
                    $assign['jsApiParameters'] = $json;
                    $assign['successurl']      = $assign['errorurl']      = $return_url;
                    if (!$hidden) {
                        echo $this->fetch('wxpay_jspay', $assign);
                    } else {
                        return $assign;
                    }

                } else if (MobileDetect()->isMobile()) {
                    //手机版H5支付
                    $params = [
                        'trade_type'       => 'MWEB', // JSAPI，NATIVE，APP...
                        'body'             => $subject,
                        'detail'           => $description,
                        'out_trade_no'     => $orderno,
                        'total_fee'        => $price * 100,
                        'spbill_create_ip' => request()->ip(0, true),
                        'attach'       =>'gspay',
                        // 单位：分
                    ];
                    $payorder = new \EasyWeChat\Payment\Order($params);
                    $result   = $app->payment->prepare($payorder);
                    if ($result->return_code == 'SUCCESS' && $result->result_code == 'SUCCESS') {
                        $prepayId = $result->prepay_id;
                        $codeUrl  = $result->code_url;
                    } else {
                        $this->error('生成订单失败，请重新下单!');
                    }
                    $url = $result->mweb_url . '&redirect_url=' . urlencode($return_url);
                    $this->redirect($url);
                } else {
                    //扫码支付
                    $params = [
                        'trade_type'   => 'NATIVE', // JSAPI，NATIVE，APP...
                        'body'         => $subject,
                        'detail'       => $description,
                        'out_trade_no' => $orderno,
                        'total_fee'    => $price * 100, // 单位：分
                        'attach'       =>'gspay',
                    ];
                    $payorder = new \EasyWeChat\Payment\Order($params);
                    $result   = $app->payment->prepare($payorder);
                    if ($result->return_code == 'SUCCESS' && $result->result_code == 'SUCCESS') {
                        $prepayId = $result->prepay_id;
                        $codeUrl  = $result->code_url;
                    } else {
                        print_R($result);exit;
                        $this->error('生成订单失败，请重新下单!');
                    }
                    $assign               = array();
                    $assign['order']      = $order;
                    $assign['code']       = $codeUrl;
                    $assign['result']     = $result;
                    $assign['successurl'] = $assign['errorurl'] = $return_url;
                    if (request()->isAjax()) {
                        $this->result([
                            'codeurl'    => urlencode($codeUrl),
                            'imgurl'     => url('qrcode') . '?data=' . urlencode($codeUrl),
                            'successurl' => $assign['successurl'],
                            'errorurl'   => $assign['errorurl'],
                        ], 1);
                    } elseif (input('param.isconsole/d', 0) || !empty(0)) {
                        Response::create($this->fetch('wxpay_qrcode2', $assign))->send();
                    } else {
                        Response::create($this->fetch('wxpay_qrcode', $assign))->send();
                    }
                }
                break;

            case 'ffsmpay':
                $client_type = input('get.client_type');
                $ret_type    = input('get.ret_type', 'redirect');

                if ($this->getClientFfsmPayType($client_type)) {
                    $client_type = $this->getClientFfsmPayType($client_type);
                }

                $params = ['subject' => $subject, 'body' => $description, 'out_trade_no' => $orderno, 'total_amount' => $price, 'return_url' => $return_url, 'pay_type' => 'wxpay'];
                $result = \ffsmpay\PayConsole::pay($params);
                if (isset($result['status']) && $result['status'] == 1 && $result['ret_code'] == 'SUCCESS') {
                    $url = config('ffsmpay.gateway_url');
                    $url .= "/gs/pay/index/pay_method/" . $client_type . "?sell_id=" . config('ffsmpay.merchant_id') . '&order_sn=' . $orderno . '&ret_type=' . $ret_type;
                    if ($ret_type == 'code') {
                        $assign = \ffsmpay\PayConsole::getWxPayCode($orderno);
                        Response::create(
                            $this->fetch('wxpay_qrcode', $assign)
                        )->send();
                    } else {
                        $this->redirect($url);
                    }

                } else {
                    $this->error('生成订单失败，请重新下单');
                }
                break;
            case 'other':
                $params = ['subject' => $subject, 'out_trade_no' => $orderno, 'total_amount' => $price, 'return_url' => $return_url];
                \sanpay\WebPay::pay($params)->send();
                break;
            default:
                $this->error('请选择支付方式!');
                break;
        }
    }
    /*
    统一支付接口

    $price 价格 单位元
    $subject 标题
    $description 介绍
    $orderno 订单号
    $return_url 支付返回地址

     */
    public function index()
    {
        $order_sn   = input('param.order_sn/s', '');
        $modelid    = input('param.modelid/s', 'ming');
        $pay_method = input('param.pay_method/s', 'wxpay');
        $data       = array('sn' => $order_sn);


        $order = $this->findorder($order_sn);
        if ($order) {
            $this->method($pay_method, $order_sn);
        } else {
            $this->error('订单已经失效了!', url('index'));
        }

    }

    public function paycount()
    {

        return;
        $order_sn = input('param.order_sn/s', '');
        $map      = array('sn' => $order_sn);
        /*$order =  Db::table("fa_order")
        ->where($map)
        ->where('is_pay', 1)
        ->find();
        $stat_keyword = $order['stat_keyword'];*/
        $bd_vid = Cookie::get('bd_vid');
        if (empty($bd_vid)) {
            // return;
        }
        $apiurl                       = 'https://fengchao.baidu.com/taurus/open/api/ADD/userconvertinfo';
        $post['logidUrl']             = 'http://' . $_SERVER['HTTP_HOST'] . "?bd_vid=" . $bd_vid;
        $post['isConvert']            = 1;
        $post['convertType']          = 4;
        $sendData['token']            = 'v2l1yXR2LxFw01CEMGiNh47958fcmbpl@uIUA3yHpNd75qoTZTQbdT4uZA1Vr3pi2';
        $sendData['conversionTypes']  = $post;
        $jsonstr                      = json_encode($sendData);
        list($ret_code, $ret_content) = $this->http_post_json($apiurl, $jsonstr);
        $host                         = $_SERVER['HTTP_HOST'];
        $addData['sn']                = $order_sn;
        $addData['addtime']           = date("Y-m-d H:i:s");
        $addData['host']              = $host;
        $addData['remark']            = json_encode(array('logidUrl' => $post['logidUrl'], 'code' => $ret_code, 'content' => $ret_content));
        Db::table("fa_pay_countlog")->insert($addData);
    }

    /**
     * 模拟post进行url请求
     * @param string $url
     * @param string $param
     */
    public function http_post_json($url, $jsonstr)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonstr);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: application/json; charset=utf-8',
            'Content-Length: ' . strlen($jsonstr),
        )
        );
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        return array($httpCode, $response);
    }
    protected function getClientFfsmPayType($type)
    {
        if ($type == 'wxpay' || $type == 'weixin') {
            if (MobileDetect()->isWechat()) {
                return 'weixin.jsapi';
            } else if (MobileDetect()->isMobile()) {
                return 'weixin.h5';
            } else {
                return 'weixin.native';
            }
        } else if ($type == 'alipay') {
            return 'alipay';
        }
        return '';
    }
    public function return_url()
    {
        $this->redirect(config('site.siteurl'));
    }
}
