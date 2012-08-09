/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_csm_evaluasi;
var m_csm_eval_d			= _g_root +"/module/csm_evaluasi/";
var m_ref_csm_d				= _g_root +"/module/ref_csm/";
var m_csm_eval_list;
var m_csm_eval_form;
var m_csm_id_proyek;
var m_csm_id_kontraktor;
var m_csm_koef_utama		= 0;
var m_csm_koef_tambahan		= 0;

var m_csm_store_ps	= new Ext.data.ArrayStore({
	url				: m_ref_csm_d +"data_eval_ps.jsp"
,	fields			:["id","min","max","keterangan"]
,	idIndex			:0
,	autoLoad		:false
,	get_keterangan	: function (v)
	{
		var min;
		var max;
		var r = this.getRange ();
		for (var i = 0; i < r.length; i++) {
			min = parseFloat (r[i].get ("min"));
			max = parseFloat (r[i].get ("max"));

			if (v > min && v <= max) {
				return r[i].get ("keterangan");
			}
		}
	}
});

function CSMEvalList()
{
	this.fields = new Ext.data.Record.create ([
		"id"
	,	"name"
	,	"id_kontraktor"
	,	"nama_kontraktor"
	,	"score"
	,	"penghargaan_sanksi"
	,	"koefisien_utama"
	,	"koefisien_tambah"
	,	"tanggal"
	,	"team"
	,	"work_area"
	]);

	this.store	= new Ext.data.ArrayStore ({
		url		:m_csm_eval_d +"data_project.jsp"
	,	fields	:this.fields
	,	autoLoad:false
	});

	this.cm		= new Ext.grid.ColumnModel ({
		columns	:[
			new Ext.grid.RowNumberer()
		,{
			header		:"Nama Proyek"
		,	id			:"name"
		,	dataIndex	:"name"
		},{
			header		:"Nama Kontraktor"
		,	dataIndex	:"nama_kontraktor"
		,	width		:200
		},{
			header		:"Nilai"
		,	dataIndex	:"score"
		,	align		:"center"
		},{
			header		:"Penghargaan / Sanksi"
		,	dataIndex	:"score"
		,	renderer	: function (v) {
				return m_csm_store_ps.get_keterangan (parseFloat (v));
			}
		,	width		:200
		}]
	});

	this.sm		= new Ext.grid.RowSelectionModel ({
		singleSelect	:true
	});

	this.btn_ref	= k3pl.button.Refresh (this);
	this.btn_eval	= new Ext.Button ({
		text		:"Evaluasi"
	,	iconCls		:"edit16"
	,	scope		:this
	,	handler		:function() {
			this.do_show_form_eval ();
		}
	});

	this.panel				= new Ext.grid.GridPanel ({
		title				:"Evaluasi Kontraktor"
	,	store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	autoExpandColumn	:"name"
	,	tbar				:[
			this.btn_ref	,"->"
		,	this.btn_eval
		]
	});

	this.do_show_form_eval = function ()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}
		m_csm_id_proyek			= r.data["id"];
		m_csm_id_kontraktor		= r.data["id_kontraktor"];
		m_csm_koef_utama		= r.data["koefisien_utama"];
		m_csm_koef_tambahan		= r.data["koefisien_tambah"];
		m_csm_eval_form.do_load (r);
		m_csm_evaluasi.panel.getLayout().setActiveItem(1);
	}

	this.do_refresh = function ()
	{
		m_csm_store_ps.load ();
		this.store.load ();
	}
}

function CSMEvalFormPenilaian ()
{
	this.form_id_proyek	= new Ext.form.TextField ({
		hidden			:true
	,	name			:"id"
	});

	this.form_id_kontraktor	= new Ext.form.TextField ({
		hidden				:true
	,	name				:"id_kontraktor"
	});

	this.form_name	= new Ext.form.TextField ({
		fieldLabel	:"Proyek"
	,	name		:"name"
	,	readOnly	:true
	,	width		:200
	});

	this.form_kontraktor	= new Ext.form.TextField ({
		fieldLabel			:"Kontraktor"
	,	name				:"nama_kontraktor"
	,	readOnly			:true
	,	width				:200
	});

	this.form_date	= new Ext.form.DateField ({
		fieldLabel	:"Tanggal Evaluasi"
	,	name		:"tanggal"
	,	format		:"Y-m-d"
	,	allowBlank	:false
	});

	this.form_team	= new Ext.form.TextField ({
		fieldLabel	:"Tim Evaluasi"
	,	name		:"team"
	,	allowBlank	:false
	,	width		:200
	});

	this.form_workarea	= new Ext.form.TextField ({
		fieldLabel		:"Lokasi Evaluasi"
	,	name			:"work_area"
	,	allowBlank		:false
	,	width			:200
	});

	this.form_total		= new Ext.form.NumberField ({
			fieldLabel	:"Total Nilai"
		,	name		:"score"
		,	readOnly	:true
		});

	this.form_ps		= new Ext.form.ComboBox ({
		fieldLabel		:"Penghargaan/Sanksi"
	,	store			:m_csm_store_ps
	,	valueField		:"id"
	,	displayField	:"keterangan"
	,	dataIndex		:"penghargaan_sanksi"
	,	readOnly		:true
	,	width			:400
	});

	this.panel 		= new Ext.form.FormPanel ({
		labelAlign	:"right"
	,	labelWidth	:160
	,	padding		:10
	,	items		:[
			this.form_id_proyek
		,	this.form_id_kontraktor
		,	this.form_name
		,	this.form_date
		,	this.form_team
		,	this.form_workarea
		,	this.form_kontraktor
		,	this.form_total
		,	this.form_ps
		]
	});

	this.set_total = function (v)
	{
		this.form_ps.setValue (m_csm_store_ps.get_keterangan (v));
		this.form_total.setValue (v);
	}
}

function CSMEvalFaktorPenilaian (id_faktor, title)
{
	this.id_faktor	= id_faktor;
	this.title		= title;
	this.koefisien	= 0.0;
	this.total		= 0.0;

	this.fields = new Ext.data.Record.create ([
		{name:"id"}
	,	{name:"faktor"}
	,	{name:"satuan"}
	,	{name:"hasil_pantauan", type:"int"}
	,	{name:"keterangan"}
	]);

	this.fields_satuan = new Ext.data.Record.create ([
		"nilai"
	,	"mark"
	]);

	this.reader	= new Ext.data.JsonReader ({
		root	:"faktors"
	}, this.fields);

	this.reader_satuan = new Ext.data.JsonReader (
		{}
	,	this.fields_satuan
	);

	this.store					= new Ext.data.Store ({
		url						:m_csm_eval_d +"data_penilaian.jsp"
	,	reader					:this.reader
	,	pruneModifiedRecords	:true
	,	autoLoad				:false
	});

	this.store_satuan	= new Ext.data.Store ({
		reader			:this.reader_satuan
	,	autoLoad		:false
	,	data			:{}
	});

	this.form_hasil_pantauan = new Ext.form.ComboBox ({
		store			:this.store_satuan
	,	forceSelection	:true
	,	resizeable		:true
	,	valueField		:"nilai"
	,	displayField	:"mark"
	,	triggerAction	:"all"
	,	mode			:"local"
	,	listWidth		:500
	});

	this.form_keterangan = new Ext.form.TextField();

	this.cm		= new Ext.grid.ColumnModel ({
		columns	:[
			new Ext.grid.RowNumberer()
		,{
			header		:this.title
		,	dataIndex	:"faktor"
		,	width		:300
		,	summaryRenderer	:function(v, p, o) {
				var k = 0;
				if (id_faktor == 1) {
					k = m_csm_eval_form.grid_utama.koefisien;
				} else {
					k = m_csm_eval_form.grid_tambahan.koefisien;
				}
				return "<center>(Koefisien : "+ k +")</center>";
			}
	},{
			header			:"Hasil Pantauan"
		,	dataIndex		:"hasil_pantauan"
		,	align			:"center"
		,	width			:80
		,	summaryType		:"sum"
		,	editor			:this.form_hasil_pantauan
		,	listeners		:{
				scope		:this
			,	dblclick	:function (col, grid, rowidx, e) {
					var r = this.sm.getSelected();
					col.editor.store.loadData(r.data["satuan"]);
				}
			}
		},{
			header			:"Keterangan"
		,	dataIndex		:"keterangan"
		,	id				:"keterangan"
		,	scope			:this
		,	editor			:this.form_keterangan
		,	summaryRenderer	:function(v, p, o, scope) {
				scope.total = (o.data.hasil_pantauan * scope.koefisien);

				var total = (m_csm_eval_form.grid_utama.total
						+ m_csm_eval_form.grid_tambahan.total);

				total = total.toFixed (2);
				m_csm_eval_form.form.set_total(total);

				return "<center>("+ scope.total.toFixed(2) +")</center>";
			}
		}]
	});

	this.sm				= new Ext.grid.RowSelectionModel({
		singleSelect	:true
	});

	this.summary = new Ext.ux.grid.GridSummary({scope:this});

	this.panel				= new Ext.grid.EditorGridPanel ({
		store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	plugins				:[this.summary]
	,	autoHeight			:true
	,	autoExpandColumn	:"keterangan"
	});

	this.do_refresh = function (koefisien)
	{
		this.koefisien = koefisien;

		this.store.load ({
			scope		:this
		,	params		:{
				id_proyek		:m_csm_id_proyek
			,	id_faktor		:this.id_faktor
			}
		,	callback	:function(records, options, success) {
				if (!success) {
					return;
				}
				this.cm.setColumnHeader(1, this.title);
				this.summary.refreshSummary();
			}
		});
	}

	this.get_data_penilaian = function()
	{
		this.nilai = [];

		var mr = this.store.getModifiedRecords();
		if (!mr || mr.length <= 0) {
			return this.nilai;
		}

		var x;
		for (var i = 0; i < mr.length; i++) {
			x		= {};
			x.id	= mr[i].data["id"];
			x.nilai	= mr[i].data["hasil_pantauan"];
			x.ket	= mr[i].data["keterangan"];

			this.nilai.push(x);
		}

		return this.nilai;
	}
}

/*
 * main panel
 */
function CSMEvalForm ()
{
	this.btn_back		= k3pl.button.Back (this);
	this.btn_ref		= k3pl.button.Refresh (this);
	this.btn_save		= k3pl.button.Save (this);
	this.form			= new CSMEvalFormPenilaian ();
	this.grid_utama		= new CSMEvalFaktorPenilaian (1, "Faktor Utama");
	this.grid_tambahan	= new CSMEvalFaktorPenilaian (2, "Faktor Tambahan");

	this.panel		= new Ext.Panel ({
		title		:"Form Evaluasi"
	,	autoScroll	:true
	,	defaults	:{
			width		:"94%"
		,	style		:{
				marginTop		:"10px"
			,	marginRight		:"auto"
			,	marginLeft		:"auto"
			,	marginBottom	:"10px"
			}
		}
	,	items		:[
			this.form.panel
		,	this.grid_utama.panel
		,	this.grid_tambahan.panel
		]
	,	tbar		:[
			this.btn_back	, "-"
		,	this.btn_ref	, "->"
		,	this.btn_save
		]
	});

	this.do_back = function ()
	{
		m_csm_eval_list.do_refresh();
		m_csm_evaluasi.panel.getLayout().setActiveItem(0);
	}

	this.do_refresh = function ()
	{
		this.grid_utama.do_refresh (m_csm_koef_utama);
		this.grid_tambahan.do_refresh (m_csm_koef_tambahan);
	}

	this.do_load = function (r)
	{
		this.form.panel.getForm ().loadRecord (r);
		this.do_refresh ();
	}

	this.do_save = function ()
	{
		if (!this.form.panel.getForm().isValid()) {
			Ext.Msg.alert("Kesalahan","Form belum diisi semuanya!");
			return;
		}

		var total = parseFloat(this.grid_utama.total)
				+ parseFloat(this.grid_tambahan.total);

		var nilai_utama		= this.grid_utama.get_data_penilaian ();
		var nilai_tambahan	= this.grid_tambahan.get_data_penilaian ();

		Ext.Ajax.request({
			url		:m_csm_eval_d +"submit_evaluasi.jsp"
		,	params  :{
				id_proyek		:m_csm_id_proyek
			,	tanggal			:this.form.form_date.getValue()
			,	team			:this.form.form_team.getValue()
			,	work_area		:this.form.form_workarea.getValue()
			,	score			:total.toFixed (2)
			,	nilai_utama		:Ext.encode (nilai_utama)
			,	nilai_tambahan	:Ext.encode (nilai_tambahan)
			}
		,	waitMsg	:'Mohon Tunggu ...'
		,	scope	:this
		,	failure	:function (resp) {
				Ext.Msg.alert(resp);
			}
		,	success :function (resp) {
				var msg = Ext.util.JSON.decode(resp.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
					return;
				}
				Ext.Msg.alert('Informasi', msg.info);

				this.do_refresh();
			}
		});
	}
}

function CSMEvaluasi ()
{
	m_csm_eval_list = new CSMEvalList ();
	m_csm_eval_form = new CSMEvalForm ();

	this.panel		= new Ext.Panel ({
		layout		:"card"
	,	activeItem	:0
	,	items		:[
			m_csm_eval_list.panel
		,	m_csm_eval_form.panel
		]
	});

	this.do_refresh = function ()
	{
		m_csm_eval_list.do_refresh();
	}
}

m_csm_evaluasi = new CSMEvaluasi ();

//@ sourceURL=csm_evaluasi.layout.js
