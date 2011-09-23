/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - Agus Sugianto (agus.delonge@gmail.com)
 *   - m.shulhan (ms@kilabit.org)
 */

var m_ref_pelatihan;
var m_ref_pelatihan_d = _g_root +'/module/ref_pelatihan/';
var m_ref_pelatihan_group;
var m_ref_pelatihan_type;

function M_RefPelatihanGroup(ha_level)
{
	this.dml_type	= 0;
	this.ha_level	= 0;
	this.id			= '0';

	this.fields = new Ext.data.Record.create([
		{name: 'id'}
	,	{name: 'name'}
	]);

	this.store = new Ext.data.ArrayStore({
		fields		: this.fields
	,	url		: m_ref_pelatihan_d +'data_pelatihan_kelompok.jsp'
	,	autoLoad	: false
	,	listeners	: {
			scope	: this
		,	load	: function(store, records, options) {
				this.sm.selectRow(0);
			}
		}
	});

	this.form_name = new Ext.form.TextField({
		allowBlank: false
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			id		: 'name'
		,	header		: 'Nama'
		,	dataIndex	: 'name'
		,	sortable	: true
		,	hideable	: false
		,	editor		: this.form_name
		}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						if (this.ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						this.id = data[0].data['id'];
					} else {
						this.btn_del.setDisabled(true);
						this.id = '0';
					}

					m_ref_pelatihan_type.do_filter(this.id);
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
				this.store.reload();
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

	this.panel = new Ext.grid.GridPanel({
			title		: 'Kelompok Pelatihan'
		,	region		: 'west'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	width		: '50%'
		,	autoExpandColumn: 'name'
		,	tbar		: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
                        }
		});

	this.do_add = function()
	{
		this.record_new = new this.fields({
				id	: ''
			,	name	: ''
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
				id		: record.data['id']
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url	: m_ref_pelatihan_d +'submit_pelatihan_kelompok.jsp'
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
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (this.ha_level < 4) {
			this.btn_del.setDisabled(true);
		} else {
			this.btn_del.setDisabled(false);
		}

		this.store.reload();
	}
}

function M_RefPelatihanType()
{
	this.ha_level	= 0;
	this.dml_type	= 0;

	this.fields = new Ext.data.Record.create([
			{ name: 'id_group' }
		,	{ name: 'id' }
		,	{ name: 'name' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.fields
		,	url		: m_ref_pelatihan_d +'data_pelatihan.jsp'
		,	autoLoad	: false
		,	listeners	: {
				scope	: this
			,	load	: function(s, r, o) {
					this.do_filter(m_ref_pelatihan_group.id);
				}
			}
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			id		: 'name'
		,	header		: 'Nama'
		,	dataIndex	: 'name'
		,	sortable	: true
		,	hideable	: false
		,	editor		: this.form_name
		}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
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
				this.store.reload();
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

	this.panel = new Ext.grid.GridPanel({
			title		: 'Tipe Pelatihan'
		,	region		: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	width		: '50%'
		,	autoExpandColumn: 'name'
		,	tbar		: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
                        }
		});

	this.do_add = function()
	{
		this.record_new = new this.fields({
				id_group: m_ref_pelatihan_group.id
			,	id	: ''
			,	name	: ''
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
				id_group	: m_ref_pelatihan_group.id
			,	id			: record.data['id']
			,	name		: record.data['name']
			,	dml_type	: this.dml_type
			}
		,	url	: m_ref_pelatihan_d +'submit_pelatihan.jsp'
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
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_filter = function(id_group)
	{
		this.store.filter('id_group', id_group);
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (this.ha_level < 4) {
			this.btn_del.setDisabled(true);
		} else {
			this.btn_del.setDisabled(false);
		}

		this.store.reload();
	}
}

function M_RefPelatihan()
{
	this.panel = new Ext.Container({
		id		: 'ref_pelatihan_panel'
	,	layout		: 'border'
	,	bodyBorders	: false
	,	autoScroll	: true
	,	defaults	: {
			loadMask	: {msg: 'Pemuatan...'}
		,	split		: true
		,	autoScroll	: true
		}
	,	items		: [
			m_ref_pelatihan_group.panel
		,	m_ref_pelatihan_type.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_pelatihan_group.do_refresh(ha_level);
		m_ref_pelatihan_type.do_refresh(ha_level);
	}
}

if (typeof m_ref_pelatihan_group == 'undefined') {
	m_ref_pelatihan_group = new M_RefPelatihanGroup();
}

if (typeof m_ref_pelatihan_type == 'undefined') {
	m_ref_pelatihan_type = new M_RefPelatihanType();
}

if (typeof m_ref_pelatihan == 'undefined') {
	m_ref_pelatihan = new M_RefPelatihan();
}

//@ sourceURL=ref_pelatihan.layout.js
