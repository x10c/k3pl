/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_trx_kegiatan_k3pl;
var m_trx_master_kegiatan;
var m_trx_detail_kegiatan;
var m_trx_detail_area_perhatian;
var m_trx_kegiatan_k3pl_tahun 		= '';
var m_trx_kegiatan_k3pl_bulan 		= '';
var m_trx_kegiatan_k3pl_wilayah 	= 0;
var m_trx_kegiatan_k3pl_ha_level 	= 0;
var m_trx_kegiatan_k3pl_d 			= _g_root +'/module/trx_kegiatan_k3pl/';

function kegiatan_master_on_select_load_detail()
{
	if (typeof m_trx_detail_kegiatan == 'undefined'
	||  typeof m_trx_detail_area_perhatian == 'undefined'
	||  m_trx_kegiatan_k3pl_tahun == ''
	||  m_trx_kegiatan_k3pl_bulan == '') {
		return;
	}

	m_trx_detail_kegiatan.do_refresh();
	m_trx_detail_area_perhatian.do_refresh();
}

function M_TrxMasterKegiatan(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'tahun' }
		,	{ name	: 'bulan' }
		,	{ name	: 'wilayah' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_trx_kegiatan_k3pl_d +'data_master_list.jsp'
		,	autoLoad	: false
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
		,	width			: 100
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

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'tahun'
			, header	: 'Tahun'
			, dataIndex	: 'tahun'
			, width		: 100
			, editor	: this.form_year
			, renderer	: combo_renderer(this.form_year)
			}
		,	{ id		: 'bulan'
			, header	: 'Bulan'
			, dataIndex	: 'bulan'
			, width		: 150
			, editor	: this.form_month
			, renderer	: combo_renderer(this.form_month)
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_trx_kegiatan_k3pl_tahun 	= data[0].data['tahun'];
						m_trx_kegiatan_k3pl_bulan 	= data[0].data['bulan'];
						m_trx_kegiatan_k3pl_wilayah = data[0].data['wilayah'];
					} else {
						m_trx_kegiatan_k3pl_tahun 	= '';
						m_trx_kegiatan_k3pl_bulan 	= ''
						m_trx_kegiatan_k3pl_wilayah = 0;
					}

					kegiatan_master_on_select_load_detail();
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
		,	region				: 'north'
		,	height				: 200
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

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_trx_kegiatan_k3pl_d +'submit_master.jsp'
		,	params	: {
				dml_type	: 4
			,	tahun		: data.get('tahun')
			,	bulan		: data.get('bulan')
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

	this.do_edit = function(row)
	{
		if (m_trx_kegiatan_k3pl_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				tahun	: ''
			,	bulan	: ''
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
			params  : {
				tahun		: record.data['tahun']
			,	bulan		: record.data['bulan']
			,   dml_type	: this.dml_type
			}
		,	url		: m_trx_kegiatan_k3pl_d +'submit_master.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
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
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (m_trx_kegiatan_k3pl_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data Kegiatan!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_trx_kegiatan_k3pl_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_trx_kegiatan_k3pl_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_TrxDetailKegiatan(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_kegiatan_detail' }
		,	{ name	: 'tahun' }
		,	{ name	: 'bulan' }
		,	{ name	: 'id_wilayah' }
		,	{ name	: 'id_tipe_kegiatan' }
		,	{ name	: 'nama_kegiatan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_trx_kegiatan_k3pl_d +'data_detail_kegiatan.jsp'
		,	autoLoad	: false
	});

	this.store_tipe_kegiatan = new Ext.data.ArrayStore({
			fields		: ['id_tipe_kegiatan','nama_tipe_kegiatan']
		,	url			: m_trx_kegiatan_k3pl_d +'data_tipe_kegiatan.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});

	this.form_tipe_kegiatan = new Ext.form.ComboBox({
			store			: this.store_tipe_kegiatan
		,	valueField		: 'id_tipe_kegiatan'
		,	displayField	: 'nama_tipe_kegiatan'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_nama_kegiatan = new Ext.form.TextField({});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_tipe_kegiatan'
			, header	: 'Tipe Kegiatan'
			, dataIndex	: 'id_tipe_kegiatan'
			, width		: 200
			, editor	: this.form_tipe_kegiatan
			, renderer	: combo_renderer(this.form_tipe_kegiatan)
			}
		,	{ id		: 'nama_kegiatan'
			, header	: 'Nama Kegiatan'
			, dataIndex	: 'nama_kegiatan'
			, editor	: this.form_nama_kegiatan
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
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
		,	autoExpandColumn	: 'nama_kegiatan'
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
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_trx_kegiatan_k3pl_d +'submit_detail_kegiatan.jsp'
		,	params	: {
				dml_type	: 4
			,	id_kegiatan_detail	: data.get('id_kegiatan_detail')
			,	tahun				: data.get('tahun')
			,	bulan				: data.get('bulan')
			,	id_wilayah			: data.get('id_wilayah')
			,	id_tipe_kegiatan	: data.get('id_tipe_kegiatan')
			,	nama_kegiatan		: data.get('nama_kegiatan')
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

	this.do_edit = function(row)
	{
		if (m_trx_kegiatan_k3pl_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_kegiatan_detail	: ''
			,	tahun				: m_trx_kegiatan_k3pl_tahun
			,	bulan				: m_trx_kegiatan_k3pl_bulan
			,	id_wilayah			: m_trx_kegiatan_k3pl_wilayah
			,	id_tipe_kegiatan	: ''
			,	nama_kegiatan		: ''
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
			params  : {
				id_kegiatan_detail	: record.data['id_kegiatan_detail']
			,	tahun				: record.data['tahun']
			,	bulan				: record.data['bulan']
			,	id_wilayah			: record.data['id_wilayah']
			,	id_tipe_kegiatan	: record.data['id_tipe_kegiatan']
			,	nama_kegiatan		: record.data['nama_kegiatan']
			,   dml_type			: this.dml_type
			}
		,	url		: m_trx_kegiatan_k3pl_d +'submit_detail_kegiatan.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
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
		
		if (m_trx_kegiatan_k3pl_ha_level == 4) {
			load_type = 'all';
		}

		this.store_tipe_kegiatan.load({
			callback	: function(){
				this.store.load({
					params		: {
						load_type	: load_type
					,	tahun		: m_trx_kegiatan_k3pl_tahun
					,	bulan		: m_trx_kegiatan_k3pl_bulan
					,	wilayah		: m_trx_kegiatan_k3pl_wilayah
					}
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_trx_kegiatan_k3pl_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data Kegiatan!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_trx_kegiatan_k3pl_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_trx_kegiatan_k3pl_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_TrxDetailAreaPerhatian(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_area_perhatian_detail' }
		,	{ name	: 'tahun' }
		,	{ name	: 'bulan' }
		,	{ name	: 'id_wilayah' }
		,	{ name	: 'id_tipe_area_perhatian' }
		,	{ name	: 'nama_area_perhatian' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_trx_kegiatan_k3pl_d +'data_detail_area_perhatian.jsp'
		,	autoLoad	: false
	});

	this.store_tipe_area_perhatian = new Ext.data.ArrayStore({
			fields		: ['id_tipe_area_perhatian','nama_tipe_area_perhatian']
		,	url			: m_trx_kegiatan_k3pl_d +'data_tipe_area_perhatian.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});

	this.form_tipe_area_perhatian = new Ext.form.ComboBox({
			store			: this.store_tipe_area_perhatian
		,	valueField		: 'id_tipe_area_perhatian'
		,	displayField	: 'nama_tipe_area_perhatian'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_nama_area_perhatian = new Ext.form.TextField({});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_tipe_area_perhatian'
			, header	: 'Tipe Area Perhatian'
			, dataIndex	: 'id_tipe_area_perhatian'
			, width		: 300
			, editor	: this.form_tipe_area_perhatian
			, renderer	: combo_renderer(this.form_tipe_area_perhatian)
			}
		,	{ id		: 'nama_area_perhatian'
			, header	: 'Nama Area Perhatian'
			, dataIndex	: 'nama_area_perhatian'
			, editor	: this.form_nama_area_perhatian
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
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
		,	autoExpandColumn	: 'nama_area_perhatian'
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
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_trx_kegiatan_k3pl_d +'submit_detail_area_perhatian.jsp'
		,	params	: {
				dml_type	: 4
			,	id_area_perhatian_detail	: data.get('id_area_perhatian_detail')
			,	tahun						: data.get('tahun')
			,	bulan						: data.get('bulan')
			,	id_wilayah					: data.get('id_wilayah')
			,	id_tipe_area_perhatian		: data.get('id_tipe_area_perhatian')
			,	nama_area_perhatian			: data.get('nama_area_perhatian')
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

	this.do_edit = function(row)
	{
		if (m_trx_kegiatan_k3pl_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_area_perhatian_detail	: ''
			,	tahun						: m_trx_kegiatan_k3pl_tahun
			,	bulan						: m_trx_kegiatan_k3pl_bulan
			,	id_wilayah					: m_trx_kegiatan_k3pl_wilayah
			,	id_tipe_area_perhatian		: ''
			,	nama_area_perhatian			: ''
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
			params  : {
				id_area_perhatian_detail	: record.data['id_area_perhatian_detail']
			,	tahun						: record.data['tahun']
			,	bulan						: record.data['bulan']
			,	id_wilayah					: record.data['id_wilayah']
			,	id_tipe_area_perhatian		: record.data['id_tipe_area_perhatian']
			,	nama_area_perhatian			: record.data['nama_area_perhatian']
			,   dml_type					: this.dml_type
			}
		,	url		: m_trx_kegiatan_k3pl_d +'submit_detail_area_perhatian.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
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
		
		if (m_trx_kegiatan_k3pl_ha_level == 4) {
			load_type = 'all';
		}

		this.store_tipe_area_perhatian.load({
			callback	: function(){
				this.store.load({
					params		: {
						load_type	: load_type
					,	tahun		: m_trx_kegiatan_k3pl_tahun
					,	bulan		: m_trx_kegiatan_k3pl_bulan
					,	wilayah		: m_trx_kegiatan_k3pl_wilayah
					}
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_trx_kegiatan_k3pl_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data Kegiatan!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_trx_kegiatan_k3pl_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_trx_kegiatan_k3pl_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_TrxKegiatanK3PL()
{
	m_trx_master_kegiatan		= new M_TrxMasterKegiatan('Data Kegiatan K3PL');
	m_trx_detail_kegiatan		= new M_TrxDetailKegiatan('Kegiatan');
	m_trx_detail_area_perhatian	= new M_TrxDetailAreaPerhatian('Area Perhatian');

	this.panel_detail = new Ext.TabPanel({
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
				m_trx_detail_kegiatan.grid
			,	m_trx_detail_area_perhatian.grid
			]
	});

	this.panel = new Ext.Panel({
			id				: 'trx_kegiatan_k3pl_panel'
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoWidth		: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_trx_master_kegiatan.grid
			,	this.panel_detail
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_trx_kegiatan_k3pl_ha_level	= ha_level;
		m_trx_kegiatan_k3pl_tahun 		= '';
		m_trx_kegiatan_k3pl_bulan 		= '';
		m_trx_kegiatan_k3pl_wilayah 	= 0;

		m_trx_master_kegiatan.do_refresh();
	}
}

m_trx_kegiatan_k3pl = new M_TrxKegiatanK3PL();

//@ sourceURL=trx_kegiatan_k3pl.layout.js
