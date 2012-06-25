/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_rca_lap_performance;
var m_rca_lap_performance_ha;
var m_rca_lap_performance_d = _g_root +'/module/rca_lap_performance/';

/*
 * Form Panel: display user interface to filter performance data.
 */
function M_RCALapPerfForm(grid, displayBulan)
{
	this.id_dir		= 0;
	this.id_div		= 0;
	this.id_dep		= 0;
	this.id_dinas	= 0;
	this.id_seksi	= 0;
	this.ref_grid	= grid;

	this.set_org = new k3pl.form.SetOrganisasi({
			itemAll			: true
		,	scope			: this
		,	onCheckClick	: function() {
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
						this.set_org.formDirektorat.getValue()
					,	this.set_org.formDivProSBU.getValue()
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
function M_RCALapPerfChart(store, title, xField, xTitle, y1data, y1title
							, y2data, y2title, y3data, y3title, series_type)
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
		},{
			name		: y3title
		,	dataIndex	: y3data
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

function M_RCALapRCAGrid()
{
	this.store = new Ext.data.ArrayStore({
			fields	: [
				'item'
			,	'partisipan'
			,	'total_part_percent'
			,	'violation'
			,	'temuan'
			,	'severity'
			,	'jml_tl_temuan'
			,	'tl_temuan'
			,	'avg'
			]
		,	url		: m_rca_lap_performance_d +'data.jsp'
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
			header		: 'Partisipan'
		,	dataIndex	: 'partisipan'
		,	css			: 'background-color: #f0f0f0;'
		},{
			header		: '% Partisipasi'
		,	dataIndex	: 'total_part_percent'
		,	format		: '000.00%'
		},{
			header		: 'Violation'
		,	dataIndex	: 'violation'
		,	css			: 'background-color: #f0f0f0;'
		},{
			header		: 'Temuan Kumulatif 4/5'
		,	dataIndex	: 'temuan'
		},{
			header		: '% Severity 4/5'
		,	dataIndex	: 'severity'
		,	format		: '000.00%'
		,	css			: 'background-color: #f0f0f0;'
		},{
			header		: 'Jml Tindak Lanjut Temuan 4/5'
		,	dataIndex	: 'jml_tl_temuan'
		},{
			header		: '% Tindak Lanjut Temuan 4/5'
		,	dataIndex	: 'tl_temuan'
		,	format		: '000.00%'
		,	css			: 'background-color: #f0f0f0;'
		},{
			header		: 'Average Of Severity'
		,	dataIndex	: 'avg'
		}]
	,	defaults : {
			width		: 40
		,	align		: 'center'
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.panel = new Ext.grid.GridPanel({
		title				: 'RCA Tabel'
	,	store				: this.store
	,	cm					: this.cm
	,	autoHeight			: true
	,	autoScroll			: true
	,	autoExpandColumn	: 'item'
	,	viewConfig			: {forceFit: true}
	,	tbar		: [
			{
				xtype	: 'exportbutton'
			,	store	: this.store
			}
		]
	});

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

function M_RCALapperformance()
{
	this.grid		= new M_RCALapRCAGrid();
	this.form		= new M_RCALapPerfForm(this.grid, true);
	this.chart		= new M_RCALapPerfChart(
									this.grid.store
								,	'Grafik Performance RCA'
								,	'item'				,	''
								,	'total_part_percent',	'% Partisipasi'
								,	'severity'			,	'% Severity 4/5'
								,	'tl_temuan'			,	'% Tindak Lanjut Temuan 4/5'
								,	'column');

	this.panel = new Ext.Panel({
		id			: 'rca_lap_performance_panel'
	,	title		: 'Laporan Performance RCA'
	,	padding		: '6'
	,	autoScroll	: true
	,	defaults	: {
			style		: {
				marginLeft		: 'auto'
			,	marginRight		: 'auto'
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

	this.do_refresh = function(ha_level)
	{
		m_rca_lap_performance_ha = ha_level;

		if (m_rca_lap_performance_ha < 1) {
			Ext.MessageBox.alert('Hak Akses'
			, 'Maaf, Anda tidak memiliki hak akses untuk Data Performance RCA!');
			this.panel.setDisabled(true);
			return;
		}

		this.panel.setDisabled(false);

		this.form.do_refresh();
	}	
}

m_rca_lap_performance = new M_RCALapperformance();

//@ sourceURL=rca_lap_performance.layout.js
