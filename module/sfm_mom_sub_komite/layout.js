/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - Prasetya Yanuar (prasetya.yanuar@googlemail.com)
 */
 
 /* TODO : Untuk absensi peserta rapat komite,  di isi oleh  t_pegawai_komite atau t_pegawai_sub_komite
		tergantung pemilihan tipe rapat oleh user. peserta rapat dapat ditambahkan  nipg dapat null, dan 
		id_jabatan_komite juga dapat null, entry dapat menggunakan combobox pada nama_pegawai yang 
		dengan otomatis mengisi nipg (apabila memiliki) jabatan dapat diisi di keterangan (apabila bukan merupakan pejabat komite atau merupakan seorang konsultan)
		t_rapat_absensi_komite_sub_komite sebaiknya ditambah id khusus untuk mengidentifikasi peserta rapat, karena nipg dapat null, dan id_jabatan _komite dapat null*/
		
		
var 	m_sfm_data_rapat_sub;
var		m_sfm_data_materi_mom_sub;
var		m_sfm_data_sub_materi_mom_sub;
var		m_sfm_data_absen_mom_sub;
var 	m_sfm_rapat_id = '';
var		m_sfm_rapat_tgl = '';
var		m_sfm_materi_id = '';

function checkbox_renderer(checkbox)
{
	return function(value) {
		if (value == '1' || value == 'true' || value == true) {
			return 'Hadir';
		} else {
			return 'Tidak Hadir';
		}
	}
}

function do_on_select_rapat_mom_sub(){
	if (typeof m_sfm_data_rapat_central == 'undefined'
	||  typeof m_sfm_data_materi_mom_sub == 'undefined'
	||  typeof m_sfm_data_absen_mom_sub == 'undefined'
	||  m_sfm_rapat_id == '') {
		return;
	}

	m_sfm_data_materi_mom_sub.do_load();
	m_sfm_data_absen_mom_sub.do_load();

}

function do_on_select_materi_mom_sub(){
	if (  m_sfm_materi_id == ''
	||  m_sfm_rapat_id == '') {
		return;
	}

	m_sfm_data_sub_materi_mom_sub.do_load();

}

function do_validate_load(){
	if ( m_sfm_rapat_id == ''
	||  m_sfm_rapat_tgl == '') {
		Ext.MessageBox.alert('Pesan', "Pilih data Rapat Terlebih dahulu");
		return 0;
	}
	return 1;
}

function do_validate_materi_load(){
	if ( m_sfm_rapat_id == ''
	||  m_sfm_rapat_tgl == ''
	||  m_sfm_materi_id == '') {
		Ext.MessageBox.alert('Pesan', "Pilih data Rapat dan Materi Terlebih dahulu");
		return 0;
	}
	return 1;
}

function M_SfmSubMateriRapatMomSub (title){
	this.title = title;
	this.dml_type = '';
	this.ha_level = 0;
	
	this.record = new Ext.data.Record.create([
			{ name	: 'id_rapat' }
		,	{ name	: 'id_rapat_materi' }
		,	{ name	: 'id_rapat_sub_materi' }
		,	{ name	: 'isi_rapat_sub_materi' }
		,	{ name	: 'batas_waktu_sub_materi'}
		,	{ name	: 'status_sub_materi'}
		,	{ name	: 'keterangan_sub_materi'}
		,	{ name	: 'nipg_pelaksana'}
		,	{ name	: 'nipg_supervisor'}	
	]);
	
	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root	: 'rows'
		}
		, this.record);
	
	this.store = new Ext.data.Store({
			url	: _g_root +'/module/sfm_data_rapat_central/data_list_sub_materi_rapat.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});
	
	this.store_peg = new Ext.data.ArrayStore({
			fields	: ['nipg','nama_pegawai']
		,	url	: _g_root +'/module/sfm_data_rapat_central/data_pegawai.jsp'
		,	autoLoad: false
		});
		
	this.cb_pelaksana = new Ext.form.ComboBox({
			fieldLabel	: 'Pelaksana'
		,	store		: this.store_peg
		,	valueField	: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		});
	
	this.cb_supervisor = new Ext.form.ComboBox({
			fieldLabel	: 'Supervisor'
		,	store		: this.store_peg
		,	valueField	: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		});
	
	this.form_id_rapat = new Ext.form.TextField({allowBlank : true});
	this.form_id_rapat_materi = new Ext.form.TextField({allowBlank : true});
	this.form_id_rapat_sub_materi = new Ext.form.TextField({allowBlank : true});
	this.form_isi_rapat_sub_materi = new Ext.form.TextField({allowBlank : false});
	// this.form_batas_waktu	= new Ext.form.TextField({allowBlank : true});
	this.form_batas_waktu	= new Ext.form.DateField({
			emptyText	: 'Y-m-d'
		,	format		: 'Y-m-d'
		,	editable	: false
	});

	
	this.store_status_sub_materi = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'info']
			,	['1', 'Open']
			,	['2', 'Closed Pelaksana']
			,	['3', 'Closed Supervisor']
			,	['4', 'Finished']
			]
		});
	
	this.cb_status_sub_materi = new Ext.form.ComboBox({
			store		: this.store_status_sub_materi
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
	this.form_keterangan = new Ext.form.TextField({allowBlank : true});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_rapat'
			, header	: 'Id Rapat'
			, dataIndex	: 'id_rapat'
			, sortable	: true
			, editor	: this.form_id_rapat
			, hidden	: true
			}
		,	{ id		: 'id_rapat_materi'
			, header	: 'Id Materi Rapat'
			, dataIndex	: 'id_rapat_materi'
			, sortable	: true
			, editor	: this.form_id_rapat_materi
			, hidden	: true
			}
		,	{ id		: 'id_rapat_sub_materi'
			, header	: 'Id Materi Sub Rapat'
			, dataIndex	: 'id_rapat_sub_materi'
			, sortable	: true
			, editor	: this.form_id_rapat_sub_materi
			, hidden	: true
			}
		,	{ id		: 'isi_rapat_sub_materi'
			, header	: 'Sub Materi Rapat'
			, dataIndex	: 'isi_rapat_sub_materi'
			, width		: 150
			, sortable	: true
			, editor	: this.form_isi_rapat_sub_materi
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
			, editor	: this.cb_status_sub_materi
			,renderer	: combo_renderer(this.cb_status_sub_materi)
			}	
		,	{ id		: 'keterangan_sub_materi'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan_sub_materi'
			, width		: 150
			, sortable	: true
			, editor	: this.form_keterangan
			}	
		,	{ id		: 'nipg_pelaksana'
			, header	: 'Pelaksana'
			, dataIndex	: 'nipg_pelaksana'
			, sortable	: true
			, editor	: this.cb_pelaksana
			, renderer  : combo_renderer(this.cb_pelaksana)
			}	
		,	{ id		: 'nipg_supervisor'
			, header	: 'Supervisor'
			, dataIndex	: 'nipg_supervisor'
			, sortable	: true
			, editor	: this.cb_supervisor
			, renderer  : combo_renderer(this.cb_supervisor)
			}	
		];
	
	
	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length
					&&  this.ha_level == 4) {
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
				
				this.btn_add
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_del
			]
		});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'east'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: [this.editor]
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

	this.do_add = function()
	{	if (do_validate_materi_load()){
			this.record_new = new this.record({
						id_rapat : m_sfm_rapat_id
					,	id_rapat_materi : m_sfm_materi_id
					,	id_rapat_sub_materi : ''
					,	isi_rapat_sub_materi :  ''
					,	batas_waktu_sub_materi : ''
					,	status_sub_materi : ''
					,	keterangan_sub_materi : ''
					,	nipg_pelaksana : ''
					,	nipg_supervisor : ''	
				});

			this.editor.stopEditing();
			this.store.insert(0, this.record_new);
			this.sm.selectRow(0);
			this.editor.startEditing(0);

			this.dml_type = 'insert';
		}
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 'delete';
		this.do_save(data[0]);
	}

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
					id_rapat 			: record.data['id_rapat']
				,	id_rapat_materi 	: record.data['id_rapat_materi']
				,	id_rapat_sub_materi 	: record.data['id_rapat_sub_materi']
				,	isi_rapat_sub_materi 	: record.data['isi_rapat_sub_materi']
				,	batas_waktu_sub_materi 	: record.data['batas_waktu_sub_materi']
				,	status_sub_materi 		: record.data['status_sub_materi']
				,	keterangan_sub_materi 	: record.data['keterangan_sub_materi']
				,	nipg_pelaksana 		: record.data['nipg_pelaksana']
				,	nipg_supervisor 	: record.data['nipg_supervisor']	
			,       dml_type	: this.dml_type
			}
		,	url	: _g_root +'/module/sfm_data_rapat_central/submit_sub_materi_rapat.jsp'
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
		
		if (this.ha_level >= 3) {
			this.dml_type = 'update';
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		if (do_validate_materi_load()){
			this.store.load({
				params		: {
					id_rapat : m_sfm_rapat_id
				}
			});
			this.store_peg.load();
		}
	}

	this.do_refresh = function(ha_level)
	{	
		this.ha_level = ha_level;
		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		// this.do_load();
	}
}


function M_SfmMateriRapatMomSub (title){
	this.title = title;
	this.dml_type = '';
	this.ha_level = 0;
	
	this.record = new Ext.data.Record.create([
			{ name	: 'id_rapat' }
		,	{ name	: 'id_rapat_materi' }
		,	{ name	: 'isi_rapat_materi' }
		,	{ name	: 'batas_waktu_materi'}
		,	{ name	: 'status_materi'}
		,	{ name	: 'keterangan_materi'}
		,	{ name	: 'nipg_pelaksana'}
		,	{ name	: 'nipg_supervisor'}	
	]);
	
	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root	: 'rows'
		}
		, this.record);
	
	this.store = new Ext.data.Store({
			url	: _g_root +'/module/sfm_data_rapat_central/data_list_materi_rapat.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});
	
	this.store_peg = new Ext.data.ArrayStore({
			fields	: ['nipg','nama_pegawai']
		,	url	: _g_root +'/module/sfm_data_rapat_central/data_pegawai.jsp'
		,	autoLoad: false
		});
		
	this.cb_pelaksana = new Ext.form.ComboBox({
			fieldLabel	: 'Pelaksana'
		,	store		: this.store_peg
		,	valueField	: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		});
	
	this.cb_supervisor = new Ext.form.ComboBox({
			fieldLabel	: 'Supervisor'
		,	store		: this.store_peg
		,	valueField	: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		});
	
	this.form_id_rapat = new Ext.form.TextField({allowBlank : true});
	this.form_id_rapat_materi = new Ext.form.TextField({allowBlank : true});
	this.form_isi_rapat_materi = new Ext.form.TextField({allowBlank : false});
	// this.form_batas_waktu	= new Ext.form.TextField({allowBlank : true});
	this.form_batas_waktu	= new Ext.form.DateField({
			emptyText	: 'Y-m-d'
		,	format		: 'Y-m-d'
		,	editable	: false
	});

	
	this.store_status_materi = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'info']
			,	['1', 'Open']
			,	['2', 'Closed Pelaksana']
			,	['3', 'Closed Supervisor']
			,	['4', 'Finished']
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
	this.form_keterangan = new Ext.form.TextField({allowBlank : true});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_rapat'
			, header	: 'Id Rapat'
			, dataIndex	: 'id_rapat'
			, sortable	: true
			, editor	: this.form_id_rapat
			, hidden	: true
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
			, width		: 150
			, sortable	: true
			, editor	: this.form_isi_rapat_materi
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
			,renderer	: combo_renderer(this.cb_status_materi)
			}	
		,	{ id		: 'keterangan_materi'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan_materi'
			, width		: 150
			, sortable	: true
			, editor	: this.form_keterangan
			}	
		,	{ id		: 'nipg_pelaksana'
			, header	: 'Pelaksana'
			, dataIndex	: 'nipg_pelaksana'
			, sortable	: true
			, editor	: this.cb_pelaksana
			, renderer  : combo_renderer(this.cb_pelaksana)
			}	
		,	{ id		: 'nipg_supervisor'
			, header	: 'Supervisor'
			, dataIndex	: 'nipg_supervisor'
			, sortable	: true
			, editor	: this.cb_supervisor
			, renderer  : combo_renderer(this.cb_supervisor)
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
						m_sfm_materi_id = data[0].data.id_rapat_materi;
					} else {
						this.btn_del.setDisabled(true);
						m_sfm_materi_id = '';
					}
					do_on_select_materi_mom_sub();
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
				
				this.btn_add
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_del
			]
		});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: [this.editor]
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

	this.do_add = function()
	{	if (do_validate_load()){
			this.record_new = new this.record({
						id_rapat : m_sfm_rapat_id
					,	id_rapat_materi : ''
					,	isi_rapat_materi :  ''
					,	batas_waktu_materi : ''
					,	status_materi : ''
					,	keterangan_materi : ''
					,	nipg_pelaksana : ''
					,	nipg_supervisor : ''	
				});

			this.editor.stopEditing();
			this.store.insert(0, this.record_new);
			this.sm.selectRow(0);
			this.editor.startEditing(0);

			this.dml_type = 'insert';
		}
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 'delete';
		this.do_save(data[0]);
	}

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
					id_rapat 			: record.data['id_rapat']
				,	id_rapat_materi 	: record.data['id_rapat_materi']
				,	isi_rapat_materi 	: record.data['isi_rapat_materi']
				,	batas_waktu_materi 	: record.data['batas_waktu_materi']
				,	status_materi 		: record.data['status_materi']
				,	keterangan_materi 	: record.data['keterangan_materi']
				,	nipg_pelaksana 		: record.data['nipg_pelaksana']
				,	nipg_supervisor 	: record.data['nipg_supervisor']	
			,       dml_type	: this.dml_type
			}
		,	url	: _g_root +'/module/sfm_data_rapat_central/submit_materi_rapat.jsp'
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
		
		if (this.ha_level >= 3) {
			this.dml_type = 'update';
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		if (do_validate_load()){
			this.store.load({
				params		: {
					id_rapat : m_sfm_rapat_id
				}
			});
			this.store_peg.load();
		}
	}

	this.do_refresh = function(ha_level)
	{	
		this.ha_level = ha_level;
		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		// this.do_load();
	}
}

function M_SfmAbsenRapatMomSub (title){
	this.title	= title;
	this.dml_type	= '';
	this.nipg_old = '';
	this.nama_peserta = '';
	this.nipg = '';
	this.id_jabatan_komite = '';
	var chg_hadir = 0;
	var chg_absen = 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_rapat' }
		,	{ name	: 'nipg' }
		,	{ name	: 'nama_pegawai' }
		,	{ name	: 'id_jabatan_komite'}
		,	{ name	: 'status_absensi'}
		,	{ name	: 'keterangan_absensi'}
		,	{ name	: 'jml_hadir'}
		,	{ name	: 'jml_absen'}
		]);

	this.store = new Ext.data.SimpleStore({
			fields	: this.record
		,	url	: _g_root +'/module/sfm_data_rapat_central/data_list_absensi_rapat.jsp'
		,	autoLoad: false
		});
		
	this.jabatan_komite_record = new Ext.data.Record.create([
		{	 name	: 'id'
		},
		{	name	: 'nama'
		}]);
	
	this.store_jabatan_komite = new Ext.data.SimpleStore({
			url		: _g_root +'/module/ref_pegawai_komite/data_jabatan_komite_com.jsp'
		,	fields	: this.jabatan_komite_record
		,	autoLoad	: false
		});
	
	
	
	this.form_id_rapat = new Ext.form.TextField({allowBlank : false});
	
	this.form_nipg = new Ext.form.TextField({allowBlank : true, disabled : true})

	this.form_nama_pegawai = new Ext.form.TextField({
			allowBlank	: false
		});
		
	this.cb_jabatan_komite = new Ext.form.ComboBox({
			store		: this.store_jabatan_komite
		,	valueField	: 'id'
		,	displayField	: 'nama'
		,	mode		: 'local'
		,	allowBlank	: false
		,	typeAhead	: true
		,	triggerAction	: 'all'
		,   disabled	: true
		});

	this.ck_stat_absen = new Ext.form.Checkbox({boxLabel: 'Hadir', 
												listeners:{
													scope : this
												,	change : function (ck, checked, last_checked){
														if (checked){
															Ext.MessageBox.alert('pesan','checked '+chg_hadir);
															chg_hadir++;
															chg_absen--;
														}
														else{
														Ext.MessageBox.alert('pesan','unchecked '+chg_absen);
															chg_hadir--;
															chg_absen++;
														}
													}
												}});
	
	
	this.form_keterangan_absensi = new Ext.form.TextField({allowBlank : true});
	
	this.form_jml_hadir = new Ext.form.NumberField({allowBlank : true, value: 0});
	
	this.form_jml_absen = new Ext.form.NumberField({allowBlank : true, value: 1});
	
	this.cb_pegawai_on_select = function(record)
	{
		this.nipg = record.get('nipg');
		this.id_jabatan_komite = record.get('id_jabatan_komite');

		if (this.nipg != 'undefined' && this.nipg != ''
			&& this.id_jabatan_komite != 'undefined' && this.id_jabatan_komite != '') {
			this.form_nipg.setValue(this.nipg);
			this.cb_jabatan_komite.setValue(this.id_jabatan_komite);
		} 
	}
	
	this.store_peg = new Ext.data.ArrayStore({
			fields	: ['nipg','nama_pegawai','id_jabatan_komite']
		,	url	: _g_root +'/module/sfm_data_rapat_central/data_pegawai.jsp'
		,	autoLoad: false
		});

	this.cb_nama_pegawai = new Ext.form.ComboBox({
			fieldLabel	: 'User'
		,	store		: this.store_peg
		,	valueField	: 'nama_pegawai'
		,	displayField	: 'nama_pegawai'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.cb_pegawai_on_select(record);
				}
			}
		});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'id_rapat'
			, header	: 'id rapat'
			, dataIndex	: 'id_rapat'
			, sortable	: true
			, editor	: this.id_rapat
			, hidden	: true
			}
		,	{ id		: 'nipg'
			, header	: 'NIPG'
			, dataIndex	: 'nipg'
			, sortable	: true
			, editor	: this.form_nipg
			}
		,	{ id		: 'nama_pegawai'
			, header	: 'Nama Pegawai'
			, dataIndex	: 'nama_pegawai'
			, sortable	: true
			, editor	: this.cb_nama_pegawai
			, renderer	: combo_renderer(this.cb_nama_pegawai)
			}
		,	{ id		: 'id_jabatan_komite'
			, header	: 'Jabatan Komite'
			, dataIndex	: 'id_jabatan_komite'
			, sortable	: true
			, editor	: this.cb_jabatan_komite
			, renderer	: combo_renderer(this.cb_jabatan_komite)
			}
		,	{ id		: 'status_absensi'
			, header	: 'Absensi'
			, dataIndex	: 'status_absensi'
			, sortable	: true
			, editor	: this.ck_stat_absen
			, renderer	: checkbox_renderer(this.ck_stat_absen)
			}
		,	{ id		: 'keterangan_absensi'
			, header	: 'Keterangan Absen'
			, dataIndex	: 'keterangan_absensi'
			, sortable	: true
			, editor	: this.form_keterangan_absensi
			}
		,	{ id		: 'jml_hadir'
			, header	: 'Jumlah Hadir'
			, dataIndex	: 'jml_hadir'
			, sortable	: true
			, editor	: this.form_jml_hadir
			}
		,	{ id		: 'jml_absen'
			, header	: 'Jumlah Absen'
			, dataIndex	: 'jml_absen'
			, sortable	: true
			, editor	: this.form_jml_absen
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

	this.panel = new Ext.grid.GridPanel({
			title		: this.title			
		,	region				: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	autoExpandColumn: 'nama_pegawai'
		,	width		: '33%'
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
		if (do_validate_load()){
			this.record_new = new this.record({
					id_rapat	: m_sfm_rapat_id
				,	nipg	: ''
				,	nama_pegawai : ''
				,	id_jabatan_komite : ''
				,	status_absensi : ''
				,	keterangan_absensi : ''
				,	jml_hadir : ''
				,	jml_absen : ''
				});
			chg_hadir = 0;
			chg_absen = 1;
			this.editor.stopEditing();
			this.store.insert(0, this.record_new);
			this.sm.selectRow(0);
			this.editor.startEditing(0);

			this.dml_type = 'insert';
		}
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}
		this.store.remove(data);
			this.sm.selectRow(0);
		this.dml_type = 'delete';
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{	
		if (this.dml_type == 'insert') {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{	
		var aktif =  record.data['status_absensi'] == true ? '1':'0';
		
		if (this.dml_type != 'update'){
			this.nipg_old = '';
			this.nama_peserta = '';
		}
		Ext.Ajax.request({
			params  : {
				id_rapat	: record.data['id_rapat']
			,	nipg	: record.data['nipg']
			,	nama_pegawai : record.data['nama_pegawai']
			,	id_jabatan_komite : record.data['id_jabatan_komite']
			,	status_absensi : aktif
			,	keterangan_absensi : record.data['keterangan_absensi']
			,	jml_hadir : chg_hadir
			,	jml_absen : chg_absen
			,	nipg_old : this.nipg_old
			,	nama_peserta : this.nama_peserta
			,       dml_type	: this.dml_type
			}
		,	url	: _g_root +'/module/sfm_data_rapat_central/submit_absensi_rapat.jsp'
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
		var data = this.panel.getSelectionModel().getSelected();
		this.nipg_old = data.data.nipg;
		this.nama_peserta = data.data.nama_pegawai;
		chg_hadir = data.data.jml_hadir;
		chg_absen = data.data.jml_absen;
		if (this.ha_level >= 3) {
			this.dml_type = 'update';
			return true;
		}
		return false;
	}

	this.do_load = function()
	{	if (do_validate_load()){
			// Ext.Messagebox.Alert('Pesan','id_rapat  : '+ m_sfm_rapat_id + ' tgl_rapat : ' + m_sfm_rapat_tgl);
			this.store.load({
				params		: {
					id_rapat  : m_sfm_rapat_id
				, 	tgl_rapat : m_sfm_rapat_tgl 
				}
			});
			this.store_jabatan_komite.load({
				params		: {
					id_kel : '0 or 1=1'
				}
			});
			this.store_peg.load();
		}
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		// this.do_load();
	}

}
 
 function M_SfmInputRapatMomSub (title){
	this.title 	= title;
	this.ha_level	= 0;
	this.data_rapat	= '';
	this.dml_type	= '';
	this.id_stop	= '';
	this.nipg	= '';
	
	this.record = new Ext.data.Record.create([
		{
			name	: 'id'
		},{
			name	: 'type'
		},{
			name	: 'type_name'
		},{
			name	: 'sfm_no'
		},{
			name	: 'title'
		},{
			name	: 'date'
		},{
			name	: 'place'
		},{
			name	: 'note_date'
		},{
			name	: 'note_writer'
		}]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/sfm_mom_sub_komite/data_list_rapat_sub.jsp'
		,	autoLoad: false
		});
	
		
	this.store_tipe_rapat =  new Ext.data.ArrayStore({
			fields	: ['id_kel_jabatan_komite_sub_komite','nama_kel_jabatan_komite_sub_komite']
		,	url	: _g_root +'/module/sfm_mom_sub_komite/data_kel_jabatan_komite.jsp'
		,	autoLoad: false
		});
		
	this.cb_tipe_rapat_tbar = new Ext.form.ComboBox({
			// fieldLabel	: 'Sub Committee Rapat'
			store		: this.store_tipe_rapat
		,	valueField	: 'id_kel_jabatan_komite_sub_komite'
		,	displayField	: 'nama_kel_jabatan_komite_sub_komite'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	width	: 250
		,	allowBlank	: false
		,	editable	: false
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.do_load();
				}
			}
		});
			
	/* Data Rapat */
	this.form_tipe_rapat = new Ext.form.TextField();
	this.form_no_rapat = new Ext.form.TextField({
			fieldLabel	: 'No. Rapat'
		,	disabled	: false
		});
	this.form_judul_rapat = new Ext.form.TextField({
			fieldLabel	: 'Judul Rapat'
		,	disabled	: false
		});
	this.form_tanggal_rapat = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Rapat'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		});
	this.form_lokasi_rapat = new Ext.form.TextField({
			fieldLabel	: 'Lokasi Rapat'
		,	disabled	: false
		});
	this.form_nama_notulis = new Ext.form.TextField({
			fieldLabel	: 'Nama Notulis'
		,	disabled	: false
		});
	this.form_tanggal_Notulen = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Notulen'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			id			: 'type_name'
		,	header		: 'Tipe Rapat'
		,	dataIndex	: 'type_name'
		,	width		: 100
		},{
			id			: 'sfm_no'
		,	header		: 'Nomor Rapat'
		,	dataIndex	: 'sfm_no'
		,	width		: 90
		,	editor		: this.form_no_rapat
		},{
			id			: 'title'
		,	header		: 'Judul Rapat'
		,	dataIndex	: 'title'
		,	width		: 180
		,	editor		: this.form_judul_rapat
		},{
			id			: 'date'
		,	header		: 'Tanggal'
		,	dataIndex	: 'date'
		,	width		: 100
		,	editor		: this.form_tanggal_rapat
		},{
			id			: 'place'
		,	header		: 'Lokasi Rapat'
		,	dataIndex	: 'place'
		,	width		: 120
		,	editor		: this.form_lokasi_rapat
		},{
			id			: 'note_date'
		,	header		: 'Tanggal Notulen'
		,	dataIndex	: 'note_date'
		,	width		: 100
		,	editor		: this.form_tanggal_Notulen
		},{
			id			: 'note_writer'
		,	header		: 'Notulis'
		,	dataIndex	: 'note_writer'
		,	width		: 150
		,	editor		: this.form_nama_notulis
		}];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && this.ha_level == 4) {
						this.btn_print.setDisabled(false);
						this.btn_del.setDisabled(false);
						m_sfm_rapat_id = data[0].data.id;
						m_sfm_rapat_tgl = data[0].data.date;
					} else {
						this.btn_print.setDisabled(true);
						this.btn_del.setDisabled(true);
						m_sfm_rapat_id = '';
						m_sfm_rapat_tgl = '';
					}
					do_on_select_rapat_mom_sub();
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
		
	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_print();
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
				
				this.cb_tipe_rapat_tbar
			]
		});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region				: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	autoExpandColumn: 'title'
		,	tbar : [this.btn_print,'-','Sub Committee : ',this.cb_tipe_rapat_tbar ]
		,	width		: '33%'
		,	height		: 150 
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
                        }
		});

	/* Functions and events */
	// this.do_assign_absensi_pegawai_komite = function(record)
	// {
		// Ext.Ajax.request({
			// params  : {
				// id			: record.data['id']
			// ,	type		: record.data['type']
			// ,	date 		: record.data['date']
			// ,   dml_type	: this.dml_type
			// }
		// ,	url	: _g_root +'/module/sfm_data_rapat_central/submit_absensi_pegawai.jsp'
		// ,	waitMsg	: 'Mohon Tunggu ...'
		// ,	success :
				// function (response)
				// {
					// var msg = Ext.util.JSON.decode(response.responseText);

					// if (msg.success == false) {
						// Ext.MessageBox.alert('Pesan', msg.info);
					// }

					// this.do_load();
				// }
		// ,	scope	: this
		// });
	// }
	
	this.do_add = function()
	{
		this.record_new = new this.record({
				id	: ''
			,	type	: '1'
			,	sfm_no : ''
			,	title : ''
			,	date : ''
			,	place : ''
			,	note_date : ''
			,	note_writer : ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 'insert';
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}
		this.store.remove(data);
			this.sm.selectRow(0);
		this.dml_type = 'delete';
		this.do_save(data[0]);
	}

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
				id			: record.data['id']
			,	type		: record.data['type']
			,	sfm_no 		: record.data['sfm_no']
			,	title 		: record.data['title']
			,	date 		: record.data['date']
			,	place 		: record.data['place']
			,	note_date 	: record.data['note_date']
			,	note_writer : record.data['note_writer']
			,   dml_type	: this.dml_type
			}
		,	url	: _g_root +'/module/sfm_data_rapat_central/submit_rapat_central.jsp'
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
		// if (this.dml_type == 'insert') {
			// this.do_assign_absensi_pegawai_komite(record);		// assign absensi pegawai komite
		// }
		
	}

	this.do_edit = function(row)
	{
		if (this.ha_level >= 3) {
			this.dml_type = 'update';
			return true;
		}
		return false;
	}
	
	this.do_print = function(){
		// Ext.Ajax.request({
			// params  : {
					// id_rapat 			: m_sfm_rapat_id
			// }
		// ,	url	: _g_root +'/module/sfm_mom_komite/data_rapat_export.jsp'
		// ,	waitMsg	: 'Mohon Tunggu ...'
		// ,	success :
				// function (response)
				// {
					// var msg = Ext.util.JSON.decode(response.responseText);

					// if (msg.success == false) {
						// Ext.MessageBox.alert('Pesan', msg.info);
					// }

				// }
		// ,	scope	: this
		// });
		var form;
		form = document.createElement('form');
		
		form.setAttribute('method', 'post');
		form.setAttribute('action', _g_root +'/module/sfm_mom_sub_komite/data_rapat_export.jsp');
		
		var hiddenField = document.createElement ('input');
        hiddenField.setAttribute('type', 'hidden');
        hiddenField.setAttribute('name', 'id_rapat');
        hiddenField.setAttribute('value', m_sfm_rapat_id);
		
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		form.submit();

		// // create the form
		// form = createElement('form', {
			// method: 'post',
			// action: _g_root +'/module/sfm_mom_komite/data_rapat_export.jsp'
		// }, {
			// display: NONE
		// }, doc.body);
		
		// // add the values
		// each(['id_rapat'], function(name) {
			// createElement('input', {
				// type: HIDDEN,
				// name: name,
				// value: { 
					// id_rapat: m_sfm_rapat_id
				// }[name]
			// }, null, form);
		// });
		
		// // submit
		// form.submit();
		
		// // clean up
		// discardElement(form);
	}

	this.do_load = function()
	{
		this.store_tipe_rapat.load();
		this.store.load({
			params		: {
				type : this.cb_tipe_rapat_tbar.getValue()
			}});
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
 
 
 function M_SfmDataRapatMomSub (){
	m_sfm_data_rapat_mom_sub_master = new M_SfmInputRapatMomSub('Rapat Komite');
	// m_sfm_data_absen_mom_sub = new M_SfmAbsenRapatMomSub('Absensi Peserta')
	// m_sfm_data_materi_mom_sub = new M_SfmMateriRapatMomSub('Materi Rapat');
	// m_sfm_data_sub_materi_mom_sub = new M_SfmSubMateriRapatMomSub('Sub Materi Rapat');
	
	// this.det_materi = new Ext.Container({
			// region		: 'south'
		// ,	title		: 'Materi'
		// ,	layout		: 'border'
		// ,	width		: '50%'
		// ,	defaults	: {
				// loadMask	: {msg: 'Pemuatan...'}
			// ,	split		: true
			// ,	autoScroll	: true
			// ,	animCollapse	: true
    			// }
		// ,	items	: [
				// m_sfm_data_materi_mom_sub.panel
			// ,	m_sfm_data_sub_materi_mom_sub.panel
			// ]
		// });
// //	this.panel_add = new M_ObsInputStop('Input Data Observasi');
	// this.grid_detail = new Ext.TabPanel({
			// autoScroll		: true
		// ,	enableTabScroll	: true
		// ,	region			: 'south'
        // ,	activeTab		: 0
		// ,	height			: 350
		// ,	defaults		: {
				// loadMask		: {msg: 'Pemuatan...'}
			// ,	split			: true
			// ,	autoScroll		: true
			// ,	animCollapse	: true
    		// }
        // ,	items		: [
					// m_sfm_data_absen_mom_sub.panel
				// ,	this.det_materi
			// ]
    // });

	this.panel = new Ext.Panel({
			id				: 'sfm_mom_sub_komite_panel'
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_sfm_data_rapat_mom_sub_master.panel
			// ,	this.grid_detail
			]
	});
	this.do_refresh = function(ha_level)
	{
		m_sfm_rapat_id 	= '';
		m_sfm_materi_id 	= '';
		
		m_sfm_data_rapat_mom_sub_master.do_refresh(ha_level);
		// m_sfm_data_absen_mom_sub.do_refresh(ha_level);
		// m_sfm_data_materi_mom_sub.do_refresh(ha_level);
		// m_sfm_data_sub_materi_mom_sub.do_refresh(ha_level);
	}
 }
 
 m_sfm_mom_sub_komite = new M_SfmDataRapatMomSub ();