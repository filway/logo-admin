(function(){
	var dataread={};
	var init=function(){
		if(localStorage['orders20180312']!==undefined && localStorage['orders20180312']!==""){
			dataread=JSON.parse(localStorage['orders20180312']);
		}
		if(localStorage['orders20180312']==undefined){
			localStorage['orders20180312']='{}';
			dataread=JSON.parse(localStorage['orders20180312']);
		}
		if(localStorage['orders20180312'].indexOf("undefined")>0){
			localStorage['orders20180312']='{}';
			dataread=JSON.parse(localStorage['orders20180312']);
		}
	}
	var set_data=function(this_history_v){
		var his=JSON.parse(this_history_v);
		if(dataread[his.order_id]===undefined){
			dataread[his.order_id]={}
		}
		dataread[his.order_id]=this_history_v;
	}
	var save_data=function(){
		localStorage['orders20180312']=JSON.stringify(dataread);
	}
	if(this_history!==undefined && this_history!==""){
	init();
	set_data(this_history);
	save_data();}

})()