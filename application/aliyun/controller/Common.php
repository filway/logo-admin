<?php
/*
 * Aliyun API
 * 阿里云基础功能，基础配置
 * 2018-11-27
 * jungerpan@npn.sg
 */
namespace app\aliyun\controller;

import('aliyun/aliyun-php-sdk-core/Config', EXTEND_PATH, '.php');
class Common extends \RpcAcsRequest{
    protected $AliyunClientCls;
    protected $AliyunRequestCls;
    
    /**
     * 初始化
     * @param unknown $_version
     * @param unknown $_product
     * @param unknown $_actMethod
     * @param unknown $_regionId
     * @param unknown $_accessKeyId
     * @param unknown $_accessKeySecret
     * @param unknown $_requestMethod
     */
    public function __construct($_version,$_product,$_actMethod,$_regionId,$_accessKeyId,$_accessKeySecret,$_requestMethod){
        $iClientProfile = \DefaultProfile::getProfile($_regionId, $_accessKeyId, $_accessKeySecret);
        $this->AliyunClientCls = new \DefaultAcsClient($iClientProfile);
        parent::__construct($_product, $_version, $_actMethod);
        $this->setMethod($_requestMethod);
    }
    
}
