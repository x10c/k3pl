/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_rca_lap_severity;
var m_rca_lap_severity_d = _g_root +'/module/rca_lap_severity/';

function M_RCALapSeverityForm(grid, displayBulan)
{
	this.ref_grid		= grid;

	this.set_org = new k3pl.form.SetOrganisasi({
			itemAll			: true
		,	scope			: this
		,	onCheckClick	: function() {
				this.scope.set_checked()
			}
	});

	this.set_wil = new k3pl.form.SetWilayah({
			itemAll			: true
		,	scope			: this
		,	onCheckClick	: function() {
				this.scope.set_checked()
			}
	});

	this.set_waktu = new k3pl.form.SetWaktu({
			itemAll			: displayBulan
		,	displayBulan	: displayBulan
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
					,	displayBulan ? this.set_waktu.formBulan.getValue() : 0
					,	this.set_org.collapsed ? 0 : 1
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
			,	this.set_wil
			,	this.set_waktu
			]
	});

	this.set_checked = function()
	{
		this.set_org.toggleCollapse(true);
		this.set_wil.toggleCollapse(true);
	}

	this.do_refresh = function(ha_level)
	{
		this.set_org.do_load();
		this.set_wil.do_load();
		this.set_waktu.do_load();
	}
}

function M_RCALapSeverityGrid()
{
	this.ha_level		= 0;

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
		,	{ name: 'id_rca_detail' }
		,	{ name: 'nama_auditor' }
	]);

	this.store = new Ext.data.JsonStore ({
			url				: m_rca_lap_severity_d +'data.jsp'
		,	storeId			:'m_rca_lap_severity'
		,	root			:'data'
		,	totalProperty	:'total'
		,	fields			:this.record
		,	idProperty		:'id_rca_detail'
		,	autoLoad		:false
		,	baseParams		:{
				id_dir			:0
			,	id_div			:0
			,	id_dep			:0
			,	id_dinas		:0
			,	id_seksi		:0
			,	id_wilayah		:0
			,	id_area			:0
			,	year			:0
			,	month			:0
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

	this.form_status = new Ext.form.ComboBox({
			store			: this.store_status
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
	});

	this.columns = [
		new Ext.grid.RowNumberer({
			locked		: true
		,	width		: 25
		}),{
			header		: 'Nama Auditor'
		,	dataIndex	: 'nama_auditor'
		,	sortable	: true
		,	width		: 200
		},{
			id			: 'description'
		,	header		: 'Deskripsi Severity'
		,	dataIndex	: 'description'
		,	sortable	: true
		,	width		: 300
		},{
			header		: 'Severity'
		,	dataIndex	: 'id_severity'
		,	align		: 'center'
		,	sortable	: true
		,	width		: 70
		},{
			header		: 'Lokasi'
		,	dataIndex	: 'nama_tempat_rca'
		,	sortable	: true
		,	width		: 200
		},{
			header		: 'Direktorat Owner'
		,	dataIndex	: 'nama_direktorat'
		,	sortable	: true
		,	width		: 250
		},{
			header		: 'Divisi/Proyek/SBU Owner'
		,	dataIndex	: 'nama_divprosbu'
		,	sortable	: true
		,	width		: 250
		},{
			header		: 'Departemen Owner'
		,	dataIndex	: 'nama_departemen'
		,	sortable	: true
		,	width		: 250
		},{
			header		: 'Dinas Owner'
		,	dataIndex	: 'nama_dinas'
		,	sortable	: true
		,	width		: 300
		},{
			header		: 'Seksi Owner'
		,	dataIndex	: 'nama_seksi'
		,	sortable	: true
		,	width		: 300
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
		}];

	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});

	this.panel = new Ext.grid.GridPanel({
			autoScroll	: true
		,	height		: 500
		,	store		: this.store
		,	columns		: this.columns
		,	tbar		: [ this.btn_print ]
		,	bbar		: new Ext.PagingToolbar ({
				store		:this.store
			,	pageSize	:k3pl.pageSize
			})
	});

	this.do_print = function()
	{
		var form;
		var id_report	= '25';
		var tipe_report	= 'xls';
		var isinorg		= m_rca_lap_severity.form.set_org.isChecked();
		
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
		hiddenField4.setAttribute('name', 'year');
        hiddenField4.setAttribute('value', m_rca_lap_severity.form.set_waktu.formTahun.getValue());
		
		var hiddenField5 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField5.setAttribute('name', 'month');
        hiddenField5.setAttribute('value', m_rca_lap_severity.form.set_waktu.formBulan.getValue());

		var hiddenField6 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField6.setAttribute('name', 'id_dir');
        hiddenField6.setAttribute('value', m_rca_lap_severity.form.set_org.formDirektorat.getValue());
		
		var hiddenField7 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField7.setAttribute('name', 'id_div');
        hiddenField7.setAttribute('value', m_rca_lap_severity.form.set_org.formDivProSBU.getValue());
		
		var hiddenField8 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField8.setAttribute('name', 'id_dep');
        hiddenField8.setAttribute('value', m_rca_lap_severity.form.set_org.formDepartemen.getValue());
		
		var hiddenField9 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField9.setAttribute('name', 'id_dinas');
        hiddenField9.setAttribute('value', m_rca_lap_severity.form.set_org.formDinas.getValue());
		
		var hiddenField10 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField10.setAttribute('name', 'id_seksi');
        hiddenField10.setAttribute('value', m_rca_lap_severity.form.set_org.formSeksi.getValue());
		
		var hiddenField11 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField11.setAttribute('name', 'id_wilayah');
        hiddenField11.setAttribute('value', m_rca_lap_severity.form.set_wil.formWilayah.getValue());
		
		var hiddenField12 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField12.setAttribute('name', 'id_area');
        hiddenField12.setAttribute('value', m_rca_lap_severity.form.set_wil.formArea.getValue());
				
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
	
	this.do_load = function(id_dir, id_div, id_dep, id_dinas, id_seksi, id_wilayah, id_area, year, month)
	{
		this.store.baseParams.id_dir		= id_dir;
		this.store.baseParams.id_div		= id_div;
		this.store.baseParams.id_dep		= id_dep;
		this.store.baseParams.id_dinas		= id_dinas;
		this.store.baseParams.id_seksi		= id_seksi;
		this.store.baseParams.id_wilayah	= id_wilayah;
		this.store.baseParams.id_area		= id_area;
		this.store.baseParams.year			= year;
		this.store.baseParams.month			= month;

		this.store.load({
			params		: {
				year		:year
			,	month		:month
			}
		});
	}
}

function M_RCALapSeverity()
{
	this.grid = new M_RCALapSeverityGrid();
	this.form = new M_RCALapSeverityForm(this.grid, true);

	this.panel = new Ext.Panel({
			title		:'Laporan Severity RCA'
		,	frame		:false
		,	padding		:'6'
		,	autoScroll	:true
		,	defaults	:{
				style		: {
					marginLeft		:'auto'
				,	marginRight		:'auto'
				,	marginBottom	:'8px'
				}
			}
		,	items		:[
				this.form.panel
			,	this.grid.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.form.do_refresh(ha_level);
	}
}
m_rca_lap_severity = new M_RCALapSeverity();

//@ sourceURL=rca_lap_severity.layout.js
