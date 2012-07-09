/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - Prasetya Yanuar (prasetya.yanuar@googlemail.com)
 */

 var m_pssr_laporan;
 var m_pssr_laporan_master;
 var m_pssr_laporan_detail;
 var m_pssr_laporan_d = _g_root +'/module/pssr_laporan/';
 var m_pssr_laporan_id_pssr = '';
 var m_pssr_laporan_id_report = '';
 var m_pssr_laporan_tipe_report = '';
 var m_pssr_laporan_ha_level = 0;
 
 function m_pssr_laporan_master_on_select_load_detail()
 {
 	if (typeof m_pssr_laporan_master == 'undefined') {
		return;
	}

	m_pssr_laporan_detail.do_refresh();
 }

 function m_pssrLaporanMaster(title)
 {
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pssr' }
		,	{ name	: 'id_project' }
		,	{ name	: 'tanggal' }
		,	{ name	: 'lokasi' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pssr_laporan_d +'data_master.jsp'
		,	autoLoad: false
	});
	this.store_project = new Ext.data.ArrayStore({
			fields 	: ['id_project','no_project','nama_project','tanggal_mulai']
		,	url		: _g_root +'/module/pssr_entry/data_project.jsp'
		,	autoLoad: false
	});
	
	this.form_project = new Ext.form.ComboBox({
			store		: this.store_project
		,	valueField	: 'id_project'
		,	displayField	: 'nama_project'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Project'
		,	dataIndex	: 'id_project'
		,	editor		: this.form_project
		,	renderer	: combo_renderer(this.form_project)
		,	width		: 200
		},
		{
			header		: 'Tanggal'
		,	dataIndex	: 'tanggal'
		,	align		: 'center'
		,	width		: 90
		},{
			id			: 'lokasi'
		,	header		: 'Lokasi'
		,	dataIndex	: 'lokasi'
		}]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});


	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_pssr_laporan_id_pssr = data[0].data['id_pssr'];
					} else {
						m_pssr_laporan_id_pssr = '';
					}

					m_pssr_laporan_master_on_select_load_detail();
				}
			}
	});

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.store.reload();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'lokasi'
	});

	this.do_load = function()
	{
		var load_type = 'user';

		if (m_pssr_laporan_ha_level == 4) {
			load_type = 'all';
		}
		this.store_project.load();
		this.store.load({
			params	: {
				load_type : load_type
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pssr_laporan_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Laporan PSSR!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
 }
 
  function m_pssrLaporanDetail(title)
 {
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_report' }
		,	{ name	: 'nama_report' }
		,	{ name	: 'klasifikasi_report' }
		,	{ name	: 'tipe_report' }
		,	{ name	: 'file_location' }
		,	{ name	: 'web_params' }
		,	{ name	: 'report_params' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pssr_laporan_d +'data_detail.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{	id			: 'nama_report'
		,	header		: 'Nama Laporan'
		,	dataIndex	: 'nama_report'
		}]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_pssr_laporan_id_report		= data[0].data['id_report'];
						m_pssr_laporan_tipe_report	= data[0].data['tipe_report'];
						this.btn_print.setDisabled(false);
					} else {
						m_pssr_laporan_id_report		= '';
						m_pssr_laporan_tipe_report	= '';
						this.btn_print.setDisabled(true);
					}
				}
			}
	});

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.store.reload();
			}
	});

	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_print
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nama_report'
	});

	this.do_print = function()
	{
		if (m_pssr_laporan_id_pssr == '') {
			return;
		}

		var form;
		form = document.createElement('form');

		form.setAttribute('method', 'post');
		form.setAttribute('target', '_blank');		
		form.setAttribute('action', _g_root +'/report');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'id');
        hiddenField1.setAttribute('value', m_pssr_laporan_id_report);
		
		var hiddenField2 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField2.setAttribute('name', 'type');
        hiddenField2.setAttribute('value', m_pssr_laporan_tipe_report);

		var hiddenField3 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField3.setAttribute('name', 'id_pssr');
        hiddenField3.setAttribute('value', m_pssr_laporan_id_pssr);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
		document.body.appendChild(form);
		form.submit();
	}
	
	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		this.do_load();
		
		this.btn_print.setDisabled(true);
	}
 }
 
 function M_pssrLaporanChecklist()
{
	this.fields = new Ext.data.Record.create([
		{name:'id_pssr'}
	,	{name:'id_item_detail_pssr'}
	,	{name:'id_item_pssr'}
	,	{name:'id_kategori_item_pssr'}
	,	{name:'nama_item_detail_pssr'}
	,	{name:'nama_item_pssr'}
	,	{name:'nama_kategori_item_pssr'}
	,	{name:'applicable'}
	,	{name:'confirm_ok'}
	,	{name:'punchlist'}
	,	{name:'keterangan'}
	]);

	this.reader	= new Ext.data.JsonReader({
		root	:'rows'
	}, this.fields);

	this.store = new Ext.data.GroupingStore({
		url			:m_pssr_laporan_d +'data_checklist.jsp'
	,	reader		:this.reader
	,	autoLoad	:false
	});
	
	this.store_applicable = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'No']
			,	['1', 'Yes']
			]
		});
	this.store_confirm = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'No']
			,	['1', 'Yes']
			,	['2', '-']
			]
		});
	this.store_punchlist = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'Minor']
			,	['1', 'Major']
			,	['2', '-']
			]
		});
	
	this.form_applicable = new Ext.form.ComboBox({
			store		: this.store_applicable
		,	fieldLabel	: 'Applicable'
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.set_form_confirm(record.get('applicable'));
				}
			}
		});
	this.set_form_confirm = function (applicable){
		if (applicable == 0){
			this.form_confirm.setDisabled(true);
			this.form_punchlist.setDisabled(true);
		}
	
	}
		
	this.form_confirm = new Ext.form.ComboBox({
			store		: this.store_confirm
		,	fieldLabel	: 'Confirm'
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});

	this.form_punchlist = new Ext.form.ComboBox({
			store		: this.store_punchlist
		,	fieldLabel	: 'Punchlist'
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
	
	this.btn_submit = new Ext.Button({
		text	:'Submit'
	,	scope	:this
	,	handler	: function() {
			this.do_submit();
		}
	});

	this.panel_form = new Ext.form.FormPanel({
		title		: 'Filter'
	,	autoHeight	:true
	,	buttonAlign	:'center'
	,	buttons		:[
			this.btn_submit
		]
	,	frame		: true
	,	labelWidth	: 150
	,	items		:[
			this.form_applicable
		,	this.form_confirm
		,	this.form_punchlist
		]
	,	labelAlign	:'right'
	,	width		:450
	});
/*
 * Grid
 */
	this.cm = new Ext.grid.ColumnModel({
		columns	:[
			new Ext.grid.RowNumberer()
		,{
			header		:'Nama Item'
		,	dataIndex	:'nama_item_detail_pssr'
		},{
			header		:'Applicable'
		,	dataIndex	:'applicable'
		,	renderer	:store_renderer('id', 'name', this.store_applicable)
		},{
			header		:'Confirm'
		,	dataIndex	:'confirm_ok'
		,	groupable	:true
		,	renderer	:store_renderer('id', 'name', this.store_confirm)
		},{
			header		:'Punchlist'
		,	dataIndex	:'punchlist'
		,	groupable	:true
		,	renderer	:store_renderer('id', 'name', this.store_punchlist)
		}]
	,	defaults	:{
			sortable	:true
		}
	});

	this.summary		= new Ext.ux.grid.GridSummary()
	this.group_summary	= new Ext.ux.grid.GroupSummary();

	this.panel_grid = new Ext.grid.GridPanel({
		store		:this.store
	,	cm			:this.cm
	,	autoHeight	:true
	,	autoWidth	:true
	,	autoScroll	:true
	,	plugins		:[this.summary, this.group_summary]
	,	view		: new Ext.grid.GroupingView({
			hideGroupedColumn	:true
		,	startCollapsed		:true
		,	forceFit			:true
		})
	});
/*
 * main panel
 */
	this.panel = new Ext.Panel({
		title		:'Checklist'
	,	padding		:'6'
	,	autoScroll	:true
	,	defaults	:{
			style		:{
					marginLeft		: 'auto'
				,	marginRight		: 'auto'
				,	marginBottom	: '8px'
			}
		}
	,	items	:[
			this.panel_form
		,	this.panel_grid
		]
	});

	this.do_submit = function()
	{
		this.store.load({
			params	:{
				applicable 	:this.form_applicable.getValue()
			,	confirm_ok	:this.form_confirm.getValue()
			,	punchlist	:this.form_punchlist.getValue()
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.store_applicable.load();
		this.store_confirm.load();
		this.store_punchlist.do_load();
	}
}

 
 function m_pssrLaporan()
 {
	m_pssr_laporan_master	= new m_pssrLaporanMaster('Data PSSR');
	m_pssr_laporan_detail	= new m_pssrLaporanDetail('List Laporan');
	m_pssr_laporan_checklist = new M_pssrLaporanChecklist('Laporan Filter Checklist')
	
	this.panel_depan = new Ext.Panel({
			title		: 'Laporan PSSR'
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_pssr_laporan_master.grid
			,	m_pssr_laporan_detail.grid
			]
	});
	
	this.panel = new Ext.TabPanel({
			id				: 'pssr_laporan_panel'
		,	autoScroll	: true
		,	enableTabScroll	: true
		,	region		: 'center'
		,	activeTab	: 0
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			}
		,	items			: [
				this.panel_depan
			 ,	m_pssr_laporan_checklist.panel
			]
	});
	
	this.do_refresh = function(ha_level)
	{
		m_pssr_laporan_ha_level	= ha_level;

		m_pssr_laporan_master.do_refresh(ha_level);
	}
 }
 
 m_pssr_laporan	= new m_pssrLaporan();
 
 //@ sourceURL=lnk_bulanan.layout.js