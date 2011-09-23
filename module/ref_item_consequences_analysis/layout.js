/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - Agus Sugianto (agus.delonge@gmail.com)
 */

var m_ref_item_consequences_analysis;
var m_ref_item_consequences_analysis_d = _g_root +'/module/ref_item_consequences_analysis/';
var m_ref_item_consequences_analysis_kategori;
var m_ref_item_consequences_analysis_item;

function M_RefItemConsequencesAnalysisKategori(ha_level)
{
	this.dml_type				= 0;
	this.ha_level				= 0;
	this.id_kategori_item_ca	= '0';

	this.fields = new Ext.data.Record.create([
		{name: 'id_kategori_item_ca'}
	,	{name: 'nama_kategori_item_ca'}
	]);

	this.store = new Ext.data.ArrayStore({
		fields		: this.fields
	,	url			: m_ref_item_consequences_analysis_d +'data_kategori_item_ca.jsp'
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
			id			: 'nama_kategori_item_ca'
		,	header		: 'Nama'
		,	dataIndex	: 'nama_kategori_item_ca'
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
						this.id_kategori_item_ca = data[0].data['id_kategori_item_ca'];
					} else {
						this.btn_del.setDisabled(true);
						this.id_kategori_item_ca = '0';
					}

					m_ref_item_consequences_analysis_item.do_filter(this.id_kategori_item_ca);
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
			title		: 'Kategori Item Consequences Analysis'
		,	region		: 'west'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	width		: '50%'
		,	autoExpandColumn: 'nama_kategori_item_ca'
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
				id_kategori_item_ca		: ''
			,	nama_kategori_item_ca	: ''
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
				id_kategori_item_ca		: record.data['id_kategori_item_ca']
			,	nama_kategori_item_ca	: record.data['nama_kategori_item_ca']
			,	dml_type				: this.dml_type
			}
		,	url		: m_ref_item_consequences_analysis_d +'submit_kategori_item_ca.jsp'
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

function M_RefItemConsequencesAnalysisItem()
{
	this.ha_level	= 0;
	this.dml_type	= 0;

	this.fields = new Ext.data.Record.create([
			{ name: 'id_kategori_item_ca' }
		,	{ name: 'id_item_ca' }
		,	{ name: 'nama_item_ca' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.fields
		,	url			: m_ref_item_consequences_analysis_d +'data_item_ca.jsp'
		,	autoLoad	: false
		,	listeners	: {
				scope	: this
			,	load	: function(s, r, o) {
					this.do_filter(m_ref_item_consequences_analysis_kategori.id_kategori_item_ca);
				}
			}
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			id			: 'nama_item_ca'
		,	header		: 'Nama'
		,	dataIndex	: 'nama_item_ca'
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
			title		: 'Item Consequences Analysis'
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	width		: '50%'
		,	autoExpandColumn: 'nama_item_ca'
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
				id_kategori_item_ca	: m_ref_item_consequences_analysis_kategori.id_kategori_item_ca
			,	id_item_ca			: ''
			,	nama_item_ca		: ''
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
				id_kategori_item_ca	: m_ref_item_consequences_analysis_kategori.id_kategori_item_ca
			,	id_item_ca			: record.data['id_item_ca']
			,	nama_item_ca		: record.data['nama_item_ca']
			,	dml_type			: this.dml_type
			}
		,	url		: m_ref_item_consequences_analysis_d +'submit_item_ca.jsp'
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

	this.do_filter = function(id_kategori_item_ca)
	{
		this.store.filter('id_kategori_item_ca', id_kategori_item_ca);
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

function M_RefItemConsequencesAnalysis()
{
	this.panel = new Ext.Container({
		id			: 'ref_item_consequences_analysis_panel'
	,	layout		: 'border'
	,	bodyBorders	: false
	,	autoScroll	: true
	,	defaults	: {
			loadMask	: {msg: 'Pemuatan...'}
		,	split		: true
		,	autoScroll	: true
		}
	,	items		: [
			m_ref_item_consequences_analysis_kategori.panel
		,	m_ref_item_consequences_analysis_item.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_item_consequences_analysis_kategori.do_refresh(ha_level);
		m_ref_item_consequences_analysis_item.do_refresh(ha_level);
	}
}

if (typeof m_ref_item_consequences_analysis_kategori == 'undefined') {
	m_ref_item_consequences_analysis_kategori = new M_RefItemConsequencesAnalysisKategori();
}

if (typeof m_ref_item_consequences_analysis_item == 'undefined') {
	m_ref_item_consequences_analysis_item = new M_RefItemConsequencesAnalysisItem();
}

if (typeof m_ref_item_consequences_analysis == 'undefined') {
	m_ref_item_consequences_analysis = new M_RefItemConsequencesAnalysis();
}

//@ sourceURL=ref_item_consequences_analysis.layout.js
