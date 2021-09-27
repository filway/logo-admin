<?php

namespace app\admin\model;
use think\Model;

class Material extends Model
{
    // 表名
    protected $table = 'material';

    public function colorSystem()
    {
        return $this->belongsTo('ColorSystem', 'color_system_id', 'color_system_id', [], 'LEFT')->setEagerlyType(0);
    }
    public function industry() {
        return $this->belongsTo('Industry', 'industry_id', 'industry_id', [], 'LEFT')->setEagerlyType(0);
    }
}
