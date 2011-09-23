/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

 var m_pha_laporan;
 var m_pha_laporan_master;
 var m_pha_laporan_detail;
 var m_pha_laporan_d = _g_root +'/module/pha_laporan/';
 var m_pha_laporan_id_pha = '';
 var m_pha_laporan_id_report = '';
 var m_pha_laporan_tipe_report = '';
 var m_pha_laporan_ha_level = 0;
 
 function m_pha_laporan_master_on_select_load_detail()
 {
 	if (typeof m_pha_laporan_master == 'undefined') {
		return;
	}

	m_pha_laporan_detail.do_refresh();
 }

 function M_PHALaporanMaster(title)
 {
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pha' }
		,	{ name	: 'tanggal' }
		,	{ name	: 'lokasi' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_laporan_d +'data_master.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Tanggal'
		,	dataIndex	: 'tanggal'
		,	align		: 'center'
		,	width		: 90
		},{
			id			: 'lokasi_pha'
		,	header		: 'Lokasi'
		,	dataIndex	: 'lokasi'
		}]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});


	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_pha_laporan_id_pha = data[0].data['id_pha'];
					} else {
						m_pha_laporan_id_pha = '';
					}

					m_pha_laporan_master_on_select_load_detail();
				}
			}
	});

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.store.reload();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'lokasi_pha'
	});

	this.do_load = function()
	{
		var load_type = 'user';

		if (m_pha_laporan_ha_level == 4) {
			load_type = 'all';
		}

		this.store.load({
			params	: {
				load_type : load_type
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_pha_laporan_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Laporan PHA!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
 }
 
  function M_PHALaporanDetail(title)
 {
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_report' }
		,	{ name	: 'nama_report' }
		,	{ name	: 'klasifikasi_report' }
		,	{ name	: 'tipe_report' }
		,	{ name	: 'file_location' }
		,	{ name	: 'web_params' }
		,	{ name	: 'report_params' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_pha_laporan_d +'data_detail.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{	id			: 'nama_report'
		,	header		: 'Nama Laporan'
		,	dataIndex	: 'nama_report'
		}]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_pha_laporan_id_report		= data[0].data['id_report'];
						m_pha_laporan_tipe_report	= data[0].data['tipe_report'];
						this.btn_print.setDisabled(false);
					} else {
						m_pha_laporan_id_report		= '';
						m_pha_laporan_tipe_report	= '';
						this.btn_print.setDisabled(true);
					}
				}
			}
	});

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.store.reload();
			}
	});

	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_print
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nama_report'
	});

	this.do_print = function()
	{
		if (m_pha_laporan_id_pha == '') {
			return;
		}

		var form;
		form = document.createElement('form');

		form.setAttribute('method', 'post');
		form.setAttribute('target', '_blank');		
		form.setAttribute('action', _g_root +'/report');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'id');
        hiddenField1.setAttribute('value', m_pha_laporan_id_report);
		
		var hiddenField2 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField2.setAttribute('name', 'type');
        hiddenField2.setAttribute('value', m_pha_laporan_tipe_report);

		var hiddenField3 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField3.setAttribute('name', 'id_pha');
        hiddenField3.setAttribute('value', m_pha_laporan_id_pha);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
		document.body.appendChild(form);
		form.submit();
	}
	
	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		this.do_load();
		
		this.btn_print.setDisabled(true);
	}
 }
 
 function M_PHALaporan()
 {
	m_pha_laporan_master	= new M_PHALaporanMaster('Data PHA');
	m_pha_laporan_detail	= new M_PHALaporanDetail('List Laporan');

	this.panel = new Ext.Panel({
			id				: 'pha_laporan_panel'
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_pha_laporan_master.grid
			,	m_pha_laporan_detail.grid
			]
	});
	
	this.do_refresh = function(ha_level)
	{
		m_pha_laporan_ha_level	= ha_level;

		m_pha_laporan_master.do_refresh(ha_level);
	}
 }
 
 m_pha_laporan	= new M_PHALaporan();
 
 //@ sourceURL=lnk_bulanan.layout.js