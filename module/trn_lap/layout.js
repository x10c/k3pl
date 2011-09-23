/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_trn_lap;
var m_trn_lap_d		= _g_root +'/module/trn_lap/';
var m_trn_entri_d	= _g_root +'/module/trn_entri/';
var m_trn_lap_col;

function M_TrnMatriks()
{
	this.ha_level = 0;

	this.fields = new Ext.data.Record.create([
		{name:'nipg'}
	,	{name:'nama_pegawai'}
	,	{name:'id_jabatan'}
	,	{name:'nama_jabatan'}
	]);

	this.fields_jab = new Ext.data.Record.create([
		{name:'id'}
	,	{name:'name'}
	]);

	this.reader = new Ext.data.JsonReader(
		{
			id		:'nipg'
		,	root	:'rows'
		}
		, this.fields
	);

	this.store = new Ext.ux.data.PagingStore({
		url		: m_trn_lap_d +'data_peg_pelatihan.jsp'
	,	reader	: this.reader
	,	autoLoad: false
	});

	this.store_jab = new Ext.data.ArrayStore({
		fields	: this.fields_jab
	,	url		: _g_root +'/module/ref_jabatan/data_jabatan.jsp'
	,	autoLoad: false
	,	idIndex	:0
	});

	this.form_jab = new Ext.form.ComboBox({
		store			: this.store_jab
	,	valueField		: 'id'
	,	displayField	: 'name'
	,	mode			: 'local'
	,	editable		: false
	});

	this.columns = [
		new Ext.grid.RowNumberer({
			width		:40
		,	locked		:true
		}),{
			header		:'Nama Pegawai'
		,	dataIndex	:'nama_pegawai'
		,	hideable	:false
		,	width		:260
		,	locked		:true
		,	filterable	:true
		},{
			header		:'Jabatan'
		,	dataIndex	:'id_jabatan'
		,	renderer	:combo_renderer(this.form_jab)
		,	hideable	:false
		,	width		:180
		,	filter		:{
				type		:'list'
			,	labelField	:'name'
			,	store		:this.store_jab
			}
		}
	];

	this.cm = new Ext.ux.grid.LockingColumnModel({
		columns : this.columns
	});

	this.btn_ref = new Ext.Button({
		text	: 'Refresh'
	,	iconCls	: 'refresh16'
	,	scope	: this
	,	handler	: function() {
			this.do_refresh(this.ha_level);
		}
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
		});

	this.panel = new Ext.grid.GridPanel({
		title		: 'Matriks Pelatihan'
	,	store		: this.store
	,	cm			: this.cm
	,	autoScroll	: true
	,	autoWidth	: true
	,	stripeRows	: true
	,	columnLines	: true
	,	view		: new Ext.ux.grid.LockingGridView({
			syncHeights	:true
		})
	,	plugins		: [this.filters]
	,	tbar		: [
			this.btn_ref
			,	'->'
			,	{
				xtype	: 'exportbutton'
			,	store	: this.store}
		]
	,	bbar		: new Ext.PagingToolbar({
			store		: this.store
		,	pageSize	: 50
		,	plugins		: [this.filters]
		})
	});

	this.create_header = function(col_headers)
	{
		Ext.iterate(col_headers, function(k,v) {
			Ext.each(v, function(col) {
				this.store.addField({
					name		: col.id
				});

				this.columns.push({
					header		: col.name
				,	align		: 'center'
				,	dataIndex	: col.id
				,	xtype		: 'datecolumn'
				,	format		: 'Y-m-d'
				,	filter		:{
						type	:'date'
					,	format	:'Y-m-d'
					}
				});
			}, this);
		}, this);

		this.cm.setConfig(this.columns);
	}

	this.init = function()
	{
		Ext.Ajax.request({
			url	: m_trn_lap_d +'data_column_header.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.create_header(msg);
				}
		,	scope	: this
		});
	}

	this.init();

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		this.store_jab.reload();
		this.store.load({
			params	: {
				start	: 0
			,	limit	: 50
			}
		});
	}
}

function M_TrnLapPegawai()
{
	this.fields = new Ext.data.Record.create([
		{name:'nipg'}
	,	{name:'name'}
	,	{name:'id_dep'}
	,	{name:'id_dinas'}
	,	{name:'id_seksi'}
	,	{name:'nama_pelatihan'}
	,	{name:'tanggal'}
	,	{name:'tempat'}
	,	{name:'lama'}
	]);

	this.reader	= new Ext.data.JsonReader({
		root	:'rows'
	}, this.fields);

	this.store = new Ext.data.GroupingStore({
		url			:m_trn_lap_d +'data_per_pegawai.jsp'
	,	reader		:this.reader
	,	autoLoad	:false
	,	groupField	:'id_dep'
	});

	this.store_peg = new Ext.data.ArrayStore({
		url		:m_trn_entri_d +'data_peg.jsp'
	,	fields	:['nipg','name']
	,	autoLoad:false
	});

	this.form_peg = new Ext.form.ComboBox({
		fieldLabel		:'Nama Pegawai'
	,	emptyText		:'Nama Pegawai'
	,	store			:this.store_peg
	,	valueField		:'nipg'
	,	displayField	:'name'
	,	mode			:'local'
	,	triggerAction	:'all'
	,	typeAhead		:true
	,	width			:250
	});

	this.form_date_begin = new Ext.form.DateField({
		fieldLabel	:'dari'
	,	format		:'Y-m-d'
	,	emptyText	:'Tahun-Bulan-Tanggal'
	});

	this.form_date_end = new Ext.form.DateField({
		fieldLabel	:'sampai dengan'
	,	format		:'Y-m-d'
	,	emptyText	:'Tahun-Bulan-Tanggal'
	});

	this.set_org = new k3pl.form.SetOrganisasi({
		itemAll		: true
	,	scope		: this
	,	onCheckClick	: function() {
			this.toggleCollapse(true);
			this.scope.set_pegawai.toggleCollapse(true);
		}
	});

	this.set_pegawai = new Ext.form.FieldSet({
		title			:'Pegawai'
	,	checkboxToggle	:true
	,	autoHeight		:true
	,	collapsed		:true
	,	scope			:this
	,	items			:[
			this.form_peg
		]
	,	onCheckClick	: function() {
			this.scope.set_org.toggleCollapse(true);
			this.toggleCollapse(true);
		}
	,	listeners	:{
			scope	:this
		,	collapse: function() {
				this.form_peg.setValue("");
			}
		}
	});

	this.set_waktu = new Ext.form.FieldSet({
		title		:'Tanggal Pelatihan'
	,	autoHeight	:true
	,	labelWidth	:120
	,	items		:[
			this.form_date_begin
		,	this.form_date_end
		]
	});

	this.btn_submit = new Ext.Button({
		text	:'Submit'
	,	scope	:this
	,	handler	: function() {
			this.do_submit();
		}
	});

	this.panel_form = new Ext.form.FormPanel({
		autoHeight	:true
	,	buttonAlign	:'center'
	,	buttons		:[
			this.btn_submit
		]
	,	frame		: true
	,	items		:[
			this.set_org
		,	this.set_pegawai
		,	this.set_waktu
		]
	,	labelAlign	:'right'
	,	width		:450
	});
/*
 * Grid
 */
	this.cm = new Ext.grid.ColumnModel({
		columns	:[
			new Ext.grid.RowNumberer()
		,{
			header		:'NIPG'
		,	dataIndex	:'nipg'
		},{
			header		:'Nama Pegawai'
		,	dataIndex	:'name'
		},{
			header		:'Departemen'
		,	dataIndex	:'id_dep'
		,	groupable	:true
		,	renderer	:store_renderer('id', 'name', k3pl.store.Departemen)
		},{
			header		:'Dinas'
		,	dataIndex	:'id_dinas'
		,	groupable	:true
		,	renderer	:store_renderer('id', 'name', k3pl.store.Dinas)
		},{
			header		:'Seksi'
		,	dataIndex	:'id_seksi'
		,	groupable	:true
		,	renderer	:store_renderer('id', 'name', k3pl.store.Seksi)
		},{
			header		:'Nama Pelatihan'
		,	dataIndex	:'nama_pelatihan'
		,	groupable	:true
		},{
			header		:'Tanggal'
		,	dataIndex	:'tanggal'
		,	align		:'center'
		},{
			header		:'Tempat'
		,	dataIndex	:'tempat'
		,	summaryRenderer	: function() {
					return '<center><b>Total :</b></center>';
				}
		},{
			header		:'Durasi (hari)'
		,	dataIndex	:'lama'
		,	summaryType	: 'sum'
		,	align		:'center'
		}]
	,	defaults	:{
			sortable	:true
		}
	});

	this.summary		= new Ext.ux.grid.GridSummary()
	this.group_summary	= new Ext.ux.grid.GroupSummary();

	this.panel_grid = new Ext.grid.GridPanel({
		store		:this.store
	,	cm			:this.cm
	,	autoHeight	:true
	,	autoWidth	:true
	,	autoScroll	:true
	,	plugins		:[this.summary, this.group_summary]
	,	view		: new Ext.grid.GroupingView({
			hideGroupedColumn	:true
		,	startCollapsed		:true
		,	forceFit			:true
		})
	});
/*
 * main panel
 */
	this.panel = new Ext.Panel({
		title		:'Data Pelatihan'
	,	padding		:'6'
	,	autoScroll	:true
	,	defaults	:{
			style		:{
					marginLeft		: 'auto'
				,	marginRight		: 'auto'
				,	marginBottom	: '8px'
			}
		}
	,	items	:[
			this.panel_form
		,	this.panel_grid
		]
	});

	this.do_submit = function()
	{
		this.store.load({
			params	:{
				id_dep 		:this.set_org.formDepartemen.getValue()
			,	id_dinas	:this.set_org.formDinas.getValue()
			,	id_seksi	:this.set_org.formSeksi.getValue()
			,	nipg		:this.form_peg.getValue()
			,	date_begin	:this.form_date_begin.getValue()
			,	date_end	:this.form_date_end.getValue()
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.store_peg.load();

		this.set_org.do_load();
	}
}

function M_TrnLap()
{
	this.trn_matriks	= new M_TrnMatriks();
	this.trn_peg		= new M_TrnLapPegawai(this.trn_matriks.store);

	this.panel = new Ext.TabPanel({
		id		:'trn_lap_panel'
	,	activeItem	:0
	,	items		:[
			this.trn_matriks.panel
		,	this.trn_peg.panel
		]
	});

	this.do_refresh = function(ha_level)
	{
		this.trn_matriks.do_refresh(ha_level);
		this.trn_peg.do_refresh(ha_level);
	}
}

m_trn_lap = new M_TrnLap();

//@ sourceURL=trn_lap.layout.js
