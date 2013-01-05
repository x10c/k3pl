/**
 * Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_charts;
var m_charts_interval;
var m_charts_n			= 8;
var m_charts_active		= 0;
var m_charts_id_div		= 0;
var m_charts_d			= _g_root +'/charts/';
var m_obs_lap_perf_d	= _g_root +'/module/obs_lap_performansi/';
var m_obs_lap_part_d	= _g_root +'/module/obs_lap_partisipasi/';
var m_rca_lap_part_d	= _g_root +'/module/rca_lap_partisipasi/';
var m_luk_d				= _g_root +'/module/luk_lap_unjuk_kerja/';

function M_ObsLapPerfChart(store, title, xField, xTitle, ySafe, yUnsafe)
{
	this.chart = new Ext.ux.HighChart({
		store		: store
	,	updateDelay	: 3
	,	xField		: xField
	,	series		: [{
			name		: '% Safe'
		,	dataIndex	: ySafe
		},{
			name		: '% Unsafe'
		,	dataIndex	: yUnsafe
		}]
	,	chartConfig	: {
			chart	: {
				defaultSeriesType : 'line'
			}
		,	title	: {
				text	: title
			}
		,	xAxis	: [{}]
		,	yAxis	: {
				title	: {
					text: '%'
				}
			}
		,	legend	: {
				display	: 'horizontal'
			}
		}
	});

	this.panel = new Ext.Panel({
		border		: true
	,	layout		: 'fit'
	,	style		: {
			marginLeft	: 'auto'
		,	marginRight	: 'auto'
		,	marginBottom	: '8px'
		}
	,	items		: [
			this.chart
		]
	});

	this.set_subtitle = function (s) {
		this.chart.setSubTitle(s);
	}

	this.do_refresh = function() {
		this.chart.refresh();
	}
}

function M_ChartPerfByCategory()
{
	this.store = new Ext.data.ArrayStore({
		fields		:[
			'obs_type_id'
		,	'obs_type_name'
		,	'n_safe'
		,	'n_unsafe'
		,	'safe_percent'
		,	'unsafe_percent'
		]
	,	url		: m_obs_lap_perf_d +'data_by_category.jsp'
	,	autoLoad	: false
	});

	this.chart	= new M_ObsLapPerfChart(
				this.store
			,	'Grafik Performansi per Kategori'
			,	'obs_type_name'
			,	'Kategori'
			,	'safe_percent'
			,	'unsafe_percent');

	this.do_refresh = function() {
		var date	= new Date();
		var year	= date.format ('Y');
		var month	= date.format ('n');

		this.chart.set_subtitle('Tahun '+ year +', bulan '
					+ k3pl_months_wall[month][1]);

		this.store.load({
			scope		: this
		,	params		: {
				id_dir		: 0
			,	id_div		: m_charts_id_div
			,	id_dep		: 0
			,	id_dinas	: 0
			,	id_seksi	: 0
			,	id_wilayah	: 0
			,	id_area		: 0
			,	year		: year
			,	month		: month
			}
		});
	}
}

function M_ChartPerfByIndex()
{
	this.store = new Ext.data.ArrayStore({
		fields		:[
			'id'
		,	'month'
		,	'n_safe'
		,	'n_unsafe'
		,	'safe_index'
		,	'unsafe_index'
		]
	,	url		: m_obs_lap_perf_d +'data_index_by_month.jsp'
	,	autoLoad	: false
	});

	this.chart = new M_ObsLapPerfChart(
					this.store
				,	'Grafik Safe/Unsafe Index'
				,	'month'
				,	'Bulan'
				,	'safe_index'
				,	'unsafe_index');

	this.do_refresh = function() {
		var date	= new Date();
		var year	= date.format ('Y');

		this.chart.set_subtitle('Tahun '+ year);

		this.store.load({
			scope		: this
		,	params		: {
				id_div			: m_charts_id_div
			,	id_dep			: 0
			,	id_dinas		: 0
			,	id_seksi		: 0
			,	id_area_seksi	: 0
			,	year			: year
			}
		});
	}
}

function M_ChartPerfByHour()
{
	this.store = new Ext.data.ArrayStore({
		fields		:[
			'id'
		,	'month'
		,	'n_safe'
		,	'n_unsafe'
		,	'safe_hour'
		,	'unsafe_hour'
		]
	,	url		: m_obs_lap_perf_d +'data_obs_hour_by_month.jsp'
	,	autoLoad	: false
	});

	this.chart = new M_ObsLapPerfChart(
					this.store
				,	'Grafik Safe/Unsafe per Hour'
				,	'month'
				,	'Bulan'
				,	'safe_hour'
				,	'unsafe_hour');

	this.do_refresh = function() {
		var date	= new Date();
		var year	= date.format ('Y');

		this.chart.set_subtitle('Tahun '+ year);

		this.store.load({
			scope		: this
		,	params		: {
				id_div			: m_charts_id_div
			,	id_dep			: 0
			,	id_dinas		: 0
			,	id_seksi		: 0
			,	id_area_seksi	: 0
			,	year			: year
			}
		});
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
		border		: true
	,	layout		: 'fit'
	,	items		: [
			this.chart
		]
	});

	this.do_refresh = function(ha_level) {
		var date	= new Date();
		var year	= date.format ('Y');
		var month	= date.format ('n');
		var i,m;

		this.chart.setSubTitle('Tahun '+ year);

		if (month < 3) {
			m = 1;
		} else {
			m = month - 2;
		}

		this.store.load({
			scope		: this
		,	params			: {
				year		: year
			,	month_start	: m
			,	month_end	: month
			,	id_div		: m_charts_id_div
			}
		});
	}
}

function M_ObsPartChart(title, xField, y1)
{
	this.record = new Ext.data.Record.create ([
		{name:'name'}
	,	{name:'target'}
	,	{name:'total_part'}
	,	{name:'target_percent'}
	,	{name:'total_part_percent'}
	]);

	this.store = new Ext.data.ArrayStore ({
		url		:m_obs_lap_part_d +'data_part_org2.jsp'
	,	fields	:this.record
	,	autoLoad:false
	});

	this.chart = new Ext.ux.HighChart({
		store		: this.store
	,	xField		: xField
	,	series		: [{
			name		: '% Partisipasi'
		,	dataIndex	: y1
		}]
	,	chartConfig	: {
			chart	: {
				defaultSeriesType : 'column'
			}
		,	title	: {
				text	: title
			}
		,	xAxis	: [{}]
		,	yAxis	: {
				title	: {
					text: '%'
				}
			}
		,	legend	: {
				display	: 'horizontal'
			}
		}
	});

	this.panel = new Ext.Panel({
		border	: true
	,	layout	: 'fit'
	,	items	:[
			this.chart
		]
	});

	this.do_load = function (id_dir, id_div, id_dep, id_dinas, id_seksi, id_wilayah
				, id_area, year, month, is_in_org)
	{
		var sub		= '';
		var record;
		var combo;

		sub += 'Tahun '+ year;

		if (month != 0) {
			sub += ', bulan '+ k3pl_months_wall[month][1];
		}

		this.chart.setSubTitle(sub);

		this.store.load({
			scope		: this
		,	params		: {
				is_in_org	: is_in_org
			,	id_dir		: id_dir
			,	id_div		: id_div
			,	id_dep		: id_dep
			,	id_dinas	: id_dinas
			,	id_seksi	: id_seksi
			,	id_wilayah	: id_wilayah
			,	id_area		: id_area
			,	year		: year
			,	month		: month
			}
		});
	}

	this.do_refresh = function ()
	{
		var d = new Date();

		this.do_load (0, m_charts_id_div, 0,0,0,0,0, d.format ('Y'), d.format ('n'), 1);
	}
}

function M_RCAPartChart(title, xField, y1)
{
	this.record = new Ext.data.Record.create ([
		{name:'name'}
	,	{name:'target'}
	,	{name:'total_part'}
	,	{name:'target_percent'}
	,	{name:'total_part_percent'}
	]);

	this.store = new Ext.data.ArrayStore ({
		url	:m_rca_lap_part_d +'data_part_org.jsp'
	,	fields	:this.record
	,	autoLoad:false
	});

	this.chart = new Ext.ux.HighChart({
		store		: this.store
	,	xField		: xField
	,	series		: [{
			name		: '% Partisipasi'
		,	dataIndex	: y1
		}]
	,	chartConfig	: {
			chart	: {
				defaultSeriesType : 'column'
			}
		,	title	: {
				text	: title
			}
		,	xAxis	: [{}]
		,	yAxis	: {
				title	: {
					text: '%'
				}
			}
		,	legend	: {
				display	: 'horizontal'
			}
		}
	});

	this.panel = new Ext.Panel({
		border	: true
	,	layout	: 'fit'
	,	items	:[
			this.chart
		]
	});

	this.do_load = function(id_dir, id_div, id_dep, id_dinas, id_seksi, id_wilayah
				, id_area, year, month, is_in_org)
	{
		var sub		= '';
		var record;
		var combo;

		sub += 'Tahun '+ year;

		if (month != 0) {
			sub += ', bulan '+ k3pl_months_wall[month][1];
		}

		this.chart.setSubTitle(sub);

		this.store.load({
			scope		: this
		,	params		: {
				is_in_org	: is_in_org
			,	id_dir		: id_dir
			,	id_div		: id_div
			,	id_dep		: id_dep
			,	id_dinas	: id_dinas
			,	id_seksi	: id_seksi
			,	id_wilayah	: id_wilayah
			,	id_area		: id_area
			,	year		: year
			,	month		: month
			}
		});
	}

	this.do_refresh = function()
	{
		var d = new Date();

		this.do_load(0, m_charts_id_div, 0,0,0,0,0, d.format ('Y'), d.format ('n'), 1);
	}
}

function M_Charts()
{
	this.perf_by_cat	= new M_ChartPerfByCategory();
	this.perf_by_index	= new M_ChartPerfByIndex();
	this.perf_by_hour	= new M_ChartPerfByHour();

	this.uk_chart_jka	= new M_LUKChart(
				'Grafik Jam Kerja Aman Kumulatif'
				, 'Jam Kerja'
				, m_luk_d +'data_jka.jsp'
				, 'column', false);

	this.uk_chart_ltif	= new M_LUKChart(
				'Grafik LTIF'
				, ''
				, m_luk_d +'data_ltif.jsp'
				, 'column', true);

	this.uk_chart_tsaf	= new M_LUKChart(
				'Grafik TSAF'
				, ''
				, m_luk_d +'data_tsaf.jsp'
				, 'column', true);

	this.stop_part		= new M_ObsPartChart(
				'Persentase Partisipasi Observasi'
				, 'name'
				, 'total_part_percent');

	this.rca_part		= new M_RCAPartChart(
				'Persentase Partisipasi RCA'
				, 'name'
				, 'total_part_percent');

	this.panel = new Ext.Panel({
			region				: 'center'
		,	layout				: 'card'
		,	margins				: '0'
		,	bodyBorder			: false
		,	activeItem			: m_charts_active
		,	cardSwitchAnimation	: 'slide'
		,	tbar				: []
		,	charts				: [
				this.stop_part
			,	this.rca_part
			,	this.perf_by_cat
			,	this.perf_by_index
			,	this.perf_by_hour
			,	this.uk_chart_jka
			,	this.uk_chart_ltif
			,	this.uk_chart_tsaf
			]
		,	items				: [
				this.stop_part.panel
			,	this.rca_part.panel
			,	this.perf_by_cat.chart.panel
			,	this.perf_by_index.chart.panel
			,	this.perf_by_hour.chart.panel
			,	this.uk_chart_jka.panel
			,	this.uk_chart_ltif.panel
			,	this.uk_chart_tsaf.panel
			]
	});

	this.stop_part.do_refresh();
}

function charts_do_refresh()
{
	if (m_charts == undefined) {
		return;
	}

	m_charts_active++;
	if (m_charts_active >= m_charts_n) {
		m_charts_active = 0;
	}

	m_charts.panel.charts[m_charts_active].do_refresh();
	m_charts.panel.layout.setActiveItem(m_charts_active);
}

function charts_start()
{
	m_charts_interval = self.setInterval('charts_do_refresh()', _g_chart_delay);
}

function charts_stop()
{
	window.clearInterval (m_charts_interval);
}

//@ sourceURL=charts.layout.js
