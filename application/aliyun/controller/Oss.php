<?php

/**

 * 阿里云对象存储 相关功能

 * User: zhouxiao

 * Date: 2019/2/12

 * Time: 14:20

 */

namespace app\aliyun\controller;



use OSS\OssClient;

use OSS\Core\OssException;

use think\Log;



class Oss

{

    public static $oss;     //oss客户端操作实例



    private $error = ''; //上传错误信息



    private $endPoint;

    private $accessKeyId;

    private $accessKeySecret;

    private $bucket;

    private $prefix;  //根目录



    public function __construct()
    {

        require_once "/www/wwwroot/logo.com/vendor/aliyuncs/autoload.php";

        //获取配置

        $this->accessKeyId = config('oss.accessKeyId');                 //获取阿里云oss的accessKeyId

        $this->accessKeySecret = config('oss.accessKeySecret');         //获取阿里云oss的accessKeySecret

        $this->endPoint = config('oss.endPoint');

        $this->bucket = config('oss.bucket');

//        Log::record("OSS","access key id: ".$this->accessKeyId);

        //获取阿里云oss的endPoint

        try{

            self::$oss = new OssClient($this->accessKeyId , $this->accessKeySecret, $this->endPoint);  //实例化OssClient对象

        }catch (OssException $e){

            Log::record("OSS",__FUNCTION__ . " creating OssClient instance: FAILED");

            $this->error($e->getMessage());

            exit(0);

        }

    }

    public function index() {

    }

    public function getBucketName()

    {

        return $this->bucket;

    }



    /**

     * 创建一个存储空间，如果发生异常直接exit

     */

    public function createBucket()

    {

        $ossClient = self::$oss;

        $bucket = input("bucket") ? input("bucket") : $this->getBucketName();

        $acl = OssClient::OSS_ACL_TYPE_PUBLIC_READ_WRITE; //公共读写

        Log::record("OSS","准备创建bucket ".$bucket);

        try {

            $ossClient->createBucket($bucket, $acl);

        } catch (OssException $e) {

            $message = $e->getMessage();

            if (\OSS\Core\OssUtil::startsWith($message, 'http status: 403')) {

                Log::record("OSS","Please Check your AccessKeyId and AccessKeySecret");

                $this->error("Please Check your AccessKeyId and AccessKeySecret");

                exit(0);

            } elseif (strpos($message, "BucketAlreadyExists") !== false) {

                Log::record("OSS","Bucket already exists. Please check whether the bucket belongs to you, or it was visited with correct endpoint.");

                $this->error("Bucket already exists. Please check whether the bucket belongs to you, or it was visited with correct endpoint.");

                exit(0);

            }

            Log::record("OSS",__FUNCTION__ . ": FAILED");

            $this->error($e->getMessage());

            exit(0);

        }

        Log::record("OSS",__FUNCTION__ . ": OK");

        $this->success(__FUNCTION__);

    }



    //文件上传


 public function upload($path,$filename,$_ossfilepath){

        $path = realpath($path).'/';
        Log::record("OSS","准备上传文件 ".$filename." 到临时目录 ".$path);

        $bucket = $this->bucket;

        $object = $_ossfilepath.$filename;


        //首先检测目录是否存在,bucket是否可写

        if(!$this->checkPath($_ossfilepath)){

            $this->error($this->error);

            exit();

        }


        //开始上传object

        try{

            $ret = self::$oss->uploadFile($bucket, $object, $path.$filename); //调用uploadFile方法上传到阿里云oss
            Log::record("oss upload status",$ret);

        }catch (OssException $e){

            $this->error($e->getMessage());

            unlink($path.$filename);

            exit();

        }

        Log::record("OSS","upload $object success");

        //删除临时文件

        unlink($path.$filename);

        return true;
        //$this->success(__FUNCTION__);

    }

    // public function upload(){



    //     $file = $_FILES;

    //     $filename = input("filename");

    //     Log::record("OSS","准备上传文件 ".$filename." 到临时目录 ".$path);

    //     if(move_uploaded_file($file["file"]["tmp_name"],$path.$filename)){

    //         $filepath = input("path");

    //         $bucket = $this->bucket;

    //         $object = $filepath.$filename;



    //         //首先检测目录是否存在,bucket是否可写

    //         if(!$this->checkPath($filepath)){

    //             $this->error($this->error);

    //             exit();

    //         }



    //         //开始上传object

    //         try{

    //             self::$oss->uploadFile($bucket, $object, $path.$filename); //调用uploadFile方法上传到阿里云oss

    //         }catch (OssException $e){

    //             $this->error($e->getMessage());

    //             unlink($path.$filename);

    //             exit();

    //         }

    //         Log::record("OSS","upload $object success");

    //         //删除临时文件

    //         unlink($path.$filename);

    //         $this->success(__FUNCTION__);

    //     }else{

    //         $this->error("上传文件 ".$filename." 到临时目录失败");

    //     }

    // }



    /**

     * 检测上传根目录,如果不可写,报错,如果不存在,自动创建

     * 注意:在阿里云oss里面其实不存在目录的概念,只不过为了方便与

     * 服务器上的目录相对应而加上了/属性来设置Object,因此这里的

     * 检测目录其实就是检测在oss里面是否存在该Object

     * @param string $path   目录

     * @return boolean true-检测通过，false-检测失败

     */

    public function checkPath($path){

        if(!($this->is_writable())){

            $this->error = "bucket不可写!";

            Log::record("OSS","bucket ".$this->bucket." 不可写");

            return false;

        }

        if(!($this->is_object($path))){

            //不存在该目录,自动创建

            //检测并创建目录,也就是创建一个带"/"属性的Object

            Log::record("OSS","开始自动创建目录 ".$path);

            return $this->mk_dir($path);

        }

        return true;

    }



    /**

     * 判断当前bucket是否可写

     * @return bool

     */

    public function is_writable(){

//        return self::$oss->getBucketAcl($this->bucket) == OssClient::OSS_ACL_TYPE_PUBLIC_READ_WRITE ? true : false;

        return true;

    }



    /** 判断object是否存在

     * @param $object

     * @return bool

     */

    public function is_object($object){

        try{

            return self::$oss->doesObjectExist($this->bucket,$object);

        }catch (OssException $e){

            $this->error = $e->getMessage();

            return false;

        }

    }





    /**

     * 阿里云OSS快速创建目录

     * @param $path

     * @return bool

     */

    private function mk_dir($path){

        //创建目录

        if(!empty($path)){

            try{

                //2019-02-18 由于createObjectDir函数会自动加上"/",所以这里如果有"/",必须将其去掉

                if(substr($path,-1,1) == "/"){

                    $path = substr($path,0,strrpos($path,"/"));

                }

                self::$oss->createObjectDir($this->bucket,$path);

            }catch (OssException $e){

                $this->error = $e->getMessage();

                return false;

            }

            return true;

        }

        $this->error = "path empty";

        return false;

    }



    /**

     * 递归创建目录

     */

    public function mkdirs(){

        $path = input("path");

        if($this->mk_dir($path)){

            $this->success(__FUNCTION__);

        }else{

            $this->error($this->error);

        }

    }





    /**

     * 删除object

     *

     */

    public function deleteObject()

    {

        $object = input("filename");

        $path = input("path");

        if($path){

            $object = $path.$object;

        }

//        //首选判断object 是否存在

//        if(!$this->doesObjectExist($object)){

//            $this->success("$object 不存在,无需删除");

//            exit();

//        }

        try {

            self::$oss->deleteObject($this->bucket, $object);

        } catch (OssException $e) {

            Log::record("OSS",__FUNCTION__ . ": FAILED");

            $this->error($e->getMessage());

            exit();

        }

        Log::record("OSS","delete object $object success");

        $this->success(__FUNCTION__);

    }



    /**

     * 批量删除object

     */

    function deleteObjects()

    {

        $objects = input("filenames");

        try {

            self::$oss->deleteObjects($this->bucket, $objects);

        } catch (OssException $e) {

            Log::record("OSS",__FUNCTION__ . ": FAILED");

            $this->error($e->getMessage());

            return;

        }

        $this->success(__FUNCTION__);

    }



    /**

     * 判断object是否存在

     *

     * @param OssClient $ossClient OssClient实例

     * @param string $bucket 存储空间名称

     * @return null

     */

    private function doesObjectExist($object)

    {

        try {

            $exist = self::$oss->doesObjectExist($this->bucket, $object);

        } catch (OssException $e) {

            Log::record("OSS",__FUNCTION__ . ": FAILED");

            Log::record("OSS",$e->getMessage());

            $this->error($e->getMessage());

            exit(); //有问题,终止

        }

        return $exist;

    }



    /**

     * 检测文件是否存在

     */

    public function checkFileExist(){

        $path = input("path");

        $filename = input("filename");

        $object = $path.$filename;

        Log::record("OSS","检测文件是否存在 ".$object);



        if(!$this->doesObjectExist($object)){

            Log::record("OSS","文件不存在");

            $this->error("文件不存在");

        }

        $this->success(__FUNCTION__);

    }





    /**

     * 查看目录文件列表

     */

    public function showDirectoryFileList(){

        $prefix = input("path");

        $response = array(

            "status"=>0,

            "message"=>"操作成功",

            "files"=>$this->get_allfiles($prefix)

        );

        echo json_encode($response);

    }



    /**

     * 递归列出Bucket内所有目录和文件， 根据返回的nextMarker循环得到所有Objects

     * @param string $prefix

     * @param array $files

     * @param bool $return_dir 是否返回目录 true: 需要返回目录 false:只返回文件

     * @return array

     */

    private function listAllObjects($prefix='upload/',$return_dir=true,&$files=[])

    {

        $ossClient = self::$oss;

        $bucket = $this->bucket;



        $delimiter = '/';

        $nextMarker = '';

        $maxkeys = 30;



            while (true) {

                $options = array(

                    'delimiter' => $delimiter,

                    'prefix' => $prefix,

                    'max-keys' => $maxkeys,

                    'marker' => $nextMarker,

                );

                Log::record("OSS",json_encode($options));

                try {

                    $listObjectInfo = $ossClient->listObjects($bucket, $options);

                } catch (OssException $e) {

                    Log::record("OSS",__FUNCTION__ . ": FAILED");

                    $this->error($e->getMessage()); //出错

                    exit();

                }

                // 得到nextMarker，从上一次listObjects读到的最后一个文件的下一个文件开始继续获取文件列表

                $nextMarker = $listObjectInfo->getNextMarker();

                $listObject = $listObjectInfo->getObjectList(); //文件

                $listPrefix = $listObjectInfo->getPrefixList(); //目录 "/"

                foreach ($listObject as $item){

                    if($return_dir){

                        $files[] =  [

                            'name'      => $item->getKey(),

                            'size'      => $item->getSize(),

                            'update_at' => $item->getLastModified(),

                        ];

                    }else{

                        //不返回目录,需要加以判断,排除目录的情况

                        if($item->getSize() > 0){

                            $files[] =  [

                                'name'      => $item->getKey(),

                                'size'      => $item->getSize(),

                                'update_at' => $item->getLastModified(),

                            ];

                        }

                    }

                }

                foreach ($listPrefix as $item){

                    $this->listAllObjects($item->getPrefix(),$files);

                }

                if ($nextMarker === '') {

                    break;

                }

            }

        return $files;

    }





    private function get_allfiles($prefix='upload/',&$files=[]){

        $ossClient = self::$oss;

        $bucket = $this->bucket;



        $delimiter = '/';

        $nextMarker = '';

        $maxkeys = 100;



        while (true) {

            $options = array(

                'delimiter' => $delimiter,

                'prefix' => $prefix,

                'max-keys' => $maxkeys,

                'marker' => $nextMarker,

            );

            Log::record("OSS",json_encode($options));

            try {

                $listObjectInfo = $ossClient->listObjects($bucket, $options);

            } catch (OssException $e) {

                Log::record("OSS",__FUNCTION__ . ": FAILED");

                $this->error($e->getMessage()); //出错

                exit();

            }

            // 得到nextMarker，从上一次listObjects读到的最后一个文件的下一个文件开始继续获取文件列表

            $nextMarker = $listObjectInfo->getNextMarker();

            $listObject = $listObjectInfo->getObjectList(); //文件

            $listPrefix = $listObjectInfo->getPrefixList(); //目录 "/"

            $dir = substr($prefix,strripos($prefix,"/"));

            $filesList["text"] = $dir;

            $filesList["state"] = "closed";

            foreach ($listObject as $item){

                if($item->getSize() > 0){

                    $fullpath = $item->getKey();

                    $tmp["text"] = substr($fullpath,strripos($fullpath,"/") + 1);

                    $tmp["fullpath"] = $fullpath;

                    $tmp["time"] = $item->getLastModified();

                    $filesList["children"][] = $tmp;

                }

            }

            foreach ($listPrefix as $item){

                $this->get_allfiles($item->getPrefix(),$filesList);

            }

            if ($nextMarker === '') {

                break;

            }

        }

        return $filesList;

    }





    /**

     * 返回目录下面的一级文件

     */

    public function scandir(){

        $ossClient = self::$oss;

        $bucket = $this->bucket;



        $delimiter = '/';

        $nextMarker = '';

        $maxkeys = 1000;

        $prefix = input("path");  //需要查看的目录



        $files = array();

        while (true) {

            $options = array(

                'delimiter' => $delimiter,

                'prefix' => $prefix,

                'max-keys' => $maxkeys,

                'marker' => $nextMarker,

            );

            try {

                $listObjectInfo = $ossClient->listObjects($bucket, $options);

            } catch (OssException $e) {

                Log::record("OSS",__FUNCTION__ . ": FAILED");

                $this->error($e->getMessage()); //出错

                exit();

            }

            // 得到nextMarker，从上一次listObjects读到的最后一个文件的下一个文件开始继续获取文件列表

            $nextMarker = $listObjectInfo->getNextMarker();

            $listObject = $listObjectInfo->getObjectList(); //文件

            $listPrefix = $listObjectInfo->getPrefixList(); //目录 "/"

            foreach ($listObject as $item){

                $tmp_name = $item->getKey();

                $tmp_name = substr($tmp_name,strrpos($tmp_name,"/") + 1);

                if($tmp_name){

                    $etag = $item->getETag();

                    $time = $item->getLastModified();

                    $size = $item->getSize();

                    $etag = str_replace('"','',$etag);

                    $files[] =  ["name"=>$tmp_name,"etag"=>strtolower($etag),"update_at"=>$time,'size'=>$size];

                }

            }

            if ($nextMarker === '') {

                break;

            }

        }

        Log::record("OSS",__FUNCTION__ . "OK");

        echo json_encode(array("status"=>0,"message"=>"操作成功","files"=>$files));

    }





    /**

     * 拷贝object

     * 当目的object和源object完全相同时，表示修改object的meta信息

     *

     */

    public function copyFile()

    {

        $source = input("source");

        $target = input("target");



        if($this->is_dir($source)){

            //copy文件夹

            if(!$target){

                //如果没有target,代表没有重命名的打算,copy以后保持原来的命名

                $tmp_arr = explode("/",$source);

                $target = $tmp_arr[count($tmp_arr) - 2]."/";

            }

            $dir_list = [];

            $dir_list = $this->listAllObjects($source,true,$dir_list);

            foreach ($dir_list as $v){

                $filename = substr($v["name"],strripos($v["name"],"/") + 1);

                $this->copyObject($v["name"],$target.$filename);

            }

        }else{

            //copy文件

            if(!$target){

                //如果没有target,代表没有重命名的打算,copy以后保持原来的命名

                $target = substr($source,strripos($source,"/")+1);

            }

           $this->copyObject($source,$target);

        }

        $this->success(__FUNCTION__);

    }



    /**

     * 拷贝object

     * @param OssClient $ossClient OssClient实例

     * @param string $bucket 存储空间名称

     */

    private function copyObject($source,$target)

    {

        $options = array();



        try {

            self::$oss->copyObject($this->bucket, $source, $this->bucket, $target, $options);

        } catch (OssException $e) {

            Log::record("OSS",__FUNCTION__ . ": FAILED");

            Log::record("OSS",$e->getMessage());

            $this->error("复制文件 $source 到 $target 失败");

            exit();

        }

        Log::record("OSS",__FUNCTION__ . ": OK $source --> $target");

    }



    /**

     * 由于OSS没有文件夹的概念,所以通过判断content-length来确定是否有文件

     * @param string $object

     */

    public function is_dir($object=""){

        try{

            $info = self::$oss->getObjectMeta($this->bucket,$object);

        }catch (OssException $e){

            Log::record("OSS",__FUNCTION__ . ": get object meta failed");

            $this->error("get object meta failed");

            exit();  //出错

        }

        if($info["content-length"] == 0 && substr($object,-1,1) == "/"){

            //文件夹

            return true;

        }else{

            //文件

            return false;

        }

    }



    /**

     * 把本地变量的内容到文件

     * 简单上传,上传指定变量的内存值作为object的内容

     *

     */

    public function putObject()

    {

        $ossClient = self::$oss;

        $bucket = $this->bucket;

        $object = input("path");       //object名

        $content = input("content");  //需要写入的内容

        $options = array();

        try {

            $result = $ossClient->putObject($bucket, $object, $content, $options);

        } catch (OssException $e) {

            Log::record("OSS",__FUNCTION__ . ": FAILED");

            $this->error($e->getMessage());

            exit();

        }

        Log::record("OSS",__FUNCTION__ . ": OK" );

        Log::record("OSS","$object is created");

        Log::record("OSS",$result['x-oss-request-id']);

        Log::record("OSS",$result['etag']);

        Log::record("OSS",$result['content-md5']);

        Log::record("OSS",$result['body']);

        $this->success(__FUNCTION__);

    }





    //得到上传后的图片路径

    public function getUrl($object)

    {

        $url = 'http://'.$this->bucket.'.'.$this->endPoint.'/'.$object;

        return $url;

    }



    /**

     * 成功

     */

    private function success($action){

        $msg = $action." 操作成功";

        Log::record("OSS",$msg);

        $response = array(

            "status"=>0,

            "message"=>$msg

        );

        echo json_encode($response);

    }



    /**

     * 报错

     */

    private function error($msg){

        Log::record("OSS",$msg);

        $response = array(

            "status"=>1,

            "message"=>$msg

        );

        echo json_encode($response);

    }



}