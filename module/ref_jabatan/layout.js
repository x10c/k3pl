/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_ref_jabatan;
var m_ref_jabatan_d = _g_root +'/module/ref_jabatan/';

function M_RefJabatan(title)
{
	this.title	= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_jabatan' }
		,	{ name	: 'nama_jabatan' }
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: m_ref_jabatan_d +'data_jabatan.jsp'
		,	autoLoad: false
		});

	this.form_nama_jabatan = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nama_jabatan'
			, header	: 'Nama'
			, dataIndex	: 'nama_jabatan'
			, sortable	: true
			, editor	: this.form_nama_jabatan
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && this.ha_level == 4) {
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

	this.panel = new Ext.grid.GridPanel({
			id		: 'ref_jabatan_panel'
		,	title		: this.title
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nama_jabatan'
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
				id_jabatan	: ''
			,	nama_jabatan	: ''
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
				id_jabatan	: record.data['id_jabatan']
			,	nama_jabatan	: record.data['nama_jabatan']
			,       dml_type	: this.dml_type
			}
		,	url	: m_ref_jabatan_d +'submit_jabatan.jsp'
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

		if (ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

m_ref_jabatan = new M_RefJabatan('Jabatan');

//@ sourceURL=ref_jabatan.layout.js
