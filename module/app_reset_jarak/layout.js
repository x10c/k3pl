/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_app_reset_jarak;
var m_app_reset_jarak_d = _g_root +'/module/app_reset_jarak/';

function M_AppResetJamKerja()
{
	this.ha_level = 0;

	this.fields = [
		{name: 'id'}
	,	{name: 'tanggal'}
	,	{name: 'nama_area'}
	,	{name: 'nama_klas'}
	,	{name: 'jml_kecelakaan_kendaraan'}
	,	{name: 'status_reset_jarak'}
	];

	this.store = new Ext.data.SimpleStore({
		fields	: this.fields
	,	url	: m_app_reset_jarak_d +'data.jsp'
	,	autoLoad: false
	});

	this.form_cb_reset = new Ext.form.Checkbox({
	});

	this.columns = [
		new Ext.grid.RowNumberer()
	,{
		header		: 'Tanggal Insiden'
	,	dataIndex	: 'tanggal'
	},{
		header		: 'Lokasi Insiden'
	,	dataIndex	: 'nama_area'
	},{
		header		: 'Klasifikasi'
	,	dataIndex	: 'nama_klas'
	},{
		header		: 'Jumlah Kecelakaan Kendaraan'
	,	dataIndex	: 'jml_kecelakaan_kendaraan'
	},{
		header		: 'Status Reset'
	,	dataIndex	: 'status_reset_jarak'
	,	editor		: this.form_cb_reset
	,	renderer	: checkbox_renderer(this.ck_status, 'Aktif', '-')
	}];

	this.cm = new Ext.grid.ColumnModel({
		columns	: this.columns
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		});

	this.editor = new MyRowEditor(this);

	this.btn_refresh = new Ext.Button({
		text	: 'Refresh'
	,	iconCls	: 'refresh16'
	,	scope	: this
	,	handler	: function() {
			this.do_refresh(this.ha_level);
		}
	});

	this.panel = new Ext.grid.GridPanel({
		title		: 'Reset Jarak Tempuh'
	,	id		: 'app_reset_jarak_panel'
	,	store		: this.store
	,	cm		: this.cm
	,	plugins		: this.editor
	,	viewConfig	: {forceFit: true}
	,	tbar		: [
			this.btn_refresh
		]
	,       listeners       : {
			scope		: this
		,	rowdblclick	:
				function (g, r, e) {
					return this.do_edit(r);
				}
		}
	});

	this.do_edit = function()
	{
		if (this.ha_level >= 3) {
			return true;
		}
		return false;
	}

	this.do_cancel = function()
	{
	}

	this.do_save = function(record)
	{
		var state = 0;

		if (record.data['status_reset']) {
			state = 1;
		}

		Ext.Ajax.request({
			url	: m_app_reset_jarak_d +'submit.jsp'
		,	params	: {
				id_insiden	: record.data['id']
			,	state		: state
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				Ext.MessageBox.alert('Informasi', msg.info);
				this.do_load();
			}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses'
			, 'Maaf, Anda tidak memiliki hak akses untuk Data Observasi!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (ha_level < 3) {
			this.form_cb_reset.setDisabled(true);
		} else {
			this.form_cb_reset.setDisabled(false);
		}

		this.do_load();
	}
}

m_app_reset_jarak = new M_AppResetJamKerja();

//@ sourceURL=app_reset_jarak.layout.js
