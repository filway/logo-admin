<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use app\api\controller\BaiduTransApi as Bapi;
use think\Db;
/**
 * 会员管理
 *
 * @icon fa fa-user
 */
class Order extends Backend
{

    //protected $relationSearch = true;
    //protected $searchFields = 'id,username,nickname';

    /**
     * @var \app\admin\model\Order
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Order');
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
            $result = array("total" => $list->total(), "rows" => $list->items());

            return json($result);
        }
        $this->assignconfig('industryList',$this->getIndustryList());
        return $this->view->fetch();
    }

    public function getIndustryList(){
        return model('Industry')->field('industry_name,industry_id')->select();
    }

    public function changeStatus($ids = '') {
        if ($this->request->isAjax()) {

            $row = $this->model->where('order_id',$ids)->find();
            if($row['ti_status'] == 1) {
                $this->error('已经查单过了');
            }
            $subrow = input('');
            if(isset($subrow['selecthy']) && $subrow['selecthy']) {
                $upData['hy'] = $subrow['selecthy'];
            }
            $material_ids = $this->match($row);
            $logoName = $row['logonameurl'];
            $logoNameEn = $row['logoname_en'];
            if(empty($logoNameEn)) {
                $tranApi = new Bapi();
                $transRes = $tranApi->translate($logoName);
                $logoNameEn = $transRes['trans_result'][0]['dst'];
                $upData['logoname_en'] = $logoNameEn;
            }
            $upData['ti_status'] = 1;
            $upData['is_jump'] = 0;
            $upData['show_time'] = date('Y-m-d H:i:s');
            $upData['material_ids'] = $material_ids;
            //var_dump($upData);die;
            $res = $this->model->where('order_id',$ids)->update($upData);
            if($res) {
                $this->success('查单成功');
            }
            else {
                $this->error('查单失败');
            }
        }
    }

    public function match($row) {
        $logoName = addslashes($row['logonameurl']);
        $hy = $row['hy'];
        $field = "material_id as materialId,material_name as materialName,file_name as fileName,material_path as materialPath,rgb";
        $limit = 4;
        $len = mb_strlen($logoName);
        $maxlen = $len+1;
        $str_repeat = str_repeat("%",$len);
        $orderStr = '(CASE ';
        for($i = 1;$i<=$len;$i++) {
            $orderStr.="WHEN UPPER(typename) LIKE BINARY CONCAT(
                '%',
                substring(
                CONCAT(
                '',
                UPPER(TRIM('{$logoName}')),
                '{$str_repeat}'
                ),
                {$i},
                1
                ),
                '%'
                ) THEN
                {$i} ";
        }
        $orderStr.="ELSE {$maxlen} END),RAND()";
        $industry_ids = model('Industry')->where('industry_name',$hy)->column('industry_id');
        $industry_ids = $industry_ids?$industry_ids:12;
        $list = model('Material')
            ->field($field)
            ->whereIn('industry_id',$industry_ids)
            ->where('status',0)
            ->orderRaw($orderStr)
            ->limit($limit)
            ->select();
        $materialArr = array_column($list, 'materialId');
        return $material_ids = implode(",",$materialArr);
    }

    public function changeStatus_bak($ids = '',$material_id='') {
        if ($this->request->isAjax()) {
            $row = $this->model->where('order_no',$ids)->find();
            if($row['ti_status'] == 1) {
                $this->error('已经查单过了');
            }
            $material_ids = $this->match($row,$material_id);
            $logoName = $row['logonameurl'];
            $logoNameEn = $row['logoname_en'];
            if(empty($logoNameEn)) {
                $tranApi = new Bapi();
                $transRes = $tranApi->translate($logoName);
                $logoNameEn = $transRes['trans_result'][0]['dst'];
                $upData['logoname_en'] = $logoNameEn;
            }
            $upData['ti_status'] = 1;
            $upData['is_jump'] = 0;
            $upData['show_time'] = date('Y-m-d H:i:s');
            $upData['material_ids'] = $material_ids;
            $res = $this->model->where('order_no',$ids)->update($upData);
            if($res) {
                $this->success('查单成功');
            }
            else {
                $this->error('查单失败');
            }
        }
    }

    public function match_bak($row,$material_id) {
        $logoName = $row['logonameurl'];
        $hy = $row['hy'];
        $field = "material_id as materialId,material_name as materialName,file_name as fileName,material_path as materialPath,rgb";
        $limit = 3;
        $len = mb_strlen($logoName);
        $maxlen = $len+1;
        $str_repeat = str_repeat("%",$len);
        $orderStr = '(CASE ';
        for($i = 1;$i<=$len;$i++) {
            $orderStr.="WHEN UPPER(typename) LIKE BINARY CONCAT(
                '%',
                substring(
                CONCAT(
                '',
                UPPER(TRIM('{$logoName}')),
                '{$str_repeat}'
                ),
                {$i},
                1
                ),
                '%'
                ) THEN
                {$i} ";
        }
        $orderStr.="ELSE {$maxlen} END),RAND()";
        $industry_ids = model('Industry')->where('industry_name',$hy)->column('industry_id');
        $industry_ids = $industry_ids?$industry_ids:12;
        $list = model('Material')
            ->field($field)
            ->whereIn('industry_id',$industry_ids)
            ->where('material_id','neq',$material_id)
            ->where('status',0)
            ->orderRaw($orderStr)
            ->limit($limit)
            ->select();
        $materialArr = array_column($list, 'materialId');
        array_unshift($materialArr,$material_id);
        $material_ids = implode(",",$materialArr);
        return $material_ids;
        //echo $orderStr;die;
    }
    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $this->token();
        }
        return parent::add();
    }

    /**
     * 编辑
     */
    public function edit($ids = null)
    {
        if ($this->request->isPost()) {
            $row = input();
            $row = $row['row'];
            $ids = input('ids');
            $logonameurl = $row['logonameurl'];
            $logonameurl_old = $row['logonameurl_old'];
            $updatedata['logonameurl'] = $logonameurl;
            if($logonameurl_old!=$logonameurl) {
                $api = new Bapi();
                $transRes = $api->translate($logonameurl);
                $logoname_en = $transRes['trans_result'][0]['dst'];
                $updatedata['logoname_en'] = $logoname_en;
            }
            else {
                $updatedata['logoname_en'] = $row['logoname_en'];
            }

            $res = $this->model->where('order_id',$ids)->update($updatedata);
            if($res) {
                $this->success('修改成功');
            }
            else {
                $this->error('修改失败');
            }
        }
        else {
            return parent::edit($ids);
        }
    }

    /**
     * 删除
     */
    public function del($ids = "")
    {
        if (!$this->request->isPost()) {
            $this->error(__("Invalid parameters"));
        }
        $ids = $ids ? $ids : $this->request->post("ids");
        $row = $this->model->get($ids);
        $this->modelValidate = true;
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        Auth::instance()->delete($row['id']);
        $this->success();
    }

}
