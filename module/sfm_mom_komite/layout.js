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
		
		
var 	m_sfm_data_rapat_central;
var		m_sfm_data_materi_mom;
var		m_sfm_data_absen_mom;
var		ha_sfm_data_rapat = 0;
var 	m_sfm_rapat_id = '';
var		m_sfm_rapat_tgl = '';

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

function do_on_select_rapat_mom(){
	if (typeof m_sfm_data_rapat_central == 'undefined'
	||  typeof m_sfm_data_materi_mom == 'undefined'
	||  typeof m_sfm_data_absen_mom == 'undefined'
	||  m_sfm_rapat_id == '') {
		return;
	}

	m_sfm_data_materi_mom.do_load();
	m_sfm_data_absen_mom.do_load();

}

function M_SfmSubMateriRapatMom (title){
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
			url	: _g_root +'/module/sfm_mom_komite/data_list_sub_materi_rapat.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});
	
	this.store_peg = new Ext.data.ArrayStore({
			fields	: ['nipg','nama_pegawai']
		,	url	: _g_root +'/module/sfm_mom_komite/data_pegawai.jsp'
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
		});
	

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'south'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	collapsible	: true
		,	width		: '100%'
		,	autoResize  : true
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
					}
                        }
		});


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

		// this.do_load();
	}
}

function M_SfmMateriRapatMom (title){
	this.title = title;
	this.dml_type = '';
	this.ha_level = ha_sfm_data_rapat;
	
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
			url	: _g_root +'/module/sfm_mom_komite/data_list_materi_rapat.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});
	
	this.store_peg = new Ext.data.ArrayStore({
			fields	: ['nipg','nama_pegawai']
		,	url	: _g_root +'/module/sfm_mom_komite/data_pegawai.jsp'
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
			, sortable	: true
			, editor	: this.form_keterangan
			}	
		,	{ id		: 'nipg_pelaksana'
			, header	: 'Pelaksana'
			, dataIndex	: 'nipg_pelaksana'
			, sortable	: true
			, editor	: this.cb_pelaksana
			}	
		,	{ id		: 'nipg_supervisor'
			, header	: 'Supervisor'
			, dataIndex	: 'nipg_supervisor'
			, sortable	: true
			, editor	: this.cb_supervisor
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
	

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	collapsible	: true
		,	width		: '50%'
		,	height		: '100%'
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
					}
                        }
		});

	
	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_rapat : m_sfm_rapat_id
			}
		});
		this.store_peg.load();
	}

	this.do_refresh = function(ha_level)
	{	
		ha_sfm_data_rapat = ha_level;

	}
}

function M_SfmAbsenRapatMom (title){
	this.title	= title;
	this.dml_type	= '';
	this.ha_level	= ha_sfm_data_rapat;
	this.nipg_old = '';
	this.nama_peserta = '';

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
		,	url	: _g_root +'/module/sfm_mom_komite/data_list_absensi_rapat.jsp'
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
	
	this.form_nipg = new Ext.form.TextField({allowBlank : true})

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
		});

	this.ck_stat_absen = new Ext.form.Checkbox();
	
	this.form_keterangan_absensi = new Ext.form.TextField({allowBlank : true});
	
	this.form_jml_hadir = new Ext.form.NumberField({allowBlank : true});
	
	this.form_jml_absen = new Ext.form.NumberField({allowBlank : true});
	
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
			, editor	: this.form_nama_pegawai
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

				}
			}
		});


	this.panel = new Ext.grid.GridPanel({
			title		: this.title			
		,	region				: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	autoExpandColumn: 'nama_pegawai'
		,	width		: '100%'
		,	height		: '100%'
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
					}
                        }
		});

	this.do_load = function()
	{
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
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

	}

}
 
 function M_SfmInputRapatMom (title){
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
		,	url	: _g_root +'/module/sfm_mom_komite/data_list_rapat_central.jsp'
		,	autoLoad: false
		});

	
		
	/* Data Rapat */
	this.form_no_rapat = new Ext.form.TextField({
			fieldLabel	: 'No. Rapat'
		,	disabled	: false
		,	width		: 260
		});
	this.form_judul_rapat = new Ext.form.TextField({
			fieldLabel	: 'Judul Rapat'
		,	disabled	: false
		,	width		: 300
		});
	this.form_tanggal_rapat = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Rapat'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 260
		});
	this.form_lokasi_rapat = new Ext.form.TextField({
			fieldLabel	: 'Lokasi Rapat'
		,	disabled	: false
		,	width		: 260
		});
	this.form_nama_notulis = new Ext.form.TextField({
			fieldLabel	: 'Nama Notulis'
		,	disabled	: false
		,	width		: 260
		});
	this.form_tanggal_Notulen = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Notulen'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 260
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			id			: 'type_name'
		,	header		: 'Tipe Rapat'
		,	dataIndex	: 'type_name'
		,	hidden		: true
		},{
			id			: 'sfm_no'
		,	header		: 'Nomor Rapat'
		,	dataIndex	: 'sfm_no'
		,	editor		: this.form_no_rapat
		},{
			id			: 'title'
		,	header		: 'Judul Rapat'
		,	dataIndex	: 'title'
		,	width		: 160
		,	editor		: this.form_judul_rapat
		},{
			id			: 'date'
		,	header		: 'Tanggal'
		,	dataIndex	: 'date'
		,	width		: 120
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
		,	width		: 120
		,	editor		: this.form_tanggal_Notulen
		},{
			id			: 'note_writer'
		,	header		: 'Notulis'
		,	dataIndex	: 'note_writer'
		,	width		: 120
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
						m_sfm_rapat_id = data[0].data.id;
						m_sfm_rapat_tgl = data[0].data.date;
					} else {						
						this.btn_print.setDisabled(true);
						m_sfm_rapat_id = '';
						m_sfm_rapat_tgl = '';
					}
					do_on_select_rapat_mom();
				}
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

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region				: 'center'
		,	store		: this.store
		,	sm		: this.sm
		,	tbar 	:[this.btn_print]
		,	columns		: this.columns
		,	autoExpandColumn: 'title'
		,	width		: '100%'
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
					}
                        }
		});

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
		form.setAttribute('action', _g_root +'/module/sfm_mom_komite/data_rapat_export.jsp');
		
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
		this.store.load({
			params		: {
				type : '1'
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;


		this.do_load();
	}
 }
 
 
 function M_SfmDataRapatMom (){
	m_sfm_data_rapat_central_mom_master = new M_SfmInputRapatMom('Rapat Komite');
	// m_sfm_data_absen_mom = new M_SfmAbsenRapatMom('Absensi Peserta')
	// m_sfm_data_materi_mom = new M_SfmMateriRapatMom('Materi Rapat');
	// m_sfm_data_sub_materi_mom = new M_SfmSubMateriRapatMom('Sub Materi Rapat');
	
	// this.det_materi = new Ext.Panel({
			// region		: 'south'
		// ,	title		: 'Materi'
		// ,	layout		: 'vbox'
		// ,	width		: '100%'
		// ,	defaults	: {
				// loadMask	: {msg: 'Pemuatan...'}
			// ,	split		: true
			// ,	autoScroll	: true
			// ,	animCollapse	: true
    			// }
		// ,	items	: [
				// m_sfm_data_materi_mom.panel
			// ,	m_sfm_data_sub_materi_mom.panel
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
					// m_sfm_data_absen_mom.panel
				// ,	this.det_materi
			// ]
    // });

	this.panel = new Ext.Panel({
			id				: 'sfm_mom_komite_panel'
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_sfm_data_rapat_central_mom_master.panel
			// ,	this.grid_detail
			]
	});
	this.do_refresh = function(ha_level)
	{
		m_sfm_rapat_id 	= '';

		m_sfm_data_rapat_central_mom_master.do_refresh(ha_level);
		// m_sfm_data_absen_mom.do_refresh(ha_level);
		// m_sfm_data_materi_mom.do_refresh(ha_level);
	}
 }
 
 m_sfm_mom_komite = new M_SfmDataRapatMom ();