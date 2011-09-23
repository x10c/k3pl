/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
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
                                layout	: 'horizontal'
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
			params	: { year: this.form_year.getValue() }
		});

		this.chart.setSubTitle('Tahun '+ this.form_year.getValue());
	}

	this.do_refresh = function(ha_level)
	{
		this.form_year.setValue(this.form_year.store.getAt(0).get('year'));
		this.do_load();
	}
}

function M_LUKAll()
{
	this.uk			= new M_LUK();
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

	this.panel = new Ext.TabPanel({
		id		: 'luk_lap_unjuk_kerja_panel'
	,	activeTab	: 0
	,	items		: [
			this.uk.panel
		,	this.uk_chart_jka.panel
		,	this.uk_chart_ltif.panel
		,	this.uk_chart_tsaf.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		this.uk.do_refresh(ha_level);
		this.uk_chart_jka.do_refresh(ha_level);
		this.uk_chart_ltif.do_refresh(ha_level);
		this.uk_chart_tsaf.do_refresh(ha_level);
	}
}

m_luk_lap_unjuk_kerja = new M_LUKAll();

//@ sourceURL=luk_lap_unjuk_kerja.layout.js
