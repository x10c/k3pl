/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *	 - agus sugianto (agus.delonge@gmail.com)
 */

var m_trx_ptw_cold;
var m_trx_ptw_cold_master;
var m_trx_ptw_cold_master_add;
var	m_trx_ptw_cold_detail_sbak;
var	m_trx_ptw_cold_detail_alat_pelindung_diri;
var	m_trx_ptw_cold_detail_safety_checklist;
var	m_trx_ptw_cold_detail_validasi;

var m_trx_ptw_cold_id_ptw	= '';
var m_trx_ptw_cold_jenis_ptw = '2';
var m_trx_ptw_cold_ha_level	= 0;

var m_trx_ptw_cold_store_jsa = new Ext.data.SimpleStore({
		fields		: ['id','name']
	,	url			: _g_root +'/module/trx_ptw/data_ref_jsa.jsp'
	,	autoLoad	: false
});

function ptw_cold_master_on_select_load_detail()
{
	if (typeof m_trx_ptw_cold_master == 'undefined'
	||  m_trx_ptw_cold_id_ptw == '') {
		return;
	}

	m_trx_ptw_cold_detail_sbak.do_refresh();
	m_trx_ptw_cold_detail_alat_pelindung_diri.do_refresh();
	m_trx_ptw_cold_detail_safety_checklist.do_refresh();
	m_trx_ptw_cold_detail_validasi.do_refresh();
}

function M_TrxPTWColdMasterAdd(title)
{
	this.title 			= title;
	this.dml_type		= 0;
	this.id_ptw			= '';

	this.form_dokumen_pendukung = new Ext.form.ComboBox({
			fieldLabel		: 'Dokumen Pendukung'
		,	store			: m_trx_ptw_cold_store_jsa
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
	});
	
	this.form_nomor = new Ext.form.TextField({
			fieldLabel		: 'Nomor'
		,	width			: 200
	});

	this.form_tanggal_pengesahan = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Pengesahan'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	allowBlank	: false
	});

	this.form_masa_berlaku_awal = new Ext.form.DateField({
			fieldLabel	: 'Masa Berlaku Awal'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	allowBlank	: false
	});

	this.form_masa_berlaku_akhir = new Ext.form.DateField({
			fieldLabel	: 'Masa Berlaku Akhir'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	allowBlank	: false
	});

	this.form_lokasi_pekerjaan = new Ext.form.TextField({
			fieldLabel		: 'Lokasi Pekerjaan'
		,	width			: 200
	});

	this.form_pelaksana_pekerjaan = new Ext.form.TextField({
			fieldLabel		: 'Pelaksana Pekerjaan'
		,	width			: 200
	});

	this.form_uraian_pekerjaan = new Ext.form.TextArea({
			fieldLabel	: 'Uraian Pekerjaan'
		,	width		: 400
	});

	this.form_nama_perusahaan = new Ext.form.TextField({
			fieldLabel		: 'Nama Perusahaan'
		,	width			: 200
	});

	this.form_no_lisensi = new Ext.form.TextField({
			fieldLabel		: 'No. Lisensi'
		,	width			: 200
	});

	this.form_sumber_radioaktif = new Ext.form.TextField({
			fieldLabel		: 'Sumber Radioaktif'
		,	width			: 200
	});

	this.form_proyektor = new Ext.form.TextField({
			fieldLabel		: 'Proyektor'
		,	width			: 200
	});

	this.form_survey_meter = new Ext.form.TextField({
			fieldLabel		: 'Survey Meter'
		,	width			: 200
	});

	this.form_tanggal_service = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Service'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	allowBlank	: false
	});

	this.form_tanggal_kalibrasi = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Kalibrasi'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	allowBlank	: false
	});

	this.form_nama_petugas_isolasi_listrik = new Ext.form.TextField({
			fieldLabel		: 'Nama Petugas Isolasi Listrik'
		,	width			: 200
	});

	this.form_jabatan_petugas_isolasi_listrik = new Ext.form.TextField({
			fieldLabel		: 'Jabatan Petugas Isolasi Listrik'
		,	width			: 200
	});

	this.form_nama_petugas_uji_kandungan_gas = new Ext.form.TextField({
			fieldLabel		: 'Nama Petugas Uji Kandungan Gas'
		,	width			: 200
	});

	this.form_jabatan_petugas_uji_kandungan_gas = new Ext.form.TextField({
			fieldLabel		: 'Jabatan Petugas Uji Kandungan Gas'
		,	width			: 200
	});

	this.form_nama_pelaksana_pekerjaan = new Ext.form.TextField({
			fieldLabel		: 'Nama Pelaksana Pekerjaan'
		,	width			: 200
	});

	this.form_jabatan_pelaksana_pekerjaan = new Ext.form.TextField({
			fieldLabel		: 'Jabatan Pelaksana Pekerjaan'
		,	width			: 200
	});

	this.form_nama_pejabat_berwenang = new Ext.form.TextField({
			fieldLabel		: 'Nama Pejabat Berwenang'
		,	width			: 200
	});

	this.form_jabatan_pejabat_berwenang = new Ext.form.TextField({
			fieldLabel		: 'Jabatan Pejabat Berwenang'
		,	width			: 200
	});

	this.form_catatan = new Ext.form.TextArea({
			fieldLabel	: 'Catatan'
		,	width		: 400
	});
	
	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_dokumen_pendukung
				,	this.form_nomor
				,	this.form_tanggal_pengesahan
				,	this.form_masa_berlaku_awal
				,	this.form_masa_berlaku_akhir
				,	this.form_lokasi_pekerjaan
				,	this.form_pelaksana_pekerjaan
				,	this.form_uraian_pekerjaan
				,	this.form_nama_pelaksana_pekerjaan
				,	this.form_jabatan_pelaksana_pekerjaan
				,	this.form_nama_pejabat_berwenang
				,	this.form_jabatan_pejabat_berwenang
				,	this.form_catatan
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

	this.is_valid = function()
	{
		if (!this.form_dokumen_pendukung.isValid()) {
			return false;
		}

		if (!this.form_tanggal_pengesahan.isValid()) {
			return false;
		}

		if (!this.form_masa_berlaku_awal.isValid()) {
			return false;
		}

		if (!this.form_masa_berlaku_akhir.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_trx_ptw_cold.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
			url	: _g_root +'/module/trx_ptw/submit_ptw_master.jsp'
		,	params	: {
					dml_type							: this.dml_type
				,	id_jsa								: this.form_dokumen_pendukung.getValue()
				,	id_ptw								: m_trx_ptw_cold_id_ptw
				,	jenis_ptw							: m_trx_ptw_cold_jenis_ptw
				,	nomor								: this.form_nomor.getValue()
				,	tgl_pengesahan						: this.form_tanggal_pengesahan.getValue()
				,	masa_berlaku_awal					: this.form_masa_berlaku_awal.getValue()
				,	masa_berlaku_akhir					: this.form_masa_berlaku_akhir.getValue()
				,	lokasi_pekerjaan					: this.form_lokasi_pekerjaan.getValue()
				,	pelaksana_pekerjaan					: this.form_pelaksana_pekerjaan.getValue()
				,	uraian_pekerjaan					: this.form_uraian_pekerjaan.getValue()
				,	nama_perusahaan						: this.form_nama_perusahaan.getValue()
				,	no_lisensi							: this.form_no_lisensi.getValue()
				,	sumber_radioaktif					: this.form_sumber_radioaktif.getValue()
				,	proyektor							: this.form_proyektor.getValue()
				,	survey_meter						: this.form_survey_meter.getValue()
				,	tanggal_service						: this.form_tanggal_service.getValue()
				,	tanggal_kalibrasi					: this.form_tanggal_kalibrasi.getValue()
				,	nama_petugas_isolasi_listrik		: this.form_nama_petugas_isolasi_listrik.getValue()
				,	jabatan_petugas_isolasi_listrik		: this.form_jabatan_petugas_isolasi_listrik.getValue()
				,	nama_petugas_uji_kandungan_gas		: this.form_nama_petugas_uji_kandungan_gas.getValue()
				,	jabatan_petugas_uji_kandungan_gas	: this.form_jabatan_petugas_uji_kandungan_gas.getValue()
				,	nama_pelaksana_pekerjaan			: this.form_nama_pelaksana_pekerjaan.getValue()
				,	jabatan_pelaksana_pekerjaan			: this.form_jabatan_pelaksana_pekerjaan.getValue()
				,	nama_pejabat_berwenang				: this.form_nama_pejabat_berwenang.getValue()
				,	jabatan_pejabat_berwenang			: this.form_jabatan_pejabat_berwenang.getValue()
				,	catatan								: this.form_catatan.getValue()			
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

				m_trx_ptw_cold_master.store.reload();
				m_trx_ptw_cold.panel.layout.setActiveItem(0);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		this.form_dokumen_pendukung.setValue('');
		this.form_nomor.setValue('');
		this.form_tanggal_pengesahan.setValue('');
		this.form_masa_berlaku_awal.setValue('');
		this.form_masa_berlaku_akhir.setValue('');
		this.form_lokasi_pekerjaan.setValue('');
		this.form_pelaksana_pekerjaan.setValue('');
		this.form_uraian_pekerjaan.setValue('');
		this.form_nama_perusahaan.setValue('');
		this.form_no_lisensi.setValue('');
		this.form_sumber_radioaktif.setValue('');
		this.form_proyektor.setValue('');
		this.form_survey_meter.setValue('');
		this.form_tanggal_service.setValue('');
		this.form_tanggal_kalibrasi.setValue('');
		this.form_nama_petugas_isolasi_listrik.setValue('');
		this.form_jabatan_petugas_isolasi_listrik.setValue('');
		this.form_nama_petugas_uji_kandungan_gas.setValue('');
		this.form_jabatan_petugas_uji_kandungan_gas.setValue('');
		this.form_nama_pelaksana_pekerjaan.setValue('');
		this.form_jabatan_pelaksana_pekerjaan.setValue('');
		this.form_nama_pejabat_berwenang.setValue('');
		this.form_jabatan_pejabat_berwenang.setValue('');
		this.form_catatan.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_dokumen_pendukung.setValue(data.id_jsa);
		this.form_nomor.setValue(data.nomor);
		this.form_tanggal_pengesahan.setValue(data.tgl_pengesahan);
		this.form_masa_berlaku_awal.setValue(data.masa_berlaku_awal);
		this.form_masa_berlaku_akhir.setValue(data.masa_berlaku_akhir);
		this.form_lokasi_pekerjaan.setValue(data.lokasi_pekerjaan);
		this.form_pelaksana_pekerjaan.setValue(data.pelaksana_pekerjaan);
		this.form_uraian_pekerjaan.setValue(data.uraian_pekerjaan);
		this.form_nama_perusahaan.setValue(data.nama_perusahaan);
		this.form_no_lisensi.setValue(data.no_lisensi);
		this.form_sumber_radioaktif.setValue(data.sumber_radioaktif);
		this.form_proyektor.setValue(data.proyektor);
		this.form_survey_meter.setValue(data.survey_meter);
		this.form_tanggal_service.setValue(data.tanggal_service);
		this.form_tanggal_kalibrasi.setValue(data.tanggal_kalibrasi);
		this.form_nama_petugas_isolasi_listrik.setValue(data.nama_petugas_isolasi_listrik);
		this.form_jabatan_petugas_isolasi_listrik.setValue(data.jabatan_petugas_isolasi_listrik);
		this.form_nama_petugas_uji_kandungan_gas.setValue(data.nama_petugas_uji_kandungan_gas);
		this.form_jabatan_petugas_uji_kandungan_gas.setValue(data.jabatan_petugas_uji_kandungan_gas);
		this.form_nama_pelaksana_pekerjaan.setValue(data.nama_pelaksana_pekerjaan);
		this.form_jabatan_pelaksana_pekerjaan.setValue(data.jabatan_pelaksana_pekerjaan);
		this.form_nama_pejabat_berwenang.setValue(data.nama_pejabat_berwenang);
		this.form_jabatan_pejabat_berwenang.setValue(data.jabatan_pejabat_berwenang);
		this.form_catatan.setValue(data.catatan);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url	: _g_root +'/module/trx_ptw/data_ptw_master.jsp'
		,	params	: {
				id_ptw	: id
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

	this.do_refresh = function()
	{
		if (m_trx_ptw_cold_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input data JSA!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}
	}
}

function M_TrxPTWColdMaster(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_jsa'
		},{
			name	: 'id_ptw'
		},{
			name	: 'jenis_ptw'
		},{
			name	: 'nomor'
		},{
			name	: 'tgl_pengesahan'
		},{
			name	: 'masa_berlaku_awal'
		},{
			name	: 'masa_berlaku_akhir'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/trx_ptw_cold/data_list_ptw_cold_master.jsp'
		,	autoLoad: false
	});

	this.form_dokumen_pendukung = new Ext.form.ComboBox({
			store			: m_trx_ptw_cold_store_jsa
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_jsa'
			, header	: 'Dokumen Pendukung'
			, dataIndex	: 'id_jsa'
			, width		: 200
			, renderer	: combo_renderer(this.form_dokumen_pendukung)
			}
		,	{ id		: 'nomor'
			, header	: 'Nomor'
			, dataIndex	: 'nomor'
			, sortable	: true
			, width		: 150
			}
		,	{ id		: 'tgl_pengesahan'
			, header	: 'Tanggal Pengesahan'
			, dataIndex	: 'tgl_pengesahan'
			, sortable	: true
			, width		: 100
			, align		: 'center'
			}
		,	{ id		: 'masa_berlaku_awal'
			, header	: 'Masa Berlaku Awal'
			, dataIndex	: 'masa_berlaku_awal'
			, sortable	: true
			, width		: 100
			, align		: 'center'
			}
		,	{ id		: 'masa_berlaku_akhir'
			, header	: 'Masa Berlaku Akhir'
			, dataIndex	: 'masa_berlaku_akhir'
			, sortable	: true
			, width		: 100
			, align		: 'center'
			}
		]
	,	defaults	: {
			hideable	: false
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_trx_ptw_cold_id_ptw = data[0].data['id_ptw'];
						this.btn_print.setDisabled(false);
					} else {
						m_trx_ptw_cold_id_ptw = '';
						this.btn_print.setDisabled(true);
					}

					ptw_cold_master_on_select_load_detail();
				}
			}
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
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
			this.btn_edit
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		,	'->'
		,	this.btn_print
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
	});

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_trx_ptw_cold_master_add.do_edit(data.get('id_ptw'));
		m_trx_ptw_cold.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		m_trx_ptw_cold_master_add.do_add();
		m_trx_ptw_cold.panel.layout.setActiveItem(1);
	}

	this.do_print = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		var form;
		form = document.createElement('form');

		form.setAttribute('method', 'post');
		form.setAttribute('target', '_blank');
		form.setAttribute('action', _g_root +'/module/lap_ptw/export_cwp.jsp');

		var id_ptw = document.createElement('input');
		id_ptw.setAttribute('type', 'hidden');
		id_ptw.setAttribute('name', 'id_ptw');
		id_ptw.setAttribute('value', data.get('id_ptw'));

		form.appendChild(id_ptw);
		form.submit();
	}

	this.do_load = function()
	{
		var load_type = 'user';
		
		if (m_trx_ptw_cold_ha_level == 4) {
			load_type = 'all';
		}

		this.store.load({
			params		: {
				jenis_ptw	: m_trx_ptw_cold_jenis_ptw
			,	load_type	: load_type
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_trx_ptw_cold_ha_level <= 1) {
			this.btn_edit.setDisabled(true);
			this.btn_add.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
			this.btn_add.setDisabled(false);
		}

		this.do_load();
	}
}

function M_TrxPTWColdDetailSBAK(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_ptw'
		},{
			name	: 'id_sbak_ptw'
		},{
			name	: 'id_sbak_ptw_old'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: _g_root +'/module/trx_ptw/data_ptw_detail_sbak.jsp'
		,	autoLoad: false
		});

	this.store_sbak_ptw = new Ext.data.SimpleStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/trx_ptw/data_ref_sbak.jsp'
		,	autoLoad: false
		,	idIndex	: 0
		});

	this.form_sbak_ptw = new Ext.form.ComboBox({
			store			: this.store_sbak_ptw
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
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_sbak_ptw'
			, header	: 'Sumber Bahaya Alat/Kegiatan'
			, dataIndex	: 'id_sbak_ptw'
			, width		: 300
			, editor	: this.form_sbak_ptw
			, renderer	: combo_renderer(this.form_sbak_ptw)
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_trx_ptw_cold_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	plugins				: [this.editor]
		,	tbar				: this.toolbar
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_add = function()
	{
		if (m_trx_ptw_cold_id_ptw == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu PTW Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_ptw 		: m_trx_ptw_cold_id_ptw
			,	id_sbak_ptw	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id_ptw			: record.data['id_ptw']
			,	id_sbak_ptw		: record.data['id_sbak_ptw']
			,	id_sbak_ptw_old	: record.data['id_sbak_ptw_old']
			,   dml_type		: this.dml_type
			}
		,	url	: _g_root +'/module/trx_ptw/submit_ptw_detail_sbak.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_trx_ptw_cold_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_sbak_ptw.load({
			callback	: function(){
				this.store.load({
					params		: {
						id_ptw	: m_trx_ptw_cold_id_ptw
					}
				});
			}
		,	scope		: this	
		});
	}

	this.do_refresh = function()
	{
		if (m_trx_ptw_cold_ha_level < 2) {
			this.btn_add.setDisabled(true);
			this.btn_del.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
			this.btn_del.setDisabled(false);
		}
		
		this.do_load();
	}
}

function M_TrxPTWColdDetailAlatPelindungDiri(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_ptw'
		},{
			name	: 'id_alat_pelindung_diri_ptw'
		},{
			name	: 'id_alat_pelindung_diri_ptw_old'
		},{
			name	: 'keterangan'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/trx_ptw/data_ptw_detail_alat_pelindung_diri.jsp'
		,	autoLoad: false
		});

	this.store_alat_pelindung_diri_ptw = new Ext.data.SimpleStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/trx_ptw/data_ref_alat_pelindung_diri.jsp'
		,	autoLoad: false
		,	idIndex	: 0
		});

	this.form_alat_pelindung_diri_ptw = new Ext.form.ComboBox({
			store			: this.store_alat_pelindung_diri_ptw
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
	
	this.form_keterangan = new Ext.form.TextField({});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_alat_pelindung_diri_ptw'
			, header	: 'Alat Pelindung Diri'
			, dataIndex	: 'id_alat_pelindung_diri_ptw'
			, width		: 300
			, editor	: this.form_alat_pelindung_diri_ptw
			, renderer	: combo_renderer(this.form_alat_pelindung_diri_ptw)
			}
		,	{ id		: 'keterangan'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan'
			, width		: 300
			, editor	: this.form_keterangan
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_trx_ptw_cold_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	plugins				: [this.editor]
		,	tbar				: this.toolbar
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
		});

	this.do_add = function()
	{
		if (m_trx_ptw_cold_id_ptw == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu PTW Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_ptw 						: m_trx_ptw_cold_id_ptw
			,	id_alat_pelindung_diri_ptw	: ''
			, 	keterangan					: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id_ptw							: record.data['id_ptw']
			,	id_alat_pelindung_diri_ptw		: record.data['id_alat_pelindung_diri_ptw']
			,	id_alat_pelindung_diri_ptw_old	: record.data['id_alat_pelindung_diri_ptw_old']
			,	keterangan						: record.data['keterangan']
			,   dml_type						: this.dml_type
			}
		,	url	: _g_root +'/module/trx_ptw/submit_ptw_detail_alat_pelindung_diri.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_trx_ptw_cold_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_alat_pelindung_diri_ptw.load({
			callback	: function(){
				this.store.load({
					params		: {
						id_ptw	: m_trx_ptw_cold_id_ptw
					}
				});			
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_trx_ptw_cold_ha_level < 2) {
			this.btn_add.setDisabled(true);
			this.btn_del.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
			this.btn_del.setDisabled(false);
		}
		
		this.do_load();
	}
}

function M_TrxPTWColdDetailSafetyChecklist(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_ptw'
		},{
			name	: 'id_safety_checklist_ptw'
		},{
			name	: 'id_safety_checklist_ptw_old'
		},{
			name	: 'status'
		},{
			name	: 'keterangan'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/trx_ptw/data_ptw_detail_safety_checklist.jsp'
		,	autoLoad: false
		});

	this.store_safety_checklist_ptw = new Ext.data.SimpleStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/trx_ptw/data_ref_safety_checklist.jsp'
		,	autoLoad: false
		,	idIndex	: 0
		});

	this.store_status = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	data	: [
				['0', 'Tidak']
			,	['1', 'Ya']
		]
		});

	this.form_safety_checklist_ptw = new Ext.form.ComboBox({
			store			: this.store_safety_checklist_ptw
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
	
	this.form_status = new Ext.form.ComboBox({
			store			: this.store_status
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
	
	this.form_keterangan = new Ext.form.TextField({});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_safety_checklist_ptw'
			, header	: 'Item'
			, dataIndex	: 'id_safety_checklist_ptw'
			, width		: 450
			, editor	: this.form_safety_checklist_ptw
			, renderer	: combo_renderer(this.form_safety_checklist_ptw)
			}
		,	{ id		: 'status'
			, header	: 'Status'
			, dataIndex	: 'status'
			, align		: 'center'
			, width		: 100
			, editor	: this.form_status
			, renderer	: combo_renderer(this.form_status)
			}
		,	{ id		: 'keterangan'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan'
			, editor	: this.form_keterangan
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_trx_ptw_cold_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	plugins				: [this.editor]
		,	autoExpandColumn	: 'keterangan'
		,	tbar				: this.toolbar
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_add = function()
	{
		if (m_trx_ptw_cold_id_ptw == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu PTW Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_ptw 					: m_trx_ptw_cold_id_ptw
			,	id_safety_checklist_ptw	: ''
			,	status					: ''
			, 	keterangan				: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id_ptw						: record.data['id_ptw']
			,	id_safety_checklist_ptw		: record.data['id_safety_checklist_ptw']
			,	id_safety_checklist_ptw_old	: record.data['id_safety_checklist_ptw_old']
			,	status						: record.data['status']
			,	keterangan					: record.data['keterangan']
			,   dml_type					: this.dml_type
			}
		,	url	: _g_root +'/module/trx_ptw/submit_ptw_detail_safety_checklist.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_trx_ptw_cold_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_safety_checklist_ptw.load({
			callback	: function(){
				this.store.load({
					params		: {
						id_ptw	: m_trx_ptw_cold_id_ptw
					}
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_trx_ptw_cold_ha_level < 2) {
			this.btn_add.setDisabled(true);
			this.btn_del.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
			this.btn_del.setDisabled(false);
		}
		
		this.do_load();
	}
}

function M_TrxPTWColdDetailValidasi(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_ptw'
		},{
			name	: 'id_ptw_validasi'
		},{
			name	: 'hari'
		},{
			name	: 'waktu_mulai'
		},{
			name	: 'waktu_selesai'
		},{
			name	: 'nama_pelaksana'
		},{
			name	: 'inisial_pelaksana'
		},{
			name	: 'nama_pengawas'
		},{
			name	: 'inisial_pengawas'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/trx_ptw/data_ptw_detail_validasi.jsp'
		,	autoLoad: false
		});

	this.form_hari = new Ext.form.TextField({
		allowBlank	: false
	});
	
	this.form_waktu_mulai = new Ext.form.TextField({});
	
	this.form_waktu_selesai = new Ext.form.TextField({});
	
	this.form_nama_pelaksana = new Ext.form.TextField({});
	
	this.form_inisial_pelaksana = new Ext.form.TextField({});
	
	this.form_nama_pengawas = new Ext.form.TextField({});
	
	this.form_inisial_pengawas = new Ext.form.TextField({});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'hari'
			, header	: 'Hari'
			, dataIndex	: 'hari'
			, width		: 100
			, editor	: this.form_hari
			}
		,	{ id		: 'waktu_mulai'
			, header	: 'Waktu Mulai'
			, dataIndex	: 'waktu_mulai'
			, width		: 100
			, editor	: this.form_waktu_mulai
			}
		,	{ id		: 'waktu_selesai'
			, header	: 'Waktu Selesai'
			, dataIndex	: 'waktu_selesai'
			, width		: 100
			, editor	: this.form_waktu_selesai
			}
		,	{ id		: 'nama_pelaksana'
			, header	: 'Nama Pelaksana'
			, dataIndex	: 'nama_pelaksana'
			, width		: 200
			, editor	: this.form_nama_pelaksana
			}
		,	{ id		: 'inisial_pelaksana'
			, header	: 'Inisial Pelaksana'
			, dataIndex	: 'inisial_pelaksana'
			, width		: 75
			, editor	: this.form_inisial_pelaksana
			}
		,	{ id		: 'nama_pengawas'
			, header	: 'Nama Pengawas'
			, dataIndex	: 'nama_pengawas'
			, width		: 200
			, editor	: this.form_nama_pengawas
			}
		,	{ id		: 'inisial_pengawas'
			, header	: 'Inisial Pengawas'
			, dataIndex	: 'inisial_pengawas'
			, width		: 75
			, editor	: this.form_inisial_pengawas
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_trx_ptw_cold_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	plugins				: [this.editor]
		,	tbar				: this.toolbar
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_add = function()
	{
		if (m_trx_ptw_cold_id_ptw == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu PTW Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_ptw 				: m_trx_ptw_cold_id_ptw
			,	id_ptw_validasi		: ''
			, 	hari				: ''
			, 	waktu_mulai			: ''
			, 	waktu_selesai		: ''
			, 	nama_pelaksana		: ''
			, 	inisial_pelaksana	: ''
			, 	nama_pengawas		: ''
			, 	inisial_pengawas	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id_ptw				: record.data['id_ptw']
			,	id_ptw_validasi		: record.data['id_ptw_validasi']
			,	hari				: record.data['hari']
			,	waktu_mulai			: record.data['waktu_mulai']
			,	waktu_selesai		: record.data['waktu_selesai']
			,	nama_pelaksana		: record.data['nama_pelaksana']
			,	inisial_pelaksana	: record.data['inisial_pelaksana']
			,	nama_pengawas		: record.data['nama_pengawas']
			,	inisial_pengawas	: record.data['inisial_pengawas']
			,   dml_type			: this.dml_type
			}
		,	url	: _g_root +'/module/trx_ptw/submit_ptw_detail_validasi.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_trx_ptw_cold_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_ptw	: m_trx_ptw_cold_id_ptw
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_trx_ptw_cold_ha_level < 2) {
			this.btn_add.setDisabled(true);
			this.btn_del.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
			this.btn_del.setDisabled(false);
		}
		
		this.do_load();
	}
}

function M_TrxPTWCold()
{
	m_trx_ptw_cold_master						= new M_TrxPTWColdMaster('Cold Work Permit');
	m_trx_ptw_cold_master_add					= new M_TrxPTWColdMasterAdd('Entry / Edit Data Cold Work Permit');
	m_trx_ptw_cold_detail_sbak					= new M_TrxPTWColdDetailSBAK('Sumber Bahaya Alat/Kegiatan');
	m_trx_ptw_cold_detail_alat_pelindung_diri	= new M_TrxPTWColdDetailAlatPelindungDiri('Alat Pelindung Diri');
	m_trx_ptw_cold_detail_safety_checklist		= new M_TrxPTWColdDetailSafetyChecklist('Safety Checklist');
	m_trx_ptw_cold_detail_validasi				= new M_TrxPTWColdDetailValidasi('Validasi');

	this.panel_ptw_cold_detail = new Ext.TabPanel({
			autoScroll		: true
		,	enableTabScroll	: true
		,	region			: 'center'
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    		}
		,	items			: [
				m_trx_ptw_cold_detail_sbak.grid
			,	m_trx_ptw_cold_detail_alat_pelindung_diri.grid
			,	m_trx_ptw_cold_detail_safety_checklist.grid
			,	m_trx_ptw_cold_detail_validasi.grid
			]
	});
	
	this.panel_ptw_cold = new Ext.Panel({
			layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_trx_ptw_cold_master.grid
			,	this.panel_ptw_cold_detail
			]
	});

	this.panel = new Ext.Panel({
			id				: 'trx_ptw_cold_panel'
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				this.panel_ptw_cold
			,	m_trx_ptw_cold_master_add.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_trx_ptw_cold_ha_level	= ha_level;
		m_trx_ptw_cold_id_ptw 	= '';
		
		m_trx_ptw_cold_store_jsa.load();
		
		m_trx_ptw_cold_master.do_refresh();
	}
}

m_trx_ptw_cold = new M_TrxPTWCold();

//@ sourceURL=trx_ptw_cold.layout.js
