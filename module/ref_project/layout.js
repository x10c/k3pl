/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - prasetya (prasetya.yanuar@gmail.com)
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_project;
var m_ref_project_d = _g_root +'/module/ref_project/';

function M_RefProject(title)
{
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_project' }
		,	{ name	: 'no_project' }
		,	{ name	: 'nama_project' }
		,	{ name	: 'tanggal_mulai' }
		,	{ name	: 'durasi' }
		,	{ name	: 'keterangan' }
		,	{ name	: 'pha' }
		,	{ name	: 'pssr' }
		,	{ name	: 'csm' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_project_d +'data.jsp'
		,	autoLoad: false
	});
	
	this.store_process = new Ext.data.ArrayStore ({
			fields: ['id','name']
		,	data:	[
				['0','Belum ada']
			,	['1','Sudah ada']
			]
	});
	
	this.form_pha = new Ext.form.ComboBox({
			store		: this.store_process
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});
	
	this.form_pssr = new Ext.form.ComboBox({
			store		: this.store_process
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});
	
	this.form_csm = new Ext.form.ComboBox({
			store		: this.store_process
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});	
	
	this.form_no_project = new Ext.form.TextField({
			allowBlank	: false
	});

	this.form_nama_project = new Ext.form.TextField({
			allowBlank	: false
	});

	this.form_tanggal_mulai = new Ext.form.DateField({
			emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
	});

	this.form_durasi = new Ext.form.NumberField({
			allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_keterangan = new Ext.form.TextField({});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'No. Project'
			, dataIndex	: 'no_project'
			, sortable	: true
			, width		: 150
			, editor	: this.form_no_project
			}
		,	{ header	: 'Nama Project'
			, dataIndex	: 'nama_project'
			, sortable	: true
			, width		: 300
			, editor	: this.form_nama_project
			}
		,	{ header	: 'Tanggal Mulai'
			, dataIndex	: 'tanggal_mulai'
			, sortable	: true
			, width		: 100
			, align		: 'center'
			, editor	: this.form_tanggal_mulai
			}
		,	{ header	: 'Durasi (Hari)'
			, dataIndex	: 'durasi'
			, sortable	: true
			, width		: 100
			, align		: 'center'
			, editor	: this.form_durasi
			}
		,	{ id		: 'keterangan'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan'
			, sortable	: true
			, editor	: this.form_keterangan
			}
		,	{ id		: 'pha'
			, header	: 'PHA'
			, dataIndex	: 'pha'
			, sortable	: true
			, editor	: this.form_pha
			, renderer	: combo_renderer(this.form_pha)
			}
		,	{ id		: 'pssr'
			, header	: 'PSSR'
			, dataIndex	: 'pssr'
			, sortable	: true
			, renderer	: combo_renderer(this.form_pssr)
			}
		,	{ id		: 'csm'
			, header	: 'CSM'
			, dataIndex	: 'csm'
			, sortable	: true
			, renderer	: combo_renderer(this.form_csm)
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
			id			: 'ref_project_panel'
		,	title		: title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'keterangan'
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
				id_project		: ''
			,	no_project		: ''
			,	nama_project	: ''
			,	tanggal_mulai	: ''
			,	durasi			: ''
			,	keterangan		: ''
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
				id_project		: record.data['id_project']
			,	no_project		: record.data['no_project']
			,	nama_project	: record.data['nama_project']
			,	tanggal_mulai	: record.data['tanggal_mulai']
			,	durasi			: record.data['durasi']
			,	keterangan		: record.data['keterangan']
			,	dml_type		: this.dml_type
			}
		,	url		: m_ref_project_d +'submit.jsp'
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
		//this.store_process.load();
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

m_ref_project = new M_RefProject('Project');

//@ sourceURL=ref_project.layout.js
