/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_rca_lap_severity;
var m_rca_lap_severity_d = _g_root +'/module/rca_lap_severity/';
var m_rca_lap_severity_month = ''

function M_RCALapSeverity()
{
	this.ha_level		= 0;
	this.id_direktorat	= '0';
	this.id_divprosbu	= '0';
	this.id_departemen	= '0';
	this.id_dinas		= '0';
	this.id_seksi		= '0';

	this.store_month = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [[1,'Januari'],
					   [2,'Februari'],
					   [3,'Maret'],
					   [4,'April'],
					   [5,'Mei'],
					   [6,'Juni'],
					   [7,'Juli'],
					   [8,'Agustus'],
					   [9,'September'],
					   [10,'Oktober'],
					   [11,'November'],
					   [12,'Desember']]
	});

	this.form_month = new Ext.form.ComboBox({
			store			: this.store_month
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					m_rca_lap_severity_month = record.get('name');
				}
			}
	});

	this.form_month.setValue(this.store_month.getAt(0).data['id']);		

	this.form_month_label = new Ext.form.Label({
		html	: '&nbsp;&nbsp;Bulan :&nbsp;&nbsp;'
	});
	
	this.get_form_year_data = function()
	{
		var d		= new Date();
		var cur_year	= d.getFullYear();
		var years	= '[["'+ cur_year +'"]';

		for(var i=1; i<=10; i++) {
			years += ',["'+ (cur_year - i) +'"]';
		}

		years += ']';

		return Ext.util.JSON.decode(years);
	}

	this.store_year = new Ext.data.ArrayStore({
			fields	: ['year']
		,	data	: this.get_form_year_data()
	});

	this.form_year = new Ext.form.ComboBox({
			store			: this.store_year
		,	valueField		: 'year'
		,	displayField	: 'year'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
	});

	this.form_year.setValue(this.store_year.getAt(0).data['year']);

	this.form_year_label = new Ext.form.Label({
		html	: '&nbsp;&nbsp;Tahun :&nbsp;&nbsp;'
	});
	
	this.record = new Ext.data.Record.create([
			{ name: 'description' }
		,	{ name: 'id_severity' }
		,	{ name: 'nama_tempat_rca' }
		,	{ name: 'penanggung_jawab_seksi' }
		,	{ name: 'nama_seksi' }
		,	{ name: 'penanggung_jawab_dinas' }
		,	{ name: 'nama_dinas' }
		,	{ name: 'penanggung_jawab_departemen' }
		,	{ name: 'nama_departemen' }
		,	{ name: 'penanggung_jawab_divprosbu' }
		,	{ name: 'nama_divprosbu' }
		,	{ name: 'penanggung_jawab_direktorat' }
		,	{ name: 'nama_direktorat' }
		,	{ name: 'completion_date_target' }
		,	{ name: 'status' }
		,	{ name: 'nama_status' }
		,	{ name: 'note' }
	]);

	this.store = new Ext.ux.data.PagingArrayStore({
			url			: m_rca_lap_severity_d +'data.jsp'
		,	fields		: this.record
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_severity = new Ext.data.ArrayStore({
			fields		: ['id_severity','nama_severity']
		,	url			: _g_root +'/module/trx_rca/data_ref_severity.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_direktorat.load();
				}
			}
	});

	this.store_direktorat = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_direktorat.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_divprosbu.load({
						params	: {
							id_direktorat : this.id_direktorat
						}
					});
				}
			}
	});

	this.store_divprosbu = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_divprosbu.jsp'
		,	autoLoad	: false
		,	idIndex		: 1
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_departemen.load({
						params	: {
							id_direktorat 	: this.id_direktorat
						,	id_divprosbu	: this.id_divprosbu
						}
					});
				}
			}
	});

	this.store_departemen = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id_divprosbu', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_departemen.jsp'
		,	autoLoad	: false
		,	idIndex		: 2
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_dinas.load({
						params	: {
							id_direktorat 	: this.id_direktorat
						,	id_divprosbu	: this.id_divprosbu
						,	id_departemen 	: this.id_departemen
						}
					});
				}
			}
	});

	this.store_dinas = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id_divprosbu', 'id_departemen', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_dinas.jsp'
		,	autoLoad	: false
		,	idIndex		: 3
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_seksi.load({
						params	: {
							id_direktorat 	: this.id_direktorat
						,	id_divprosbu	: this.id_divprosbu
						,	id_departemen	: this.id_departemen
						,	id_dinas		: this.id_dinas
						}
					});
				}
			}
	});

	this.store_seksi = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id_divprosbu', 'id_departemen', 'id_dinas', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_seksi.jsp'
		,	autoLoad	: false
		,	idIndex		: 4
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.do_load(this.form_year.getValue(),this.form_month.getValue());
				}
			}
	});

	this.store_status = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	data	: [
				[1,'Open']
			,	[2,'Process']
			,	[3,'Closed']
			]
		,	idIndex	: 0
	});

	this.form_description = new Ext.form.TextField();

	this.form_severity = new Ext.form.ComboBox({
			store			: this.store_severity
		,	valueField		: 'id_severity'
		,	displayField	: 'id_severity'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
	});

	this.form_nama_tempat = new Ext.form.TextField();
	
	this.form_seksi = new Ext.form.ComboBox({
			store			: this.store_seksi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
	});

	this.form_dinas = new Ext.form.ComboBox({
			store			: this.store_dinas
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
	});

	this.form_departemen = new Ext.form.ComboBox({
			store			: this.store_departemen
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
	});

	this.form_divprosbu = new Ext.form.ComboBox({
			store			: this.store_divprosbu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
	});

	this.form_direktorat = new Ext.form.ComboBox({
			store			: this.store_direktorat
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
	});

	this.form_tanggal_selesai = new Ext.form.DateField({
			format		: 'Y-m-d'
	});

	this.form_status = new Ext.form.ComboBox({
			store			: this.store_status
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
	});

	this.form_keterangan = new Ext.form.TextField();

	this.btn_proses = new Ext.Button({
			text	: 'Filter'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load(this.form_year.getValue(),this.form_month.getValue());
			}
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
		new Ext.grid.RowNumberer({
			locked		: true
		,	width		: 25
		}),{
			id			: 'description'
		,	header		: 'Deskripsi Severity'
		,	dataIndex	: 'description'
		,	sortable	: true
		,	width		: 300
		,	filterable	: true
		},{
			header		: 'Severity'
		,	dataIndex	: 'id_severity'
		,	align		: 'center'
		,	sortable	: true
		,	width		: 70
		,	renderer	: combo_renderer(this.form_severity)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_severity
			,	labelField	: 'id_severity'
			,	phpMode		: false
			}
		},{
			header		: 'Lokasi'
		,	dataIndex	: 'nama_tempat_rca'
		,	sortable	: true
		,	width		: 200
		,	filterable	: true
		},{
			header		: 'Direktorat Owner'
		,	dataIndex	: 'penanggung_jawab_direktorat'
		,	sortable	: true
		,	width		: 250
		,	renderer	: combo_renderer(this.form_direktorat)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_direktorat
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Divisi/Proyek/SBU Owner'
		,	dataIndex	: 'penanggung_jawab_divprosbu'
		,	sortable	: true
		,	width		: 250
		,	renderer	: combo_renderer(this.form_divprosbu)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_divprosbu
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Departemen Owner'
		,	dataIndex	: 'penanggung_jawab_departemen'
		,	sortable	: true
		,	width		: 250
		,	renderer	: combo_renderer(this.form_departemen)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_departemen
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Dinas Owner'
		,	dataIndex	: 'penanggung_jawab_dinas'
		,	sortable	: true
		,	width		: 300
		,	renderer	: combo_renderer(this.form_dinas)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_dinas
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Seksi Owner'
		,	dataIndex	: 'penanggung_jawab_seksi'
		,	sortable	: true
		,	width		: 300
		,	renderer	: combo_renderer(this.form_seksi)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_seksi
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Target Tindak Lanjut'
		,	dataIndex	: 'completion_date_target'
		,	align		: 'center'
		,	sortable	: true
		,	width		: 100
		},{
			header		: 'Status'
		,	dataIndex	: 'status'
		,	align		: 'center'
		,	sortable	: true
		,	width		: 70
		,	renderer	: combo_renderer(this.form_status)
		},{
			header		: 'Keterangan'
		,	dataIndex	: 'note'
		,	sortable	: true
		,	width		: 200
		,	filterable	: true
		}];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	viewConfig		: {forceFit:true}
	});

	this.grid = new Ext.grid.GridPanel({
			title		: 'Laporan Severity RCA'
		,	autoScroll	: true
		,	autoWidth	: true
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: [this.filters]
		,	tbar		: [
				this.form_year_label
			,	this.form_year
			,	'-'
			,	this.form_month_label
			,	this.form_month
			,	'-'
			,	this.btn_proses
			,	'->'
			,	{
					xtype	: 'exportbutton'
				,	store	: this.store
				}
			]
		,	bbar		: new Ext.PagingToolbar({
				store	: this.store
			,	pageSize: 50
			,	plugins	: [this.filters]
			})
	});

	this.panel = new Ext.Container({
		id			: 'rca_lap_severity_panel'
	,	layout		: 'card'
	,	activeItem	: 0
	,	items		: [
			this.grid
		]
	});

	this.do_load = function(year, month)
	{
		delete this.store.lastParams;

		this.store.load({
			params		: {
				start	: 0
			,	limit	: 50
			,	year	: year
			,	month	: month
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;		
		this.store_severity.load();
	}
}

m_rca_lap_severity = new M_RCALapSeverity();

//@ sourceURL=rca_lap_severity.layout.js
