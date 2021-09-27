<?php
namespace app\api\controller;
use app\common\controller\Api;
use think\Db;

class Noticeapi extends Api{
    // 无需登录的接口,*表示全部
    protected $noNeedLogin = "*";
    // 无需鉴权的接口,*表示全部
    protected $noNeedRight = "*";
    
    public function addNotice($text='',$url='') {
        $adminList = db('admin')->where('status','normal')->column('id');
        $allData = [];
        foreach ($adminList as $v) {
            $allData[] = ["aid" => $v, "createtime" => time(), "text" => $text, "state" => 0, "loop" => 1, "url_type" => 'open', "url" => $url];
        }
        return db('voicenotice_que')->insertAll($allData);
    }
}

