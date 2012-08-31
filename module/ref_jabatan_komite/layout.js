/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 *   - Prasetya Yanuar (mieh100freak@gmail.com)
 */

var m_ref_jabatan_komite;
var m_ref_jab_komite;
var m_ref_jab_komite_d = _g_root +'/module/ref_jabatan_komite/';
var m_ref_kel_jab_komite;
var m_ref_kel_jab_komite_csc;
var m_ref_jab_kom_ha_level = 0;
var m_ref_jab_kel_id = '';
var m_ref_jab_kel_csc_id = '';
var m_ref_direktorat_id = '';
var m_ref_divprosbu_id = '';

function keljab_on_select_load_jab_komite()
{
	if (typeof m_ref_jab_komite == 'undefined'
	||  typeof m_ref_kel_jab_komite == 'undefined'
	||  typeof m_ref_kel_jab_csc == 'undefined'
	||  m_ref_jab_kel_id == '') {
		return;
	}

	m_ref_jab_komite.do_load();
}

function keljabcsc_on_select_load_jab_komite()
{
	if (typeof m_ref_jab_komite == 'undefined'
	||  typeof m_ref_kel_jab_komite == 'undefined'
	||  typeof m_ref_kel_jab_csc == 'undefined'
	||  m_ref_jab_kel_csc_id == '') {
		return;
	}
	m_ref_kel_jab_komite.do_load();
	m_ref_jab_komite.do_load();
}

function do_validate_load_jab_komite()
{
	if(m_ref_jab_kel_id == '' && m_ref_jab_kel_csc_id == ''){
		Ext.MessageBox.alert('Pesan', 'Pilih Kelompok central atau sub Komite Terlebih Dahulu')
		return 0;
	}
	return 1;
}

function do_validate_load_jab_csc()
{
	if( m_ref_jab_kel_csc_id = ''){
		Ext.MessageBox.alert('Pesan', 'Pilih Kelompok Central Komite Terlebih Dahulu')
		return 0;
	}
	return 1;
}

function M_RefJabatanKomite()
{
	
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'id_kel_csc'}
		,	{name:'id_kel'}
		,	{name:'nama'}
		,	{name:'notulen'}
		]);

	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root: 'rows'
		}
		, this.record);

	this.store = new Ext.data.Store({
			url		: m_ref_jab_komite_d +'data_jabatan_komite.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});

	this.form_id = new Ext.form.TextField({
			allowBlank	: true
		});
	this.form_id_kel = new Ext.form.TextField({
			allowBlank	: true
		});
	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});
	
	this.store_notulen_level = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'No Access']
			,	['1', 'Notulen']
			,	['2', 'Penanggung Jawab']
			,	['3', 'Notulen & Penanggung Jawab']
			]
		})

	this.cb_notulen_level = new Ext.form.ComboBox({
			store		: this.store_notulen_level
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: true
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id'
			, header	: 'ID'
			, dataIndex	: 'id'
			, sortable	: true
			, editor	: this.form_id
			, hidden	: true
			}
		,	{ id		: 'id_kel'
			, header	: 'Kelompok'
			, dataIndex	: 'id_kel'
			, sortable	: true
			, hidden	: true
			}
		,	{ id		: 'id_kel_csc'
			, header	: 'Kelompok CSC'
			, dataIndex	: 'id_kel'
			, sortable	: true
			, hidden	: true
			}
		,	{ id		: 'nama'
			, header	: 'Nama'
			, dataIndex	: 'nama'
			, sortable	: true
			, editor	: this.form_name
			, width 	: 400
			}
		,	{ id		: 'notulen'
			, header	: 'Level'
			, dataIndex	: 'notulen'
			, sortable	: true
			, editor	: this.cb_notulen_level
			,renderer	: combo_renderer(this.cb_notulen_level)
			, width 	: 100
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect: true
		,	listeners	: {
				scope	: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length
					&& m_ref_jab_kom_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = new MyRowEditor(this);

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
			title		: 'Jabatan Komite'
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	listeners	: {
				scope		: this
			,	rowclick	: function (g, r, e) {
					return this.do_edit(r);
				}
			}
		});

	this.do_add = function()
	{
		if (do_validate_load_jab_komite()) {
			this.record_new = new this.record({
				id		: ''
			,	id_kel_csc : m_ref_jab_kel_csc_id
			,	id_kel	: m_ref_jab_kel_id
			,	nama	: ''
			,	notulen	: ''
			});

			this.editor.stopEditing();
			this.store.insert(0, this.record_new);
			this.sm.selectRow(0);
			this.editor.startEditing(0);

			this.dml_type = 2;
		}
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
			params	: {
				id		: record.data['id']
			,	id_kel_csc	: record.data['id_kel_csc']
			,	id_kel	: record.data['id_kel']
			,	nama	: record.data['nama']
			,	notulen	: record.data['notulen']
			,	dml_type: this.dml_type
			}
		,	url		:  m_ref_jab_komite_d +'submit_jabatan_komite.jsp'
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
		if (m_ref_jab_kom_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		if(do_validate_load_jab_komite()){
			this.store.load({
				params		: {
					id_kel : m_ref_jab_kel_id
				,	id_kel_csc : m_ref_jab_kel_csc_id
				}
			});
		}
	}

	this.do_refresh = function()
	{
		if (m_ref_jab_kom_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

	}
}

function M_RefKelJabatanKomite()
{
	this.id_direktorat = 0;
	this.id_divprosbu = 0;
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
		{name: 'id'}
	,	{name: 'nama'}
	,	{name: 'id_kel_jabatan_csc'}
	,	{name: 'id_divprosbu'}
	,	{name: 'id_direktorat'}
	]);

	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root: 'rows'
		}
		, this.record);

	this.store = new Ext.data.Store({
			url	: m_ref_jab_komite_d +'data_kel_jabatan_komite.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});

	this.form_id_kel_jabatan_komite = new Ext.form.TextField({
			allowBlank	: false
		});

	this.form_nama_jabatan_sub_komite = new Ext.form.TextField({
			allowBlank	: false
		});
		
	this.store_direktorat = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_direktorat.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_divprosbu.load({
						params	: {
							id_direktorat : this.id_direktorat
						}
					});
				}
			}
	});

	this.store_divprosbu = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_divprosbu.jsp'
		,	autoLoad	: false
		,	idIndex		: 1
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_departemen.load({
						params	: {
							id_direktorat	: this.id_direktorat
						,	id_divprosbu	: this.id_divprosbu
						}
					});
				}
			}
	});

	this.form_divprosbu = new Ext.form.ComboBox({
			fieldLabel		: 'Divisi/Proyek/SBU'
		,	store			: this.store_divprosbu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 400
	});

	this.form_direktorat = new Ext.form.ComboBox({
			fieldLabel		: 'Direktorat'
		,	store			: this.store_direktorat
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_direktorat_on_select(record.get('id'));
				}
			}
	});

	this.form_direktorat_on_select = function(id_direktorat)
	{
		this.id_direktorat = id_direktorat;

		if (this.id_direktorat != 'undefined'
		&&  this.id_direktorat != '') {
			this.form_divprosbu.clearFilter(true);
			this.form_divprosbu.filterBy(this.form_divprosbu_filter, this);

			var id = this.store_divprosbu.getAt(0).get('id');

			this.form_divprosbu.setValue(id);
			this.form_divprosbu_on_select(id);
		} else {
			this.form_divprosbu.clearFilter(true);
		}
	}

	this.columns = [
			{ id		: 'id'
			, header	: 'Id'
			, dataIndex	: 'id'
			, width		: 50
			, sortable	: true
			, hidden	: true
			}
		,	{ id		: 'nama'
			, header	: 'Nama'
			, dataIndex	: 'nama'
			, width		: 100
			, sortable	: true
			, editor	: this.form_nama_jabatan_sub_komite
			}
		,	{ id		: 'id_direktorat'
			, header	: 'Direktorat'
			, dataIndex	: 'id_direktorat'
			, width		: 100
			, sortable	: true
			, hidden	: true
			, editor	: this.form_direktorat
			, renderer	: combo_renderer(this.form_direktorat)
			}
		,	{ id		: 'id_divprosbu'
			, header	: 'Divisi/ Proyek/ SBU'
			, dataIndex	: 'id_divprosbu'
			, width		: 100
			, sortable	: true
			, hidden	: true
			, editor	: this.form_divprosbu
			, renderer	: combo_renderer(this.form_divprosbu)
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();

					if (data.length) {
						if (m_ref_jab_kom_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_ref_jab_kel_id = data[0].data.id;
					} else {
						this.btn_del.setDisabled(true);
						m_ref_jab_kel_id = '';
					}

					keljab_on_select_load_jab_komite();
				}
			}
		});

	this.editor = new MyRowEditor(this);

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
			title		: 'Kelompok Sub Komite'
		,	region		: 'south'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoWidth	: true
		,	width		: '50%'
		,	height		: 250
		,	autoExpandColumn: 'nama'
		,	listeners		: {
				scope		: this
			,	rowclick	: function (g, r, e) {
					return this.do_edit(r);
				}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id	: ''
			,	nama: ''
			,	id_kel_jabatan_csc: ''
			,	id_direktorat: ''
			,	id_divprosbu: ''
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
			params :{
				id		: record.data['id']
			,	nama	: record.data['nama']
			,	id_kel_jabatan_csc	: m_ref_jab_kel_csc_id
			,	id_direktorat	: m_ref_direktorat_id
			,	id_divprosbu	: m_ref_divprosbu_id
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_jab_komite_d +'submit_kel_jabatan_komite.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.store.reload();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_ref_jab_kom_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
						params	: {
							id_kel_csc : m_ref_jab_kel_csc_id
						}});
	}

	this.do_refresh = function()
	{
		if (m_ref_jab_kom_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

	}
}

function M_RefKelJabatanCSC()
{
	this.id_direktorat = 0;
	this.id_divprosbu = 0;
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
		{name: 'id'}
	,	{name: 'nama'}
	,	{name: 'id_divprosbu'}
	,	{name: 'id_direktorat'}
	]);

	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root: 'rows'
		}
		, this.record);

	this.store = new Ext.data.Store({
			url	: m_ref_jab_komite_d +'data_kel_jabatan_csc.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});

	this.form_id_kel_jabatan_komite = new Ext.form.TextField({
			allowBlank	: false
		});

	this.form_nama_jabatan_sub_komite = new Ext.form.TextField({
			allowBlank	: false
		});
		
	this.store_direktorat = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_direktorat.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_divprosbu.load({
						params	: {
							id_direktorat : this.id_direktorat
						}
					});
				}
			}
	});

	this.store_divprosbu = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_divprosbu.jsp'
		,	autoLoad	: false
		,	idIndex		: 1
	});

	this.form_divprosbu = new Ext.form.ComboBox({
			fieldLabel		: 'Divisi/Proyek/SBU'
		,	store			: this.store_divprosbu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 400
	});

	this.form_direktorat = new Ext.form.ComboBox({
			fieldLabel		: 'Direktorat'
		,	store			: this.store_direktorat
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_direktorat_on_select(record.get('id'));
				}
			}
	});
	
	this.form_divprosbu_filter = function(r,id)
	{
		return (
			r.get('id_direktorat')	== this.id_direktorat
		);
	}
	this.form_direktorat_on_select = function(id_direktorat)
	{
		this.id_direktorat = id_direktorat;

		if (this.id_direktorat != 'undefined'
		&&  this.id_direktorat != '') {
			this.form_divprosbu.clearFilter(true);
			this.form_divprosbu.filterBy(this.form_divprosbu_filter, this);

			var id = this.store_divprosbu.get('id');

			this.form_divprosbu.setValue(id);
		} else {
			this.form_divprosbu.clearFilter(true);
		}
	}

	this.columns = [
			{ id		: 'id'
			, header	: 'Id'
			, dataIndex	: 'id'
			, width		: 50
			, sortable	: true
			// , editor	: this.form_id_kel_jabatan_komite
			}
		,	{ id		: 'nama'
			, header	: 'Nama'
			, dataIndex	: 'nama'
			, width		: 100
			, sortable	: true
			, editor	: this.form_nama_jabatan_sub_komite
			}
		,	{ id		: 'id_direktorat'
			, header	: 'Direktorat'
			, dataIndex	: 'id_direktorat'
			, width		: 100
			, sortable	: true
			, editor	: this.form_direktorat
			, renderer	: combo_renderer(this.form_direktorat)
			}
		,	{ id		: 'id_divprosbu'
			, header	: 'Divisi/ Proyek/ SBU'
			, dataIndex	: 'id_divprosbu'
			, width		: 100
			, sortable	: true
			, editor	: this.form_divprosbu
			, renderer	: combo_renderer(this.form_divprosbu)
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();

					if (data.length) {
						if (m_ref_jab_kom_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_ref_jab_kel_csc_id = data[0].data.id;
						m_ref_direktorat_id = data[0].data.id_direktorat;
						m_ref_divprosbu_id = data[0].data.id_divprosbu;
					} else {
						this.btn_del.setDisabled(true);
						m_ref_jab_kel_csc_id = '';
						m_ref_direktorat_id = '';
						m_ref_divprosbu_id = '';
					}    

					keljabcsc_on_select_load_jab_komite();
				}
			}
		});

	this.editor = new MyRowEditor(this);

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
			title		: 'Kelompok Central Komite'
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoWidth	: true
		,	width		: '50%'
		,	autoExpandColumn: 'nama'
		,	listeners		: {
				scope		: this
			,	rowclick	: function (g, r, e) {
					return this.do_edit(r);
				}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id	: ''
			,	nama: ''
			,	id_divprosbu: ''
			,	id_direktorat: ''
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
			params :{
				id		: record.data['id']
			,	nama	: record.data['nama']
			,	id_direktorat	: record.data['id_direktorat']
			,	id_divprosbu	: record.data['id_divprosbu']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_jab_komite_d +'submit_kel_jabatan_csc.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.store.reload();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_ref_jab_kom_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_direktorat.load();
		this.store_divprosbu.load();
		this.store.load();
		
	}

	this.do_refresh = function()
	{
		if (m_ref_jab_kom_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_ReferensiJabatanKomite_manager()
{
	m_ref_kel_jab_komite	= new M_RefKelJabatanKomite();
	m_ref_kel_jab_csc	= new M_RefKelJabatanCSC();
	m_ref_jab_komite	= new M_RefJabatanKomite();

	this.col_left = new Ext.Container({
			region		: 'west'
		,	layout		: 'border'
		,	width		: '50%'
		,	align		: 'scretch'
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
    			}
		,	items	: [
				m_ref_kel_jab_csc.grid
			,	m_ref_kel_jab_komite.grid
			]
		});
	
	this.panel = new Ext.Container({
			id			: 'ref_jabatan_komite_panel'
		,	layout		: 'border'
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse: true
			}
		,	items		: [
				this.col_left
			,	m_ref_jab_komite.grid
			]
		});

	this.do_refresh = function(ha_level)
	{
		m_ref_jab_kom_ha_level = ha_level;
		m_ref_jab_kel_id = '';
		m_ref_jab_kel_csc_id = '';

		m_ref_kel_jab_komite.do_refresh();
		m_ref_kel_jab_csc.do_refresh();
		m_ref_jab_komite.do_refresh();
	}
}

m_ref_jabatan_komite = new M_ReferensiJabatanKomite_manager();

//@ sourceURL=ref_jabatan_komite.layout.js
