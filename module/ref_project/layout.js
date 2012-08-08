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
				[0,'Belum ada']
			,	[1,'Sudah ada']
			]
	});

	this.form_id = new Ext.form.TextField ({
			name		: 'id_project'
		,	hidden		: true
		});
	
	this.form_pha = new Ext.form.ComboBox({
			fieldLabel		: 'PHA'
		,	name			: 'pha'
		,	store			: this.store_process
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	hidden			: true
		});
	
	this.form_pssr = new Ext.form.ComboBox({
			fieldLabel		: 'PSSR'
		,	name			: 'pssr'
		,	store			: this.store_process
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	hidden			: true
		});

	this.form_csm = new Ext.form.ComboBox({
			fieldLabel		: 'CSM'
		,	name			: 'csm'
		,	store			: this.store_process
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	hidden			: true
		});	
	
	this.form_no_project = new Ext.form.TextField({
			fieldLabel		: 'Nomor'
		,	name			: 'no_project'
		,	allowBlank		: false
		});

	this.form_nama_project = new Ext.form.TextField({
			fieldLabel		: 'Nama'
		,	name			: 'nama_project'
		,	allowBlank		: false
		});

	this.form_tanggal_mulai = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Mulai'
		,	name			: 'tanggal_mulai'
		,	emptyText		: 'Y-M-D'
		,	format			: 'Y-m-d'
		,	editable		: false
		,	allowBlank		: false
		});

	this.form_durasi = new Ext.form.NumberField({
			fieldLabel		: 'Durasi (Hari)'
		,	name			: 'durasi'
		,	allowDecimals	: false
		,	allowNegative	: false
		});

	this.form_keterangan = new Ext.form.TextArea({
			fieldLabel		: 'Keterangan'
		,	name			: 'keterangan'
		,	width			: 200
		,	height			: 100
		});

	this.form_btn_save = new Ext.Button ({
			text		: 'Simpan'
		,	iconCls		: 'save16'
		,	scope		: this
		,	formBind	: true
		,	handler		: function() {
				this.do_save ();
			}
		});

	this.form = new Ext.form.FormPanel ({
			padding		: 6
		,	labelAlign	: 'right'
		,	items		: [
				this.form_id
			,	this.form_no_project
			,	this.form_nama_project
			,	this.form_tanggal_mulai
			,	this.form_durasi
			,	this.form_keterangan
			]
		,	buttons		: [
				this.form_btn_save
			]
		});

	this.win = new Ext.Window ({
			title		: 'Data Project'
		,	width		: 400
		,	autoHeight	: true
		,	closeAction	: 'hide'
		,	items		: [
				this.form
			]
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'No. Project'
			, dataIndex	: 'no_project'
			, sortable	: true
			, width		: 150
			}
		,	{ header	: 'Nama Project'
			, dataIndex	: 'nama_project'
			, sortable	: true
			, width		: 300
			}
		,	{ header	: 'Tanggal Mulai'
			, dataIndex	: 'tanggal_mulai'
			, sortable	: true
			, width		: 100
			, align		: 'center'
			}
		,	{ header	: 'Durasi (Hari)'
			, dataIndex	: 'durasi'
			, sortable	: true
			, width		: 100
			, align		: 'center'
			}
		,	{ id		: 'pha'
			, header	: 'PHA'
			, dataIndex	: 'pha'
			, sortable	: true
			, renderer	: store_renderer ('id', 'name', this.store_process)
			}
		,	{ id		: 'pssr'
			, header	: 'PSSR'
			, dataIndex	: 'pssr'
			, sortable	: true
			, renderer	: store_renderer ('id', 'name', this.store_process)
			}
		,	{ id		: 'csm'
			, header	: 'CSM'
			, dataIndex	: 'csm'
			, sortable	: true
			, renderer	: store_renderer ('id', 'name', this.store_process)
			}
		,	{ id		: 'keterangan'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan'
			, width		: 300
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

	this.btn_edit = new Ext.Button ({
			text		: 'Edit'
		,	iconCls		: 'edit16'
		,	scope		: this
		,	handler		: function() {
				this.do_edit();
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
			,	this.btn_edit
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		});

	this.panel = new Ext.grid.GridPanel({
			id				: 'ref_project_panel'
		,	title			: title
		,	store			: this.store
		,	sm				: this.sm
		,	columns			: this.columns
		,	tbar			: this.toolbar
		,	listeners       : {
				scope		: this
			,	rowdblclick	: function (g, r, e) {
					return this.do_edit ();
				}
			}
		});

	this.do_add = function()
	{
		this.form.getForm ().reset ();
		this.win.show ();

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length || this.ha_level < 4) {
			return;
		}

		this.form.getForm ().loadRecord (data[0]);
		this.dml_type = 4;
		this.do_save ();
	}

	this.do_save = function ()
	{
		var form = this.form.getForm ();

		if (! form.isValid ()) {
			Ext.Msg.alert ('Kesalahan', 'Silahkan isi semua kolom yang berwarna merah');
			return;
		}

		form.submit ({
			url		: m_ref_project_d +'submit.jsp'
		,	params	: {
				dml_type	: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success : function (form, resp)
				{
					if (resp.result.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
						return;
					}

					this.store.load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function ()
	{
		var data = this.sm.getSelections();
		if (data.length <= 0 || this.ha_level < 3) {
			return false;
		}

		this.form.getForm ().loadRecord (data[0]);
		this.dml_type = 3;
		this.win.show ();

		return true;
	}

	this.do_load = function()
	{	
		this.store.reload ();
	}

	this.do_refresh = function (ha_level)
	{
		this.ha_level = ha_level;
		this.do_load ();

		if (ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

m_ref_project = new M_RefProject('Project');

//@ sourceURL=ref_project.layout.js
