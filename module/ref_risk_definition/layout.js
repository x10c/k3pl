/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */
var m_ref_risk_definition;
var m_ref_risk_definition_d = _g_root +'/module/ref_risk_definition/';

function M_RefRiskDefinition(title)
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
		,	url		: m_ref_risk_definition_d +'data.jsp'
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
			, width		: 100
			}
		,	{ header	: 'Description'
			, dataIndex	: 'description'
			, sortable	: true
			, editor	: this.form_description
			, width		: 150
			}
		,	{ header	: 'Note'
			, dataIndex	: 'note'
			, sortable	: true
			, editor	: this.form_note
			, width		: 200
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
			id			: 'ref_risk_definition_panel'
		,	title		: title
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
		,	url		: m_ref_risk_definition_d +'submit.jsp'
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

		if (ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

m_ref_risk_definition = new M_RefRiskDefinition('Risk Definition');

//@ sourceURL=ref_risk_definition.layout.js
