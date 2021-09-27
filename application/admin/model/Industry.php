<?php

namespace app\admin\model;
use think\Model;

class Industry extends Model
{
    // 表名
    protected $table = 'industry';

    public function getList($type = 0) {
        if($type == 1) {
            return $this->column('industry_name','industry_id');
        }
        return $this->select();
    }

    public function getRow($id = null) {
        return $this->where('industry_id',$id)->find();
    }
}
