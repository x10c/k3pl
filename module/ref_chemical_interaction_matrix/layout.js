/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */
var m_ref_chemical_interaction_matrix;
var m_ref_chemical_interaction_matrix_d = _g_root +'/module/ref_chemical_interaction_matrix/';

function M_RefChemicalInteractionMatrix(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_material' }
		,	{ name	: 'id_material_old' }
		,	{ name	: 'id_material_interaction' }
		,	{ name	: 'id_material_interaction_old' }
		,	{ name	: 'interaction' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_chemical_interaction_matrix_d +'data.jsp'
		,	autoLoad: false
		});

	this.store_material = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/ref_material/data.jsp'
		,	autoLoad: false
		});

	this.store_material_interaction = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/ref_material_interaction/data.jsp'
		,	autoLoad: false
		});

	this.form_material = new Ext.form.ComboBox({
			store			: this.store_material
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});

	this.form_material_interaction = new Ext.form.ComboBox({
			store			: this.store_material_interaction
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});

	this.form_interaction = new Ext.form.TextArea({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_material'
			, header	: 'Material 1'
			, dataIndex	: 'id_material'
			, sortable	: true
			, editor	: this.form_material
			, renderer	: combo_renderer(this.form_material)
			, width		: 200
			}
		,	{ header	: 'Material 2'
			, dataIndex	: 'id_material_interaction'
			, sortable	: true
			, editor	: this.form_material_interaction
			, renderer	: combo_renderer(this.form_material_interaction)
			, width		: 200
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
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		});

	this.panel = new Ext.grid.GridPanel({
			id			: 'ref_chemical_interaction_matrix_panel'
		,	title		: title
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
			,	id_material_old				: ''
			,	id_material_interaction		: ''
			,	id_material_interaction_old	: ''
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
			,	id_material_old				: record.data['id_material_old']
			,	id_material_interaction		: record.data['id_material_interaction']
			,	id_material_interaction_old	: record.data['id_material_interaction_old']
			,	interaction					: record.data['interaction']
			,	dml_type					: this.dml_type
			}
		,	url		: m_ref_chemical_interaction_matrix_d +'submit.jsp'
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
		this.store_material.load({
			callback	: function(){
				this.store_material_interaction.load({
					callback	: function(){
						this.store.load();
					}
				,	scope		: this				
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();

		if (ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

m_ref_chemical_interaction_matrix = new M_RefChemicalInteractionMatrix('Chemical Interaction Matrix');

//@ sourceURL=ref_chemical_interaction_matrix.layout.js
