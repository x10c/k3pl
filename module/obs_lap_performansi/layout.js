/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_obs_lap_performansi;
var m_obs_lap_performansi_ha;
var m_obs_lap_performansi_d = _g_root +'/module/obs_lap_performansi/';

/*
 * Form Panel: display user interface to filter performance data.
 */
function M_ObsLapPerfForm(grid, displayBulan)
{
	this.id_dep			= 0;
	this.id_dinas		= 0;
	this.id_seksi		= 0;
	this.ref_grid		= grid;

	this.set_org = new k3pl.form.SetOrganisasi({
			itemAll		:true
		,	scope		:this
		,	onCheckClick	:function() {
				this.scope.set_checked()
			}
		});

	this.set_wil = new k3pl.form.SetWilayah({
			itemAll		:true
		,	scope		:this
		,	onCheckClick	:function() {
				this.scope.set_checked()
			}
		});

	this.set_waktu = new k3pl.form.SetWaktu({
			itemAll		:true
		,	displayBulan	:displayBulan
		});

	this.btn_submit = new Ext.Button({
		text		: 'OK'
	,	listeners	: {
			scope	: this
		,	click	: function(btn, e) {
				this.ref_grid.do_load(
						this.set_org.formDirektorat.getValue ()
					,	this.set_org.formDivProSBU.getValue ()
					,	this.set_org.formDepartemen.getValue()
					,	this.set_org.formDinas.getValue()
					,	this.set_org.formSeksi.getValue()
					,	this.set_wil.formWilayah.getValue()
					,	this.set_wil.formArea.getValue()
					,	this.set_waktu.formTahun.getValue()
					,	this.set_waktu.formBulan ? this.set_waktu.formBulan.getValue() : 0
					,	this.set_org.collapsed ? 0 : 1
				);
			}
		}
	});

	this.panel = new Ext.form.FormPanel({
		frame		: true
	,	width		: 500
	,	autoHeight	: true
	,	autoScroll	: true
	,	labelAlign	: 'right'
	,	labelWidth	: 150
	,	items		: [
			this.set_org
		,	this.set_wil
		,	this.set_waktu
		]
	,	buttonAlign	: 'center'
	,	buttons		: [
			this.btn_submit
		]
	});

	this.set_checked = function()
	{
		this.set_org.toggleCollapse(true);
		this.set_wil.toggleCollapse(true);
	}

	this.do_refresh = function()
	{
		this.set_org.do_load();
		this.set_wil.do_load();
		this.set_waktu.do_load();
	}
}

/*
 * Chart Panel: display custom chart based on different store.
 */
function M_ObsLapPerfChart(store, title, xField, xTitle, y1data, y1title
							, y2data, y2title, series_type)
{
	this.chart = new Ext.ux.HighChart({
		store		: store
	,	updateDelay	: 3
	,	xField		: xField
	,	series		: [{
			name		: y1title
		,	dataIndex	: y1data
		},{
			name		: y2title
		,	dataIndex	: y2data
		}]
	,	chartConfig	: {
			chart	: {
				defaultSeriesType : series_type
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
	,	items		: [
			this.chart
		]
	});

	this.do_refresh = function()
	{
		this.chart.refresh();
	}
}

/*
 * Grid panel: display performance data
 */
function M_ObsLapPerfByCategoryGrid()
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
	,	url			: m_obs_lap_performansi_d +'data_by_category.jsp'
	,	autoLoad	: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			{
				id			: 'obs_type_name'
			,	header		: 'Kategori'
			,	dataIndex	: 'obs_type_name'
			,	align		: 'left'
			,	xtype		: 'gridcolumn'
			,	summaryRenderer	: function() {
					return '<center><b>Total :</b></center>';
				}
			},{
				header		: 'Safe'
			,	dataIndex	: 'n_safe'
			,	summaryType	: 'sum'
			,	css		: 'background-color: #CBFFBB;'
			},{
				header		: 'Unsafe'
			,	dataIndex	: 'n_unsafe'
			,	summaryType	: 'sum'
			,	css		: 'background-color: #FFB5C1;'
			},{
				header		: '% Safe'
			,	dataIndex	: 'safe_percent'
			,	summaryType	: 'sum'
			,	format		: '000.00%'
			,	css		: 'background-color: #CBFFBB;'
			},{
				header		: '% Unsafe'
			,	dataIndex	: 'unsafe_percent'
			,	summaryType	: 'sum'
			,	format		: '000.00%'
			,	css		: 'background-color: #FFB5C1;'
			}
		]
	,	defaults	: {
			width		: 60
		,	align		: 'center'
		,	sortable	: true
		,	hideable	: false
		,	xtype		: 'numbercolumn'
		,	format		: '0000'
		}
	});

	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});

	this.panel = new Ext.grid.GridPanel({
		store		: this.store
	,	cm			: this.cm
	,	width		: 450
	,	autoExpandColumn: 'obs_type_name'
	,	autoHeight	: true
	,	autoScroll	: true
	,	plugins		: new Ext.ux.grid.GridSummary()
	,	tbar		: [ this.btn_print ]
	});

	this.do_print = function()
	{
		var url = _g_root +'/report';

		url	+= '?id=29';
		url	+= '&type=xls'
		url += '&id_dir='+ m_obs_lap_performansi.perf_by_cat.form.set_org.formDirektorat.getValue ();
		url += '&id_div='+ m_obs_lap_performansi.perf_by_cat.form.set_org.formDivProSBU.getValue ();
		url += '&id_dep='+ m_obs_lap_performansi.perf_by_cat.form.set_org.formDepartemen.getValue ();
		url += '&id_dinas='+ m_obs_lap_performansi.perf_by_cat.form.set_org.formDinas.getValue ();
		url += '&id_seksi='+ m_obs_lap_performansi.perf_by_cat.form.set_org.formSeksi.getValue ();
		url += '&id_wilayah='+ m_obs_lap_performansi.perf_by_cat.form.set_wil.formWilayah.getValue ();
		url += '&id_area='+ m_obs_lap_performansi.perf_by_cat.form.set_wil.formArea.getValue ();
		url += '&year='+ m_obs_lap_performansi.perf_by_cat.form.set_waktu.formTahun.getValue ();
		url += '&month='+ m_obs_lap_performansi.perf_by_cat.form.set_waktu.formBulan.getValue ();

		console.log (url);

		window.open (url, '_blank');
	}
	
	this.do_load = function(id_dir, id_div, id_dep, id_dinas, id_seksi, id_wilayah, id_area
							, year, month, is_in_org)
	{
		this.store.load({
			scope		: this
		,	params		: {
				id_dir		: id_dir
			,	id_div		: id_div
			,	id_dep		: id_dep
			,	id_dinas	: id_dinas
			,	id_seksi	: id_seksi
			,	id_wilayah	: id_wilayah
			,	id_area		: id_area
			,	year		: year
			,	month		: month
			,	is_in_org	: is_in_org
			}
		});
	}
}

function M_ObsLapPerfByCategory()
{
	this.grid	= new M_ObsLapPerfByCategoryGrid();
	this.form	= new M_ObsLapPerfForm(this.grid, true);
	this.chart	= new M_ObsLapPerfChart(
					this.grid.store
				,	'Grafik Performansi per Kategori'
				,	'obs_type_name'	,'Kategori'
				,	'safe_percent'	,'% Safe'
				,	'unsafe_percent','% Unsafe'
				,	'column');

	this.panel = new Ext.Panel({
		title		: 'Performansi per Kategori'
	,	padding		: '6'
	,	autoScroll	: true
	,	defaults	: {
			style		: {
				marginLeft	: 'auto'
			,	marginRight	: 'auto'
			,	marginBottom	: '8px'
			}
		}
	,	items		: [
			this.form.panel
		,	this.grid.panel
		,	this.chart.panel
		]
	});

	this.do_refresh = function()
	{
		this.form.do_refresh();
	}
}

function M_ObsLapPerfByIndexGrid()
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
	,	url		: m_obs_lap_performansi_d +'data_index_by_month.jsp'
	,	autoLoad	: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			{
				id		: 'month'
			,	header		: 'Bulan'
			,	dataIndex	: 'month'
			,	align		: 'left'
			,	xtype		: 'gridcolumn'
			,	summaryRenderer	: function() {
					return '<center><b>Total :</b></center>';
				}
			},{
				header		: 'Safe'
			,	dataIndex	: 'n_safe'
			,	summaryType	: 'sum'
			,	css		: 'background-color: #CBFFBB;'
			},{
				header		: 'Unsafe'
			,	dataIndex	: 'n_unsafe'
			,	summaryType	: 'sum'
			,	css		: 'background-color: #FFB5C1;'
			},{
				header		: 'Safe Index'
			,	dataIndex	: 'safe_index'
			,	summaryType	: 'sum'
			,	format		: '000.00%'
			,	css		: 'background-color: #CBFFBB;'
			},{
				header		: 'Unsafe Index'
			,	dataIndex	: 'unsafe_index'
			,	summaryType	: 'sum'
			,	format		: '000.00%'
			,	css		: 'background-color: #FFB5C1;'
			}
		]
	,	defaults	: {
			width		: 60
		,	align		: 'center'
		,	sortable	: true
		,	hideable	: false
		,	xtype		: 'numbercolumn'
		,	format		: '0000'
		}
	});

	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});

	this.panel = new Ext.grid.GridPanel({
		store		: this.store
	,	cm		: this.cm
	,	width		: 450
	,	autoExpandColumn: 'month'
	,	autoHeight	: true
	,	autoScroll	: true
	,	plugins		: new Ext.ux.grid.GridSummary()
	,	tbar		: [ this.btn_print ]
	});

	this.do_print = function()
	{
		var url = _g_root +'/report';

		url	+= '?id=30';
		url	+= '&type=xls'
		url += '&id_dir='+ m_obs_lap_performansi.perf_by_index.form.set_org.formDirektorat.getValue ();
		url += '&id_div='+ m_obs_lap_performansi.perf_by_index.form.set_org.formDivProSBU.getValue ();
		url += '&id_dep='+ m_obs_lap_performansi.perf_by_index.form.set_org.formDepartemen.getValue ();
		url += '&id_dinas='+ m_obs_lap_performansi.perf_by_index.form.set_org.formDinas.getValue ();
		url += '&id_seksi='+ m_obs_lap_performansi.perf_by_index.form.set_org.formSeksi.getValue ();
		url += '&id_wilayah='+ m_obs_lap_performansi.perf_by_index.form.set_wil.formWilayah.getValue ();
		url += '&id_area='+ m_obs_lap_performansi.perf_by_index.form.set_wil.formArea.getValue ();
		url += '&year='+ m_obs_lap_performansi.perf_by_index.form.set_waktu.formTahun.getValue ();

		window.open (url, '_blank');
	}
	
	this.do_load = function(id_dir, id_div, id_dep, id_dinas, id_seksi, id_wilayah, id_area
							, year, month, is_in_org)
	{
		this.store.load({
			scope		: this
		,	params		: {
				id_dir		: id_dir
			,	id_div		: id_div
			,	id_dep		: id_dep
			,	id_dinas	: id_dinas
			,	id_seksi	: id_seksi
			,	id_wilayah	: id_wilayah
			,	id_area		: id_area
			,	year		: year
			,	month		: month
			,	is_in_org	: is_in_org
			}
		});
	}
}

function M_ObsLapPerfByIndex()
{
	this.grid	= new M_ObsLapPerfByIndexGrid();
	this.form	= new M_ObsLapPerfForm(this.grid, false);
	this.chart	= new M_ObsLapPerfChart(
					this.grid.store
				,	'Grafik Safe/Unsafe Index'
				,	'month'			,'Bulan'
				,	'safe_index'	,'% Safe'
				,	'unsafe_index'	,'% Unsafe'
				,	'line');

	this.panel = new Ext.Panel({
		title		: 'Safe/Unsafe Index'
	,	padding		: '6'
	,	autoScroll	: true
	,	defaults	: {
			style		: {
				marginLeft	: 'auto'
			,	marginRight	: 'auto'
			,	marginBottom	: '8px'
			}
		}
	,	items		: [
			this.form.panel
		,	this.grid.panel
		,	this.chart.panel
		]
	});

	this.do_refresh = function()
	{
		this.form.do_refresh();
		this.chart.do_refresh();
	}
}

function M_ObsLapPerfByHourGrid()
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
	,	url		: m_obs_lap_performansi_d +'data_obs_hour_by_month.jsp'
	,	autoLoad	: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			{
				id		: 'month'
			,	header		: 'Bulan'
			,	dataIndex	: 'month'
			,	align		: 'left'
			,	xtype		: 'gridcolumn'
			,	summaryRenderer	: function() {
					return '<center><b>Total :</b></center>';
				}
			},{
				header		: 'Safe'
			,	dataIndex	: 'n_safe'
			,	summaryType	: 'sum'
			,	css		: 'background-color: #CBFFBB;'
			},{
				header		: 'Unsafe'
			,	dataIndex	: 'n_unsafe'
			,	summaryType	: 'sum'
			,	css		: 'background-color: #FFB5C1;'
			},{
				header		: 'Safe Act per Hour'
			,	dataIndex	: 'safe_hour'
			,	summaryType	: 'sum'
			,	format		: '000.00'
			,	css		: 'background-color: #CBFFBB;'
			},{
				header		: 'Unsafe Act per Hour'
			,	dataIndex	: 'unsafe_hour'
			,	summaryType	: 'sum'
			,	format		: '000.00'
			,	css		: 'background-color: #FFB5C1;'
			}
		]
	,	defaults	: {
			width		: 60
		,	align		: 'center'
		,	sortable	: true
		,	hideable	: false
		,	xtype		: 'numbercolumn'
		,	format		: '0000'
		}
	});

	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});

	this.panel = new Ext.grid.GridPanel({
		store		: this.store
	,	cm		: this.cm
	,	width		: 450
	,	autoExpandColumn: 'month'
	,	autoHeight	: true
	,	autoScroll	: true
	,	plugins		: new Ext.ux.grid.GridSummary()
	,	tbar		: [ this.btn_print ]
	});

	this.do_print = function()
	{
		var url	= _g_root +'/report';

		url += '?id=31';
		url += '&type=xls'
		url += '&id_dir='+ m_obs_lap_performansi.perf_by_hour.form.set_org.formDirektorat.getValue ();
		url += '&id_div='+ m_obs_lap_performansi.perf_by_hour.form.set_org.formDivProSBU.getValue ();
		url += '&id_dep='+ m_obs_lap_performansi.perf_by_hour.form.set_org.formDepartemen.getValue ();
		url += '&id_dinas='+ m_obs_lap_performansi.perf_by_hour.form.set_org.formDinas.getValue ();
		url += '&id_seksi='+ m_obs_lap_performansi.perf_by_hour.form.set_org.formSeksi.getValue ();
		url += '&id_wilayah='+ m_obs_lap_performansi.perf_by_hour.form.set_wil.formWilayah.getValue ();
		url += '&id_area='+ m_obs_lap_performansi.perf_by_hour.form.set_wil.formArea.getValue ();
		url += '&year='+ m_obs_lap_performansi.perf_by_hour.form.set_waktu.formTahun.getValue ();

		window.open (url, '_blank');
	}
	
	this.do_load = function(id_dir, id_div, id_dep, id_dinas, id_seksi, id_wilayah, id_area
							, year, month, is_in_org)
	{
		this.store.load({
			scope		: this
		,	params		: {
				id_dir		: id_dir
			,	id_div		: id_div
			,	id_dep		: id_dep
			,	id_dinas	: id_dinas
			,	id_seksi	: id_seksi
			,	id_wilayah	: id_wilayah
			,	id_area		: id_area
			,	year		: year
			,	month		: month
			,	is_in_org	: is_in_org
			}
		});
	}
}

function M_ObsLapPerfByHour()
{
	this.grid = new M_ObsLapPerfByHourGrid();
	this.form = new M_ObsLapPerfForm(this.grid, false);
	this.chart= new M_ObsLapPerfChart(
					this.grid.store
				,	'Grafik Safe/Unsafe per Hour'
				,	'month'			,	'Bulan'
				,	'safe_hour'		,	'Safe'
				,	'unsafe_hour'	,	'Unsafe'
				,	'line');


	this.panel = new Ext.Panel({
		title		: 'Safe/Unsafe Observasi per Hour'
	,	padding		: '6'
	,	autoScroll	: true
	,	defaults	: {
			style		: {
				marginLeft	: 'auto'
			,	marginRight	: 'auto'
			,	marginBottom	: '8px'
			}
		}
	,	items		: [
			this.form.panel
		,	this.grid.panel
		,	this.chart.panel
		]
	});

	this.do_refresh = function()
	{
		this.form.do_refresh();
		this.chart.do_refresh();
	}
}

function M_ObsLapSTOPGrid()
{
	this.store = new Ext.data.ArrayStore({
			fields	: [
				'item'
			,	'total_part_percent'
			,	'unsafe_act_index'
			,	'unsafe_act_hour'
			]
		,	url		: m_obs_lap_performansi_d +'data_performance.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		: 'ITEM'
		,	dataIndex	: 'item'
		,	align		: 'left'
		,	width		: 200
		,	css			: 'font-weight: bold;'
		},{
			header		: '% Partisipasi'
		,	dataIndex	: 'total_part_percent'
		,	format		: '000.00%'
		,	css			: 'background-color: #f0f0f0;'
		},{
			header		: 'Unsafe Act Index'
		,	format		: '000.00%'
		,	dataIndex	: 'unsafe_act_index'
		},{
			header		: 'Unsafe Act Observation per Hour'
		,	dataIndex	: 'unsafe_act_hour'
		,	css			: 'background-color: #f0f0f0;'
		}]
	,	defaults : {
			width		: 40
		,	align		: 'center'
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});

	this.panel = new Ext.grid.GridPanel({
		title				: 'Tabel Observasi'
	,	store				: this.store
	,	cm					: this.cm
	,	autoHeight			: true
	,	autoScroll			: true
	,	autoExpandColumn	: 'item'
	,	viewConfig			: {forceFit: true}
	,	tbar				: [ this.btn_print ]
	});

	this.do_print = function()
	{
		var url = _g_root +'/report';

		url	+= '?id=32';
		url	+= '&type=xls'
		url += '&id_dir='+ m_obs_lap_performansi.perf_stop.form.set_org.formDirektorat.getValue ();
		url += '&id_div='+ m_obs_lap_performansi.perf_stop.form.set_org.formDivProSBU.getValue ();
		url += '&id_dep='+ m_obs_lap_performansi.perf_stop.form.set_org.formDepartemen.getValue ();
		url += '&id_dinas='+ m_obs_lap_performansi.perf_stop.form.set_org.formDinas.getValue ();
		url += '&id_seksi='+ m_obs_lap_performansi.perf_stop.form.set_org.formSeksi.getValue ();
		url += '&id_wilayah='+ m_obs_lap_performansi.perf_stop.form.set_wil.formWilayah.getValue ();
		url += '&id_area='+ m_obs_lap_performansi.perf_stop.form.set_wil.formArea.getValue ();
		url += '&year='+ m_obs_lap_performansi.perf_stop.form.set_waktu.formTahun.getValue ();
		url += '&month='+ m_obs_lap_performansi.perf_stop.form.set_waktu.formBulan.getValue ();

		window.open (url, '_blank');
	}
	
	this.do_load = function(id_dir, id_div, id_dep, id_dinas, id_seksi, id_wilayah, id_area
							, year, month, is_in_org)
	{
		this.store.load({
			scope		: this
		,	params		: {
				id_dir		: id_dir
			,	id_div		: id_div
			,	id_dep		: id_dep
			,	id_dinas	: id_dinas
			,	id_seksi	: id_seksi
			,	id_wilayah	: id_wilayah
			,	id_area		: id_area
			,	year		: year
			,	month		: month
			,	is_in_org	: is_in_org
			}
		});
	}
}

function M_ObsLapSTOP()
{
	this.grid		= new M_ObsLapSTOPGrid();
	this.form		= new M_ObsLapPerfForm(this.grid, true);
	this.chart		= new M_ObsLapPerfChart(
									this.grid.store
								,	'Grafik Performansi Observasi'
								,	'item'				,	''
								,	'total_part_percent',	'% Partisipasi'
								,	'unsafe_act_index'	,	'Unsafe Act per Hour'
								,	'column');

	this.panel = new Ext.Panel({
		title		: 'Laporan Performansi Observasi'
	,	padding		: '6'
	,	autoScroll	: true
	,	defaults	: {
			style		: {
				marginLeft	: 'auto'
			,	marginRight	: 'auto'
			,	marginBottom	: '8px'
			}
		}
	,	items		: [
			this.form.panel
		,	this.grid.panel
		,	this.chart.panel
		]
	});

	this.do_proses = function(year, month)
	{
		this.grid.do_refresh(year, month);
		this.chart.do_refresh(year, month);
	}

	this.do_refresh = function()
	{
		this.form.do_refresh();
	}
}

function M_ObsLapPerformansi()
{
	this.perf_by_cat	= new M_ObsLapPerfByCategory();
	this.perf_by_index	= new M_ObsLapPerfByIndex();
	this.perf_by_hour	= new M_ObsLapPerfByHour();
	this.perf_stop		= new M_ObsLapSTOP();

	this.panel = new Ext.TabPanel({
		id			: 'obs_lap_performansi_panel'
	,	activeItem	: 0
	,	items		: [
			this.perf_by_cat.panel
		,	this.perf_by_index.panel
		,	this.perf_by_hour.panel
		,	this.perf_stop.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		if (m_obs_lap_performansi_ha < 1) {
			Ext.MessageBox.alert('Hak Akses'
			, 'Maaf, Anda tidak memiliki hak akses untuk Laporan Performansi Observasi!');
			this.panel.setDisabled(true);
			return;
		}

		m_obs_lap_performansi_ha = ha_level;

		this.panel.setDisabled(false);

		this.perf_by_cat.do_refresh();
		this.perf_by_index.do_refresh();
		this.perf_by_hour.do_refresh();
		this.perf_stop.do_refresh();
	}
}

m_obs_lap_performansi = new M_ObsLapPerformansi();

//@ sourceURL=obs_lap_performansi.layout.js
