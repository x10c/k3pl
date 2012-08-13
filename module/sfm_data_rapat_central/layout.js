/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - Prasetya Yanuar (prasetya.yanuar@googlemail.com)
 *   - m.shulhan (ms@kilabit.org)
 */
 
 /* TODO : Untuk absensi peserta rapat komite,  di isi oleh  t_pegawai_komite atau t_pegawai_sub_komite
		tergantung pemilihan tipe rapat oleh user. peserta rapat dapat ditambahkan  nipg dapat null, dan 
		id_jabatan_komite juga dapat null, entry dapat menggunakan combobox pada nama_pegawai yang 
		dengan otomatis mengisi nipg (apabila memiliki) jabatan dapat diisi di keterangan (apabila bukan merupakan pejabat komite atau merupakan seorang konsultan)
		t_rapat_absensi_komite_sub_komite sebaiknya ditambah id khusus untuk mengidentifikasi peserta rapat, karena nipg dapat null, dan id_jabatan _komite dapat null*/


var m_sfm_data_rapat_central;
var m_sfm_central_d	= _g_root +'/module/sfm_data_rapat_central/';
var m_sfm_central_master;
var m_sfm_central_materi;
var m_sfm_central_submateri;
var m_sfm_central_absen;
var m_sfm_rapat_id	= '';
var m_sfm_rapat_tgl	= '';
var m_sfm_materi_id	= '';
var err_valid ='';

var store_pic_seksi = new Ext.data.ArrayStore({
		fields	: ['id_seksi','id_dinas','id_departemen','nama_seksi','kepala_seksi']
	,	url	: m_sfm_central_d +'data_ref_pic_seksi.jsp'
	,	autoLoad: false
	});

var store_pic_dinas = new Ext.data.ArrayStore({
		fields	: ['id_dinas','id_departemen','nama_dinas','kepala_dinas']
	,	url	: m_sfm_central_d +'data_ref_pic_dinas.jsp'
	,	autoLoad: false
	});
	
function checkbox_renderer(checkbox){
	return function(value) {
		if (value == '1' || value == 'true' || value == true) {
			return 'Hadir';
		} else {
			return 'Tidak Hadir';
		}
	}
}

function do_on_select_rapat_central(){
	if (typeof m_sfm_data_rapat_central == 'undefined'
	||  typeof m_sfm_central_materi == 'undefined'
	||  typeof m_sfm_central_absen == 'undefined'
	||  m_sfm_rapat_id == '') {
		return;
	}
	m_sfm_central_materi.do_load();
	m_sfm_central_absen.do_load();
}

function do_on_select_materi_central(){
	if (  m_sfm_materi_id == ''
	||  m_sfm_rapat_id == '') {
		return;
	}

	m_sfm_central_submateri.do_load();
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

function M_SfmSubMateriRapatCentral(){
	this.dml_type	= '';
	this.ha_level	= 0;
	this.pic_seksi	= '';
	this.pic_kasi 	= '';
	this.pic_dinas	= '';
	this.pic_kadin	= '';

	this.record = new Ext.data.Record.create([
			{ name	: 'id_rapat' }
		,	{ name	: 'id_rapat_materi' }
		,	{ name	: 'id_rapat_sub_materi' }
		,	{ name	: 'isi_rapat_sub_materi' }
		,	{ name	: 'batas_waktu_sub_materi'}
		,	{ name	: 'status_sub_materi'}
		,	{ name	: 'keterangan_sub_materi'}
		,	{ name	: 'nipg_pelaksana'}
		,	{ name	: 'seksi_pelaksana'}
		,	{ name	: 'nipg_supervisor'}
		,	{ name	: 'dinas_supervisor'}
	]);

	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root	: 'rows'
		}
		, this.record);

	this.store = new Ext.data.Store({
			url	: m_sfm_central_d +'data_list_sub_materi_rapat.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		,	pruneModifiedRecords : true
		});

	this.form_id_rapat		= new Ext.form.TextField({allowBlank : true, hidden : true});
	this.form_id_rapat_materi	= new Ext.form.TextField({allowBlank : true, hidden : true});
	this.form_id_rapat_sub_materi	= new Ext.form.TextField({allowBlank : true, hidden : true});
	this.form_isi_rapat_sub_materi	= new Ext.form.TextField({fieldLabel	: 'Sub Materi',allowBlank : false, anchor: '98%'});
	this.form_batas_waktu		= new Ext.form.DateField({
			fieldLabel	: 'Batas Waktu'
		,	emptyText	: 'Thn-Bln-Tgl'
		,	format		: 'Y-m-d'
		,	allowBlank	: true
		,	editable	: false
		,	width		: 100
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
			fieldLabel		: 'Status Materi'
		,	store		: this.store_status_sub_materi
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});

	this.form_keterangan = new Ext.form.TextField({fieldLabel	: 'Keterangan',allowBlank : true});
	
	this.form_pic_seksi_on_select = function(record)
	{
		this.pic_seksi		= record.get('id_seksi');
		this.pic_kasi = record.get('kepala_seksi');
	};
	
	this.form_pic_dinas_on_select = function(record)
	{
		this.pic_dinas		= record.get('id_dinas');
		this.pic_kadin = record.get('kepala_dinas');
	};
		
	this.form_pic_seksi = new Ext.form.ComboBox({
			fieldLabel		: 'Penanggung Jawab'
		,	store			: store_pic_seksi
		,	valueField		: 'id_seksi'
		,	displayField	: 'nama_seksi'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_pic_seksi_on_select(record);
					this.form_pic_dinas.allowBlank = true;
				}
		}
	});

	this.form_pic_dinas = new Ext.form.ComboBox({
			fieldLabel		: 'Supervisor'
		,	store			: store_pic_dinas
		,	valueField		: 'id_dinas'
		,	displayField	: 'nama_dinas'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_pic_dinas_on_select(record);
				}
		}
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Id Rapat'
		,	dataIndex	: 'id_rapat'
		,	hidden		: true
		},{
			header		: 'Id Materi Rapat'
		,	dataIndex	: 'id_rapat_materi'
		,	hidden		: true
		},{
			header		: 'Id Materi Sub Rapat'
		,	dataIndex	: 'id_rapat_sub_materi'
		,	hidden		: true
		},{
			header		: 'Sub Materi Rapat'
		,	dataIndex	: 'isi_rapat_sub_materi'
		,	width		: 250
		},{
			header		: 'Batas Waktu'
		,	dataIndex	: 'batas_waktu_sub_materi'
		},{
			header		: 'Status'
		,	dataIndex	: 'status_sub_materi'
		,	renderer	: combo_renderer(this.cb_status_sub_materi)
		},{
			header		: 'Keterangan'
		,	dataIndex	: 'keterangan_sub_materi'
		,	width		: 150
		},{
			header		: 'Pelaksana'
		,	dataIndex	: 'seksi_pelaksana'
		,	renderer	: combo_renderer(this.form_pic_seksi)
		},{
			header		: 'Supervisor'
		,	dataIndex	: 'dinas_supervisor'
		,	renderer	: combo_renderer(this.form_pic_dinas)
		},{
			header		: 'Pelaksana'
		,	dataIndex	: 'nipg_pelaksana'
		,	hidden	: true
		},{
			header		: 'Pelaksana'
		,	dataIndex	: 'nipg_supervisor'
		,	hidden	: true
		}];

	this.cm = new Ext.grid.ColumnModel({
		columns	: this.columns
	,	defaults: {
			sortable	: true
		,	hideable	: false
		,	menuDisabled	: true
		}
	});

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
		
	this.btn_save = new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
		});

	this.btn_save1 = new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				if (do_validate_materi_load()){
					this.dml_type = 'insert';
					this.do_save();
				}
			}
		});
		
	this.btn_cancel = new Ext.Button({
			text		: 'Batal'
		,	iconCls		: 'del16'
		,	scope		: this
		,	handler		: function() {
				this.do_cancel();
				this.form_pic_dinas.allowBlank = true;
			}
		});
		
	this.panel_add = new Ext.form.FormPanel({
		title		: 'Input Sub Materi'
	,	labelAlign	: 'right'
	,	labelWidth	: 220
	,	autoWidth	: true
	,	autoHeight	: true
	,	bodyCssClass	: 'stop-panel-form'
	,	style		: 'margin: 8px;'
	,	tbar		: [
			this.btn_cancel
		,	'-'
		,	this.btn_save
		]
	,	items		: [
		this.form_id_rapat
		,	this.form_id_rapat_materi
		,this.form_id_rapat_sub_materi
		,{
                xtype: 'panel',
                layout: 'column',
                baseCls: 'x-plain',
                border:false,
                items:[
                    {columnWidth: 0.9, layout: 'form', baseCls: 'x-plain', labelWidth:80,
                                items: [this.form_isi_rapat_sub_materi]
                    }
                ]
        }
		,{
                xtype: 'panel',
                layout: 'column',
                baseCls: 'x-plain',
                border:false,
                items:[
                    {columnWidth: 0.5, layout: 'form', baseCls: 'x-plain', labelWidth:80,
                                items: [
                                    this.form_batas_waktu
								,	this.cb_status_sub_materi
                                    
                                ]
                    },      
                    {columnWidth: 0.5, layout: 'form', baseCls: 'x-plain', labelWidth:80,
                                items: [
                                    this.form_keterangan
									,	this.form_pic_seksi
									,	this.form_pic_dinas
                                ]
                    }
                ]
        }		
		]
		});
		
	this.panel = new Ext.grid.GridPanel({
			title		: 'Sub Materi Rapat'
		,	region		: 'east'
		,	store		: this.store
		,	sm		: this.sm
		,	cm		: this.cm
		,	plugins		: [Ext.ux.grid.DataDrop]
		,	autoResize	: true
		,	height		: 250
		,	tbar		: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			,	'-'
			,	this.btn_save1
			]
		,	collapsible	: true
		,	autoResize	: true
		,       listeners       : {
				scope		: this
			,	rowdblclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
			}
		});

	this.do_add = function()
	{	
	if (do_validate_materi_load()){
			m_sfm_central_sub_materi_con.layout.setActiveItem(this.panel_add);
			
			this.form_id_rapat.setValue(m_sfm_rapat_id);
			this.form_id_rapat_materi.setValue(m_sfm_materi_id);
			this.form_id_rapat_sub_materi.setValue('');
			this.form_isi_rapat_sub_materi.setValue('');
			this.form_batas_waktu.setValue('');
			this.cb_status_sub_materi.setValue('');
			this.form_keterangan.setValue('');
			this.form_pic_seksi.setValue('');
			this.form_pic_dinas.setValue('');

			this.dml_type = 'insert_one';
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
		m_sfm_central_sub_materi_con.layout.setActiveItem(this.panel);
		this.form_pic_dinas.allowBlank = true;
	}
	
	this.is_valid = function()
	{
			
		if (!this.form_isi_rapat_sub_materi.isValid()) {
			err_valid = " [Pilihan Isi Sub Materi belum diisi] ";
			return false;
		}

		if (!this.form_batas_waktu.isValid()) {
			err_valid = " [Pilihan Batas Waktu belum diisi] ";
			return false;
		}
		
		if (!this.cb_status_sub_materi.isValid()) {
			err_valid = " [Pilihan Status Materi belum diisi] ";
			return false;
		}

		if (this.form_pic_seksi.isValid()) {
			if (!this.form_pic_dinas.isValid()) {
				err_valid = " [Pilihan Supervisor belum diisi] ";
				return false;
			}
		}

		err_valid = '';
		return true;
	}

	this.do_save = function(record)
	{	
		if (!this.is_valid() && (this.dml_type == 'insert_one' || this.dml_type == 'update')) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!'+err_valid);
			return;
		}
		var data = "[";
		if (this.dml_type == 'insert'){
			var mods = this.store.getModifiedRecords();
			
			for (i = 0; i < mods.length; i++){
				if (i > 0) {
					data += ",";
				}
				
				data	+="{ id_rapat: '"+ m_sfm_rapat_id +"' "
						+ ", id_rapat_materi: '"+ m_sfm_materi_id +"' "
						+ ", id_rapat_sub_materi: '"+ mods[i].get('id_rapat_sub_materi') +"' "
						+ ", isi_rapat_sub_materi: '"+ mods[i].get('isi_rapat_sub_materi') +"' "
						+ ", batas_waktu_sub_materi: '"+ mods[i].get('batas_waktu_sub_materi') +"' "
						+ ", status_sub_materi: '"+ mods[i].get('status_sub_materi') +"' "
						+ ", keterangan_sub_materi: '"+ mods[i].get('keterangan_sub_materi') +"' "
						+ ", nipg_pelaksana: '"+ mods[i].get('nipg_pelaksana') +"' "
						+ ", nipg_supervisor: '"+ mods[i].get('nipg_supervisor') +"' "
						+ ", seksi_pelaksana: '"+ mods[i].get('seksi_pelaksana') +"' "
						+ ", dinas_supervisor: '"+ mods[i].get('dinas_supervisor') +"' "
						+ " } ";
			}
		}else if(this.dml_type == 'insert_one'){
			
			data	+="{ id_rapat: '"+ m_sfm_rapat_id +"' "
						+ ", id_rapat_materi: '"+ m_sfm_materi_id +"' "
						+ ", id_rapat_sub_materi: '"+ this.form_id_rapat_sub_materi.getValue() +"' "
						+ ", isi_rapat_sub_materi: '"+ this.form_isi_rapat_sub_materi.getValue() +"' "
						+ ", batas_waktu_sub_materi: '"+ this.form_batas_waktu.getRawValue() +"' "
						+ ", status_sub_materi: '"+ this.cb_status_sub_materi.getValue() +"' "
						+ ", keterangan_sub_materi: '"+ this.form_keterangan.getValue() +"' "
						+ ", nipg_pelaksana: '"+ this.pic_kasi +"' "
						+ ", nipg_supervisor: '"+ this.pic_kadin +"' "
						+ ", seksi_pelaksana: '"+ this.form_pic_seksi.getValue() +"' "
						+ ", dinas_supervisor: '"+ this.form_pic_dinas.getValue() +"' "
						+ " } ";
						this.dml_type = 'insert';
		}
		else if(this.dml_type == 'update'){
			data	+="{ id_rapat: '"+ m_sfm_rapat_id +"' "
						+ ", id_rapat_materi: '"+ m_sfm_materi_id +"' "
						+ ", id_rapat_sub_materi: '"+ this.form_id_rapat_sub_materi.getValue() +"' "
						+ ", isi_rapat_sub_materi: '"+ this.form_isi_rapat_sub_materi.getValue() +"' "
						+ ", batas_waktu_sub_materi: '"+ this.form_batas_waktu.getRawValue() +"' "
						+ ", status_sub_materi: '"+ this.cb_status_sub_materi.getValue() +"' "
						+ ", keterangan_sub_materi: '"+ this.form_keterangan.getValue() +"' "
						+ ", nipg_pelaksana: '"+ this.pic_kasi +"' "
						+ ", nipg_supervisor: '"+ this.pic_kadin +"' "
						+ ", seksi_pelaksana: '"+ this.form_pic_seksi.getValue() +"' "
						+ ", dinas_supervisor: '"+ this.form_pic_dinas.getValue() +"' "
						+ " } ";
		}else {
			var record = this.sm.getSelections();
			if (!record.length) {
				return;
			}
			data	+="{ id_rapat: '"+ m_sfm_rapat_id +"' "
						+ ", id_rapat_materi: '"+ m_sfm_materi_id +"' "
						+ ", id_rapat_sub_materi: '"+ record[0].data['id_rapat_sub_materi'] +"' "
						+ ", isi_rapat_sub_materi: '"+ record[0].data['isi_rapat_sub_materi'] +"' "
						+ ", batas_waktu_sub_materi: '"+ record[0].data['batas_waktu_sub_materi'] +"' "
						+ ", status_sub_materi: '"+ record[0].data['status_sub_materi'] +"' "
						+ ", keterangan_sub_materi: '"+ record[0].data['keterangan_sub_materi'] +"' "
						+ ", nipg_pelaksana: '"+ record[0].data['nipg_pelaksana'] +"' "
						+ ", nipg_supervisor:  '"+ record[0].data['nipg_supervisor'] +"' "
						+ ", seksi_pelaksana: '"+ record[0].data['seksi_pelaksana'] +"' "
						+ ", dinas_supervisor: '"+ record[0].data['dinas_supervisor'] +"' "
						+ " } ";
		}
		data +="]";
		
		Ext.Ajax.request({
			params  : {
					data : data
				,	dml_type		: this.dml_type
			}
		,	url	: m_sfm_central_d +'submit_sub_materi_rapat.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
						
					}
					if (this.dml_type = 'update'){
						m_sfm_central_sub_materi_con.layout.setActiveItem(this.panel);
					}
					this.do_load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{	
		this.form_pic_dinas.allowBlank = true;
		var data = this.sm.getSelections();
		
		if (this.ha_level >= 3) {
			this.dml_type = 'update';
			m_sfm_central_sub_materi_con.layout.setActiveItem(this.panel_add);
			
			this.form_id_rapat.setValue(m_sfm_rapat_id);
			this.form_id_rapat_materi.setValue(data[0].data.id_rapat_materi);
			this.form_id_rapat_sub_materi.setValue(data[0].data.id_rapat_sub_materi);
			this.form_isi_rapat_sub_materi.setValue(data[0].data.isi_rapat_sub_materi);
			this.form_batas_waktu.setValue(data[0].data.batas_waktu_sub_materi);
			this.cb_status_sub_materi.setValue(data[0].data.status_sub_materi);
			this.form_keterangan.setValue(data[0].data.keterangan_sub_materi);
			this.form_pic_seksi.setValue(data[0].data.seksi_pelaksana);
			this.form_pic_dinas.setValue(data[0].data.dinas_supervisor);
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
				,	id_rapat_materi : m_sfm_materi_id
				}
			});

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
	}
}

function M_SfmMateriRapatCentral(){
	this.dml_type	= '';
	this.ha_level	= 0;
		this.pic_seksi	= '';
	this.pic_kasi 	= '';
	this.pic_dinas	= '';
	this.pic_kadin	= '';
	

	this.record = new Ext.data.Record.create([
			{ name	: 'id_rapat' }
		,	{ name	: 'id_rapat_materi' }
		,	{ name	: 'isi_rapat_materi' }
		,	{ name	: 'batas_waktu_materi'}
		,	{ name	: 'status_materi'}
		,	{ name	: 'keterangan_materi'}
		,	{ name	: 'nipg_pelaksana'}
		,	{ name	: 'seksi_pelaksana'}
		,	{ name	: 'nipg_supervisor'}
		,	{ name	: 'dinas_supervisor'}
	]);

	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root	: 'rows'
		}
		, this.record);

	this.store = new Ext.data.Store({
			url	: m_sfm_central_d +'data_list_materi_rapat.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		,	pruneModifiedRecords : true
		});

	this.form_id_rapat		= new Ext.form.TextField({allowBlank : true, hidden : true});
	this.form_id_rapat_materi	= new Ext.form.TextField({allowBlank : true, hidden : true});
	this.form_isi_rapat_materi	= new Ext.form.TextField({fieldLabel	: 'Materi Rapat',allowBlank : false, anchor: '98%'});
	this.form_keterangan		= new Ext.form.TextField({fieldLabel	: 'Keterangan',allowBlank : true});
	this.form_batas_waktu		= new Ext.form.DateField({
			fieldLabel	: 'Batas Waktu'
		,	emptyText	: 'Thn-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	altFormats	: 'Y-m-d'
		,	allowBlank	: true
		,	editable	: false
		,	width		: 100
	});
	// this.form_batas_waktu		= new Ext.form.TextField({
			// fieldLabel	: 'Batas Waktu'
		// ,	emptyText	: 'Thn-Bln-Tgl'
		// ,	format		: 'Y-m-d'
		// ,	altFormats	: 'Y-m-d'
		// ,	allowBlank	: false
		// ,	editable	: false
		// ,	width		: 100
	// });
	
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
			fieldLabel : 'Status'
		,	store		: this.store_status_materi
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});
	
	this.form_pic_seksi_on_select = function(record)
	{
		this.pic_seksi	= record.get('id_seksi');
		this.pic_kasi 	= record.get('kepala_seksi');
	};
	
	this.form_pic_dinas_on_select = function(record)
	{
		this.pic_dinas	= record.get('id_dinas');
		this.pic_kadin 	= record.get('kepala_dinas');
	};
		
	this.form_pic_seksi = new Ext.form.ComboBox({
			fieldLabel		: 'Penanggung Jawab'
		,	store			: store_pic_seksi
		,	valueField		: 'id_seksi'
		,	displayField	: 'nama_seksi'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_pic_seksi_on_select(record);
					this.form_pic_dinas.allowBlank = false
				}
		}
	});
	this.form_pic_dinas = new Ext.form.ComboBox({
			fieldLabel		: 'Supervisor'
		,	store			: store_pic_dinas
		,	valueField		: 'id_dinas'
		,	displayField	: 'nama_dinas'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_pic_dinas_on_select(record);
					this.allowBlank = true;
				}
		}
	});
	
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Id Rapat'
		,	dataIndex	: 'id_rapat'
		,	hidden		: true
		},{
			header		: 'Id Materi Rapat'
		,	dataIndex	: 'id_rapat_materi'
		,	hidden		: true
		},{
			header		: 'Materi Rapat'
		,	dataIndex	: 'isi_rapat_materi'
		,	width		: 250
		},{
			header		: 'Batas Waktu'
		,	dataIndex	: 'batas_waktu_materi'
		,	format		: 'Y-m-d'
		},{
			header		: 'Status'
		,	dataIndex	: 'status_materi'
		,	renderer	: combo_renderer(this.cb_status_materi)
		},{
			header		: 'Keterangan'
		,	dataIndex	: 'keterangan_materi'
		,	width		: 150
		},{
			header		: 'Pelaksana'
		,	dataIndex	: 'seksi_pelaksana'
		,	renderer	: combo_renderer(this.form_pic_seksi)
		},{
			header		: 'Supervisor'
		,	dataIndex	: 'dinas_supervisor'
		,	renderer	: combo_renderer(this.form_pic_dinas)
		}];

	this.cm = new Ext.grid.ColumnModel({
		columns	: this.columns
	,	defaults: {
			sortable	: true
		,	hideable	: false
		,	menuDisabled	: true
		}
	});

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
						m_sfm_materi_id = data[0].data.id_rapat_materi;
					} else {
						this.btn_del.setDisabled(true);
						m_sfm_materi_id = '';
					}
					do_on_select_materi_central();
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
		
	this.btn_save = new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
		});
		
	this.btn_save1 = new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.dml_type = 'insert';
				this.do_save();
			}
		});
		
	this.btn_cancel = new Ext.Button({
			text		: 'Batal'
		,	iconCls		: 'del16'
		,	scope		: this
		,	handler		: function() {
				this.do_cancel();
				err_valid ='';
				this.form_pic_dinas.allowBlank = true;
			}
		});
		
	this.panel_add = new Ext.form.FormPanel({
		title		: 'Input Materi'
	,	labelAlign	: 'right'
	,	labelWidth	: 220
	,	autoWidth	: true
	,	autoHeight	: true
	,	bodyCssClass	: 'stop-panel-form'
	,	style		: 'margin: 8px;'
	,	tbar		: [
			this.btn_cancel
		,	'-'
		,	this.btn_save
		]
	,	items		: [
		this.form_id_rapat
		,	this.form_id_rapat_materi
		,{
                xtype: 'panel',
                layout: 'column',
                baseCls: 'x-plain',
                border:false,
                items:[
                    {columnWidth: 0.9, layout: 'form', baseCls: 'x-plain', labelWidth:80,
                                items: [this.form_isi_rapat_materi]
                    }
                ]
        }
		,{
                xtype: 'panel',
                layout: 'column',
                baseCls: 'x-plain',
                border:false,
                items:[
                    {columnWidth: 0.5, layout: 'form', baseCls: 'x-plain', labelWidth:80,
                                items: [
                                    this.form_batas_waktu
								,	this.cb_status_materi
                                    
                                ]
                    },      
                    {columnWidth: 0.5, layout: 'form', baseCls: 'x-plain', labelWidth:80,
                                items: [
                                    this.form_keterangan
									,	this.form_pic_seksi
									,	this.form_pic_dinas
                                ]
                    }
                ]
        }		
		]
		});

	this.panel = new Ext.grid.GridPanel({
			title		: 'Materi Rapat'
		,	region		: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	cm		: this.cm
		,	plugins		: [Ext.ux.grid.DataDrop]
		,	tbar		: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			,	'-'
			,	this.btn_save1
			]
		,	collapsible	: true
		,	width		: '100%'
		,	height		: 200
		,	autoResize	: true
		,	listeners	: {
				scope		: this
			,	rowdblclick	: function (g, r, e) {
					return this.do_edit(r);
				}
			}
		});

	this.do_add = function()
	{	if (do_validate_load()){
			m_sfm_central_materi_con.layout.setActiveItem(this.panel_add);
			
			this.form_id_rapat.setValue(m_sfm_rapat_id);
			this.form_id_rapat_materi.setValue('');
			this.form_isi_rapat_materi.setValue('');
			this.form_batas_waktu.setValue('');
			this.cb_status_materi.setValue('');
			this.form_keterangan.setValue('');
			this.form_pic_seksi.setValue('');
			this.form_pic_dinas.setValue('');

			
			this.dml_type = 'insert_one';
		}
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 'delete';
		this.do_save();
	}

	this.do_cancel = function()
	{
		m_sfm_central_materi_con.layout.setActiveItem(this.panel);
	}
	
	this.is_valid = function()
	{
			
		if (!this.form_isi_rapat_materi.isValid()) {
			err_valid = " [Pilihan Status Materi belum diisi] ";
			return false;
		}
		
		if (!this.form_batas_waktu.isValid()) {
			err_valid = " [Pilihan Status Materi belum diisi] ";
			return false;
		}
		
		if (!this.cb_status_materi.isValid()) {
			err_valid = " [Pilihan Status Materi belum diisi] ";
			return false;
		}

		if (this.form_pic_seksi.isValid()) {
			if (!this.form_pic_dinas.isValid()) {
				err_valid = " [Pilihan Supervisor belum diisi] ";
				return false;
			}
		}

		err_valid = '';
		this.form_pic_dinas.allowBlank = true;
		return true;
	}

	this.do_save = function()
	{
		if (!this.is_valid() && (this.dml_type == 'insert_one' || this.dml_type == 'update')) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!'+err_valid);
			return;
		}
		
		var data = "[";
		if (this.dml_type == 'insert'){
			var mods = this.store.getModifiedRecords();
			
			for (i = 0; i < mods.length; i++){
				if (i > 0) {
					data += ",";
				}
				
				data	+="{ id_rapat: '"+ m_sfm_rapat_id +"' "
						+ ", id_rapat_materi: '"+ mods[i].get('id_rapat_materi') +"' "
						+ ", isi_rapat_materi: '"+ mods[i].get('isi_rapat_materi') +"' "
						+ ", batas_waktu_materi: '"+ mods[i].get('batas_waktu_materi') +"' "
						+ ", status_materi: '"+ mods[i].get('status_materi') +"' "
						+ ", keterangan_materi: '"+ mods[i].get('keterangan_materi') +"' "
						+ ", nipg_pelaksana: '"+ mods[i].get('nipg_pelaksana') +"' "
						+ ", nipg_supervisor: '"+ mods[i].get('nipg_supervisor') +"' "
						+ ", seksi_pelaksana: '"+ mods[i].get('seksi_pelaksana') +"' "
						+ ", dinas_supervisor: '"+ mods[i].get('dinas_supervisor') +"' "
						+ " } ";
			}
		}else if(this.dml_type == 'insert_one'){
			data	+="{ id_rapat: '"+ m_sfm_rapat_id +"' "
						+ ", id_rapat_materi: '"+ this.form_id_rapat_materi.getValue() +"' "
						+ ", isi_rapat_materi: '"+ this.form_isi_rapat_materi.getValue() +"' "
						+ ", batas_waktu_materi: '"+ this.form_batas_waktu.getRawValue() +"' "
						+ ", status_materi: '"+ this.cb_status_materi.getValue() +"' "
						+ ", keterangan_materi: '"+ this.form_keterangan.getValue() +"' "
						+ ", nipg_pelaksana: '"+ this.pic_kasi +"' "
						+ ", nipg_supervisor: '"+ this.pic_kadin +"' "
						+ ", seksi_pelaksana: '"+ this.form_pic_seksi.getValue() +"' "
						+ ", dinas_supervisor: '"+ this.form_pic_dinas.getValue() +"' "
						+ " } ";
						this.dml_type = 'insert';
		}
		else if(this.dml_type == 'update'){
			data	+="{ id_rapat: '"+ m_sfm_rapat_id +"' "
						+ ", id_rapat_materi: '"+ this.form_id_rapat_materi.getValue() +"' "
						+ ", isi_rapat_materi: '"+ this.form_isi_rapat_materi.getValue() +"' "
						+ ", batas_waktu_materi: '"+ this.form_batas_waktu.getRawValue() +"' "
						+ ", status_materi: '"+ this.cb_status_materi.getValue() +"' "
						+ ", keterangan_materi: '"+ this.form_keterangan.getValue() +"' "
						+ ", nipg_pelaksana: '"+ this.pic_kasi +"' "
						+ ", nipg_supervisor: '"+ this.pic_kadin +"' "
						+ ", seksi_pelaksana: '"+ this.form_pic_seksi.getValue() +"' "
						+ ", dinas_supervisor: '"+ this.form_pic_dinas.getValue() +"' "
						+ " } ";
		}else {
			var record = this.sm.getSelections();
			if (!record.length) {
				return;
			}
			data	+="{ id_rapat: '"+ m_sfm_rapat_id +"' "
						+ ", id_rapat_materi: '"+ record[0].data['id_rapat_materi'] +"' "
						+ ", isi_rapat_materi: '"+ record[0].data['isi_rapat_materi'] +"' "
						+ ", batas_waktu_materi: '"+ record[0].data['batas_waktu_materi'] +"' "
						+ ", status_materi: '"+ record[0].data['status_materi'] +"' "
						+ ", keterangan_materi: '"+ record[0].data['keterangan_materi'] +"' "
						+ ", nipg_pelaksana: '"+ record[0].data['nipg_pelaksana'] +"' "
						+ ", nipg_supervisor:  '"+ record[0].data['nipg_supervisor'] +"' "
						+ ", seksi_pelaksana: '"+ record[0].data['seksi_pelaksana'] +"' "
						+ ", dinas_supervisor: '"+ record[0].data['dinas_supervisor'] +"' "
						+ " } ";
		}
		data +="]";
		
		Ext.Ajax.request({
			params  : {
					data : data
			,	dml_type		: this.dml_type
			}
		,	url	: m_sfm_central_d +'submit_materi_rapat.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
						
					}
					if (this.dml_type = 'update'){
							m_sfm_central_materi_con.layout.setActiveItem(this.panel);
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
			m_sfm_central_materi_con.layout.setActiveItem(this.panel_add);
			
			this.form_id_rapat.setValue(m_sfm_rapat_id);
			this.form_id_rapat_materi.setValue(data[0].data.id_rapat_materi);
			this.form_isi_rapat_materi.setValue(data[0].data.isi_rapat_materi);
			this.form_batas_waktu.setValue(data[0].data.batas_waktu_materi);
			this.cb_status_materi.setValue(data[0].data.status_materi);
			this.form_keterangan.setValue(data[0].data.keterangan);
			this.form_pic_seksi.setValue(data[0].data.seksi_pelaksana);
			this.form_pic_dinas.setValue(data[0].data.dinas_supervisor);
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
			m_sfm_central_submateri.store.removeAll();
			// m_sfm_central_submateri.modified = []; // not necessary if you have pruneModifiedRecords set to true
			m_sfm_central_submateri.store.removed = [];
		}
		
		store_pic_seksi.load();
		store_pic_dinas.load();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_SfmAbsenRapatCentral(){
	this.dml_type		= '';
	this.nipg_old		= '';
	this.nama_peserta	= '';
	this.nipg		= '';
	this.id_jabatan_komite	= '';
	var chg_hadir		= 0;
	var chg_absen		= 0;
	var cb_aktif = '';
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
		,	url	: m_sfm_central_d +'data_list_absensi_rapat.jsp'
		,	autoLoad: false
		});

	this.jabatan_komite_record = new Ext.data.Record.create([
		{name	: 'id'}
	,	{name	: 'nama'}
	]);

	this.store_jabatan_komite = new Ext.data.SimpleStore({
			url	: _g_root +'/module/ref_pegawai_komite/data_jabatan_komite_com.jsp'
		,	fields	: this.jabatan_komite_record
		,	autoLoad: false
		});

	this.form_id_rapat	= new Ext.form.TextField({allowBlank : false});
	this.form_nipg		= new Ext.form.TextField({allowBlank : true, disabled : true})
	this.form_nama_pegawai	= new Ext.form.TextField({
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

	this.ck_stat_absen = new Ext.form.Checkbox({
		boxLabel	: 'Hadir'
	});

	this.form_keterangan_absensi	= new Ext.form.TextField({allowBlank : true});
	this.form_jml_hadir		= new Ext.form.NumberField({allowBlank : true, value: 0});
	this.form_jml_absen		= new Ext.form.NumberField({allowBlank : true, value: 1});

	this.cb_pegawai_on_select = function(record)
	{
		this.nipg = record.get('nipg');
		this.id_jabatan_komite = record.get('id_jabatan_komite');
		
			this.form_nipg.setValue(this.nipg);
			this.cb_jabatan_komite.setValue(this.id_jabatan_komite);
	
	}

	this.store_peg = new Ext.data.ArrayStore({
			fields	: ['nipg','nama_pegawai','id_jabatan_komite']
		,	url	: m_sfm_central_d +'data_pegawai.jsp'
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
		,	editable	: true
		,  	typeAhead	:true
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.cb_pegawai_on_select(record);
				}
			}
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			header		: 'NIPG'
		,	dataIndex	: 'nipg'
		,	editor		: this.form_nipg
		},{
			id		: 'nama_pegawai'
		,	header		: 'Nama Pegawai'
		,	dataIndex	: 'nama_pegawai'
		,	editor		: this.cb_nama_pegawai
		,	renderer	: combo_renderer(this.cb_nama_pegawai)
		},{
			header		: 'Jabatan Komite'
		,	dataIndex	: 'id_jabatan_komite'
		,	editor		: this.cb_jabatan_komite
		,	renderer	: combo_renderer(this.cb_jabatan_komite)
		},{
			header		: 'Absensi'
		,	dataIndex	: 'status_absensi'
		,	editor		: this.ck_stat_absen
		,	renderer	: checkbox_renderer(this.ck_stat_absen)
		},{
			header		: 'Keterangan Absen'
		,	dataIndex	: 'keterangan_absensi'
		,	editor		: this.form_keterangan_absensi
		},{
			header		: 'Jumlah Hadir'
		,	dataIndex	: 'jml_hadir'
		//,	editor		: this.form_jml_hadir
		},{
			header		: 'Jumlah Absen'
		,	dataIndex	: 'jml_absen'
		//,	editor		: this.form_jml_absen
		}];

	this.cm = new Ext.grid.ColumnModel({
		columns	: this.columns
	,	defaults: {
			sortable	: true
		,	hideable	: false
		,	menuDisabled	: true
		}
	});

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

	this.panel = new Ext.grid.GridPanel({
			title		: 'Absensi Rapat'
		,	region		: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	cm		: this.cm
		,	height	: 300
	,	autoResize	: true
		,	autoExpandColumn: 'nama_pegawai'
		,	plugins		: this.editor
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

		if (this.dml_type == 'update'){
			if (aktif != cb_aktif){
				if (aktif == '1'){
					chg_hadir += 1;
					chg_absen -= 1;
				}else {
					chg_hadir -= 1;
					chg_absen += 1;
				}
			}
		}
		if (this.dml_type == 'insert'){
		
			this.nipg_old = '';
			this.nama_peserta = '';
			if (aktif == '1'){
				chg_hadir += 1;
				chg_absen -= 1;
			}
			
		}
		Ext.Ajax.request({
			params  : {
				id_rapat		: record.data['id_rapat']
			,	nipg			: record.data['nipg']
			,	nama_pegawai		: record.data['nama_pegawai']
			,	id_jabatan_komite	: record.data['id_jabatan_komite']
			,	status_absensi		: aktif
			,	keterangan_absensi	: record.data['keterangan_absensi']
			,	jml_hadir		: chg_hadir
			,	jml_absen		: chg_absen
			,	nipg_old		: this.nipg_old
			,	nama_peserta		: this.nama_peserta
			,	dml_type		: this.dml_type
			}
		,	url	: m_sfm_central_d +'submit_absensi_rapat.jsp'
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
		chg_hadir = parseInt(data.data.jml_hadir);
		chg_absen = parseInt(data.data.jml_absen);
		cb_aktif =  (data.data.status_absensi == true)? '1':'0';
		if (this.ha_level >= 3) {
			this.dml_type = 'update';
			return true;
		}
		return false;
	}

	this.do_load = function()
	{	if (do_validate_load()){
			this.store.load({
				params	: {
					id_rapat  : m_sfm_rapat_id
				,	tgl_rapat : m_sfm_rapat_tgl
				}
			,	callback	: function(){
					this.store_peg.load({
						callback : function(){
							this.store_jabatan_komite.load({
								params	: {
									id_kel : '0 or 1=1'
								}
							});
						}
						, scope : this
					});
				}
			,	scope		: this		
			});
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
	}

}

function M_SfmFormRapatCentral(){
	this.data_rapat	= '';
	this.dml_type	= 0;
	this.id_stop	= '';
	this.nipg	= '';

	this.record = new Ext.data.Record.create([
		{name	: 'id'}
	,	{name	: 'type_csc'}
	,	{name	: 'type_csc_name'}
	,	{name	: 'sfm_no'}
	,	{name	: 'title'}
	,	{name	: 'date'}
	,	{name	: 'place'}
	,	{name	: 'note_date'}
	,	{name	: 'note_writer'}
	]);

	this.store = new Ext.data.ArrayStore({
		fields	: this.record
	,	url	: m_sfm_central_d +'data_list_rapat_central.jsp'
	,	autoLoad: false
	});

	/* Data Rapat */
	this.form_id_rapat = new Ext.form.TextField({
			fieldLabel	: 'Id Rapat'
		,	disabled	: false
		, 	hidden		: true
		});

	this.form_no_rapat = new Ext.form.TextField({
			fieldLabel	: 'No. Rapat'
		,	disabled	: false
		,	allowBlank	: false
		,	width		: 150
		});

	this.form_judul_rapat = new Ext.form.TextField({
			fieldLabel	: 'Judul Rapat'
		,	disabled	: false
		,	allowBlank	: false
		,	width		: 200
		});

	this.form_tanggal_rapat = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Rapat'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 100
		});

	this.form_lokasi_rapat = new Ext.form.TextField({
			fieldLabel	: 'Lokasi Rapat'
		,	disabled	: false
		,	width		: 150
		});

	this.form_nama_notulis = new Ext.form.TextField({
			fieldLabel	: 'Nama Notulis'
		,	disabled	: false
		,	width		: 150
		});

	this.form_tanggal_notulen = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Notulen'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 100
		});

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
	
	/* observation data */
	this.panel = new Ext.form.FormPanel({
		title		: 'Central Safety Committee Meeting'
	,	labelAlign	: 'right'
	,	labelWidth	: 220
	,	autoWidth	: true
	,	autoHeight	: true
	,	bodyCssClass	: 'stop-panel-form'
	,	style		: 'margin: 8px;'
	,	tbar		: [
			this.btn_cancel
		,	'-'
		,	this.btn_save
		]
	,	items		: [
			this.form_no_rapat
		,	this.form_judul_rapat
		,	this.form_tanggal_rapat
		,	this.form_lokasi_rapat
		,	this.form_nama_notulis
		,	this.form_tanggal_notulen
		]
		});
	

	this.do_add = function()
	{	
		this.form_no_rapat.setValue('');
		this.form_judul_rapat.setValue('');
		this.form_tanggal_rapat.setValue('');
		this.form_lokasi_rapat.setValue('');
		this.form_nama_notulis.setValue('');
		this.form_tanggal_notulen.setValue('');

		this.dml_type = 'insert';
	}

	this.do_cancel = function()
	{	
		
		m_sfm_central_master_con.layout.setActiveItem(m_sfm_central_master.panel);
		m_sfm_central_master.do_load();
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id		: this.form_id_rapat.getValue()							// default  type_id for central safety committee meeting
			,	sfm_no 		: this.form_no_rapat.getValue()
			,	title 		: this.form_judul_rapat.getValue()
			,	date 		: this.form_tanggal_rapat.getValue()
			,	place 		: this.form_lokasi_rapat.getValue()
			,	note_date 	: this.form_tanggal_notulen.getValue()
			,	note_writer	: this.form_nama_notulis.getValue()
			,	dml_type	: this.dml_type
			}
		,	url	: m_sfm_central_d +'submit_rapat_central.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
						
						
					}
					
					m_sfm_central_master_con.layout.setActiveItem(m_sfm_central_master.panel);
					m_sfm_central_master.do_load();
					
				}
		,	scope	: this
		});
	}

	this.do_edit = function(record)
	{
		this.form_id_rapat.setValue(record[0].data.id);
		this.form_no_rapat.setValue(record[0].data.sfm_no);
		this.form_judul_rapat.setValue(record[0].data.title);
		this.form_tanggal_rapat.setValue(record[0].data.date);
		this.form_lokasi_rapat.setValue(record[0].data.place);
		this.form_nama_notulis.setValue(record[0].data.note_writer);
		this.form_tanggal_notulen.setValue(record[0].data.note_date);
		
		this.dml_type = 'update';
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				type : '1'
			}
		});
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

function M_SfmFormMasterRapatCentral(){
	this.data_rapat	= '';
	this.dml_type	= '';
	this.id_stop	= '';
	this.nipg	= '';

	this.record = new Ext.data.Record.create([
		{name	: 'id'}
	,	{name	: 'type'}
	,	{name	: 'type_name'}
	,	{name	: 'sfm_no'}
	,	{name	: 'title'}
	,	{name	: 'date'}
	,	{name	: 'place'}
	,	{name	: 'note_date'}
	,	{name	: 'note_writer'}
	]);

	this.store = new Ext.data.ArrayStore({
		fields	: this.record
	,	url	: m_sfm_central_d +'data_list_rapat_central.jsp'
	,	autoLoad: false
	});

	/* Data Rapat */
	this.form_id_rapat = new Ext.form.TextField({
			fieldLabel	: 'Id Rapat'
		,	disabled	: false
		,	editable	: false
		, 	hidden		: true
		});

	this.form_no_rapat = new Ext.form.TextField({
			fieldLabel	: 'No. Rapat'
		,	disabled	: false
		,	editable	: false
		,	allowBlank	: false
		,	width		: 150
		});

	this.form_judul_rapat = new Ext.form.TextField({
			fieldLabel	: 'Judul Rapat'
		,	disabled	: false
		,	editable	: false
		,	allowBlank	: false
		,	width		: 200
		});

	this.form_tanggal_rapat = new Ext.form.TextField({
			fieldLabel	: 'Tanggal Rapat'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 100
		});

	this.form_lokasi_rapat = new Ext.form.TextField({
			fieldLabel	: 'Lokasi Rapat'
		,	disabled	: false
		,	editable	: false
		,	width		: 150
		});

	this.form_nama_notulis = new Ext.form.TextField({
			fieldLabel	: 'Nama Notulis'
		,	disabled	: false
		,	editable	: false
		,	width		: 150
		});

	this.form_tanggal_notulen = new Ext.form.TextField({
			fieldLabel	: 'Tanggal Notulen'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 100
		});


	/* observation data */
	this.panel = new Ext.form.FormPanel({
		title		: 'Central Safety Committee Meeting'
	,	labelAlign	: 'right'
	,	autoWidth	: true
	,	autoHeight	: true
	,	style		: 'margin: 2px;'
	,	items		: [
		 this.form_no_rapat
										,	this.form_judul_rapat
										,	this.form_tanggal_rapat
					,this.form_lokasi_rapat
										,	this.form_nama_notulis
										,	this.form_tanggal_notulen
		]
		});
	
	this.do_assign = function()
	{	var record = m_sfm_central_master.panel.getSelectionModel().getSelections();
		this.form_id_rapat.setValue(record[0].data.id);
		this.form_no_rapat.setValue(record[0].data.sfm_no);
		this.form_judul_rapat.setValue(record[0].data.title);
		this.form_tanggal_rapat.setValue(record[0].data.date);
		this.form_lokasi_rapat.setValue(record[0].data.place);
		this.form_nama_notulis.setValue(record[0].data.note_writer);
		this.form_tanggal_notulen.setValue(record[0].data.note_date);
		
	}

}

function M_SfmInputRapatCentral(){
	this.data_rapat	= '';
	this.dml_type	= '';
	this.id_stop	= '';
	this.nipg	= '';

	this.record = new Ext.data.Record.create([
		{name	: 'id'}
	,	{name	: 'type_csc'}
	,	{name	: 'type_csc_name'}
	,	{name	: 'sfm_no'}
	,	{name	: 'title'}
	,	{name	: 'date'}
	,	{name	: 'place'}
	,	{name	: 'note_date'}
	,	{name	: 'note_writer'}
	]);

	this.store = new Ext.data.ArrayStore({
		fields	: this.record
	,	url	: m_sfm_central_d +'data_list_rapat_central.jsp'
	,	autoLoad: false
	});

	/* Data Rapat */
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
			header		: 'Tipe Rapat'
		,	dataIndex	: 'type_csc_name'
		,	width		: 100
		,	hidden		: true
		},{
			header		: 'Nomor Rapat'
		,	dataIndex	: 'sfm_no'
		,	width		: 90
		},{
			header		: 'Tanggal'
		,	dataIndex	: 'date'
		,	width		: 80
		,	align		: 'center'
		},{
			id		: 'title'
		,	header		: 'Judul Rapat'
		,	dataIndex	: 'title'
		,	width		: 180
		},{
			header		: 'Lokasi Rapat'
		,	dataIndex	: 'place'
		,	width		: 120
		},{
			header		: 'Notulis'
		,	dataIndex	: 'note_writer'
		,	width		: 150
		},{
			header		: 'Tanggal Notulen'
		,	dataIndex	: 'note_date'
		,	align		: 'center'
		,	width		: 100
		}];

	this.cm = new Ext.grid.ColumnModel({
		columns	: this.columns
	,	defaults: {
			sortable	: true
		,	hideable	: false
		,	menuDisabled	: true
		}
	});

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
						m_sfm_rapat_id = data[0].data.id;
						m_sfm_rapat_tgl = data[0].data.date;
						
							m_sfm_data_rapat_central.panel.getItem(1).setDisabled(false);
							m_sfm_data_rapat_central.panel.getItem(2).setDisabled(false);
						m_sfm_central_form_master.do_assign();
						m_sfm_central_form_materi.do_assign();
					} else {
						this.btn_del.setDisabled(true);
						m_sfm_rapat_id = '';
						m_sfm_rapat_tgl = '';
						
							m_sfm_data_rapat_central.panel.getItem(1).setDisabled(true);
							m_sfm_data_rapat_central.panel.getItem(2).setDisabled(true);
					}
					do_on_select_rapat_central();
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
		
	this.btn_edit = new Ext.Button({
			text	: 'Ubah'
		,	iconCls	: 'edit16'
		,	scope	: this
		,	handler	: function() {
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
			title		: 'Rapat Committee'
		,	region		: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	cm		: this.cm
		,	plugins		: this.editor
		,	tbar		: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			,	'-'
			,	this.btn_edit
			]
		,	autoExpandColumn: 'title'
		,	height		: 150 
		,       listeners       : {
				scope		: this
			,	rowdblclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
			}
		});

	this.do_add = function()
	{
		m_sfm_central_form.do_add();		
		m_sfm_central_master_con.layout.setActiveItem(m_sfm_central_form.panel);
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
				id		: record.data['id']
			,	id_kel_csc	: record.data['type_csc']
			,	sfm_no 		: record.data['sfm_no']
			,	title 		: record.data['title']
			,	date 		: record.data['date']
			,	place 		: record.data['place']
			,	note_date 	: record.data['note_date']
			,	note_writer	: record.data['note_writer']
			,	dml_type	: this.dml_type
			}
		,	url	: m_sfm_central_d +'submit_rapat_central.jsp'
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
		if (!data.length) {
			return;
		}
		
		if (this.ha_level >= 3) {
			this.dml_type = 'update';
			m_sfm_central_form.do_edit(data);
			m_sfm_central_master_con.layout.setActiveItem(m_sfm_central_form.panel);
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				type : this.ha_level
			}
		});
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

function M_SfmDataRapat(){
	m_sfm_central_master	= new M_SfmInputRapatCentral();
	m_sfm_central_absen	= new M_SfmAbsenRapatCentral()
	m_sfm_central_materi	= new M_SfmMateriRapatCentral();
	m_sfm_central_submateri	= new M_SfmSubMateriRapatCentral();
	m_sfm_central_form		= new M_SfmFormRapatCentral();
	m_sfm_central_form_materi = new M_SfmFormMasterRapatCentral();
	m_sfm_central_form_master		= new M_SfmFormMasterRapatCentral();

		
	m_sfm_central_master_con = new Ext.Container({
			region		: 'center'
		,	title		: 'Central Safety Committee Meeting'
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
		,	width		: '100%'
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			}
		,	items	: [
				m_sfm_central_master.panel
			,	m_sfm_central_form.panel
			]
	
	});
	
	m_sfm_central_materi_con = new Ext.Container({
			region		: 'center'
		,	title		: 'Materi Meeting'
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
		,	autoResize	: true
		,	width		: 930
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			}
		,	items	: [
				m_sfm_central_materi.panel
			,	m_sfm_central_materi.panel_add
			]
	
	});
	m_sfm_central_sub_materi_con = new Ext.Container({
			region		: 'center'
		,	title		: 'Materi Meeting'
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
		,	autoResize	: true
		,	width		: 930
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			}
		,	items	: [
				m_sfm_central_submateri.panel
			,	m_sfm_central_submateri.panel_add
			]
	
	});
	
	m_sfm_form_master_absen_con = new Ext.Panel({
        frame: true,
        labelAlign: 'left',
        title: 'Absensi Peserta Rapat',
        bodyStyle:'padding:5px',
        width: 930,
		height		: 500,
        layout: 'vbox',    // Specifies that the items will now be arranged in columns
			defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			},
        items: [m_sfm_central_form_master.panel,m_sfm_central_absen.panel]
		});
	this.materi_vbox = new 	Ext.Panel({
        frame: true,
        labelAlign: 'left',
        bodyStyle:'padding:5px',
        width: 1000,
		height		: 500,
       layout: 'vbox',    
			defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			},
        items: [	m_sfm_central_materi_con
			,	m_sfm_central_sub_materi_con]
		});
		
	m_sfm_form_master_materi_con = new Ext.Panel({
        frame: true,
        labelAlign: 'left',
        title: 'Materi Rapat',
        bodyStyle:'padding:5px',
        width: 930,
		height		: 500,
 //       layout: 'vbox',    
			defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			},
        items: [m_sfm_central_form_materi.panel
			,	this.materi_vbox]
		});
		
	this.panel = new Ext.TabPanel({
			id		: 'sfm_data_rapat_central_panel'
		,	autoScroll	: true
		,	enableTabScroll	: true
		,	region		: 'center'
		,	activeTab	: 0
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			}
		,	items			: [
				m_sfm_central_master_con
			 ,	m_sfm_form_master_absen_con
			,	m_sfm_form_master_materi_con
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_sfm_rapat_id	= '';
		m_sfm_materi_id	= '';

		m_sfm_central_master.do_refresh(ha_level);
		m_sfm_central_absen.do_refresh(ha_level);
		m_sfm_central_materi.do_refresh(ha_level);
		m_sfm_central_submateri.do_refresh(ha_level);
		this.panel.getItem(1).setDisabled(true);
		this.panel.getItem(2).setDisabled(true);
		this.panel.setActiveTab(0);
	}
}

m_sfm_data_rapat_central = new M_SfmDataRapat();
