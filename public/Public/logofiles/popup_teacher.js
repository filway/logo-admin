/*
 * 老师微信弹出层   需要和jquery----layer----clipboar一起用
 * 调用 new popupTeacher.init('绑定事件名'，'传入的微信号')
 */
window.popupTeacher=function(){
	// 兼容IE-classList处理
	if (!("classList" in document.documentElement)) {
        Object.defineProperty(HTMLElement.prototype, 'classList', {
            get: function() {
                var self = this;
                function update(fn) {
                    return function(value) {
                        var classes = self.className.split(/\s+/g),
                            index = classes.indexOf(value);
                        
                        fn(classes, index, value);
                        self.className = classes.join(" ");
                    }
                }
                
                return {                    
                    add: update(function(classes, index, value) {
                        if (!~index) classes.push(value);
                    }),
                    
                    remove: update(function(classes, index) {
                        if (~index) classes.splice(index, 1);
                    }),
                    
                    toggle: update(function(classes, index, value) {
                        if (~index)
                            classes.splice(index, 1);
                        else
                            classes.push(value);
                    }),
                    
                    contains: function(value) {
                        return !!~self.className.split(/\s+/g).indexOf(value);
                    },
                    
                    item: function(i) {
                        return self.className.split(/\s+/g)[i] || null;
                    }
                };
            }
        });
    }
	//绑定事件
	var e=function(){
		this.box
	};
	e.prototype={
		init: function(name,wxNum,imgUrl, masterThumb) {
			this.box = document.querySelectorAll(name),
			this.wx = wxNum,
			this.imgUrl = imgUrl,
			this.masterThumb = masterThumb ? masterThumb : imgUrl+'/weixin_touxiang.png',
			this.bindEvent('data')
		},
		bindEvent:function(type){
			var self=this;
			
			//微信弹出box
			function popupBox(){
				var popupBox=document.createElement('div'),
					popupBoxHtml='<div class="popupT_bj" onclick="noRemove()"></div>'+
						'<div class="popupT_Con">'+
						'<div class="popupT_ConTop">'+
						'<img src="'+self.masterThumb+'" />'+
						'<p>每天只通过50个名额<br>添加微信号'+self.wx+'立即咨询</p>'+
						'<i class="popupTNo" onclick="noRemove()"></i>'+
						'</div>'+
						'<div class="popupWx">'+
						'<p id="weixinNum">'+self.wx+'</p>'+
						'<button id="weixinCopy" data-clipboard-action="copy" data-clipboard-target="#weixinNum">复制</button>'+
						'</div>'+
						'<a href="weixin://" class="popupWxShow"><span>点击打开微信</span></a>'+
						'<p class="popupText">打开微信，点击右上角“<span>+</span>”，点击“<span>添加朋友</span>”</p>'+
						'<div class="popupImg">'+
						'<img src="'+self.imgUrl+'/weixin_demo.png"/>'+
						'</div>'+
						'</div>';
					popupBox.innerHTML=popupBoxHtml;
					popupBox.setAttribute('id','popupTeacher');
					document.body.appendChild(popupBox);
					//点击关闭事件
//			        document.querySelector('.popupT_bj').onclick=function(){
//			        	document.querySelector('#popupTeacher').remove();
//			        }
//			        document.querySelector('.popupTNo').onclick=function(){
//			        	document.querySelector('#popupTeacher').remove();
//			        }

				var type=navigator.userAgent;
				if(type.indexOf('baiduboxapp') > -1){
					//百度浏览器有打开微信按钮时按钮隐藏
					document.querySelector('.popupWxShow').style['display']='none';
				}
		}
			//拷贝微信
			var clipboard = new ClipboardJS('#weixinCopy');
	        clipboard.on('success', function(e) {
	            layer.msg('复制成功');
	            e.clearSelection();
	        });
	
	        clipboard.on('error', function(e) {
	            layer.msg('请长按微信号进行复制!');
	        });
			//调用插件
			for(var m=0,mLen=self.box.length;m<mLen;m++){
				self.box[m].addEventListener('click',function(){
					popupBox();
				})
			}
			
		}
	}
	return e;
	
}();
function noRemove(){
	document.querySelector('#popupTeacher').remove();
}