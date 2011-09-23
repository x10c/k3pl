/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

 var m_lnk_bulanan;
 var m_lnk_bulanan_master;
 var m_lnk_bulanan_detail_list;
 var m_lnk_bulanan_detail_detail;
 var m_lnk_bulanan_d = _g_root +'/module/lnk_bulanan/';
 var m_lnk_bulanan_id_lingkungan_bulanan_detail	= '';
 var m_lnk_bulanan_tahun = '';
 var m_lnk_bulanan_bulan = '';
 var m_lnk_bulanan_ha_level = 0;
 
 function m_lnk_bulanan_master_on_select_load_detail()
 {
 	if (typeof m_lnk_bulanan_master == 'undefined'
	||  m_lnk_bulanan_tahun == ''
	||	m_lnk_bulanan_bulan == '') {
		return;
	}

	m_lnk_bulanan_detail_list.do_refresh();
 }

 function M_LNKBulananMaster(title)
 {
	this.title		= title;
 	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'tahun' }
		,	{ name	: 'tahun_old' }
		,	{ name	: 'bulan' }
		,	{ name	: 'bulan_old' }
		,	{ name	: 'pekerjaan' }
		,	{ name	: 'lokasi_proyek' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_lnk_bulanan_d +'data_master.jsp'
		,	autoLoad: false
	});

	this.store_month = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [[1,'Januari'],
					   [2,'Februari'],
					   [3,'Maret'],
					   [4,'April'],
					   [5,'Mei'],
					   [6,'Juni'],
					   [7,'Juli'],
					   [8,'Agustus'],
					   [9,'September'],
					   [10,'Oktober'],
					   [11,'November'],
					   [12,'Desember']]
	});

	this.get_form_year_data = function()
	{
		var d		= new Date();
		var cur_year	= d.getFullYear();
		var years	= '[["'+ cur_year +'"]';

		for(var i=1; i<=10; i++) {
			years += ',["'+ (cur_year - i) +'"]';
		}

		years += ']';

		return Ext.util.JSON.decode(years);
	}

	this.store_year = new Ext.data.ArrayStore({
			fields	: ['year']
		,	data	: this.get_form_year_data()
	});

	this.form_year = new Ext.form.ComboBox({
			store			: this.store_year
		,	valueField		: 'year'
		,	displayField	: 'year'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_month = new Ext.form.ComboBox({
			store			: this.store_month
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});
	
	this.form_pekerjaan = new Ext.form.TextField({
		allowBlank	: false
	});

	this.form_lokasi_proyek = new Ext.form.TextField({
		allowBlank	: false
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Tahun'
			, dataIndex	: 'tahun'
			, width		: 100
			, align		: 'center'
			, editor	: this.form_year
			, renderer	: combo_renderer(this.form_year)
			}
		,	{ header	: 'Bulan'
			, dataIndex	: 'bulan'
			, width		: 100
			, editor	: this.form_month
			, renderer	: combo_renderer(this.form_month)
			}
		,	{ header	: 'Pekerjaan'
			, dataIndex	: 'pekerjaan'
			, width		: 400
			, editor	: this.form_pekerjaan
			}
		,	{ id		: 'lokasi_proyek'
			, header	: 'Lokasi Proyek'
			, dataIndex	: 'lokasi_proyek'
			, editor	: this.form_lokasi_proyek
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_lnk_bulanan_tahun = data[0].data['tahun'];
						m_lnk_bulanan_bulan = data[0].data['bulan'];
					} else {
						m_lnk_bulanan_tahun = '';
						m_lnk_bulanan_bulan = '';
					}

					m_lnk_bulanan_master_on_select_load_detail();
				}
			}
	});

	this.editor = new MyRowEditor(this);
	
	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	plugins				: [this.editor]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'lokasi_proyek'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function()
	{
		if (m_lnk_bulanan_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				tahun 			: ''
			,	bulan			: ''
			,	pekerjaan		: ''
			,	lokasi_proyek	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_lnk_bulanan_d +'submit_master.jsp'
		,	params  : {
				tahun			: record.data['tahun']
			,	tahun_old		: record.data['tahun_old']
			,	bulan			: record.data['bulan']
			,	bulan_old		: record.data['bulan_old']
			,	pekerjaan		: record.data['pekerjaan']
			,	lokasi_proyek	: record.data['lokasi_proyek']
			,   dml_type		: this.dml_type
			}
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
	
	this.do_load = function()
	{
		var load_type = 'user';

		if (m_lnk_bulanan_ha_level == 4) {
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
		if (m_lnk_bulanan_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data Pengelolaan Lingkungan!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_lnk_bulanan_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_lnk_bulanan_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
 }
 
 function M_LNKBulananDetailDetail(title)
 {
	this.title		= title;
  	this.dml_type	= 0;

	this.store_tipe_kegiatan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data	: [[1,'Kegiatan Pengelolaan Lingkungan'],
					   [2,'Kegiatan TJSL']]
	});

	this.form_tipe_kegiatan = new Ext.form.ComboBox({
			fieldLabel		: 'Tipe Kegiatan'
		,	store			: this.store_tipe_kegiatan
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

	this.form_nama_kegiatan = new Ext.form.TextArea({
			fieldLabel	: 'Nama Kegiatan'
		,	allowBlank	: false
		,	width		: 400
	});

	this.form_tanggal_awal = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Awal'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 150
	});

	this.form_tanggal_akhir = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Akhir'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 150
	});

	this.form_uraian_kegiatan = new Ext.form.TextArea({
			fieldLabel	: 'Uraian Kegiatan'
		,	allowBlank	: false
		,	width		: 600
		,	height		: 200
	});

	this.form_keterangan = new Ext.form.TextField({
			fieldLabel	: 'Keterangan'
		,	width		: 400
	});

	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 100
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_tipe_kegiatan
				,	this.form_nama_kegiatan
				,	this.form_tanggal_awal
				,	this.form_tanggal_akhir
				,	this.form_uraian_kegiatan
				,	this.form_keterangan
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
		if (!this.form_tipe_kegiatan.isValid()) {
			return false;
		}

		if (!this.form_nama_kegiatan.isValid()) {
			return false;
		}

		if (!this.form_tanggal_awal.isValid()) {
			return false;
		}

		if (!this.form_tanggal_akhir.isValid()) {
			return false;
		}

		if (!this.form_uraian_kegiatan.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_lnk_bulanan.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		main_load.show();
		
		Ext.Ajax.request({
			url		: m_lnk_bulanan_d +'submit_detail.jsp'
		,	params	: {
					dml_type						: this.dml_type
				,	id_lingkungan_bulanan_detail	: m_lnk_bulanan_id_lingkungan_bulanan_detail
				,	tahun							: m_lnk_bulanan_tahun
				,	bulan							: m_lnk_bulanan_bulan
				,	tipe_kegiatan					: this.form_tipe_kegiatan.getValue()
				,	nama_kegiatan					: this.form_nama_kegiatan.getValue()
				,	tanggal_awal					: this.form_tanggal_awal.getValue()
				,	tanggal_akhir					: this.form_tanggal_akhir.getValue()
				,	uraian_kegiatan					: this.form_uraian_kegiatan.getValue()
				,	keterangan						: this.form_keterangan.getValue()
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

				m_lnk_bulanan_detail_list.store.reload();
				m_lnk_bulanan.panel.layout.setActiveItem(0);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		this.form_tipe_kegiatan.setValue('');
		this.form_nama_kegiatan.setValue('');
		this.form_tanggal_awal.setValue('');
		this.form_tanggal_akhir.setValue('');
		this.form_uraian_kegiatan.setValue('');
		this.form_keterangan.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_tipe_kegiatan.setValue(data.tipe_kegiatan);
		this.form_nama_kegiatan.setValue(data.nama_kegiatan);
		this.form_tanggal_awal.setValue(data.tanggal_awal);
		this.form_tanggal_akhir.setValue(data.tanggal_akhir);
		this.form_uraian_kegiatan.setValue(data.uraian_kegiatan);
		this.form_keterangan.setValue(data.keterangan);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_lnk_bulanan_d +'data_detail.jsp'
		,	params	: {
				id_lingkungan_bulanan_detail	: m_lnk_bulanan_id_lingkungan_bulanan_detail
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
		if (m_lnk_bulanan_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input Data Pengelolaan Lingkungan!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}
	}
 }
 
 function M_LNKBulananDetailList(title)
 {
	this.title		= title;
  	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_lingkungan_bulanan_detail' }
		,	{ name	: 'tipe_kegiatan' }
		,	{ name	: 'nama_kegiatan' }
		,	{ name	: 'tanggal_awal' }
		,	{ name	: 'tanggal_akhir' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_lnk_bulanan_d +'data_detail_list.jsp'
		,	autoLoad: false
	});

	this.store_tipe_kegiatan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data	: [[1,'Kegiatan Pengelolaan Lingkungan'],
					   [2,'Kegiatan TJSL']]
	});

	this.form_tipe_kegiatan = new Ext.form.ComboBox({
			store			: this.store_tipe_kegiatan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{	
				header		: 'Tipe Kegiatan'
			,	dataIndex	: 'tipe_kegiatan'
			,	width		: 300
			,	editor		: this.form_tipe_kegiatan
			,	renderer	: combo_renderer(this.form_tipe_kegiatan)
			}
		,	{ 
				id			: 'nama_kegiatan'
			,	header		: 'Nama Kegiatan'
			,	dataIndex	: 'nama_kegiatan'
			}
		,	{	
				header		: 'Tanggal Awal'
			,	dataIndex	: 'tanggal_awal'
			,	width		: 100
			,	align		: 'center'
			}
		,	{	
				header		: 'Tanggal Akhir'
			,	dataIndex	: 'tanggal_akhir'
			,	width		: 100
			,	align		: 'center'
			}
		]
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
						m_lnk_bulanan_id_lingkungan_bulanan_detail = data[0].data['id_lingkungan_bulanan_detail'];
					} else {
						m_lnk_bulanan_id_lingkungan_bulanan_detail = '';
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

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nama_kegiatan'
	});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_lnk_bulanan_d +'submit_detail.jsp'
		,	params	: {
				dml_type						: 4
			,	id_lingkungan_bulanan_detail	: data.get('id_lingkungan_bulanan_detail')
			,	tahun							: ''
			,	bulan							: ''
			,	tipe_kegiatan					: ''
			,	nama_kegiatan					: ''
			,	tanggal_awal					: ''
			,	tanggal_akhir					: ''
			,	uraian_kegiatan					: ''
			,	keterangan						: ''
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

		m_lnk_bulanan_detail_detail.do_refresh();
		m_lnk_bulanan_detail_detail.do_edit(data.get('id_lingkungan_bulanan_detail'));
		m_lnk_bulanan.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		if (m_lnk_bulanan_tahun == '' && m_lnk_bulanan_bulan == '') {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu Lingkungan Master terlebih dahulu!");
			return;
		}

		m_lnk_bulanan_detail_detail.do_refresh();
		m_lnk_bulanan_detail_detail.do_add();
		m_lnk_bulanan.panel.layout.setActiveItem(1);
	}

	this.do_load = function()
	{
		this.store.load({
			params	: {
				tahun : m_lnk_bulanan_tahun
			,	bulan : m_lnk_bulanan_bulan
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_lnk_bulanan_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data Pengelolaan Lingkungan!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_lnk_bulanan_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_lnk_bulanan_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_lnk_bulanan_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
 }
 
 function M_LNKBulanan()
 {
	m_lnk_bulanan_master		= new M_LNKBulananMaster('Pengelolaan Lingkungan Bulanan');
	m_lnk_bulanan_detail_list	= new M_LNKBulananDetailList('Pengelolaan Lingkungan Bulanan Detail');
	m_lnk_bulanan_detail_detail	= new M_LNKBulananDetailDetail('Data Pengelolaan Lingkungan Bulanan Detail');

	this.panel_master_detail = new Ext.Panel({
			layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_lnk_bulanan_master.grid
			,	m_lnk_bulanan_detail_list.grid
			]
	});
	
	this.panel = new Ext.Panel({
			id				: 'lnk_bulanan_panel'
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				this.panel_master_detail
			,	m_lnk_bulanan_detail_detail.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_lnk_bulanan_ha_level	= ha_level;

		m_lnk_bulanan_master.do_refresh(ha_level);
	}
 }
 
 m_lnk_bulanan	= new M_LNKBulanan();
 
 //@ sourceURL=lnk_bulanan.layout.js