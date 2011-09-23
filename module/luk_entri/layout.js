/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_luk_entri;
var m_luk_thj;
var m_luk_jarak;
var m_luk_entri_d = _g_root +'/module/luk_entri/';

function M_LUKTenagaHariJam()
{
	this.ha_level = 0;

	this.fields = [
		{name: 'id'}
	,	{name: 'name'}
	,	{name: 'jml_tk_bulan_lalu'}
	,	{name: 'jml_tenaga_kerja'}
	,	{name: 'jml_hk_bulan_lalu'}
	,	{name: 'jml_hari_kerja'}
	,	{name: 'jml_ha_bulan_lalu'}
	,	{name: 'jml_hari_absen'}
	,	{name: 'jml_jk_bulan_lalu'}
	,	{name: 'jml_jam_kerja'}
	];

	this.fields_kum = [
		{name: 'kum_hari_kerja'}
	,	{name: 'kum_hari_absen'}
	,	{name: 'kum_jk_bulan_lalu'}
	,	{name: 'kum_jk_bulan_skrg'}
	,	{name: 'kum_tanggal'}
	];

	this.reader = new Ext.data.JsonReader(
		{	id	: 'id'
		,	root	: 'rows'
		}
		, this.fields
	);

	this.reader_kum = new Ext.data.JsonReader(
		{root	: 'rows'}
	,	this.fields_kum
	);

	this.store = new Ext.data.Store({
		url		: m_luk_entri_d +'data_jka.jsp'
	,	reader		: this.reader
	,	autoLoad	: false
	});

	this.store_kum = new Ext.data.Store({
		url		: m_luk_entri_d +'data_kum.jsp'
	,	reader		: this.reader_kum
	,	autoLoad	: false
	});

	this.form_number = new Ext.form.NumberField({
		allowBlank	: false
	,	allowDecimals	: false
	,	allowNegative	: false
	,	value		: '0'
	});

	this.form_float	= new Ext.form.NumberField({
		allowBlank	: false
	,	allowNegative	: false
	,	value		: '0.00'
	,	format		: '0.00'
	});

	this.form_ket = new Ext.form.TextField();

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
				new Ext.grid.RowNumberer()
			,{
				header		: 'Pekerja'
			,	dataIndex	: 'name'
			,	align		: 'left'
			,	width		: 100
			,	summaryRenderer	: function() {
					return '<center><b>Total :</b></center>';
				}
			},{
				header		: 'Lalu'
			,	dataIndex	: 'jml_tk_bulan_lalu'
			,	editable	: false
			,	summaryType	: 'sum'
			,	css		: 'background-color: #f0f0f0;'
			},{
				header		: 'Sekarang'
			,	dataIndex	: 'jml_tenaga_kerja'
			,	summaryType	: 'sum'
			,	editor		: this.form_number
			},{
				header		: 'Lalu'
			,	dataIndex	: 'jml_jk_bulan_lalu'
			,	editable	: false
			,	css		: 'background-color: #f0f0f0;'
			,	summaryType	: 'sum'
			},{
				header		: 'Sekarang'
			,	dataIndex	: 'jml_jam_kerja'
			,	summaryType	: 'sum'
			,	editor		: this.form_float
			},{
				header		: 'Lalu'
			,	dataIndex	: 'jml_hk_bulan_lalu'
			,	editable	: false
			,	css		: 'background-color: #f0f0f0;'
			,	summaryType	: 'sum'
			},{
				header		: 'Sekarang'
			,	dataIndex	: 'jml_hari_kerja'
			,	summaryType	: 'sum'
			,	editor		: this.form_number
			},{
				header		: 'Lalu'
			,	dataIndex	: 'jml_ha_bulan_lalu'
			,	editable	: false
			,	css		: 'background-color: #f0f0f0;'
			,	summaryType	: 'sum'
			},{
				header		: 'Sekarang'
			,	dataIndex	: 'jml_hari_absen'
			,	summaryType	: 'sum'
			,	editor		: this.form_number
			}]
	,	defaults : {
			align		: 'center'
		,	sortable	: false
		,	hideable	: false
		,	width		: 60
		}
	});

	this.col_hdr = [{
		colspan	: 2
	},{
		header	: 'Tenaga Kerja Bulan'
	,	colspan	: 2
	},{
		header	: 'Jam Kerja Nyata + Lembur'
	,	colspan	: 2
	},{
		header	: 'Hari Kerja'
	,	colspan	: 2
	},{
		header	: 'Ketidakhadiran Karena Sakit (TSA)'
	,	colspan	: 2
	}];

	this.hdr = new Ext.ux.grid.ColumnHeaderGroup({
		rows	: [this.col_hdr]
	});

	this.summary = new Ext.ux.grid.GridSummary();

	this.form_year = new Ext.form.ComboBox({
		store		: new Ext.data.ArrayStore({
		fields		: ['year']
		,	data	: k3pl_create_form_year_data(10)
		})
	,	width		: 100
	,	editable	: false
	,	valueField	: 'year'
	,	displayField	: 'year'
	,	mode		: 'local'
	,	triggerAction	: 'all'
	});

	this.form_month = new Ext.form.ComboBox({
		store		: new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	data	: k3pl_months
		})
	,	width		: 100
	,	editable	: false
	,	valueField	: 'id'
	,	displayField	: 'name'
	,	mode		: 'local'
	,	triggerAction	: 'all'
	});

	this.btn_refresh = new Ext.Button({
		text	: 'Refresh'
	,	iconCls : 'refresh16'
	,	scope	: this
	,	handler	: function() {
			this.do_load();
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

	this.grid = new Ext.grid.EditorGridPanel({
		store		: this.store
	,	cm		: this.cm
	,	border		: false
	,	frame		: false
	,	autoScroll	: true
	,	autoHeight	: true
	,	autoWidth	: true
	,	plugins		: [this.summary, this.hdr]
	});

	/*
	 * Kumulatif
	 */
	this.form_kum_hari_kerja = new Ext.form.NumberField({
		fieldLabel	: 'Kumulatif Hari Kerja'
	});

	this.form_kum_hari_absen = new Ext.form.NumberField({
		fieldLabel	: 'Kumulatif Hari Absen'
	});

	this.form_kum_jk_bulan_lalu = new Ext.form.NumberField({
		fieldLabel	: 'Kumulatif Jam Kerja Bulan Lalu'
	});

	this.form_kum_jk_bulan_skrg = new Ext.form.NumberField({
		fieldLabel	: 'Kumulatif Jam Kerja Bulan Sekarang'
	});

	this.form_kum_date = new Ext.form.TextField({
		fieldLabel	: 'Terhitung Mulai Tanggal'
	});

	this.panel_kumulatif = new Ext.form.FormPanel({
		labelWidth	: 220
	,	labelAlign	: 'right'
	,	padding		: 5
	,	defaults	: {
			readOnly	: true
		,	width		: 120
		}
	,	items	: [
			this.form_kum_hari_kerja
		,	this.form_kum_hari_absen
		,	this.form_kum_jk_bulan_lalu
		,	this.form_kum_jk_bulan_skrg
		,	this.form_kum_date
		]
	});

	this.panel = new Ext.Panel({
		title		: 'Jumlah Tenaga, Hari dan Jam Kerja'
	,	autoWidth	: true
	,	autoScroll	: true
	,	tbar		: [
			' Tahun : '
		,	this.form_year
		,	'-'
		,	' Bulan : '
		,	this.form_month
		,	'-'
		,	this.btn_refresh
		,	'->'
		,	this.btn_save
		]
	,	items		: [
			this.grid
		,	this.panel_kumulatif
		]
	});

	this.do_load = function()
	{
		var y = this.form_year.getValue();
		if (y <= 0) {
			return;
		}

		var m = this.form_month.getValue();

		this.store.load({
			params	: {
				year 	: y
			,	month	: m
			}
		});

		this.store_kum.load({
			scope	: this
		,	params	: {
				year	: y
			,	month	: m
			}
		,	callback: function(r,options,success) {
				if (r && r.length > 0) {
					this.form_kum_hari_kerja.setValue(r[0].get('kum_hari_kerja'));
					this.form_kum_hari_absen.setValue(r[0].get('kum_hari_absen'));
					this.form_kum_jk_bulan_lalu.setValue(r[0].get('kum_jk_bulan_lalu'));
					this.form_kum_jk_bulan_skrg.setValue(r[0].get('kum_jk_bulan_skrg'));
					this.form_kum_date.setValue(r[0].get('kum_tanggal'));
				}
			}
		});
	}

	this.do_save = function()
	{
		var data	= "[";
		var mods	= this.store.getModifiedRecords();
		var changes;
		var i,j;

		for (i = 0; i < mods.length; i++) {
			if (i > 0) {
				data += ",";
			}

			data	+="{ id: '"+ mods[i].get('id') +"' "
				+ ", data: {";

			changes = mods[i].getChanges();
			j = 0;
			Ext.iterate(changes, function(k,v) {
				if (j > 0) {
					data += ",";
				} else {
					j = 1;
				}

				data += k +":'"+ v +"'";
			});

			data +="}}";
		}
		data +="]";

		Ext.Ajax.request({
			url	: m_luk_entri_d +'submit.jsp'
		,	params	: {
				year	: this.form_year.getValue()
			,	month	: this.form_month.getValue()
			,	rows	: data
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	scope	: this
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
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		this.form_year.setValue(this.form_year.store.getAt(0).get('year'));
		this.form_month.setValue(1);

		this.do_load();
	}
}

function M_LUKJarakBerkendaraan()
{
	this.ha_level = 0;

	this.fields = [
		{name: 'id'}
	,	{name: 'name'}
	,	{name: 'jml_jt_bulan_lalu'}
	,	{name: 'jml_jarak_tempuh'}
	,	{name: 'jml_jta_bulan_lalu'}
	,	{name: 'jml_jarak_tempuh_aman'}
	];

	this.reader = new Ext.data.JsonReader(
		{	id	: 'id'
		,	root	: 'rows'
		}
		, this.fields
	);

	this.store = new Ext.data.Store({
		url		: m_luk_entri_d +'data_jarak_tempuh.jsp'
	,	reader		: this.reader
	,	autoLoad	: false
	});

	this.fields_kum = [
		{name: 'kum_jt_bulan_lalu'}
	,	{name: 'kum_jt_bulan_skrg'}
	,	{name: 'kum_tanggal'}
	];

	this.reader_kum = new Ext.data.JsonReader(
		{root	: 'rows'}
	,	this.fields_kum
	);

	this.store_kum = new Ext.data.Store({
		url		: m_luk_entri_d +'data_kum_jarak.jsp'
	,	reader		: this.reader_kum
	,	autoLoad	: false
	});

	this.form_number = new Ext.form.NumberField({
		allowBlank	: false
	,	allowDecimals	: false
	,	allowNegative	: false
	,	value		: '0'
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
				new Ext.grid.RowNumberer()
			,{
				header		: 'Pekerja'
			,	dataIndex	: 'name'
			,	align		: 'left'
			,	width		: 100
			,	summaryRenderer	: function() {
					return '<center><b>Total :</b></center>';
				}
			},{
				header		: 'Lalu'
			,	dataIndex	: 'jml_jt_bulan_lalu'
			,	editable	: false
			,	summaryType	: 'sum'
			,	css		: 'background-color: #f0f0f0;'
			},{
				header		: 'Sekarang'
			,	dataIndex	: 'jml_jarak_tempuh'
			,	summaryType	: 'sum'
			,	editor		: this.form_number
			},{
				header		: 'Lalu'
			,	dataIndex	: 'jml_jta_bulan_lalu'
			,	editable	: false
			,	summaryType	: 'sum'
			,	css		: 'background-color: #f0f0f0;'
			},{
				header		: 'Sekarang'
			,	dataIndex	: 'jml_jarak_tempuh_aman'
			,	summaryType	: 'sum'
			,	editor		: this.form_number
		}]
	,	defaults : {
			align		: 'center'
		,	sortable	: false
		}
	});

	this.col_hdr = [{
		colspan	: 2
	},{
		header	: 'Total Jarak Tempuh (km)'
	,	colspan	: 2
	},{
		header	: 'Total Jarak Berkendaraan Aman (km)'
	,	colspan	: 2
	}];

	this.hdr = new Ext.ux.grid.ColumnHeaderGroup({
		rows	: [this.col_hdr]
	});

	this.summary = new Ext.ux.grid.GridSummary();

	this.form_year = new Ext.form.ComboBox({
		store		: new Ext.data.ArrayStore({
		fields		: ['year']
		,	data	: k3pl_create_form_year_data(10)
		})
	,	width		: 100
	,	editable	: false
	,	valueField	: 'year'
	,	displayField	: 'year'
	,	mode		: 'local'
	,	triggerAction	: 'all'
	});

	this.form_month = new Ext.form.ComboBox({
		store		: new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	data	: k3pl_months
		})
	,	width		: 100
	,	editable	: false
	,	valueField	: 'id'
	,	displayField	: 'name'
	,	mode		: 'local'
	,	triggerAction	: 'all'
	});

	this.btn_refresh = new Ext.Button({
		text	: 'Refresh'
	,	iconCls : 'refresh16'
	,	scope	: this
	,	handler	: function() {
			this.do_load();
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

	this.grid = new Ext.grid.EditorGridPanel({
		store		: this.store
	,	cm		: this.cm
	,	border		: false
	,	frame		: false
	,	autoScroll	: true
	,	autoWidth	: true
	,	autoHeight	: true
	,	plugins		: [this.summary, this.hdr]
	});

	this.form_kum_jt_bulan_lalu = new Ext.form.NumberField({
		fieldLabel	: 'Kumulatif Jarak Tempuh Bulan Lalu'
	});

	this.form_kum_jt_bulan_skrg = new Ext.form.NumberField({
		fieldLabel	: 'Kumulatif Jarak Tempuh Bulan Sekarang'
	});

	this.form_kum_date = new Ext.form.TextField({
		fieldLabel	: 'Terhitung Mulai Tanggal'
	});

	this.panel_kumulatif = new Ext.form.FormPanel({
		labelWidth	: 250
	,	labelAlign	: 'right'
	,	padding		: 5
	,	defaults	: {
			readOnly	: true
		,	width		: 120
		}
	,	items	: [
			this.form_kum_jt_bulan_lalu
		,	this.form_kum_jt_bulan_skrg
		,	this.form_kum_date
		]
	});

	this.panel = new Ext.Panel({
		title		: 'Jarak Berkendaraan'
	,	autoWidth	: true
	,	autoScroll	: true
	,	tbar		: [
			' Tahun : '
		,	this.form_year
		,	'-'
		,	' Bulan : '
		,	this.form_month
		,	'-'
		,	this.btn_refresh
		,	'->'
		,	this.btn_save
		]
	,	items		: [
			this.grid
		,	this.panel_kumulatif
		]
	});

	this.do_save = function()
	{
		var data	= "[";
		var mods	= this.store.getModifiedRecords();
		var changes;
		var i,j;

		for (i = 0; i < mods.length; i++) {
			if (i > 0) {
				data += ",";
			}

			data	+="{ id: '"+ mods[i].get('id') +"' "
				+ ", data: {";

			changes = mods[i].getChanges();
			j = 0;
			Ext.iterate(changes, function(k,v) {
				if (j > 0) {
					data += ",";
				} else {
					j = 1;
				}

				data += k +":'"+ v +"'";
			});

			data +="}}";
		}
		data +="]";

		Ext.Ajax.request({
			url	: m_luk_entri_d +'submit.jsp'
		,	params	: {
				year	: this.form_year.getValue()
			,	month	: this.form_month.getValue()
			,	rows	: data
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	scope	: this
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
		});
	}

	this.do_load = function()
	{
		var y = this.form_year.getValue();
		var m = this.form_month.getValue();

		this.store.load({
			params	: {
				year	: y
			,	month	: m
			}
		});

		this.store_kum.load({
			scope	: this
		,	params	: {
				year	: y
			,	month	: m
			}
		,	callback: function(r,options,success) {
				if (r && r.length > 0) {
					this.form_kum_jt_bulan_lalu.setValue(r[0].get('kum_jt_bulan_lalu'));
					this.form_kum_jt_bulan_skrg.setValue(r[0].get('kum_jt_bulan_skrg'));
					this.form_kum_date.setValue(r[0].get('kum_tanggal'));
				}
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		this.form_year.setValue(this.form_year.store.getAt(0).get('year'));
		this.form_month.setValue(1);

		this.do_load();
	}
}

function M_LUKEntri()
{
	m_luk_thj	= new M_LUKTenagaHariJam();
	m_luk_jarak	= new M_LUKJarakBerkendaraan();

	this.panel = new Ext.TabPanel({
		id		: 'luk_entri_panel'
	,	activeTab	: 0
	,	items		: [
			m_luk_thj.panel
		,	m_luk_jarak.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		m_luk_thj.do_refresh(ha_level);
		m_luk_jarak.do_refresh(ha_level);
	}
}

m_luk_entri = new M_LUKEntri();

//@ sourceURL=luk_entri.layout.js
