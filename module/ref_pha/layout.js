/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

 var m_ref_pha;
 var m_ref_pha_work_steps;
 var m_ref_pha_work_steps_d = _g_root +'/module/ref_work_steps/';
 var m_ref_pha_jabatan;
 var m_ref_pha_jabatan_d = _g_root +'/module/ref_jabatan_pha/';
 var m_ref_pha_material;
 var m_ref_pha_material_master;
 var m_ref_pha_material_detail;
 var m_ref_pha_material_d = _g_root +'/module/ref_material/';
 var m_ref_pha_chemical_hazard_d = _g_root +'/module/ref_chemical_hazard/';
 var m_ref_pha_chemical_interaction_matrix;
 var m_ref_pha_chemical_interaction_matrix_d = _g_root +'/module/ref_chemical_interaction_matrix/';
 var m_ref_pha_properties;
 var m_ref_pha_properties_d = _g_root +'/module/ref_properties/';
 var m_ref_pha_hazard;
 var m_ref_pha_hazard_process;
 var m_ref_pha_hazard_process_d = _g_root +'/module/ref_hazard_process/';
 var m_ref_pha_hazard_pressure;
 var m_ref_pha_hazard_pressure_d = _g_root +'/module/ref_hazard_pressure/';
 var m_ref_pha_item_consequences_analysis;
 var m_ref_pha_item_consequences_analysis_d = _g_root +'/module/ref_item_consequences_analysis/';
 var m_ref_pha_item_consequences_analysis_category;
 var m_ref_pha_item_consequences_analysis_item;
 var m_ref_pha_risk_frequency;
 var m_ref_pha_risk_frequency_d = _g_root +'/module/ref_risk_frequency/';
 var m_ref_pha_risk_category;
 var m_ref_pha_risk_category_d = _g_root +'/module/ref_risk_category/';
 var m_ref_pha_risk_consequence;
 var m_ref_pha_risk_consequence_consequence;
 var m_ref_pha_risk_consequence_category;
 var m_ref_pha_risk_consequence_d = _g_root +'/module/ref_risk_consequence/';
 var m_ref_pha_risk_definition;
 var m_ref_pha_risk_definition_d = _g_root +'/module/ref_risk_definition/';
 var m_ref_pha_risk_matrix;
 var m_ref_pha_risk_matrix_d = _g_root +'/module/ref_risk_matrix/';
 var m_ref_pha_id_material = 0;
 var m_ref_pha_consequence = '';
 var m_ref_pha_ha_level	= 0;
 
function material_master_on_select_load_detail()
{
	if (typeof m_ref_pha_material_master == 'undefined'
	||  m_ref_pha_id_material == 0) {
		return;
	}

	m_ref_pha_material_detail.do_refresh();
}

function consequence_master_on_select_load_detail()
{
	if (typeof m_ref_pha_risk_consequence_consequence == 'undefined'
	||  m_ref_pha_consequence == '') {
		return;
	}

	m_ref_pha_risk_consequence_category.do_refresh(m_ref_pha_ha_level);
}

function M_RefPHAWorkSteps(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id' }
		,	{ name	: 'name' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_work_steps_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama Work Steps'
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
					if (data.length
					&& this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = MyRowEditor(this);

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
			//	this.btn_del
			//,	'-'
				this.btn_ref
			//,	'-'
			//,	this.btn_add
			]
		});

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		//,	plugins		: this.editor
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
				id		: record.data['id']
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_pha_work_steps_d +'submit.jsp'
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
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHAJabatan(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id' }
		,	{ name	: 'name' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_jabatan_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama Jabatan PHA'
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
					if (data.length
					&& this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
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
				id		: record.data['id']
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_pha_jabatan_d +'submit.jsp'
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
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHAProperties(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id' }
		,	{ name	: 'name' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_properties_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama Properties'
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
					if (data.length
					&& this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
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
				id		: record.data['id']
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_pha_properties_d +'submit.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.store.load();
					
					m_ref_pha_material_detail.do_refresh();
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

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHAMaterialDetail(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_material' }
		,	{ name	: 'id_properties' }
		,	{ name	: 'properties' }
		,	{ name	: 'description' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_chemical_hazard_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_properties = new Ext.form.TextField({});

	this.form_description = new Ext.form.TextArea({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Properties'
			, dataIndex	: 'properties'
			, sortable	: true
			, editor	: this.form_properties
			, width		: 200
			, editable	: false
			}
		,	{ id		: 'description'
			, header	: 'Description'
			, dataIndex	: 'description'
			, sortable	: true
			, editor	: this.form_description
			, width		: 400
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.do_load();
			}
		});

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_ref
			]
		});

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoScroll	: true
		,	autoExpandColumn: 'description'
		,   listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
                        }
		});

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
				id_material			: record.data['id_material']
			,	id_properties		: record.data['id_properties']
			,	description			: record.data['description']
			,	dml_type			: this.dml_type
			}
		,	url		: m_ref_pha_chemical_hazard_d +'submit.jsp'
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

	this.do_edit = function(row)
	{
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_material	: m_ref_pha_id_material
			}
		});
	}

	this.do_refresh = function()
	{
		this.ha_level = m_ref_pha_ha_level;
		this.do_load();
	}	
}

function M_RefPHAMaterialMaster(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id' }
		,	{ name	: 'name' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_material_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama Material'
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
					if (data.length) {
						m_ref_pha_id_material = data[0].data['id'];
					} else {
						m_ref_pha_id_material = 0;
					}
					
					material_master_on_select_load_detail();
				}
			}
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	region		: 'north'
		,	height		: 200
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
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
				id		: record.data['id']
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_pha_material_d +'submit.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.store.load();
					
					m_ref_pha_chemical_interaction_matrix.do_refresh();
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

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHAMaterial(title)
{
	m_ref_pha_material_master	= new M_RefPHAMaterialMaster('Material');
	m_ref_pha_material_detail	= new M_RefPHAMaterialDetail('Chemical Hazard');

	this.panel = new Ext.Panel({
			layout		: 'border'
		,	bodyBorders	: false
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			}
		,	items		: [
				m_ref_pha_material_master.panel
			,	m_ref_pha_material_detail.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_pha_id_material = 0;
		
		m_ref_pha_material_master.do_refresh(ha_level);
	}
}

function M_RefPHAChemicalInteractionMatrix(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_material' }
		,	{ name	: 'id_material_interaction' }
		,	{ name	: 'material' }
		,	{ name	: 'material_interaction' }
		,	{ name	: 'interaction' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_chemical_interaction_matrix_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_material = new Ext.form.TextField({});

	this.form_material_interaction = new Ext.form.TextField({});

	this.form_interaction = new Ext.form.TextArea({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Material 1'
			, dataIndex	: 'material'
			, sortable	: true
			, editor	: this.form_material
			, width		: 200
			, editable	: false
			}
		,	{ header	: 'Material 2'
			, dataIndex	: 'material_interaction'
			, sortable	: true
			, editor	: this.form_material_interaction
			, width		: 200
			, editable	: false
			}
		,	{ id		: 'interaction'
			, header	: 'Interaction'
			, dataIndex	: 'interaction'
			, sortable	: true
			, editor	: this.form_interaction
			, width		: 400
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length
					&& this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = MyRowEditor(this);

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
			//	this.btn_del
			//,	'-'
				this.btn_ref
			//,	'-'
			//,	this.btn_add
			]
		});

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoScroll	: true
		,	autoExpandColumn: 'interaction'
		,   listeners       : {
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
				id_material					: ''
			,	id_material_interaction		: ''
			,	interaction					: ''
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
				id_material					: record.data['id_material']
			,	id_material_interaction		: record.data['id_material_interaction']
			,	interaction					: record.data['interaction']
			,	dml_type					: this.dml_type
			}
		,	url		: m_ref_pha_chemical_interaction_matrix_d +'submit.jsp'
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
		if (this.ha_level >= 3) {
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
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHAHazard(title)
{
	m_ref_pha_hazard_process	= new M_RefPHAHazardProcess('Hazard Process');
	m_ref_pha_hazard_pressure	= new M_RefPHAHazardPressure('Hazard Pressure');

	this.panel = new Ext.Panel({
			layout		: 'border'
		,	bodyBorders	: false
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			}
		,	items		: [
				m_ref_pha_hazard_process.panel
			,	m_ref_pha_hazard_pressure.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_pha_hazard_process.do_refresh(ha_level);
		m_ref_pha_hazard_pressure.do_refresh(ha_level);
	}
}

function M_RefPHAHazardProcess(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id' }
		,	{ name	: 'name' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_hazard_process_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama Hazard Process'
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
					if (data.length
					&& this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	region		: 'west'
		,	width		: '50%'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
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
				id		: record.data['id']
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_pha_hazard_process_d +'submit.jsp'
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
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHAHazardPressure(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id' }
		,	{ name	: 'name' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_hazard_pressure_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama Hazard Pressure'
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
					if (data.length
					&& this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
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
				id		: record.data['id']
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_pha_hazard_pressure_d +'submit.jsp'
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
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHAItemConsequencesAnalysisCategory(title)
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
		,	url			: m_ref_pha_item_consequences_analysis_d +'data_kategori_item_ca.jsp'
		,	autoLoad	: false
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

					m_ref_pha_item_consequences_analysis_item.do_filter(this.id_kategori_item_ca);
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
			title		: title
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
		,	url		: m_ref_pha_item_consequences_analysis_d +'submit_kategori_item_ca.jsp'
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

function M_RefPHAItemConsequencesAnalysisItem(title)
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
		,	url			: m_ref_pha_item_consequences_analysis_d +'data_item_ca.jsp'
		,	autoLoad	: false
		,	listeners	: {
				scope	: this
			,	load	: function(s, r, o) {
					this.do_filter(m_ref_pha_item_consequences_analysis_category.id_kategori_item_ca);
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
			title		: title
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
				id_kategori_item_ca	: m_ref_pha_item_consequences_analysis_category.id_kategori_item_ca
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
				id_kategori_item_ca	: m_ref_pha_item_consequences_analysis_category.id_kategori_item_ca
			,	id_item_ca			: record.data['id_item_ca']
			,	nama_item_ca		: record.data['nama_item_ca']
			,	dml_type			: this.dml_type
			}
		,	url		: m_ref_pha_item_consequences_analysis_d +'submit_item_ca.jsp'
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

function M_RefPHAItemConsequencesAnalysis(title)
{
	m_ref_pha_item_consequences_analysis_category	= new M_RefPHAItemConsequencesAnalysisCategory('Kategori Item Consequences Analysis');
	m_ref_pha_item_consequences_analysis_item		= new M_RefPHAItemConsequencesAnalysisItem('Item Consequences Analysis');

	this.panel = new Ext.Panel({
			layout		: 'border'
		,	bodyBorders	: false
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			}
		,	items		: [
				m_ref_pha_item_consequences_analysis_category.panel
			,	m_ref_pha_item_consequences_analysis_item.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_pha_item_consequences_analysis_category.do_refresh(ha_level);
		m_ref_pha_item_consequences_analysis_item.do_refresh(ha_level);
	}
}

function M_RefPHARiskFrequency(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'frequency_category' }
		,	{ name	: 'description' }
		,	{ name	: 'frequency' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_risk_frequency_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_frequency_category = new Ext.form.TextField({
			allowBlank	: false
		});

	this.form_description = new Ext.form.TextField({
			allowBlank	: false
		});

	this.form_frequency = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Frequency Category'
			, dataIndex	: 'frequency_category'
			, sortable	: true
			, editor	: this.form_frequency_category
			, width		: 150
			, align		: 'center'
			}
		,	{ header	: 'Frequency'
			, dataIndex	: 'frequency'
			, sortable	: true
			, editor	: this.form_frequency
			, width		: 150
			}
		,	{ id		: 'description'
			, header	: 'Description'
			, dataIndex	: 'description'
			, sortable	: true
			, editor	: this.form_description
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length
					&& this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'description'
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
		this.form_frequency_category.setDisabled(false);
		
		this.record_new = new this.record({
				frequency_category	: ''
			,	description			: ''
			,	frequency			: ''
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
				frequency_category	: record.data['frequency_category']
			,	description			: record.data['description']
			,	frequency			: record.data['frequency']
			,	dml_type			: this.dml_type
			}
		,	url		: m_ref_pha_risk_frequency_d +'submit.jsp'
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
		this.form_frequency_category.setDisabled(true);
		
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHARiskCategory(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'consequence_category' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_risk_category_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_consequence_category = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'consequence_category'
			, header	: 'Consequence Category'
			, dataIndex	: 'consequence_category'
			, sortable	: true
			, editor	: this.form_consequence_category
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length
					&& this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'consequence_category'
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
		this.form_consequence_category.setDisabled(false);
		
		this.record_new = new this.record({
				consequence_category	: ''
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
				consequence_category	: record.data['consequence_category']
			,	dml_type				: this.dml_type
			}
		,	url		: m_ref_pha_risk_category_d +'submit.jsp'
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
		this.form_consequence_category.setDisabled(true);
		
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHARiskConsequenceCategory(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'consequence' }
		,	{ name	: 'consequence_category' }
		,	{ name	: 'description' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_risk_consequence_d +'data_consequence_category.jsp'
		,	autoLoad: false
		});

	this.store_consequence_category = new Ext.data.ArrayStore({
			fields	: ['id']
		,	url		: m_ref_pha_risk_category_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_consequence_category = new Ext.form.ComboBox({
			store			: this.store_consequence_category
		,	valueField		: 'id'
		,	displayField	: 'id'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_description = new Ext.form.TextArea({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Consequence Category'
			, dataIndex	: 'consequence_category'
			, sortable	: true
			, editor	: this.form_consequence_category
			, renderer	: combo_renderer(this.form_consequence_category)
			, width		: 150
			, align		: 'center'
			}
		,	{ id		: 'description'
			, header	: 'Description'
			, dataIndex	: 'description'
			, sortable	: true
			, editor	: this.form_description
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'description'
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
		if (m_ref_pha_consequence == '') {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu Data Consequence terlebih dahulu!");
			return;
		}

		this.form_consequence_category.setDisabled(false);
		
		this.record_new = new this.record({
				consequence				: ''
			,	consequence_category	: ''
			,	description				: ''
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
				consequence				: m_ref_pha_consequence
			,	consequence_category	: record.data['consequence_category']
			,	description				: record.data['description']
			,	dml_type				: this.dml_type
			}
		,	url		: m_ref_pha_risk_consequence_d +'submit_consequence_category.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh(this.ha_level);
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_ref_pha_consequence == '') {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu Data Consequence terlebih dahulu!");
			return;
		}

		this.form_consequence_category.setDisabled(true);
		
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_consequence_category.load({
			callback	: function(){
				this.store.load({
					params		: {
						consequence	: m_ref_pha_consequence
					}
				});
			}
		,	scope		: this				
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (this.ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}
}

function M_RefPHARiskConsequenceConsequence(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'consequence' }
		,	{ name	: 'note' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_risk_consequence_d +'data_consequence.jsp'
		,	autoLoad: false
		});

	this.form_consequence = new Ext.form.TextArea({
			allowBlank	: false
		});

	this.form_note = new Ext.form.TextArea({
			allowBlank	: true
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'consequence'
			, header	: 'Consequence'
			, dataIndex	: 'consequence'
			, sortable	: true
			, editor	: this.form_consequence
			}
		,	{ header	: 'Note'
			, dataIndex	: 'note'
			, sortable	: true
			, editor	: this.form_note
			, width		: 200
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_ref_pha_consequence	= data[0].data['consequence'];
					} else {
						m_ref_pha_consequence	= '';
					}
					
					consequence_master_on_select_load_detail();
				}
			}
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	region		: 'north'
		,	height		: 200
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'consequence'
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
		this.form_consequence.setDisabled(false);
		
		this.record_new = new this.record({
				consequence	: ''
			,	note		: ''
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
				consequence	: record.data['consequence']
			,	note		: record.data['note']
			,	dml_type	: this.dml_type
			}
		,	url		: m_ref_pha_risk_consequence_d +'submit_consequence.jsp'
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
		this.form_consequence.setDisabled(true);
		
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (this.ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}
}

function M_RefPHARiskConsequence(title)
{
	m_ref_pha_risk_consequence_consequence	= new M_RefPHARiskConsequenceConsequence('Consequence');
	m_ref_pha_risk_consequence_category		= new M_RefPHARiskConsequenceCategory('Consequence Category');

	this.panel = new Ext.Panel({
			layout		: 'border'
		,	bodyBorders	: false
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			}
		,	items		: [
				m_ref_pha_risk_consequence_consequence.panel
			,	m_ref_pha_risk_consequence_category.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_pha_consequence = '';
		
		m_ref_pha_risk_consequence_consequence.do_refresh(ha_level);
	}
}

function M_RefPHARiskDefinition(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'risk_score' }
		,	{ name	: 'risk_score_old' }
		,	{ name	: 'description' }
		,	{ name	: 'note' }
		,	{ name	: 'action_required' }
		,	{ name	: 'pha_recommendation' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_risk_definition_d +'data.jsp'
		,	autoLoad: false
		});

	this.form_risk_score = new Ext.form.TextField({
			allowBlank	: false
		});

	this.form_description = new Ext.form.TextField({
			allowBlank	: false
		});

	this.form_note = new Ext.form.TextArea({
			allowBlank	: false
		});

	this.form_action_required = new Ext.form.TextArea({
			allowBlank	: false
		});
		
	this.form_pha_recommendation = new Ext.form.TextArea({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Risk Score'
			, dataIndex	: 'risk_score'
			, sortable	: true
			, align		: 'center'
			, editor	: this.form_risk_score
			, width		: 80
			}
		,	{ header	: 'Description'
			, dataIndex	: 'description'
			, sortable	: true
			, editor	: this.form_description
			, width		: 100
			}
		,	{ header	: 'Note'
			, dataIndex	: 'note'
			, sortable	: true
			, editor	: this.form_note
			, width		: 150
			}
		,	{ header	: 'Action Required'
			, dataIndex	: 'action_required'
			, sortable	: true
			, editor	: this.form_action_required
			, width		: 200
			}
		,	{ id		: 'pha_recommendation'
			, header	: 'PHA Recommendation'
			, dataIndex	: 'pha_recommendation'
			, sortable	: true
			, editor	: this.form_pha_recommendation
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length
					&& this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = MyRowEditor(this);

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

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'pha_recommendation'
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
				risk_score			: ''
			,	description			: ''
			,	note				: ''
			,	action_required		: ''
			,	pha_recommendation	: ''
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
				risk_score			: record.data['risk_score']
			,	risk_score_old		: record.data['risk_score_old']
			,	description			: record.data['description']
			,	note				: record.data['note']
			,	action_required		: record.data['action_required']
			,	pha_recommendation	: record.data['pha_recommendation']
			,	dml_type			: this.dml_type
			}
		,	url		: m_ref_pha_risk_definition_d +'submit.jsp'
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
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_RefPHARiskMatrix(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'frequency_category' }
		,	{ name	: 'consequence_category' }
		,	{ name	: 'risk_score' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_pha_risk_matrix_d +'data.jsp'
		,	autoLoad: false
		});

	this.store_risk_score = new Ext.data.ArrayStore({
			fields	: ['id']
		,	url		: m_ref_pha_risk_matrix_d +'data_ref_risk_score.jsp'
		,	autoLoad: false
	});

	this.form_frequency_category = new Ext.form.TextField({});

	this.form_consequence_category = new Ext.form.TextField({});
	
	this.form_risk_score = new Ext.form.ComboBox({
			store			: this.store_risk_score
		,	valueField		: 'id'
		,	displayField	: 'id'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Frequency'
			, dataIndex	: 'frequency_category'
			, sortable	: true
			, editor	: this.form_frequency_category
			, width		: 150
			, align		: 'center'
			}
		,	{ header	: 'Consequence'
			, dataIndex	: 'consequence_category'
			, sortable	: true
			, editor	: this.form_consequence_category
			, width		: 150
			, align		: 'center'
			}
		,	{ header	: 'Risk Ranking'
			, dataIndex	: 'risk_score'
			, sortable	: true
			, editor	: this.form_risk_score
			, renderer	: combo_renderer(this.form_risk_score)
			, width		: 150
			, align		: 'center'
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		});

	this.editor = MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.do_load();
			}
		});

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_ref
			]
		});

	this.panel = new Ext.grid.GridPanel({
			title		: title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoScroll	: true
		,   listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
                        }
		});

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
				frequency_category		: record.data['frequency_category']
			,	consequence_category	: record.data['consequence_category']
			,	risk_score				: record.data['risk_score']
			,	dml_type				: this.dml_type
			}
		,	url		: m_ref_pha_risk_matrix_d +'submit.jsp'
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
		this.form_frequency_category.setDisabled(true);
		this.form_consequence_category.setDisabled(true);
		
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_risk_score.load({
			callback	: function(){
				this.store.load();
			}
		,	scope		: this				
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();
	}
}

function M_RefPHA()
{
	m_ref_pha_work_steps					= new M_RefPHAWorkSteps('Work Steps');
	m_ref_pha_jabatan						= new M_RefPHAJabatan('Jabatan');
	m_ref_pha_properties					= new M_RefPHAProperties('Properties');
	m_ref_pha_material						= new M_RefPHAMaterial('Material');
	m_ref_pha_chemical_interaction_matrix	= new M_RefPHAChemicalInteractionMatrix('Chemical Interaction Matrix');
	m_ref_pha_hazard						= new M_RefPHAHazard('Hazard');
	m_ref_pha_item_consequences_analysis	= new M_RefPHAItemConsequencesAnalysis('Item Consequences Analysis');
	m_ref_pha_risk_frequency				= new M_RefPHARiskFrequency('Risk Frequency');
	m_ref_pha_risk_category					= new M_RefPHARiskCategory('Risk Category');
	m_ref_pha_risk_consequence				= new M_RefPHARiskConsequence('Risk Consequence');
	m_ref_pha_risk_definition				= new M_RefPHARiskDefinition('Risk Definition');
	m_ref_pha_risk_matrix					= new M_RefPHARiskMatrix('Risk Matrix');

	this.store = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	data	: [[0,'Work Steps'],
					   [1,'Jabatan'],
					   [2,'Properties'],
					   [3,'Material'],
					   [4,'Chemical Interaction Matrix'],
					   [5,'Hazard'],
					   [6,'Item Consequences Analysis'],
					   [7,'Risk Frequency'],
					   [8,'Risk Category'],
					   [9,'Risk Consequence'],
					   [10,'Risk Definition'],
					   [11,'Risk Matrix']]
	});

	this.form_name = new Ext.form.TextField({});

	this.columns = [
		{ id		: 'nama_menu'
		, header	: 'Nama Menu'
		, dataIndex	: 'name'
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
						this.panel_detail.layout.setActiveItem(data[0].data['id']);
					}
				}
			}
	});

	this.panel_menu = new Ext.grid.GridPanel({
			title				: 'Menu'
		,	region				: 'west'
		,	width				: '18%'
		,	collapsible			: true
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	autoExpandColumn	: 'nama_menu'
	});

	this.panel_detail = new Ext.Panel({
			layout		: 'card'
		,	region		: 'center'
		,	activeItem	: 0
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_ref_pha_work_steps.panel
			,	m_ref_pha_jabatan.panel
			,	m_ref_pha_properties.panel
			,	m_ref_pha_material.panel
			,	m_ref_pha_chemical_interaction_matrix.panel
			,	m_ref_pha_hazard.panel
			,	m_ref_pha_item_consequences_analysis.panel
			,	m_ref_pha_risk_frequency.panel
			,	m_ref_pha_risk_category.panel
			,	m_ref_pha_risk_consequence.panel
			,	m_ref_pha_risk_definition.panel
			,	m_ref_pha_risk_matrix.panel
			]
	});

	this.panel = new Ext.Panel({
			id			: 'ref_pha_panel'
		,	layout		: 'border'
		,	region		: 'center'
		,	bodyBorder	: false
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				this.panel_menu
			,	this.panel_detail
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_pha_ha_level	= ha_level;

		m_ref_pha_work_steps.do_refresh(ha_level);
		m_ref_pha_jabatan.do_refresh(ha_level);
		m_ref_pha_properties.do_refresh(ha_level);
		m_ref_pha_material.do_refresh(ha_level);
		m_ref_pha_chemical_interaction_matrix.do_refresh(ha_level);
		m_ref_pha_hazard_process.do_refresh(ha_level);
		m_ref_pha_hazard_pressure.do_refresh(ha_level);
		m_ref_pha_item_consequences_analysis.do_refresh(ha_level);
		m_ref_pha_risk_frequency.do_refresh(ha_level);
		m_ref_pha_risk_category.do_refresh(ha_level);
		m_ref_pha_risk_consequence.do_refresh(ha_level);
		m_ref_pha_risk_definition.do_refresh(ha_level);
		m_ref_pha_risk_matrix.do_refresh(ha_level);
	}
}

m_ref_pha = new M_RefPHA();

//@ sourceURL=ref_pha.layout.js
