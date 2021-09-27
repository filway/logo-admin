<?php

namespace app\api\controller;

use app\common\controller\Api;

/**
 * 示例接口
 */
class Douyinapi extends Api
{

    //如果$noNeedLogin为空表示所有接口都需要登录才能请求
    //如果$noNeedRight为空表示所有接口都需要验证权限才能请求
    //如果接口已经设置无需登录,那也就无需鉴权了
    //
  protected $noNeedLogin = '*';
  protected $noNeedRight = '*';

     /**
     * @param $token
     * @param $conversions
     * @return bool 发送成功返回 true，失败返回 false
     */
     public function index($url) {
       $ch = curl_init();

       $url = urlencode($url);
        // set url
       //curl_setopt($ch, CURLOPT_URL, 'https://ad.oceanengine.com/track/activate/?callback='.$url.'&event_type=2&conv_time='.time());
       curl_setopt($ch, CURLOPT_URL, "https://ad.oceanengine.com/track/activate/?link={$url}&conv_time=".time()."&event_type=2");

        // set method
       curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');

        // return the transfer as a string
       curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

        // send the request and save response to $response
       $response = curl_exec($ch);

        // stop if fails
       if (!$response) {
        //die('Error: "' . curl_error($ch) . '" - Code: ' . curl_errno($ch));
      }

      // echo 'HTTP Status Code: ' . curl_getinfo($ch, CURLINFO_HTTP_CODE) . PHP_EOL;
      // echo 'Response Body: ' . $response . PHP_EOL;

      // close curl resource to free up system resources 
      curl_close($ch);
    }
  }
    /*$token = '这里替换为您的 token';
    // 编辑一条转化数据
    $cv = array(
     'logidUrl' => 'http://www.b123.com/12345?XX=XXX&sg_vid=1111', // 您的落地页 url
     'convertType' => 1 // 转化类型请按实际情况填写
    );
    // 此处仅为 demo, conversions 支持添加更多数据
    $conversions = array($cv);
    $demo = new APIDemo();
    $demo->sendConvertData($token, $conversions);*/

