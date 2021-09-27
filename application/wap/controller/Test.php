<?php
namespace app\wap\controller;
use app\wap\controller\Base;
use think\Db;
use app\api\controller\BaiduTransApi as Bapi;
use think\Cookie;
use app\common\library\Stat;
use app\aliyun\controller\Oss;
class Test extends Base
{
	public function index() {
		return $this->fetch();
	}


    /* base64格式编码转换为图片并保存对应文件夹 */
    public function base64_image_content(){

      $path = 'temp/';
      $file_name = "test.svg";
      $base64_image_content = input('imageBase64');
	  //匹配出图片的格式
      if (preg_match('/^(data:\s*image\/(\w+);base64,)/', $base64_image_content, $result)){
         if(!file_exists($path)){
            echo 333;
	      // 路径不存在
            return false;
        }
        echo $new_file = $path . $file_name;
        if (file_put_contents($new_file, base64_decode(str_replace($result[1], '', $base64_image_content)))){
            return '/'.$new_file;
        }else{
            echo 222;
            return false;
        }
      } else {
          echo 111;
          return false;
      }
    }

public function downsvg() {
        $path = 'temp/download/';
        $file_name = uniqid();
        $extArr =  ['png','jpg'];
        $base64_image_content = $this->request->post("base64");
        $svg = $this->request->post("svg");
      //匹配出图片的格式
        if (preg_match('/^(data:\s*image\/(\w+);base64,)/', $base64_image_content, $result)){
            if(!file_exists($path)){
                // 路径不存在
                echo 111;
                return false;
            }
            $returnUrl = [];
            foreach ($extArr as $ext) {
                $new_file = $path . $file_name.'.'.$ext;
                
                if (file_put_contents($new_file, base64_decode(str_replace($result[1], '', $base64_image_content)))){
                    $returnUrl[$ext] = request()->domain().'/'.$new_file;
                }else{
                    echo 222;
                    return false;
                }
                $oss = new Oss();
                $oss->upload($path,$file_name.'.'.$ext,'upload/svg/');
            }
        }else{
            echo 333;
            return false;
        }
        $new_file = $path . $file_name.'.svg';
        file_put_contents($new_file,$svg);
        $returnUrl['svg'] = request()->domain().'/'.$new_file;
        return json(['code'=>0,'data'=>$returnUrl]);
}



    /*public function base64_image_content(){

    $path = 'temp/';
    $file_name = mt_rand(100000,999999);
    $extArr =  ['png','jpg','svg'];
    $base64_image_content = input('imageBase64');
      //匹配出图片的格式
        if (preg_match('/^(data:\s*image\/(\w+);base64,)/', $base64_image_content, $result)){
            if(!file_exists($path)){
                echo 333;
          // 路径不存在
                return false;
            }
            $returnUrl = [];
            foreach ($extArr as $ext) {
                $new_file = $path . $file_name.'.'.$ext;
                if (file_put_contents($new_file, base64_decode(str_replace($result[1], '', $base64_image_content)))){
                    $returnUrl[$ext] = request()->domain().'/'.$new_file;
                }else{
                    echo 222;
                    return false;
                }
            }
            return json($returnUrl);
        }else{
            echo 111;
            return false;
        }
    }*/

    public function test() {
          $order_no = $this->request->param("sn");
            //$order_no = 'E710280601292507';
          $cacheTime = 300;
          $row = model('order')->where('order_no',$order_no)->cache($cacheTime)->find();
          if(empty($row)) {
            return json(['code'=>0,'data'=>[]]);
        }
        $logoName = $row['logonameurl'];
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
        $orderStr.="ELSE {$maxlen} END)";
            //echo $orderStr;die;
        $hy = $row['hy'];
        $logoNameEn = $row['logoname_en'];
        $industry_ids = Db::table('industry')->where('industry_name',$hy)->cache($cacheTime)->column('industry_id');
        $industry_ids = $industry_ids?$industry_ids:12;
        $list = Db::table('material')
        ->field('material_id as materialId,material_name as materialName,file_name as fileName,material_path as materialPath,rgb')
        ->whereIn('industry_id',$industry_ids)
        ->orderRaw($orderStr)
        ->cache($cacheTime)
        ->limit(10)
        ->select();
            //echo Db::table('material')->getLastsql();
        foreach ($list as $k =>&$v) {
            $v['name'] = $logoName;
            $v['name_en'] = $row['logoname_en'];
        }
        return json(['code'=>0,'data'=>$list]);
    }

    public function to_base64() {
        $file_path = "Public/logofiles/case78.png";
        $file = "http://sjossdemo.oss-cn-beijing.aliyuncs.com/logo3/R 最后(5).svg";
        $file_path = "temp/123.svg";
        echo file_put_contents($file_path,file_get_contents($file));
        if($fp = fopen($file_path,"rb", 0))
        {
            $gambar = fread($fp,filesize($file));
            fclose($fp);
            $base64 = chunk_split(base64_encode($gambar));
            // 输出
            $encode = '<img src="data:image/jpg/png/gif;base64,' . $base64 .'" >';
            // $encode = file_get_contents($file);
            // echo $encode;
        }    
    }

    public function ts() {
        return $this->fetch();
    }

    public function mergeimg() {
        return $this->fetch();
    }

    public function mergeimg_online() {
         return $this->fetch();
    }

    public function phpimg() {
        //echo phpinfo();die;
        // 图片一 url地址或者相对地址
        $path_1 = 'Public/logofiles/images/show1.png';
        // 图片二  url地址或者相对地址
        $path_2 = 'temp/dwonload/112233.png';
        //$path_2 = 'Public/logofiles/images/1.png';


//        $as = getimagesize($path_2);
//        var_dump($as);
//        $image_1 = imagecreatefrompng($path_1);
//        $image_2 = imagecreatefrompng($path_2);

        $image_1 = imagecreatefromstring(file_get_contents($path_1));
        $image_2 = imagecreatefromstring(file_get_contents($path_2));

        var_dump($image_2);

        /*$left = intval((imagesx($image_1) - imagesx($image_2)) / 2);
        $top  = intval((imagesy($image_1) - imagesy($image_2)) / 2);*/

        $logo_width = imagesx($image_2);
        $logo_height = imagesy($image_2);

        $logo_width = $logo_width?$logo_width:100;
        $logo_height = $logo_height?$logo_height:100;
        var_dump($logo_width,$logo_height);
        $dst_w = 500;
        $dst_h = intval($dst_w* $logo_width / $logo_height);
        $dst_h = $dst_h?$dst_h:100;

        $imgpath = 'temp/phpimg'.mt_rand(1000,9999).'.png';
        $imgpath = $this->createPoster($path_1,$path_2,200,150,100,100,$logo_width,$logo_height,$imgpath);

        echo '<img src=/'.$imgpath.' />';
    }

    /**
     * 将两张图片合成一张
     * $bg_path    背景图地址
     * $poster     图片2
     * $x           图片2在背景图片上位置的左边距,单位：px （例：436）
     * $y           图片2在背景图片上位置的上边距,单位：px （例：1009）
     * $dst_w：设定载入的原图的宽度（在此设置缩放）
     * $dst_h：设定载入的原图的高度（在此设置缩放）
     * $poster_w	图片2宽度,单位：px （例：200）
     * $poster_y		图片2高度,单位：px （例：300）
     * $echo_path   生成的新图片存放路径
     **/
    public function createPoster($bg_path, $poster, $x, $y, $dst_w,$dst_h,$poster_w, $poster_y, $echo_path, $is_base64 = 0){
        $background = imagecreatefromstring(file_get_contents($bg_path));
        $poster_res = imagecreatefromstring(file_get_contents($poster));
        //参数内容:目标图象连接资源，源图象连接资源，目标X坐标点，目标Y坐标点，源的X坐标点，源的Y坐标点，目标宽度，目标高度，源图象的宽度，源图象的高度
        imagecopyresampled($background, $poster_res, $x, $y, 0, 0, $dst_w, $dst_h, $poster_w, $poster_y);
        //输出到本地文件夹，返回生成图片的路径
        if(!is_dir(dirname($echo_path))){
            mkdir(dirname($echo_path), 0755, true);
            chown(dirname($echo_path), 'nobody');
            chgrp(dirname($echo_path), 'nobody');
        }

        if($is_base64){
            ob_start ();
            //imagepng展示出图片
            imagepng ($background);
            $imageData = ob_get_contents ();
            ob_end_clean ();
            //得到这个结果，可以直接用于前端的img标签显示
            $res = "data:image/jpeg;base64,". base64_encode ($imageData);
        }else{
            imagepng($background,$echo_path);
            $res = $echo_path;
        }
        imagedestroy($background);
        imagedestroy($poster_res);
        return $res;
    }

    //根据房间名称  确认x坐标
    public function getRNameWidth($roomname){
        header("Content-type: text/html; charset=utf-8");

        preg_match_all("/[0-9]{1}/",$roomname,$arrNum);//数字
        preg_match_all("/[a-zA-Z]{1}/",$roomname,$arrAl);//字母
        preg_match_all("/([\x{4e00}-\x{9fa5}]){1}/u",$roomname,$arrCh);//汉字

        $numlen = sizeof($arrNum[0]);
        $allen = sizeof($arrAl[0]);
        $chlen = sizeof($arrCh[0]);

        $rnamewidth = ($numlen+$allen)*20+$chlen*36;

        $x = (abs(470-$rnamewidth))/2;

        return $x;
    }

    public  function  phpimg2() {
        $im = imageCreateTrueColor(200, 200);      	//建立空白背景
        $white = imageColorAllocate ($im, 255, 255, 255);	//设置绘图颜色
        $blue  = imageColorAllocate ($im, 0, 0, 64);
        //2. 开始绘画
        imageFill($im, 0, 0, $blue);                    		//绘制背景
        imageLine($im, 0, 0, 200, 200, $white);        	//画线
        imageString($im, 4, 50, 150, 'Sales', $white);  	//添加字串
        //3. 输出图像
        header('Content-type: image/png');
        $imgpath = 'temp/phpimg.png';
        imagePng ($im,$imgpath);     //以 PNG 格式将图像输出
        //4. 释放资源
        imageDestroy($im);
        echo '<img src=/'.$imgpath.' />';
    }

    public function  svgimg() {
        $svg = '<svg baseProfile="full" version="1.1" class="svg0" viewBox="0 0 686 448" xmlns="http://www.w3.org/2000/svg" data-v-7ef494b2="" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.dev/svgjs"><svg><g fill="dodgerblue" transform="matrix(1,0,0,1,135,175.39) " class="svg-logo0"><image width="110" height="110" xlink:href="data:image/svg+xml;base64,PHN2ZyBpZD0i5Zu+5bGCXzEiIGRhdGEtbmFtZT0i5Zu+5bGCIDEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHZpZXdCb3g9IjAgMCAzOC41NCAzNS41MSI+PGRlZnM+PHN0eWxlPi5jbHMtMXtmaWxsOnVybCgjbGluZWFyLWdyYWRpZW50KTt9LmNscy0ye2ZpbGw6dXJsKCNsaW5lYXItZ3JhZGllbnQtMik7fS5jbHMtM3tmaWxsOnVybCgjbGluZWFyLWdyYWRpZW50LTMpO308L3N0eWxlPjxsaW5lYXJHcmFkaWVudCBpZD0ibGluZWFyLWdyYWRpZW50IiB4MT0iMjE1LjgxIiB5MT0iMzk1LjI3IiB4Mj0iMjE1LjgxIiB5Mj0iMzcwLjE3IiBncmFkaWVudFRyYW5zZm9ybT0idHJhbnNsYXRlKC0xMjIgODguMjcpIHJvdGF0ZSgtMTcuNzYpIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHN0b3Agb2Zmc2V0PSIwLjI1IiBzdG9wLWNvbG9yPSIjMzJhMmQzIi8+PHN0b3Agb2Zmc2V0PSIwLjYxIiBzdG9wLWNvbG9yPSIjODhiZTQzIi8+PC9saW5lYXJHcmFkaWVudD48bGluZWFyR3JhZGllbnQgaWQ9ImxpbmVhci1ncmFkaWVudC0yIiB4MT0iMjU3LjU1IiB5MT0iNDYzLjU3IiB4Mj0iMjU3LjU1IiB5Mj0iNDM4LjQ3IiBncmFkaWVudFRyYW5zZm9ybT0idHJhbnNsYXRlKDEwMC40OCA5MDcuMjMpIHJvdGF0ZSgtMTM3Ljg2KSIgeGxpbms6aHJlZj0iI2xpbmVhci1ncmFkaWVudCIvPjxsaW5lYXJHcmFkaWVudCBpZD0ibGluZWFyLWdyYWRpZW50LTMiIHgxPSIxNzYuOTIiIHkxPSI0NjUuNjUiIHgyPSIxNzYuOTIiIHkyPSI0NDAuNTUiIGdyYWRpZW50VHJhbnNmb3JtPSJ0cmFuc2xhdGUoNjk3LjUzIDMwNC42Nykgcm90YXRlKDEwMi4wNSkiIHhsaW5rOmhyZWY9IiNsaW5lYXItZ3JhZGllbnQiLz48L2RlZnM+PHRpdGxlPmJ2Yy0xMjwvdGl0bGU+PHBhdGggY2xhc3M9ImNscy0xIiBkPSJNMjEzLjE3LDM4OGMuNjItMiwuMzMtMy41Ni0uMzItNC4wN2EzLDMsMCwwLDAtMi4zNS0uNTIsOC4wOSw4LjA5LDAsMCwwLTIsLjQ5LDI5LDI5LDAsMCwwLTYuOCwzLjlsLS4zNC4yOGMuNDctMS43My44Ni0zLjQsMS4yLTQuOTEuNzQtMy4zNywxLjIyLTYuMSwxLjUzLThzLjQ1LTIuODguNDUtMi44OC0uMTgsMS0uNSwyLjg1LS44Niw0LjU0LTEuNjYsNy44NmMtLjQsMS42NC0uODYsMy40Ni0xLjQyLDUuMzhhNTIsNTIsMCwwLDAtNS4wNiw0LjM5LDIzLjM1LDIzLjM1LDAsMCwwLTQuNjgsNi4wNSw0LjQ1LDQuNDUsMCwwLDAtLjM0LDEuMSwyLjQsMi40LDAsMCwwLDAsLjgsMS41MywxLjUzLDAsMCwwLC40My44NiwyLjMzLDIuMzMsMCwwLDAsMS44NS41NSwzLjkyLDMuOTIsMCwwLDAsMi44MS0xLjQ5LDIwLjE2LDIwLjE2LDAsMCwwLDMuMjUtNS44OWMuNjMtMS42NiwxLjE1LTMuMjksMS42MS00Ljg4LjQ2LS4zNC44OS0uNzEsMS4zNi0xYTI4LjE2LDI4LjE2LDAsMCwxLDYuNzEtMy43LDguMTcsOC4xNywwLDAsMSwxLjg3LS40MywyLjY2LDIuNjYsMCwwLDEsMS44Mi4zNiwyLjIzLDIuMjMsMCwwLDEsLjY0LDJjMCwuMywwLC42MS0uMDkuOTJtLTE0LjI3LDYuNDFhMTkuMTcsMTkuMTcsMCwwLDEtMy4yOCw1LjYyLDMuNjcsMy42NywwLDAsMS0yLjU4LDEuMzEsMi4xLDIuMSwwLDAsMS0xLjQ2LS4zN2MtLjI0LS4xNS0uMDctMSwuMTktMS41MmEyMi45MSwyMi45MSwwLDAsMSw0LjY0LTUuNzcsNTIuMyw1Mi4zLDAsMCwxLDQtMy40MUMyMDAsMzkxLjY3LDE5OS40NywzOTMuMDUsMTk4LjksMzk0LjQ1WiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE5MC44NyAtMzY4LjA0KSIvPjxwYXRoIGNsYXNzPSJjbHMtMiIgZD0iTTIwNi42MywzODguMjNjLTIuMDYuNDgtMy4yNCwxLjUtMy4zNiwyLjMyYTMuMDUsMy4wNSwwLDAsMCwuNzMsMi4zLDguODgsOC44OCwwLDAsMCwxLjQxLDEuNDYsMjksMjksMCwwLDAsNi43OSwzLjkybC40MS4xNmMtMS43My40Ny0zLjM3LDEtNC44NSwxLjQyLTMuMjksMS4wNi01Ljg5LDItNy42NiwyLjY4bC0yLjcyLDEuMDYsMi43Mi0xYzEuNzYtLjYzLDQuMzYtMS41Myw3LjYzLTIuNTEsMS42Mi0uNDcsMy40Mi0xLDUuMzYtMS40NmE1My4zNiw1My4zNiwwLDAsMCw2LjM0LDIuMTgsMjMuMzYsMjMuMzYsMCwwLDAsNy41OCwxLDQsNCwwLDAsMCwxLjEzLS4yNiwyLjI2LDIuMjYsMCwwLDAsLjY4LS40LDEuODQsMS44NCwwLDAsMCwuNTQtLjgsMi40MSwyLjQxLDAsMCwwLS40Ni0xLjg5LDMuOTMsMy45MywwLDAsMC0yLjctMS42OCwyMC4yNCwyMC4yNCwwLDAsMC02LjcyLjE0Yy0xLjc3LjI5LTMuNDMuNjYtNSwxLjA1LS41My0uMjItMS4wNi0uNDEtMS41OC0uNjRhMjguMjMsMjguMjMsMCwwLDEtNi41OC00LDguMjEsOC4yMSwwLDAsMS0xLjMtMS40LDIuNzUsMi43NSwwLDAsMS0uNjEtMS43NmMuMDUtLjU4LjU5LTEuMTEsMS40MS0xLjU1LjI2LS4xNC41NS0uMjYuODQtLjM4bTEyLjcsOS4xM2ExOS4xNiwxOS4xNiwwLDAsMSw2LjUsMCwzLjY3LDMuNjcsMCwwLDEsMi40NCwxLjU4LDIsMiwwLDAsMSwuNCwxLjQ0YzAsLjI5LS44MS41Ni0xLjQuNTlhMjIuNjYsMjIuNjYsMCwwLDEtNy4zMi0xLjExLDQ5LjMyLDQ5LjMyLDAsMCwxLTQuOTUtMS43M0MyMTYuNCwzOTcuODUsMjE3LjgzLDM5Ny41NywyMTkuMzMsMzk3LjM2WiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE5MC44NyAtMzY4LjA0KSIvPjxwYXRoIGNsYXNzPSJjbHMtMyIgZD0iTTIxMC4wOCwzOTMuNzljMS40NCwxLjU1LDIuOTIsMiwzLjY5LDEuNzVhMywzLDAsMCwwLDEuNjEtMS43OCw4LjUsOC41LDAsMCwwLC41Ni0yLDI4LjU5LDI4LjU5LDAsMCwwLDAtNy44NGMwLS4xNS0uMDUtLjI5LS4wNy0uNDQsMS4yOCwxLjI3LDIuNTMsMi40NCwzLjY3LDMuNDgsMi41NiwyLjMyLDQuNjgsNC4wOSw2LjE1LDUuMjlsMi4yOSwxLjgzLTIuMjQtMS44NWMtMS40My0xLjIxLTMuNS0zLTYtNS4zNS0xLjIzLTEuMTYtMi41OC0yLjQ3LTQtMy45MWE1MS4yMyw1MS4yMywwLDAsMC0xLjMtNi41NywyMy41NCwyMy41NCwwLDAsMC0yLjkyLTcuMDcsNC4zNSw0LjM1LDAsMCwwLS43OS0uODQsMi4zMiwyLjMyLDAsMCwwLS42OS0uMzksMS44MSwxLjgxLDAsMCwwLTEtLjA2LDIuNDIsMi40MiwwLDAsMC0xLjQsMS4zNCwzLjkzLDMuOTMsMCwwLDAtLjEsMy4xNywyMCwyMCwwLDAsMCwzLjUsNS43NWMxLjEzLDEuMzgsMi4yOCwyLjY0LDMuNDMsMy44My4wNy41Ny4xNywxLjEyLjIzLDEuNjlhMjguNTUsMjguNTUsMCwwLDEtLjEyLDcuNjcsOC4yNSw4LjI1LDAsMCwxLS41NiwxLjgzLDIuNzMsMi43MywwLDAsMS0xLjIyLDEuNDEsMi4yNSwyLjI1LDAsMCwxLTItLjQ0LDYuNDYsNi40NiwwLDAsMS0uNzUtLjU0bTEuNTItMTUuNTZhMTkuMjUsMTkuMjUsMCwwLDEtMy4yNC01LjY0LDMuNjgsMy42OCwwLDAsMSwuMTQtMi45LDIuMDksMi4wOSwwLDAsMSwxLTEuMDdjLjI2LS4xNC45LjQyLDEuMjMuOTFhMjMuMzUsMjMuMzUsMCwwLDEsMi43MSw2Ljg5Yy40MiwxLjY4LjcyLDMuNDEsMSw1LjE1QzIxMy41LDM4MC41MiwyMTIuNTQsMzc5LjQyLDIxMS42LDM3OC4yM1oiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0xOTAuODcgLTM2OC4wNCkiLz48L3N2Zz4="></image></g><g fill="dodgerblue" transform="matrix(1,0,0,1,160,40) "><text font-size="75" font-family="SourceHanSerif-B" font-weight="bolder" fill="#3399cc" dx="250" dy="210" text-anchor="middle" class="svg-name0">白色恋人</text><text font-size="25" font-family="SourceHanSerif-B" font-weight="bolder" fill="#3399cc" dx="250" dy="250" text-anchor="middle" class="svg-slogan0">White Lover</text></g></svg></svg>';
        $im = new \Imagick();
        $im->readImageBlob($svg);
        $im->setImageFormat("png");
        $imgpath = 'temp/phpimg.png';
        $im->writeImage($imgpath);

        $im->clear();
        $im->destroy();

        echo '<img src=/'.$imgpath.' />';
    }

    public function creatsvg() {
        $url = 'http://sj.songshuqf.com/api/api/changedownUrl';
        $data = ['svgxml'=>'<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" version="1.1" id="svg-drawing" viewBox="0 0 500 500" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs"><rect id="svg-background" width="100%" height="100%" fill-opacity="0"></rect><g id="svg-body" transform="matrix(1,0,0,1,120,84.91499328613281)"><g id="svg-logo" transform="matrix(1,0,0,1,0,0)" class="svg-element" data-ori="{&quot;w&quot;:250,&quot;h&quot;:250,&quot;x2&quot;:250,&quot;y2&quot;:250,&quot;cx&quot;:125,&quot;cy&quot;:125,&quot;x&quot;:0,&quot;y&quot;:0,&quot;width&quot;:250,&quot;height&quot;:250}"><g class="svg-shape" transform="matrix(1.04,0,0,1.04,0,0)"><rect rx="0" ry="0" width="250" height="250" fill-opacity="0" class="svg-logo-background"></rect><g transform="matrix(1,0,0,1,25,25)" class="imgUrl"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" contentscripttype="text/ecmascript" width="200" zoomAndPan="magnify" contentstyletype="text/css" viewBox="0 0 137.83 108.96" height="200" preserveAspectRatio="xMidYMid meet" version="1.0"><defs><style xml:space="preserve">.cls-1{isolation:isolate;}.cls-2{fill:#3f5ece;}.cls-2,.cls-3,.cls-8{fill-rule:evenodd;}.cls-3{fill:#9b30d1;}.cls-4{fill:url(#linear-gradient);}.cls-5{fill:url(#linear-gradient-2);}.cls-6{fill:url(#linear-gradient-3);}.cls-7{fill:url(#linear-gradient-4);}.cls-8{fill:#7385a1;opacity:0.5;mix-blend-mode:multiply;}</style><linearGradient x1="273.54" xmlns:xlink="http://www.w3.org/1999/xlink" y1="78.39" x2="213.13" gradientUnits="userSpaceOnUse" y2="231.48" xlink:type="simple" xlink:actuate="onLoad" id="linear-gradient" xlink:show="other"><stop offset="0" stop-color="#ed20d5"></stop><stop offset="1" stop-color="#1bcdde"></stop></linearGradient><linearGradient x1="213.37" xmlns:xlink="http://www.w3.org/1999/xlink" y1="235.14" x2="149.09" xlink:href="#linear-gradient" y2="131.68" xlink:type="simple" xlink:actuate="onLoad" id="linear-gradient-2" xlink:show="other"></linearGradient><linearGradient x1="234.54" xmlns:xlink="http://www.w3.org/1999/xlink" y1="171.56" x2="189.63" xlink:href="#linear-gradient" y2="105.11" xlink:type="simple" xlink:actuate="onLoad" id="linear-gradient-3" xlink:show="other"></linearGradient><linearGradient x1="225.35" xmlns:xlink="http://www.w3.org/1999/xlink" y1="177.76" x2="180.45" xlink:href="#linear-gradient" y2="111.32" xlink:type="simple" xlink:actuate="onLoad" id="linear-gradient-4" xlink:show="other"></linearGradient></defs><title>Kids Care</title><g class="cls-1"><g id="Layer_1" data-name="Layer 1"><path class="cls-2" d="M229.76,186.37c-6-3.76-6.8,17.63-22.38,23.83-4.77,1.89-8.26,3-14.51,1.25,1.28.55,1.68,2.14,3.55,2.53a31.56,31.56,0,0,0,4.06,1c15.74-.73,22.17-14.69,26.88-17.79.42-.28,1.37-3.39,1.77-3.47a36.8,36.8,0,0,0,.63-7.35" transform="translate(-133.17 -119.1)"></path><path class="cls-3" d="M229.13,193.72c-4.93,1-10.63,18.64-27.77,19.44,12.48.75,20.1-4.75,25.16-7.76,1.13-.68,2.53-5.38,3.38-5.25a36.59,36.59,0,0,0,1.39-5.71,2.41,2.41,0,0,0-2.16-.72" transform="translate(-133.17 -119.1)"></path><path class="cls-4" d="M269,143.69c-5.83-15.53-22.1-25.65-38.5-21.37-8.09,6-10.47,8.12-11.71,17.26,10.08-17.79,38.35-4,33,26.91C246.17,199.25,227.18,230,194.34,226,229.53,240.2,282,178.47,269,143.69Z" transform="translate(-133.17 -119.1)"></path><path class="cls-5" d="M197.57,212.64c-14.12-3-10.74-11.64-1.08-9.51a13.45,13.45,0,0,0,12.29-3.78c1.63-1.77,2.7-5.44-.26-5.15-1.61.16-3.93.87-5.78,1.13-4.38.61-5.2,0-11.58-2.12-6.66-2.19-10.06-1.06-14.12.4-25.23,9.08-32.52-39.59-15.83-52.25,9.37-7.11,23.9-6.31,31,2.2-2.39-7.1-8.42-17.29-27.93-21.33a35.6,35.6,0,0,0-6.43,1.52c-59.24,20.86,1.84,101.47,40,100.25,18.88-.6,28.31-9.38,33.72-22.69C227.15,195,217.44,216.88,197.57,212.64Z" transform="translate(-133.17 -119.1)"></path><path class="cls-6" d="M204.64,119.1c-4.08,0-7.4,3.68-7.4,8.21s3.32,8.21,7.4,8.21,7.39-3.67,7.39-8.21S208.72,119.1,204.64,119.1Z" transform="translate(-133.17 -119.1)"></path><path class="cls-7" d="M204.7,141.9c-7.43.18-14.92-23.73-40.4-19.67,15.76,4.34,30.55,18.33,31.9,33.56.69,7.77-1.65,16.76-4.77,24.62-5.57,14,4.19,10,9.25-1.91,4.55-10.77,6.51-4.17,3.95,3.95C201.7,191.74,215,200,215.41,155c.13-14.79,7-21.48,15.06-32.63a31.46,31.46,0,0,0-3.17,1C214.58,128.13,209.62,141.78,204.7,141.9Z" transform="translate(-133.17 -119.1)"></path><path class="cls-8" d="M171.91,125.1c5.45,3,8.53,6.71,11.85,12.7a19,19,0,0,1,8.46,5.75l-.05-.08,0-.1a47.13,47.13,0,0,0-20.21-18.27m54.82,7.43a31.27,31.27,0,0,1,2.4-8.39c-4.15,5.58-7.86,10.13-10.37,15.44A15.05,15.05,0,0,1,226.73,132.53Z" transform="translate(-133.17 -119.1)"></path></g></g></svg></g></g><rect id="SvgjsRect1040" width="260" height="260" class="svg-ghost" fill-opacity="0" stroke="#555555" stroke-opacity="0" stroke-width="0.8" stroke-dasharray="4,2"></rect></g><g id="svg-name" datatype="text" class="svg-element" data-ori="{&quot;w&quot;:0,&quot;h&quot;:0,&quot;x2&quot;:0,&quot;y2&quot;:0,&quot;cx&quot;:0,&quot;cy&quot;:0,&quot;x&quot;:0,&quot;y&quot;:0,&quot;width&quot;:0,&quot;height&quot;:0}" transform="matrix(1,0,0,1,42.394996643066406,260)"><g class="svg-shape" data-font="http://sj.songshuqf.com/font/★日文毛笔行书.ttf" data-text="圆鼓鼓色" data-size="45" fill="purple" transform="matrix(1,0,0,1,-14.940000534057617,-8.4399995803833)"><path d="M14.94 21.27L29.88 21.27L29.88 36.39L14.94 36.39L14.94 21.27ZM63.81 11.07L63.81 11.07Q63.81 11.95 62.93 15.47L62.93 15.47Q62.40 17.23 62.40 17.93L62.40 17.93Q64.86 18.46 65.92 18.63L65.92 18.63L65.92 18.98Q64.86 19.86 62.05 20.74L62.05 20.74Q61.88 21.45 61.70 22.15L61.70 22.15Q62.75 22.15 63.81 21.45L63.81 21.45Q64.69 21.09 65.21 21.09L65.21 21.09Q66.27 21.09 67.32 21.71Q68.38 22.32 68.38 23.20L68.38 23.20Q68.03 23.55 64.51 23.73L64.51 23.73Q61.88 23.91 53.96 27.42L53.96 27.42Q47.99 30.06 45.70 29.88L45.70 29.88Q47.64 27.77 57.83 23.55L57.83 23.55Q58.18 22.68 58.18 21.45L58.18 21.45L56.43 21.45Q55.55 21.45 51.68 20.39L51.68 20.39Q52.73 19.69 56.25 18.98L56.25 18.98L56.78 18.81L57.30 18.81L58.18 18.63Q58.36 17.75 58.54 15.47L58.54 15.47Q57.30 14.77 56.78 14.06L56.78 14.06Q57.83 11.95 58.71 11.60L58.71 11.60Q60.47 10.72 62.75 10.72L62.75 10.72Q63.28 10.72 63.81 11.07ZM75.06 13.71L75.06 13.71Q76.11 14.24 76.46 15.12L76.46 15.12Q76.46 16.17 76.29 17.40L76.29 17.40Q76.29 18.46 76.11 19.69L76.11 19.69L76.64 19.51L77.17 19.34Q78.93 19.34 82.27 20.04L82.27 20.04Q81.56 21.09 75.41 23.55L75.41 23.55Q74.00 26.54 74.00 27.42L74.00 27.42Q74.00 28.30 74.36 29.53L74.36 29.53Q76.99 29.71 77.34 29.88L77.34 29.88Q78.22 30.41 78.22 31.82L78.22 31.82Q78.22 33.05 76.11 38.14L76.11 38.14Q82.62 42.71 89.30 43.42L89.30 43.42Q87.36 45.18 85.08 45.18L85.08 45.18Q81.74 45.18 77.34 41.84L77.34 41.84Q75.76 40.78 74.71 40.25L74.71 40.25Q69.96 45.53 65.39 45.53L65.39 45.53Q64.69 45.53 63.11 44.47L63.11 44.47Q63.46 44.47 65.74 44.30L65.74 44.30Q68.73 44.12 72.60 38.85L72.60 38.85Q67.68 34.80 66.97 32.52L66.97 32.52Q68.73 32.87 70.49 34.45L70.49 34.45Q72.07 35.68 74.00 36.74L74.00 36.74Q74.36 36.21 74.53 35.68L74.53 35.68L74.71 35.33Q75.41 33.75 75.41 32.34L75.41 32.34Q75.41 31.46 75.06 30.76L75.06 30.76Q71.54 29.00 71.54 26.89L71.54 26.89Q71.54 26.72 71.72 25.66L71.72 25.66Q71.89 25.14 71.89 24.61L71.89 24.61Q68.91 25.66 67.32 25.66L67.32 25.66Q71.19 23.73 72.60 22.15L72.60 22.15Q72.77 19.51 72.95 16.52L72.95 16.52Q72.25 16.35 70.84 16.17L70.84 16.17Q71.37 15.12 71.89 14.41L71.89 14.41Q73.13 13.71 75.06 13.71ZM76.11 20.04L76.11 20.04Q75.94 20.92 75.76 21.45L75.76 21.45Q77.52 21.45 78.22 20.39L78.22 20.39Q77.70 20.04 76.11 20.04ZM65.57 27.42L65.57 27.42Q64.69 28.13 64.16 28.65L64.16 28.65Q63.63 29.36 63.11 29.53L63.11 29.53Q63.63 29.88 63.81 30.76L63.81 30.76Q61.35 31.11 60.29 34.28L60.29 34.28Q62.23 33.40 63.11 33.22L63.11 33.22Q63.81 33.22 64.51 33.57L64.51 33.57Q64.34 34.28 63.81 35.51L63.81 35.51Q63.28 36.56 63.11 37.44L63.11 37.44Q66.27 36.56 67.32 36.39L67.32 36.39Q67.15 37.27 66.45 37.62L66.45 37.62Q62.40 39.73 60.12 41.31L60.12 41.31Q55.20 44.47 52.38 44.47L52.38 44.47Q51.33 44.47 50.27 42.36L50.27 42.36Q51.33 41.31 52.73 40.96L52.73 40.96Q53.61 41.66 54.14 42.01L54.14 42.01Q57.30 41.13 60.64 36.04L60.64 36.04L60.29 35.33Q59.06 36.04 57.30 37.79L57.30 37.79Q56.78 38.50 55.90 38.85L55.90 38.85Q55.55 38.50 55.55 37.79L55.55 37.79Q55.55 36.39 56.78 34.98L56.78 34.98Q57.30 34.45 57.48 33.93L57.48 33.93Q55.02 34.10 54.49 27.77L54.49 27.77Q55.37 28.13 56.60 29.18L56.60 29.18Q60.47 25.66 62.58 25.66L62.58 25.66Q65.57 25.66 65.57 27.42ZM60.64 28.13L60.64 28.13Q57.30 29.71 57.30 30.76L57.30 30.76Q57.30 31.11 57.83 31.46L57.83 31.46Q60.64 28.83 60.64 28.13ZM108.81 11.07L108.81 11.07Q108.81 11.95 107.93 15.47L107.93 15.47Q107.40 17.23 107.40 17.93L107.40 17.93Q109.86 18.46 110.92 18.63L110.92 18.63L110.92 18.98Q109.86 19.86 107.05 20.74L107.05 20.74Q106.88 21.45 106.70 22.15L106.70 22.15Q107.75 22.15 108.81 21.45L108.81 21.45Q109.69 21.09 110.21 21.09L110.21 21.09Q111.27 21.09 112.32 21.71Q113.38 22.32 113.38 23.20L113.38 23.20Q113.03 23.55 109.51 23.73L109.51 23.73Q106.88 23.91 98.96 27.42L98.96 27.42Q92.99 30.06 90.70 29.88L90.70 29.88Q92.64 27.77 102.83 23.55L102.83 23.55Q103.18 22.68 103.18 21.45L103.18 21.45L101.43 21.45Q100.55 21.45 96.68 20.39L96.68 20.39Q97.73 19.69 101.25 18.98L101.25 18.98L101.78 18.81L102.30 18.81L103.18 18.63Q103.36 17.75 103.54 15.47L103.54 15.47Q102.30 14.77 101.78 14.06L101.78 14.06Q102.83 11.95 103.71 11.60L103.71 11.60Q105.47 10.72 107.75 10.72L107.75 10.72Q108.28 10.72 108.81 11.07ZM120.06 13.71L120.06 13.71Q121.11 14.24 121.46 15.12L121.46 15.12Q121.46 16.17 121.29 17.40L121.29 17.40Q121.29 18.46 121.11 19.69L121.11 19.69L121.64 19.51L122.17 19.34Q123.93 19.34 127.27 20.04L127.27 20.04Q126.56 21.09 120.41 23.55L120.41 23.55Q119.00 26.54 119.00 27.42L119.00 27.42Q119.00 28.30 119.36 29.53L119.36 29.53Q121.99 29.71 122.34 29.88L122.34 29.88Q123.22 30.41 123.22 31.82L123.22 31.82Q123.22 33.05 121.11 38.14L121.11 38.14Q127.62 42.71 134.30 43.42L134.30 43.42Q132.36 45.18 130.08 45.18L130.08 45.18Q126.74 45.18 122.34 41.84L122.34 41.84Q120.76 40.78 119.71 40.25L119.71 40.25Q114.96 45.53 110.39 45.53L110.39 45.53Q109.69 45.53 108.11 44.47L108.11 44.47Q108.46 44.47 110.74 44.30L110.74 44.30Q113.73 44.12 117.60 38.85L117.60 38.85Q112.68 34.80 111.97 32.52L111.97 32.52Q113.73 32.87 115.49 34.45L115.49 34.45Q117.07 35.68 119.00 36.74L119.00 36.74Q119.36 36.21 119.53 35.68L119.53 35.68L119.71 35.33Q120.41 33.75 120.41 32.34L120.41 32.34Q120.41 31.46 120.06 30.76L120.06 30.76Q116.54 29.00 116.54 26.89L116.54 26.89Q116.54 26.72 116.72 25.66L116.72 25.66Q116.89 25.14 116.89 24.61L116.89 24.61Q113.91 25.66 112.32 25.66L112.32 25.66Q116.19 23.73 117.60 22.15L117.60 22.15Q117.77 19.51 117.95 16.52L117.95 16.52Q117.25 16.35 115.84 16.17L115.84 16.17Q116.37 15.12 116.89 14.41L116.89 14.41Q118.13 13.71 120.06 13.71ZM121.11 20.04L121.11 20.04Q120.94 20.92 120.76 21.45L120.76 21.45Q122.52 21.45 123.22 20.39L123.22 20.39Q122.70 20.04 121.11 20.04ZM110.57 27.42L110.57 27.42Q109.69 28.13 109.16 28.65L109.16 28.65Q108.63 29.36 108.11 29.53L108.11 29.53Q108.63 29.88 108.81 30.76L108.81 30.76Q106.35 31.11 105.29 34.28L105.29 34.28Q107.23 33.40 108.11 33.22L108.11 33.22Q108.81 33.22 109.51 33.57L109.51 33.57Q109.34 34.28 108.81 35.51L108.81 35.51Q108.28 36.56 108.11 37.44L108.11 37.44Q111.27 36.56 112.32 36.39L112.32 36.39Q112.15 37.27 111.45 37.62L111.45 37.62Q107.40 39.73 105.12 41.31L105.12 41.31Q100.20 44.47 97.38 44.47L97.38 44.47Q96.33 44.47 95.27 42.36L95.27 42.36Q96.33 41.31 97.73 40.96L97.73 40.96Q98.61 41.66 99.14 42.01L99.14 42.01Q102.30 41.13 105.64 36.04L105.64 36.04L105.29 35.33Q104.06 36.04 102.30 37.79L102.30 37.79Q101.78 38.50 100.90 38.85L100.90 38.85Q100.55 38.50 100.55 37.79L100.55 37.79Q100.55 36.39 101.78 34.98L101.78 34.98Q102.30 34.45 102.48 33.93L102.48 33.93Q100.02 34.10 99.49 27.77L99.49 27.77Q100.37 28.13 101.60 29.18L101.60 29.18Q105.47 25.66 107.58 25.66L107.58 25.66Q110.57 25.66 110.57 27.42ZM105.64 28.13L105.64 28.13Q102.30 29.71 102.30 30.76L102.30 30.76Q102.30 31.11 102.83 31.46L102.83 31.46Q105.64 28.83 105.64 28.13ZM159.43 14.06L159.43 14.06L159.79 14.41Q163.13 14.24 164.36 17.23L164.36 17.23Q162.07 20.21 159.08 21.97L159.08 21.97Q158.03 22.68 157.68 23.55L157.68 23.55Q158.55 23.55 159.61 23.20L159.61 23.20L160.31 23.03Q160.84 22.85 161.37 22.68L161.37 22.68Q162.95 22.15 163.48 22.15L163.48 22.15Q165.06 22.15 166.46 23.91L166.46 23.91Q165.94 26.72 164.18 28.30L164.18 28.30Q160.84 31.46 158.03 31.46L158.03 31.46Q157.15 31.46 153.81 30.94L153.81 30.94Q153.63 30.94 152.75 30.76L152.75 30.76Q151.88 32.34 151.08 35.07Q150.29 37.79 150.29 39.20L150.29 39.20Q150.29 43.24 152.75 43.59L152.75 43.59Q155.57 43.95 159.08 43.95L159.08 43.95Q165.06 43.95 168.22 40.25L168.22 40.25Q169.98 38.14 169.98 35.51L169.98 35.51L169.98 34.98L169.98 34.63L169.98 34.28L169.98 33.93L169.98 33.22Q173.85 37.09 173.85 42.19L173.85 42.19Q173.85 43.95 171.39 44.82L171.39 44.82Q165.76 47.11 159.26 47.11L159.26 47.11Q152.58 47.11 149.59 45L149.59 45Q147.13 43.24 147.13 38.32L147.13 38.32Q147.13 35.68 149.77 29.00L149.77 29.00L149.94 28.65Q149.59 27.95 149.24 27.25L149.24 27.25Q148.89 26.37 148.89 25.84L148.89 25.84Q151.70 24.43 155.74 20.57L155.74 20.57Q157.32 19.16 157.32 17.93L157.32 17.93L156.97 17.58Q145.90 24.96 143.61 25.14L143.61 25.14Q142.91 24.26 142.73 22.50L142.73 22.50Q143.44 21.97 148.36 18.63L148.36 18.63Q156.45 13.18 156.97 11.95L156.97 11.95Q156.62 11.43 156.45 11.07L156.45 11.07Q155.92 10.37 155.21 9.49L155.21 9.49Q156.27 8.44 157.50 8.44L157.50 8.44Q158.55 8.44 160.66 9.67L160.66 9.67Q161.54 10.20 161.54 11.07L161.54 11.07Q161.54 11.78 159.43 14.06ZM161.54 25.14L161.54 25.14Q159.61 24.96 155.92 26.54L155.92 26.54Q156.80 27.42 156.97 29.36L156.97 29.36Q157.85 29.00 159.43 29.00L159.43 29.00Q159.79 28.65 160.14 28.13L160.14 28.13Q161.54 26.54 161.54 25.14ZM154.51 29.36L154.51 27.25Q153.98 27.42 153.63 27.42L153.63 27.42Q152.93 27.77 152.40 28.30L152.40 28.30Q152.75 29.36 153.46 29.71L153.46 29.71Q153.98 29.36 154.51 29.36L154.51 29.36Z"></path></g><rect id="SvgjsRect1041" width="158.91000366210938" height="38.67000198364258" class="svg-ghost" fill-opacity="0" stroke="#555555" stroke-opacity="0" stroke-width="0.8" stroke-dasharray="4,2"></rect></g><g id="svg-slogan" datatype="text" class="svg-element" data-ori="{&quot;w&quot;:0,&quot;h&quot;:0,&quot;x2&quot;:0,&quot;y2&quot;:0,&quot;cx&quot;:0,&quot;cy&quot;:0,&quot;x&quot;:0,&quot;y&quot;:0,&quot;width&quot;:0,&quot;height&quot;:0}" style="opacity: 1;" transform="matrix(1,0,0,1,72.87999725341797,315)"><g class="svg-shape" data-font="http://sj.songshuqf.com/font/华康宋体W12(P).ttf" data-text="Drum color" data-size="22" fill="purple" transform="matrix(1,0,0,1,-0.7699999809265137,-7.260000228881836)"><path d="M15.83 14.59L15.83 14.59Q15.83 18.15 13.64 19.98L13.64 19.98Q11.62 21.70 7.95 21.70L7.95 21.70L0.77 21.70L0.77 20.84L1.29 20.84Q2.64 20.84 2.64 19.21L2.64 19.21L2.64 10.01Q2.64 8.42 1.44 8.42L1.44 8.42L0.82 8.42L0.82 7.56L7.56 7.56Q11 7.56 13.32 9.32L13.32 9.32Q15.83 11.28 15.83 14.59ZM12.16 14.63L12.16 14.63Q12.16 8.42 7.22 8.42L7.22 8.42Q5.97 8.42 5.97 10.01L5.97 10.01L5.97 19.21Q5.97 20.84 7.39 20.84L7.39 20.84L8.38 20.84Q10.36 20.84 11.37 18.61L11.37 18.61Q12.16 16.87 12.16 14.63ZM24.02 13.38L24.02 13.38Q24.02 14.82 22.67 14.82L22.67 14.82Q22.02 14.82 21.59 14.18L21.59 14.18Q21.18 13.51 21.21 13.51L21.21 13.51Q20.88 13.51 20.52 13.88L20.52 13.88L20.52 19.79Q20.52 21.05 21.55 21.05L21.55 21.05L21.55 21.70L16.82 21.70L16.82 21.05Q17.88 21.05 17.88 19.79L17.88 19.79L17.88 14.01Q17.88 13.23 17.77 13.02L17.77 13.02Q17.60 12.65 16.97 12.65L16.97 12.65L16.97 12.03Q18.37 12.03 20.52 11.54L20.52 11.54L20.52 12.65Q21.55 11.90 22.28 11.90L22.28 11.90Q24.02 11.90 24.02 13.38ZM37.45 21.05L37.45 21.76Q34.59 21.76 32.91 22.43L32.91 22.43L32.91 20.99Q31.35 22.02 30.08 22.02L30.08 22.02Q28.60 22.02 27.48 21.10L27.48 21.10Q26.34 20.20 26.34 18.71L26.34 18.71L26.34 14.78Q26.34 13.32 24.79 13.32L24.79 13.32L24.79 12.61Q27.29 12.61 29.43 11.54L29.43 11.54L29.43 18.78Q29.43 19.59 29.78 20.15L29.78 20.15Q30.16 20.78 30.96 20.78L30.96 20.78Q31.78 20.78 32.91 20.00L32.91 20.00L32.91 14.78Q32.91 13.32 31.22 13.32L31.22 13.32L31.22 12.61Q33.88 12.61 36.01 11.54L36.01 11.54L36.01 19.44Q36.01 21.05 37.45 21.05L37.45 21.05ZM57.00 20.99L57.00 21.70L50.98 21.70L50.98 20.99Q51.88 20.99 52.14 20.56L52.14 20.56Q52.36 20.28 52.36 19.34L52.36 19.34L52.36 14.57Q52.36 12.55 51.07 12.55L51.07 12.55Q50.32 12.55 49.24 13.45L49.24 13.45Q49.48 14.01 49.48 14.80L49.48 14.80L49.48 19.34Q49.48 20.99 50.77 20.99L50.77 20.99L50.77 21.70L44.97 21.70L44.97 20.99Q46.32 20.99 46.32 19.34L46.32 19.34L46.32 14.57Q46.32 13.84 46.04 13.28L46.04 13.28Q45.68 12.55 45.03 12.55L45.03 12.55Q44.30 12.55 43.46 13.21L43.46 13.21L43.46 19.36Q43.46 20.22 43.66 20.54L43.66 20.54Q43.94 20.99 44.75 20.99L44.75 20.99L44.75 21.70L38.74 21.70L38.74 20.99Q40.33 20.99 40.33 19.36L40.33 19.36L40.33 14.78Q40.33 13.34 38.67 13.34L38.67 13.34L38.67 12.61Q40.20 12.61 41.12 12.38L41.12 12.38Q41.70 12.25 43.46 11.54L43.46 11.54L43.46 12.38Q44.56 11.54 46.00 11.54L46.00 11.54Q48.02 11.54 48.92 12.83L48.92 12.83Q50.40 11.54 52.04 11.54L52.04 11.54Q53.63 11.54 54.57 12.38L54.57 12.38Q55.52 13.21 55.52 14.80L55.52 14.80L55.52 19.34Q55.52 20.99 57.00 20.99L57.00 20.99ZM75.15 18.61L75.75 19.06Q73.78 22.02 70.94 22.02L70.94 22.02Q68.58 22.02 67.10 20.56L67.10 20.56Q65.63 19.12 65.63 16.78L65.63 16.78Q65.63 14.39 67.07 12.98L67.07 12.98Q68.56 11.54 70.94 11.54L70.94 11.54Q72.34 11.54 73.46 12.10L73.46 12.10Q74.89 12.78 74.89 14.05L74.89 14.05Q74.89 14.70 74.46 15.15L74.46 15.15Q74.08 15.64 73.43 15.64L73.43 15.64Q72.81 15.64 72.34 15.21L72.34 15.21Q71.89 14.80 71.89 14.16L71.89 14.16Q71.89 13.96 72.02 13.56L72.02 13.56Q72.12 13.15 72.12 12.98L72.12 12.98Q72.12 12.29 71.11 12.29L71.11 12.29Q70.04 12.29 69.39 13.99L69.39 13.99Q68.90 15.28 68.90 16.61L68.90 16.61Q68.90 18.18 69.42 19.31L69.42 19.31Q70.08 20.84 71.44 20.84L71.44 20.84Q73.58 20.84 75.15 18.61L75.15 18.61ZM87.79 16.78L87.79 16.78Q87.79 19.08 86.28 20.56L86.28 20.56Q84.76 22.02 82.44 22.02L82.44 22.02Q80.12 22.02 78.59 20.54L78.59 20.54Q77.06 19.06 77.06 16.78L77.06 16.78Q77.06 14.48 78.59 13.02L78.59 13.02Q80.12 11.54 82.44 11.54L82.44 11.54Q84.78 11.54 86.30 13.00L86.30 13.00Q87.79 14.44 87.79 16.78ZM84.50 16.78L84.50 16.78Q84.50 15.23 84.11 14.05L84.11 14.05Q83.60 12.27 82.44 12.27L82.44 12.27Q81.25 12.27 80.74 14.05L80.74 14.05Q80.35 15.23 80.35 16.78L80.35 16.78Q80.35 18.33 80.74 19.51L80.74 19.51Q81.25 21.29 82.44 21.29L82.44 21.29Q83.60 21.29 84.11 19.51L84.11 19.51Q84.50 18.33 84.50 16.78ZM95.09 20.99L95.09 21.70L88.99 21.70L88.99 20.99Q89.98 20.99 90.30 20.65L90.30 20.65Q90.60 20.30 90.60 19.31L90.60 19.31L90.60 10.76Q90.60 10.05 90.13 9.65L90.13 9.65Q89.63 9.28 88.88 9.28L88.88 9.28L88.88 8.55Q91.44 8.55 93.52 7.26L93.52 7.26L93.52 19.31Q93.52 20.26 93.82 20.60L93.82 20.60Q94.14 20.99 95.09 20.99L95.09 20.99ZM106.93 16.78L106.93 16.78Q106.93 19.08 105.42 20.56L105.42 20.56Q103.90 22.02 101.58 22.02L101.58 22.02Q99.26 22.02 97.73 20.54L97.73 20.54Q96.21 19.06 96.21 16.78L96.21 16.78Q96.21 14.48 97.73 13.02L97.73 13.02Q99.26 11.54 101.58 11.54L101.58 11.54Q103.92 11.54 105.45 13.00L105.45 13.00Q106.93 14.44 106.93 16.78ZM103.64 16.78L103.64 16.78Q103.64 15.23 103.25 14.05L103.25 14.05Q102.74 12.27 101.58 12.27L101.58 12.27Q100.40 12.27 99.88 14.05L99.88 14.05Q99.49 15.23 99.49 16.78L99.49 16.78Q99.49 18.33 99.88 19.51L99.88 19.51Q100.40 21.29 101.58 21.29L101.58 21.29Q102.74 21.29 103.25 19.51L103.25 19.51Q103.64 18.33 103.64 16.78ZM115.01 13.38L115.01 13.38Q115.01 14.82 113.65 14.82L113.65 14.82Q113.01 14.82 112.58 14.18L112.58 14.18Q112.17 13.51 112.19 13.51L112.19 13.51Q111.87 13.51 111.50 13.88L111.50 13.88L111.50 19.79Q111.50 21.05 112.54 21.05L112.54 21.05L112.54 21.70L107.81 21.70L107.81 21.05Q108.86 21.05 108.86 19.79L108.86 19.79L108.86 14.01Q108.86 13.23 108.75 13.02L108.75 13.02Q108.58 12.65 107.96 12.65L107.96 12.65L107.96 12.03Q109.36 12.03 111.50 11.54L111.50 11.54L111.50 12.65Q112.54 11.90 113.27 11.90L113.27 11.90Q115.01 11.90 115.01 13.38Z"></path></g><rect id="SvgjsRect1042" width="114.24000549316406" height="15.170000076293945" class="svg-ghost" fill-opacity="0" stroke="#555555" stroke-opacity="0" stroke-width="0.8" stroke-dasharray="4,2"></rect></g><g id="svg-append-text" datatype="text" transform="matrix(1,0,0,1,130,0)" class="svg-element" style="opacity: 1;" data-ori="{&quot;w&quot;:0,&quot;h&quot;:0,&quot;x2&quot;:0,&quot;y2&quot;:0,&quot;cx&quot;:0,&quot;cy&quot;:0,&quot;x&quot;:0,&quot;y&quot;:0,&quot;width&quot;:0,&quot;height&quot;:0}"><g fill="#888" data-text="" data-size="22" transform="matrix(1,0,0,1,130,0)" class="svg-shape"></g><rect id="SvgjsRect1043" width="0" height="0" class="svg-ghost" fill-opacity="0" stroke="#555555" stroke-opacity="0" stroke-width="0.8" stroke-dasharray="4,2"></rect></g></g><defs id="SvgjsDefs1001"></defs></svg>'];
        $header = array("Content-Type:application/json;charset=UTF-8");
        $retData = $this->post($url,json_encode($data),$header);
        $retDataArr = json_decode($retData,true);
        //var_dump($retDataArr);

        $url = "http://sj.songshuqf.com/api/api/joinchangeimage";
        $data = ['materialId'=>'1054', 'svgurl'=>$retDataArr['logonameurl']];
        $result = $this->post($url,json_encode($data),$header);
        var_dump($result);
    }


    public function post($url, $data,$header)
    {
        //初使化init方法
        $ch = curl_init();
        //指定URL
        curl_setopt($ch, CURLOPT_URL, $url);
        //设定请求后返回结果
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        //声明使用POST方式来进行发送
        curl_setopt($ch, CURLOPT_POST, 1);
        //发送什么数据呢
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        //忽略证书
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        //忽略header头信息
        curl_setopt($ch, CURLOPT_HEADER, 0);
        //设置超时时间
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        //发送请求
        $output = curl_exec($ch);
        //关闭curl
        curl_close($ch);
        //返回数据
        return $output;
    }

    public function cssmerge() {
        return $this->fetch();
    }

}