define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'material/index/',
                    add_url: 'material/add',
                    edit_url: 'material/edit',
                    del_url: 'material/del',
                    multi_url: 'material/multi',
                    table: '',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'material_id',
                sortName: 'material_id',
                searchFormVisible:true,
                search: false,
                //启用普通表单搜索
                commonSearch: true,
                columns: [
                    [
                        {field: 'material_id', title: __('ID'),operate: false},
                        {field: 'material_name', title: __('素材名称'),operate: true},
                        {field: 'material_path', title: __('预览'), operate: false,formatter:function(value,row,index){
                                return `<img src="${value}" style="width: 40px; height: 40px;">`;
                            }},
                        {field: 'color_system.name',searchList: $.getJSON('material/getColor'), title: __('色系')},
                        {field: 'typename', title: __('标签'), operate: "LIKE",formatter:function(value,row,index){
                                var str = '';
                                if(value) {
                                    var arr = value.split(",");
                                    for(var i in arr) {
                                        str+=`<span class="btn btn-default btn-sm" style="margin-right: 3px;">${arr[i]}</span>`;
                                    }
                                }
                                return str;
                            }},
                        {field: 'industry.industry_name', searchList: $.getJSON('material/getHy'),title: __('行业'),operate: "LIKE"},
                        {field: 'status', title: __('状态'),searchList: {"0":__('正常'),"1":__('锁定')},formatter:function (value,row,index){
                                if (value == 0) {
                                    return '正常';
                                }
                                else {
                                    return '锁定';
                                }
                            }},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        selectdata: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'material/index',
                    table: '',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'material_id',
                sortName: 'material_id',
                searchFormVisible:true,
                search: false,
                //启用普通表单搜索
                commonSearch: true,
                columns: [
                    [
                        {field: 'material_id',operate: false,formatter:function (value,row,index){
                                return `<input data-index="${value}" name="btSelectItem" type="radio" value="${value}">`
                            }},

                        {field: 'material_name', title: __('素材名称'),operate: true},
                        {field: 'material_path', title: __('预览'), operate: false,formatter:function(value,row,index){
                                return `<img src="${value}" style="width: 40px; height: 40px;">`;
                            }},
                        {field: 'color_system.name',searchList: $.getJSON('material/getColor'), title: __('色系')},
                        {field: 'typename', title: __('标签'), operate: "LIKE",formatter:function(value,row,index){
                                var str = '';
                                if(value) {
                                    var arr = value.split(",");
                                    for(var i in arr) {
                                        str+=`<span class="btn btn-default btn-sm" style="margin-right: 3px;">${arr[i]}</span>`;
                                    }
                                }
                                return str;
                            }},
                        {field: 'industry.industry_name', searchList: $.getJSON('material/getHy'),title: __('行业'),operate: "LIKE"},
                        {field: 'status', title: __('状态'),searchList: {"0":__('正常'),"1":__('锁定')},formatter:function (value,row,index){
                                if (value == 0) {
                                    return '正常';
                                }
                                else {
                                    return '锁定';
                                }
                            }},
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
                $(document).on('click', ".sendno", function (row) {
                    console.log(row)
                });
            },
            formatter: {
                url: function(value, row, index) {

                    if(row.ti_status!=1) {
                        var url ="javascript:alert('请先查单')";
                        return '<div class="input-group input-group-sm"><a href="' + url + '" class="btn btn-xs btn-danger btn-magic">复制</div>';
                    }
                    else {
                        var url = "【原谷品牌设计】您好，让您久等了，这是您购买的ai智能logo设计结果，请您查收 lg.yuangu03.cn/r/"+value;
                        //var str = '<button class="copybtn" onclick="copyArticle(this)" >复制</button>';
                        return '<div class="input-group input-group-sm"><span class="copybtn" data-clipboard-text="'+url+'"><a href="javascript:;" alt="复制" title="复制" class="btn btn-xs btn-success btn-magic">复制</a></span></div>';
                    }
                },
            },
        }
    };
    return Controller;
});