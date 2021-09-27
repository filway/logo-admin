<?php
namespace app\wap\controller;
use app\wap\controller\Base;
use think\Db;
use app\api\controller\BaiduTransApi as Bapi;
use think\Cookie;
use app\common\library\Stat;

class Index extends Base
{

    public function index() {
        //获得百度回传bd_vid
        $seo_vid = input('bd_vid');
        if ($seo_vid) {
            Cookie::set('seo_vid', $seo_vid);
            Cookie::set('seo_type', 1);
        }

        //抖音
        $clickid = input('clickid');
        if($clickid) {
           $url = $this->request->server('REQUEST_URI');
           $referer = 'http://'.$_SERVER['HTTP_HOST'].$url;
            Cookie::set('seo_vid', $clickid);
            Cookie::set('seo_type', 2);
            Cookie::set('touyin_referer_url',$referer);
        }
        return $this->fetch();
    }

    public function newindex() {
        //获得百度回传bd_vid
        $seo_vid = input('bd_vid');
        if ($seo_vid) {
            Cookie::set('seo_vid', $seo_vid);
            Cookie::set('seo_type', 1);
        }

        //抖音
        $clickid = input('clickid');
        if($clickid) {
            $url = $this->request->server('REQUEST_URI');
            $referer = 'http://'.$_SERVER['HTTP_HOST'].$url;
            Cookie::set('seo_vid', $clickid);
            Cookie::set('seo_type', 2);
            Cookie::set('touyin_referer_url',$referer);
        }
        return $this->fetch();
    }
    public function hangye() {
        $logoName = input('name');
        $list = Db::table('industry')->where('stage',0)->cache(600)->select();
        $this->assign('list',$list);
        $this->assign('logoName',$logoName);
        return $this->fetch();
    }

    public function logop() {
        $logoName = input('name');
        $hy = input('hy');
        $hy_id = input('hy_id');
        $this->assign('logoName',$logoName);
        $this->assign('hy',$hy);
        return $this->fetch();
    }

    public function order() {
        $d = input('');
        $sn = $this->create_trade_no();
        $mobile = $d['tel'];
        $userInfo = model('User')->getUser($mobile);
        $addtime = date('Y-m-d H:i:s');
        $user_id = $userInfo['user_id'];
        if(empty($userInfo)) {
            $inData = [
                        'phone'=>$mobile,
                        'pwd'=>md5($mobile),
                        'reg_time'=>$addtime,
                        'reg_ip'=>request()->ip(),
                        'reg_client'=>request()->isMobile()?0:1,
                        'reg_address'=>request()->url(true),
                ];
            $user_id = model('User')->addUser($inData);
        }

        $api = new Bapi();
        $transRes = $api->translate($d['name']);

        $data = [
                    'order_no'=>$sn,
                    'user_id'=>$user_id,
                    'order_stage'=>0,
                    'logonameurl'=>$d['name'],
                    'creat_time'=>$addtime,
                    'industry_id'=>$d['hy'],
                    'mobile'=>$mobile,
                    'logoname_en'=> $transRes['trans_result'][0]['dst'],
                ];

        $res = model('Order')->addOrder($data);
        if($res) {
            $this->success('提交成功',url('/wap/index/pay/sn/'.$sn));
        }
        else {
            $this->error('提交失败');
        }
    }

    public function pay() {
        $sn = input('sn');
        $row = model('Order')->getOrder($sn);
        if(empty($row)) {
            $this->error('订单不存在');
        }
        $this->assign('sn',$sn);
        $this->assign('pricedata',config('payset'));
        $tpl = '';
        if($row['order_stage'] == 1) {
            $this->assign('result',$row);
            $tpl = 'errorpay';
        }
        $this->assign('logo_price',config('site.logo_price'));
        $this->assign('logo_original_price',config('site.logo_original_price'));
        return $this->fetch($tpl);
    }
}