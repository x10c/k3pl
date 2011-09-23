/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_app_notif;
var m_app_notif_d = _g_root +'/module/app_notif/';

function M_AppNotifSet(title, setting)
{
	this.setting	= setting;

	this.form_active = new Ext.form.Checkbox({
		fieldLabel	:'Aktif'
	,	scope		:this
	,	handler		:function(cb, v) {
			this.form_sender.setDisabled(!v);
			this.form_subject.setDisabled(!v);
			this.form_content.setDisabled(!v);
			this.set_test.setDisabled(!v);
		}
	});

	this.form_sender = new Ext.form.TextField({
		fieldLabel	:'Alamat Pengirim'
	,	vtype		:'email'
	,	vtypeText	:'Format email: nama@domain.tld'
	,	allowBlank	:false
	});

	this.form_subject = new Ext.form.TextField({
		fieldLabel	:'Subjek'
	,	width		:300
	});

	this.form_content = new Ext.form.TextArea({
		fieldLabel	:'Isi'
	,	width		:300
	});

	this.form_test_addr = new Ext.form.TextField({
		fieldLabel	:'Alamat Tujuan'
	,	vtype		:'email'
	,	vtypeText	:'Format email: nama@domain.tld'
	});

	this.btn_test = new Ext.Button({
		text	:'Test'
	,	scope	:this
	,	handler	:function() {
			this.do_test();
		}
	});

	this.form_test = new Ext.form.CompositeField({
		labelAlign	:'right'
	,	labelWidth	:150
	,	items		:[
			this.form_test_addr
		,	this.btn_test
		]
	});

	this.set_test = new Ext.form.FieldSet({
		title		:'Test Notifikasi'
	,	checkboxToggle	:true
	,	collapsed	:true
	,	disabled	:true
	,	items		:[
			this.form_test
		]
	});

	this.set = new Ext.form.FieldSet({
		title		:title
	,	items		:[
			this.form_active
		,	this.form_sender
		,	this.form_subject
		,	this.form_content
		,	this.set_test
		]
	});

	this.do_test = function()
	{
		Ext.Ajax.request({
			params  : {
				email_server		:this.setting.email_server.getValue()
			,	email_server_port	:this.setting.email_server_port.getValue()
			,	email_use_auth		:this.setting.email_use_auth.getValue() == true ? 1 : 0
			,	email_username		:this.setting.email_username.getValue()
			,	email_password		:this.setting.email_password.getValue()

			,	from			:this.form_sender.getValue()
			,	subject			:this.form_subject.getValue()
			,	content			:this.form_content.getValue()
			,	to			:this.form_test_addr.getValue()
			}
		,	url	:m_app_notif_d +'test.jsp'
		,	waitMsg	:'Mohon Tunggu ...'
		,	scope	:this
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					Ext.MessageBox.alert('Pesan', msg.info);
				}
		});
	}
}

function M_AppNotif()
{
	this.store = new Ext.data.Store({
		url		: m_app_notif_d +'data.jsp'
	,	reader		: new Ext.data.JsonReader({
			root	:'r_k3pl'
		,	fields	:[
				{name:'email_server'}
			,	{name:'email_server_port'}
			,	{name:'email_use_auth'}
			,	{name:'email_username'}
			,	{name:'email_password'}

			,	{name:'stop_active'}
			,	{name:'stop_sender'}
			,	{name:'stop_subject'}
			,	{name:'stop_content'}

			,	{name:'rca_active'}
			,	{name:'rca_sender'}
			,	{name:'rca_subject'}
			,	{name:'rca_content'}
			]
		})
	,	autoLoad	:false
	});

	this.email_server = new Ext.form.TextField({
		fieldLabel	:'Email SMTP Server'
	});

	this.email_server_port = new Ext.form.NumberField({
		fieldLabel	:'Email SMTP Port Number'
	,	maxValue	:65535
	,	minValue	:0
	,	value		:25
	,	allowBlank	:false
	});

	this.email_use_auth = new Ext.form.Checkbox({
		fieldLabel	:'Use Authentication'
	,	scope		:this
	,	handler		:function(cb, v) {
			this.email_username.setDisabled(!v);
			this.email_password.setDisabled(!v);
		}
	});

	this.email_username = new Ext.form.TextField({
		fieldLabel	:'Email Username'
	,	disabled	:true
	,	allowBlank	:false
	});

	this.email_password = new Ext.form.TextField({
		fieldLabel	:'Email Password'
	,	inputType	: 'password'
	,	disabled	:true
	,	allowBlank	:false
	});

	this.set_email_setting = new Ext.form.FieldSet({
		title	:'Konfigurasi Email'
	,	items	:[
			this.email_server
		,	this.email_server_port
		,	this.email_use_auth
		,	this.email_username
		,	this.email_password
		]
	});

	this.stop	= new M_AppNotifSet('Konfigurasi Notifikasi STOP', this);
	this.rca	= new M_AppNotifSet('Konfigurasi Notifikasi RCA', this);
/*
 * main panel
 */
	this.btn_save = new Ext.Button({
		text	:'Simpan'
	,	iconCls	:'save16'
	,	scope	:this
	,	handler	:function() {
			this.do_save()
		}
	});

	this.panel = new Ext.Panel({
		title		:'Konfigurasi Notifikasi Email'
	,	id		:'app_notif_panel'
	,	autoScroll	:true
	,	padding		:6
	,	defaults	:{
			labelAlign	:'right'
		,	labelWidth	:160
		}
	,	items		:[
			this.set_email_setting
		,	this.stop.set
		,	this.rca.set
		]
	,	tbar		:[
			this.btn_save
		]
	});

	this.do_save = function()
	{
		main_load.show();

		Ext.Ajax.request({
			params  : {
				email_server		:this.email_server.getValue()
			,	email_server_port	:this.email_server_port.getValue()
			,	email_use_auth		:this.email_use_auth.getValue() == true ? 1 : 0
			,	email_username		:this.email_username.getValue()
			,	email_password		:this.email_password.getValue()

			,	stop_active		:this.stop.form_active.getValue() == true ? 1 : 0
			,	stop_sender		:this.stop.form_sender.getValue()
			,	stop_subject		:this.stop.form_subject.getValue()
			,	stop_content		:this.stop.form_content.getValue()

			,	rca_active		:this.rca.form_active.getValue() == true ? 1 : 0
			,	rca_sender		:this.rca.form_sender.getValue()
			,	rca_subject		:this.rca.form_subject.getValue()
			,	rca_content		:this.rca.form_content.getValue()
			}
		,	url	:m_app_notif_d +'submit.jsp'
		,	waitMsg	:'Mohon Tunggu ...'
		,	scope	:this
		,	failure	: function(response, opts) {
				main_load.hide();
			}
		,	success :
				function (response, opts)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					Ext.MessageBox.alert('Pesan', msg.info);

					main_load.hide();
				}
		});
	}

	this.do_fill_form = function(d)
	{
		var v = (d.get('email_use_auth') == 1) ? true : false;

		this.email_username.setDisabled(!v);
		this.email_password.setDisabled(!v);

		this.email_server.setValue(d.get('email_server'));
		this.email_server_port.setValue(d.get('email_server_port'));
		this.email_use_auth.setValue(v);
		this.email_username.setValue(d.get('email_username'));
		this.email_password.setValue(d.get('email_password'));

		v = (d.get('stop_active') == 1) ? true : false;

		this.stop.form_sender.setDisabled(!v);
		this.stop.form_subject.setDisabled(!v);
		this.stop.form_content.setDisabled(!v);

		this.stop.form_active.setValue(v);
		this.stop.form_sender.setValue(d.get('stop_sender'));
		this.stop.form_subject.setValue(d.get('stop_subject'));
		this.stop.form_content.setValue(d.get('stop_content'));

		v = (d.get('rca_active') == 1) ? true : false;

		this.rca.form_sender.setDisabled(!v);
		this.rca.form_subject.setDisabled(!v);
		this.rca.form_content.setDisabled(!v);

		this.rca.form_active.setValue(v);
		this.rca.form_sender.setValue(d.get('rca_sender'));
		this.rca.form_subject.setValue(d.get('rca_subject'));
		this.rca.form_content.setValue(d.get('rca_content'));
	}

	this.do_load = function()
	{
		this.store.load({
			scope	:this
		,	callback:function(r, options, success) {
				if (!success) {
					return;
				}

				this.do_fill_form(r[0]);
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		if (ha_level < 3) {
			this.btn_save.setDisabled(true);
		} else {
			this.btn_save.setDisabled(false);
		}

		this.do_load();
	}
}

m_app_notif = new M_AppNotif();

//@ sourceURL=app_notif.layout.js
