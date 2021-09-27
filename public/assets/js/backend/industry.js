define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'industry/index',
                    add_url: 'industry/add',
                    edit_url: 'industry/edit',
                    del_url: 'industry/del',
                    multi_url: 'industry/multi',
                    table: '',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'industry_id',
                sortName: 'industry_id',
                searchFormVisible:true,
                search: false,
                //启用普通表单搜索
                commonSearch: true,
                columns: [
                    [
                        {field: 'file_name', title: __('初始图片(浅色)'),operate: false},
                        {field: 'file_name1', title: __('选中图片(深色)'),operate: false},
                        {field: 'industry_info', title: __('产业信息'), operate: false},
                        {field: 'industry_name', title: __('行业名称'),operate: "LIKE"},
                       /* {field: 'stage', title: __('状态'), operate: false,formatter:function(value,row,index){
                                var str = '';
                                if(value == 0) {
                                    str = '未删除';
                                }
                                else{
                                    str = '已删除';
                                }
                                return str;
                            }},*/
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
                $(document).on('click', ".sendno", function (row) {
                    console.log(row)
                });
            },
            formatter: {
                url: function(value, row, index) {
                },
            },
        }
    };
    return Controller;
});