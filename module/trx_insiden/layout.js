/**
 * Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *	 - agus sugianto (agus.delonge@gmail.com)
 */

var m_trx_insiden;
var m_trx_insiden_master;
var m_trx_insiden_master_add;
var m_trx_insiden_detail;
var m_trx_insiden_id_insiden	= '';
var m_trx_insiden_ha_level		= 0;
var m_trx_insiden_d				= _g_root +'/module/trx_insiden/';
var m_ref_klas_pegawai_d		= _g_root +'/module/ref_klas_pegawai/';

function insiden_master_on_select_load_detail()
{
	if (typeof m_trx_insiden_master == 'undefined'
	||  typeof m_trx_insiden_detail == 'undefined'
	||  m_trx_insiden_id_insiden == '') {
		return;
	}

	m_trx_insiden_detail.do_refresh();
}

function M_TrxInsidenMasterAdd(title)
{
	this.title 			= title;
	this.dml_type		= 0;

	this.store_area = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_trx_insiden_d +'data_area.jsp'
		,	autoLoad	: false
	});

	this.store_klas = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	url		: m_ref_klas_pegawai_d +'data.jsp'
		,	autoLoad: false
	});

	this.form_no_insiden = new Ext.form.TextField({
			fieldLabel		: 'Nomor Insiden'
		,	width			: 200
	});

	this.form_area = new Ext.form.ComboBox({
			fieldLabel		: 'Lokasi Insiden'
		,	store			: this.store_area
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	editable		: false
		,	mode			: 'local'
		,	triggerAction	: 'all'
		,	width			: 400
	});

	this.form_klas = new Ext.form.ComboBox({
			fieldLabel		: 'Klasifikasi Pegawai'
		,	store			: this.store_klas
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	editable		: false
		,	mode			: 'local'
		,	triggerAction	: 'all'
		,	width			: 100
	});

	this.form_tanggal = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Insiden'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	editable		: false
		,	width			: 150
	});

	this.form_waktu = new Ext.form.TextField({
			fieldLabel		: 'Waktu Insiden'
		,	width			: 100
	});
	
	this.form_bagian_fungsi = new Ext.form.TextField({
			fieldLabel		: 'Bagian/Fungsi'
		,	width			: 300
	});
	
	this.form_dikeluarkan = new Ext.form.TextField({
			fieldLabel		: 'Dikeluarkan'
		,	width			: 300
	});

	this.form_pekerjaan_dilakukan = new Ext.form.TextArea({
			fieldLabel		: 'Pekerjaan yang sedang dilakukan ketika Insiden terjadi'
		,	width			: 400
		,	height			: 75
	});
	
	this.form_uraian = new Ext.form.TextArea({
			fieldLabel		: 'Uraian Peristiwa Insiden'
		,	width			: 400
		,	height			: 75
	});
	
	this.form_tindakan_dilakukan = new Ext.form.TextArea({
			fieldLabel		: 'Tindakan segera yang sudah dilakukan'
		,	width			: 400
		,	height			: 75
	});
	
	this.form_ringkasan_insiden = new Ext.form.TextArea({
			fieldLabel		: 'Ringkasan Insiden'
		,	width			: 400
		,	height			: 75
	});
	
	this.form_temuan_investigasi = new Ext.form.TextArea({
			fieldLabel		: 'Temuan-Temuan Investigasi'
		,	width			: 400
		,	height			: 75
	});
	
	this.form_akar_masalah = new Ext.form.TextArea({
			fieldLabel		: 'Akar Masalah'
		,	width			: 400
		,	height			: 57
	});
	
	this.form_sistem_perlu_diperkuat = new Ext.form.TextArea({
			fieldLabel		: 'Sistem yang perlu diperkuat'
		,	width			: 400
		,	height			: 75
	});
	
	this.set_data_insiden = {
			xtype			: 'fieldset'
		,	labelWidth		: 220
		,	items			: [
					this.form_no_insiden
				,	this.form_area
				,	this.form_klas
				,	this.form_tanggal
				,	this.form_waktu
				,	this.form_bagian_fungsi
				,	this.form_dikeluarkan
				,	this.form_pekerjaan_dilakukan
				,	this.form_uraian
				,	this.form_tindakan_dilakukan
				,	this.form_ringkasan_insiden
				,	this.form_temuan_investigasi
				,	this.form_akar_masalah
				,	this.form_sistem_perlu_diperkuat
			]
	}

	this.form_jml_korban_mati = new Ext.form.NumberField({
			fieldLabel		: 'Kematian'
	});

	this.form_jml_korban_berat = new Ext.form.NumberField({
			fieldLabel		: 'Kecelakaan Berat (cacat permanen)'
	});

	this.form_jml_korban_sedang = new Ext.form.NumberField({
			fieldLabel		: 'Kecelakaan Sedang'
	});

	this.form_jml_hari_kerja_hilang = new Ext.form.NumberField({
			fieldLabel		: 'Hari Kerja Hilang'
	});

	this.form_jml_korban_dampak = new Ext.form.NumberField({
			fieldLabel		: 'Jumlah Kejadian Dampak Akibat Kecelakaan'
	});

	this.form_jml_korban_medis = new Ext.form.NumberField({
			fieldLabel		: 'Jumlah Pengobatan Medis'
	});

	this.form_jml_korban_p3k = new Ext.form.NumberField({
			fieldLabel		: 'P3K'
	});

	this.form_jml_hampir_celaka = new Ext.form.NumberField({
			fieldLabel		: 'Hampir Celaka'
	});

	this.form_bakar_ledak_bocor = new Ext.form.NumberField({
			fieldLabel		: 'Kebakaran / Ledakan / Kebocoran'
	});

	this.set_kecelakaan = {
			xtype			: 'fieldset'
		,	labelWidth		: 300
		,	title			: 'Kecelakaan'
		,	autoHeight		: true
		,	defaults		: {
					allowDecimals	: false
				,	allowNegative	: false
				,	allowBlank		: false
				,	msgTarget		: 'side'
				,	value			: 0
				,	minValue		: 0
				,	width			: 50
			}
		,	items			: [
					this.form_jml_korban_mati
				,	this.form_jml_korban_berat
				,	this.form_jml_korban_sedang
				,	this.form_jml_hari_kerja_hilang
				,	this.form_jml_korban_dampak
				,	this.form_jml_korban_medis
				,	this.form_jml_korban_p3k
				,	this.form_jml_hampir_celaka
				,	this.form_bakar_ledak_bocor
			]
	};
	
	this.form_jml_rusak_jaringan = new Ext.form.NumberField({
			fieldLabel		: 'Kerusakan Jaringan'
	});

	this.form_jml_rusak_bangunan = new Ext.form.NumberField({
			fieldLabel		: 'Kerusakan Bangunan'
	});

	this.form_jml_rusak_kendaraan = new Ext.form.NumberField({
			fieldLabel		: 'Kerusakan Kendaraan'
	});

	this.form_jml_rusak_lain = new Ext.form.NumberField({
			fieldLabel		: 'Kerusakan Lainnya'
	});

	this.form_nilai_jaringan = new Ext.form.NumberField({
			fieldLabel		: 'Nilai (Rp)'
	});

	this.form_nilai_bangunan = new Ext.form.NumberField({
			fieldLabel		: 'Nilai (Rp)'
	});

	this.form_nilai_kendaraan = new Ext.form.NumberField({
			fieldLabel		: 'Nilai (Rp)'
	});

	this.form_nilai_lain = new Ext.form.NumberField({
			fieldLabel		: 'Nilai (Rp)'
	});

	this.set_kerusakan = {
			xtype			: 'fieldset'
		,	title			: 'Kerusakan'
		,	autoHeight		: true
		,	layout			: 'column'
		,	labelWidth		: 180
		,	items			: [
				{
						columnWidth		: .4
					,	layout			: 'form'
					,	border			: false
					,	bodyCssClass	: 'stop-panel-form'
					,	defaults		: {
								allowDecimals	: false
							,	allowNegative	: false
							,	allowBlank		: false
							,	msgTarget		: 'side'
							,	value			: 0
							,	minValue		: 0
							,	width			: 50
						}
					,	items			: [
								this.form_jml_rusak_jaringan
							,	this.form_jml_rusak_bangunan
							,	this.form_jml_rusak_kendaraan
							,	this.form_jml_rusak_lain
						]
				}
			,	{
						columnWidth		: .6
					,	layout			: 'form'
					,	border			: false
					,	bodyCssClass	: 'stop-panel-form'
					,	defaults		: {
								allowNegative	: false
							,	msgTarget		: 'side'
							,	allowBlank		: false
							,	value			: 0
							,	minValue		: 0
							,	width			: 180
							,	format			: '000,000,000,000.00'
						}
					,	items			: [
								this.form_nilai_jaringan
							,	this.form_nilai_bangunan
							,	this.form_nilai_kendaraan
							,	this.form_nilai_lain
						]
				}
			]
	};

	this.form_jml_pencemaran_lingkungan = new Ext.form.NumberField({
			fieldLabel		: 'Pencemaran Lingkungan'
	});

	this.form_jml_kecelakaan_kendaraan = new Ext.form.NumberField({
			fieldLabel		: 'Kecelakaan Kendaraan'
	});

	this.form_jml_kejadian_keamanan = new Ext.form.NumberField({
			fieldLabel		: 'Kejadian Keamanan'
	});

	this.set_misc = {
			xtype			: 'fieldset'
		,	title			: 'Lainnya'
		,	flex			: 1
		,	labelWidth		: 180
		,	autoHeight		: true
		,	defaults		: {
					allowDecimals	: false
				,	allowNegative	: false
				,	allowBlank		: false
				,	msgTarget		: 'side'
				,	value			: 0
				,	minValue		: 0
				,	width			: 50
			}
		,	items			: [
					this.form_jml_pencemaran_lingkungan
				,	this.form_jml_kecelakaan_kendaraan
				,	this.form_jml_kejadian_keamanan
			]
	}
	
	this.set_kecelakaan_misc = {
			xtype		: 'container'
		,	items		: [
					this.set_kecelakaan
				,	this.set_misc
			]
	};

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

	this.panel = new Ext.form.FormPanel({
			title		: 'Input Data Insiden'
		,	autoScroll	: true
		,	autoWidth	: true
		,	labelAlign	: 'right'
		,	bodyCssClass	: 'stop-panel-form'
		,	tbar		: [
				this.btn_cancel
			,	'->'
			,	this.btn_save
			]
		,	items			: [
				this.set_data_insiden
			,	this.set_kecelakaan_misc
			,	this.set_kerusakan
			]
	});

	this.panel = new Ext.form.FormPanel({
			title			: this.title
		,	autoScroll		: true
		,	autoWidth		: true
		,	labelAlign		: 'right'
		,	buttonAlign		: 'center'
		,	bodyCssClass	: 'stop-panel-form'
		,	tbar			: [
					this.btn_cancel
				,	'->'
				,	this.btn_save
			]
		,	items			: [
					this.set_data_insiden
				,	this.set_kecelakaan_misc
				,	this.set_kerusakan
			]
	});

	this.do_load_area = function()
	{
		this.store_area.load({
				callback	: function() {
					var record = this.store_area.getAt(0);

					if (record) {
						this.form_area.setValue(record.get('id'));
					}
				}
			,	scope		: this
		});
	}

	this.do_load_klas = function()
	{
		this.store_klas.load({
				callback	: function() {
					var record = this.store_klas.getAt(0);

					if (record) {
						this.form_klas.setValue(record.get('id'));
					}
				}
			,	scope		: this
		});
	}
	
	this.is_valid = function()
	{
		if (!this.form_tanggal.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_trx_insiden.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				url			: m_trx_insiden_d +'submit.jsp'
			,	waitMsg		: 'Mohon Tunggu ...'
			,	params		: {
						dml_type					: this.dml_type
					,	id_insiden					: m_trx_insiden_id_insiden
					,	id_area_seksi				: this.form_area.getValue()
					,	id_klas						: this.form_klas.getValue()
					,	tanggal						: this.form_tanggal.getValue()
					,	uraian						: this.form_uraian.getValue()
					,	jml_korban_mati				: this.form_jml_korban_mati.getValue()
					,	jml_korban_berat			: this.form_jml_korban_berat.getValue()
					,	jml_korban_sedang			: this.form_jml_korban_sedang.getValue()
					,	jml_hari_kerja_hilang		: this.form_jml_hari_kerja_hilang.getValue()
					,	jml_korban_dampak			: this.form_jml_korban_dampak.getValue()
					,	jml_korban_medis			: this.form_jml_korban_medis.getValue()
					,	jml_korban_p3k				: this.form_jml_korban_p3k.getValue()
					,	jml_hampir_celaka			: this.form_jml_hampir_celaka.getValue()
					,	jml_bakar_ledak_bocor		: this.form_bakar_ledak_bocor.getValue()
					,	jml_rusak_jaringan			: this.form_jml_rusak_jaringan.getValue()
					,	jml_rusak_bangunan			: this.form_jml_rusak_bangunan.getValue()
					,	jml_rusak_kendaraan			: this.form_jml_rusak_kendaraan.getValue()
					,	jml_rusak_lain				: this.form_jml_rusak_lain.getValue()
					,	nilai_rusak_jaringan		: this.form_nilai_jaringan.getValue()
					,	nilai_rusak_bangunan		: this.form_nilai_bangunan.getValue()
					,	nilai_rusak_kendaraan		: this.form_nilai_kendaraan.getValue()
					,	nilai_rusak_lain			: this.form_nilai_lain.getValue()
					,	jml_pencemaran_lingkungan	: this.form_jml_pencemaran_lingkungan.getValue()
					,	jml_kecelakaan_kendaraan	: this.form_jml_kecelakaan_kendaraan.getValue()
					,	jml_kejadian_keamanan		: this.form_jml_kejadian_keamanan.getValue()
					,	no_insiden					: this.form_no_insiden.getValue()
					,	waktu						: this.form_waktu.getValue()
					,	bagian_fungsi				: this.form_bagian_fungsi.getValue()
					,	pekerjaan_dilakukan			: this.form_pekerjaan_dilakukan.getValue()
					,	tindakan_dilakukan			: this.form_tindakan_dilakukan.getValue()
					,	dikeluarkan					: this.form_dikeluarkan.getValue()
					,	ringkasan_insiden			: this.form_ringkasan_insiden.getValue()
					,	temuan_investigasi			: this.form_temuan_investigasi.getValue()
					,	akar_masalah				: this.form_akar_masalah.getValue()
					,	sistem_perlu_diperkuat		: this.form_sistem_perlu_diperkuat.getValue()
				}
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

					m_trx_insiden_master.store.reload();
					m_trx_insiden.panel.layout.setActiveItem(0);
				}
			,	scope	: this
		});
	}
		
	this.do_reset = function()
	{
		var record = this.store_area.getAt(0);

		if (record) {
			this.form_area.setValue(record.get('id'));
		}

		record = this.store_klas.getAt(0);
		if (record) {
			this.form_klas.setValue(record.get('id'));
		}

		this.form_no_insiden.setValue('');
		this.form_waktu.setValue('');
		this.form_bagian_fungsi.setValue('');
		this.form_pekerjaan_dilakukan.setValue('');
		this.form_tindakan_dilakukan.setValue('');
		this.form_dikeluarkan.setValue('');
		this.form_ringkasan_insiden.setValue('');
		this.form_temuan_investigasi.setValue('');
		this.form_akar_masalah.setValue('');
		this.form_sistem_perlu_diperkuat.setValue('');
		this.form_tanggal.setValue('');
		this.form_uraian.setValue('');

		this.form_jml_korban_mati.setValue(0);
		this.form_jml_korban_berat.setValue(0);
		this.form_jml_korban_sedang.setValue(0);
		this.form_jml_hari_kerja_hilang.setValue(0);
		this.form_jml_korban_dampak.setValue(0);
		this.form_jml_korban_medis.setValue(0);
		this.form_jml_korban_p3k.setValue(0);
		this.form_jml_hampir_celaka.setValue(0);
		this.form_bakar_ledak_bocor.setValue(0);

		this.form_jml_rusak_jaringan.setValue(0);
		this.form_jml_rusak_bangunan.setValue(0);
		this.form_jml_rusak_kendaraan.setValue(0);
		this.form_jml_rusak_lain.setValue(0);

		this.form_nilai_jaringan.setValue(0);
		this.form_nilai_bangunan.setValue(0);
		this.form_nilai_kendaraan.setValue(0);
		this.form_nilai_lain.setValue(0);

		this.form_jml_pencemaran_lingkungan.setValue(0);
		this.form_jml_kecelakaan_kendaraan.setValue(0);
		this.form_jml_kejadian_keamanan.setValue(0);
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.edit_fill_form = function(data)
	{
		this.form_area.setValue(data.id_area_seksi);
		this.form_klas.setValue(data.id_klasifikasi_pegawai);
		this.form_tanggal.setValue(data.tanggal);
		this.form_uraian.setValue(data.uraian);

		this.form_jml_korban_mati.setValue(data.jml_korban_mati);
		this.form_jml_korban_berat.setValue(data.jml_korban_berat);
		this.form_jml_korban_sedang.setValue(data.jml_korban_sedang);
		this.form_jml_hari_kerja_hilang.setValue(data.jml_hari_kerja_hilang);
		this.form_jml_korban_dampak.setValue(data.jml_korban_dampak);
		this.form_jml_korban_medis.setValue(data.jml_korban_medis);
		this.form_jml_korban_p3k.setValue(data.jml_korban_p3k);
		this.form_jml_hampir_celaka.setValue(data.jml_hampir_celaka);
		this.form_bakar_ledak_bocor.setValue(data.jml_bakar_ledak_bocor);

		this.form_jml_rusak_jaringan.setValue(data.jml_rusak_jaringan);
		this.form_jml_rusak_bangunan.setValue(data.jml_rusak_bangunan);
		this.form_jml_rusak_kendaraan.setValue(data.jml_rusak_kendaraan);
		this.form_jml_rusak_lain.setValue(data.jml_rusak_lain);

		this.form_nilai_jaringan.setValue(data.nilai_rusak_jaringan);
		this.form_nilai_bangunan.setValue(data.nilai_rusak_bangunan);
		this.form_nilai_kendaraan.setValue(data.nilai_rusak_kendaraan);
		this.form_nilai_lain.setValue(data.nilai_rusak_lain);

		this.form_jml_pencemaran_lingkungan.setValue(data.jml_pencemaran_lingkungan);
		this.form_jml_kecelakaan_kendaraan.setValue(data.jml_kecelakaan_kendaraan);
		this.form_jml_kejadian_keamanan.setValue(data.jml_kejadian_keamanan);
		
		this.form_no_insiden.setValue(data.no_insiden);
		this.form_waktu.setValue(data.waktu);
		this.form_bagian_fungsi.setValue(data.bagian_fungsi);
		this.form_pekerjaan_dilakukan.setValue(data.pekerjaan_dilakukan);
		this.form_tindakan_dilakukan.setValue(data.tindakan_dilakukan);
		this.form_dikeluarkan.setValue(data.dikeluarkan);
		this.form_ringkasan_insiden.setValue(data.ringkasan_insiden);
		this.form_temuan_investigasi.setValue(data.temuan_investigasi);
		this.form_akar_masalah.setValue(data.akar_masalah);
		this.form_sistem_perlu_diperkuat.setValue(data.sistem_perlu_diperkuat);
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_trx_insiden_d +'data_insiden.jsp'
		,	params	: {
				id	: id
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

	this.do_refresh = function()
	{
		if (m_trx_insiden_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input data Insiden!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}
		
		this.do_load_area();
		this.do_load_klas();
	}
}

function M_TrxInsidenMaster(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_insiden'
		},{
			name	: 'tanggal'
		},{
			name	: 'nama_area'
		},{
			name	: 'nama_klasifikasi_pegawai'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/trx_insiden/data_list_insiden.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ 
				header		: 'Tanggal Insiden'
			, 	dataIndex	: 'tanggal'
			,	width		: 120
			,	align		: 'center'
			}
		,	{ 
				id			: 'nama_area'
			, 	header		: 'Lokasi Insiden'
			, 	dataIndex	: 'nama_area'
			}
		,	{ 
				header		: 'Klasifikasi'
			, 	dataIndex	: 'nama_klasifikasi_pegawai'
			, 	width		: 200
			,	align		: 'center'
			}
		]
	,	defaults	: {
		 	sortable	: true
		,	hideable	: false
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_trx_insiden_id_insiden = data[0].data['id_insiden'];
						this.btn_print.setDisabled(false);
					} else {
						m_trx_insiden_id_insiden = '';
						this.btn_print.setDisabled(true);
					}

					insiden_master_on_select_load_detail();
				}
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

	this.btn_print = new Ext.Button({
			text		: ' Print'
		,	iconCls		: 'print16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_print();
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
		,	this.btn_print
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
		,	autoExpandColumn	: 'nama_area'
		,	tbar				: this.toolbar
	});

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_trx_insiden_master_add.do_refresh();
		m_trx_insiden_master_add.do_edit(data.get('id_insiden'));
		m_trx_insiden.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		m_trx_insiden_master_add.do_refresh();
		m_trx_insiden_master_add.do_add();
		m_trx_insiden.panel.layout.setActiveItem(1);
	}

	this.do_print = function(){
		var form;
		var id_report	= '33';
		var tipe_report	= 'doc';

		form = document.createElement('form');
		
		form.setAttribute('method', 'post');
		form.setAttribute('target', '_blank');		
		form.setAttribute('action', _g_root +'/report');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'id');
        hiddenField1.setAttribute('value', id_report);
		
		var hiddenField2 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField2.setAttribute('name', 'type');
        hiddenField2.setAttribute('value', tipe_report);

		var hiddenField3 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField3.setAttribute('name', 'id_insiden');
        hiddenField3.setAttribute('value', m_trx_insiden_id_insiden);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
		document.body.appendChild(form);
		form.submit();
	}

	this.do_load = function()
	{
		var load_type = 'user';
		
		if (m_trx_insiden_ha_level == 4) {
			load_type = 'all';
		}

		delete this.store.lastParams;
		
		this.store.load({
			params	: {
				load_type : load_type
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_trx_insiden_ha_level <= 1) {
			this.btn_edit.setDisabled(true);
			this.btn_add.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
			this.btn_add.setDisabled(false);
		}

		this.do_load();
	}
}

function M_TrxInsidenDetail(title)
{
	this.title	= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_insiden'
		},{
			name	: 'id_insiden_rekomendasi'
		},{
			name	: 'rekomendasi'
		},{
			name	: 'penanggung_jawab'
		},{
			name	: 'tanggal_selesai'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: _g_root +'/module/trx_insiden/data_rekomendasi_insiden.jsp'
		,	autoLoad	: false
	});

	this.form_rekomendasi = new Ext.form.TextField({
			allowBlank	: false
	});
		
	this.form_penanggung_jawab = new Ext.form.TextField({
			allowBlank	: false
	});

	this.form_tanggal_selesai = new Ext.form.DateField({
			emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	editable		: false
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'rekomendasi'
			, header	: 'Rekomendasi'
			, dataIndex	: 'rekomendasi'
			, sortable	: true
			, editor	: this.form_rekomendasi
			}
		,	{ header	: 'Penanggung Jawab'
			, dataIndex	: 'penanggung_jawab'
			, sortable	: true
			, width		: 250
			, editor	: this.form_penanggung_jawab
			}
		,	{ header	: 'Tanggal Selesai'
			, dataIndex	: 'tanggal_selesai'
			, sortable	: true
			, width		: 150
			, align		: 'center'
			, editor	: this.form_tanggal_selesai
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_trx_insiden_ha_level == 4) {
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
		,	autoExpandColumn	: 'rekomendasi'
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
		if (m_trx_insiden_id_insiden == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu Data Insiden terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_insiden 				: m_trx_insiden_id_insiden
			,	id_insiden_rekomendasi	: ''
			,	rekomendasi				: ''
			,	penanggung_jawab		: ''
			,	tanggal_selesai			: ''
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
				id_insiden				: record.data['id_insiden']
			,	id_insiden_rekomendasi	: record.data['id_insiden_rekomendasi']
			,	rekomendasi				: record.data['rekomendasi']
			,	penanggung_jawab		: record.data['penanggung_jawab']
			,	tanggal_selesai			: record.data['tanggal_selesai']
			,   dml_type				: this.dml_type
			}
		,	url		: _g_root +'/module/trx_insiden/submit_rekomendasi_insiden.jsp'
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
		if (m_trx_insiden_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_insiden	: m_trx_insiden_id_insiden
			}
		});
	}

	this.do_refresh = function()
	{	
		if (m_trx_insiden_ha_level <= 1) {
			this.btn_del.setDisabled(true);
			this.btn_add.setDisabled(true);
		} else {
			this.btn_del.setDisabled(false);
			this.btn_add.setDisabled(false);
		}
		
		this.do_load();
	}
}

function M_TrxInsiden()
{
	m_trx_insiden_master		= new M_TrxInsidenMaster('Data Insiden');
	m_trx_insiden_detail		= new M_TrxInsidenDetail('Rekomendasi Insiden');
	m_trx_insiden_master_add	= new M_TrxInsidenMasterAdd('Entry / Edit Data Insiden');

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
				m_trx_insiden_master.grid
			,	m_trx_insiden_detail.grid
			]
	});
	
	this.panel = new Ext.Panel({
			id				: 'trx_insiden_panel'
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				this.panel_master_detail
			,	m_trx_insiden_master_add.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_trx_insiden_ha_level		= ha_level;
		m_trx_insiden_id_insiden 	= '';

		m_trx_insiden_master.do_refresh();
	}
}

m_trx_insiden = new M_TrxInsiden();

//@ sourceURL=trx_jsa.layout.js
