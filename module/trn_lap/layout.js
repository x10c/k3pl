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
	,	{name:'id_direktorat'}
	,	{name:'id_divprosbu'}
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

	this.btn_print = new Ext.Button({
			text	: 'Print'
		,	iconCls	: 'print16'
		,	scope	: this
		,	handler	: function() {
				this.do_print();
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
			,	this.btn_print
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
				,	width		:150
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

	this.do_print = function()
	{
		var form;
		var id_report		= '23';
		var tipe_report		= 'xls';
		var id_direktorat	= this.store.getAt(0).data['id_direktorat'];
		var id_divprosbu	= this.store.getAt(0).data['id_divprosbu'];
		
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
		hiddenField3.setAttribute('name', 'id_dir');
        hiddenField3.setAttribute('value', id_direktorat);
		
		var hiddenField4 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField4.setAttribute('name', 'id_div');
        hiddenField4.setAttribute('value', id_divprosbu);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
		form.appendChild(hiddenField4);
		document.body.appendChild(form);
		form.submit();
	}
	
	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		this.store_jab.reload();

		delete this.store.lastParams;
		
		this.store.reload({
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
		itemAll			: true
	,	scope			: this
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
	,	width		:460
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
		,	width		:120
		},{
			header		:'Nama Pegawai'
		,	dataIndex	:'name'
		,	width		:200
		},{
			header		:'Departemen'
		,	dataIndex	:'id_dep'
		,	groupable	:true
		,	renderer	:store_renderer('id', 'name', k3pl.store.Departemen)
		,	width		:200
		},{
			header		:'Dinas'
		,	dataIndex	:'id_dinas'
		,	groupable	:true
		,	renderer	:store_renderer('id', 'name', k3pl.store.Dinas)
		,	width		:200
		},{
			header		:'Seksi'
		,	dataIndex	:'id_seksi'
		,	groupable	:true
		,	renderer	:store_renderer('id', 'name', k3pl.store.Seksi)
		,	width		:200
		},{
			header		:'Nama Pelatihan'
		,	dataIndex	:'nama_pelatihan'
		,	groupable	:true
		,	width		:200
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
		,	width		:150
		},{
			header		:'Durasi (hari)'
		,	dataIndex	:'lama'
		,	summaryType	:'sum'
		,	align		:'center'
		}]
	,	defaults	:{
			sortable	:true
		}
	});

	this.summary		= new Ext.ux.grid.GridSummary()
	this.group_summary	= new Ext.ux.grid.GroupSummary();

	this.btn_print = new Ext.Button({
			text	: 'Print'
		,	iconCls	: 'print16'
		,	scope	: this
		,	handler	: function() {
				this.do_print();
			}
	});

	this.panel_grid = new Ext.grid.GridPanel({
		store		:this.store
	,	cm			:this.cm
	,	autoHeight	:true
	,	autoScroll	:true
	,	plugins		:[this.summary, this.group_summary]
	,	view		: new Ext.grid.GroupingView({
			hideGroupedColumn	:true
		,	startCollapsed		:false
		})
	,	tbar		: [ this.btn_print ]
	});
/*
 * main panel
 */
	this.panel = new Ext.Panel({
		title		:'Data Pelatihan'
	,	padding		:'6'
	,	autoScroll	:true
	,	defaults	: {
			style		: {
				marginLeft	: 'auto'
			,	marginRight	: 'auto'
			}
		}
	,	items		:[
			this.panel_form
		,	this.panel_grid
		]
	});

	this.do_submit = function()
	{
		this.store.load({
			params	:{
				id_dir		:this.set_org.formDirektorat.getValue ()
			,	id_div		:this.set_org.formDivProSBU.getValue ()
			,	id_dep 		:this.set_org.formDepartemen.getValue()
			,	id_dinas	:this.set_org.formDinas.getValue()
			,	id_seksi	:this.set_org.formSeksi.getValue()
			,	nipg		:this.form_peg.getValue()
			,	date_begin	:this.form_date_begin.getValue()
			,	date_end	:this.form_date_end.getValue()
			}
		});
	}

	this.do_print = function()
	{
		var form;
		var id_report		= '24';
		var tipe_report		= 'xls';
		
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
		hiddenField3.setAttribute('name', 'id_dir');
        hiddenField3.setAttribute('value', this.set_org.formDirektorat.getValue());
		
		var hiddenField4 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField4.setAttribute('name', 'id_div');
        hiddenField4.setAttribute('value', this.set_org.formDivProSBU.getValue());
		
		var hiddenField5 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField5.setAttribute('name', 'id_dep');
        hiddenField5.setAttribute('value', this.set_org.formDepartemen.getValue());
		
		var hiddenField6 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField6.setAttribute('name', 'id_din');
        hiddenField6.setAttribute('value', this.set_org.formDinas.getValue());
		
		var hiddenField7 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField7.setAttribute('name', 'id_sek');
        hiddenField7.setAttribute('value', this.set_org.formSeksi.getValue());
		
		var hiddenField8 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField8.setAttribute('name', 'nipg');
        hiddenField8.setAttribute('value', this.form_peg.getValue());
		
		var hiddenField9 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField9.setAttribute('name', 'start_date');
        hiddenField9.setAttribute('value', this.form_date_begin.getRawValue());
		
		var hiddenField10 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField10.setAttribute('name', 'end_date');
        hiddenField10.setAttribute('value', this.form_date_end.getRawValue());
		
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
		document.body.appendChild(form);
		form.submit();
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
