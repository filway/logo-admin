<?php
namespace app\api\controller;
use app\common\controller\Api;

class baiduTransApi extends Api{
    // 无需登录的接口,*表示全部
    protected $noNeedLogin = "*";
    // 无需鉴权的接口,*表示全部
    protected $noNeedRight = "*";

    protected $CURL_TIMEOUT = 10;
    protected $URL = "http://api.fanyi.baidu.com/api/trans/vip/translate";
    protected $APP_ID = "20210622000869523";
    protected $SEC_KEY = "GFyYzl67ruC9l_FHrxEE";

    //翻译入口
    public function translate($query, $from='auto', $to='en')
    {
        $args = array(
            'q' => $query,
            'appid' => $this->APP_ID,
            'salt' => rand(10000,99999),
            'from' => $from,
            'to' => $to,

        );
        $args['sign'] = $this->buildSign($query, $this->APP_ID, $args['salt'], $this->SEC_KEY);
        $ret = $this->call($this->URL, $args);
        $ret = json_decode($ret, true);
        return $ret; 
    }

    //加密
    public function buildSign($query, $appID, $salt, $secKey)
    {
        $str = $appID . $query . $salt . $secKey;
        $ret = md5($str);
        return $ret;
    }

    //发起网络请求
    public function call($url, $args=null, $method="post", $testflag = 0, $timeout = 10, $headers=array())
    {
        $ret = false;
        $i = 0; 
        while($ret === false) 
        {
            if($i > 1)
                break;
            if($i > 0) 
            {
                sleep(1);
            }
            $ret = $this->callOnce($url, $args, $method, false, $timeout, $headers);
            $i++;
        }
        return $ret;
    }

    public function callOnce($url, $args=null, $method="post", $withCookie = false, $timeout = 10, $headers=array())
    {/*{{{*/
        $ch = curl_init();
        if($method == "post") 
        {
            $data = $this->convert($args);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
            curl_setopt($ch, CURLOPT_POST, 1);
        }
        else 
        {
            $data = $this->convert($args);
            if($data) 
            {
                if(stripos($url, "?") > 0) 
                {
                    $url .= "&$data";
                }
                else 
                {
                    $url .= "?$data";
                }
            }
        }
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        if(!empty($headers)) 
        {
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        }
        if($withCookie)
        {
            curl_setopt($ch, CURLOPT_COOKIEJAR, $_COOKIE);
        }
        $r = curl_exec($ch);
        curl_close($ch);
        return $r;
    }

    public function convert(&$args)
    {
        $data = '';
        if (is_array($args))
        {
            foreach ($args as $key=>$val)
            {
                if (is_array($val))
                {
                    foreach ($val as $k=>$v)
                    {
                        $data .= $key.'['.$k.']='.rawurlencode($v).'&';
                    }
                }
                else
                {
                    $data .="$key=".rawurlencode($val)."&";
                }
            }
            return trim($data, "&");
        }
        return $args;
    }


}

