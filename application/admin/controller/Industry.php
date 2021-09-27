<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use app\aliyun\controller\Oss;
/**
 * 会员管理
 *
 * @icon fa fa-user
 */
class Industry extends Backend
{

    //protected $relationSearch = true;
    //protected $searchFields = 'id,username,nickname';

    /**
     * @var \app\admin\model\Order
     */
    protected $model = null;
    //protected $relationSearch = true;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Industry');
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

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $this->token();
            $params = $this->request->post();
            $file = $params['industry_path'];
            $path = str_replace("/upload","upload",pathinfo($file,PATHINFO_DIRNAME))."/";
            $filename = pathinfo($file, PATHINFO_BASENAME);
            $file1 = $params['industry_path1'];
            $path1 = str_replace("/upload","upload",pathinfo($file1,PATHINFO_DIRNAME))."/";
            $filename1 = pathinfo($file1, PATHINFO_BASENAME);

            $oss = new Oss();
            $ossPath = 'upload/material/';
            $oss->upload($path,$filename,$ossPath);
            $oss->upload($path1,$filename1,$ossPath);
            $data = [
                'industry_name'=>$params['industry_name'],
                'industry_info'=>$params['industry_info'],
                'industry_path'=>config('oss.host').$ossPath.$filename,
                'file_name'=>$filename,
                'industry_path1'=>config('oss.host').$ossPath.$filename1,
                'file_name1'=>$filename1,
            ];
            $res = $this->model->insert($data);
            if($res) {
                $this->success('添加成功');
            }
            else {
                $this->error('添加失败');
            }
        }
        else {
            return parent::add();
        }
    }
}
