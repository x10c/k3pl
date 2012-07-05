/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_ref_org_d = _g_root +'/module/ref_organisasi/';
var m_ref_org_dep;
var m_ref_org_dinas;
var m_ref_org_seksi;
var m_ref_org_id_dir	= 0;
var m_ref_org_id_div	= 0;
var m_ref_org_id_dep	= 0;
var m_ref_org_id_dinas	= 0;
var m_ref_org_ha_level	= 0;

function disable_add_button ()
{
	console.log (m_ref_org_id_dir +","+ m_ref_org_id_div +","+ m_ref_org_id_dep +","+ m_ref_org_id_dinas);
	m_ref_org_dir.btn_add.setDisabled (0);
	m_ref_org_div.btn_add.setDisabled (m_ref_org_id_dir == 0);
	m_ref_org_dep.btn_add.setDisabled (m_ref_org_id_div == 0);
	m_ref_org_dinas.btn_add.setDisabled (m_ref_org_id_dep == 0);
	m_ref_org_seksi.btn_add.setDisabled (m_ref_org_id_dinas == 0);
}

function dir_on_select_load_div ()
{
	if (typeof m_ref_org_dir == 'undefined'
	||  typeof m_ref_org_div == 'undefined') {
		return;
	}

	m_ref_org_div.do_load();
	m_ref_org_dep.store.removeAll();
	m_ref_org_dinas.store.removeAll();
	m_ref_org_seksi.store.removeAll();

	disable_add_button ();
}

function div_on_select_load_dep ()
{
	if (typeof m_ref_org_dir == 'undefined'
	||  typeof m_ref_org_div == 'undefined'
	||  typeof m_ref_org_dep == 'undefined')
	{
		return;
	}

	m_ref_org_dep.do_load();
	m_ref_org_dinas.store.removeAll();
	m_ref_org_seksi.store.removeAll();

	disable_add_button ();
}

function dep_on_select_load_dinas()
{
	if (typeof m_ref_org_dir == 'undefined'
	||	typeof m_ref_org_div == 'undefined'
	||	typeof m_ref_org_dep == 'undefined'
	||  typeof m_ref_org_dinas == 'undefined')
	{
		return;
	}

	m_ref_org_dinas.do_load();
	m_ref_org_seksi.store.removeAll();

	disable_add_button ();
}

function dinas_on_select_load_seksi()
{
	if (typeof m_ref_org_dep == 'undefined'
	||  typeof m_ref_org_dinas == 'undefined'
	||  typeof m_ref_org_seksi == 'undefined')
	{
		return;
	}

	m_ref_org_seksi.do_load();

	disable_add_button ();
}

function M_RefOrgDirektorat ()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([{
		name	: 'id_direktorat'
	},{
		name	: 'nama_direktorat'
	}]);

	this.store = new Ext.data.ArrayStore ({
			fields	: this.record
		,	url		: m_ref_org_d +'data_direktorat.jsp'
		,	autoLoad: false
	});

	this.form_name = new Ext.form.TextField ({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Nama'
		,	id			: 'nama_direktorat'
		,	dataIndex	: 'nama_direktorat'
		,	sortable	: true
		,	editor		: this.form_name
		}];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
				scope			: this
			,	selectionchange	: function (sm) {
					var data = sm.getSelections();
					if (data.length) {
						if (m_ref_org_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_ref_org_id_dir = data[0].data['id_direktorat'];
					} else {
						this.btn_del.setDisabled(true);
						m_ref_org_id_dir = 0;
					}

					dir_on_select_load_div();
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
			title		: 'Direktorat'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nama_direktorat'
		,	listeners	: {
				scope		: this
			,	rowdblclick	: function (g, r, e) {
					return this.do_edit(r);
				}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_direktorat	: ''
			,	nama_direktorat	: ''
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
				id_direktorat	: record.data['id_direktorat']
			,	nama_direktorat	: record.data['nama_direktorat']
			,	dml_type		: this.dml_type
			}
		,	url		: m_ref_org_d +'submit_direktorat.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success	:
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
		if (m_ref_org_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			scope	:this
		,	callback: function(r,options,success) {
				if (!success) {
					return;
				}

				var dir_all = new Ext.data.Record({
					id_direktorat	: '0'
				,	nama_direktorat	: 'Semua direktorat'
				});

				this.store.add (dir_all);
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_org_ha_level <= 1) {
			this.btn_add.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefOrgDivProSBU ()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([{
		name	: 'id_direktorat'
	},{
		name	: 'id_divprosbu'
	},{
		name	: 'nama_divprosbu'
	},{
		name	: 'status_divprosbu'
	}]);

	this.store = new Ext.data.ArrayStore ({
			fields	: this.record
		,	url		: m_ref_org_d +'data_divprosbu.jsp'
		,	autoLoad: false
	});

	this.store_status = new Ext.data.ArrayStore ({
			fields	: ['id', 'name']
		,	data	: [
				[1, 'Divisi']
			,	[2, 'Proyek']
			,	[3, 'SBU']
			]
	});
	
	this.form_name = new Ext.form.TextField ({
			allowBlank	: false
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

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{
				header		: 'Nama'
			,	id			: 'nama_divprosbu'
			,	dataIndex	: 'nama_divprosbu'
			,	sortable	: true
			,	editor		: this.form_name
			}
		,	{
				header		: 'Status'
			,	dataIndex	: 'status_divprosbu'
			,	sortable	: true
			,	editor		: this.form_status
			,	renderer	: combo_renderer(this.form_status)
			,	align		: 'center'
			,	width		: 75
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
				scope			: this
			,	selectionchange	: function (sm) {
					var data = sm.getSelections();
					if (data.length) {
						if (m_ref_org_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_ref_org_id_div = data[0].data['id_divprosbu'];
					} else {
						this.btn_del.setDisabled(true);
						m_ref_org_id_div = 0;
					}

					div_on_select_load_dep ();
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	disabled: true
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
			title			: 'Divisi/Proyek/SBU'
		,	store			: this.store
		,	sm				: this.sm
		,	columns			: this.columns
		,	plugins			: this.editor
		,	tbar			: this.toolbar
		,	autoExpandColumn: 'nama_divprosbu'
		,	listeners		: {
				scope			: this
			,	rowdblclick		: function (g, r, e) {
					return this.do_edit(r);
				}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_direktorat		: m_ref_org_id_dir
			,	id_divprosbu		: ''
			,	nama_divprosbu		: ''
			,	status_divprosbu	: ''
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
				id_direktorat		: record.data['id_direktorat']
			,	id_divprosbu		: record.data['id_divprosbu']
			,	nama_divprosbu		: record.data['nama_divprosbu']
			,	status_divprosbu	: record.data['status_divprosbu']
			,	dml_type			: this.dml_type
			}
		,	url		: m_ref_org_d +'submit_divprosbu.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success	:
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
		if (m_ref_org_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			scope		:this
		,	params		: {
				id_direktorat	: m_ref_org_id_dir
			}
		,	callback	: function(r,options,success) {
				if (!success) {
					return;
				}

				var dir_all = new Ext.data.Record({
					id_divprosbu	: '0'
				,	nama_divprosbu	: 'Semua Divisi/Proyek/SBU'
				});

				this.store.add (dir_all);
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_org_ha_level <= 1) {
			this.btn_add.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefOrgDepartement(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([{
			name	: 'id_direktorat'
		},{
			name	: 'id_divprosbu'
		},{
			name	: 'id_departemen'
		},{
			name	: 'nama_departemen'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: m_ref_org_d +'data_departemen.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nama_departemen'
			, header	: 'Nama'
			, dataIndex	: 'nama_departemen'
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
						if (m_ref_org_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_ref_org_id_dep = data[0].data['id_departemen'];
					} else {
						this.btn_del.setDisabled(true);
						m_ref_org_id_dep = 0;
					}

					dep_on_select_load_dinas();
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	disabled: true
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
			title			: this.title
		,	region			: 'west'
		,	store			: this.store
		,	sm				: this.sm
		,	columns			: this.columns
		,	plugins			: this.editor
		,	tbar			: this.toolbar
		,	autoExpandColumn: 'nama_departemen'
		,	listeners       : {
				scope		: this
			,	rowdblclick	: function (g, r, e) {
					return this.do_edit(r);
				}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_direktorat	: m_ref_org_id_dir
			,	id_divprosbu	: m_ref_org_id_div
			,	id_departemen	: ''
			,	nama_departemen	: ''
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
				id_direktorat	: record.data['id_direktorat']
			,	id_divprosbu	: record.data['id_divprosbu']
			,	id_departemen	: record.data['id_departemen']
			,	nama_departemen	: record.data['nama_departemen']
			,	dml_type		: this.dml_type
			}
		,	url	: m_ref_org_d +'submit_departemen.jsp'
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
		if (m_ref_org_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			scope	:this
		,	params	: {
				id_direktorat	: m_ref_org_id_dir
			,	id_divprosbu	: m_ref_org_id_div
			}
		,	callback: function(r,options,success) {
				if (!success) {
					return;
				}

				var dep_all = new Ext.data.Record({
					id_departemen	: '0'
				,	nama_departemen	: 'Semua departemen'
				});

				this.store.add(dep_all);
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_org_ha_level <= 1) {
			this.btn_add.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefOrgDinas(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_direktorat'
		},{
			name	: 'id_divprosbu'
		},{
			name	: 'id_departemen'
		},{
			name	: 'id_dinas'
		},{
			name	: 'nama_dinas'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: m_ref_org_d +'data_dinas.jsp'
		,	autoLoad: false
		});

	this.form_nama_dinas = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nama_dinas'
			, header	: 'Nama'
			, dataIndex	: 'nama_dinas'
			, sortable	: true
			, editor	: this.form_nama_dinas
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						if (m_ref_org_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_ref_org_id_dinas = data[0].data['id_dinas'];
					} else {
						this.btn_del.setDisabled(true);
						m_ref_org_id_dinas = 0;
					}

					dinas_on_select_load_seksi();
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	disabled: true
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
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nama_dinas'
		,	listeners       : {
				scope		: this
			,	rowdblclick	: function (g, r, e) {
					return this.do_edit(r);
				}
			}

		});

	this.do_add = function()
	{
		if (m_ref_org_id_dep == 0) {
			Ext.Msg.alert("Kesalahan Operasi"
		, "Silahkan pilih salah satu departemen terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_direktorat	: m_ref_org_id_dir
			,	id_divprosbu	: m_ref_org_id_div
			,	id_departemen 	: m_ref_org_id_dep
			,	id_dinas		: ''
			,	nama_dinas		: ''
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
				id_direktorat	: record.data['id_direktorat']
			,	id_divprosbu	: record.data['id_divprosbu']
			,	id_departemen	: record.data['id_departemen']
			,	id_dinas		: record.data['id_dinas']
			,	nama_dinas		: record.data['nama_dinas']
			,	dml_type		: this.dml_type
			}
		,	url	: m_ref_org_d +'submit_dinas.jsp'
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
		if (m_ref_org_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			scope		: this
		,	params		: {
				id_departemen	: m_ref_org_id_dir
			,	id_divprosbu	: m_ref_org_id_div
			,	id_departemen	: m_ref_org_id_dep
			}
		,	callback: function(r, options, success) {
				if (!success) {
					return;
				}

				var dinas_all = new Ext.data.Record({
					id_departemen	: '0'
				,	id_dinas		: '0'
				,	nama_dinas		: 'Semua dinas'
				});

				this.store.add(dinas_all);
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_org_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_RefOrgSeksi(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_direktorat'
		},{
			name	: 'id_divprosbu'
		},{
			name	: 'id_departemen'
		},{
			name	: 'id_dinas'
		},{
			name	: 'id_seksi'
		},{
			name	: 'nama_seksi'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: m_ref_org_d +'data_seksi.jsp'
		,	autoLoad: false
		});

	this.form_nama_seksi = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nama_seksi'
			, header	: 'Nama'
			, dataIndex	: 'nama_seksi'
			, sortable	: true
			, editor	: this.form_nama_seksi
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_ref_org_ha_level == 4) {
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
		,	disabled: true
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
			title			: this.title
		,	region			: 'east'
		,	store			: this.store
		,	sm				: this.sm
		,	columns			: this.columns
		,	plugins			: this.editor
		,	tbar			: this.toolbar
		,	autoExpandColumn: 'nama_seksi'
		,	listeners       : {
				scope		: this
			,	rowdblclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
			}
		});

	this.do_add = function()
	{
		if (m_ref_org_id_dinas == 0) {
			Ext.Msg.alert("Kesalahan Operasi"
		, "Silahkan pilih salah satu dinas terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_direktorat	: m_ref_org_id_dir
			,	id_divprosbu	: m_ref_org_id_div
			,	id_departemen 	: m_ref_org_id_dep
			,	id_dinas		: m_ref_org_id_dinas
			,	id_seksi		: ''
			,	nama_seksi		: ''
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
				id_direktorat	: record.data['id_direktorat']
			,	id_divprosbu	: record.data['id_divprosbu']
			,	id_departemen	: record.data['id_departemen']
			,	id_dinas		: record.data['id_dinas']
			,	id_seksi		: record.data['id_seksi']
			,	nama_seksi		: record.data['nama_seksi']
			,	dml_type		: this.dml_type
			}
		,	url	: m_ref_org_d +'submit_seksi.jsp'
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
		if (m_ref_org_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_direktorat	: m_ref_org_id_dir
			,	id_divprosbu	: m_ref_org_id_div
			,	id_departemen	: m_ref_org_id_dep
			,	id_dinas		: m_ref_org_id_dinas
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_org_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefOrgList()
{
	this.store = new Ext.data.ArrayStore({
		url	: m_ref_org_d +'data_organisasi.jsp'
	,	fields	:['nama_departemen', 'nama_dinas', 'nama_seksi']
	,	autoLoad:false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		:'Departemen'
		,	dataIndex	:'nama_departemen'
		},{
			header		:'Dinas'
		,	dataIndex	:'nama_dinas'
		},{
			header		:'Seksi'
		,	dataIndex	:'nama_seksi'
		}]
	});

	this.panel = new Ext.grid.GridPanel({
		title		:'Daftar Organisasi'
	,	store		:this.store
	,	cm		:this.cm
	,	viewConfig	:{forceFit:true}
	});

	this.do_refresh = function(ha_level)
	{
		this.store.load();
	}
}

function M_ReferensiOrganisasi()
{
	m_ref_org_dir	= new M_RefOrgDirektorat ();
	m_ref_org_div	= new M_RefOrgDivProSBU ();
	m_ref_org_dep	= new M_RefOrgDepartement('Departemen');
	m_ref_org_dinas	= new M_RefOrgDinas('Dinas');
	m_ref_org_seksi	= new M_RefOrgSeksi('Seksi');

	this.panel_entri = new Ext.Panel({
			title		: 'Referensi Organisasi'
		,	layout		: 'hbox'
		,	autoScroll	: true
		,	layoutConfig: {
				align		: 'stretch'
			,	pack		: 'start'
			}
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	width			: 300
			,	autoScroll		: true
			}
		,	items		: [
				m_ref_org_dir.grid
			,	m_ref_org_div.grid
			,	m_ref_org_dep.grid
			,	m_ref_org_dinas.grid
			,	m_ref_org_seksi.grid
			]
		});

	this.panel_list = new M_RefOrgList();

	this.panel = new Ext.TabPanel({
		id		: 'ref_org_panel'
	,	activeTab	: 0
	,	items		: [
			this.panel_entri
		,	this.panel_list.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_org_ha_level	= ha_level;
		m_ref_org_id_dir 	= 0;
		m_ref_org_id_div 	= 0;
		m_ref_org_id_dep 	= 0;
		m_ref_org_id_dinas	= 0;

		m_ref_org_dir.do_refresh();
		m_ref_org_div.do_refresh();
		m_ref_org_dep.do_refresh();
		m_ref_org_dinas.do_refresh();
		m_ref_org_seksi.do_refresh();

		this.panel_list.do_refresh(ha_level);
	}
}

var m_ref_organisasi = new M_ReferensiOrganisasi();

//@ sourceURL=ref_organisasi.layout.js
