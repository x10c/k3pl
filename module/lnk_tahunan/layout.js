/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

 var m_lnk_tahunan;
 var m_lnk_tahunan_pemantauan;
 var m_lnk_tahunan_pemantauan_master_list;
 var m_lnk_tahunan_pemantauan_master_add;
 var m_lnk_tahunan_pemantauan_detail_list;
 var m_lnk_tahunan_pemantauan_detail_add;
 var m_lnk_tahunan_pengelolaan;
 var m_lnk_tahunan_pengelolaan_master_list;
 var m_lnk_tahunan_pengelolaan_master_add;
 var m_lnk_tahunan_pengelolaan_detail_list;
 var m_lnk_tahunan_pengelolaan_detail_add;
 var m_lnk_tahunan_d = _g_root +'/module/lnk_tahunan/';
 var m_lnk_tahunan_id_lingkungan_tahunan_pemantauan		= '';
 var m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan	= '';
 var m_lnk_tahunan_id_komponen_lingkungan_pemantauan	= '';
 var m_lnk_tahunan_id_komponen_lingkungan_pengelolaan	= '';
 var m_lnk_tahunan_ha_level = 0;
 
 function m_lnk_tahunan_pemantauan_master_on_select_load_detail()
 {
 	if (typeof m_lnk_tahunan_pemantauan_master_list == 'undefined'
	||  m_lnk_tahunan_id_lingkungan_tahunan_pemantauan == '') {
		return;
	}

	m_lnk_tahunan_pemantauan_detail_list.do_refresh();
 }

 function m_lnk_tahunan_pengelolaan_master_on_select_load_detail()
 {
 	if (typeof m_lnk_tahunan_pengelolaan_master_list == 'undefined'
	||  m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan == '') {
		return;
	}

	m_lnk_tahunan_pengelolaan_detail_list.do_refresh();
 }
 
 function M_LNKTahunanPemantauanMasterAdd()
 {
 	this.dml_type				= 0;
	this.id_lingkungan_tahunan	= '';
	this.id_seksi				= 0;
	this.id_dinas				= 0;
	this.id_departemen			= 0;

	this.form_satuan_kerja_on_select = function(record)
	{
		this.id_seksi		= record.get('id_seksi');
		this.id_dinas 		= record.get('id_dinas');
		this.id_departemen	= record.get('id_departemen');
	}

	this.store_satuan_kerja = new Ext.data.ArrayStore({
			fields		: ['id_seksi','id_dinas','id_departemen','nama_seksi']
		,	url			: m_lnk_tahunan_d +'data_ref_satuan_kerja.jsp'
		,	autoLoad	: false
	});

	this.form_satuan_kerja = new Ext.form.ComboBox({
			fieldLabel		: 'Satuan Kerja'
		,	store			: this.store_satuan_kerja
		,	valueField		: 'id_seksi'
		,	displayField	: 'nama_seksi'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 300
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_satuan_kerja_on_select(record);
				}
		}
	});

	this.form_proyek = new Ext.form.TextArea({
			fieldLabel	: 'Proyek/Kegiatan/Aktifitas'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_dikompilasi_oleh = new Ext.form.TextField({
			fieldLabel	: 'Dikompilasi Oleh'
		,	allowBlank	: false
		,	width		: 300
	});

	this.form_tanggal_kompilasi = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Kompilasi'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 150
	});

	this.form_disetujui_oleh = new Ext.form.TextField({
			fieldLabel	: 'Disetujui Oleh'
		,	allowBlank	: false
		,	width		: 300
	});

	this.form_tanggal_disetujui = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Disetujui'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 150
	});

	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 150
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_satuan_kerja
				,	this.form_proyek
				,	this.form_dikompilasi_oleh
				,	this.form_tanggal_kompilasi
				,	this.form_disetujui_oleh
				,	this.form_tanggal_disetujui
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
		if (!this.form_satuan_kerja.isValid()) {
			return false;
		}

		if (!this.form_proyek.isValid()) {
			return false;
		}

		if (!this.form_dikompilasi_oleh.isValid()) {
			return false;
		}

		if (!this.form_tanggal_kompilasi.isValid()) {
			return false;
		}

		if (!this.form_disetujui_oleh.isValid()) {
			return false;
		}

		if (!this.form_tanggal_disetujui.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_lnk_tahunan_pemantauan.panel_master.layout.setActiveItem(0);
		m_lnk_tahunan_pemantauan.panel_detail.setDisabled(false);
		m_lnk_tahunan.panel.unhideTabStripItem(1);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		main_load.show();
		
		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'submit_master_pemantauan.jsp'
		,	params	: {
					dml_type					: this.dml_type
				,	id_lingkungan_tahunan		: m_lnk_tahunan_id_lingkungan_tahunan_pemantauan
				,	id_seksi					: this.id_seksi
				,	id_dinas					: this.id_dinas
				,	id_departemen				: this.id_departemen
				,	tipe_kegiatan_lingkungan	: 1
				,	proyek_kegiatan_aktifitas	: this.form_proyek.getValue()
				,	dikompilasi_oleh			: this.form_dikompilasi_oleh.getValue()
				,	tanggal_kompilasi			: this.form_tanggal_kompilasi.getValue()
				,	disetujui_oleh				: this.form_disetujui_oleh.getValue()	
				,	tanggal_disetujui			: this.form_tanggal_disetujui.getValue()	
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				main_load.hide();
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				main_load.hide();
				
				Ext.MessageBox.alert('Informasi', msg.info);

				m_lnk_tahunan_pemantauan_master_list.store.reload();
				m_lnk_tahunan_pemantauan.panel_master.layout.setActiveItem(0);
				m_lnk_tahunan_pemantauan.panel_detail.setDisabled(false);
				m_lnk_tahunan.panel.unhideTabStripItem(1);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		this.form_satuan_kerja.setValue('');
		this.form_proyek.setValue('');
		this.form_dikompilasi_oleh.setValue('');
		this.form_tanggal_kompilasi.setValue('');
		this.form_disetujui_oleh.setValue('');
		this.form_tanggal_disetujui.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_satuan_kerja.setValue(data.id_seksi);
		this.id_dinas = data.id_dinas;
		this.id_departemen = data.id_departemen;
		this.form_proyek.setValue(data.proyek_kegiatan_aktifitas);
		this.form_dikompilasi_oleh.setValue(data.dikompilasi_oleh);
		this.form_tanggal_kompilasi.setValue(data.tanggal_kompilasi);
		this.form_disetujui_oleh.setValue(data.disetujui_oleh);
		this.form_tanggal_disetujui.setValue(data.tanggal_disetujui);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'data_master_pemantauan.jsp'
		,	params	: {
				id_lingkungan_tahunan	: id
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

	this.do_load = function()
	{
		this.store_satuan_kerja.load();
	}

	this.do_refresh = function()
	{
		if (m_lnk_tahunan_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input Data Pengelolaan Lingkungan!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
 }
 
 function M_LNKTahunanPemantauanMasterList()
 {
 	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_lingkungan_tahunan' }
		,	{ name	: 'satuan_kerja' }
		,	{ name	: 'proyek' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_lnk_tahunan_d +'data_master_pemantauan_list.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{	
			header		: 'Satuan Kerja'
		,	dataIndex	: 'satuan_kerja'
		,	width		: 300
		},{
			id			: 'proyek'
		,	header		: 'Proyek / Kegiatan / Aktifitas'
		,	dataIndex	: 'proyek'
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
						m_lnk_tahunan_id_lingkungan_tahunan_pemantauan = data[0].data['id_lingkungan_tahunan'];
					} else {
						m_lnk_tahunan_id_lingkungan_tahunan_pemantauan = '';
					}

					m_lnk_tahunan_pemantauan_master_on_select_load_detail();
				}
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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
			text		: 'Tambah'
		,	iconCls		: 'add16'
		,	scope		: this
		,	handler		: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_edit
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			region				: 'center'
		,	height				: 200
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'proyek'
	});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'submit_master_pemantauan.jsp'
		,	params	: {
				dml_type					: 4
			,	id_lingkungan_tahunan		: data.get('id_lingkungan_tahunan')
			,	id_seksi					: ''
			,	id_dinas					: ''
			,	id_departemen				: ''
			,	tipe_kegiatan_lingkungan	: ''
			,	proyek_kegiatan_aktifitas	: ''
			,	dikompilasi_oleh			: ''
			,	tanggal_kompilasi			: ''
			,	disetujui_oleh				: ''
			,	tanggal_disetujui			: ''
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

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_lnk_tahunan_pemantauan_master_add.do_refresh();
		m_lnk_tahunan_pemantauan_master_add.do_edit(data.get('id_lingkungan_tahunan'));
		m_lnk_tahunan_pemantauan.panel_master.layout.setActiveItem(1);
		m_lnk_tahunan_pemantauan.panel_detail.setDisabled(true);
		m_lnk_tahunan.panel.hideTabStripItem(1);
	}

	this.do_add = function()
	{
		m_lnk_tahunan_pemantauan_master_add.do_refresh();
		m_lnk_tahunan_pemantauan_master_add.do_add();
		m_lnk_tahunan_pemantauan.panel_master.layout.setActiveItem(1);
		m_lnk_tahunan_pemantauan.panel_detail.setDisabled(true);
		m_lnk_tahunan.panel.hideTabStripItem(1);
	}

	this.do_load = function()
	{
		var load_type = 'user';

		if (m_lnk_tahunan_ha_level == 4) {
			load_type = 'all';
		}

		this.store.load({
			params	: {
				load_type : load_type
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_lnk_tahunan_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data Pengelolaan Lingkungan!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_lnk_tahunan_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_lnk_tahunan_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_lnk_tahunan_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
 }
 
 function M_LNKTahunanPemantauanDetailAdd()
 {
  	this.dml_type				= 0;

	this.store_komponen_lingkungan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_lnk_tahunan_d +'data_ref_komponen_lingkungan.jsp'
		,	autoLoad	: false
	});

	this.form_komponen_lingkungan = new Ext.form.ComboBox({
			fieldLabel		: 'Komponen Lingkungan'
		,	store			: this.store_komponen_lingkungan
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

	this.form_lokasi_dampak = new Ext.form.TextField({
			fieldLabel	: 'Lokasi'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_jenis_dampak = new Ext.form.TextField({
			fieldLabel	: 'Jenis'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_sumber_dampak = new Ext.form.TextField({
			fieldLabel	: 'Sumber'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_parameter_pemantauan = new Ext.form.TextField({
			fieldLabel	: 'Parameter'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_baku_mutu_pemantauan = new Ext.form.TextField({
			fieldLabel	: 'Baku Mutu'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_periode_pemantauan = new Ext.form.TextField({
			fieldLabel	: 'Periode'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_hasil_pemantauan = new Ext.form.TextArea({
			fieldLabel	: 'Hasil'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_penanggung_jawab = new Ext.form.TextField({
			fieldLabel	: 'Penanggung Jawab'
		,	allowBlank	: false
		,	width		: 400
	});

	this.set_komponen_lingkungan = {
			xtype		: 'fieldset'
		,	labelWidth	: 150
		,	items		: [
				this.form_komponen_lingkungan
			]
	};

	this.set_identifikasi_dampak = {
			xtype		: 'fieldset'
		,	title		: 'Identifikasi Dampak'
		,	labelWidth	: 150
		,	items		: [
				this.form_lokasi_dampak
			,	this.form_jenis_dampak
			,	this.form_sumber_dampak
			]		
	};

	this.set_pemantauan_lingkungan = {
			xtype		: 'fieldset'
		,	title		: 'Pemantauan Lingkungan'
		,	labelWidth	: 150
		,	items		: [
				this.form_parameter_pemantauan
			,	this.form_baku_mutu_pemantauan
			,	this.form_periode_pemantauan
			,	this.form_hasil_pemantauan
			]		
	};

	this.set_penanggung_jawab = {
			xtype		: 'fieldset'
		,	labelWidth	: 150
		,	items		: [
				this.form_penanggung_jawab
			]
	};
	
	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.set_komponen_lingkungan
				,	this.set_identifikasi_dampak
				,	this.set_pemantauan_lingkungan
				,	this.set_penanggung_jawab
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
		if (!this.form_komponen_lingkungan.isValid()) {
			return false;
		}

		if (!this.form_lokasi_dampak.isValid()) {
			return false;
		}

		if (!this.form_jenis_dampak.isValid()) {
			return false;
		}

		if (!this.form_sumber_dampak.isValid()) {
			return false;
		}

		if (!this.form_parameter_pemantauan.isValid()) {
			return false;
		}

		if (!this.form_baku_mutu_pemantauan.isValid()) {
			return false;
		}

		if (!this.form_periode_pemantauan.isValid()) {
			return false;
		}

		if (!this.form_hasil_pemantauan.isValid()) {
			return false;
		}

		if (!this.form_penanggung_jawab.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_lnk_tahunan_pemantauan.panel_detail.layout.setActiveItem(0);
		m_lnk_tahunan_pemantauan.panel_master.setDisabled(false);
		m_lnk_tahunan.panel.unhideTabStripItem(1);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		main_load.show();
		
		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'submit_detail_pemantauan.jsp'
		,	params	: {
					dml_type				: this.dml_type
				,	id_lingkungan_tahunan	: m_lnk_tahunan_id_lingkungan_tahunan_pemantauan
				,	id_komponen_lingkungan	: this.form_komponen_lingkungan.getValue()
				,	lokasi_dampak			: this.form_lokasi_dampak.getValue()
				,	jenis_dampak			: this.form_jenis_dampak.getValue()
				,	sumber_dampak			: this.form_sumber_dampak.getValue()
				,	parameter_pemantauan	: this.form_parameter_pemantauan.getValue()
				,	baku_mutu_pemantauan	: this.form_baku_mutu_pemantauan.getValue()
				,	periode_pemantauan		: this.form_periode_pemantauan.getValue()
				,	hasil_pemantauan		: this.form_hasil_pemantauan.getValue()	
				,	penanggung_jawab		: this.form_penanggung_jawab.getValue()	
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				main_load.hide();
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				main_load.hide();
				
				Ext.MessageBox.alert('Informasi', msg.info);

				m_lnk_tahunan_pemantauan_detail_list.store.reload();
				m_lnk_tahunan_pemantauan.panel_detail.layout.setActiveItem(0);
				m_lnk_tahunan_pemantauan.panel_master.setDisabled(false);
				m_lnk_tahunan.panel.unhideTabStripItem(1);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		this.form_komponen_lingkungan.setValue('');
		this.form_komponen_lingkungan.setDisabled(false);
		this.form_lokasi_dampak.setValue('');
		this.form_jenis_dampak.setValue('');
		this.form_sumber_dampak.setValue('');
		this.form_parameter_pemantauan.setValue('');
		this.form_baku_mutu_pemantauan.setValue('');
		this.form_periode_pemantauan.setValue('');
		this.form_hasil_pemantauan.setValue('');
		this.form_penanggung_jawab.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_komponen_lingkungan.setValue(data.id_komponen_lingkungan);
		this.form_komponen_lingkungan.setDisabled(true);
		this.form_lokasi_dampak.setValue(data.lokasi_dampak);
		this.form_jenis_dampak.setValue(data.jenis_dampak);
		this.form_sumber_dampak.setValue(data.sumber_dampak);
		this.form_parameter_pemantauan.setValue(data.parameter_pemantauan);
		this.form_baku_mutu_pemantauan.setValue(data.baku_mutu_pemantauan);
		this.form_periode_pemantauan.setValue(data.periode_pemantauan);
		this.form_hasil_pemantauan.setValue(data.hasil_pemantauan);
		this.form_penanggung_jawab.setValue(data.penanggung_jawab);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'data_detail_pemantauan.jsp'
		,	params	: {
				id_lingkungan_tahunan	: m_lnk_tahunan_id_lingkungan_tahunan_pemantauan
			,	id_komponen_lingkungan	: id
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

	this.do_load = function()
	{
		this.store_komponen_lingkungan.load();
	}

	this.do_refresh = function()
	{
		if (m_lnk_tahunan_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input Data Pengelolaan Lingkungan!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
 }
 
 function M_LNKTahunanPemantauanDetailList()
 {
  	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_lingkungan_tahunan' }
		,	{ name	: 'id_komponen_lingkungan' }
		,	{ name	: 'nama_komponen_lingkungan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_lnk_tahunan_d +'data_detail_pemantauan_list.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{	id			: 'nama_komponen_lingkungan'
		,	header		: 'Komponen Lingkungan'
		,	dataIndex	: 'nama_komponen_lingkungan'
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
						m_lnk_tahunan_id_komponen_lingkungan_pemantauan = data[0].data['id_komponen_lingkungan'];
					} else {
						m_lnk_tahunan_id_komponen_lingkungan_pemantauan = '';
					}
				}
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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
			text		: 'Tambah'
		,	iconCls		: 'add16'
		,	scope		: this
		,	handler		: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_edit
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			region				: 'center'
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nama_komponen_lingkungan'
	});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'submit_detail_pemantauan.jsp'
		,	params	: {
				dml_type				: 4
			,	id_lingkungan_tahunan	: data.get('id_lingkungan_tahunan')
			,	id_komponen_lingkungan	: data.get('id_komponen_lingkungan')
			,	lokasi_dampak			: ''
			,	jenis_dampak			: ''
			,	sumber_dampak			: ''
			,	parameter_pemantauan	: ''
			,	baku_mutu_pemantauan	: ''
			,	periode_pemantauan		: ''
			,	hasil_pemantauan		: ''
			,	penanggung_jawab		: ''
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

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_lnk_tahunan_pemantauan_detail_add.do_refresh();
		m_lnk_tahunan_pemantauan_detail_add.do_edit(data.get('id_komponen_lingkungan'));
		m_lnk_tahunan_pemantauan.panel_detail.layout.setActiveItem(1);
		m_lnk_tahunan_pemantauan.panel_master.setDisabled(true);
		m_lnk_tahunan.panel.hideTabStripItem(1);
	}

	this.do_add = function()
	{
		if (m_lnk_tahunan_id_lingkungan_tahunan_pemantauan == '') {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu Lingkungan Master terlebih dahulu!");
			return;
		}

		m_lnk_tahunan_pemantauan_detail_add.do_refresh();
		m_lnk_tahunan_pemantauan_detail_add.do_add();
		m_lnk_tahunan_pemantauan.panel_detail.layout.setActiveItem(1);
		m_lnk_tahunan_pemantauan.panel_master.setDisabled(true);
		m_lnk_tahunan.panel.hideTabStripItem(1);
	}

	this.do_load = function()
	{
		this.store.load({
			params	: {
				id_lingkungan_tahunan : m_lnk_tahunan_id_lingkungan_tahunan_pemantauan
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_lnk_tahunan_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data Pengelolaan Lingkungan!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_lnk_tahunan_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_lnk_tahunan_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_lnk_tahunan_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
 }
 
 function M_LNKTahunanPemantauan(title)
 {
	this.title	= title;

	m_lnk_tahunan_pemantauan_master_list	= new M_LNKTahunanPemantauanMasterList();
	m_lnk_tahunan_pemantauan_master_add		= new M_LNKTahunanPemantauanMasterAdd();
	m_lnk_tahunan_pemantauan_detail_list	= new M_LNKTahunanPemantauanDetailList();
	m_lnk_tahunan_pemantauan_detail_add		= new M_LNKTahunanPemantauanDetailAdd();
	
	this.panel_master = new Ext.Panel({
			layout			: 'card'
		,	region			: 'north'
		,	height			: 200
		,	activeItem		: 0
		,	autoScroll		: true
		,	items			: [
				m_lnk_tahunan_pemantauan_master_list.panel
			,	m_lnk_tahunan_pemantauan_master_add.panel
			]
	});

	this.panel_detail = new Ext.Panel({
			layout			: 'card'
		,	region			: 'center'
		,	activeItem		: 0
		,	autoScroll		: true
		,	items			: [
				m_lnk_tahunan_pemantauan_detail_list.panel
			,	m_lnk_tahunan_pemantauan_detail_add.panel
			]
	});

	this.panel = new Ext.Panel({
			title			: this.title
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				this.panel_master
			,	this.panel_detail
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_lnk_tahunan_id_lingkungan_tahunan_pemantauan	= '';

		m_lnk_tahunan_pemantauan_master_list.do_refresh();
	}
 }

 function M_LNKTahunanPengelolaanMasterAdd()
 {
 	this.dml_type				= 0;
	this.id_lingkungan_tahunan	= '';
	this.id_seksi				= 0;
	this.id_dinas				= 0;
	this.id_departemen			= 0;

	this.form_satuan_kerja_on_select = function(record)
	{
		this.id_seksi		= record.get('id_seksi');
		this.id_dinas 		= record.get('id_dinas');
		this.id_departemen	= record.get('id_departemen');
	}

	this.store_satuan_kerja = new Ext.data.ArrayStore({
			fields		: ['id_seksi','id_dinas','id_departemen','nama_seksi']
		,	url			: m_lnk_tahunan_d +'data_ref_satuan_kerja.jsp'
		,	autoLoad	: false
	});

	this.form_satuan_kerja = new Ext.form.ComboBox({
			fieldLabel		: 'Satuan Kerja'
		,	store			: this.store_satuan_kerja
		,	valueField		: 'id_seksi'
		,	displayField	: 'nama_seksi'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 300
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_satuan_kerja_on_select(record);
				}
		}
	});

	this.form_proyek = new Ext.form.TextArea({
			fieldLabel	: 'Proyek/Kegiatan/Aktifitas'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_dikompilasi_oleh = new Ext.form.TextField({
			fieldLabel	: 'Dikompilasi Oleh'
		,	allowBlank	: false
		,	width		: 300
	});

	this.form_tanggal_kompilasi = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Kompilasi'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 150
	});

	this.form_disetujui_oleh = new Ext.form.TextField({
			fieldLabel	: 'Disetujui Oleh'
		,	allowBlank	: false
		,	width		: 300
	});

	this.form_tanggal_disetujui = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Disetujui'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 150
	});

	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 150
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_satuan_kerja
				,	this.form_proyek
				,	this.form_dikompilasi_oleh
				,	this.form_tanggal_kompilasi
				,	this.form_disetujui_oleh
				,	this.form_tanggal_disetujui
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
		if (!this.form_satuan_kerja.isValid()) {
			return false;
		}

		if (!this.form_proyek.isValid()) {
			return false;
		}

		if (!this.form_dikompilasi_oleh.isValid()) {
			return false;
		}

		if (!this.form_tanggal_kompilasi.isValid()) {
			return false;
		}

		if (!this.form_disetujui_oleh.isValid()) {
			return false;
		}

		if (!this.form_tanggal_disetujui.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_lnk_tahunan_pengelolaan.panel_master.layout.setActiveItem(0);
		m_lnk_tahunan_pengelolaan.panel_detail.setDisabled(false);
		m_lnk_tahunan.panel.unhideTabStripItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		main_load.show();
		
		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'submit_master_pengelolaan.jsp'
		,	params	: {
					dml_type					: this.dml_type
				,	id_lingkungan_tahunan		: m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan
				,	id_seksi					: this.id_seksi
				,	id_dinas					: this.id_dinas
				,	id_departemen				: this.id_departemen
				,	tipe_kegiatan_lingkungan	: 2
				,	proyek_kegiatan_aktifitas	: this.form_proyek.getValue()
				,	dikompilasi_oleh			: this.form_dikompilasi_oleh.getValue()
				,	tanggal_kompilasi			: this.form_tanggal_kompilasi.getValue()
				,	disetujui_oleh				: this.form_disetujui_oleh.getValue()	
				,	tanggal_disetujui			: this.form_tanggal_disetujui.getValue()	
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				main_load.hide();
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				main_load.hide();
				
				Ext.MessageBox.alert('Informasi', msg.info);

				m_lnk_tahunan_pengelolaan_master_list.store.reload();
				m_lnk_tahunan_pengelolaan.panel_master.layout.setActiveItem(0);
				m_lnk_tahunan_pengelolaan.panel_detail.setDisabled(false);
				m_lnk_tahunan.panel.unhideTabStripItem(0);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		this.form_satuan_kerja.setValue('');
		this.form_proyek.setValue('');
		this.form_dikompilasi_oleh.setValue('');
		this.form_tanggal_kompilasi.setValue('');
		this.form_disetujui_oleh.setValue('');
		this.form_tanggal_disetujui.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_satuan_kerja.setValue(data.id_seksi);
		this.id_dinas = data.id_dinas;
		this.id_departemen = data.id_departemen;
		this.form_proyek.setValue(data.proyek_kegiatan_aktifitas);
		this.form_dikompilasi_oleh.setValue(data.dikompilasi_oleh);
		this.form_tanggal_kompilasi.setValue(data.tanggal_kompilasi);
		this.form_disetujui_oleh.setValue(data.disetujui_oleh);
		this.form_tanggal_disetujui.setValue(data.tanggal_disetujui);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'data_master_pengelolaan.jsp'
		,	params	: {
				id_lingkungan_tahunan	: id
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

	this.do_load = function()
	{
		this.store_satuan_kerja.load();
	}

	this.do_refresh = function()
	{
		if (m_lnk_tahunan_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input Data Pengelolaan Lingkungan!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
 }
 
 function M_LNKTahunanPengelolaanMasterList()
 {
 	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_lingkungan_tahunan' }
		,	{ name	: 'satuan_kerja' }
		,	{ name	: 'proyek' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_lnk_tahunan_d +'data_master_pengelolaan_list.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{	
			header		: 'Satuan Kerja'
		,	dataIndex	: 'satuan_kerja'
		,	width		: 300
		},{
			id			: 'proyek'
		,	header		: 'Proyek / Kegiatan / Aktifitas'
		,	dataIndex	: 'proyek'
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
						m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan = data[0].data['id_lingkungan_tahunan'];
					} else {
						m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan = '';
					}

					m_lnk_tahunan_pengelolaan_master_on_select_load_detail();
				}
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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
			text		: 'Tambah'
		,	iconCls		: 'add16'
		,	scope		: this
		,	handler		: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_edit
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			region				: 'center'
		,	height				: 200
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'proyek'
	});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'submit_master_pengelolaan.jsp'
		,	params	: {
				dml_type					: 4
			,	id_lingkungan_tahunan		: data.get('id_lingkungan_tahunan')
			,	id_seksi					: ''
			,	id_dinas					: ''
			,	id_departemen				: ''
			,	tipe_kegiatan_lingkungan	: ''
			,	proyek_kegiatan_aktifitas	: ''
			,	dikompilasi_oleh			: ''
			,	tanggal_kompilasi			: ''
			,	disetujui_oleh				: ''
			,	tanggal_disetujui			: ''
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

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_lnk_tahunan_pengelolaan_master_add.do_refresh();
		m_lnk_tahunan_pengelolaan_master_add.do_edit(data.get('id_lingkungan_tahunan'));
		m_lnk_tahunan_pengelolaan.panel_master.layout.setActiveItem(1);
		m_lnk_tahunan_pengelolaan.panel_detail.setDisabled(true);
		m_lnk_tahunan.panel.hideTabStripItem(0);
	}

	this.do_add = function()
	{
		m_lnk_tahunan_pengelolaan_master_add.do_refresh();
		m_lnk_tahunan_pengelolaan_master_add.do_add();
		m_lnk_tahunan_pengelolaan.panel_master.layout.setActiveItem(1);
		m_lnk_tahunan_pengelolaan.panel_detail.setDisabled(true);
		m_lnk_tahunan.panel.hideTabStripItem(0);
	}

	this.do_load = function()
	{
		var load_type = 'user';

		if (m_lnk_tahunan_ha_level == 4) {
			load_type = 'all';
		}

		this.store.load({
			params	: {
				load_type : load_type
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_lnk_tahunan_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data Pengelolaan Lingkungan!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_lnk_tahunan_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_lnk_tahunan_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_lnk_tahunan_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
 }
 
 function M_LNKTahunanPengelolaanDetailAdd()
 {
  	this.dml_type				= 0;

	this.store_komponen_lingkungan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_lnk_tahunan_d +'data_ref_komponen_lingkungan.jsp'
		,	autoLoad	: false
	});

	this.form_komponen_lingkungan = new Ext.form.ComboBox({
			fieldLabel		: 'Komponen Lingkungan'
		,	store			: this.store_komponen_lingkungan
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

	this.form_lokasi_dampak = new Ext.form.TextField({
			fieldLabel	: 'Lokasi'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_jenis_dampak = new Ext.form.TextField({
			fieldLabel	: 'Jenis'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_sumber_dampak = new Ext.form.TextField({
			fieldLabel	: 'Sumber'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_metode_pengelolaan = new Ext.form.TextField({
			fieldLabel	: 'Metode'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_periode_pengelolaan = new Ext.form.TextField({
			fieldLabel	: 'Periode'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_hasil_pengelolaan = new Ext.form.TextArea({
			fieldLabel	: 'Hasil'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_penanggung_jawab = new Ext.form.TextField({
			fieldLabel	: 'Penanggung Jawab'
		,	allowBlank	: false
		,	width		: 400
	});

	this.set_komponen_lingkungan = {
			xtype		: 'fieldset'
		,	labelWidth	: 150
		,	items		: [
				this.form_komponen_lingkungan
			]
	};

	this.set_identifikasi_dampak = {
			xtype		: 'fieldset'
		,	title		: 'Identifikasi Dampak'
		,	labelWidth	: 150
		,	items		: [
				this.form_lokasi_dampak
			,	this.form_jenis_dampak
			,	this.form_sumber_dampak
			]		
	};

	this.set_pengelolaan_lingkungan = {
			xtype		: 'fieldset'
		,	title		: 'Pengelolaan Lingkungan'
		,	labelWidth	: 150
		,	items		: [
				this.form_metode_pengelolaan
			,	this.form_periode_pengelolaan
			,	this.form_hasil_pengelolaan
			]		
	};

	this.set_penanggung_jawab = {
			xtype		: 'fieldset'
		,	labelWidth	: 150
		,	items		: [
				this.form_penanggung_jawab
			]
	};
	
	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.set_komponen_lingkungan
				,	this.set_identifikasi_dampak
				,	this.set_pengelolaan_lingkungan
				,	this.set_penanggung_jawab
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
		if (!this.form_komponen_lingkungan.isValid()) {
			return false;
		}

		if (!this.form_lokasi_dampak.isValid()) {
			return false;
		}

		if (!this.form_jenis_dampak.isValid()) {
			return false;
		}

		if (!this.form_sumber_dampak.isValid()) {
			return false;
		}

		if (!this.form_metode_pengelolaan.isValid()) {
			return false;
		}

		if (!this.form_periode_pengelolaan.isValid()) {
			return false;
		}

		if (!this.form_hasil_pengelolaan.isValid()) {
			return false;
		}

		if (!this.form_penanggung_jawab.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_lnk_tahunan_pengelolaan.panel_detail.layout.setActiveItem(0);
		m_lnk_tahunan_pengelolaan.panel_master.setDisabled(false);
		m_lnk_tahunan.panel.unhideTabStripItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		main_load.show();
		
		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'submit_detail_pengelolaan.jsp'
		,	params	: {
					dml_type				: this.dml_type
				,	id_lingkungan_tahunan	: m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan
				,	id_komponen_lingkungan	: this.form_komponen_lingkungan.getValue()
				,	lokasi_dampak			: this.form_lokasi_dampak.getValue()
				,	jenis_dampak			: this.form_jenis_dampak.getValue()
				,	sumber_dampak			: this.form_sumber_dampak.getValue()
				,	metode_pengelolaan		: this.form_metode_pengelolaan.getValue()
				,	periode_pengelolaan		: this.form_periode_pengelolaan.getValue()
				,	hasil_pengelolaan		: this.form_hasil_pengelolaan.getValue()	
				,	penanggung_jawab		: this.form_penanggung_jawab.getValue()	
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				main_load.hide();
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				main_load.hide();
				
				Ext.MessageBox.alert('Informasi', msg.info);

				m_lnk_tahunan_pengelolaan_detail_list.store.reload();
				m_lnk_tahunan_pengelolaan.panel_detail.layout.setActiveItem(0);
				m_lnk_tahunan_pengelolaan.panel_master.setDisabled(false);
				m_lnk_tahunan.panel.unhideTabStripItem(0);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		this.form_komponen_lingkungan.setValue('');
		this.form_komponen_lingkungan.setDisabled(false);
		this.form_lokasi_dampak.setValue('');
		this.form_jenis_dampak.setValue('');
		this.form_sumber_dampak.setValue('');
		this.form_metode_pengelolaan.setValue('');
		this.form_periode_pengelolaan.setValue('');
		this.form_hasil_pengelolaan.setValue('');
		this.form_penanggung_jawab.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_komponen_lingkungan.setValue(data.id_komponen_lingkungan);
		this.form_komponen_lingkungan.setDisabled(true);
		this.form_lokasi_dampak.setValue(data.lokasi_dampak);
		this.form_jenis_dampak.setValue(data.jenis_dampak);
		this.form_sumber_dampak.setValue(data.sumber_dampak);
		this.form_metode_pengelolaan.setValue(data.metode_pengelolaan);
		this.form_periode_pengelolaan.setValue(data.periode_pengelolaan);
		this.form_hasil_pengelolaan.setValue(data.hasil_pengelolaan);
		this.form_penanggung_jawab.setValue(data.penanggung_jawab);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'data_detail_pengelolaan.jsp'
		,	params	: {
				id_lingkungan_tahunan	: m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan
			,	id_komponen_lingkungan	: id
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

	this.do_load = function()
	{
		this.store_komponen_lingkungan.load();
	}

	this.do_refresh = function()
	{
		if (m_lnk_tahunan_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input Data Pengelolaan Lingkungan!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
 }
 
 function M_LNKTahunanPengelolaanDetailList()
 {
  	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_lingkungan_tahunan' }
		,	{ name	: 'id_komponen_lingkungan' }
		,	{ name	: 'nama_komponen_lingkungan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_lnk_tahunan_d +'data_detail_pengelolaan_list.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{	id			: 'nama_komponen_lingkungan'
		,	header		: 'Komponen Lingkungan'
		,	dataIndex	: 'nama_komponen_lingkungan'
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
						m_lnk_tahunan_id_komponen_lingkungan_pengelolaan = data[0].data['id_komponen_lingkungan'];
					} else {
						m_lnk_tahunan_id_komponen_lingkungan_pengelolaan = '';
					}
				}
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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
			text		: 'Tambah'
		,	iconCls		: 'add16'
		,	scope		: this
		,	handler		: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_edit
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			region				: 'center'
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nama_komponen_lingkungan'
	});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_lnk_tahunan_d +'submit_detail_pengelolaan.jsp'
		,	params	: {
				dml_type				: 4
			,	id_lingkungan_tahunan	: data.get('id_lingkungan_tahunan')
			,	id_komponen_lingkungan	: data.get('id_komponen_lingkungan')
			,	lokasi_dampak			: ''
			,	jenis_dampak			: ''
			,	sumber_dampak			: ''
			,	metode_pengelolaan		: ''
			,	periode_pengelolaan		: ''
			,	hasil_pengelolaan		: ''
			,	penanggung_jawab		: ''
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

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_lnk_tahunan_pengelolaan_detail_add.do_refresh();
		m_lnk_tahunan_pengelolaan_detail_add.do_edit(data.get('id_komponen_lingkungan'));
		m_lnk_tahunan_pengelolaan.panel_detail.layout.setActiveItem(1);
		m_lnk_tahunan_pengelolaan.panel_master.setDisabled(true);
		m_lnk_tahunan.panel.hideTabStripItem(0);
	}

	this.do_add = function()
	{
		if (m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan == '') {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu Lingkungan Master terlebih dahulu!");
			return;
		}

		m_lnk_tahunan_pengelolaan_detail_add.do_refresh();
		m_lnk_tahunan_pengelolaan_detail_add.do_add();
		m_lnk_tahunan_pengelolaan.panel_detail.layout.setActiveItem(1);
		m_lnk_tahunan_pengelolaan.panel_master.setDisabled(true);
		m_lnk_tahunan.panel.hideTabStripItem(0);
	}

	this.do_load = function()
	{
		this.store.load({
			params	: {
				id_lingkungan_tahunan : m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_lnk_tahunan_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data Pengelolaan Lingkungan!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_lnk_tahunan_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_lnk_tahunan_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_lnk_tahunan_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
 }
 
 function M_LNKTahunanPengelolaan(title)
 {
	this.title	= title;

	m_lnk_tahunan_pengelolaan_master_list	= new M_LNKTahunanPengelolaanMasterList();
	m_lnk_tahunan_pengelolaan_master_add	= new M_LNKTahunanPengelolaanMasterAdd();
	m_lnk_tahunan_pengelolaan_detail_list	= new M_LNKTahunanPengelolaanDetailList();
	m_lnk_tahunan_pengelolaan_detail_add	= new M_LNKTahunanPengelolaanDetailAdd();
	
	this.panel_master = new Ext.Panel({
			layout			: 'card'
		,	region			: 'north'
		,	height			: 200
		,	activeItem		: 0
		,	autoScroll		: true
		,	items			: [
				m_lnk_tahunan_pengelolaan_master_list.panel
			,	m_lnk_tahunan_pengelolaan_master_add.panel
			]
	});

	this.panel_detail = new Ext.Panel({
			layout			: 'card'
		,	region			: 'center'
		,	activeItem		: 0
		,	autoScroll		: true
		,	items			: [
				m_lnk_tahunan_pengelolaan_detail_list.panel
			,	m_lnk_tahunan_pengelolaan_detail_add.panel
			]
	});

	this.panel = new Ext.Panel({
			title			: this.title
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				this.panel_master
			,	this.panel_detail
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_lnk_tahunan_id_lingkungan_tahunan_pengelolaan	= '';

		m_lnk_tahunan_pengelolaan_master_list.do_refresh();
	}
 }
 
 function M_LNKTahunan()
 {
	m_lnk_tahunan_pemantauan	= new M_LNKTahunanPemantauan('Pemantauan Lingkungan');
	m_lnk_tahunan_pengelolaan	= new M_LNKTahunanPengelolaan('Pengelolaan Lingkungan');
	
	this.panel = new Ext.TabPanel({
			id				: 'lnk_tahunan_panel'
		,	enableTabScroll	: true
		,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_lnk_tahunan_pemantauan.panel
			,	m_lnk_tahunan_pengelolaan.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_lnk_tahunan_ha_level	= ha_level;

		m_lnk_tahunan_pemantauan.do_refresh(ha_level);
		m_lnk_tahunan_pengelolaan.do_refresh(ha_level);
	}
 }
 
 m_lnk_tahunan	= new M_LNKTahunan();
 
 //@ sourceURL=lnk_tahunan.layout.js
