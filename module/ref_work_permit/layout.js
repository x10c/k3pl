/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

 var m_ref_work_permit;
 var m_ref_jenis_pekerjaan_ptw;
 var m_ref_sbak_ptw;
 var m_ref_alat_pelindung_diri_ptw;
 var m_ref_safety_checklist_ptw;
 var m_ref_uji_kandungan_gas_ptw;
 var m_ref_work_permit_ha_level	= 0;
 
function M_RefJenisPekerjaanPTW(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id'
		},{
			name	: 'name'
		}]);

	this.store = new Ext.data.SimpleStore({
			fields	: this.record
		,	url	: _g_root +'/module/ref_work_permit/data_jenis_pekerjaan_ptw.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Jenis Pekerjaan'
			, dataIndex	: 'name'
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
					if (data.length && m_ref_work_permit_ha_level == 4) {
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
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: [this.editor]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'name'
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
		this.record_new = new this.record({
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
				id			: record.data['id']
			,	name		: record.data['name']
			,	dml_type	: this.dml_type
			}
		,	url	: _g_root +'/module/ref_work_permit/submit_jenis_pekerjaan_ptw.jsp'
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
		if (m_ref_work_permit_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}

		return false;
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		if (m_ref_work_permit_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
		
		this.do_load();
	}
}

function M_RefSBAKPTW(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id'
		},{
			name	: 'name'
		}]);

	this.store = new Ext.data.SimpleStore({
			fields	: this.record
		,	url	: _g_root +'/module/ref_work_permit/data_sbak_ptw.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama'
			, dataIndex	: 'name'
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
					if (data.length && m_ref_work_permit_ha_level == 4) {
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
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	plugins				: [this.editor]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'name'
		,	listeners       	: {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
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
		,	url		: _g_root +'/module/ref_work_permit/submit_sbak_ptw.jsp'
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
		if (m_ref_work_permit_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}

		return false;
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		if (m_ref_work_permit_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
		
		this.do_load();
	}
}

function M_RefAlatPelindungDiriPTW(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id'
		},{
			name	: 'name'
		}]);

	this.store = new Ext.data.SimpleStore({
			fields	: this.record
		,	url	: _g_root +'/module/ref_work_permit/data_alat_pelindung_diri_ptw.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama'
			, dataIndex	: 'name'
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
					if (data.length && m_ref_work_permit_ha_level == 4) {
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
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: [this.editor]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'name'
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
		this.record_new = new this.record({
				id	: ''
			,	name: ''
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
		,	url	: _g_root +'/module/ref_work_permit/submit_alat_pelindung_diri_ptw.jsp'
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
		if (m_ref_work_permit_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}

		return false;
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		this.do_load();

		if (m_ref_work_permit_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefSafetyChecklistPTW(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'name'}
		,	{name:'jenis'}
		]);

	this.store = new Ext.data.SimpleStore({
			fields	: this.record
		,	url		: _g_root +'/module/ref_work_permit/data_safety_checklist_ptw.jsp'
		,	autoLoad: false
		});

	this.store_jenis = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	data	: [
				['1','Hot Work Permit']
			,	['2','Cold Work Permit']
			,	['3','Confined Space Entry Permit']
			,	['4','Radiographic Work Permit']
			,	['5','Electrical Work Permit']
			,	['6','Digging Work Permit']
			]
	});
	
	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.form_jenis = new Ext.form.ComboBox({
			store			: this.store_jenis
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	allowBlank		: false
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama'
			, dataIndex	: 'name'
			, sortable	: true
			, editor	: this.form_name
			}
		,	{ id		: 'jenis'
			, header	: 'Jenis PTW'
			, dataIndex	: 'jenis'
			, width		: 200
			, sortable	: true
			, editor	: this.form_jenis
			, renderer	: combo_renderer(this.form_jenis)
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_ref_work_permit_ha_level == 4) {
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
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: [this.editor]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'name'
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
				id		: ''
			,	name	: ''
			,	jenis	: ''
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
			,	jenis	: record.data['jenis']
			,	dml_type: this.dml_type
			}
		,	url		: _g_root +'/module/ref_work_permit/submit_safety_checklist_ptw.jsp'
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
		if (m_ref_work_permit_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		this.do_load();

		if (m_ref_work_permit_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefUjiKandunganGasPTW(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id'
		},{
			name	: 'name'
		},{
			name	: 'standard'
		}]);

	this.store = new Ext.data.SimpleStore({
			fields	: this.record
		,	url	: _g_root +'/module/ref_work_permit/data_uji_kandungan_gas_ptw.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});
		
	this.form_standard = new Ext.form.TextField({});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama'
			, dataIndex	: 'name'
			, sortable	: true
			, editor	: this.form_name
			}
		,	{ id		: 'standard'
			, header	: 'Standard'
			, dataIndex	: 'standard'
			, sortable	: true
			, width		: 300
			, editor	: this.form_standard
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_ref_work_permit_ha_level == 4) {
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
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: [this.editor]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'name'
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
		this.record_new = new this.record({
				id			: ''
			,	name		: ''
			,	standard	: ''
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
				id			: record.data['id']
			,	name		: record.data['name']
			,	standard	: record.data['standard']
			,   dml_type	: this.dml_type
			}
		,	url	: _g_root +'/module/ref_work_permit/submit_uji_kandungan_gas_ptw.jsp'
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
		if (m_ref_work_permit_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}

		return false;
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		this.do_load();

		if (m_ref_work_permit_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefWorkPermit()
{
	m_ref_jenis_pekerjaan_ptw		= new M_RefJenisPekerjaanPTW('Jenis Pekerjaan');
	m_ref_sbak_ptw					= new M_RefSBAKPTW('Sumber Bahaya Alat/Kegiatan');
	m_ref_alat_pelindung_diri_ptw	= new M_RefAlatPelindungDiriPTW('Alat Pelindung Diri');
	m_ref_safety_checklist_ptw		= new M_RefSafetyChecklistPTW('Safety Checklist');
	m_ref_uji_kandungan_gas_ptw		= new M_RefUjiKandunganGasPTW('Uji Kandungan Gas');

	this.panel = new Ext.TabPanel({
			id				: 'ref_work_permit_panel'
		,	enableTabScroll	: true
		,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_ref_jenis_pekerjaan_ptw.grid
			,	m_ref_sbak_ptw.grid
			,	m_ref_alat_pelindung_diri_ptw.grid
			,	m_ref_safety_checklist_ptw.grid
			,	m_ref_uji_kandungan_gas_ptw.grid
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_work_permit_ha_level	= ha_level;

		m_ref_jenis_pekerjaan_ptw.do_refresh();
		m_ref_sbak_ptw.do_refresh();
		m_ref_alat_pelindung_diri_ptw.do_refresh();
		m_ref_safety_checklist_ptw.do_refresh();
		m_ref_uji_kandungan_gas_ptw.do_refresh();
	}
}

m_ref_work_permit = new M_RefWorkPermit();

//@ sourceURL=ref_work_permit.layout.js
