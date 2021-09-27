<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use app\api\controller\BaiduTransApi as Bapi;
use app\aliyun\controller\Oss;
use addons\voicenotice\library\Voicenotice as voice;
/**
 * 会员管理
 *
 * @icon fa fa-user
 */
class Material extends Backend
{

    //protected $relationSearch = true;
    //protected $searchFields = 'id,username,nickname';

    /**
     * @var \app\admin\model\Order
     */
    protected $model = null;
    protected $relationSearch = true;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Material');
    }

    /**
     * 查看
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $list = $this->model
                ->with(['colorSystem','industry'])
                ->where($where)
                ->order($sort, $order)
                ->paginate($limit);
            //echo $this->model->getLastSql();
            $result = array("total" => $list->total(), "rows" => $list->items());

            return json($result);
        }
        else {
            return $this->view->fetch();
        }
    }

    public function selectdata() {
        return $this->view->fetch();
    }

    public function getColor()
    {
        $colorList = model('ColorSystem')->getList(1);
        $searchlist = [];
        foreach ($colorList as $key => $value) {
            $searchlist[] = ['id' => $value, 'name' => $value];
        }
        $data = ['searchlist' => $searchlist];
        $this->success('', null, $data);
    }
    public function getHy()
    {
        $hyList = model('Industry')->getList(1);
        $searchlist = [];
        foreach ($hyList as $key => $value) {
            $searchlist[] = ['id' => $value, 'name' => $value];
        }
        $data = ['searchlist' => $searchlist];
        $this->success('', null, $data);
    }

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $this->token();
            $params = $this->request->post();
            $file = $params['avatar'];
            $rgb = $this->getRbg(str_replace("/upload","upload",$file));
            $rgb = $rgb && is_string($rgb)?$rgb:'#333333';
            $path = str_replace("/upload","upload",pathinfo($file,PATHINFO_DIRNAME))."/";
            $filename = pathinfo($file, PATHINFO_BASENAME);
            $oss = new Oss();
            $ossPath = 'upload/material/';
            $oss->upload($path,$filename,$ossPath);
            $data = [
                'material_name'=>$params['material_name'],
                'color_system_id'=>$params['color_system_id'],
                'industry_id'=>$params['industry_id'],
                'typename'=>$params['typename'],
                'material_path'=>config('oss.host').$ossPath.$filename,
                'rgb'=>$rgb,
                'status'=>$params['status'],
            ];
            $res = model('Material')->insert($data);
            if($res) {
                $this->success('添加成功');
            }
            else {
                $this->error('添加失败');
            }
        }
        else {
            $hyList = model('Industry')->getList(1);
            $colorList = model('ColorSystem')->getList(1);
            $this->view->assign('colorList',$colorList);
            $this->view->assign('hyList',$hyList);
            return parent::add();
        }

    }

    /**
     * 编辑
     */
    public function edit($ids = null)
    {
        if ($this->request->isPost()) {
            $params = $this->request->post();
            $data = [
                'material_name'=>$params['material_name'],
                'color_system_id'=>$params['color_system_id'],
                'industry_id'=>$params['industry_id'],
                'typename'=>$params['typename'],
                'status'=>$params['status'],
            ];
            $res = model('Material')->where('material_id',$ids)->update($data);
            if($res) {
                $this->success('操作成功');
            }
            else {
                $this->error('操作失败');
            }
        }
        else {
            $hyList = model('Industry')->getList(1);
            $colorList = model('ColorSystem')->getList(1);
            $row = $this->model->where('material_id',$ids)->find();
            $this->view->assign('row',$row);
            $this->view->assign('colorList',$colorList);
            $this->view->assign('hyList',$hyList);
            return $this->view->fetch();
        }
    }

    public function getRbg($path) {
        $svgString = file_get_contents($path);
        $pattern = '/fill="(.*?)"/';
        preg_match($pattern,$svgString,$match);
        return $match[1];
    }

    public function paymusic(){
        $svgString = file_get_contents("https://logosvg.oss-cn-chengdu.aliyuncs.com/upload/material/f6dbf272afce5d28a5460ff795442282.svg");

        $pattern = '/fill="(.*?)"/';

        preg_match($pattern,$svgString,$match);

        var_dump( $match);
        echo $svgString;
        die;
        $ret = voice::addNotice("默认发送到所有管理员");
        var_dump($ret);
        die;
        if ($this->request->isPost()) {
            $filename ="Public/payfiles/music.mp3";
            $filesize=filesize($filename);
            header("Content-type:audio/mpeg");
            header("Content-length:$filesize");
            readfile($filename);
        }
        else {
            return $this->view->fetch();
        }
    }

}
