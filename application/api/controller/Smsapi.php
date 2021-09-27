<?php
namespace app\api\controller;
use app\common\controller\Api;
use app\common\model\User;
use think\Hook;

class Smsapi extends Api{
	// 无需登录的接口,*表示全部
    protected $noNeedLogin = "*";
    // 无需鉴权的接口,*表示全部
    protected $noNeedRight = "*";
    
    public function sendsms($_phone,$content) {
    	$post_data['userid'] = 6594;
		$post_data['account'] = '18215555204';
		$post_data['password'] = 'jfw5200820';
		$post_data['content'] = $content;
		//多个手机号码用英文半角豆号‘,’分隔
		$post_data['mobile'] = $_phone;
		$url='http://sms.kingtto.com:9999/sms.aspx?action=send';
		$o='';
		foreach ($post_data as $k=>$v)
		{
			//短信内容需要用urlencode编码，否则可能收到乱码
			$o.="$k=".urlencode($v).'&'; 
		}
		$post_data=substr($o,0,-1);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_URL,$url);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //如果需要将结果直接返回到变量里，那加上这句。
		$xmlfile = curl_exec($ch);
		$ob= simplexml_load_string($xmlfile);//将字符串转化为变量
		$json = json_encode($ob);//将对象转化为JSON格式的字符串
		$configData = json_decode($json, true);//将JSON格式的字符串转化为数组
		return $configData;
    }


    
	 /**
     * 模拟post进行url请求
     * @param string $url
     * @param string $param
     */
    protected function http_post_json($url, $jsonstr)
    {
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_POST, 1);
      curl_setopt($ch, CURLOPT_URL, $url);
      curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonstr);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_HTTPHEADER, array(
          'Content-Type: application/json; charset=utf-8',
          'Content-Length: ' . strlen($jsonstr)
        )
      );
      $response = curl_exec($ch);
      $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
      return array($httpCode, $response);
    }

    protected function curl_post($url , $data=array()){
	    $ch = curl_init();

	    curl_setopt($ch, CURLOPT_URL, $url);

	    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

	    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

	    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

	    // POST数据

	    curl_setopt($ch, CURLOPT_POST, 1);

	    // 把post的变量加上

	    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

	    $output = curl_exec($ch);

	    curl_close($ch);

	    return $output;
	}
}

