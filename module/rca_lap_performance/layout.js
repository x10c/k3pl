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
							, y2data, y2title, y3data, y3title, y4data, y4title, series_type)
{
	this.chart = new Ext.ux.HighChart({
		store		: store
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
		},{
			name		: y4title
		,	dataIndex	: y4data
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
			,	max		: 100
			}
		,	legend	: {
				display	: 'horizontal'
			}
		}
	});

	this.panel = new Ext.Panel({
		border		: true
	,	autoWidth	:true
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
	this.store = new Ext.data.JsonStore({
			fields	: [
				'item'
			,	'partisipan'
			,	'total_part_percent'
			,	'violation'
			,	'temuan'
			,	'severity'
			,	'jml_tl_temuan'
			,	'tl_temuan'
			,	'jml_tl_temuan_non'
			,	'tl_temuan_non'
			,	'avg'
			]
		,	url		: m_rca_lap_performance_d +'data.jsp'
		,	autoLoad: false
		,	root	:'data'
	});

	this.cm = new Ext.grid.ColumnModel({
		defaults	: {
			align		: 'center'
		}
	,	columns	: [
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
			header		: 'Jml Tindak Lanjut Temuan Non 4/5'
		,	dataIndex	: 'jml_tl_temuan_non'
		},{
			header		: '% Tindak Lanjut Temuan Non 4/5'
		,	dataIndex	: 'tl_temuan_non'
		,	format		: '000.00%'
		,	css			: 'background-color: #f0f0f0;'
		},{
			header		: 'Average Of Severity'
		,	dataIndex	: 'avg'
		}]
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
			title				: 'RCA Tabel'
		,	store				: this.store
		,	cm					: this.cm
		,	autoHeight			: true
		,	tbar				: [ this.btn_print]
	});

	this.do_print = function()
	{
		var form;
		var id_report	= '26';
		var tipe_report	= 'xls';
		var isinorg		= m_rca_lap_performance.form.set_org.isChecked();
		
		if (isinorg){
			is_in_org	= '1'
		} else {
			is_in_org	= '0'
		}
		
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
		hiddenField3.setAttribute('name', 'is_in_org');
        hiddenField3.setAttribute('value', is_in_org);
		
		var hiddenField4 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField4.setAttribute('name', 'id_dir');
        hiddenField4.setAttribute('value', m_rca_lap_performance.form.set_org.formDirektorat.getValue ());
		
		var hiddenField5 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField5.setAttribute('name', 'id_div');
        hiddenField5.setAttribute('value', m_rca_lap_performance.form.set_org.formDivProSBU.getValue ());
		
		var hiddenField6 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField6.setAttribute('name', 'id_dep');
        hiddenField6.setAttribute('value', m_rca_lap_performance.form.set_org.formDepartemen.getValue());
		
		var hiddenField7 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField7.setAttribute('name', 'id_dinas');
        hiddenField7.setAttribute('value', m_rca_lap_performance.form.set_org.formDinas.getValue());
		
		var hiddenField8 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField8.setAttribute('name', 'id_seksi');
        hiddenField8.setAttribute('value', m_rca_lap_performance.form.set_org.formSeksi.getValue());
		
		var hiddenField9 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField9.setAttribute('name', 'id_wilayah');
        hiddenField9.setAttribute('value', m_rca_lap_performance.form.set_wil.formWilayah.getValue());
		
		var hiddenField10 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField10.setAttribute('name', 'id_area');
        hiddenField10.setAttribute('value', m_rca_lap_performance.form.set_wil.formArea.getValue());
		
		var hiddenField11 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField11.setAttribute('name', 'year');
        hiddenField11.setAttribute('value', m_rca_lap_performance.form.set_waktu.formTahun.getValue());
		
		var hiddenField12 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField12.setAttribute('name', 'month');
        hiddenField12.setAttribute('value', m_rca_lap_performance.form.set_waktu.formBulan.getValue());
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
		form.appendChild(hiddenField4);
		form.appendChild(hiddenField5);
		form.appendChild(hiddenField6);
		form.appendChild(hiddenField7);
		form.appendChild(hiddenField8);
		form.appendChild(hiddenField9);
		form.appendChild(hiddenField10);
		form.appendChild(hiddenField11);
		form.appendChild(hiddenField12);
		document.body.appendChild(form);
		form.submit();
	}
}

function M_RCALapperformance()
{
	this.grid		= new M_RCALapRCAGrid();
	this.form		= new M_RCALapPerfForm(this, true);
	this.chart		= new M_RCALapPerfChart(
									this.grid.store
								,	'Grafik Performance RCA'
								,	'item'				,	''
								,	'total_part_percent',	'% Partisipasi'
								,	'severity'			,	'% Severity 4/5'
								,	'tl_temuan'			,	'% Tindak Lanjut Temuan 4/5'
								,	'tl_temuan_non'		,	'% Tindak Lanjut Temuan Non 4/5'
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

	this.do_load = function(id_dir, id_div, id_dep, id_dinas, id_seksi, id_wilayah, id_area
							, year, month, is_in_org)
	{
		var sub		= '';
		var record;
		var combo;

		if (is_in_org) {
			if (id_seksi != 0) {
				combo	= this.form.set_org.formSeksi;
				record	= combo.findRecord(combo.valueField, id_seksi);
				sub	= 'Seksi '+ record.get(combo.displayField);
			} else if (id_dinas != 0) {
				combo	= this.form.set_org.formDinas;
				record	= combo.findRecord(combo.valueField, id_dinas);
				sub	= 'Dinas '+ record.get(combo.displayField);
			} else if (id_dep != 0) {
				combo	= this.form.set_org.formDepartemen;
				record	= combo.findRecord(combo.valueField, id_dep);
				sub	= 'Departemen '+ record.get(combo.displayField);
			} else if (id_div != 0) {
				combo	= this.form.set_org.formDivProSBU;
				record	= combo.findRecord (combo.valueField, id_div);
				sub		= 'Divisi/Proyek/SBU '+ record.get (combo.displayField);
			} else if (id_dir != 0) {
				combo	= this.form.set_org.formDirektorat;
				record	= combo.findRecord (combo.valueField, id_dir);
				sub		= record.get (combo.displayField);
			}
		} else {
			if (id_area != 0) {
				combo	= this.form.set_wil.formArea;
				record	= combo.findRecord(combo.valueField, id_area);
				sub	= 'Area '+ record.get(combo.displayField);
			} else if (id_wilayah != 0) {
				combo	= this.form.set_wil.formWilayah;
				record	= combo.findRecord(combo.valueField, id_wilayah);
				sub	= 'Wilayah '+ record.get(combo.displayField);
			}
		}

		if (month != 0) {
			combo	= this.form.set_waktu.formBulan;
			record	= combo.findRecord(combo.valueField, month);
			sub	+= ' - '+ record.get(combo.displayField);
		} else if (sub != '') {
			sub += ' - ';
		}

		sub += ' '+ year;

		this.chart.chart.setSubTitle(sub);
		
		this.grid.store.load({
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
