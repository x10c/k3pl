/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_sfm_task_progress;
var m_sfm_task_progress_d = _g_root +'/module/sfm_task_progress/';
var m_sfm_task_prog_ha_level = '';
var m_sfm_materi_id = '';

function checkbox_renderer(checkbox)
{
	return function(value) {
		if (value == '1' || value == 'true' || value == true) {
			return 'Aktif';
		} else {
			return 'Non-Aktif';
		}
	}
}

function do_on_select_task_materi_sub(){
	if (  m_sfm_materi_id == ''
	||  m_sfm_rapat_id == '') {
		return;
	}

	m_sfm_task_progress_sub.do_load();

}

function M_SfmTaskProgressSub(title)
{
	this.title = title;
	this.dml_type = '';
	this.ha_level = m_sfm_task_prog_ha_level;
	
	this.record = new Ext.data.Record.create([
			{ name	: 'nipg_pelaksana' }
		,	{ name	: 'nipg_supervisor' }
		,	{ name	: 'id_rapat' }
		,	{ name	: 'id_rapat_materi' }
		,	{ name	: 'id_rapat_sub_materi' }
		,	{ name	: 'isi_rapat_sub_materi' }
		,	{ name	: 'batas_waktu_sub_materi'}
		,	{ name	: 'status_sub_materi'}
		,	{ name	: 'keterangan_sub_materi'}
	]);
	
	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root	: 'rows'
		}
		, this.record);
		
	this.store = new Ext.data.Store({
			url	: _g_root +'/module/sfm_task_progress/data_sub_materi.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});
		
	this.store_peg = new Ext.data.ArrayStore({
			fields	: ['nipg','nama_pegawai']
		,	url	: _g_root +'/module/sfm_data_rapat_central/data_pegawai.jsp'
		,	autoLoad: false
		});
		
	this.cb_pegawai = new Ext.form.ComboBox({
			fieldLabel	: 'Pelaksana'
		,	store		: this.store_peg
		,	valueField	: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		,	disabled 	: true
		});

	
	this.form_id_rapat = new Ext.form.TextField({allowBlank : true});
	this.form_no_rapat = new Ext.form.TextField({allowBlank : true, disabled : true});
	this.form_judul_rapat = new Ext.form.TextField({allowBlank : true, disabled : true});
	this.form_id_rapat_sub_materi = new Ext.form.TextField({allowBlank : true});
	this.form_isi_rapat_sub_materi = new Ext.form.TextField({allowBlank : false, disabled : true});

	this.form_batas_waktu	= new Ext.form.DateField({
			emptyText	: 'Y-m-d'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	disabled	: true
	});
	
	this.store_status_materi = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['1', 'Open']
			,	['2', 'Closed Pelaksana']
			]
		});
	
	this.cb_status_materi = new Ext.form.ComboBox({
			store		: this.store_status_materi
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
	
	this.store_status_all = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'Info']
			,	['1', 'Open']
			,	['2', 'Closed Pelaksana']
			,	['3', 'Closed Supervisor']
			,	['4', 'Finished']
			]
		});
	this.cb_status_all = new Ext.form.ComboBox({
			store		: this.store_status_all
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
		
	this.form_keterangan = new Ext.form.TextField({allowBlank : true, disabled : true});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nipg_pelaksana'
			, header	: 'NIPG'
			, dataIndex	: 'nipg_pelaksana'
			, sortable	: true
			, editor	: this.cb_pegawai
			, renderer	: combo_renderer(this.cb_pegawai)
			, hidden	: true
			}
		,	{ id		: 'id_rapat'
			, header	: 'Id Rapat'
			, dataIndex	: 'id_rapat'
			, sortable	: true
			, editor	: this.form_id_rapat
			, hidden	: true
			}
		,	{ id		: 'id_rapat_sub_materi'
			, header	: 'Id Sub Materi Rapat'
			, dataIndex	: 'id_rapat_sub_materi'
			, sortable	: true
			, editor	: this.form_id_rapat_sub_materi
			, hidden	: true
			}
		,	{ id		: 'isi_rapat_sub_materi'
			, header	: 'Sub Materi Rapat'
			, dataIndex	: 'isi_rapat_sub_materi'
			, sortable	: true
			, editor	: this.form_isi_rapat_sub_materi
			, width		: 340
			}	
		,	{ id		: 'batas_waktu_sub_materi'
			, header	: 'Batas Waktu'
			, dataIndex	: 'batas_waktu_sub_materi'
			, sortable	: true
			, editor	: this.form_batas_waktu
			}	
		,	{ id		: 'status_sub_materi'
			, header	: 'Status'
			, dataIndex	: 'status_sub_materi'
			, sortable	: true
			, editor	: this.cb_status_materi
			,renderer	: combo_renderer(this.cb_status_all)
			}	
		,	{ id		: 'keterangan_sub_materi'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan_sub_materi'
			, sortable	: true
			, editor	: this.form_keterangan
			
			}	
		];
	
	
	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					
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

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'south'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: [this.editor]
		,	tbar		: this.toolbar
		,	collapsible	: true
		,	width		: '33%'
		,	height		: 250
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
                        }
		});

	this.do_cancel = function()
	{
		
		if (this.dml_type == 'insert') {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
					nipg 				: record.data['nipg_supervisor']
				,	id_rapat 			: record.data['id_rapat']
				,	id_rapat_materi 	: record.data['id_rapat_materi']
				,	id_rapat_sub_materi 	: record.data['id_rapat_sub_materi']
				,	isi_rapat_sub_materi 	: record.data['isi_rapat_sub_materi']
				,	batas_waktu_sub_materi 	: record.data['batas_waktu_sub_materi']
				,	status_sub_materi 		: record.data['status_sub_materi']
				,	keterangan_sub_materi 	: record.data['keterangan_sub_materi']
			,       dml_type	: this.dml_type
			}
		,	url	: _g_root +'/module/sfm_task_progress/submit_sub_materi.jsp'
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
		var data = this.sm.getSelections();
		
		if (data[0].data.status_sub_materi != '1'
			&& data[0].data.status_sub_materi != '2'){
			Ext.MessageBox.alert('Pesan','Materi yang bersifat info, atau Pekerjaan yang telah di-close oleh supervisor tidak dapat diedit');
			return false;
		}
		
		if (m_sfm_task_prog_ha_level >= 3) {
			this.dml_type = 'update';
			return true;
		}
		return false;
	}

	this.do_load = function()
	{	
		this.store.load({
				params		: {
					id_rapat_materi : m_sfm_materi_id
				}
			});
		this.store_peg.load();
	}

	this.do_refresh = function(ha_level)
	{	
		m_sfm_task_prog_ha_level = ha_level;
	}
}

function M_SfmTaskProgress(title)
{
	this.title = title;
	this.dml_type = '';
	this.ha_level = m_sfm_task_prog_ha_level;
	m_sfm_task_progress_sub = new M_SfmTaskProgressSub('Sub Materi');
	
	this.record = new Ext.data.Record.create([
			{ name	: 'nipg_pelaksana' }
		,	{ name	: 'nipg_supervisor' }
		,	{ name	: 'id_rapat' }
		,	{ name	: 'no_rapat' }
		,	{ name	: 'judul_rapat' }
		,	{ name	: 'id_rapat_materi' }
		,	{ name	: 'isi_rapat_materi' }
		,	{ name	: 'batas_waktu_materi'}
		,	{ name	: 'status_materi'}
		,	{ name	: 'keterangan_materi'}
	]);
	
	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root	: 'rows'
		}
		, this.record);
	
	this.store = new Ext.data.Store({
			url	: _g_root +'/module/sfm_task_progress/data_materi.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});
	
	this.store_peg = new Ext.data.ArrayStore({
			fields	: ['nipg','nama_pegawai']
		,	url	: _g_root +'/module/sfm_data_rapat_central/data_pegawai.jsp'
		,	autoLoad: false
		});
		
	this.cb_pegawai = new Ext.form.ComboBox({
			fieldLabel	: 'Pelaksana'
		,	store		: this.store_peg
		,	valueField	: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		,	disabled 	: true
		});

	
	this.form_id_rapat = new Ext.form.TextField({allowBlank : true});
	this.form_no_rapat = new Ext.form.TextField({allowBlank : true, disabled : true});
	this.form_judul_rapat = new Ext.form.TextField({allowBlank : true, disabled : true});
	this.form_id_rapat_materi = new Ext.form.TextField({allowBlank : true});
	this.form_isi_rapat_materi = new Ext.form.TextField({allowBlank : false, disabled : true});

	this.form_batas_waktu	= new Ext.form.DateField({
			emptyText	: 'Y-m-d'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	disabled	: true
	});

	this.store_status_materi = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['1', 'Open']
			,	['2', 'Closed Pelaksana']
			]
		});
	
	this.cb_status_materi = new Ext.form.ComboBox({
			store		: this.store_status_materi
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
	
	this.store_status_all = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'Info']
			,	['1', 'Open']
			,	['2', 'Closed Pelaksana']
			,	['3', 'Closed Supervisor']
			,	['4', 'Finished']
			]
		});
	this.cb_status_all = new Ext.form.ComboBox({
			store		: this.store_status_all
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
		
	this.form_keterangan = new Ext.form.TextField({allowBlank : true, disabled : true});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nipg'
			, header	: 'NIPG'
			, dataIndex	: 'nipg'
			, sortable	: true
			, editor	: this.cb_pegawai
			, renderer	: combo_renderer(this.cb_pegawai)
			, hidden	: true
			}
		,	{ id		: 'id_rapat'
			, header	: 'Id Rapat'
			, dataIndex	: 'id_rapat'
			, sortable	: true
			, editor	: this.form_id_rapat
			, hidden	: true
			}
		,	{ id		: 'no_rapat'
			, header	: 'No Rapat'
			, dataIndex	: 'no_rapat'
			, sortable	: true
			, editor	: this.form_no_rapat
			}
		,	{ id		: 'judul_rapat'
			, header	: 'Judul Rapat'
			, dataIndex	: 'judul_rapat'
			, sortable	: true
			, editor	: this.form_judul_rapat
			}
		,	{ id		: 'id_rapat_materi'
			, header	: 'Id Materi Rapat'
			, dataIndex	: 'id_rapat_materi'
			, sortable	: true
			, editor	: this.form_id_rapat_materi
			, hidden	: true
			}
		,	{ id		: 'isi_rapat_materi'
			, header	: 'Materi Rapat'
			, dataIndex	: 'isi_rapat_materi'
			, sortable	: true
			, editor	: this.form_isi_rapat_materi
			, width		: 340
			}	
		,	{ id		: 'batas_waktu_materi'
			, header	: 'Batas Waktu'
			, dataIndex	: 'batas_waktu_materi'
			, sortable	: true
			, editor	: this.form_batas_waktu
			}	
		,	{ id		: 'status_materi'
			, header	: 'Status'
			, dataIndex	: 'status_materi'
			, sortable	: true
			, editor	: this.cb_status_materi
			,renderer	: combo_renderer(this.cb_status_all)
			}	
		,	{ id		: 'keterangan_materi'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan_materi'
			, sortable	: true
			, editor	: this.form_keterangan
			
			}	
		];
	
	
	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length){
						m_sfm_materi_id = data[0].data.id_rapat_materi;
						m_sfm_rapat_id	= data[0].data.id_rapat;
					}else{
						m_sfm_materi_id = '';
						m_sfm_rapat_id = '';
					}
					
					do_on_select_task_materi_sub();
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
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: [this.editor]
		,	tbar		: this.toolbar
		,	collapsible	: true
		,	width		: '33%'
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
                        }
		});
	
	this.panel = new Ext.Container({
			id			: 'sfm_task_progress_panel'
		,	layout		: 'border'
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
    			}
		,	items		: [
				this.grid
			,	m_sfm_task_progress_sub.panel
			]
		});
	
	this.do_cancel = function()
	{
		
		if (this.dml_type == 'insert') {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
					nipg 				: record.data['nipg_pelaksana']
				,	id_rapat 			: record.data['id_rapat']
				,	id_rapat_materi 	: record.data['id_rapat_materi']
				,	isi_rapat_materi 	: record.data['isi_rapat_materi']
				,	batas_waktu_materi 	: record.data['batas_waktu_materi']
				,	status_materi 		: record.data['status_materi']
				,	keterangan_materi 	: record.data['keterangan_materi']
			,       dml_type	: this.dml_type
			}
		,	url	: _g_root +'/module/sfm_task_progress/submit_materi.jsp'
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
		var data = this.sm.getSelections();
		//Ext.MessageBox.alert('Pesan','a'+ data[0].data.status_materi);
		if (data[0].data.status_materi != '1'
			&& data[0].data.status_materi != '2'){
			Ext.MessageBox.alert('Pesan','Materi yang bersifat info, atau Pekerjaan yang telah di-close oleh supervisor tidak dapat diedit');
			return false;
		}
		if (m_sfm_task_prog_ha_level >= 3) {
			this.dml_type = 'update';
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
		m_sfm_task_prog_ha_level = ha_level;
		this.do_load();
		m_sfm_task_progress_sub.do_refresh(ha_level);
	}
}

m_sfm_task_progress = new M_SfmTaskProgress('Task Management');
