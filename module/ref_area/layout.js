/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 *	 - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_area_d	= _g_root +'/module/ref_area/';
var m_ref_org_d		= _g_root +'/module/ref_organisasi/';
var m_ref_area_wil;
var m_ref_area_area;
var m_ref_area_id_wil	= '';
var m_ref_area_ha_level	= 0;

function wil_on_select_load_area()
{
	if (typeof m_ref_area_wil == 'undefined'
	||  typeof m_ref_area_area == 'undefined'
	||  m_ref_area_id_wil == '') {
		return;
	}

	m_ref_area_area.do_load();
}

function M_RefAreaWilayah()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
			{name	: 'id_wilayah'}
		,	{name	: 'nama_wilayah'}
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: m_ref_area_d +'data_wilayah.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nama_wilayah'
			, header	: 'Nama Wilayah'
			, dataIndex	: 'nama_wilayah'
			, sortable	: true
			, editor	: this.form_name
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						if (m_ref_area_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_ref_area_id_wil = data[0].data['id_wilayah'];
					} else {
						this.btn_del.setDisabled(true);
						m_ref_area_id_wil = '';
					}

					wil_on_select_load_area();
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
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
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

	this.grid = new Ext.grid.GridPanel({
			title		: 'Wilayah'
		,	region		: 'west'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	autoExpandColumn: 'nama_wilayah'
		,	collapsible	: true
		,	width		: '30%'
		,	tbar		: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		,       listeners       : {
				scope		: this
			,	rowdblclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_wilayah	: ''
			,	nama_wilayah	: ''
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
				id_wilayah	: record.data['id_wilayah']
			,	nama_wilayah	: record.data['nama_wilayah']
			,       dml_type	: this.dml_type
			}
		,	url	: m_ref_area_d +'submit_wilayah.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.store.load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_ref_area_ha_level >= 3) {
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
		if (m_ref_area_ha_level <= 1) {
			this.btn_add.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefAreaArea()
{
	this.dml_type = 0
/*
 * stores
 */
	this.store = new Ext.data.ArrayStore({
			fields	: k3pl.record.Area
		,	url	: m_ref_area_d +'data_area.jsp'
		,	autoLoad: false
		});
/*
 * forms
 */
	this.btn_save = new Ext.Button({
			text	:'Simpan'
		,	iconCls	:'save16'
		,	scope	:this
		,	handler	: function()
			{
				this.do_save();
			}
		});

	this.btn_cancel = new Ext.Button({
			text	:'Batal'
		,	iconCls	:'del16'
		,	scope	:this
		,	handler	:function ()
			{
				this.do_cancel();
			}
		});

	this.form_nama_area = new Ext.form.TextField({
			fieldLabel	:'Nama Area'
		,	allowBlank	:false
		,	width		:250
		});

	this.form_seksi	= new k3pl.form.Seksi();
	this.form_dinas	= new k3pl.form.Dinas({
			formSeksi	:this.form_seksi
		});
	this.form_dep	= new k3pl.form.Departemen({
			formSeksi	:this.form_seksi
		,	formDinas	:this.form_dinas
		});

	this.form = new Ext.form.FormPanel({
			title		:'Tambah Area'
		,	labelAlign	:'right'
		,	padding		:'6'
		,	tbar		:[
				this.btn_cancel
			,	'->'
			,	this.btn_save
			]
		,	defaults	:{
				msgTarget	:'side'
			}
		,	items		:[
				this.form_dep
			,	this.form_dinas
			,	this.form_nama_area
			]
		});
/*
 * grid
 */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama Area'
			, dataIndex	: 'name'
			, sortable	: true
			, editor	: this.form_nama_area
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_ref_area_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
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

	this.btn_edit = new Ext.Button({
			text	: 'Ubah'
		,	iconCls	: 'edit16'
		,	scope	: this
		,	handler	: function() {
				this.do_edit();
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

	this.grid = new Ext.grid.GridPanel({
			title		: 'Area'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	autoExpandColumn: 'name'
		,	width		: '70%'
		,	tbar		: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_edit
			,	'-'
			,	this.btn_add
			]
		});
/*
 * main panel
 */
	this.panel = new Ext.Panel({
			region		: 'center'
		,	layout		: 'card'
		,	activeItem	: 0
		,	items		:[
				this.grid
			,	this.form
			]
	});
/*
 * functions
 */
	this.do_add = function()
	{
		if (m_ref_area_id_wil == '') {
			Ext.Msg.alert("Kesalahan Operasi"
				, "Silahkan pilih salah satu wilayah terlebih dahulu!");
			return;
		}

		this.dml_type = 2;

		this.panel.layout.setActiveItem(1);
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		var r = data[0];

		this.form_dep.setValue(r.get('id_departemen'));
		this.form_dep.setDisabled(true);

		this.form_dinas.setValue(r.get('id_dinas'));
		this.form_dinas.setDisabled(true);

		this.form_seksi.setValue(r.get('id'));
		this.form_seksi.setDisabled(true);

		this.form_nama_area.setValue(r.get('name'));

		this.dml_type = 4;
		this.do_save();
	}

	this.do_cancel = function()
	{
		this.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		Ext.Ajax.request({
			params  : {
				id_departemen	: this.form_dep.getValue()
			,	id_dinas	: this.form_dinas.getValue()
			,	id_wilayah	: m_ref_area_id_wil
			,	id_seksi	: this.form_seksi.getValue()
			,	nama_area	: this.form_nama_area.getValue()
			,       dml_type	: this.dml_type
			}
		,	url	: m_ref_area_d +'submit_area.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					Ext.Msg.alert('Pesan', msg.info);

					if (this.dml_type == 3) {
						this.form_dep.setDisabled(false)
						this.form_dinas.setDisabled(false);
						this.form_seksi.setDisabled(false);
					}

					this.do_load();
					this.panel.layout.setActiveItem(0);
				}
		,	scope	: this
		});
	}

	this.do_edit = function()
	{
		if (m_ref_area_ha_level < 3) {
			return false;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		var r = data[0];

		this.form_dep.setValue(r.get('id_departemen'));
		this.form_dep.setDisabled(true);

		this.form_dinas.setValue(r.get('id_dinas'));
		this.form_dinas.setDisabled(true);

		this.form_seksi.setValue(r.get('id'));
		this.form_seksi.setDisabled(true);

		this.form_nama_area.setValue(r.get('name'));

		this.dml_type = 3;
		this.panel.layout.setActiveItem(1);

		return true;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_wilayah	: m_ref_area_id_wil
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_area_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.form_dep.do_load();
	}
}

function M_ReferensiArea()
{
	m_ref_area_wil	= new M_RefAreaWilayah();
	m_ref_area_area	= new M_RefAreaArea();

	this.panel = new Ext.Container({
			id		: 'ref_area_panel'
		,	layout		: 'border'
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
    			}
		,	items		: [
				m_ref_area_wil.grid
			,	m_ref_area_area.panel
			]
		});

	this.do_refresh = function(ha_level)
	{
		m_ref_area_ha_level	= ha_level;
		m_ref_area_id_wil 	= '';

		m_ref_area_wil.do_refresh();
		m_ref_area_area.do_refresh();
	}
}

var m_ref_area = new M_ReferensiArea();

//@ sourceURL=ref_area.layout.js
