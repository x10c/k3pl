/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 *   - Prasetya Yanuar (mieh100freak@gmail.com)
 */

var m_ref_jab_komite;
var m_ref_jab_komite_d = _g_root +'/module/ref_jabatan_komite/';
var m_ref_kel_jab_komite;
var m_ref_jab_kom_ha_level = 0;
var m_ref_jab_kel_id = '';

function keljab_on_select_load_jab_komite()
{
	if (typeof m_ref_jab_komite == 'undefined'
	||  typeof m_ref_kel_jab_komite == 'undefined'
	||  m_ref_jab_kel_id == '') {
		return;
	}

	m_ref_jab_komite.do_load();
}

function do_validate_load_jab_komite()
{
	if(m_ref_jab_kel_id == ''){
		Ext.MessageBox.alert('Pesan', 'Pilih Kelompok Jabatan Terlebih Dahulu')
		return 0;
	}
	return 1;
}

function M_RefJabatanKomite()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'id_kel'}
		,	{name:'nama'}
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
			, editor	: this.form_id_kel
			, hidden	: true
			}
		,	{ id		: 'nama'
			, header	: 'Nama'
			, dataIndex	: 'nama'
			, sortable	: true
			, editor	: this.form_name
			, width 	: 400
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
			,	id_kel	: m_ref_jab_kel_id
			,	nama	: ''
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
			,	id_kel	: record.data['id_kel']
			,	nama	: record.data['nama']
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
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
		{name: 'id'}
	,	{name: 'nama'}
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

	this.columns = [
			{ id		: 'id'
			, header	: 'Id'
			, dataIndex	: 'id'
			, width		: 50
			, sortable	: true
			, editor	: this.form_id_kel_jabatan_komite
			}
		,	{ id		: 'nama'
			, header	: 'Nama'
			, dataIndex	: 'nama'
			, width		: 100
			, sortable	: true
			, editor	: this.form_nama_jabatan_sub_komite
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
			title		: 'Kelompok Jabatan Komite'
		,	region		: 'west'
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
		this.store.reload();
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
	m_ref_jab_komite	= new M_RefJabatanKomite();

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
				m_ref_kel_jab_komite.grid
			,	m_ref_jab_komite.grid
			]
		});

	this.do_refresh = function(ha_level)
	{
		m_ref_jab_kom_ha_level = ha_level;
		m_ref_jab_kel_id = '';

		m_ref_kel_jab_komite.do_refresh();
		m_ref_jab_komite.do_refresh();
	}
}

var m_ref_jabatan_komite = new M_ReferensiJabatanKomite_manager();

//@ sourceURL=ref_jabatan_komite.layout.js
