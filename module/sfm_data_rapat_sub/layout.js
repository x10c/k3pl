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
var		m_sfm_data_materi_sub;
var		m_sfm_data_sub_materi_sub;
var		m_sfm_data_absen_sub;
var 	m_sfm_rapat_id = '';
var		m_sfm_rapat_tgl = '';
var		m_sfm_materi_id = '';
var m_sfm_data_rapat_sub;
var m_sfm_sub_d	= _g_root +'/module/sfm_data_rapat_sub/';
var m_sfm_data_rapat_sub_master;


var store_pic_seksi_sub = new Ext.data.ArrayStore({
		fields	: ['id_seksi','id_dinas','id_departemen','nama_seksi','kepala_seksi']
	,	url	: m_sfm_central_d +'data_ref_pic_seksi.jsp'
	,	autoLoad: false
	});

var store_pic_dinas_sub = new Ext.data.ArrayStore({
		fields	: ['id_dinas','id_departemen','nama_dinas','kepala_dinas']
	,	url	: m_sfm_central_d +'data_ref_pic_dinas.jsp'
	,	autoLoad: false
	});
	
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

function do_on_select_rapat_sub(){
	if (typeof m_sfm_data_materi_sub == 'undefined'
	||  typeof m_sfm_data_absen_sub == 'undefined'
	||  m_sfm_rapat_id == '') {
		return;
	}

	m_sfm_data_materi_sub.do_load();
	m_sfm_data_absen_sub.do_load();
}

function do_on_select_materi_sub(){
	if (  m_sfm_materi_id == ''
	||  m_sfm_rapat_id == '') {
		return;
	}

	m_sfm_data_sub_materi_sub.do_load();

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


function do_validate_materi_load(){
	if ( m_sfm_rapat_id == ''
	||  m_sfm_rapat_tgl == ''
	||  m_sfm_materi_id == '') {
		Ext.MessageBox.alert('Pesan', "Pilih data Rapat dan Materi Terlebih dahulu");
		return 0;
	}
	return 1;
}

function M_SfmSubMateriRapatSub (title){
	this.title = title;
	this.dml_type = '';
	this.ha_level = 0;
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
			url	: m_sfm_sub_d +'data_list_sub_materi_rapat.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		,	pruneModifiedRecords : true
		});
	
	this.form_id_rapat 		= new Ext.form.TextField({allowBlank : true, hidden : true});
	this.form_id_rapat_materi 	= new Ext.form.TextField({allowBlank : true, hidden : true});
	this.form_id_rapat_sub_materi 	= new Ext.form.TextField({allowBlank : true, hidden : true});
	this.form_isi_rapat_sub_materi 	= new Ext.form.TextField({fieldLabel	: 'Sub Materi',allowBlank : false, anchor: '98%'});
	// this.form_batas_waktu	= new Ext.form.TextField({allowBlank : true});
	this.form_batas_waktu	= new Ext.form.DateField({
			fieldLabel	: 'Batas Waktu'
		,	emptyText	: 'Y-m-d'
		,	format		: 'Y-m-d'
		,	editable	: false
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
		,	{ id		: 'id_rapat'
			, header	: 'Id Rapat'
			, dataIndex	: 'id_rapat'
			, sortable	: true
			, hidden	: true
			}
		,	{ id		: 'id_rapat_materi'
			, header	: 'Id Materi Rapat'
			, dataIndex	: 'id_rapat_materi'
			, sortable	: true
			, hidden	: true
			}
		,	{ id		: 'id_rapat_sub_materi'
			, header	: 'Id Materi Sub Rapat'
			, dataIndex	: 'id_rapat_sub_materi'
			, sortable	: true
			, hidden	: true
			}
		,	{ id		: 'isi_rapat_sub_materi'
			, header	: 'Sub Materi Rapat'
			, dataIndex	: 'isi_rapat_sub_materi'
			, width		: 150
			, sortable	: true
			}	
		,	{ id		: 'batas_waktu_sub_materi'
			, header	: 'Batas Waktu'
			, dataIndex	: 'batas_waktu_sub_materi'
			, sortable	: true
			}	
		,	{ id		: 'status_sub_materi'
			, header	: 'Status'
			, dataIndex	: 'status_sub_materi'
			, sortable	: true
			,	renderer	: combo_renderer(this.cb_status_sub_materi)
			}	
		,	{ id		: 'keterangan_sub_materi'
			, header	: 'Keterangan'
			, dataIndex	: 'keterangan_sub_materi'
			, width		: 150
			, sortable	: true
			}	
		,	{
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
		}	
		];
	
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
	,	style		: 'margin: 8px;'
	,	bodyCssClass	: 'stop-panel-form'
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
	{	if (do_validate_materi_load()){
			m_sfm_sub_sub_materi_con.layout.setActiveItem(this.panel_add);
			
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
		
		m_sfm_sub_sub_materi_con.layout.setActiveItem(this.panel);
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
						m_sfm_sub_sub_materi_con.layout.setActiveItem(this.panel);
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
			m_sfm_sub_sub_materi_con.layout.setActiveItem(this.panel_add);
			
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

		// this.do_load();
	}
}


function M_SfmMateriRapatSub (title){
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
			url	: _g_root +'/module/sfm_data_rapat_sub/data_list_materi_rapat.jsp'
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
		,	emptyText	: 'Y-m-d'
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
					if (data.length && this.ha_level == 4) {
						this.btn_del.setDisabled(false);
						m_sfm_materi_id = data[0].data.id_rapat_materi;
					} else {
						this.btn_del.setDisabled(true);
						m_sfm_materi_id = '';
					}
					do_on_select_materi_sub();
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
	,	style		: 'margin: 8px;'
	,	bodyCssClass	: 'stop-panel-form'
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
			m_sfm_sub_materi_con.layout.setActiveItem(this.panel_add);
			
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
		
		m_sfm_sub_materi_con.layout.setActiveItem(this.panel);
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
					this.dml_type ='insert';
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
		,	url	: _g_root +'/module/sfm_data_rapat_sub/submit_materi_rapat.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
						
					}
					if (this.dml_type = 'update'){
							m_sfm_sub_materi_con.layout.setActiveItem(this.panel);
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
			m_sfm_sub_materi_con.layout.setActiveItem(this.panel_add);
			
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
		m_sfm_data_sub_materi_sub.store.removeAll();
		// m_sfm_central_submateri.modified = []; // not necessary if you have pruneModifiedRecords set to true
		m_sfm_data_sub_materi_sub.store.removed = [];
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

function M_SfmAbsenRapatSub (title){
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
		,	url	: _g_root +'/module/sfm_data_rapat_sub/data_list_absensi_rapat.jsp'
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
		,	url	: _g_root +'/module/sfm_data_rapat_sub/data_pegawai.jsp'
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
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nama_pegawai'
		,	width		: '100%'
		,	height	: 300
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
		,	url	: _g_root +'/module/sfm_data_rapat_sub/submit_absensi_rapat.jsp'
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
 
 function M_SfmFormRapatSub()
{
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
	,	url	: m_sfm_sub_d +'data_list_rapat_central.jsp'
	,	autoLoad: false
	});
	
	this.store_type = new Ext.data.ArrayStore({
			fields	: ['id_kel_jabatan_komite_sub_komite','nama_kel_jabatan_komite_sub_komite']
		,	url	: m_sfm_sub_d +'data_kel_jabatan_komite.jsp'
		,	autoLoad: false
		});
		
	/* Data Rapat */
	this.form_id_rapat = new Ext.form.TextField({
			fieldLabel	: 'Id Rapat'
		,	disabled	: false
		, 	hidden		: true
		});
	
	this.form_type_rapat = new Ext.form.ComboBox({
			fieldLabel	: 'Tipe Rapat'
		,	store		: this.store_type
		,	valueField	: 'id_kel_jabatan_komite_sub_komite'
		,	displayField	: 'nama_kel_jabatan_komite_sub_komite'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 150
		,	listWidth	: 300
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
		title		: 'Sub Committee Meeting'
	,	labelAlign	: 'right'
	,	labelWidth	: 220
	,	autoWidth	: true
	,	autoHeight	: true
	,	style		: 'margin: 8px;'
	,	tbar		: [
			this.btn_cancel
		,	'-'
		,	this.btn_save
		]
	,	items		: [
			this.form_type_rapat
		,	this.form_no_rapat
		,	this.form_judul_rapat
		,	this.form_tanggal_rapat
		,	this.form_lokasi_rapat
		,	this.form_nama_notulis
		,	this.form_tanggal_notulen
		]
		});
	

	this.do_add = function()
	{	this.store_type.load();
	
		this.form_no_rapat.setValue('');
		this.form_type_rapat.setValue('');
		this.form_judul_rapat.setValue('');
		this.form_tanggal_rapat.setValue('');
		this.form_lokasi_rapat.setValue('');
		this.form_nama_notulis.setValue('');
		this.form_tanggal_notulen.setValue('');

		this.dml_type = 'insert';
	}

	this.do_cancel = function()
	{		
		m_sfm_sub_master_con.layout.setActiveItem(m_sfm_data_rapat_sub_master.panel);
		m_sfm_data_rapat_sub_master.do_load();
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id		: this.form_id_rapat.getValue()
			,	type		: this.form_type_rapat.getValue()				
			,	sfm_no 		: this.form_no_rapat.getValue()
			,	title 		: this.form_judul_rapat.getValue()
			,	date 		: this.form_tanggal_rapat.getValue()
			,	place 		: this.form_lokasi_rapat.getValue()
			,	note_date 	: this.form_tanggal_notulen.getValue()
			,	note_writer	: this.form_nama_notulis.getValue()
			,	dml_type	: this.dml_type
			}
		,	url	: m_sfm_sub_d +'submit_rapat_central.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
						
						
					}
					if (this.dml_type == 'insert'){
						this.do_add();
					}
					else{
						m_sfm_sub_master_con.layout.setActiveItem(m_sfm_data_rapat_sub_master.panel);
						m_sfm_data_rapat_sub_master.do_load();
					}
				}
		,	scope	: this
		});
	}

	this.do_edit = function(record)
	{	
		this.store_type.load();
		this.form_id_rapat.setValue(record[0].data.id);
		this.form_type_rapat.setValue(record[0].data.type); 	
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
		this.store.load();
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

function M_SfmFormMasterRapatSub()
{
	this.data_rapat	= '';
	this.dml_type	= '';

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
	,	url	: m_sfm_sub_d +'data_list_rapat_central.jsp'
	,	autoLoad: false
	});

	this.store_type = new Ext.data.ArrayStore({
		fields	: ['id_kel_jabatan_komite_sub_komite','nama_kel_jabatan_komite_sub_komite']
	,	url	: m_sfm_sub_d +'data_kel_jabatan_komite.jsp'
	,	autoLoad: false
	});
		
	/* Data Rapat */
	this.form_id_rapat = new Ext.form.TextField({
			fieldLabel	: 'Id Rapat'
		,	disabled	: false
		, 	hidden		: true
		});
	
	this.form_type_rapat = new Ext.form.ComboBox({
			fieldLabel	: 'Tipe Rapat'
		,	store		: this.store_type
		,	valueField	: 'id_kel_jabatan_komite_sub_komite'
		,	displayField	: 'nama_kel_jabatan_komite_sub_komite'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 150
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
	,	bodyCssClass	: 'stop-panel-form'
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
	{	var record = m_sfm_data_rapat_sub_master.panel.getSelectionModel().getSelections();
		this.form_id_rapat.setValue(record[0].data.id);
		this.form_type_rapat.setValue(record[0].data.type);
		this.form_no_rapat.setValue(record[0].data.sfm_no);
		this.form_judul_rapat.setValue(record[0].data.title);
		this.form_tanggal_rapat.setValue(record[0].data.date);
		this.form_lokasi_rapat.setValue(record[0].data.place);
		this.form_nama_notulis.setValue(record[0].data.note_writer);
		this.form_tanggal_notulen.setValue(record[0].data.note_date);
		
	}

}
 
 function M_SfmInputRapatSub (title){
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
		,	url	: _g_root +'/module/sfm_data_rapat_sub/data_list_rapat_sub.jsp'
		,	autoLoad: false
		});
	
	this.store_type = new Ext.data.ArrayStore({
			fields	: ['id_kel_jabatan_komite_sub_komite','nama_kel_jabatan_komite_sub_komite']
		,	url	: m_sfm_sub_d +'data_kel_jabatan_komite.jsp'
		,	autoLoad: false
		});
	
	this.form_type_rapat = new Ext.form.ComboBox({
			fieldLabel	: 'Tipe Rapat'
		,	store		: this.store_type
		,	valueField	: 'id_kel_jabatan_komite_sub_komite'
		,	displayField	: 'nama_kel_jabatan_komite_sub_komite'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	editable	: false
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
		},{
			id			: 'title'
		,	header		: 'Judul Rapat'
		,	dataIndex	: 'title'
		,	width		: 180
		},{
			id			: 'date'
		,	header		: 'Tanggal'
		,	dataIndex	: 'date'
		,	width		: 100
		},{
			id			: 'place'
		,	header		: 'Lokasi Rapat'
		,	dataIndex	: 'place'
		,	width		: 120
		},{
			id			: 'note_date'
		,	header		: 'Tanggal Notulen'
		,	dataIndex	: 'note_date'
		,	width		: 100
		},{
			id			: 'note_writer'
		,	header		: 'Notulis'
		,	dataIndex	: 'note_writer'
		,	width		: 150
		}];

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
						
							m_sfm_data_rapat_sub.panel.getItem(1).setDisabled(false);
							m_sfm_data_rapat_sub.panel.getItem(2).setDisabled(false);
						m_sfm_sub_form_master.do_assign();
						m_sfm_sub_form_materi.do_assign();
					} else {
						this.btn_del.setDisabled(true);
						m_sfm_rapat_id = '';
						m_sfm_rapat_tgl = '';
						
							m_sfm_data_rapat_sub.panel.getItem(1).setDisabled(true);
							m_sfm_data_rapat_sub.panel.getItem(2).setDisabled(true);
					}
					
					do_on_select_rapat_sub();
				}
			}
		});
	this.cm = new Ext.grid.ColumnModel({
		columns	: this.columns
	,	defaults: {
			sortable	: true
		,	hideable	: false
		,	menuDisabled	: true
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
			title		: 'Rapat Sub Committee'
		,	region		: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	cm		: this.cm
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
		});

	
	this.do_add = function()
	{
		m_sfm_sub_form.do_add();		
		m_sfm_sub_master_con.layout.setActiveItem(m_sfm_sub_form.panel);
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
		,	url	: _g_root +'/module/sfm_data_rapat_sub/submit_rapat_central.jsp'
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
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}
		
		if (this.ha_level >= 3) {
			this.dml_type = 'update';
			m_sfm_sub_form.do_edit(data);
			m_sfm_sub_master_con.layout.setActiveItem(m_sfm_sub_form.panel);
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
		this.ha_level = ha_level;

		if (ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
 }
 
 
 function M_SfmDataRapatSub (){
	m_sfm_data_rapat_sub_master = new M_SfmInputRapatSub('Rapat Komite');
	m_sfm_data_absen_sub = new M_SfmAbsenRapatSub('Absensi Peserta')
	m_sfm_data_materi_sub = new M_SfmMateriRapatSub('Materi Rapat');
	m_sfm_data_sub_materi_sub = new M_SfmSubMateriRapatSub('Sub Materi Rapat');
	
	m_sfm_sub_form		= new M_SfmFormRapatSub();
	m_sfm_sub_form_materi = new M_SfmFormMasterRapatSub();
	m_sfm_sub_form_master		= new M_SfmFormMasterRapatSub();
	
	m_sfm_sub_master_con = new Ext.Container({
			region		: 'center'
		,	title		: 'Safety Sub Committee Meeting'
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
				 m_sfm_data_rapat_sub_master.panel
			,	m_sfm_sub_form.panel
			]
	});
	
	m_sfm_sub_materi_con = new Ext.Container({
			region		: 'center'
		,	title		: 'Materi Meeting'
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
		,	autoResize	: true
		,	width		: 930
		,	height		: 300
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			}
		,	items	: [
				m_sfm_data_materi_sub.panel
			,	m_sfm_data_materi_sub.panel_add
			]
	
	});
	
	m_sfm_sub_sub_materi_con = new Ext.Container({
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
				m_sfm_data_sub_materi_sub.panel
			,	m_sfm_data_sub_materi_sub.panel_add
			]
	
	});
	
	m_sfm_form_master_absen_sub_con = new Ext.Panel({
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
        items: [m_sfm_sub_form_master.panel,m_sfm_data_absen_sub.panel]
		});
	
	this.det_materi = new Ext.Panel({
        frame: true,
        labelAlign: 'left',
        bodyStyle:'padding:5px',
        width: 930,
		height		: 600,
       layout: 'vbox',    
			defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
			}
		,	items	: [
				m_sfm_sub_materi_con
			,	m_sfm_sub_sub_materi_con]
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
        items: [m_sfm_sub_form_materi.panel
			,	this.det_materi]
		});
	
	this.panel = new Ext.TabPanel({
			id				: 'sfm_data_rapat_sub_panel'
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
				m_sfm_sub_master_con
			 ,	m_sfm_form_master_absen_sub_con
			,	m_sfm_form_master_materi_con
			]
	});
	
	this.do_refresh = function(ha_level)
	{
		m_sfm_rapat_id 	= '';
		m_sfm_materi_id 	= '';
		
		m_sfm_data_rapat_sub_master.do_refresh(ha_level);
		m_sfm_data_absen_sub.do_refresh(ha_level);
		m_sfm_data_materi_sub.do_refresh(ha_level);
		m_sfm_data_sub_materi_sub.do_refresh(ha_level);
		this.panel.getItem(1).setDisabled(true);
		this.panel.getItem(2).setDisabled(true);
	}
 }
 
 m_sfm_data_rapat_sub = new M_SfmDataRapatSub ();