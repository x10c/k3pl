/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_rca_grafik_performance;
var m_rca_graf_perf_d	= _g_root +'/module/rca_grafik_performance/';

function M_RCAGrafikPerformancePartisipasi()
{
	this.fields = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'name'}
		,	{name:'penjualan_dan_layanan'}
		,	{name:'operasi_dan_pemeliharaan'}
		,	{name:'integritas_jaringan_dan_k3pl'}
		,	{name:'enjiniring_dan_pembangunan'}
		,	{name:'keuangan_dan_sdm'}
		,	{name:'logistik_dan_administrasi_umum'}
		,	{name:'total'}
	]);

	this.reader = new Ext.data.JsonReader(
		{}
		, this.fields
	);

	this.store = new Ext.data.Store({
			url			: m_rca_graf_perf_d + 'data_partisipasi.jsp'
		,	reader		: this.reader
		,	autoLoad	: false
	});

	this.chart = new Ext.ux.HighChart({
			store		: this.store
		,	xField		: 'name'
		,	series		: [{
				name		: 'Penjualan dan Layanan'
			,	dataIndex	: 'penjualan_dan_layanan'
			},{
				name		: 'Operasi dan Pemeliharaan'
			,	dataIndex	: 'operasi_dan_pemeliharaan'
			},{
				name		: 'Integritas Jaringan dan K3pl'
			,	dataIndex	: 'integritas_jaringan_dan_k3pl'
			},{
				name		: 'Enjiniring dan Pembangunan'
			,	dataIndex	: 'enjiniring_dan_pembangunan'
			},{
				name		: 'Keuangan dan SDM'
			,	dataIndex	: 'keuangan_dan_sdm'
			},{
				name		: 'Logistik dan Administrasi Umum'
			,	dataIndex	: 'logistik_dan_administrasi_umum'
			},{
				name		: 'Total SBU 1'
			,	dataIndex	: 'total'
			}]
		,	chartConfig	: {
				chart	: {
					defaultSeriesType: 'line'
				}
			,	title	: {
					text: 'Grafik Partisipasi RCA'
				}
			,	subtitle: {
					text: '3 Bulan Terakhir'
				}
			,	xAxis	: [{}]
			,	yAxis	: {
					title: {
						text: '%'
					}
				,	min		: 0
				,	max		: 100
				}
			,	legend		: {
					layout			: 'horizontal'
				}
			,	tooltip	: {
					formatter: function() {
						return '<b>'+ this.x +'</b><br/>' + this.series.name + ': ' + this.y + '%';
					}
				}
			}
	});

	this.panel = new Ext.Panel({
		title		:'Partisipasi'
	,	border		: true
	,	layout		: 'fit'
	,	items		: [
			this.chart
		]
	});

	this.do_refresh = function(ha_level) {
		var date	= new Date();
		var year	= 1900 + (date.getYear());
		var month	= 1 + date.getMonth();
		var i,m;

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
			}
		});
	}
}

function M_RCAGrafikPerformanceSeverity()
{
	this.fields = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'name'}
		,	{name:'penjualan_dan_layanan'}
		,	{name:'operasi_dan_pemeliharaan'}
		,	{name:'integritas_jaringan_dan_k3pl'}
		,	{name:'enjiniring_dan_pembangunan'}
		,	{name:'keuangan_dan_sdm'}
		,	{name:'logistik_dan_administrasi_umum'}
		,	{name:'total'}
	]);

	this.reader = new Ext.data.JsonReader(
		{}
		, this.fields
	);

	this.store = new Ext.data.Store({
			url			: m_rca_graf_perf_d + 'data_severity.jsp'
		,	reader		: this.reader
		,	autoLoad	: false
	});

	this.chart = new Ext.ux.HighChart({
			store		: this.store
		,	xField		: 'name'
		,	series		: [{
				name		: 'Penjualan dan Layanan'
			,	dataIndex	: 'penjualan_dan_layanan'
			},{
				name		: 'Operasi dan Pemeliharaan'
			,	dataIndex	: 'operasi_dan_pemeliharaan'
			},{
				name		: 'Integritas Jaringan dan K3pl'
			,	dataIndex	: 'integritas_jaringan_dan_k3pl'
			},{
				name		: 'Enjiniring dan Pembangunan'
			,	dataIndex	: 'enjiniring_dan_pembangunan'
			},{
				name		: 'Keuangan dan SDM'
			,	dataIndex	: 'keuangan_dan_sdm'
			},{
				name		: 'Logistik dan Administrasi Umum'
			,	dataIndex	: 'logistik_dan_administrasi_umum'
			},{
				name		: 'Total SBU 1'
			,	dataIndex	: 'total'
			}]
		,	chartConfig	: {
				chart	: {
					defaultSeriesType: 'line'
				}
			,	title	: {
					text: 'Grafik Severity 4/5 RCA'
				}
			,	subtitle: {
					text: '3 Bulan Terakhir'
				}
			,	xAxis	: [{}]
			,	yAxis	: {
					title: {
						text: '%'
					}
				,	min		: 0
				,	max		: 100
				}
			,	legend		: {
					layout			: 'horizontal'
				}
			,	tooltip	: {
					formatter: function() {
						return '<b>'+ this.x +'</b><br/>' + this.series.name + ': ' + this.y + '%';
					}
				}
			}
	});

	this.panel = new Ext.Panel({
		title		:'Severity 4/5'
	,	border		: true
	,	layout		: 'fit'
	,	items		: [
			this.chart
		]
	});

	this.do_refresh = function(ha_level) {
		var date	= new Date();
		var year	= 1900 + (date.getYear());
		var month	= 1 + date.getMonth();
		var i,m;

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
			}
		});
	}
}

function M_RCAGrafikPerformanceTindakLanjut()
{
	this.fields = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'name'}
		,	{name:'penjualan_dan_layanan'}
		,	{name:'operasi_dan_pemeliharaan'}
		,	{name:'integritas_jaringan_dan_k3pl'}
		,	{name:'enjiniring_dan_pembangunan'}
		,	{name:'keuangan_dan_sdm'}
		,	{name:'logistik_dan_administrasi_umum'}
		,	{name:'total'}
	]);

	this.reader = new Ext.data.JsonReader(
		{}
		, this.fields
	);

	this.store = new Ext.data.Store({
			url			: m_rca_graf_perf_d + 'data_tindak_lanjut_temuan.jsp'
		,	reader		: this.reader
		,	autoLoad	: false
	});

	this.chart = new Ext.ux.HighChart({
			store		: this.store
		,	xField		: 'name'
		,	series		: [{
				name		: 'Penjualan dan Layanan'
			,	dataIndex	: 'penjualan_dan_layanan'
			},{
				name		: 'Operasi dan Pemeliharaan'
			,	dataIndex	: 'operasi_dan_pemeliharaan'
			},{
				name		: 'Integritas Jaringan dan K3pl'
			,	dataIndex	: 'integritas_jaringan_dan_k3pl'
			},{
				name		: 'Enjiniring dan Pembangunan'
			,	dataIndex	: 'enjiniring_dan_pembangunan'
			},{
				name		: 'Keuangan dan SDM'
			,	dataIndex	: 'keuangan_dan_sdm'
			},{
				name		: 'Logistik dan Administrasi Umum'
			,	dataIndex	: 'logistik_dan_administrasi_umum'
			},{
				name		: 'Total SBU 1'
			,	dataIndex	: 'total'
			}]
		,	chartConfig	: {
				chart	: {
					defaultSeriesType: 'line'
				}
			,	title	: {
					text: 'Grafik Tindak Lanjut Temuan 4/5 RCA'
				}
			,	subtitle: {
					text: '3 Bulan Terakhir'
				}
			,	xAxis	: [{}]
			,	yAxis	: {
					title: {
						text: '%'
					}
				,	min		: 0
				,	max		: 100
				}
			,	legend		: {
					layout			: 'horizontal'
				}
			,	tooltip	: {
					formatter: function() {
						return '<b>'+ this.x +'</b><br/>' + this.series.name + ': ' + this.y + '%';
					}
				}
			}
	});

	this.panel = new Ext.Panel({
		title		:'Tindak Lanjut Temuan 4/5'
	,	border		: true
	,	layout		: 'fit'
	,	items		: [
			this.chart
		]
	});

	this.do_refresh = function(ha_level) {
		var date	= new Date();
		var year	= 1900 + (date.getYear());
		var month	= 1 + date.getMonth();
		var i,m;

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
			}
		});
	}
}

function M_RCAGrafikPerformance()
{
	this.graf_perf_partisipasi 		= new M_RCAGrafikPerformancePartisipasi();
	this.graf_perf_severity 		= new M_RCAGrafikPerformanceSeverity();
	this.graf_perf_tindak_lanjut 	= new M_RCAGrafikPerformanceTindakLanjut();

	this.panel = new Ext.TabPanel({
		id			: 'rca_grafik_performance_panel'
	,	activeTab	: 0
	,	frame		: false
	,	items		: [
			this.graf_perf_partisipasi.panel
		,	this.graf_perf_severity.panel
		,	this.graf_perf_tindak_lanjut.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		this.graf_perf_partisipasi.do_refresh(ha_level);
		this.graf_perf_severity.do_refresh(ha_level);
		this.graf_perf_tindak_lanjut.do_refresh(ha_level);
	}
}

m_rca_grafik_performance = new M_RCAGrafikPerformance()

//@ sourceURL=rca_grafik_performance.layout.js
