/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_trx_pengelolaan_lingkungan;

function M_InputPengelolaanLingkungan(title)
{
	this.title 						= title;
	this.ha_level					= 0;
	this.dml_type					= 0;
	this.id_pengelolaan_lingkungan	= '';

	this.store_wilayah = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: _g_root +'/module/trx_pengelolaan_lingkungan/data_wilayah.jsp'
		,	autoLoad	: false
	});

	this.form_wilayah = new Ext.form.ComboBox({
			fieldLabel		: 'Wilayah'
		,	store			: this.store_wilayah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 300
	});

	this.form_tanggal_pengelolaan_lingkungan = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Pengelolaan Lingkungan'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 200
	});

	this.form_lokasi_pengelolaan_lingkungan = new Ext.form.TextField({
			fieldLabel	: 'Lokasi Pengelolaan Lingkungan'
		,	allowBlank	: false
		,	width		: 300
		,	msgTarget	: 'side'
	});

	this.form_tipe_station = new Ext.form.TextField({
			fieldLabel	: 'Tipe Station'
		,	allowBlank	: false
		,	width		: 300
		,	msgTarget	: 'side'
	});

	this.form_parameter = new Ext.form.TextField({
			fieldLabel	: 'Parameter Yang Diambil'
		,	allowBlank	: false
		,	width		: 300
		,	msgTarget	: 'side'
	});

	this.form_sumber_dampak = new Ext.form.TextField({
			fieldLabel	: 'Sumber Dampak'
		,	allowBlank	: false
		,	width		: 300
		,	msgTarget	: 'side'
	});
	
	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 220
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
				this.form_wilayah
			,	this.form_tanggal_pengelolaan_lingkungan
			,	this.form_lokasi_pengelolaan_lingkungan
			,	this.form_tipe_station
			,	this.form_parameter
			,	this.form_sumber_dampak
			]
	});

	this.btn_cancel = new Ext.Button({
			text	: 'Batal'
		,	iconCls	: 'del16'
		,	scope	: this
		,	handler	: function() {
				this.do_cancel();
			}
	});

	this.btn_save	= new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
	});

	this.panel = new Ext.Panel({
			title		: this.title
		,	autoScroll	: true
		,	buttonAlign	: 'center'
		,	tbar		: [
				this.btn_cancel
			,	'->'
			,	this.btn_save
			]
		,	items		: [
				this.panel_user
			]
	});

	this.do_load_wilayah = function()
	{
		this.store_wilayah.load({
			callback: function() {
				var record = this.store_wilayah.getAt(0);

				if (record) {
					this.form_wilayah.setValue(record.get('id'));
				}
			}
		,	scope	: this
		});
	}

	this.is_valid = function()
	{
		if (!this.form_wilayah.isValid()) {
			return false;
		}

		if (!this.form_tanggal_pengelolaan_lingkungan.isValid()) {
			return false;
		}

		if (!this.form_lokasi_pengelolaan_lingkungan.isValid()) {
			return false;
		}

		if (!this.form_tipe_station.isValid()) {
			return false;
		}

		if (!this.form_parameter.isValid()) {
			return false;
		}

		if (!this.form_sumber_dampak.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_trx_pengelolaan_lingkungan.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
			url	: _g_root +'/module/trx_pengelolaan_lingkungan/submit.jsp'
		,	params	: {
				dml_type						: this.dml_type
			,	id_pengelolaan_lingkungan		: this.id_pengelolaan_lingkungan
			,	id_wilayah						: this.form_wilayah.getValue()
			,	tanggal_pengelolaan_lingkungan	: this.form_tanggal_pengelolaan_lingkungan.getValue()
			,	lokasi_pengelolaan_lingkungan	: this.form_lokasi_pengelolaan_lingkungan.getValue()
			,	tipe_station					: this.form_tipe_station.getValue()
			,	parameter						: this.form_parameter.getValue()
			,	sumber_dampak					: this.form_sumber_dampak.getValue()
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

				m_trx_pengelolaan_lingkungan.store.reload();
				m_trx_pengelolaan_lingkungan.panel.layout.setActiveItem(0);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		var record = this.store_wilayah.getAt(0);

		if (record) {
			this.form_wilayah.setValue(record.get('id'));
		}

		this.form_tanggal_pengelolaan_lingkungan.setValue('');
		this.form_lokasi_pengelolaan_lingkungan.setValue('');
		this.form_tipe_station.setValue('');
		this.form_parameter.setValue('');
		this.form_sumber_dampak.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_wilayah.setValue(data.id_wilayah);
		this.form_tanggal_pengelolaan_lingkungan.setValue(data.tanggal_pengelolaan_lingkungan);
		this.form_lokasi_pengelolaan_lingkungan.setValue(data.lokasi_pengelolaan_lingkungan);
		this.form_tipe_station.setValue(data.tipe_station);
		this.form_parameter.setValue(data.parameter);
		this.form_sumber_dampak.setValue(data.sumber_dampak);
	}

	this.do_edit = function(id)
	{
		this.dml_type					= 3;
		this.id_pengelolaan_lingkungan	= id;

		Ext.Ajax.request({
			url	: _g_root +'/module/trx_pengelolaan_lingkungan/data_pengelolaan_lingkungan.jsp'
		,	params	: {
				id_pengelolaan_lingkungan: id
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.edit_fill_form(msg);
			}
		,	scope	: this
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses'
, 'Maaf, Anda tidak memiliki hak akses untuk input data pengelolaan lingkungan!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load_wilayah();
	}
}

function M_TrxPengelolaanLingkungan()
{
	this.ha_level = 0;

	this.store = new Ext.data.ArrayStore({
			fields	: [
			  'id_pengelolaan_lingkungan'
			, 'nama_wilayah'
			, 'tanggal_pengelolaan_lingkungan'
			, 'lokasi_pengelolaan_lingkungan'
			, 'tipe_station'
			]
		,	url	: _g_root +'/module/trx_pengelolaan_lingkungan/data_list_pengelolaan_lingkungan.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Wilayah'
		,	dataIndex	: 'nama_wilayah'
		,	width		: 160
		},{
			header		: 'Tanggal'
		,	dataIndex	: 'tanggal_pengelolaan_lingkungan'
		,	width		: 180
		},{
			header		: 'Lokasi'
		,	dataIndex	: 'lokasi_pengelolaan_lingkungan'
		,	width		: 120
		},{
			header		: 'Tipe Station'
		,	dataIndex	: 'tipe_station'
		,	width		: 120
		}]
	,	defaults : {
			sortable	: true
		,	hideable	: false
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.btn_edit = new Ext.Button({
			text		: 'Ubah'
		,	iconCls		: 'edit16'
		,	scope		: this
		,	handler		: function() {
				this.do_edit();
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

	this.btn_add = new Ext.Button({
			text		: 'Tambah'
		,	iconCls		: 'add16'
		,	scope		: this
		,	handler		: function() {
				this.do_add();
			}
	});

	this.panel_list = new Ext.grid.GridPanel({
			title		: 'Data Pengelolaan Lingkungan'
		,	store		: this.store
		,	cm			: this.cm
		,	sm			: this.sm
		,	autoScroll	: true
		,	viewConfig	: {
				forceFit: true
			}
		,	tbar		: [
				this.btn_edit, '-'
			,	this.btn_ref, '-'
			,	this.btn_add
			]
	});

	this.panel_add = new M_InputPengelolaanLingkungan('Input Data Pengelolaan Lingkungan');

	this.panel = new Ext.Container({
			id			: 'trx_pengelolaan_lingkungan_panel'
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
		,	autoWidth	: true
		,	autoScroll	: true
		,	items		: [
				this.panel_list
			,	this.panel_add.panel
			]
	});

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		this.panel_add.do_edit(data.get('id_pengelolaan_lingkungan'));
		this.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		this.panel_add.do_add();
		this.panel.layout.setActiveItem(1);
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses'
			, 'Maaf, Anda tidak memiliki hak akses untuk Data Pengelolaan Lingkungan!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.store.load();
		this.panel_add.do_refresh(this.ha_level);
	}
}

m_trx_pengelolaan_lingkungan = new M_TrxPengelolaanLingkungan();

//@ sourceURL=trx_pengelolaan_lingkungan.layout.js
