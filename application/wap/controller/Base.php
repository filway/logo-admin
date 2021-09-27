<?php

namespace app\wap\controller;
use think\Config;
use think\Controller;
use think\Db;
use think\Request;
use think\Cache;
use think\Cookie;

/**

 * 前台控制器基类

 */

class Base extends Controller
{
    /**

     * 布局模板

     * @var string

     */
    protected $layout   = '';

    protected $autoFsId = true;
    protected $gapp_info = [];

   public  function __construct(Request $request)
    {
        parent::__construct($request);
    }

    /**
     * [create_trade_no description]
     * @Author   pb
     * @DateTime 2021-07-03T12:09:43+0800
     * @param    string                   $prefix [description]
     * @return   [type]                           [description]
     */
    public function create_trade_no($prefix='')
    {
        //return $prefix . date('YmdHis', time()) . substr(microtime(), 2, 6) . sprintf('%03d', rand(0, 999));
        $code = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J','H','G','K','L','M','N');

        return $osn = $code[mt_rand(0,count($code)-1)] . strtoupper(dechex(date('m'))) . date('d') . substr(time(), -5) . substr(microtime(), 2, 5) . sprintf('%02d', rand(0, 99));

    }

    public function read($sn = '') {
        $tpl = '';
        $result = model('Order')->getOrder($sn);
        $this->assign('result',$result);
        if($result['order_stage'] == 1) {
          $tpl = 'errorpay';
        }
        return $this->fetch($tpl);
    }

    public function checkStatus($sn = '') {
        $result = model('Order')->getOrder($sn);
        if($result['order_stage'] == 1) {
            $this->success('支付成功');
        }
        $this->error('未支付');
    }

    public function payResult($sn) {
        $result = model('Order')->getOrder($sn);
        if($result['order_stage'] == 1) {
            $tpl = 'errorpay';
        }
        else {
            $tpl = 'checkpay';
        }
        $this->assign('result',$result);
        return $this->fetch($tpl);
    }

    public function phone_lock() {
      $order_id = input('order_id');
      $phone = input('phone');
      $res = model('Order')->where('order_no',$order_id)->update(['mobile'=>$phone]);
      if($res) {
        $this->success('绑定成功');
      }
      else {
        $this->error('绑定失败');
      }
    }

    public function getpay_wx($ti_type=0,$ti_pay = 0) {
       $wx_map['ti_status'] = 1;
       //$wx_map['ti_attr'] = 0;
       $wx_map['ti_type'] = $ti_type;
       $wx_map['ti_use_type'] = 1;
       $gs_kefu_wx = Cookie::get('gs_kefu_wx');
       if(!empty($gs_kefu_wx) && empty($ti_pay)) {
            //判断微信是否正常
            if(Db::table("fa_wexin_showcount")->where($wx_map)->count()) {
                 return $gs_kefu_wx;
            }
       }
       //$ti_type = 0;
       $t_pay_shownum = Db::table("fa_wexin_showcount")->where($wx_map)->sum('pay_shownum');
       //权重总数
       $t_weight = Db::table("fa_wexin_showcount")->where($wx_map)->sum('weight');
       $list = Db::table("fa_wexin_showcount")->where($wx_map)->order('last_edit_time asc,weight desc,shownum desc')->select();
       $t_all_num =  $t_pay_shownum;
       $t_all_num = $t_all_num?$t_all_num:1;
       $flag = false;
       $g_id = 0;
       foreach ($list as $k => $v) {
           $weight = $v['weight'];
           $t_num =  $v['pay_shownum'];
           $baifen_weight = round($weight/$t_weight,5);
           $baifen_show = round($t_num/$t_all_num,5);
           $addData = [];
           $wx = $v['wx'];
           $g_id = $v['id'];
           if($baifen_show<$baifen_weight) {
               $flag=true;
               Cookie::set('pay_kefuwx',$wx,3600*24*30); 
               Db::table("fa_wexin_showcount")->where("id",$g_id)->update([
                    'pay_shownum' =>  Db::raw('pay_shownum+1'),
                    'pay_shownum_total' => Db::raw('pay_shownum_total+1'),
                    'last_edit_paynum' =>Db::raw('last_edit_paynum+1'),
               ]);
               break;
           }
       }

       //这种情况表示所有权重分配的比例一样了
       if($flag===false) {
           Cookie::set('pay_kefuwx',$wx,3600*24*30); 
           Db::table("fa_wexin_showcount")->where("id",$g_id)->update([
                'pay_shownum' =>  Db::raw('pay_shownum+1'),
                'pay_shownum_total' =>  Db::raw('pay_shownum_total+1'),
                'last_edit_paynum' =>Db::raw('last_edit_paynum+1'),
           ]);

       }
       return $wx;
    }

    /**
     * [smsorder description]
     * @Author   pb
     * @DateTime 2021-07-05T22:06:00+0800
     * @param    string                   $sn [description]
     * @return   [type]                       [description]
     */
    public function smsorder($sn = '') {
        $row = model('Order')->getOrder($sn);
        $hy = $row['hy'];
        if($row['ti_status'] != 1) {
            return;
        }
        //特殊判断，以前的订单还是到以前的
        if($row['creat_time'] < '2021-07-31 15:30:00') {
            $industry_id = Db::table('industry')->where('industry_name',$hy)->value('industry_id');
            $industry_id = $industry_id?$industry_id:12;
            $url = "http://sj.songshuqf.com/dist/logoList?industryId={$industry_id}&inputLogoName={$row['logonameurl']}&inputLogoInfo=Yuangu%20design&color=10";
            header("location:".$url);
        }
        else {
            $url = "http://log.yuangu03.cn/?sn=".$sn;
            header("location:".$url);
        }
    }
}

