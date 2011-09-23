/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 *   - m.shulhan (ms@kilabit.org)
 */

var m_trx_insiden;
var m_ref_org_d			= _g_root +'/module/ref_organisasi/';
var m_trx_insiden_d		= _g_root +'/module/trx_insiden/';
var m_ref_klas_pegawai_d	= _g_root +'/module/ref_klas_pegawai/';

function M_TrxInsidenInput()
{
	this.ha_level	= 0;
	this.dml_type	= 0;
	this.id_insiden	= '';

	this.store_area = new Ext.data.ArrayStore({
		fields		: ['id', 'name']
	,	url			: m_trx_insiden_d +'data_area.jsp'
	,	autoLoad	: false
	});

	this.store_klas = new Ext.data.ArrayStore({
		fields	: ['id','name']
	,	url		: m_ref_klas_pegawai_d +'data.jsp'
	,	autoLoad: false
	});

	/*
	 * Data Insiden
	 */
	this.form_area = new Ext.form.ComboBox({
		fieldLabel	: 'Lokasi Insiden'
	,	store		: this.store_area
	,	valueField	: 'id'
	,	displayField	: 'name'
	,	editable	: false
	,	mode		: 'local'
	,	triggerAction	: 'all'
	,	width		: 300
	});

	this.form_klas = new Ext.form.ComboBox({
		fieldLabel	: 'Klasifikasi Pegawai'
	,	store		: this.store_klas
	,	valueField	: 'id'
	,	displayField	: 'name'
	,	editable	: false
	,	mode		: 'local'
	,	triggerAction	: 'all'
	,	width		: 300
	});

	this.form_tanggal = new Ext.form.DateField({
		fieldLabel	: 'Tanggal Insiden'
	,	emptyText	: 'Tahun-Bulan-Tanggal'
	,	format		: 'Y-m-d'
	,	allowBlank	: false
	,	editable	: false
	,	width		: 200
	});

	this.form_uraian = new Ext.form.TextArea({
		fieldLabel	: 'Uraian Peristiwa Insiden'
	,	width		: 400
	,	height		: 100
	});

	this.set_data_insiden = {
		xtype		: 'fieldset'
	,	labelWidth	: 220
	,	items		: [
			this.form_area
		,	this.form_klas
		,	this.form_tanggal
		,	this.form_uraian
		]
	}

	/*
	 * Kecelakaan
	 */
	this.form_jml_korban_mati = new Ext.form.NumberField({
		fieldLabel	: 'Kematian'
	});

	this.form_jml_korban_berat = new Ext.form.NumberField({
		fieldLabel	: 'Kecelakaan Berat (cacat permanen)'
	});

	this.form_jml_korban_sedang = new Ext.form.NumberField({
		fieldLabel	: 'Kecelakaan Sedang'
	});

	this.form_jml_hari_kerja_hilang = new Ext.form.NumberField({
		fieldLabel	: 'Hari Kerja Hilang'
	});

	this.form_jml_korban_dampak = new Ext.form.NumberField({
		fieldLabel	: 'Jumlah Kejadian Dampak Akibat Kecelakaan'
	});

	this.form_jml_korban_medis = new Ext.form.NumberField({
		fieldLabel	: 'Jumlah Pengobatan Medis'
	});

	this.form_jml_korban_p3k = new Ext.form.NumberField({
		fieldLabel	: 'P3K'
	});

	this.form_jml_hampir_celaka = new Ext.form.NumberField({
		fieldLabel	: 'Hampir Celaka'
	});

	this.form_bakar_ledak_bocor = new Ext.form.NumberField({
		fieldLabel	: 'Kebakaran / Ledakan / Kebocoran'
	});


	this.set_kecelakaan = {
		xtype		: 'fieldset'
	,	labelWidth	: 300
	,	title		: 'Kecelakaan'
	,	autoHeight	: true
	,	defaults	: {
			allowDecimals	: false
		,	allowNegative	: false
		,	allowBlank	: false
		,	msgTarget	: 'side'
		,	value		: 0
		,	minValue	: 0
		,	width		: 50
		}
	,	items		: [
			this.form_jml_korban_mati
		,	this.form_jml_korban_berat
		,	this.form_jml_korban_sedang
		,	this.form_jml_hari_kerja_hilang
		,	this.form_jml_korban_dampak
		,	this.form_jml_korban_medis
		,	this.form_jml_korban_p3k
		,	this.form_jml_hampir_celaka
		,	this.form_bakar_ledak_bocor
		]
	};

	/*
	 * Kerusakan
	 */
	this.form_jml_rusak_jaringan = new Ext.form.NumberField({
		fieldLabel	: 'Kerusakan Jaringan'
	});

	this.form_jml_rusak_bangunan = new Ext.form.NumberField({
		fieldLabel	: 'Kerusakan Bangunan'
	});

	this.form_jml_rusak_kendaraan = new Ext.form.NumberField({
		fieldLabel	: 'Kerusakan Kendaraan'
	});

	this.form_jml_rusak_lain = new Ext.form.NumberField({
		fieldLabel	: 'Kerusakan Lainnya'
	});

	this.form_nilai_jaringan = new Ext.form.NumberField({
		fieldLabel	: 'Nilai (Rp)'
	});

	this.form_nilai_bangunan = new Ext.form.NumberField({
		fieldLabel	: 'Nilai (Rp)'
	});

	this.form_nilai_kendaraan = new Ext.form.NumberField({
		fieldLabel	: 'Nilai (Rp)'
	});

	this.form_nilai_lain = new Ext.form.NumberField({
		fieldLabel	: 'Nilai (Rp)'
	});

	this.set_kerusakan = {
		xtype		: 'fieldset'
	,	title		: 'Kerusakan'
	,	autoHeight	: true
	,	layout		: 'column'
	,	labelWidth	: 180
	,	items		: [{
			columnWidth	: .4
		,	layout		: 'form'
		,	border		: false
		,	bodyCssClass	: 'stop-panel-form'
		,	defaults	: {
				allowDecimals	: false
			,	allowNegative	: false
			,	allowBlank	: false
			,	msgTarget	: 'side'
			,	value		: 0
			,	minValue	: 0
			,	width		: 50
			}
		,	items		: [
				this.form_jml_rusak_jaringan
			,	this.form_jml_rusak_bangunan
			,	this.form_jml_rusak_kendaraan
			,	this.form_jml_rusak_lain
			]
		},{
			columnWidth	: .6
		,	layout		: 'form'
		,	border		: false
		,	bodyCssClass	: 'stop-panel-form'
		,	defaults	: {
				allowNegative	: false
			,	msgTarget	: 'side'
			,	allowBlank	: false
			,	value		: 0
			,	minValue	: 0
			,	width		: 180
			,	format		: '000,000,000,000.00'
			}
		,	items		: [
				this.form_nilai_jaringan
			,	this.form_nilai_bangunan
			,	this.form_nilai_kendaraan
			,	this.form_nilai_lain
			]
		}]
	};

	/*
	 * Lainnya
	 */
	this.form_jml_pencemaran_lingkungan = new Ext.form.NumberField({
		fieldLabel	: 'Pencemaran Lingkungan'
	});

	this.form_jml_kecelakaan_kendaraan = new Ext.form.NumberField({
		fieldLabel	: 'Kecelakaan Kendaraan'
	});

	this.form_jml_kejadian_keamanan = new Ext.form.NumberField({
		fieldLabel	: 'Kejadian Keamanan'
	});

	this.set_misc = {
		xtype		: 'fieldset'
	,	title		: 'Lainnya'
	,	flex		: 1
	,	labelWidth	: 180
	,	defaults	: {
			allowDecimals	: false
		,	allowNegative	: false
		,	allowBlank	: false
		,	msgTarget	: 'side'
		,	value		: 0
		,	minValue	: 0
		,	width		: 50
		}
	,	items	: [
			this.form_jml_pencemaran_lingkungan
		,	this.form_jml_kecelakaan_kendaraan
		,	this.form_jml_kejadian_keamanan
		]
	}

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

	this.set_kecelakaan_misc = {
		xtype	: 'container'
	,	layout	: 'hbox'
	,	items	: [
			this.set_kecelakaan
		,	this.set_misc
		]
	};

	this.panel = new Ext.form.FormPanel({
			title		: 'Input Data Insiden'
		,	autoScroll	: true
		,	autoWidth	: true
		,	labelAlign	: 'right'
		,	bodyCssClass	: 'stop-panel-form'
		,	tbar		: [
				this.btn_cancel
			,	'->'
			,	this.btn_save
			]
		,	items			: [
				this.set_data_insiden
			,	this.set_kecelakaan_misc
			,	this.set_kerusakan
			]
	});

	this.do_load_area = function()
	{
		this.store_area.load({
			callback: function() {
				var record = this.store_area.getAt(0);

				if (record) {
					this.form_area.setValue(record.get('id'));
				}
			}
		,	scope	: this
		});
	}

	this.do_load_klas = function()
	{
		this.store_klas.load({
			callback: function() {
				var record = this.store_klas.getAt(0);

				if (record) {
					this.form_klas.setValue(record.get('id'));
				}
			}
		,	scope	: this
		});
	}

	this.is_valid = function()
	{
		if (!this.form_tanggal.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_trx_insiden.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
			url	: m_trx_insiden_d +'submit.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	params	: {
				dml_type			: this.dml_type
			,	id_insiden			: this.id_insiden
			,	id_area_seksi			: this.form_area.getValue()
			,	id_klas				: this.form_klas.getValue()
			,	tanggal				: this.form_tanggal.getValue()
			,	uraian				: this.form_uraian.getValue()

			,	jml_korban_mati			: this.form_jml_korban_mati.getValue()
			,	jml_korban_berat		: this.form_jml_korban_berat.getValue()
			,	jml_korban_sedang		: this.form_jml_korban_sedang.getValue()
			,	jml_hari_kerja_hilang		: this.form_jml_hari_kerja_hilang.getValue()
			,	jml_korban_dampak		: this.form_jml_korban_dampak.getValue()
			,	jml_korban_medis		: this.form_jml_korban_medis.getValue()
			,	jml_korban_p3k			: this.form_jml_korban_p3k.getValue()
			,	jml_hampir_celaka		: this.form_jml_hampir_celaka.getValue()
			,	jml_bakar_ledak_bocor		: this.form_bakar_ledak_bocor.getValue()

			,	jml_rusak_jaringan		: this.form_jml_rusak_jaringan.getValue()
			,	jml_rusak_bangunan		: this.form_jml_rusak_bangunan.getValue()
			,	jml_rusak_kendaraan		: this.form_jml_rusak_kendaraan.getValue()
			,	jml_rusak_lain			: this.form_jml_rusak_lain.getValue()
			,	nilai_rusak_jaringan		: this.form_nilai_jaringan.getValue()
			,	nilai_rusak_bangunan		: this.form_nilai_bangunan.getValue()
			,	nilai_rusak_kendaraan		: this.form_nilai_kendaraan.getValue()
			,	nilai_rusak_lain		: this.form_nilai_lain.getValue()

			,	jml_pencemaran_lingkungan	: this.form_jml_pencemaran_lingkungan.getValue()
			,	jml_kecelakaan_kendaraan	: this.form_jml_kecelakaan_kendaraan.getValue()
			,	jml_kejadian_keamanan		: this.form_jml_kejadian_keamanan.getValue()
			}
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

				m_trx_insiden.store.reload();
				m_trx_insiden.panel.layout.setActiveItem(0);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		var record = this.store_area.getAt(0);

		if (record) {
			this.form_area.setValue(record.get('id'));
		}

		record = this.store_klas.getAt(0);
		if (record) {
			this.form_klas.setValue(record.get('id'));
		}

		this.form_tanggal.setValue('');
		this.form_uraian.setValue('');

		this.form_jml_korban_mati.setValue(0);
		this.form_jml_korban_berat.setValue(0);
		this.form_jml_korban_sedang.setValue(0);
		this.form_jml_hari_kerja_hilang.setValue(0);
		this.form_jml_korban_dampak.setValue(0);
		this.form_jml_korban_medis.setValue(0);
		this.form_jml_korban_p3k.setValue(0);
		this.form_jml_hampir_celaka.setValue(0);
		this.form_bakar_ledak_bocor.setValue(0);

		this.form_jml_rusak_jaringan.setValue(0);
		this.form_jml_rusak_bangunan.setValue(0);
		this.form_jml_rusak_kendaraan.setValue(0);
		this.form_jml_rusak_lain.setValue(0);

		this.form_nilai_jaringan.setValue(0);
		this.form_nilai_bangunan.setValue(0);
		this.form_nilai_kendaraan.setValue(0);
		this.form_nilai_lain.setValue(0);

		this.form_jml_pencemaran_lingkungan.setValue(0);
		this.form_jml_kecelakaan_kendaraan.setValue(0);
		this.form_jml_kejadian_keamanan.setValue(0);
	}

	this.do_add = function()
	{
		this.do_reset();
		this.id_insiden	= '';
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_area.setValue(data.id_area_seksi);
		this.form_klas.setValue(data.id_klasifikasi_pegawai);
		this.form_tanggal.setValue(data.tanggal);
		this.form_uraian.setValue(data.uraian);

		this.form_jml_korban_mati.setValue(data.jml_korban_mati);
		this.form_jml_korban_berat.setValue(data.jml_korban_berat);
		this.form_jml_korban_sedang.setValue(data.jml_korban_sedang);
		this.form_jml_hari_kerja_hilang.setValue(data.jml_hari_kerja_hilang);
		this.form_jml_korban_dampak.setValue(data.jml_korban_dampak);
		this.form_jml_korban_medis.setValue(data.jml_korban_medis);
		this.form_jml_korban_p3k.setValue(data.jml_korban_p3k);
		this.form_jml_hampir_celaka.setValue(data.jml_hampir_celaka);
		this.form_bakar_ledak_bocor.setValue(data.jml_bakar_ledak_bocor);

		this.form_jml_rusak_jaringan.setValue(data.jml_rusak_jaringan);
		this.form_jml_rusak_bangunan.setValue(data.jml_rusak_bangunan);
		this.form_jml_rusak_kendaraan.setValue(data.jml_rusak_kendaraan);
		this.form_jml_rusak_lain.setValue(data.jml_rusak_lain);

		this.form_nilai_jaringan.setValue(data.nilai_rusak_jaringan);
		this.form_nilai_bangunan.setValue(data.nilai_rusak_bangunan);
		this.form_nilai_kendaraan.setValue(data.nilai_rusak_kendaraan);
		this.form_nilai_lain.setValue(data.nilai_rusak_lain);

		this.form_jml_pencemaran_lingkungan.setValue(data.jml_pencemaran_lingkungan);
		this.form_jml_kecelakaan_kendaraan.setValue(data.jml_kecelakaan_kendaraan);
		this.form_jml_kejadian_keamanan.setValue(data.jml_kejadian_keamanan);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;
		this.id_insiden	= id;

		Ext.Ajax.request({
			url	: m_trx_insiden_d +'data_insiden.jsp'
		,	params	: {
				id: id
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
, 'Maaf, Anda tidak memiliki hak akses untuk input data insiden!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load_area();
		this.do_load_klas();
	}
}

function M_TrxInsiden()
{
	this.ha_level = 0;

	this.store = new Ext.data.ArrayStore({
			fields	: [
			  'id'
			, 'tanggal'
			, 'nama_area'
			, 'nama_klas'
			]
		,	url	: m_trx_insiden_d +'data_list_insiden.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Tanggal Insiden'
		,	dataIndex	: 'tanggal'
		,	width		: 120
		},{
			header		: 'Lokasi Insiden'
		,	dataIndex	: 'nama_area'
		,	width		: 160
		},{
			header		: 'Klasifikasi'
		,	dataIndex	: 'nama_klas'
		,	width		: 160
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
			title		: 'Data Insiden'
		,	store		: this.store
		,	cm		: this.cm
		,	sm		: this.sm
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

	this.panel_add = new M_TrxInsidenInput();

	this.panel = new Ext.Container({
			id		: 'trx_insiden_panel'
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
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

		this.panel_add.do_edit(data.get('id'));
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
			, 'Maaf, Anda tidak memiliki hak akses untuk Data Insiden!');
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

m_trx_insiden = new M_TrxInsiden();

//@ sourceURL=trx_insiden.layout.js
