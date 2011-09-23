/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_app_frontpage;
var m_app_frontpage_ha;
var m_app_frontpage_d = _g_root +"/module/app_frontpage/";

function M_AppFrontNews()
{
	this.dml_type = 0;
/*
 * grid data
 */
	this.fields = new Ext.data.Record.create([
		{name:'id'}
	,	{name:'date_published'}
	,	{name:'subject'}
	,	{name:'url'}
	,	{name:'content'}
	]);

	this.reader = new Ext.data.JsonReader({
		root:'data'
	}, this.fields);

	this.store = new Ext.data.Store({
		url		:m_app_frontpage_d +'data_news.jsp'
	,	reader	:this.reader
	,	autoLoad:false
	,	idIndex	:'id'
	});

	this.columns = [{
		header		:'Tanggal Diedarkan'
	,	dataIndex	:'date_published'
	,	align		:'center'
	,	width		:140
	},{
		header		:'Subjek'
	,	dataIndex	:'subject'
	,	width		:300
	},{
		header		:'URL'
	,	dataIndex	:'url'
	,	width		:200
	}];

	this.sm = new Ext.grid.RowSelectionModel();

	this.btn_add = new Ext.Button({
		text	:'Tambah'
	,	iconCls	:'add16'
	,	scope	:this
	,	handler	:function() {
			this.do_add();
		}
	});

	this.btn_ref = new Ext.Button({
		text	:'Refresh'
	,	iconCls	:'refresh16'
	,	scope	:this
	,	handler	:function() {
			this.do_load();
		}
	});

	this.btn_edit = new Ext.Button({
		text	:'Ubah'
	,	iconCls	:'edit16'
	,	scope	:this
	,	handler	:function() {
			this.do_edit();
		}
	});

	this.btn_del = new Ext.Button({
		text	:'Hapus'
	,	iconCls	:'del16'
	,	scope	:this
	,	handler	:function() {
			this.do_del();
		}
	});

	this.grid = new Ext.grid.GridPanel({
		store		:this.store
	,	columns		:this.columns
	,	sm			:this.sm
	,	tbar		:[
			this.btn_del
		,	'-'
		,	this.btn_edit
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});
/*
 * form
 */
	this.form_id = new Ext.form.NumberField({
		hidden		:true
	,	name		:'id'
	});

	this.form_date = new Ext.form.DateField({
		fieldLabel	:'Tanggal Pemberitahuan'
	,	name		:'date_published'
	,	format		:'Y-m-d'
	,	emptyText	:'Tahun-Bulan-Hari'
	,	allowBlank	:false
	,	width		:160
	});

	this.form_subject = new Ext.form.TextField({
		fieldLabel	:'Subject'
	,	name		:'subject'
	,	allowBlank	:false
	,	width		:400
	});

	this.form_url = new Ext.form.TextField({
		fieldLabel	:'URL'
	,	name		:'url'
	,	width		:400
	});

	this.form_content = new Ext.form.TextArea({
		fieldLabel	:'Isi'
	,	name		:'content'
	,	width		:400
	,	height		:200
	});

	this.btn_save = new Ext.Button({
		text	:'Simpan'
	,	iconCls	:'save16'
	,	scope	:this
	,	handler	:function() {
			this.do_save();
		}
	});

	this.btn_cancel = new Ext.Button({
		text	:'Batal'
	,	iconCls	:'del16'
	,	scope	:this
	,	handler	:function() {
			this.do_cancel();
		}
	});

	this.form = new Ext.form.FormPanel({
		title		:'Tambah Berita'
	,	labelWidth	:200
	,	labelAlign	:'right'
	,	tbar		:[
			this.btn_cancel
		,	'->'
		,	this.btn_save
		]
	,	items		:[
			this.form_id
		,	this.form_date
		,	this.form_subject
		,	this.form_url
		,	this.form_content
		]
	});
/*
 * main panel
 */
	this.panel = new Ext.Panel({
		title		:'Pengaturan Berita'
	,	layout		:'card'
	,	activeItem	:0
	,	items		:[
			this.grid
		,	this.form
		]
	});
/*
 * function
 */
	this.do_add = function()
	{
		this.form.getForm().reset();

		this.dml_type = 2;
		this.form.setTitle("Tambah Berita");
		this.panel.layout.setActiveItem(1);
	}

	this.do_edit = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		this.dml_type = 3;
		this.form.getForm().loadRecord(r);
		this.form.setTitle("Ubah Berita");
		this.panel.layout.setActiveItem(1);
	}

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		this.dml_type = 4;
		this.form.getForm().loadRecord(r);
		this.do_save();
	}

	this.do_cancel = function()
	{
		this.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		this.form.getForm().doAction('submit', {
			url		:m_app_frontpage_d +'submit.jsp'
		,	scope	:this
		,	params	:{
				dml_type	:this.dml_type
			}
		,	failure	:function(form, action) {
				Ext.Msg.alert("Pesan", action.result.info);
			}
		,	success	:function(form, action) {
				Ext.Msg.alert("Pesan", action.result.info);

				this.panel.layout.setActiveItem(0);
				this.do_load();
			}
		});
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (_g_ha <= 2) {
			this.btn_edit.setDisabled(true);
			this.btn_del.setDisabled(true);
		} else if (_g_ha == 3) {
			this.btn_del.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
			this.btn_del.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AppFrontGallery()
{
	this.dml_type = 0;
/*
 * grid
 */
	this.fields = new Ext.data.Record.create([
		{name:"id"}
	,	{name:"date_uploaded"}
	,	{name:"filename"}
	,	{name:"description"}
	]);

	this.reader = new Ext.data.JsonReader({
		root	:"data"
	}, this.fields);

	this.store = new Ext.data.Store({
		url		:m_app_frontpage_d +"data_gallery.jsp"
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.sm = new Ext.grid.RowSelectionModel();

	this.cm = new Ext.grid.ColumnModel({
		columns	:[{
			header		:"Tanggal Upload"
		,	dataIndex	:"date_uploaded"
		,	align		:"center"
		,	width		:100
		},{
			header		:"Nama file"
		,	dataIndex	:"filename"
		,	width		:240
		},{
			header		:"Keterangan"
		,	dataIndex	:"description"
		,	width		:300
		}]
	});

	this.btn_del = new Ext.Button({
		text	:"Hapus"
	,	iconCls	:"del16"
	,	scope	:this
	,	handler	:function() {
			this.do_del();
		}
	});

	this.btn_edit = new Ext.Button({
		text	:"Ubah"
	,	iconCls	:"edit16"
	,	scope	:this
	,	handler	:function() {
			this.do_edit();
		}
	});

	this.btn_ref = new Ext.Button({
		text	:"Refresh"
	,	iconCls	:"refresh16"
	,	scope	:this
	,	handler	:function() {
			this.do_load();
		}
	});

	this.btn_add = new Ext.Button({
		text	:"Tambah"
	,	iconCls	:"add16"
	,	scope	:this
	,	handler	:function() {
			this.do_add();
		}
	});

	this.grid = new Ext.grid.GridPanel({
		title	:"Gambar"
	,	store	:this.store
	,	sm		:this.sm
	,	cm		:this.cm
	,	tbar	:[
			this.btn_del, '-'
		,	this.btn_edit, '-'
		,	this.btn_ref, '-'
		,	this.btn_add
		]
	});
/*
 * form
 */
	this.btn_back = new Ext.Button({
		text	:"Selesai"
	,	iconCls	:"back16"
	,	scope	:this
	,	handler	:function() {
			this.do_goback();
		}
	});

	this.form_id = new Ext.form.NumberField({
		hidden	:true
	,	name	:"id"
	});

	this.form_filename = new Ext.form.TextField({
		hidden	:true
	,	name	:"filename"
	});

	this.form_upload = new Ext.form.TextField({
		fieldLabel	:"Gambar"
	,	width		:400
	,	inputType	:"file"
	});

	this.form_desc = new Ext.form.TextArea({
		fieldLabel	:"Keterangan"
	,	name		:"description"
	,	width		:400
	});

	this.btn_upload = new Ext.Button({
		text	:"Upload"
	,	iconCls	:"save16"
	,	scope	:this
	,	handler	:function() {
			this.do_upload();
		}
	});

	this.form = new Ext.FormPanel({
		title		:"Tambah Gambar"
	,	fileUpload	:true
	,	padding		:10
	,	labelWidth	:200
	,	labelAlign	:"right"
	,	tbar		:[
			this.btn_back
		]
	,	items		:[
			this.form_id
		,	this.form_filename
		,	this.form_upload
		,	this.form_desc
		]
	,	buttonAlign	:"center"
	,	buttons		:[
			this.btn_upload
		]
	});
/*
 * main panel
 */
	this.panel = new Ext.Panel({
		title		:"Pengaturan Gambar"
	,	layout		:"card"
	,	activeItem	:0
	,	items		:[
			this.grid
		,	this.form
		]
	});
/*
 * functions
 */
	this.do_goback = function()
	{
		this.panel.layout.setActiveItem(0);
		this.do_load();
	}

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		Ext.Ajax.request({
			url		:m_app_frontpage_d +"delete_pic.jsp"
		,	scope	:this
		,	params	:{
				id			:r.get("id")
			,	filename	:r.get("filename")
			}
		,	failure	:function(response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				Ext.Msg.alert('Pesan', msg.info);
			}
		,	success :function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				Ext.Msg.alert('Pesan', msg.info);
				this.do_load();
			}
		});
	}

	this.do_edit = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		this.dml_type = 3;
		this.form.getForm().loadRecord(r);

		this.form.setTitle("Ubah Keterangan Gambar");
		this.form_upload.setDisabled(true);
		this.btn_upload.setText("Simpan");

		this.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		this.dml_type = 2;
		this.form.setTitle("Tambah Gambar");
		this.form_upload.setDisabled(false);
		this.btn_upload.setText("Upload");
		this.do_reset();
		this.panel.layout.setActiveItem(1);
	}

	this.do_upload = function()
	{
		if (this.dml_type != 3 && this.form_upload.getValue() == "") {
			return;
		}

		this.do_save();
	}

	this.do_reset = function()
	{
		this.form_upload.setValue("");
		this.form_desc.setValue("");
	}

	this.do_save = function()
	{
		main_load.show();
		this.btn_back.setDisabled(true);

		this.form.getForm().doAction("submit", {
			url		:m_app_frontpage_d +"submit_pic.jsp"
		,	scope	:this
		,	params	:{
				dml_type	:this.dml_type
			}
		,	failure	:function(form, action) {
				Ext.Msg.alert("Pesan", action.result.info);
				main_load.hide();
				this.btn_back.setDisabled(false);
			}
		,	success	:function(form, action) {
				Ext.Msg.alert("Pesan", action.result.info);

				this.do_reset();
				main_load.hide();
				this.btn_back.setDisabled(false);

				if (this.dml_type == 3) {
					this.panel.layout.setActiveItem(0);
					this.do_load();
				}
				if (this.dml_type == 4) {
					this.do_load();
				}
			}
		});
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (_g_ha <= 0) {
			return;
		}
		if (_g_ha == 1) {
			this.btn_del.setDisabled(true);
			this.btn_add.setDisabled(true);
		} else if (_g_ha == 2 || _g_ha == 3) {
			this.btn_del.setDisabled(true);
			this.btn_add.setDisabled(false);
		} else if (_g_ha == 4) {
			this.btn_del.setDisabled(false);
			this.btn_add.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AppFrontDelay()
{
	this.fields	= new Ext.data.Record.create([
		{name:"chart_delay"}
	,	{name:"gallery_delay"}
	]);

	this.reader = new Ext.data.JsonReader({
		root	:"data"
	}, this.fields);

	this.store = new Ext.data.Store({
		url		:m_app_frontpage_d +"data_delay.jsp"
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.form_cd = new Ext.form.NumberField({
		fieldLabel		:"Chart Delay"
	,	name			:"chart_delay"
	,	allowBlank		:false
	,	allowNegative	:false
	,	allowDecimals	:false
	});

	this.form_gd = new Ext.form.NumberField({
		fieldLabel		:"Gallery Delay"
	,	name			:"gallery_delay"
	,	allowBlank		:false
	,	allowNegative	:false
	,	allowDecimals	:false
	});

	this.btn_save = new Ext.Button({
		text	:"Simpan"
	,	iconCls	:"save16"
	,	scope	:this
	,	handler	:function() {
			this.do_save();
		}
	});

	this.panel = new Ext.form.FormPanel({
		title	:"Pengaturan Delay"
	,	padding	:10
	,	tbar	:[
			this.btn_save
		]
	,	items	:[
			this.form_cd
		,	this.form_gd
		]
	});

	this.do_save = function()
	{
		this.panel.getForm().doAction("submit", {
			url		:m_app_frontpage_d +'submit_delay.jsp'
		,	scope	:this
		,	failure	:function(form, action) {
				Ext.Msg.alert("Pesan", action.result.info);
			}
		,	success	:function(form, action) {
				Ext.Msg.alert("Pesan", action.result.info);
			}
		});
	}

	this.do_load = function()
	{
		this.store.load({
			scope	: this
		,	callback: function(r,options,success) {
				this.panel.getForm().loadRecord(r[0]);
			}
		});
	}

	this.do_refresh = function()
	{
		if (_g_ha <= 0) {
			return;
		}
		if (_g_ha == 1 || _g_ha == 2 || _g_ha == 3) {
			this.btn_save.setDisabled(true);
		} else if (_g_ha == 4) {
			this.btn_save.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AppFrontPage()
{
	this.panel_news = new M_AppFrontNews();
	this.panel_gallery = new M_AppFrontGallery();
	this.panel_delay = new M_AppFrontDelay();

	this.panel = new Ext.TabPanel({
		id			:'app_frontpage_panel'
	,	activeTab	:0
	,	items		:[
			this.panel_news.panel
		,	this.panel_gallery.panel
		,	this.panel_delay.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		this.panel_news.do_refresh();
		this.panel_gallery.do_refresh();
		this.panel_delay.do_refresh();
	}
}

m_app_frontpage = new M_AppFrontPage();

//@ sourceURL=app_frontpage.layout.js
