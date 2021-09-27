<?php
namespace app\common\model;

use think\Model;

class Order extends Model
{
	protected $table = 'order';
	 /**
     * [getorder description]
     * @Author   pb
     * @DateTime 2021-07-03T12:09:38+0800
     * @param    string                   $sn [description]
     * @return   [type]                       [description]
     */
    public function getorder($sn ='') {
        return $this->where('order_no',$sn)->find();
    }

    
    /**
     * [addOrder description]
     * @Author   pb
     * @DateTime 2021-07-03T12:12:46+0800
     * @param    [type]                   $data [description]
     */
    public function addOrder($data) {
        return $this->insert($data,'',true);
    }

    /**
     * [updateOrder description]
     * @Author   pb
     * @DateTime 2021-07-03T12:49:56+0800
     * @param    [type]                   $map  [description]
     * @param    [type]                   $data [description]
     * @return   [type]                         [description]
     */
    public function updateOrder($map,$data) {
    	return $this->where($map)->update($data);
    }
}