/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_trn_entri;
var m_trn_entri_form;
var m_trn_entri_list;
var m_trn_entri_d = _g_root +'/module/trn_entri/';
var m_ref_pelatihan_d = _g_root +'/module/ref_pelatihan/'

var m_trn_entri_store_pel = new Ext.data.ArrayStore({
		url		:m_ref_pelatihan_d +'data_pelatihan.jsp'
	,	fields		:['kel','id','name']
	,	idIndex		:1
	,	autoLoad	:false
	});

var m_trn_entri_store_peg = new Ext.data.ArrayStore({
		url		:m_trn_entri_d +'data_peg.jsp'
	,	fields		:['id','name']
	,	idIndex		:0
	,	autoLoad	:false
	});

var m_trn_entri_form_peg = new Ext.form.ComboBox({
		store		:m_trn_entri_store_peg
	,	valueField	:'id'
	,	displayField	:'name'
	,	mode		:'local'
	,	allowBlank	:false
	,	forceSelection	:true
	,	typeAhead	:true
	,	selectOnFocus	:true
	,	triggerAction	:'all'
	,	width		:260
	});


function M_TrnEntriFormPeserta()
{
	this.record = new Ext.data.Record.create([
		{name:'nipg'}
	]);

	this.store = new Ext.data.ArrayStore({
		fields	:this.record
	,	data	:[]
	});

	this.columns = [{
			header		:'Nama'
		,	id		:'nipg'
		,	dataIndex	:'nipg'
		,	editor		:m_trn_entri_form_peg
		,	renderer	:combo_renderer(m_trn_entri_form_peg)
	}];

	this.cm = new Ext.grid.ColumnModel({
		columns	:this.columns
	});

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
		text	:'Tambah'
	,	iconCls	:'add16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_add();
		}
	});

	this.btn_del = new Ext.Button({
		text	:'Hapus'
	,	iconCls	:'del16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_del();
		}
	});

	this.panel = new Ext.grid.GridPanel({
		title		:'Peserta'
	,	store		:this.store
	,	cm		:this.cm
	,	sm		:this.sm
	,	autoScroll	:true
	,	height		:400
	,	width		:450
	,	autoExpandColumn:'nipg'
	,	plugins	:[this.editor]
	,	tbar	:[
			this.btn_del,'->'
		,	this.btn_add
		]
	});

	this.do_add = function()
	{
		this.record_new = new this.record;

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.store.remove(data[0]);
	}

	this.do_cancel = function()
	{
		this.store.remove(this.record_new);
		this.sm.selectRow(0);
	}

	this.do_save = function()
	{
		this.store.commitChanges();
	}

	this.do_reset = function()
	{
		this.store.removeAll();
	}
}

function M_TrnEntriForm()
{
	this.id			= '';
	this.dml_type	= 0;

	this.form_pel = new Ext.form.ComboBox({
		fieldLabel		:'Tipe Pelatihan'
	,	store			:m_trn_entri_store_pel
	,	valueField		:'id'
	,	displayField	:'name'
	,	mode			:'local'
	,	allowBlank		:false
	,	forceSelection	:true
	,	typeAhead		:true
	,	selectOnFocus	:true
	,	triggerAction	:'all'
	,	editable		:false
	,	width			:260
	});

	this.form_penyelenggara = new Ext.form.TextField({
		fieldLabel	:'Penyelenggara'
	,	allowBlank	:false
	,	width		:260
	});

	this.form_tempat = new Ext.form.TextField({
		fieldLabel	:'Tempat'
	,	allowBlank	:false
	,	width		:260
	});

	this.form_tanggal = new Ext.form.DateField({
		fieldLabel	:'Tanggal'
	,	allowBlank	:false
	,	format		:'Y-m-d'
	,	editable	:false
	,	width		:260
	});

	this.form_lama = new Ext.form.NumberField({
		fieldLabel	:'Lama'
	,	allowBlank	:false
	,	allowDecimal	:false
	,	allowNegative	:false
	,	minValue	:1
	,	value		:1
	,	width		:260
	});

	this.form_peserta = new M_TrnEntriFormPeserta();

	this.btn_save = new Ext.Button({
		text	:'Simpan'
	,	iconCls	:'save16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_save();
		}
	});

	this.btn_cancel = new Ext.Button({
		text	:'Batal'
	,	iconCls	:'del16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_cancel();
		}
	});

	this.panel_form = new Ext.form.FormPanel({
		labelAlign	:'right'
	,	labelWidth	:140
	,	width		:450
	,	defaults	:{
			msgTarget	: 'side'
		}
	,	items		:[
			this.form_pel
		,	this.form_penyelenggara
		,	this.form_tempat
		,	this.form_tanggal
		,{
				xtype	: 'compositefield'
			,	items	: [
					this.form_lama
				,{	xtype:'displayfield'
				,	value:'hari'
				}]
		}
		]
	});

	this.panel = new Ext.Panel({
		title		:'Data Pelatihan'
	,	autoScroll	:true
	,	padding		:'6'
	,	tbar		:[
			this.btn_cancel,'->'
		,	this.btn_save
		]
	,	defaults	:{
			style		:{
				marginLeft	:'auto'
			,	marginRight	:'auto'
			,	marginBottom	:'8px'
			}
		}
	,	items		:[
			this.panel_form
		,	this.form_peserta.panel
		]
	});

	this.do_cancel = function()
	{
		m_trn_entri.panel.layout.setActiveItem(0);
	}

	this.do_reset = function()
	{
		this.form_pel.setValue(m_trn_entri_store_pel.getAt(0).get('id'));
		this.form_penyelenggara.setValue('');
		this.form_tempat.setValue('');
		this.form_tanggal.setValue('');
		this.form_lama.setValue(1);

		this.form_peserta.do_reset();
	}

	this.do_fill = function(r)
	{
		this.form_pel.setValue(r.get('id_pelatihan'));
		this.form_penyelenggara.setValue(r.get('penyelenggara'));
		this.form_tempat.setValue(r.get('tempat'));
		this.form_tanggal.setValue(r.get('tanggal'));
		this.form_lama.setValue(r.get('lama'));

		this.form_peserta.store.loadData(r.get('peserta'), false);
	}

	this.do_save = function()
	{
		var i		= 0;
		var peserta	= '[';

		this.form_peserta.store.each(function(r) {
			if (i > 0) {
				peserta += ",";
			} else {
				i = 1;
			}
			peserta += "'"+ r.get('nipg') +"'";
		});
		peserta += ']';
		
		Ext.Ajax.request({
			url	:m_trn_entri_d +'submit.jsp'
		,	scope	: this
		,	params	:{
				dml_type	: this.dml_type
			,	id			: this.id
			,	id_pelatihan	: this.form_pel.getValue()
			,	penyelenggara	: this.form_penyelenggara.getValue()
			,	tempat		: this.form_tempat.getValue()
			,	tanggal		: this.form_tanggal.getValue()
			,	lama		: this.form_lama.getValue()
			,	peserta		: peserta
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				Ext.MessageBox.alert('Informasi', msg.info);

				m_trn_entri_list.do_load();
				m_trn_entri.panel.layout.setActiveItem(0);
			}
		});
	}
}

function M_TrnEntriList()
{
	this.ha_level = 0;

	this.record = new Ext.data.Record.create([
		{name:'id'}
	,	{name:'id_pelatihan'}
	,	{name:'penyelenggara'}
	,	{name:'tempat'}
	,	{name:'tanggal'}
	,	{name:'lama'}
	,	{name:'pj'}
	,	{name:'peserta'}
	]);

	this.reader = new Ext.data.JsonReader(
		{root:'rows'}
	,	this.record
	);

	this.store = new Ext.data.Store({
		url	:m_trn_entri_d +'/data.jsp'
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.store_single = new Ext.data.Store({
		url	:m_trn_entri_d +'/data.jsp'
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.form_pel = new Ext.form.ComboBox({
		fieldLabel	:'Tipe Pelatihan'
	,	store		:m_trn_entri_store_pel
	,	valueField	:'id'
	,	displayField	:'name'
	,	mode		:'local'
	,	allowBlank	:false
	,	forceSelection	:true
	,	typeAhead	:true
	,	selectOnFocus	:true
	,	triggerAction	:'all'
	,	editable	:false
	,	width		:260
	});

	this.columns = [{
		header		:'Pelatihan'
	,	dataIndex	:'id_pelatihan'
	,	renderer	:combo_renderer(this.form_pel)
	,	filter		:{
			type		:'list'
		,	store		:m_trn_entri_store_pel
		,	labelField	:'name'
		}
	},{
		header		:'Penyelenggara'
	,	dataIndex	:'penyelenggara'
	,	filterable	: true
	},{
		header		:'Tempat'
	,	dataIndex	:'tempat'
	,	filterable	: true
	},{
		header		:'Tanggal'
	,	dataIndex	:'tanggal'
	,	align		:'center'
	,	width		:70
	,	filter		:{
			type	:'date'
		,	format	:'Y-m-d'
		}
	},{
		header		:'Lama (hari)'
	,	dataIndex	:'lama'
	,	align		:'center'
	,	width		:50
	,	filter		:{
			type	:'numeric'
		}
	}];

	this.cm = new Ext.grid.ColumnModel({
		columns	:this.columns
	,	defaults: {
			sortable:true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						if (this.ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						if (this.ha_level >= 3) {
							this.btn_edit.setDisabled(false);
						}
					} else {
						this.btn_del.setDisabled(true);
						this.btn_edit.setDisabled(true);
					}
				}
			}
		});

	this.btn_add = new Ext.Button({
		text	:'Tambah'
	,	iconCls	:'add16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_add();
		}
	});

	this.btn_edit = new Ext.Button({
		text		:'Ubah'
	,	disabled	:true
	,	iconCls		:'edit16'
	,	scope		:this
	,	handler		:function()
		{
			this.do_edit();
		}
	});

	this.btn_ref = new Ext.Button({
		text	:'Refresh'
	,	iconCls	:'refresh16'
	,	scope	:this
	,	handler	: function()
		{
			this.do_load();
		}
	});

	this.btn_del = new Ext.Button({
		text		:'Hapus'
	,	disabled	:true
	,	iconCls		:'del16'
	,	scope		:this
	,	handler		:function()
		{
			this.do_del();
		}
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
		});

	this.panel = new Ext.grid.GridPanel({
		title		:'Data Pelatihan'
	,	store		:this.store
	,	cm		:this.cm
	,	sm		:this.sm
	,	stripeRows	:true
	,	plugins		: [this.filters]
	,	tbar		:[
			this.btn_del, '-'
		,	this.btn_edit, '-'
		,	this.btn_ref, '-'
		,	this.btn_add
		]
	,	viewConfig	:{
			forceFit:true
		}
	});

	this.do_add = function()
	{
		m_trn_entri_form.id			= '';
		m_trn_entri_form.dml_type	= 2;
		m_trn_entri_form.do_reset();
		m_trn_entri.panel.layout.setActiveItem(1);
	}

	this.do_edit = function()
	{
		if (this.ha_level < 3) {
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		m_trn_entri_form.dml_type	= 3;
		m_trn_entri_form.id			= data[0].get('id')

		this.store_single.load({
			params	: {
				id	: data[0].get('id')
			}
		,	callback: function(records,options,success)
			{
				if (!success) {
					return;
				}

				m_trn_entri_form.do_fill(records[0]);
			}
		});

		m_trn_entri.panel.layout.setActiveItem(1);
	}

	this.do_del = function()
	{
		if (this.ha_level < 4) {
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		m_trn_entri_form.dml_type	= 4;
		m_trn_entri_form.id			= data[0].get('id');
		m_trn_entri_form.do_save();
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();
	}
}

function M_TrnEntri()
{
	this.ha_level		= 0;
	m_trn_entri_form	= new M_TrnEntriForm();
	m_trn_entri_list	= new M_TrnEntriList();

	this.panel = new Ext.Panel({
		id		:'trn_entri_panel'
	,	layout		:'card'
	,	activeItem	:0
	,	items		:[
			m_trn_entri_list.panel
		,	m_trn_entri_form.panel
		]
	});

	this.do_load_peg = function()
	{
		m_trn_entri_store_peg.load({
			scope	: this
		,	callback: function(records,options,success)
			{
				if (!success) {
					return;
				}
				m_trn_entri_list.do_refresh(this.ha_level);
			}
		});
	}

	this.do_load = function()
	{
		m_trn_entri_store_pel.load({
			scope	: this
		,	callback: function(records,options,success)
			{
				if (!success) {
					return;
				}
				this.do_load_peg();
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();
	}
}

m_trn_entri = new M_TrnEntri();

//@ sourceURL=trn_entri.layout.js
