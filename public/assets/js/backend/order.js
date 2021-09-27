define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'order/index',
                    add_url: 'order/add',
                    edit_url: 'order/edit',
                    multi_url: 'order/multi',
                    table: '',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'order_id',
                sortName: 'order_id',
                searchFormVisible:true,
                search: false,
                //启用普通表单搜索
                commonSearch: true,
                onLoadSuccess:function(){
                    // 这里就是数据渲染结束后的回调函数
                    $(".btn-dialog").data("area", ['95%','90%']);
                },
                queryParams: function(params) {
                    return params;
                },
                columns: [
                    [
                        {field: 'order_no', title: __('订单号'),formatter:function(value,row,index){
                            return `<a href="orderfile/index/vc_sn/${value}" class="btn-detail btn-dialog" title=""> ${value}</a>`;
                        }},
                        {field: 'paymoney', title: __('付款金额'), operate: false},
                        {field: 'paytype', title: __('付款方式'), searchList: {'alipay': __('支付宝'), 'wechat': __('微信')},formatter:function(value,row,index){
                            if(value == 'alipay') {
                                return '支付宝';
                            }   
                            else if(value == 'wechat') {
                                return '微信';
                            }
                        }},
                        {field: 'mobile', title: __('手机号码')},
                        {field: 'logonameurl', title: __('logo名称'), operate: "LIKE"},
                        // {field: 'logoname_en', title: __('logo名称英文'), operate:false},
                        {field: 'hy', title: __('行业'), operate: "LIKE"},
                        {field: 'creat_time', title: __('下单时间'), addclass: 'datetimepicker',data:'data-date-format="YYYY-MM-DD"', operate: 'BETWEEN'},
                        {field: 'order_stage', title: __('付款状态'),operate: false,formatter(value,row,index){
                            if(value == '0') {
                                return '未支付';
                            }   
                            else if(value == '1') {
                                return '支付';
                            }
                        }},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });


            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            },
            formatter: { 
                url: function(value, row, index) {

                },
            },
        }
    };
    return Controller;
});