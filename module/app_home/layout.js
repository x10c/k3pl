/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_app_home;
var m_app_home_d		= _g_root +'/module/app_home/';
var m_obs_data_stop_d	= _g_root +'/module/obs_input_stop/';

function M_HomeLog()
{
	this.store = new Ext.data.ArrayStore({
		url			:m_app_home_d +'data_log.jsp'
	,	fields		:[
			'date'
		,	'user'
		,	'menu'
		,	'stat'
		]
	,	autoLoad	:false
	});

	this.store_stat = new Ext.data.ArrayStore({
		fields		:['id','name']
	,	idIndex		:0
	,	data		:[
			[2, 'Insert']
		,	[3, 'Update']
		,	[4, 'Delete']
		,	[5, 'Login']
		]
	});

	this.store_menu = new Ext.data.ArrayStore({
		fields		:['id','name']
	,	idIndex		:0
	,	url			:m_app_home_d +'data_menu.jsp'
	,	autoLoad	:false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	:[
			new Ext.grid.RowNumberer()
		,{
			header		:'Tanggal'
		,	dataIndex	:'date'
		,	align		:'center'
		,	width		:160
		},{
			header		:'User'
		,	dataIndex	:'user'
		,	width		:180
		},{
			header		:'Nama Menu'
		,	id			:'menu'
		,	dataIndex	:'menu'
		,	width		:240
		,	renderer	:store_renderer("id", "name", this.store_menu)
		},{
			header		:'Status'
		,	dataIndex	:'stat'
		,	align		:'center'
		,	width		:60
		,	renderer	:store_renderer("id", "name", this.store_stat)
		}]
	});

	this.grid = new Ext.grid.GridPanel({
		region				:"center"
	,	store				:this.store
	,	autoScroll	:true
	,	cm					:this.cm
	,	stripeRows			:true
	,	autoExpandColumn	:'menu'
	});
/*
 */
	this.form_date_bgn = new Ext.form.DateField({
		fieldLabel	:"Dari tanggal"
	,	format		:"Y-m-d"
	});

	this.form_date_end = new Ext.form.DateField({
		fieldLabel	:"sampai dengan"
	,	format		:"Y-m-d"
	});

	this.fs_date = new Ext.form.FieldSet({
		title		:"Filter Tanggal"
	,	labelWidth	:120
	,	items		:[
			this.form_date_bgn
		,	this.form_date_end
		]
	});

	this.form_user = new Ext.form.TextField({
		fieldLabel		:"User"
	});

	this.form_menu = new Ext.form.ComboBox({
		fieldLabel		:"Menu"
	,	store			:this.store_menu
	,	valueField		:'id'
	,	displayField	:'name'
	,	triggerAction	:'all'
	,	mode			:'local'
	,	typeAhead		:true
	,	listWidth		:300
	});

	this.form_stat = new Ext.form.ComboBox({
		fieldLabel		:"Status"
	,	store			:this.store_stat
	,	valueField		:'id'
	,	displayField	:'name'
	,	triggerAction	:'all'
	,	mode			:'local'
	,	typeAhead		:true
	});

	this.btn_filter = new Ext.Button({
		text	:"Filter"
	,	iconCls	:"refresh16"
	,	scope	:this
	,	handler	:function() {
			this.do_filter();
		}
	});

	this.form = new Ext.FormPanel({
		title		:"Filter Log"
	,	region		:"north"
	,	labelAlign	:"right"
	,	padding		:10
	,	autoScroll	:true
	,	autoHeight	:true
	,	collapsible	:true
	,	items		:[
			this.fs_date
		,	this.form_user
		,	this.form_menu
		,	this.form_stat
		]
	,	buttonAlign	:"center"
	,	buttons		:[
			this.btn_filter
		]
	});
/*
 * main panel
 */
	this.panel = new Ext.Panel({
		title		:'Sistem Log'
	,	layout		:"border"
	,	items		:[
			this.form
		,	this.grid
		]
	});
/*
 * functions
 */
	this.do_filter = function()
	{
		this.store.load({
			scope	: this
		,	params	: {
				date_bgn	:this.form_date_bgn.getValue()
			,	date_end	:this.form_date_end.getValue()
			,	user		:this.form_user.getValue()
			,	menu		:this.form_menu.getValue()
			,	stat		:this.form_stat.getValue()
			}
		});
	}

	this.do_refresh = function(ha_level) {
		if (ha_level == 4) {
			this.store_menu.load({
				scope		:this
			,	callback	: function(r,o,s) {
					this.store.load();
				}
			});
		}
	}
}

function M_HomeUserObs()
{
	this.store = new Ext.data.ArrayStore({
			url		: m_obs_data_stop_d +'data_list_stop.jsp'
		,	fields	: [
			  'id'
			, 'nipg'
			, 'nama_pegawai'
			, 'date'
			, 'area'
			, 'site'
			, 'shift'
			, 'obs_time'
			, 'n_obs'
			, 'n_dis'
			, 'status_aktif'
			]
		,	autoLoad: false
		});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Tanggal'
		,	dataIndex	: 'date'
		},{
			header		: 'Area'
		,	dataIndex	: 'area'
		,	width		: 240
		},{
			header		: 'Site'
		,	dataIndex	: 'site'
		,	width		: 240
		},{
			header		: 'Shift'
		,	dataIndex	: 'shift'
		,	width		: 120
		},{
			header		: 'Lama Observasi'
		,	dataIndex	: 'obs_time'
		,	width		: 100
		,	align		: 'center'
		},{
			header		: 'Jumlah Orang Diskusi'
		,	dataIndex	: 'n_dis'
		,	width		: 100
		,	align		: 'center'
		},{
			header		: 'Jumlah Orang Diobservasi'
		,	dataIndex	: 'n_obs'
		,	width		: 100
		,	align		: 'center'
		}]
	,	defaults : {
			sortable	: true
		,	width		: 80
		}
	});

	this.panel = new Ext.grid.GridPanel({
			title		: 'Data Observasi Anda'
		,	store		: this.store
		,	cm			: this.cm
		,	autoScroll	: true
		,	height		: 200
		,	style		: {
				marginBottom	:12
			}
	});

	this.do_refresh = function(ha_level) {
		this.store.load({
			params	:{
				load_type	:''
			}
		});
	}
}

function M_HomeUserRCA()
{
	this.record = new Ext.data.Record.create([
			{ name	: 'tanggal_rca'	}
		,	{ name	: 'description' }
		,	{ name	: 'id_severity' }
		,	{ name	: 'status' }
	]);
	
	this.store = new Ext.data.ArrayStore({
			url			: m_app_home_d + 'data_rca.jsp'
		,	fields		: this.record
		,	autoLoad	: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
				new Ext.grid.RowNumberer()
			,	{
					header		: 'Tanggal RCA'
				,	dataIndex	: 'tanggal_rca'
				,	align		: 'center'
				,	width		: 100
				}
			,	{
					id			: 'description'
				,	header		: 'Description'
				,	dataIndex	: 'description'
				}
			,	{
					header		: 'Severity'
				,	dataIndex	: 'id_severity'
				,	align		: 'center'
				,	width		: 100
				}
			,	{
					header		: 'Status'
				,	dataIndex	: 'status'
				,	align		: 'center'
				,	width		: 100
				}
		]
	,	defaults : {
			sortable	: true
		,	hideable	: false
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
	});

	this.panel = new Ext.grid.GridPanel({
			title				: 'Data Risk Containment Audit (RCA)'
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	height				: 200
		,	autoExpandColumn	: 'description'
	});

	this.do_refresh = function()
	{
		this.store.load({
			params	: {
				load_type : ''
			}
		});
	}
}

function M_HomeWinChange(title, form_old_title, form_new_title
							, form_type, url)
{
	this.type	= form_type;
	this.url	= url;

	this.form_old = new Ext.form.TextField({
			fieldLabel	:form_old_title
		,	inputType	:form_type
		,	width		:200
		});

	this.form_new = new Ext.form.TextField({
			fieldLabel	:form_new_title
		,	inputType	:form_type
		,	allowBlank	:false
		,	width		:200
		});

	this.btn_cancel = new Ext.Button({
			text	:'Batal'
		,	iconCls	:'del16'
		,	scope	:this
		,	handler	:function() {
				this.do_cancel();
			}
	});

	this.btn_save = new Ext.Button({
			text		: 'Simpan'
		,	iconCls		: 'save16'
		,	scope		: this
		,	handler		: function() {
				this.do_save();
			}
		});

	this.win = new Ext.Window({
		title		:title
	,	modal		:true
	,	layout		:'form'
	,	labelAlign	:'left'
	,	padding		:6
	,	closable	:false
	,	resizable	:false
	,	plain		:true
	,	autoHeight	:true
	,	width		:350
	,	items		:[
			this.form_old
		,	this.form_new
		]
	,	bbar		: [
			this.btn_cancel, '->'
		,	this.btn_save
		]
	});

	this.do_cancel = function()
	{
		this.win.hide();
	}

	this.is_form_valid = function()
	{
		if (this.type == 'password') {
			if (!this.form_old.isValid()) {
				return false;
			}
		}
		if (!this.form_new.isValid()) {
			return false;
		}
		return true;
	}

	this.do_save = function(record)
	{
		if (!this.is_form_valid()) {
			Ext.Msg.alert('Kesalahan'
, 'Data yang anda inputkan kosong atau tidak sesuai format yang ditentukan!');
			return;
		}

		var lama_v	= this.form_old.getValue();
		var baru_v	= this.form_new.getValue();
		var lama	= ''
		var baru	= '';

		if (this.type == 'password') {
			lama	= Sha256.hash(lama_v);
			baru	= Sha256.hash(baru_v);
		} else {
			lama	= lama_v;
			baru	= baru_v;
		}

		Ext.Ajax.request({
			params  :{
				lama	: lama
			,	baru	: baru
			}
		,	url		:this.url
		,	scope	:this
		,	waitMsg	:'Mohon Tunggu ...'
		,	success :function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan Kesalahan'
							, msg.info);
					return;
				}

				if (this.type == 'email') {
					_g_usermail = baru;
				}

				this.win.hide();
			}
		});
	}
}

function M_Home()
{
	this.win_email = new M_HomeWinChange(
			'User Email Change'
		,	'Old Email'
		,	'New Email'
		,	'email'
		,	m_app_home_d +'submit_change_email.jsp'
		);

	this.win_email.form_old.setReadOnly(true);
	this.win_email.form_new.vtype 		= 'email';
	this.win_email.form_new.vtypeText	= 'Format email: nama@domain.tld';

	this.win_pass = new M_HomeWinChange(
			'User Password Change'
		,	'Old Password'
		,	'New Password'
		,	'password'
		,	m_app_home_d +'submit_change_password.jsp'
		);

	this.panel_log = new M_HomeLog();

	this.data_obs = new M_HomeUserObs();
	
	this.data_rca = new M_HomeUserRCA();

	this.menu = new Ext.menu.Menu({
		items	:[{
			text	:'Change Email Address'
		,	scope	:this
		,	handler	:function (b,e) {
				this.do_change_email()
			}
		},{
			text	:'Change Password'
		,	scope	:this
		,	handler	:function (b,e) {
				this.do_change_password()
			}
		}]
	});

	this.btn_my_account = new Ext.SplitButton({
		text	:'My Account'
	,	menu	: this.menu
	});

	this.panel_home = new Ext.Panel({
		title			:"Home"
	,	padding			:"6"
	,	tbar			:[
			this.btn_my_account
		]
	,	defaults		:{margins:'0 auto 12 auto'}
	,	items			:[
				this.data_obs.panel
			,	this.data_rca.panel
		]
	});

	this.panel = new Ext.TabPanel({
		id				:'app_home_panel'
	,	activeTab		:0
	,	autoScroll		:true
	,	bodyBorder		:false
	,	frame			:false
	,	items			:[
			this.panel_home
		,	this.panel_log.panel
		]
	});

	this.do_change_email = function()
	{
		this.win_email.form_old.setValue(_g_usermail);
		this.win_email.win.show();
	}

	this.do_change_password = function()
	{
		this.win_pass.win.show();
	}

	this.do_refresh = function(ha_level)
	{
		this.data_obs.do_refresh(ha_level);
		this.data_rca.do_refresh();
		this.panel_log.do_refresh(ha_level);
		if (_g_ha < 4) {
			this.panel.hideTabStripItem(1);
		} else {
			this.panel.unhideTabStripItem(1);
		}
		this.panel.setActiveTab(0);
	}
}

m_app_home = new M_Home();

//@ sourceURL=app_home.layout.js
