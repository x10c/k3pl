/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *	 - agus sugianto (agus.delonge@gmail.com)
 */

var m_trx_jsa;
var m_trx_jsa_master;
var m_trx_jsa_master_add;
var m_trx_jsa_detail;
var m_trx_jsa_id_jsa	= '';
var m_trx_jsa_ha_level	= 0;

function jsa_master_on_select_load_detail()
{
	if (typeof m_trx_jsa_master == 'undefined'
	||  typeof m_trx_jsa_detail == 'undefined'
	||  m_trx_jsa_id_jsa == '') {
		return;
	}

	m_trx_jsa_detail.do_refresh();
}

function M_TrxJSAMasterAdd(title)
{
	this.title 			= title;
	this.dml_type		= 0;
	this.id_jsa			= '';

	this.form_no_dokumen = new Ext.form.TextField({
			fieldLabel	: 'Nomor Dokumen'
		,	width		: 250
		,	allowBlank	: false
		,	msgTarget	: 'side'
	});

	this.form_revisi = new Ext.form.TextField({
			fieldLabel	: 'Revisi'
		,	width		: 50
	});

	this.form_no_kontrak = new Ext.form.TextField({
			fieldLabel	: 'Nomor Kontrak'
		,	width		: 250
	});
	
	this.form_nama_perusahaan = new Ext.form.TextField({
			fieldLabel	: 'Nama Perusahaan'
		,	width		: 400
	});
	
	this.form_nama_proyek = new Ext.form.TextField({
			fieldLabel	: 'Nama Proyek'
		,	width		: 400
	});
	
	this.form_nama_pic = new Ext.form.TextField({
			fieldLabel	: 'Nama PIC'
		,	width		: 250
	});
	
	this.form_aktifitas_pekerjaan = new Ext.form.TextArea({
			fieldLabel	: 'Aktifitas Pekerjaan'
		,	width		: 400
	});
	
	this.form_tanggal_jsa = new Ext.form.DateField({
			fieldLabel	: 'Tanggal'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	allowBlank	: false
	});

	this.form_alat_pelindung_diri_digunakan = new Ext.form.TextArea({
			fieldLabel	: 'Alat Pelindung Diri Digunakan'
		,	width		: 400
	});

	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 150
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_no_dokumen
				,	this.form_revisi
				,	this.form_no_kontrak
				,	this.form_nama_perusahaan
				,	this.form_nama_proyek
				,	this.form_nama_pic
				,	this.form_aktifitas_pekerjaan
				,	this.form_tanggal_jsa
				,	this.form_alat_pelindung_diri_digunakan
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
		if (!this.form_no_dokumen.isValid()) {
			return false;
		}

		if (!this.form_tanggal_jsa.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_trx_jsa.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
			url	: _g_root +'/module/trx_jsa/submit_jsa_master.jsp'
		,	params	: {
					dml_type						: this.dml_type
				,	id_jsa							: m_trx_jsa_id_jsa
				,	no_dokumen						: this.form_no_dokumen.getValue()
				,	revisi							: this.form_revisi.getValue()
				,	no_kontrak						: this.form_no_kontrak.getValue()
				,	nama_perusahaan					: this.form_nama_perusahaan.getValue()
				,	nama_proyek						: this.form_nama_proyek.getValue()
				,	nama_pic						: this.form_nama_pic.getValue()
				,	aktifitas_pekerjaan				: this.form_aktifitas_pekerjaan.getValue()
				,	tanggal_jsa						: this.form_tanggal_jsa.getValue()
				,	alat_pelindung_diri_digunakan	: this.form_alat_pelindung_diri_digunakan.getValue()
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

				m_trx_jsa_master.store.reload();
				m_trx_jsa.panel.layout.setActiveItem(0);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		this.form_no_dokumen.setValue('');
		this.form_revisi.setValue('');
		this.form_no_kontrak.setValue('');
		this.form_nama_perusahaan.setValue('');
		this.form_nama_proyek.setValue('');
		this.form_nama_pic.setValue('');
		this.form_aktifitas_pekerjaan.setValue('');
		this.form_tanggal_jsa.setValue('');
		this.form_alat_pelindung_diri_digunakan.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_no_dokumen.setValue(data.no_dokumen);
		this.form_revisi.setValue(data.revisi);
		this.form_no_kontrak.setValue(data.no_kontrak);
		this.form_nama_perusahaan.setValue(data.nama_perusahaan);
		this.form_nama_proyek.setValue(data.nama_proyek);
		this.form_nama_pic.setValue(data.nama_pic);
		this.form_aktifitas_pekerjaan.setValue(data.aktifitas_pekerjaan);
		this.form_tanggal_jsa.setValue(data.tanggal_jsa);
		this.form_alat_pelindung_diri_digunakan.setValue(data.alat_pelindung_diri_digunakan);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url	: _g_root +'/module/trx_jsa/data_jsa.jsp'
		,	params	: {
				id_jsa	: id
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
		if (m_trx_jsa_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input data JSA!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}
	}
}

function M_TrxJSAMaster(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_jsa'
		},{
			name	: 'no_dokumen'
		},{
			name	: 'revisi'
		},{
			name	: 'no_kontrak'
		},{
			name	: 'nama_perusahaan'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/trx_jsa/data_jsa_master.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ id		: 'no_dokumen'
			, header	: 'No.Dokumen'
			, dataIndex	: 'no_dokumen'
			, sortable	: true
			, width		: 200
			}
		,	{ id		: 'revisi'
			, header	: 'Revisi'
			, dataIndex	: 'revisi'
			, sortable	: true
			, width		: 50
			}
		,	{ id		: 'no_kontrak'
			, header	: 'No.Kontrak'
			, dataIndex	: 'no_kontrak'
			, sortable	: true
			, width		: 200
			}
		,	{ id		: 'nama_perusahaan'
			, header	: 'Nama Perusahaan'
			, dataIndex	: 'nama_perusahaan'
			, sortable	: true
			, width		: 300
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
						m_trx_jsa_id_jsa = data[0].data['id_jsa'];
						this.btn_print.setDisabled(false);
					} else {
						m_trx_jsa_id_jsa = '';
						this.btn_print.setDisabled(true);
					}

					jsa_master_on_select_load_detail();
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
			text		: ' Print'
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
		,	autoExpandColumn	: 'nama_perusahaan'
		,	tbar				: this.toolbar
	});

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_trx_jsa_master_add.do_edit(data.get('id_jsa'));
		m_trx_jsa.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		m_trx_jsa_master_add.do_add();
		m_trx_jsa.panel.layout.setActiveItem(1);
	}

	this.do_print = function(){
		var form;
		var id_report	= '18';
		var tipe_report	= 'doc';

		form = document.createElement('form');
		
		form.setAttribute('method', 'post');
		form.setAttribute('target', '_blank');		
		form.setAttribute('action', _g_root +'/report');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'id');
        hiddenField1.setAttribute('value', id_report);
		
		var hiddenField2 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField2.setAttribute('name', 'type');
        hiddenField2.setAttribute('value', tipe_report);

		var hiddenField3 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField3.setAttribute('name', 'id_jsa');
        hiddenField3.setAttribute('value', m_trx_jsa_id_jsa);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
		document.body.appendChild(form);
		form.submit();
	}

	this.do_load = function()
	{
		var load_type = 'user';
		
		if (m_trx_jsa_ha_level == 4) {
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
		if (m_trx_jsa_ha_level <= 1) {
			this.btn_edit.setDisabled(true);
			this.btn_add.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
			this.btn_add.setDisabled(false);
		}

		this.do_load();
	}
}

function M_TrxJSADetail(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_jsa'
		},{
			name	: 'id_jsa_detail'
		},{
			name	: 'urutan_langkah_pekerjaan_dasar'
		},{
			name	: 'potensi_bahaya'
		},{
			name	: 'rekomendasi_aksi'
		},{
			name	: 'penanggung_jawab'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/trx_jsa/data_jsa_detail.jsp'
		,	autoLoad: false
		});

	this.form_urutan_langkah_pekerjaan_dasar = new Ext.form.TextField({
		});
		
	this.form_potensi_bahaya = new Ext.form.TextField({
		});

	this.form_rekomendasi_aksi = new Ext.form.TextField({
		});

	this.form_penanggung_jawab = new Ext.form.TextField({
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'urutan_langkah_pekerjaan_dasar'
			, header	: 'Urutan Langkah Pekerjaan Dasar'
			, dataIndex	: 'urutan_langkah_pekerjaan_dasar'
			, sortable	: true
			, width		: 100
			, editor	: this.form_urutan_langkah_pekerjaan_dasar
			}
		,	{ id		: 'potensi_bahaya'
			, header	: 'Potensi Bahaya'
			, dataIndex	: 'potensi_bahaya'
			, sortable	: true
			, width		: 250
			, editor	: this.form_potensi_bahaya
			}
		,	{ id		: 'rekomendasi_aksi'
			, header	: 'Rekomendasi Aksi'
			, dataIndex	: 'rekomendasi_aksi'
			, sortable	: true
			, width		: 250
			, editor	: this.form_rekomendasi_aksi
			}
		,	{ id		: 'penanggung_jawab'
			, header	: 'Penanggung Jawab'
			, dataIndex	: 'penanggung_jawab'
			, sortable	: true
			, editor	: this.form_penanggung_jawab
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_trx_jsa_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = new Ext.ux.grid.RowEditor({
			saveText : 'Simpan'
		,	listeners: {
				scope		: this
			,	canceledit	:
					function(roweditor, state) {
						if (state === true) {
							this.do_cancel();
						}
					}
			,	afteredit	:
					function(roweditor, object, record, idx) {
						this.do_save(record);
					}
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

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
		});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
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
		,	autoExpandColumn	: 'penanggung_jawab'
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
		if (m_trx_jsa_id_jsa == '') {
			Ext.Msg.alert("Kesalahan Operasi"
		, "Silahkan pilih salah satu JSA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_jsa 							: m_trx_jsa_id_jsa
			,	id_jsa_detail					: ''
			,	urutan_langkah_pekerjaan_dasar	: ''
			,	potensi_bahaya					: ''
			,	rekomendasi_aksi				: ''
			,	penanggung_jawab				: ''
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
				id_jsa							: record.data['id_jsa']
			,	id_jsa_detail					: record.data['id_jsa_detail']
			,	urutan_langkah_pekerjaan_dasar	: record.data['urutan_langkah_pekerjaan_dasar']
			,	potensi_bahaya					: record.data['potensi_bahaya']
			,	rekomendasi_aksi				: record.data['rekomendasi_aksi']
			,	penanggung_jawab				: record.data['penanggung_jawab']
			,   dml_type						: this.dml_type
			}
		,	url	: _g_root +'/module/trx_jsa/submit_jsa_detail.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_trx_jsa_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_jsa	: m_trx_jsa_id_jsa
			}
		});
	}

	this.do_refresh = function()
	{	
		if (m_trx_jsa_ha_level <= 1) {
			this.btn_del.setDisabled(true);
			this.btn_add.setDisabled(true);
		} else {
			this.btn_del.setDisabled(false);
			this.btn_add.setDisabled(false);
		}
		
		this.do_load();
	}
}

function M_TrxJSA()
{
	m_trx_jsa_master		= new M_TrxJSAMaster('Job Safety Analysis');
	m_trx_jsa_detail		= new M_TrxJSADetail('Job Safety Analysis Detail');
	m_trx_jsa_master_add	= new M_TrxJSAMasterAdd('Entry / Edit Data Job Safety Analysis');

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
				m_trx_jsa_master.grid
			,	m_trx_jsa_detail.grid
			]
	});
	
	this.panel = new Ext.Panel({
			id				: 'trx_jsa_panel'
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				this.panel_master_detail
			,	m_trx_jsa_master_add.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_trx_jsa_ha_level	= ha_level;
		m_trx_jsa_id_jsa 	= '';

		m_trx_jsa_master.do_refresh();
	}
}

m_trx_jsa = new M_TrxJSA();

//@ sourceURL=trx_jsa.layout.js
