/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_pha_input;
var m_pha_input_list;
var m_pha_input_detail;
var m_pha_input_detail_work_steps;
var m_pha_input_detail_rencana_kerja;
var m_pha_input_detail_keanggotaan;
var m_pha_input_detail_hazard_process;
var m_pha_input_detail_hazard_pressure;
var m_pha_input_detail_field_tour;
var m_pha_input_detail_chemical_hazard;
var m_pha_input_detail_worst_scenario;
var m_pha_input_detail_consequences_analysis;
var m_pha_input_detail_what_if;
var m_pha_input_detail_what_if_list;
var m_pha_input_detail_what_if_detail;
var m_pha_input_detail_what_if_detail_recommendation;
var m_pha_input_detail_facility_sitting;
var m_pha_input_detail_human_factor;
var m_pha_input_detail_storm;
var m_pha_input_detail_reference;
var m_pha_input_id_pha = 0;
var m_pha_input_id_pha_phr = 0;
var m_pha_input_id_pha_phr_recommendation	= 0;
var m_pha_input_ha_level = 0;
var m_pha_input_d = _g_root +'/module/pha_input/';

function pha_master_on_select_load_detail()
{
	if (typeof m_pha_input_list == 'undefined'
	||  m_pha_input_id_pha == 0) {
		return;
	}

	m_pha_input_detail_work_steps.do_refresh();
	m_pha_input_detail_rencana_kerja.do_refresh();
	m_pha_input_detail_keanggotaan.do_refresh();
	m_pha_input_detail_hazard_process.do_refresh();
	m_pha_input_detail_hazard_pressure.do_refresh();
	m_pha_input_detail_field_tour.do_refresh();
	m_pha_input_detail_chemical_hazard.do_refresh();
	m_pha_input_detail_worst_scenario.do_refresh();
	m_pha_input_detail_consequences_analysis.do_refresh();
	m_pha_input_detail_what_if.do_refresh();
	m_pha_input_detail_facility_sitting.do_refresh();
	m_pha_input_detail_human_factor.do_refresh();
	m_pha_input_detail_storm.do_refresh();
	m_pha_input_detail_reference.do_refresh();
}

function pha_detail_what_if_master_on_select_load_detail()
{
	if (typeof m_pha_input_detail_what_if_list == 'undefined'
	||  m_pha_input_id_pha_phr == 0) {
		return;
	}

	m_pha_input_detail_what_if_detail_recommendation.do_refresh();
}

function M_PHAInputDetailWorkSteps(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
		{ name	: 'id_pha' }
	,	{ name	: 'id_work_steps' }
	,	{ name	: 'status' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_work_steps.jsp'
		,	autoLoad: false
	});

	this.store_work_steps = new Ext.data.SimpleStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/ref_work_steps/data.jsp'
		,	autoLoad: false
		,	idIndex	: 0
	});

	this.store_status = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
					[0, 'Not Done']
				,	[1, 'Done']
			]
	});

	this.form_work_steps = new Ext.form.ComboBox({
			store			: this.store_work_steps
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
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
		,	{ header	: 'Work Steps'
			, dataIndex	: 'id_work_steps'
			, width		: 300
			, editor	: this.form_work_steps
			, renderer	: combo_renderer(this.form_work_steps)
			}
		,	{ header	: 'Status'
			, dataIndex	: 'status'
			, width		: 100
			, align		: 'center'
			, editor	: this.form_status
			, renderer	: combo_renderer(this.form_status)
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	tbar				: this.toolbar
	});

	this.do_load = function()
	{
		this.store_work_steps.load({
			callback	: function(){
				this.store.load({
					params		: {
						id_pha	: m_pha_input_id_pha
					}
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		this.do_load();
	}
}

function M_PHAInputDetailRencanaKerja(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pha'
		},{
			name	: 'id_pha_rencana_kerja'
		},{
			name	: 'waktu'
		},{
			name	: 'aktifitas'
		},{
			name	: 'keterangan'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_rencana_kerja.jsp'
		,	autoLoad: false
	});

	this.form_waktu = new Ext.form.DateField({
			emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
	});
	
	this.form_aktifitas = new Ext.form.TextArea({
		allowBlank	: false
	});

	this.form_keterangan = new Ext.form.TextField({});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Waktu'
			, dataIndex	: 'waktu'
			, width		: 100
			, align		: 'center'
			, editor	: this.form_waktu
			}
		,	{ header	: 'Aktifitas'
			, dataIndex	: 'aktifitas'
			, width		: 450
			, editor	: this.form_aktifitas
			}
		,	{ id		: 'keterangan'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan'
			, editor	: this.form_keterangan
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,	autoExpandColumn	: 'keterangan'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 					: m_pha_input_id_pha
			,	id_pha_rencana_kerja	: ''
			,	waktu					: ''
			,	aktifitas				: ''
			,	keterangan				: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_rencana_kerja.jsp'
		,	params  : {
				id_pha					: record.data['id_pha']
			,	id_pha_rencana_kerja	: record.data['id_pha_rencana_kerja']
			,	waktu					: record.data['waktu']
			,	aktifitas				: record.data['aktifitas']
			,	keterangan				: record.data['keterangan']
			,   dml_type				: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_pha	: m_pha_input_id_pha
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailKeanggotaan(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pha' }
		,	{ name	: 'nipg' }
		,	{ name	: 'nipg_old' }
		,	{ name	: 'departemen' }
		,	{ name	: 'id_jabatan_pha' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_keanggotaan.jsp'
		,	autoLoad: false
	});

	this.store_nipg = new Ext.data.SimpleStore({
			fields	: ['id','name','departemen']
		,	url		: m_pha_input_d +'data_ref_pegawai.jsp'
		,	autoLoad: false
		,	idIndex	: 0
	});

	this.store_jabatan_pha = new Ext.data.SimpleStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/ref_jabatan_pha/data.jsp'
		,	autoLoad: false
		,	idIndex	: 0
	});

	this.form_nipg = new Ext.form.ComboBox({
			store			: this.store_nipg
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					if (record.get('id') != 'undefined' && record.get('id') != '') {
						this.form_departemen.setValue(record.get('departemen'));
					}
				}
		}
	});

	this.form_departemen = new Ext.form.TextField();
	
	this.form_jabatan_pha = new Ext.form.ComboBox({
			store			: this.store_jabatan_pha
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
		,	{ header	: 'Nama Pegawai'
			, dataIndex	: 'nipg'
			, width		: 250
			, editor	: this.form_nipg
			, renderer	: combo_renderer(this.form_nipg)
			}
		,	{ header	: 'Departemen'
			, dataIndex	: 'departemen'
			, editable	: false
			, width		: 300
			, editor	: this.form_departemen
			}
		,	{ header	: 'Jabatan'
			, dataIndex	: 'id_jabatan_pha'
			, width		: 100
			, editor	: this.form_jabatan_pha
			, renderer	: combo_renderer(this.form_jabatan_pha)
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 			: m_pha_input_id_pha
			,	nipg 			: ''
			,	id_jabatan_pha	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_keanggotaan.jsp'
		,	params  : {
				id_pha			: record.data['id_pha']
			,	nipg			: record.data['nipg']
			,	nipg_old		: record.data['nipg_old']
			,	id_jabatan_pha	: record.data['id_jabatan_pha']
			,   dml_type		: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store_nipg.load({
			callback	: function(){
				this.store_jabatan_pha.load({
					callback	: function(){
						this.store.load({
							params		: {
								id_pha	: m_pha_input_id_pha
							}
						});
					}
				,	scope		: this				
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailHazardProcess(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pha'
		},{
			name	: 'id_hazard_process'
		},{
			name	: 'id_hazard_process_old'
		},{
			name	: 'description'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_hazard_process.jsp'
		,	autoLoad: false
	});

	this.store_hazard_process = new Ext.data.SimpleStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/ref_hazard_process/data.jsp'
		,	autoLoad: false
		,	idIndex	: 0
	});

	this.form_hazard_process = new Ext.form.ComboBox({
			store			: this.store_hazard_process
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_description = new Ext.form.TextField({
		allowBlank		: false
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'From Process'
			, dataIndex	: 'id_hazard_process'
			, width		: 300
			, editor	: this.form_hazard_process
			, renderer	: combo_renderer(this.form_hazard_process)
			}
		,	{ id		: 'description'
			, header	: 'Description'
			, dataIndex	: 'description'
			, editor	: this.form_description
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,	autoExpandColumn	: 'description'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 				: m_pha_input_id_pha
			,	id_hazard_process	: ''
			,	description			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_hazard_process.jsp'
		,	params  : {
				id_pha					: record.data['id_pha']
			,	id_hazard_process		: record.data['id_hazard_process']
			,	id_hazard_process_old	: record.data['id_hazard_process_old']
			,	description				: record.data['description']
			,   dml_type				: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store_hazard_process.load({
			callback	: function(){
				this.store.load({
					params		: {
						id_pha	: m_pha_input_id_pha
					}
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailHazardPressure(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pha'
		},{
			name	: 'id_hazard_pressure'
		},{
			name	: 'id_hazard_pressure_old'
		},{
			name	: 'description'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_hazard_pressure.jsp'
		,	autoLoad: false
	});

	this.store_hazard_pressure = new Ext.data.SimpleStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/ref_hazard_pressure/data.jsp'
		,	autoLoad: false
		,	idIndex	: 0
	});

	this.form_hazard_pressure = new Ext.form.ComboBox({
			store			: this.store_hazard_pressure
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_description = new Ext.form.TextField({
		allowBlank		: false
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_hazard_pressure'
			, header	: 'Pressure/Volume'
			, dataIndex	: 'id_hazard_pressure'
			, width		: 300
			, editor	: this.form_hazard_pressure
			, renderer	: combo_renderer(this.form_hazard_pressure)
			}
		,	{ id		: 'description'
			, header	: 'Description'
			, dataIndex	: 'description'
			, editor	: this.form_description
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,	autoExpandColumn	: 'description'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 				: m_pha_input_id_pha
			,	id_hazard_pressure	: ''
			,	description			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_hazard_pressure.jsp'
		,	params  : {
				id_pha					: record.data['id_pha']
			,	id_hazard_pressure		: record.data['id_hazard_pressure']
			,	id_hazard_pressure_old	: record.data['id_hazard_pressure_old']
			,	description				: record.data['description']
			,   dml_type				: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store_hazard_pressure.load({
			callback	: function(){
				this.store.load({
					params		: {
						id_pha	: m_pha_input_id_pha
					}
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailFieldTour(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pha'
		},{
			name	: 'id_pha_field_tour'
		},{
			name	: 'keterangan'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_field_tour.jsp'
		,	autoLoad: false
	});

	this.form_description = new Ext.form.TextField({
		allowBlank		: false
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'keterangan'
			, header	: 'Description'
			, dataIndex	: 'keterangan'
			, editor	: this.form_description
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,	autoExpandColumn	: 'keterangan'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 				: m_pha_input_id_pha
			,	id_pha_field_tour	: ''
			,	keterangan			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_field_tour.jsp'
		,	params  : {
				id_pha				: record.data['id_pha']
			,	id_pha_field_tour	: record.data['id_pha_field_tour']
			,	keterangan			: record.data['keterangan']
			,   dml_type			: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_pha	: m_pha_input_id_pha
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailChemicalHazard(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pha'
		},{
			name	: 'id_material'
		},{
			name	: 'id_material_old'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_chemical_hazard.jsp'
		,	autoLoad: false
	});

	this.store_material = new Ext.data.SimpleStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/ref_material/data.jsp'
		,	autoLoad: false
		,	idIndex	: 0
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

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_material'
			, header	: 'Materials'
			, dataIndex	: 'id_material'
			, width		: 300
			, editor	: this.form_material
			, renderer	: combo_renderer(this.form_material)
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 		: m_pha_input_id_pha
			,	id_material	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_chemical_hazard.jsp'
		,	params  : {
				id_pha			: record.data['id_pha']
			,	id_material		: record.data['id_material']
			,	id_material_old	: record.data['id_material_old']
			,   dml_type		: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store_material.load({
			callback	: function(){
				this.store.load({
					params		: {
						id_pha	: m_pha_input_id_pha
					}
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailWorstScenario(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pha'
		},{
			name	: 'id_pha_wsfca'
		},{
			name	: 'hazard'
		},{
			name	: 'hazard_event'
		},{
			name	: 'qty_release'
		},{
			name	: 'impact'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_worst_scenario.jsp'
		,	autoLoad: false
	});

	this.form_hazard = new Ext.form.TextArea({
		allowBlank	: false
	});

	this.form_hazard_event = new Ext.form.TextArea({
		allowBlank	: false
	});

	this.form_qty_release = new Ext.form.TextField({});

	this.form_impact = new Ext.form.TextArea({
		allowBlank	: false
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Hazard'
			, dataIndex	: 'hazard'
			, width		: 200
			, editor	: this.form_hazard
			}
		,	{ id		: 'hazard_event'
			, header	: 'Hazard Event'
			, dataIndex	: 'hazard_event'
			, editor	: this.form_hazard_event
			}
		,	{ header	: 'QTY Release'
			, dataIndex	: 'qty_release'
			, width		: 150
			, editor	: this.form_qty_release
			}
		,	{ header	: 'Impact'
			, dataIndex	: 'impact'
			, width		: 200
			, editor	: this.form_impact
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,	autoExpandColumn	: 'hazard_event'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 			: m_pha_input_id_pha
			,	id_pha_wsfca	: ''
			,	hazard			: ''
			,	hazard_event	: ''
			,	qty_release		: ''
			,	impact			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_worst_scenario.jsp'
		,	params  : {
				id_pha			: record.data['id_pha']
			,	id_pha_wsfca	: record.data['id_pha_wsfca']
			,	hazard			: record.data['hazard']
			,	hazard_event	: record.data['hazard_event']
			,	qty_release		: record.data['qty_release']
			,	impact			: record.data['impact']
			,   dml_type		: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_pha	: m_pha_input_id_pha
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailConsequencesAnalysis(title)
{
	this.title					= title;
	this.dml_type				= 0;
	this.id_kategori_item_ca	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pha' }
		,	{ name	: 'id_kategori_item_ca' }
		,	{ name	: 'id_kategori_item_ca_old' }
		,	{ name	: 'id_item_ca' }
		,	{ name	: 'id_item_ca_old' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_consequences_analysis.jsp'
		,	autoLoad: false
	});

	this.store_kategori = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	url		: _g_root +'/module/ref_item_consequences_analysis/data_kategori_item_ca.jsp'
		,	autoLoad: false
		,	idIndex	: 0
	});

	this.store_item = new Ext.data.ArrayStore({
			fields	: ['id_kategori_item_ca','id','name']
		,	url		: _g_root +'/module/ref_item_consequences_analysis/data_item_ca.jsp'
		,	autoLoad: false
		,	idIndex	: 1
	});

	this.form_kategori = new Ext.form.ComboBox({
			store			: this.store_kategori
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_kategori_on_select(record.get('id'));
				}
			}
	});

	this.form_item = new Ext.form.ComboBox({
			store			: this.store_item
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_keterangan = new Ext.form.TextField({
		allowBlank		: false
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Kategori'
			, dataIndex	: 'id_kategori_item_ca'
			, width		: 300
			, editor	: this.form_kategori
			, renderer	: combo_renderer(this.form_kategori)
			}
		,	{ header	: 'Item'
			, dataIndex	: 'id_item_ca'
			, width		: 300
			, editor	: this.form_item
			, renderer	: combo_renderer(this.form_item)
			}
		,	{ id		: 'keterangan'
			, header	: 'Deskripsi'
			, dataIndex	: 'keterangan'
			, editor	: this.form_keterangan
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,	autoExpandColumn	: 'keterangan'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.form_item_filter = function(r,id)
	{
		return (r.get('id_kategori_item_ca') == this.id_kategori_item_ca);
	}

	this.form_kategori_on_select = function(id_kategori_item_ca)
	{
		this.id_kategori_item_ca = id_kategori_item_ca;

		if (this.id_kategori_item_ca != 'undefined'
		&&  this.id_kategori_item_ca != '') {
			this.form_item.clearFilter(true);
			this.form_item.filterBy(this.form_item_filter, this);
			this.form_item.setValue(this.store_item.getAt(0).get('id'));
		} else {
			this.form_item.clearFilter(true);
		}
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

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 				: m_pha_input_id_pha
			,	id_kategori_item_ca	: ''
			,	id_item_ca			: ''
			,	keterangan			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_consequences_analysis.jsp'
		,	params  : {
				id_pha					: record.data['id_pha']
			,	id_kategori_item_ca		: record.data['id_kategori_item_ca']
			,	id_kategori_item_ca_old	: record.data['id_kategori_item_ca_old']
			,	id_item_ca				: record.data['id_item_ca']
			,	id_item_ca_old			: record.data['id_item_ca_old']
			,	keterangan				: record.data['keterangan']
			,   dml_type				: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store_kategori.load({
			callback	: function(){
				this.store_item.load({
					callback	: function(){
						this.store.load({
							params		: {
								id_pha	: m_pha_input_id_pha
							}
						});
					}
				,	scope		: this				
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailWhatIfDetail(title)
{
	this.title					= title;
	this.dml_type				= 0;
	this.frequency_category		= '';
	this.consequence_category	= '';
	this.risk_score				= '';
	this.id_pha_phr				= 0;

	this.store_frequency_category = new Ext.data.ArrayStore({
			fields	: ['id']
		,	url		: m_pha_input_d +'data_ref_frequency_category.jsp'
		,	autoLoad: false
		,	idIndex	: 0
	});

	this.store_consequence_category = new Ext.data.ArrayStore({
			fields	: ['id']
		,	url		: m_pha_input_d +'data_ref_consequence_category.jsp'
		,	autoLoad: false
		,	idIndex	: 0
	});

	this.form_process_step = new Ext.form.TextArea({
			fieldLabel	: 'Process Step or Equipment Piece'
		,	width		: 400
		,	allowBlank	: false
	});

	this.form_what_if = new Ext.form.TextArea({
			fieldLabel	: 'What If ... ?'
		,	width		: 400
		,	allowBlank	: false
	});

	this.form_consequence = new Ext.form.TextArea({
			fieldLabel	: 'Consequence'
		,	width		: 400
		,	allowBlank	: false
	});

	this.form_protection_now = new Ext.form.TextArea({
			fieldLabel	: 'Protection Now'
		,	width		: 400
	});

	this.form_frequency_category = new Ext.form.ComboBox({
			fieldLabel		: 'F'
		,	store			: this.store_frequency_category
		,	valueField		: 'id'
		,	displayField	: 'id'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 100
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_frequency_category_on_select(record.get('id'));
				}
			}
	});

	this.form_consequence_category = new Ext.form.ComboBox({
			fieldLabel		: 'C'
		,	store			: this.store_consequence_category
		,	valueField		: 'id'
		,	displayField	: 'id'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 100
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_consequence_category_on_select(record.get('id'));
				}
			}
	});

	this.form_risk_score = new Ext.form.TextField({
			fieldLabel		: 'RR'
		,	editable		: false
		,	disabled		: true
		,	width			: 100
	});

	this.form_resp = new Ext.form.TextArea({
			fieldLabel	: 'Resp'
		,	width		: 400
	});
	
	this.form_status_of_question = new Ext.form.TextArea({
			fieldLabel	: 'Status of Question'
		,	width		: 400
	});
	
	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_process_step
				,	this.form_what_if
				,	this.form_consequence
				,	this.form_protection_now
				,	this.form_frequency_category
				,	this.form_consequence_category
				,	this.form_risk_score
				,	this.form_resp
				,	this.form_status_of_question
			]
	});

	this.btn_cancel = new Ext.Button({
			text	: 'Batal'
		,	iconCls	: 'del16'
		,	scope	: this
		,	handler	: function() {
				this.do_cancel();
			}
	});

	this.btn_save	= new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_cancel
		,	'->'
		,	this.btn_save
		]
	});

	this.panel = new Ext.Panel({
			title		: this.title
		,	autoScroll	: true
		,	buttonAlign	: 'center'
		,	tbar		: this.toolbar
		,	items		: [
				this.panel_user
			]
	});

	this.form_frequency_category_on_select = function(id)
	{
		this.frequency_category = id;

		Ext.Ajax.request({
			url		: m_pha_input_d +'data_risk_ranking.jsp'
		,	params	: {
				frequency_category		: id
			,	consequence_category	: this.consequence_category
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					return;
				}

				this.form_risk_score.setValue(msg.risk_score);
			}
		,	scope	: this
		});
	}

	this.form_consequence_category_on_select = function(id)
	{
		this.consequence_category = id;

		Ext.Ajax.request({
			url		: m_pha_input_d +'data_risk_ranking.jsp'
		,	params	: {
				frequency_category		: this.frequency_category
			,	consequence_category	: id
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					return;
				}

				this.form_risk_score.setValue(msg.risk_score);
			}
		,	scope	: this
		});
	}

	this.is_valid = function()
	{
		if (!this.form_process_step.isValid()) {
			return false;
		}

		if (!this.form_what_if.isValid()) {
			return false;
		}

		if (!this.form_consequence.isValid()) {
			return false;
		}

		if (!this.form_protection_now.isValid()) {
			return false;
		}

		if (!this.form_frequency_category.isValid()) {
			return false;
		}

		if (!this.form_consequence_category.isValid()) {
			return false;
		}

		if (!this.form_risk_score.isValid()) {
			return false;
		}

		if (!this.form_resp.isValid()) {
			return false;
		}

		if (!this.form_status_of_question.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_cancel = function()
	{
		m_pha_input_detail_what_if.panel.layout.setActiveItem(0);
	}

	this.do_save = function(record)
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
			url		: m_pha_input_d +'submit_detail_pha_what_if.jsp'
		,	params	: {
					dml_type				: this.dml_type
				,	id_pha					: m_pha_input_id_pha
				,	id_pha_phr				: m_pha_input_id_pha_phr
				,	process_step			: this.form_process_step.getValue()
				,	what_if					: this.form_what_if.getValue()
				,	consequence				: this.form_consequence.getValue()
				,	protection_now			: this.form_protection_now.getValue()
				,	frequency_category		: this.form_frequency_category.getValue()
				,	consequence_category	: this.form_consequence_category.getValue()	
				,	risk_score				: this.form_risk_score.getValue()	
				,	resp					: this.form_resp.getValue()	
				,	status_of_question		: this.form_status_of_question.getValue()	
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				Ext.MessageBox.alert('Informasi', msg.info);

				m_pha_input_detail_what_if_list.store.reload();
				m_pha_input_detail_what_if.panel.layout.setActiveItem(0);
				
				m_pha_input_detail_work_steps.do_refresh();
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		this.frequency_category = '';
		this.consequence_category = '';
		
		this.form_process_step.setValue('');
		this.form_what_if.setValue('');
		this.form_consequence.setValue('');
		this.form_protection_now.setValue('');
		this.form_frequency_category.setValue('');
		this.form_consequence_category.setValue('');
		this.form_risk_score.setValue('');
		this.form_resp.setValue('');
		this.form_status_of_question.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_process_step.setValue(data.process_step);
		this.form_what_if.setValue(data.what_if);
		this.form_consequence.setValue(data.consequence);
		this.form_protection_now.setValue(data.protection_now);
		this.form_frequency_category.setValue(data.frequency_category);
		this.form_consequence_category.setValue(data.consequence_category);
		this.form_risk_score.setValue(data.risk_score);
		this.form_resp.setValue(data.resp);
		this.form_status_of_question.setValue(data.status_of_question);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_pha_input_d +'data_detail_pha_what_if.jsp'
		,	params	: {
				id_pha_phr	: id
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
	
	this.do_load = function()
	{
		this.store_frequency_category.load();
		this.store_consequence_category.load();
	}
	
	this.do_refresh = function()
	{
		this.do_load();
		
		if (m_pha_input_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input data PHA!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}
	}
}

function M_PHAInputDetailWhatIfList(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pha' }
		,	{ name	: 'id_pha_phr' }
		,	{ name	: 'process_step' }
		,	{ name	: 'what_if' }
		,	{ name	: 'consequence' }
		,	{ name	: 'frequency_category' }
		,	{ name	: 'consequence_category' }
		,	{ name	: 'risk_score' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_what_if_list.jsp'
		,	autoLoad: false
	});

	this.form_process_step = new Ext.form.TextArea({});

	this.form_what_if = new Ext.form.TextArea({});

	this.form_consequence = new Ext.form.TextArea({});
	
	this.form_frequency_category = new Ext.form.TextField({});

	this.form_consequence_category = new Ext.form.TextField({});

	this.form_risk_score = new Ext.form.TextField({});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Process Step or Equipment Piece'
			, dataIndex	: 'process_step'
			, width		: 150
			, editor	: this.form_process_step
			}
		,	{ header	: 'What If ...?'
			, dataIndex	: 'what_if'
			, width		: 150
			, editor	: this.form_what_if
			}
		,	{ id		: 'consequence'
			, header	: 'Consequence'
			, dataIndex	: 'consequence'
			, width		: 200
			, editor	: this.form_consequence
			}
		,	{ header	: 'F'
			, dataIndex	: 'frequency_category'
			, width		: 50
			, align		: 'center'
			, editor	: this.form_frequency_category
			}
		,	{ header	: 'C'
			, dataIndex	: 'consequence_category'
			, width		: 50
			, align		: 'center'
			, editor	: this.form_consequence_category
			}
		,	{ header	: 'RR'
			, dataIndex	: 'risk_score'
			, width		: 50
			, align		: 'center'
			, editor	: this.form_risk_score
			}
		]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_pha_input_id_pha_phr = data[0].data['id_pha_phr'];
					} else {
						m_pha_input_id_pha_phr = 0;
					}
					
					pha_detail_what_if_master_on_select_load_detail();
				}
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
			}
	});

	this.btn_edit = new Ext.Button({
			text		: 'Ubah'
		,	iconCls		: 'edit16'
		,	scope		: this
		,	handler		: function() {
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'consequence'
	});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_pha_input_d +'submit_detail_pha_what_if.jsp'
		,	params	: {
				dml_type				: 4
			,	id_pha					: data.get('id_pha')
			,	id_pha_phr				: data.get('id_pha_phr')
			,	process_step			: ''
			,	what_if					: ''
			,	consequence				: ''
			,	protection_now			: ''
			,	frequency_category		: ''
			,	consequence_category	: ''
			,	risk_score				: ''
			,	resp					: ''
			,	status_of_question		: ''
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				Ext.MessageBox.alert('Informasi', msg.info);

				this.do_load();
				m_pha_input_detail_work_steps.do_refresh();
			}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_pha_input_detail_what_if_detail.do_refresh();
		m_pha_input_detail_what_if_detail.do_edit(data.get('id_pha_phr'));
		m_pha_input_detail_what_if.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		m_pha_input_detail_what_if_detail.do_refresh();
		m_pha_input_detail_what_if_detail.do_add();
		m_pha_input_detail_what_if.panel.layout.setActiveItem(1);
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_pha	: m_pha_input_id_pha
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_pha_input_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailWhatIfDetailRecommendation(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{ name	: 'id_pha' }
	,	{ name	: 'id_pha_phr' }
	,	{ name	: 'id_pha_phr_recommendation' }
	,	{ name	: 'recommendation' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_what_if_recommendation.jsp'
		,	autoLoad: false
	});

	this.form_recommendation = new Ext.form.TextArea({
		allowBlank		: false
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'recommendation'
			, header	: 'Recommendation'
			, dataIndex	: 'recommendation'
			, editor	: this.form_recommendation
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
			title				: this.title
		,	region				: 'south'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	plugins				: [this.editor]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'recommendation'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_id_pha_phr == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA What If Master terlebih dahulu!");
			return;
		}

		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha_phr == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA What If Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 						: m_pha_input_id_pha
			,	id_pha_phr					: m_pha_input_id_pha_phr
			,	id_pha_phr_recommendation	: ''
			,	recommendation				: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_what_if_recommendation.jsp'
		,	params  : {
				id_pha						: record.data['id_pha']
			,	id_pha_phr					: record.data['id_pha_phr']
			,	id_pha_phr_recommendation	: record.data['id_pha_phr_recommendation']
			,	recommendation				: record.data['recommendation']
			,   dml_type					: this.dml_type
			}
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

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_pha		: m_pha_input_id_pha
			,	id_pha_phr	: m_pha_input_id_pha_phr
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailWhatIf(title)
{
	m_pha_input_detail_what_if_list 					= new M_PHAInputDetailWhatIfList('PHA What If');
	m_pha_input_detail_what_if_detail 					= new M_PHAInputDetailWhatIfDetail('Data PHA What If');
	m_pha_input_detail_what_if_detail_recommendation 	= new M_PHAInputDetailWhatIfDetailRecommendation('Remarks & Recommendation');

	this.panel_master_detail = new Ext.Panel({
			layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_pha_input_detail_what_if_list.panel
			,	m_pha_input_detail_what_if_detail_recommendation.panel
			]
	});
	
	this.panel = new Ext.Panel({
		layout		: 'card'
	,	activeItem	: 0
	,	autoWidth	: true
	,	autoScroll	: true
	,	items		: [
			this.panel_master_detail
		,	m_pha_input_detail_what_if_detail.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		m_pha_input_id_pha_phr	= 0;
		
		m_pha_input_detail_what_if_list.do_refresh();
		m_pha_input_detail_what_if_detail_recommendation.do_refresh();
	}

}

function M_PHAInputDetailFacilitySitting(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{ name	: 'id_pha' }
	,	{ name	: 'id_pha_facility_sitting' }
	,	{ name	: 'category' }
	,	{ name	: 'description' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_facility_sitting.jsp'
		,	autoLoad: false
	});

	this.form_category = new Ext.form.TextField({
		allowBlank		: false
	});

	this.form_description = new Ext.form.TextArea({
		allowBlank		: false
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Kategori'
			, dataIndex	: 'category'
			, width		: 300
			, editor	: this.form_category
			}
		,	{ id		: 'description'
			, header	: 'Deskripsi'
			, dataIndex	: 'description'
			, editor	: this.form_description
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,	autoExpandColumn	: 'description'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 					: m_pha_input_id_pha
			,	id_pha_facility_sitting	: ''
			,	category				: ''
			,	description				: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_facility_sitting.jsp'
		,	params  : {
				id_pha					: record.data['id_pha']
			,	id_pha_facility_sitting	: record.data['id_pha_facility_sitting']
			,	category				: record.data['category']
			,	description				: record.data['description']
			,   dml_type				: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_pha	: m_pha_input_id_pha
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailHumanFactor(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{ name	: 'id_pha' }
	,	{ name	: 'id_pha_human_factor' }
	,	{ name	: 'category' }
	,	{ name	: 'description' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_human_factor.jsp'
		,	autoLoad: false
	});

	this.form_category = new Ext.form.TextField({
		allowBlank		: false
	});

	this.form_description = new Ext.form.TextArea({
		allowBlank		: false
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Kategori'
			, dataIndex	: 'category'
			, width		: 300
			, editor	: this.form_category
			}
		,	{ id		: 'description'
			, header	: 'Deskripsi'
			, dataIndex	: 'description'
			, editor	: this.form_description
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,	autoExpandColumn	: 'description'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 				: m_pha_input_id_pha
			,	id_pha_human_factor	: ''
			,	category			: ''
			,	description			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_human_factor.jsp'
		,	params  : {
				id_pha				: record.data['id_pha']
			,	id_pha_human_factor	: record.data['id_pha_human_factor']
			,	category			: record.data['category']
			,	description			: record.data['description']
			,   dml_type			: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_pha	: m_pha_input_id_pha
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailSTORM(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pha' }
		,	{ name	: 'id_pha_storm' }
		,	{ name	: 'risk_score' }
		,	{ name	: 'recommendation' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_storm.jsp'
		,	autoLoad: false
	});

	this.store_rating = new Ext.data.SimpleStore({
			fields	: ['risk_score']
		,	url		: _g_root +'/module/ref_risk_matrix/data_ref_risk_score.jsp'
		,	autoLoad: false
		,	idIndex	: 0
	});

	this.form_rating = new Ext.form.ComboBox({
			store			: this.store_rating
		,	valueField		: 'risk_score'
		,	displayField	: 'risk_score'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});
	
	this.form_recommendation = new Ext.form.TextArea({
		allowBlank		: false
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Rating'
			, dataIndex	: 'risk_score'
			, width		: 100
			, align		: 'center'
			, editor	: this.form_rating
			, renderer	: combo_renderer(this.form_rating)
			}
		,	{ id		: 'recommendation'
			, header	: 'Recommendation'
			, dataIndex	: 'recommendation'
			, editor	: this.form_recommendation
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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
		,	autoExpandColumn	: 'recommendation'
		,   listeners   : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 			: m_pha_input_id_pha
			,	id_pha_storm 	: ''
			,	risk_score		: ''
			,	recommendation	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_storm.jsp'
		,	params  : {
				id_pha			: record.data['id_pha']
			,	id_pha_storm	: record.data['id_pha_storm']
			,	risk_score		: record.data['risk_score']
			,	recommendation	: record.data['recommendation']
			,   dml_type		: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store_rating.load({
			callback	: function(){
				this.store.load({
					params		: {
						id_pha	: m_pha_input_id_pha
					}
				});
			}
		,	scope		: this				
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetailReference(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_pha'
		},{
			name	: 'id_pha_reference'
		},{
			name	: 'reference'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_detail_pha_reference.jsp'
		,	autoLoad: false
	});

	this.form_reference = new Ext.form.TextField({
		allowBlank		: false
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'reference'
			, header	: 'Reference'
			, dataIndex	: 'reference'
			, editor	: this.form_reference
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_edit = function(row)
	{
		if (m_pha_input_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_add = function()
	{
		if (m_pha_input_id_pha == 0) {
			Ext.Msg.alert("Kesalahan Operasi" , "Silahkan pilih salah satu PHA Master terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pha 				: m_pha_input_id_pha
			,	id_pha_reference	: ''
			,	reference			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
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
			url		: m_pha_input_d +'submit_detail_pha_reference.jsp'
		,	params  : {
				id_pha				: record.data['id_pha']
			,	id_pha_reference	: record.data['id_pha_reference']
			,	reference			: record.data['reference']
			,   dml_type			: this.dml_type
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_refresh();
					m_pha_input_detail_work_steps.do_refresh();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_pha	: m_pha_input_id_pha
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInputDetail(title)
{
	this.title 			= title;
	this.dml_type		= 0;
	this.id_pha			= '';

	this.store_project = new Ext.data.ArrayStore({
			fields		: ['id_project','nama_project','tanggal_mulai']
		,	url			: m_pha_input_d +'data_ref_project.jsp'
		,	autoLoad	: false
	});

	this.form_project_on_select = function(tanggal_mulai)
	{
		this.form_tanggal_project.setValue(tanggal_mulai);
	}

	this.form_project = new Ext.form.ComboBox({
			fieldLabel		: 'Project'
		,	store			: this.store_project
		,	valueField		: 'id_project'
		,	displayField	: 'nama_project'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 300
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_project_on_select(record.get('tanggal_mulai'));
				}
			}
	});

	this.form_tanggal_project = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Project'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	disabled	: true
		,	width		: 150
	});

	this.form_tanggal = new Ext.form.DateField({
			fieldLabel	: 'Tanggal PHA'
		,	emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	allowBlank	: false
	});
	
	this.form_lokasi = new Ext.form.TextField({
			fieldLabel	: 'Lokasi'
		,	width		: 400
		,	allowBlank	: false
	});

	this.form_proses_phr = new Ext.form.TextField({
			fieldLabel	: 'Proses PHR'
		,	width		: 400
	});

	this.panel_user = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 100
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_project
				,	this.form_tanggal_project
				,	this.form_tanggal
				,	this.form_lokasi
				,	this.form_proses_phr
			]
	});

	this.btn_cancel = new Ext.Button({
			text	: 'Batal'
		,	iconCls	: 'del16'
		,	scope	: this
		,	handler	: function() {
				this.do_cancel();
			}
	});

	this.btn_save	= new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
	});

	this.panel = new Ext.Panel({
			title		: this.title
		,	autoScroll	: true
		,	buttonAlign	: 'center'
		,	tbar		: [
				this.btn_cancel
			,	'->'
			,	this.btn_save
			]
		,	items		: [
				this.panel_user
			]
	});

	this.is_valid = function()
	{
		if (!this.form_project.isValid()) {
			return false;
		}

		if (!this.form_lokasi.isValid()) {
			return false;
		}

		if (!this.form_tanggal.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_pha_input.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		main_load.show();
		
		Ext.Ajax.request({
			url		: m_pha_input_d +'submit_master_pha.jsp'
		,	params	: {
					dml_type			: this.dml_type
				,	id_pha				: m_pha_input_id_pha
				,	id_project			: this.form_project.getValue()
				,	lokasi				: this.form_lokasi.getValue()
				,	tanggal				: this.form_tanggal.getValue()
				,	proses_phr			: this.form_proses_phr.getValue()	
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				main_load.hide();
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				main_load.hide();
				
				Ext.MessageBox.alert('Informasi', msg.info);

				m_pha_input_list.store.reload();
				m_pha_input.panel.layout.setActiveItem(0);
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		this.form_project.setValue('');
		this.form_tanggal_project.setValue('');
		this.form_lokasi.setValue('');
		this.form_tanggal.setValue('');
		this.form_proses_phr.setValue('');
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_project.setValue(data.id_project);
		this.form_tanggal_project.setValue(data.tanggal_project);
		this.form_lokasi.setValue(data.lokasi);
		this.form_tanggal.setValue(data.tanggal);
		this.form_proses_phr.setValue(data.proses_phr);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_pha_input_d +'data_master_pha.jsp'
		,	params	: {
				id_pha	: id
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

	this.do_load = function()
	{
		this.store_project.load();
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input data PHA!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_PHAInputList(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{ name	: 'id_pha' }
	,	{ name	: 'project' }
	,	{ name	: 'tanggal_project' }
	,	{ name	: 'tanggal' }
	,	{ name	: 'lokasi' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_input_d +'data_master_pha_list.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Project'
		,	dataIndex	: 'project'
		,	width		: 200
		},{
			header		: 'Tanggal Project'
		,	dataIndex	: 'tanggal_project'
		,	align		: 'center'
		,	width		: 110
		},{
			header		: 'Tanggal PHA'
		,	dataIndex	: 'tanggal'
		,	align		: 'center'
		,	width		: 90
		},{
			id			: 'lokasi_pha'
		,	header		: 'Lokasi'
		,	dataIndex	: 'lokasi'
		}]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_pha_input_id_pha = data[0].data['id_pha'];
					} else {
						m_pha_input_id_pha = 0;
					}

					pha_master_on_select_load_detail();
				}
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
			}
	});

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
			text		: 'Tambah'
		,	iconCls		: 'add16'
		,	scope		: this
		,	handler		: function() {
				this.do_add();
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
			title				: this.title
		,	region				: 'north'
		,	height				: 150
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'lokasi_pha'
	});
	
	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url		: m_pha_input_d +'submit_master_pha.jsp'
		,	params	: {
				dml_type			: 4
			,	id_pha				: data.get('id_pha')
			,	id_project			: ''
			,	lokasi				: ''
			,	tanggal				: ''
			,	proses_phr			: ''
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				Ext.MessageBox.alert('Informasi', msg.info);

				this.do_load();
			}
		,	scope	: this
		});
	}

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_pha_input_detail.do_refresh();
		m_pha_input_detail.do_edit(data.get('id_pha'));
		m_pha_input.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		m_pha_input_detail.do_refresh();
		m_pha_input_detail.do_add();
		m_pha_input.panel.layout.setActiveItem(1);
	}

	this.do_load = function()
	{
		var load_type = 'user';

		if (m_pha_input_ha_level == 4) {
			load_type = 'all';
		}

		this.store.load({
			params	: {
				load_type : load_type
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_input_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data PHA!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_pha_input_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_pha_input_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_pha_input_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_PHAInput()
{
	m_pha_input_list							= new M_PHAInputList('Process Hazard Analysis');
	m_pha_input_detail							= new M_PHAInputDetail('Data Process Hazard Analysis');
	m_pha_input_detail_work_steps				= new M_PHAInputDetailWorkSteps('Work Steps');
	m_pha_input_detail_rencana_kerja			= new M_PHAInputDetailRencanaKerja('Rencana Kerja');
	m_pha_input_detail_keanggotaan				= new M_PHAInputDetailKeanggotaan('Keanggotaan');
	m_pha_input_detail_hazard_process			= new M_PHAInputDetailHazardProcess('Hazard Process');
	m_pha_input_detail_hazard_pressure			= new M_PHAInputDetailHazardPressure('Hazard Pressure');
	m_pha_input_detail_field_tour				= new M_PHAInputDetailFieldTour('Field Tour');
	m_pha_input_detail_chemical_hazard			= new M_PHAInputDetailChemicalHazard('Chemical Hazard');
	m_pha_input_detail_worst_scenario			= new M_PHAInputDetailWorstScenario('Worst Scenario');
	m_pha_input_detail_consequences_analysis	= new M_PHAInputDetailConsequencesAnalysis('Consequences Analysis');
	m_pha_input_detail_what_if					= new M_PHAInputDetailWhatIf('What-If');
	m_pha_input_detail_facility_sitting			= new M_PHAInputDetailFacilitySitting('Facility Sitting');
	m_pha_input_detail_human_factor				= new M_PHAInputDetailHumanFactor('Human Factor');
	m_pha_input_detail_storm					= new M_PHAInputDetailSTORM('Other Recommendations');
	m_pha_input_detail_reference				= new M_PHAInputDetailReference('References');

	this.store = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	data	: [[0,'Work Steps'],
					   [1,'Rencana Kerja'],
					   [2,'Keanggotaan'],
					   [3,'Hazard Process'],
					   [4,'Hazard Pressure'],
					   [5,'Field Tour'],
					   [6,'Chemical Hazard'],
					   [7,'Worst Scenario'],
					   [8,'Consequences Analysis'],
					   [9,'What-If'],
					   [10,'Facility Sitting'],
					   [11,'Human Factor'],
					   [12,'Other Recommendations'],
					   [13,'References']]
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
						this.panel_pha_detail.layout.setActiveItem(data[0].data['id']);
					}
				}
			}
	});

	this.panel_menu = new Ext.grid.GridPanel({
			title				: 'Menu'
		,	region				: 'west'
		,	width				: '15%'
		,	collapsible			: true
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	autoExpandColumn	: 'nama_menu'
	});
	
	this.panel_pha_detail = new Ext.Panel({
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
				m_pha_input_detail_work_steps.grid
			,	m_pha_input_detail_rencana_kerja.grid
			,	m_pha_input_detail_keanggotaan.grid
			,	m_pha_input_detail_hazard_process.grid
			,	m_pha_input_detail_hazard_pressure.grid
			,	m_pha_input_detail_field_tour.grid
			,	m_pha_input_detail_chemical_hazard.grid
			,	m_pha_input_detail_worst_scenario.grid
			,	m_pha_input_detail_consequences_analysis.grid
			,	m_pha_input_detail_what_if.panel
			,	m_pha_input_detail_facility_sitting.grid
			,	m_pha_input_detail_human_factor.grid
			,	m_pha_input_detail_storm.grid
			,	m_pha_input_detail_reference.grid
			]
	});

	this.panel_detail = new Ext.Container({
			layout			: 'border'
		,	region			: 'center'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				this.panel_menu
			,	this.panel_pha_detail
			]
	});
	
	this.panel_pha_master_detail = new Ext.Panel({
			layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_pha_input_list.panel
			,	this.panel_detail
			]
	});

	this.panel	= new Ext.Panel({
			id			: 'pha_input_panel'
		,	layout		: 'card'
		,	activeItem	: 0
		,	autoWidth	: true
		,	autoScroll	: true
		,	items		: [
				this.panel_pha_master_detail
			,	m_pha_input_detail.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_pha_input_ha_level	= ha_level;
		m_pha_input_id_pha 		= 0;

		m_pha_input_list.do_refresh();
	}
}

m_pha_input = new M_PHAInput();

//@ sourceURL=pha_input.layout.js
