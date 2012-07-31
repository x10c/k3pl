/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *	 - prasetya (prasetya.yanuar@googlemail.com)
 */

var m_pssr_entry;
var m_pssr_entry_master;
var m_pssr_entry_master_add;
var m_pssr_entry_detail;
var m_pssr_entry_checklist;
var m_pssr_entry_id_pssr	= '';
var m_pssr_entry_ha_level	= 0;
var m_fill_form_pssr	= [];

function pssr_master_on_select_load_detail()
{
	if (typeof m_pssr_entry_master == 'undefined'
	||  typeof m_pssr_entry_detail == 'undefined'
	||  m_pssr_entry_id_pssr == '') {
		return;
	}

	m_pssr_entry_detail.do_refresh();
	m_pssr_entry_anggota.do_refresh();
	//m_pssr_entry_checklist.do_refresh();
}

function M_PssrEntryMaster(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pssr'
		},{
			name	: 'id_project'
		},{
			name	: 'tanggal_mulai'
		},{
			name	: 'lokasi'
		},{
			name	: 'tanggal'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/pssr_entry/data_pssr.jsp'
		,	autoLoad: false
	});
	
	this.form_id_pssr = new Ext.form.TextField({allowBlank : true});
	
	this.store_project = new Ext.data.ArrayStore({
			fields 	: ['id_project','no_project','nama_project','tanggal_mulai']
		,	url		: _g_root +'/module/pssr_entry/data_project.jsp'
		,	autoLoad: false
	});
	
	this.form_project = new Ext.form.ComboBox({
			store		: this.store_project
		,	valueField	: 'id_project'
		,	displayField	: 'nama_project'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		});
	this.form_lokasi = new Ext.form.TextField({allowBlank : true});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_pssr'
			, header	: 'ID PSSR'
			, dataIndex	: 'id_pssr'
			, sortable	: true
			, width		: 100
			, hidden 	: true
			, editor	: this.form_id_pssr
			}
		,	{ id		: 'id_project'
			, header	: 'Nama Project'
			, dataIndex	: 'id_project'
			, sortable	: true
			, width		: 200
			, editor	: this.form_project
			, renderer	: combo_renderer(this.form_project)
			}
		,	{ id		: 'tanggal_mulai'
			, header	: 'Tanggal Project'
			, dataIndex	: 'tanggal_mulai'
			, sortable	: true
			, width		: 100
			}
		,	{ id		: 'lokasi'
			, header	: 'Lokasi'
			, dataIndex	: 'lokasi'
			, sortable	: true
			, width		: 200
			}
		,	{ id		: 'tanggal'
			, header	: 'Tanggal PSSR'
			, dataIndex	: 'tanggal'
			, sortable	: true
			, width		: 100
			}
		]
	,	defaults	: {
			hideable	: false
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_pssr_entry_id_pssr = data[0].data['id_pssr'];
						m_pssr_entry_checklist.form_assign(data);
						// this.btn_print.setDisabled(false);
					} else {
						m_pssr_entry_id_pssr = '';
						// this.btn_print.setDisabled(true);
					}
					pssr_master_on_select_load_detail();
				}
			}
	});
	
	this.editor = new MyRowEditor(this);

	this.btn_edit = new Ext.Button({
			text		: 'Ubah'
		,	iconCls		: 'edit16'
		,	scope		: this
		,	handler		: function() {
				this.do_edit();
			}
	});

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.store.reload();
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
	
	this.btn_pssr_checklist = new Ext.Button({
			text	: 'Checklist PSSR'
		,	scope	: this
		,	handler	: function() {
				this.entry_pssr_checklist();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_edit
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		,	'->'
		,	this.btn_pssr_checklist
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
	});
	
	this.do_edit = function()
	{	
		var data = this.sm.getSelections();
		if (m_pssr_entry_ha_level >= 3) {
			m_pssr_master_con.layout.setActiveItem(m_pssr_entry_master_add.panel);
			m_pssr_entry_master_add.form_edit(data);
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		m_pssr_entry_master_add.form_add();
		m_pssr_master_con.layout.setActiveItem(m_pssr_entry_master_add.panel);
	}

	this.entry_pssr_checklist = function (){
		if (m_pssr_entry_id_pssr == '') {
			Ext.Msg.alert("Kesalahan Operasi"
		, "Silahkan pilih salah satu PSSR terlebih dahulu!");
			return;
		}
		m_pssr_entry_checklist.form_edit();
		m_pssr_entry.panel.layout.setActiveItem(m_pssr_entry_checklist.panel);
	}
	
	this.do_load = function()
	{
		this.store_project.load();
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (m_pssr_entry_ha_level <= 1) {
			this.btn_edit.setDisabled(true);
			this.btn_add.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
			this.btn_add.setDisabled(false);
		}

		this.do_load();
	}
}

function M_PssrEntryMasterAdd(title)
{
	this.title	= title;
	this.dml_type	= 0;
	
	this.store_project = new Ext.data.ArrayStore({
			fields 	: ['id_project','no_project','nama_project','tanggal_mulai']
		,	url		: _g_root +'/module/pssr_entry/data_project.jsp'
		,	autoLoad: false
	});
	
	this.form_project = new Ext.form.ComboBox({
			store		: this.store_project
		,	fieldLabel	: 'Project'
		,	valueField	: 'id_project'
		,	displayField	: 'nama_project'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_project_on_select(record.get('tanggal_mulai'));
				}
			}
		});
		
	this.form_id_pssr = new Ext.form.TextField({fieldLabel : 'Id PSSR', allowBlank : true, hidden : true});
	this.form_lokasi = new Ext.form.TextField({fieldLabel : 'Lokasi' , allowBlank : false});
	this.form_tanggal_project = new Ext.form.DateField({
			fieldLabel 	: 'Tanggal Project'
		,	emptyText	: 'Thn-Bln-Tgl'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		,	disabled	: true
		,	width		: 100 });
		
	this.form_tanggal = new Ext.form.DateField({
			fieldLabel 	: 'Tanggal PSSR'
		,	emptyText	: 'Thn-Bln-Tgl'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 100 });
	
	

	this.btn_save = new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
		});
		
	this.btn_cancel = new Ext.Button({
			text		: 'Batal'
		,	iconCls		: 'del16'
		,	scope		: this
		,	handler		: function() {
				this.do_cancel();
			}
		});

	this.panel = new Ext.form.FormPanel({
			title				: this.title
		,	region				: 'center'
		,	labelAlign	: 'right'
		,	labelWidth	: 220
		,	autoWidth	: true
		,	autoHeight	: true
		,	bodyCssClass	: 'stop-panel-form'
		,	style		: 'margin: 8px;'
		,	tbar				: [
				this.btn_cancel
			,	'->'
			,	this.btn_save
			]
		,	items :[
			this.form_id_pssr
			, this.form_project
			, this.form_tanggal_project
			, this.form_lokasi
			, this.form_tanggal
			]
		});

	this.form_project_on_select = function(tanggal_mulai)
	{
			this.form_tanggal_project.setValue(tanggal_mulai);
	}
	
	this.form_add = function()
	{
		this.store_project.load();
		
		this.form_id_pssr.setValue('');
		this.form_project.setValue('');
		this.form_tanggal_project.setValue('');
		this.form_lokasi.setValue('');
		this.form_tanggal.setValue('');

		this.dml_type = 2;
	}

	this.do_cancel = function()
	{
		m_pssr_master_con.layout.setActiveItem(m_pssr_entry_master.grid);
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id_pssr					: this.form_id_pssr.getValue()
			,	id_project				: this.form_project.getValue()
			,	lokasi					: this.form_lokasi.getValue()
			,	tanggal					: this.form_tanggal.getValue()
			,   dml_type				: this.dml_type
			}
		,	url	: _g_root +'/module/pssr_entry/submit_pssr.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}
					
					m_pssr_master_con.layout.setActiveItem(m_pssr_entry_master.grid);
					m_pssr_entry_master.do_load();
				}
		,	scope	: this
		});
	}

	this.form_edit = function(data)
	{
		this.store_project.load();
		
		this.form_id_pssr.setValue(data[0].data['id_pssr']);
		this.form_project.setValue(data[0].data['id_project']);
		this.form_tanggal_project.setValue(data[0].data['tanggal_mulai']);
		this.form_lokasi.setValue(data[0].data['lokasi']);
		this.form_tanggal.setValue(data[0].data['tanggal']);
		
		this.dml_type = 3;
	}
}

function M_PssrEntryDokumen(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pssr'
		},{
			name	: 'id_pssr_reference'
		},{
			name	: 'reference'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/pssr_entry/data_dokumen_pssr.jsp'
		,	autoLoad: false
		});
		
	this.form_id_pssr = new Ext.form.TextField({allowBlank : true, hidden:true});
	this.form_id_pssr_reference = new Ext.form.TextField({allowBlank : true, hidden:true});
	this.form_reference = new Ext.form.TextField({allowBlank : true});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_pssr'
			, header	: 'PSSR'
			, dataIndex	: 'id_pssr'
			, sortable	: true
			, width		: 100
			, editor	: this.form_id_pssr
			, hidden	:true
			}
		,	{ id		: 'id_pssr_reference'
			, header	: 'ID REFERENSI PSSR'
			, dataIndex	: 'id_pssr_reference'
			, sortable	: true
			, width		: 100
			, editor	: this.form_id_pssr_reference
			, hidden	:true
			}
		,	{ id		: 'reference'
			, header	: 'Dokumen Referensi'
			, dataIndex	: 'reference'
			, sortable	: true
			, width		: 250
			, editor	: this.form_reference
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_pssr_entry_ha_level == 4) {
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
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	plugins				: [this.editor]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'reference'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
		});

	this.do_add = function()
	{
		if (m_pssr_entry_id_pssr == '') {
			Ext.Msg.alert("Kesalahan Operasi"
		, "Silahkan pilih salah satu PSSR terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pssr 							: m_pssr_entry_id_pssr
			,	id_pssr_reference				: ''
			,	reference						: ''
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
				id_pssr							: record.data['id_pssr']
			,	id_pssr_reference			: record.data['id_pssr_reference']
			,	reference					: record.data['reference']
			,   dml_type						: this.dml_type
			}
		,	url	: _g_root +'/module/pssr_entry/submit_dokumen_pssr.jsp'
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
		if (m_pssr_entry_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_pssr	: m_pssr_entry_id_pssr
			}
		});
	}

	this.do_refresh = function()
	{	
		if (m_pssr_entry_ha_level <= 1) {
			this.btn_del.setDisabled(true);
			this.btn_add.setDisabled(true);
		} else {
			this.btn_del.setDisabled(false);
			this.btn_add.setDisabled(false);
		}
		
		this.do_load();
	}
}

function M_PssrEntryAnggota(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pssr'
		},{
			name	: 'nipg'
		},{
			name	: 'nipg_old'
		},{
			name	: 'id_departemen'
		},{
			name	: 'id_jabatan_pssr'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/pssr_entry/data_anggota_pssr.jsp'
		,	autoLoad: false
		});
		
	this.store_peg = new Ext.data.ArrayStore ({
			fields : ['id', 'name','id_dep']
		,	url : _g_root +'/module/pssr_entry/data_ref_pegawai.jsp'
		,	autoLoad : false
		,	idIndex : 0
	});
	
	this.store_departemen = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id_divprosbu', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_departemen.jsp'
		,	autoLoad	: false
		,	idIndex		: 2
		});
	
	this.form_departemen = new Ext.form.ComboBox({
			fieldLabel	: 'Departemen'
		,	store		: this.store_departemen
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: true
		,	typeAhead	: true
		,	triggerAction	: 'all'
		,	width		: 400
		});
	
	this.store_jab_pssr = new Ext.data.ArrayStore ({
			fields : ['id_jabatan_pssr', 'nama_jabatan_pssr']
		,	url : _g_root +'/module/ref_jab_pssr/data.jsp'
		,	autoLoad : false
		,	idIndex : 0
	});
	
	this.form_id_pssr = new Ext.form.TextField({allowBlank : true, hidden:true});
	this.form_peg = new Ext.form.ComboBox({
			store			: this.store_peg
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_jabatan_pssr = new Ext.form.ComboBox({
			store			: this.store_jab_pssr
		,	valueField		: 'id_jabatan_pssr'
		,	displayField	: 'nama_jabatan_pssr'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_pssr'
			, header	: 'PSSR'
			, dataIndex	: 'id_pssr'
			, sortable	: true
			, width		: 100
			, editor	: this.form_id_pssr
			, hidden	:true
			}
		,	{ id		: 'nipg'
			, header	: 'Nama Pegawai'
			, dataIndex	: 'nipg'
			, sortable	: true
			, width		: 300
			, editor	: this.form_peg
			, renderer	: combo_renderer(this.form_peg)
			}
		,	{ id		: 'id_jabatan_pssr'
			, header	: 'Jabatan PSSR'
			, dataIndex	: 'id_jabatan_pssr'
			, sortable	: true
			, width		: 200
			, editor	: this.form_jabatan_pssr
			, renderer 	: combo_renderer(this.form_jabatan_pssr)
			}
		,	{ id		: 'id_departemen'
			, header	: 'Departemen'
			, dataIndex	: 'id_departemen'
			, sortable	: true
			, width		: 200
			, renderer 	: combo_renderer(this.form_departemen)
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_pssr_entry_ha_level == 4) {
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
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	plugins				: [this.editor]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nipg'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
		});
	
	
	this.do_add = function()
	{
		if (m_pssr_entry_id_pssr == '') {
			Ext.Msg.alert("Kesalahan Operasi"
		, "Silahkan pilih salah satu PSSR terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pssr 							: m_pssr_entry_id_pssr
			,	nipg				: ''
			,	id_jabatan_pssr						: ''
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
				id_pssr							: record.data['id_pssr']
			,	nipg			: record.data['nipg']
			,	nipg_old			: record.data['nipg_old']
			,	id_jabatan_pssr					: record.data['id_jabatan_pssr']
			,   dml_type						: this.dml_type
			}
		,	url	: _g_root +'/module/pssr_entry/submit_anggota_pssr.jsp'
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
		if (m_pssr_entry_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{	
		this.store_departemen.load({
			callback	: function(){
				this.store_peg.load({
					callback	: function(){
						this.store_jab_pssr.load({
							callback	: function(){
								this.store.load({
									params		: {
										id_pssr	: m_pssr_entry_id_pssr
									}
								});
							}
						,	scope		: this				
						});
					}
				,	scope		: this
				});
			}
		,	scope	:this
		});
		
	}

	this.do_refresh = function()
	{	
		if (m_pssr_entry_ha_level <= 1) {
			this.btn_del.setDisabled(true);
			this.btn_add.setDisabled(true);
		} else {
			this.btn_del.setDisabled(false);
			this.btn_add.setDisabled(false);
		}
		
		this.do_load();
	}
}

function M_PssrInputDetail(_i, _j, id, title, data)
{
	this._i			= _i;
	this._j			= _j;
	this.id			= id;
	this.title		= title;
	this.data		= data;
	this.cb_id		= 'cb_all_safe_'+ _i +'_'+ _j;

	this.reader = new Ext.data.JsonReader({
		fields		: [
			{name: 'kat_id'}
		,	{name: 'item_id'}
		,	{name: 'detail_id'}
		,	{name: 'detail_name'}
		,	{name: 'applicable'}
		,	{name: 'confirm_ok'}
		,	{name: 'punchlist'}
		,	{name: 'keterangan'}
		]
	,	root		: 'details'
	,	idProperty	: 'detail_id'
	});

	this.store = new Ext.data.Store({
			data 	: this.data
		,	reader	: this.reader
		});
	
	this.store_applicable = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'No']
			,	['1', 'Yes']
			]
		});
	this.store_confirm = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'No']
			,	['1', 'Yes']
			,	['2', '-']
			]
		});
	this.store_punchlist = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'Minor']
			,	['1', 'Major']
			,	['2', '-']
			]
		});
	
	this.form_applicable = new Ext.form.ComboBox({
			store		: this.store_applicable
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
		
	this.form_confirm = new Ext.form.ComboBox({
			store		: this.store_confirm
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});

	this.form_punchlist = new Ext.form.ComboBox({
			store		: this.store_punchlist
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
	
	this.form_keterangan = new Ext.form.TextField({allowBlanks:true});
		
	this.cm = new Ext.grid.ColumnModel({
		is_all_safe	: false
	,	columns		: [
			{
				id		: 'detail_name'
			,	dataIndex	: 'detail_name'
			,	width		: 220
			,	align		: 'left'
			,	header		: 'Item'
			},{
				dataIndex	: 'applicable'
			,	header		: 'Applicable'
			,	editor		: this.form_applicable
			 ,	renderer	: combo_renderer(this.form_applicable)
			,	width		: 100
			},{
				dataIndex	: 'confirm_ok'
			,	header		: 'Status (Ok)'
			,	editor		: this.form_confirm
			,	renderer	: combo_renderer(this.form_confirm)
			,	width		: 100
			},{
				dataIndex	: 'punchlist'
			,	header		: 'Punchlist'
			,	editor		: this.form_punchlist
			,	renderer	: combo_renderer(this.form_punchlist)
			,	width		: 100
			},{
				dataIndex	: 'keterangan'
			,	header		: 'Keterangan'
			,	editor		: this.form_keterangan
			,	width		: 250
			}]
	,	defaults	: {
			align		: 'center'
		,	menuDisabled	: true
		,	hideable	: false
		}
	,	scope	: this
	});

	this.panel = new Ext.grid.EditorGridPanel({
			title		: this.title
		,	id		: this.id
		,	style		: 'margin-bottom: 5px;'
		,	autoHeight	: true
		,	autoScroll	: true
		,	stripeRows	: true
		,	clicksToEdit	: 1
		,	store		: this.store
		,	colModel	: this.cm
		// ,	listeners	: {
				// afteredit	: function(e) {
					// if (e.field == 'safe') {
						// e.record.set('unsafe', m_stop_n_observed - e.record.get('safe'));
					// }
				// }
			// }
	});
}

function M_PssrEntryChecklist(title)
{
	this.title	= title;
	this.dml_type	= 0;
	this.data_pssr = '';
	
	this.store_project = new Ext.data.ArrayStore({
			fields 	: ['id_project','no_project']
		,	url		: _g_root +'/module/pssr_entry/data_project.jsp'
		,	autoLoad: false
	});
	
	this.form_project = new Ext.form.ComboBox({
			store		: this.store_project
		,	fieldLabel	: 'Project'
		,	valueField	: 'id_project'
		,	displayField	: 'no_project'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		});
		
	this.form_id_pssr = new Ext.form.TextField({fieldLabel : 'Id PSSR', allowBlank : true, hidden : true});
	this.form_lokasi = new Ext.form.TextField({fieldLabel : 'Lokasi' , allowBlank : false});
	this.form_tanggal = new Ext.form.DateField({
			fieldLabel 	: 'Tanggal Mulai'
		,	emptyText	: 'Thn-Bln-Tgl'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 100 });
	
	

	this.btn_save = new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
		});
		
	this.btn_refresh = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.form_edit();
			}
		});
		
	this.panel_pssr = new Ext.Panel({
			layout		:'column'
		});
		
	this.panel_master = new Ext.form.FormPanel({
			region				: 'center'
		,	labelAlign	: 'right'
		,	labelWidth	: 220
		,	autoWidth	: true
		,	autoHeight	: true
		,	bodyCssClass	: 'stop-panel-form'
		,	style		: 'margin: 8px;'
		,	tbar				: [
				this.btn_refresh
			,	'-'
			,	this.btn_save
			]
		,	items :[
			this.form_id_pssr
			, this.form_project
			, this.form_lokasi
			, this.form_tanggal
			]
		});
		
	this.create_pssr_form = function ()
	{
		var i,j;
		var id;
		var kat;
		var item;
		var detail;

		kat = this.data_pssr;
		for (i = 0; i < kat.length; i++) {
			m_fill_form_pssr[i] = {};

			/* create group of observasi */
			m_fill_form_pssr[i].item		= [];
			m_fill_form_pssr[i].id		= kat[i].id;
			m_fill_form_pssr[i].content	= new Ext.Panel({
				style		: {
					marginTop	: '16px'
				,	marginRight	: 'auto'
				,	marginLeft	: 'auto'
				,	padding		: '8px'
				}
			,	bodyCssClass	: 'stop-panel-form'
			,	autoScroll	: true
			,	autoHeight	: true
			,	headerCfg	: {
					cls	: 'stop-header-form'
				,	html	: kat[i].text
				}
			});

			/* create input detail observasi */
			item = kat[i].item;

			for (j = 0; j < item.length; j++) {
				id = 'pssr_input_detail_'+ kat[i].id +'_'+ item[j].id;

				m_fill_form_pssr[i].item[j] = new M_PssrInputDetail(i, j, id, item[j].text, item[j]);

				m_fill_form_pssr[i].content.add(m_fill_form_pssr[i].item[j].panel);
			}

			m_fill_form_pssr[i].content.doLayout();
			this.panel_pssr.add(m_fill_form_pssr[i].content);
		}
		this.panel_pssr.doLayout();
		this.panel.doLayout();
	}
	
	this.get_pssr_form = function ()
	{
		Ext.Ajax.request({
			url	: _g_root +'/module/pssr_entry/data_pssr_form.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.data_pssr = Ext.util.JSON.decode(response.responseText);
				this.create_pssr_form();
			}
		,	scope	: this
		});
	}

	this.btn_back = new Ext.Button({
			text		: 'Batal'
		,	iconCls	: 'del16'
		,	scope		: this
		,	handler		: function() {
				this.do_back();
			}
	});
	
	this.panel = new Ext.Panel({
		id			: 'tab 2'
	,	title		: this.title
	,	bodyBorder	: false
	,	autoScroll	: true
	,	buttonAlign	: 'center'
	,	tbar		: [
			this.btn_back
		,	'-'
		,	this.btn_refresh
		,	'->'
		,	this.btn_save
		]
	,	items		: [
			this.panel_master
		,	this.panel_pssr
		]
		});
		
	this.form_add = function()
	{
		this.store_project.load();
		
		this.form_id_pssr.setValue('');
		this.form_project.setValue('');
		this.form_lokasi.setValue('');
		this.form_tanggal.setValue('');
		this.reset_form();
		this.dml_type = 2;
	}
	
	this.do_back = function(){
		m_pssr_entry.panel.layout.setActiveItem(0);
	}
	
	this.do_cancel = function()
	{
		m_pssr_master_con.layout.setActiveItem(m_pssr_entry_master.grid);
	}

	this.do_save = function()
	{
		main_load.show();
		
		var i, j, k, l, t, r;
		var out = "[";

		l = 0;
		for (i = 0; i < m_fill_form_pssr.length; i++) {
			t = m_fill_form_pssr[i].item;
			for (j = 0; j < t.length; j++) {
				r = t[j].store.getRange();
				for (k = 0; k < r.length; k++) {
					if (l > 0) {
						out += ",";
					} else {
						l++;
					}
					out	+="{ kat_id   : '"+ r[k].get('kat_id') +"' "
						+ ", item_id  : '"+ r[k].get('item_id') +"' "
						+ ", detail_id: '"+ r[k].get('detail_id') +"' "
						+ ", applicable     : '"+ r[k].get('applicable') +"' "
						+ ", confirm_ok   : '"+ r[k].get('confirm_ok') +"' "
						+ ", punchlist   : '"+ r[k].get('punchlist') +"' "
						+ ", keterangan   : '"+ r[k].get('keterangan') +"' "
						+" }"
				}
			}
		}
		out += "]";
		
		Ext.Ajax.request({
			params  : {
				id_pssr					: this.form_id_pssr.getValue()
			,	id_project				: this.form_project.getValue()
			,	lokasi					: this.form_lokasi.getValue()
			,	tanggal					: this.form_tanggal.getValue()
			,	detail					: out
			,   dml_type				: this.dml_type
			}
		,	url	: _g_root +'/module/pssr_entry/submit_checklist_pssr.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
				main_load.hide();
			}
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}
					this.form_edit();
					main_load.hide();
				}
		,	scope	: this
		});
	}
	
	this.reset_form = function(){
		var i,j,k;
		var grid_id;
		var kat;
		var item;
		var detail;
		kat = this.data_pssr;
		
		for (i = 0; i < kat.length; i++) {
			
			/* create input detail observasi */
			item = kat[i].item;

			for (j = 0; j < item.length; j++) {
				grid_id = 'pssr_input_detail_'+ kat[i].id +'_'+ item[j].id;
				grid = Ext.getCmp(grid_id);
				if (grid == undefined) {
					continue;
				}
				detail = item[j].details;
				for (k =0; k < detail.length;k++){
					x = grid.store.find('detail_id', detail[k].detail_id);
					if (x == -1) {
						continue;
					}

					r = grid.store.getAt(x);
					r.set('applicable', '0');
					r.set('confirm_ok', '0');
					r.set('punchlist', '0');
					r.set('keterangan', '');
					r.commit();
				}
			}
		}
	}
	
	this.edit_fill_form = function(data)
	{
		var i, x;
		var d = data.details;
		var grid;
		var grid_id;
		var r;
		if(d.length == 0){this.dml_type = 2;
			this.reset_form();
			return;}

		for (i = 0; i < d.length; i++) {
			grid_id = 'pssr_input_detail_'+ d[i].kat_id +'_'+ d[i].item_id;
			grid = Ext.getCmp(grid_id);
			if (grid == undefined) {
				continue;
			}

			x = grid.store.find('detail_id', d[i].detail_id);
			if (x == -1) {
				continue;
			}
			//	grid.store.reload();
			r = grid.store.getAt(x);
			if (r == 'undefined'){
				continue;
			}
			r.set('confirm_ok', d[i].confirm_ok +'');
			r.set('punchlist', d[i].punchlist +'');
			r.set('keterangan', d[i].keterangan +'');
			r.set('applicable', d[i].applicable +'');
			r.commit();
		}
	}
	
	this.form_edit = function(data)
	{
		this.dml_type	= 3;
		this.id_pssr	= m_pssr_entry_id_pssr;

		Ext.Ajax.request({
			url	: _g_root +'/module/pssr_entry/data_pssr_form_edit.jsp'
		,	params	: {
				id_pssr: m_pssr_entry_id_pssr
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.edit_fill_form(msg);
			}
		,	scope	: this
		});
	}
	
	this.form_assign = function(data){
		this.store_project.load();
		
		this.form_id_pssr.setValue(data[0].data['id_pssr']);
		this.form_project.setValue(data[0].data['id_project']);
		this.form_lokasi.setValue(data[0].data['lokasi']);
		this.form_tanggal.setValue(data[0].data['tanggal']);
		
		this.dml_type = 3;
	}
	
	this.do_refresh = function()
	{
		this.get_pssr_form();
	}
}

function M_PssrEntry()
{
	m_pssr_entry_master		= new M_PssrEntryMaster('PSSR');
	m_pssr_entry_detail		= new M_PssrEntryDokumen('Dokumen Pendukung');
	m_pssr_entry_master_add	= new M_PssrEntryMasterAdd('Entry / Edit Data PSSR');
	m_pssr_entry_anggota	= new M_PssrEntryAnggota ('Entry Anggota Charter PSSR');
	m_pssr_entry_checklist	= new M_PssrEntryChecklist ('Entry Checklist PSSR');

	m_pssr_master_con = new Ext.Container({
			region		: 'north'
		,	title		: 'PSSR Master'
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
		,	autoResize	: true
		,	autoWidth		: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			}
		,	items	: [
				m_pssr_entry_master.grid
			,	m_pssr_entry_master_add.panel
			]
	
	});
		
	this.panel_detil = new Ext.TabPanel({
			autoScroll	: true
		,	enableTabScroll	: true
		,	region		: 'center'
		,	activeTab	: 0
		,	items			: [
				m_pssr_entry_detail.grid
			,	m_pssr_entry_anggota.grid
			]
	});
	
	this.panel_master_detail = new Ext.Panel({
			id				: 'tab 1'
		,	layout			: 'border'
		,	title			: 'Entry PSSR'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_pssr_master_con
			,	this.panel_detil
			]
		
	});

	this.panel = new Ext.Container({
			id				: 'pssr_entry_panel'
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
		,	autoResize	: true
		,	autoWidth		: true
		,	region		: 'center'
		,	items			: [
				this.panel_master_detail
			,	m_pssr_entry_checklist.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_pssr_entry_ha_level	= ha_level;
		m_pssr_entry_id_pssr 	= '';

		m_pssr_entry_master.do_refresh();
		m_pssr_entry_checklist.do_refresh();
	}
}

m_pssr_entry = new M_PssrEntry();

//@ sourceURL=pssr_entry.layout.js
