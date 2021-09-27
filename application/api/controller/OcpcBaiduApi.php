<?php

namespace app\api\controller;

use app\common\controller\Api;

/**
 * 示例接口
 */
class OcpcBaiduApi extends Api
{

    // 无需登录的接口,*表示全部
    protected $noNeedLogin = "*";
    // 无需鉴权的接口,*表示全部
    protected $noNeedRight = "*";

    const BAIDU_OCPC_URL = 'https://ocpc.baidu.com/ocpcapi/api/uploadConvertData';
    const RETRY_TIMES = 3;

    /**
     * @param $token
     * @param $conversionTypes
     * @return bool 发送成功返回true，失败返回false
     */
    public function sendConvertData($token, $conversionTypes) {
        $reqData = array('token' => $token, 'conversionTypes' => $conversionTypes);
        $reqData = json_encode($reqData);
        // 发送完整的请求数据
        // do some log
       // print_r('req data: ' . $reqData . "\n");
        // 向百度发送数据
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, self::BAIDU_OCPC_URL);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $reqData);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                           'Content-Type: application/json; charset=utf-8',
                           'Content-Length: ' . strlen($reqData)
                       )
        );
        // 添加重试，重试次数为3
        for ($i = 0; $i < self::RETRY_TIMES; $i++) {
            $response = curl_exec($ch);
            $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            if ($httpCode === 200) {
                // 打印返回结果
                // do some log
                //print_r('retry times: ' . $i . ' res: ' . $response . "\n");
                $res = json_decode($response, true);
                // status为4，代表服务端异常，可添加重试
                $status = $res['header']['status'];
                if ($status !== 4) {
                    curl_close($ch);
                    //return $status === 0;
                    return $res;
                }
            }
        }
        curl_close($ch);
        return false;
    }
}
/*$token = '这里替换为您的token';
// 编辑一条转化数据
$cv = array(
    'logidUrl' => 'http://www.b123.com/12345?XX=XXX&bd_vid=1111', // 您的落地页url
    'newType' => 1 // 转化类型请按实际情况填写
);
// 此处仅为demo, conversionTypes支持添加更多数据
$conversionTypes = array($cv);
$demo = new APIDemo();
$demo->sendConvertData($token, $conversionTypes);*/

