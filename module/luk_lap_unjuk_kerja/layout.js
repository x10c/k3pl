/**
 * Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_luk_lap_unjuk_kerja;
var m_luk_d	= _g_root +'/module/luk_lap_unjuk_kerja/';

function M_LUK()
{
	this.ha_level = 0;

	this.fields = new Ext.data.Record.create([
		{name:'id'}
	,	{name:'name'}
	,	{name:'teknik_bulan'}
	,	{name:'teknik_tahun'}
	,	{name:'teknik_kumul'}
	,	{name:'servis_bulan'}
	,	{name:'servis_tahun'}
	,	{name:'servis_kumul'}
	,	{name:'kontrak_bulan'}
	,	{name:'kontrak_tahun'}
	,	{name:'kontrak_kumul'}
	,	{name:'kum_bulan'}
	,	{name:'kum_tahun'}
	,	{name:'kum_kumul'}
	]);

	this.reader = new Ext.data.JsonReader(
		{}
		, this.fields
	);

	this.store = new Ext.data.Store({
		url	: m_luk_d +'data.jsp'
	,	reader	: this.reader
	,	autoLoad: false
	});

	this.form_year = new Ext.form.ComboBox({
		store		: new Ext.data.ArrayStore({
			fields	: ['year']
		,	data	: k3pl_create_form_year_data(10)
		})
	,	valueField	: 'year'
	,	displayField	: 'year'
	,	allowBlank	: false
	,	mode		: 'local'
	,	triggerAction	: 'all'
	});

	this.form_month	= new Ext.form.ComboBox({
		store		: new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: k3pl_months
		})
	,	valueField	: 'id'
	,	displayField	: 'name'
	,	allowBlank	: false
	,	mode		: 'local'
	,	triggerAction	: 'all'
	});

	this.columns = [
		new Ext.grid.RowNumberer({
			header	: '<br/>No.'
		,	locked	: true
		}),{
			header		: '<br/>Keterangan'
		,	align		: 'left'
		,	dataIndex	: 'name'
		,	width		: 260
		},{
			header		: '<br/><hr/>Bulan'
		,	dataIndex	: 'teknik_bulan'
		,	css		: 'background-color: #DAEAFF;'
		},{
			header		: 'Teknik<br/><hr/>Tahun'
		,	dataIndex	: 'teknik_tahun'
		,	css		: 'background-color: #C5DEFF;'
		},{
			header		: '<br/><hr/>Kumulatif'
		,	dataIndex	: 'teknik_kumul'
		,	css		: 'background-color: #B9D7FF;'
		},{
			header		: '<br/><hr/>Bulan'
		,	dataIndex	: 'servis_bulan'
		},{
			header		: 'Servis<br/><hr/>Tahun'
		,	dataIndex	: 'servis_tahun'
		},{
			header		: '<br/><hr/>Kumulatif'
		,	dataIndex	: 'servis_kumul'
		},{
			header		: '<br/><hr/>Bulan'
		,	dataIndex	: 'kontrak_bulan'
		,	css		: 'background-color: #DAEAFF;'
		},{
			header		: 'Kontrak<br/><hr/>Tahun'
		,	dataIndex	: 'kontrak_tahun'
		,	css		: 'background-color: #C5DEFF;'
		},{
			header		: '<br/><hr/>Kumulatif'
		,	dataIndex	: 'kontrak_kumul'
		,	css		: 'background-color: #B9D7FF;'
		},{
			header		: '<br/><hr/>Bulan'
		,	dataIndex	: 'kum_bulan'
		},{
			header		: 'Kumulatif<br/><hr/>Tahun'
		,	dataIndex	: 'kum_tahun'
		},{
			header		: '<br/><hr/>Kumulatif'
		,	dataIndex	: 'kum_kumul'
		}
	];

	this.cm = new Ext.ux.grid.LockingColumnModel({
		columns : this.columns
	,	defaults: {
			hideable	: false
		,	align		: 'center'
		,	width		: 85
		}
	});

	this.btn_ref = new Ext.Button({
		text	: 'Refresh'
	,	iconCls	: 'refresh16'
	,	scope	: this
	,	handler	: function() {
			this.do_load(this.ha_level);
		}
	});
	
	this.panel = new Ext.grid.GridPanel({
		title		: 'Unjuk Kerja K3PL'
	,	store		: this.store
	,	columns		: this.columns
	,	autoScroll	: true
	,	autoWidth	: true
	,	stripeRows	: true
	,	columnLines	: true
	,	tbar		: [
			' Tahun : ', this.form_year, '-'
		,	' Bulan : ', this.form_month, '-'
		,	this.btn_ref
		,	'->'
		,	{
				xtype	: 'exportbutton'
			,	store	: this.store
			}
		]
	});

	this.do_load = function()
	{
		this.store.load({
			params	: {
				year	: this.form_year.getValue()
			,	month	: this.form_month.getValue()
			}
		});
	}
	
	this.do_print = function(){
		var form;
		form = document.createElement('form');
		
		form.setAttribute('method', 'post');
		form.setAttribute('action', _g_root +'/module/luk_lap_unjuk_kerja/data_unjuk_export.jsp');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'store');
        hiddenField1.setAttribute('value', this.store.getRange());
		
		form.appendChild(hiddenField1);
		document.body.appendChild(form);
		form.submit();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		this.form_year.setValue(this.form_year.store.getAt(0).get('year'));
		this.form_month.setValue('1');

		this.do_load();
	}
}

function M_LUKChart(title, y_title, store_url, chart_type, show_target)
{
	this.fields = new Ext.data.Record.create([
		{name:'id'}
	,	{name:'name'}
	,	{name:'teknik'}
	,	{name:'servis'}
	,	{name:'kontrak'}
	,	{name:'kumulatif'}
	,	{name:'target'}
	]);

	this.reader = new Ext.data.JsonReader(
		{}
		, this.fields
	);

	this.store = new Ext.data.Store({
		url	: store_url
	,	reader	: this.reader
	,	autoLoad: false
	});

	this.form_year = new Ext.form.ComboBox({
		store		: new Ext.data.ArrayStore({
			fields	: ['year']
		,	data	: k3pl_create_form_year_data(10)
		})
	,	valueField	: 'year'
	,	displayField	: 'year'
	,	allowBlank	: false
	,	mode		: 'local'
	,	triggerAction	: 'all'
	});

	this.btn_ref = new Ext.Button({
		text	: 'Refresh'
	,	iconCls	: 'refresh16'
	,	scope	: this
	,	handler	: function() {
			this.do_load();
		}
	});

	this.chart = new Ext.ux.HighChart({
		store		: this.store
	,	xField		: 'name'
	,	series		: [{
			name		: 'Teknik'
		,	dataIndex	: 'teknik'
		},{
			name		: 'Servis'
		,	dataIndex	: 'servis'
		},{
			name		: 'Kontrak'
		,	dataIndex	: 'kontrak'
		},{
			name		: 'Kumulatif'
		,	dataIndex	: 'kumulatif'
		},{
			name		: 'Target'
		,	dataIndex	: 'target'
		,	type		: 'line'
		}]
	,	chartConfig	: {
			chart	: {
				defaultSeriesType: chart_type
			}
		,	title	: {
				text: title
			}
		,	subtitle: {
				text: 'Tahun'
			}
		,	xAxis	: [{}]
		,	yAxis	: {
				title: {
					text: y_title
				}
			}
		,	legend		: {
				layout		: 'horizontal'
			}
		}
	});

	if (!show_target) {
		this.chart.removeSerie(4, true);
	}

	this.panel = new Ext.Panel({
		title		: title
	,	border		: true
	,	layout		: 'fit'
	,	tbar		: [
			' Tahun : ', this.form_year
		,	'-', this.btn_ref
		]
	,	items		: [
			this.chart
		]
	});

	this.do_load = function()
	{
		this.store.load({
			params	: {
				year: this.form_year.getValue()
			}
		});

		this.chart.setSubTitle('Tahun '+ this.form_year.getValue());
	}

	this.do_refresh = function(ha_level)
	{
		this.form_year.setValue(this.form_year.store.getAt(0).get('year'));
		this.do_load();
	}
}

function M_LUK_JBAForm (_parent, displayBulan)
{
	this.ref_parent = _parent;

	this.set_org = new k3pl.form.SetOrganisasi({
			itemAll			:true
		,	scope			:this
		,	checkboxToggle	:false
		});

	this.set_org.formDivProSBU.hide ();
	this.set_org.formDepartemen.hide ();
	this.set_org.formDinas.hide ();
	this.set_org.formSeksi.hide ();

	this.set_waktu = new k3pl.form.SetWaktu({
			itemAll			:displayBulan
		,	displayBulan	:displayBulan
		});

	this.btn_submit = new Ext.Button({
		text		: 'Submit'
	,	listeners	: {
			scope	: this
		,	click	: function(btn, e) {
				this.ref_parent.do_load (
						this.set_org.formDirektorat.getValue ()
					,	this.set_waktu.formTahun.getValue()
				);
			}
		}
	});

	this.panel = new Ext.form.FormPanel({
		frame		: true
	,	width		: 500
	,	labelAlign	: 'right'
	,	labelWidth	: 150
	,	buttonAlign	: 'center'
	,	buttons		: [
			this.btn_submit
		]
	,	items		: [
			this.set_org
		,	this.set_waktu
		]
	});

	this.do_refresh = function(ha_level)
	{
		this.set_org.do_load();
		this.set_waktu.do_load();
	}
}

function M_LUK_JBA ()
{
	this.grid_store = new Ext.data.JsonStore ({
				url			: m_luk_d +'data_jba.jsp'
			,	autoLoad	: false
			,	storeId		: 'JBA'
			,	fields		: [
						'id'
					,	'name'
					,	'jan'
					,	'feb'
					,	'mar'
					,	'apr'
					,	'may'
					,	'jun'
					,	'jul'
					,	'aug'
					,	'sep'
					,	'oct'
					,	'nov'
					,	'dec'
				]
			,	idProperty	:'id'
		});

	this.grid_cm = new Ext.grid.ColumnModel ({
			columns	: [{
					header		:'Nama'
				,	dataIndex	:'name'
				,	width		:260
				},{
					header		:'Januari'
				,	dataIndex	:'jan'
				},{
					header		:'Februari'
				,	dataIndex	:'feb'
				},{
					header		:'Maret'
				,	dataIndex	:'mar'
				},{
					header		:'April'
				,	dataIndex	:'apr'
				},{
					header		:'Mei'
				,	dataIndex	:'may'
				},{
					header		:'Juni'
				,	dataIndex	:'jun'
				},{
					header		:'Juli'
				,	dataIndex	:'jul'
				},{
					header		:'Agustus'
				,	dataIndex	:'aug'
				},{
					header		:'September'
				,	dataIndex	:'sep'
				},{
					header		:'Oktober'
				,	dataIndex	:'oct'
				},{
					header		:'November'
				,	dataIndex	:'nov'
				},{
					header		:'Desember'
				,	dataIndex	:'dec'
			}]
		});

	this.grid = new Ext.grid.GridPanel ({
		title		: 'Data'
	,	autoHeight	: true
	,	autoScroll	: true
	,	store		: this.grid_store
	,	colModel	: this.grid_cm
	});

	this.chart = new Ext.Panel ({
			title		: 'Grafik'
		,	html		: '<div id="luk_jba_chart"></div>'
		,	view		: {}
		,	chartConfig	: {
				chart		: {
					renderTo			: 'luk_jba_chart'
				,	defaultSeriesType	: 'column'
				}
			,	title	: {
					text		: 'Grafik Jarak Berkendara Aman (KM)'
				}
			,	subtitle: {
					text		: 'Tahun'
				}
			,	xAxis	: {
					categories	: [
						'Jan'
					,	'Feb'
					,	'Mar'
					,	'Apr'
					,	'Mei'
					,	'Jun'
					,	'Jul'
					,	'Agu'
					,	'Sep'
					,	'Okt'
					,	'Nov'
					,	'Des'
					]
				}
			,	yAxis	: {
					title		: {
						text		: ''
					}
				}
			,	legend	: {
					layout		: 'horizontal'
				}
			,	series	: []
			}
		});

	this.form = new M_LUK_JBAForm (this, 0);

	this.panel = new Ext.Panel ({
		title		: 'Jarak Berkendaraan Aman'
	,	autoScroll	: true
	,	frame		: false
	,	padding		: '6'
	,	defaults	:{
			style		: {
				marginLeft	:'auto'
			,	marginRight	:'auto'
			,	marginBottom:'8px'
			}
		}
	,	items		: [
				this.form.panel
			,	this.grid
			,	this.chart
		]
	});

	this.do_load = function (id_dir, year)
	{
		this.grid_store.load ({
			scope	: this
		,	params	: {
				id_dir		: id_dir
			,	year		: year
			}
		,	callback: function (records, options, success) {
				if (! success || records.length <= 0) {
					return;
				}

				/* hide all month columns except for the last four months */
				/*
				var d		= new Date();
				var m_end	= d.getMonth() + 1;
				var m_start	= 1;

				if (m_end > 3) {
					m_start = m_end - 3;
				}

				for (var i = 1; i < this.grid_cm.getColumnCount (); i++) {
					if (i < m_start || i > m_end) {
						this.grid_cm.setHidden (i, true);
					} else {
						this.grid_cm.setHidden (i, false);
					}
				}
				*/

				this.chart.chartConfig.subtitle.text	= 'Tahun '+ year;
/*
				this.chart.chartConfig.xAxis.min		= m_start - 1;
				this.chart.chartConfig.xAxis.max		= m_end - 1;
*/
				this.chart.chartConfig.series			= this.convert_records_to_series (records);
				this.chart.view = new Highcharts.Chart (this.chart.chartConfig);
			}
		});
	}

	this.convert_records_to_series = function (records)
	{
		var s = [];
		var r;
		for (var i = 0; i < records.length; i++) {
			r			= records[i];
			s[i]		= {};
			s[i].name	= r.get('name');
			s[i].data	= [];
			s[i].data.push (parseInt (r.get('jan')));
			s[i].data.push (parseInt (r.get('feb')));
			s[i].data.push (parseInt (r.get('mar')));
			s[i].data.push (parseInt (r.get('apr')));
			s[i].data.push (parseInt (r.get('may')));
			s[i].data.push (parseInt (r.get('jun')));
			s[i].data.push (parseInt (r.get('jul')));
			s[i].data.push (parseInt (r.get('aug')));
			s[i].data.push (parseInt (r.get('sep')));
			s[i].data.push (parseInt (r.get('oct')));
			s[i].data.push (parseInt (r.get('nov')));
			s[i].data.push (parseInt (r.get('dec')));
		}

		return s;
	}

	this.do_refresh = function (ha_level)
	{
		this.form.do_refresh (ha_level);
	}
}

function M_LUK_Insiden ()
{
	this.grid_store = new Ext.data.JsonStore ({
				url			: m_luk_d +'data_insiden.jsp'
			,	autoLoad	: false
			,	fields		: [
						'unit_id'
					,	'unit_name'
					,	'jml_korban_mati'
					,	'jml_korban_berat'
					,	'jml_korban_sedang'
					,	'jml_korban_medis'
					,	'jml_korban_p3k'
					,	'jml_hampir_celaka'
					,	'jml_kecelakaan_kendaraan'
				]
			,	idProperty	:'unit_id'
		});

	this.grid_cm = new Ext.grid.ColumnModel ({
			columns	: [{
					header		:'Nama Unit'
				,	dataIndex	:'unit_name'
				,	width		:260
				},{
					header		:'Fatality'
				,	dataIndex	:'jml_korban_mati'
				},{
					header		:'Kecelakaan Berat'
				,	dataIndex	:'jml_korban_berat'
				},{
					header		:'Kecelakaan Sedang'
				,	dataIndex	:'jml_korban_sedang'
				},{
					header		:'Kecelakaan Ringan'
				,	dataIndex	:'jml_korban_medis'
				},{
					header		:'First Aid'
				,	dataIndex	:'jml_korban_p3k'
				},{
					header		:'Near Miss'
				,	dataIndex	:'jml_hampir_celaka'
				},{
					header		:'Kecelakaan Kendaraan'
				,	dataIndex	:'jml_kecelakaan_kendaraan'
				}]
		});

	this.grid = new Ext.grid.GridPanel ({
		title		: 'Data'
	,	autoHeight	: true
	,	autoScroll	: true
	,	store		: this.grid_store
	,	colModel	: this.grid_cm
	});

	this.chart = new Ext.Panel ({
			title		: 'Grafik'
		,	html		: '<div id="luk_insiden_chart"></div>'
		,	view		: {}
		,	chartConfig	: {
				chart		: {
					renderTo			: 'luk_insiden_chart'
				,	defaultSeriesType	: 'column'
				}
			,	title	: {
					text		: 'Grafik Insiden'
				}
			,	subtitle: {
					text		: 'Tahun'
				}
			,	xAxis	: {
					categories	: []
				}
			,	yAxis	: {
					title		: {
						text		: ''
					}
				}
			,	legend	: {
					layout		: 'horizontal'
				}
			,	series	: [{
					name		: 'Fatality'
				,	dataIndex	: 'jml_korban_mati'
				},{
					name		: 'Kecelakaan Berat'
				,	dataIndex	: 'jml_korban_berat'
				},{
					name		: 'Kecelakaan Sedang'
				,	dataIndex	: 'jml_korban_sedang'
				},{
					name		: 'Kecelakaan Ringan'
				,	dataIndex	: 'jml_korban_medis'
				},{
					name		: 'First Aid'
				,	dataIndex	: 'jml_korban_p3k'
				},{
					name		: 'Near Miss'
				,	dataIndex	: 'jml_hampir_celaka'
				},{
					name		: 'Kecelakaan Kendaraan'
				,	dataIndex	: 'jml_kecelakaan_kendaraan'
				}]
			}
		});

	this.form = new M_LUK_JBAForm (this, 0);

	this.panel = new Ext.Panel ({
		title		: 'Insiden'
	,	autoScroll	: true
	,	frame		: false
	,	padding		: '6'
	,	defaults	:{
			style		: {
					marginLeft	:'auto'
				,	marginRight	:'auto'
				,	marginBottom:'8px'
			}
		}
	,	items		: [
				this.form.panel
			,	this.grid
			,	this.chart
		]
	});

	this.do_load = function (id_dir, year)
	{
		this.grid_store.load ({
			scope	: this
		,	params	: {
				id_dir	: id_dir
			,	year	: year
			}
		,	callback: function (records, options, success) {
				if (! success || records.length <= 0) {
					return;
				}

				this.chart.chartConfig.subtitle.text	= 'Tahun '+ year;
				this.set_chart_categories (records);
				this.set_chart_series_data (records);
				this.chart.view = new Highcharts.Chart (this.chart.chartConfig);
			}
		});
	}

	this.set_chart_categories = function (records)
	{
		var cat = this.chart.chartConfig.xAxis.categories = [];

		for (var i = 0; i < records.length; i++) {
			cat.push (records[i].get ('unit_name'));
		}
	}

	this.set_chart_series_data = function (records)
	{
		var s = this.chart.chartConfig.series;

		for (var i = 0; i < s.length; i++) {
			s[i].data = [];

			for (var j = 0; j < records.length; j++) {
				s[i].data.push (parseInt (records[j].get (s[i].dataIndex)));
			}
		}
	}

	this.do_refresh = function (ha_level)
	{
		this.form.do_refresh (ha_level);
	}
}

function M_LUK_TJK (displayBulan)
{
	this.ha_level = 0;

	this.set_org = new k3pl.form.SetOrganisasi({
			itemAll			:true
		,	scope			:this
		,	checkboxToggle	:false
		});

	this.set_org.formDepartemen.hide ();
	this.set_org.formDinas.hide ();
	this.set_org.formSeksi.hide ();

	this.set_waktu = new k3pl.form.SetWaktu({
			itemAll			:displayBulan
		,	displayBulan	:displayBulan
		});

	this.btn_submit = new Ext.Button ({
		text		: 'Submit'
	,	listeners	: {
			scope	: this
		,	click	: function(btn, e) {
				this.do_load (
						this.set_org.formDirektorat.getValue ()
					,	this.set_org.formDivProSBU.getValue ()
					,	this.set_org.formDepartemen.getValue ()
					,	this.set_org.formDinas.getValue ()
					,	this.set_org.formSeksi.getValue ()
					,	this.set_waktu.formTahun.getValue()
					,	this.set_waktu.formBulan.getValue()
				);
			}
		}
	});

	this.form = new Ext.form.FormPanel ({
		frame		: true
	,	width		: 500
	,	labelAlign	: 'right'
	,	labelWidth	: 150
	,	buttonAlign	: 'center'
	,	buttons		: [
			this.btn_submit
		]
	,	items		: [
			this.set_org
		,	this.set_waktu
		]
	});

	/*
	** grid 
	**/
	this.fields = new Ext.data.Record.create([
		{name: 'id'}
	,	{name: 'name'}
	,	{name: 'jml_tk_bulan_lalu'}
	,	{name: 'jml_tenaga_kerja'}
	,	{name: 'jml_jk_bulan_lalu'}
	,	{name: 'jml_jam_kerja'}
	,	{name: 'jml_kecelakaan'}
	,	{name: 'jml_korban_ringan'}
	,	{name: 'jml_korban_sedang'}
	,	{name: 'jml_korban_berat'}
	,	{name: 'jml_korban_mati'}
	,	{name: 'jml_korban_total'}
	,	{name: 'jml_hh_ringan'}
	,	{name: 'jml_hh_sedang'}
	,	{name: 'jml_hh_berat'}
	,	{name: 'jml_hh_mati'}
	,	{name: 'jml_hh_total'}
	,	{name: 'ket'}
	]);

	this.reader = new Ext.data.JsonReader(
		{root:'info'}
		, this.fields
	);

	this.store = new Ext.data.Store({
		url		: m_luk_d +'data_tjk.jsp'
	,	reader	: this.reader
	,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer ({
				header	: 'NO.'
			,	locked	: true
			,	width	: 40
			}),{
				header		: 'Pekerja'
			,	dataIndex	: 'name'
			,	align		: 'left'
			,	width		: 100
			},{
				header		: 'Lalu'
			,	dataIndex	: 'jml_tk_bulan_lalu'
			,	editable	: false
			,	css			: 'background-color: #f0f0f0;'
			,	width		: 60
			},{
				header		: 'Sekarang'
			,	dataIndex	: 'jml_tenaga_kerja'
			,	width		: 80
			},{
				header		: 'Lalu'
			,	dataIndex	: 'jml_jk_bulan_lalu'
			,	css			: 'background-color: #f0f0f0;'
			},{
				header		: 'Sekarang'
			,	dataIndex	: 'jml_jam_kerja'
			,	width		: 80
			},{
				header		: 'Jumlah Kecelakaan'
			,	dataIndex	: 'jml_kecelakaan'
			,	css			: 'background-color: #f0f0f0;'
			,	width		: 100
			},{
				header		: 'Ringan'
			,	dataIndex	: 'jml_korban_ringan'
			},{
				header		: 'Sedang'
			,	dataIndex	: 'jml_korban_sedang'
			},{
				header		: 'Berat'
			,	dataIndex	: 'jml_korban_berat'
			},{
				header		: 'Mati'
			,	dataIndex	: 'jml_korban_mati'
			},{
				header		: 'Total'
			,	dataIndex	: 'jml_korban_total'
			},{
				header		: 'Ringan'
			,	dataIndex	: 'jml_hh_ringan'
			},{
				header		: 'Sedang'
			,	dataIndex	: 'jml_hh_sedang'
			},{
				header		: 'Berat'
			,	dataIndex	: 'jml_hh_berat'
			},{
				header		: 'Mati'
			,	dataIndex	: 'jml_hh_mati'
			},{
				header		: 'Total'
			,	dataIndex	: 'jml_hh_total'
			},{
				header		: 'Keterangan'
			,	dataIndex	: 'ket'
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
		header	: 'Jam Kerja Nyata + Lembur Bulan'
	,	colspan	: 2
	},{
		colspan	: 1
	},{
		header	: 'Jumlah Korban'
	,	colspan	: 5
	},{
		header	: 'Jumlah Hari Hilang'
	,	colspan	: 5
	}];

	this.hdr = new Ext.ux.grid.ColumnHeaderGroup({
		rows	: [this.col_hdr]
	});

	this.grid = new Ext.grid.GridPanel({
		store		: this.store
	,	cm			: this.cm
	,	autoScroll	: true
	,	autoHeight	: true
	,	autoWidth	: true
	,	plugins		: [this.hdr]
	});

	/*
	** panel
	**/
	this.fields_kum = [
		{name: 'kum_jk_bulan_lalu'}
	,	{name: 'kum_jk_bulan_skrg'}
	,	{name: 'kum_tanggal'}
	];

	this.reader_kum = new Ext.data.JsonReader(
		{root	: 'info'}
	,	this.fields_kum
	);

	this.store_kum = new Ext.data.Store ({
		url			: m_luk_d +'data_tjk_kum.jsp'
	,	reader		: this.reader_kum
	,	autoLoad	: false
	});

	this.form_kum_jk_bulan_lalu = new Ext.form.NumberField({
		fieldLabel	: 'Kumulatif Jam Kerja Bulan Lalu'
	,	name		: 'kum_jk_bulan_lalu'
	});

	this.form_kum_jk_bulan_skrg = new Ext.form.NumberField({
		fieldLabel	: 'Kumulatif Jam Kerja Bulan Sekarang'
	,	name		: 'kum_jk_bulan_skrg'
	});

	this.form_kum_date = new Ext.form.TextField({
		fieldLabel	: 'Terhitung Mulai Tanggal'
	,	name		: 'kum_tanggal'
	});

	this.form_kumulatif = new Ext.form.FormPanel ({
		labelWidth	: 260
	,	labelAlign	: 'right'
	,	padding		: 5
	,	defaults	: {
			readOnly	: true
		,	width		: 120
		}
	,	items	: [
			this.form_kum_jk_bulan_lalu
		,	this.form_kum_jk_bulan_skrg
		,	this.form_kum_date
		]
	});

	this.panel = new Ext.Panel({
		title		: 'Tenaga, Jam dan Kecelakaan'
	,	autoWidth	: true
	,	autoScroll	: true
	,	defaults	:{
			style		: {
				marginLeft	:'auto'
			,	marginRight	:'auto'
			,	marginBottom:'8px'
			}
		}
	,	items		: [
			this.form
		,	this.grid
		,	this.form_kumulatif
		]
	});

	this.do_load = function (dir, div, dep, dinas, seksi, tahun, bulan)
	{
		this.store.load ({
			params	: {
				dir		: dir
			,	div		: div
			,	dep		: dep
			,	dinas	: dinas
			,	seksi	: seksi	
			,	tahun	: tahun
			,	bulan	: bulan
			}
		});

		this.store_kum.load ({
			scope	: this
		,	params	: {
				dir		: dir
			,	div		: div
			,	tahun	: tahun
			,	bulan	: bulan
			}
		,	callback: function (r,options,success) {
				if (r && r.length > 0) {
					this.form_kum_jk_bulan_lalu.setValue(r[0].get('kum_jk_bulan_lalu'));
					this.form_kum_jk_bulan_skrg.setValue(r[0].get('kum_jk_bulan_skrg'));
					this.form_kum_date.setValue(r[0].get('kum_tanggal'));
				}
			}

		});
	}

	this.do_refresh = function (ha_level)
	{
		this.ha_level = ha_level;
		this.set_org.do_load ();
		this.set_waktu.do_load ();
	}
}

function M_LUKAll()
{
	this.uk				= new M_LUK();
	this.uk_chart_jka	= new M_LUKChart(
				'Jam Kerja Aman Kumulatif'
				, 'Jam Kerja'
				, m_luk_d +'data_jka.jsp'
				, 'column', false);

	this.uk_chart_ltif	= new M_LUKChart(
				'LTIF'
				, ''
				, m_luk_d +'data_ltif.jsp'
				, 'column', true);

	this.uk_chart_tsaf	= new M_LUKChart(
				'TSAF'
				, ''
				, m_luk_d +'data_tsaf.jsp'
				, 'column', true);

	this.luk_jba		= new M_LUK_JBA ();
	this.luk_insiden	= new M_LUK_Insiden ();
	this.luk_tjk		= new M_LUK_TJK (true);

	this.panel = new Ext.TabPanel({
		id				: 'luk_lap_unjuk_kerja_panel'
	,	activeTab		: 0
	,	enableTabScroll	: true
	,	items			: [
			this.luk_tjk.panel
		,	this.uk.panel
		,	this.uk_chart_jka.panel
		,	this.uk_chart_ltif.panel
		,	this.uk_chart_tsaf.panel
		,	this.luk_jba.panel
		,	this.luk_insiden.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		this.luk_tjk.do_refresh (ha_level);
		this.uk.do_refresh(ha_level);
		this.uk_chart_jka.do_refresh(ha_level);
		this.uk_chart_ltif.do_refresh(ha_level);
		this.uk_chart_tsaf.do_refresh(ha_level);
		this.luk_jba.do_refresh (ha_level);
		this.luk_insiden.do_refresh (ha_level);
	}
}

m_luk_lap_unjuk_kerja = new M_LUKAll();

//@ sourceURL=luk_lap_unjuk_kerja.layout.js
