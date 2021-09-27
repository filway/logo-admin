<?php

namespace app\admin\model;
use think\Model;

class ColorSystem extends Model
{
    // 表名
    protected $table = 'color_system';

    public function getList($type = 0) {
        if($type == 1) {
            return $this->column('name','color_system_id');
        }
        return $this->select();
    }

    public function getRow($id = null) {
        return $this->where('industry_id',$id)->find();
    }
}
