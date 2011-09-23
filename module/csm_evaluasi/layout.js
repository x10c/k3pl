/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_csm_evaluasi;
var m_csm_eval_d = _g_root +"/module/csm_evaluasi/";
var m_ref_csm_d = _g_root +"/module/ref_csm/";
var m_csm_eval_list;
var m_csm_eval_form;
var m_csm_eval_id_proyek;

var m_csm_store_ps	= new Ext.data.ArrayStore({
	url				: m_ref_csm_d +"data_eval_ps.jsp"
,	fields			:["id","min","max","keterangan"]
,	idIndex			:0
,	autoLoad		:false
});

function CSMEvalList()
{
	this.fields = new Ext.data.Record.create ([
		"id"
	,	"name"
	,	"id_kontraktor"
	,	"nama_kontraktor"
	,	"weighted_score"
	,	"penghargaan_sanksi"
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
			header		:"Weighted Score"
		,	dataIndex	:"weighted_score"
		,	align		:"center"
		},{
			header		:"Penghargaan / Sanksi"
		,	dataIndex	:"penghargaan_sanksi"
		,	renderer	:store_renderer("id", "keterangan", m_csm_store_ps)
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
		m_csm_eval_id_proyek = r.data["id"];
		m_csm_eval_form.do_refresh ();
		m_csm_evaluasi.panel.getLayout().setActiveItem(1);
	}

	this.do_refresh = function ()
	{
		m_csm_store_ps.load ();
		this.store.load ();
	}
}

function CSMEvalForm ()
{
	this.form_id_proyek = new Ext.form.TextField ({
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

	this.form_ps	= new Ext.form.ComboBox ({
		fieldLabel		:"Penghargaan/Sanksi"
	,	store			:m_csm_store_ps
	,	valueField		:"id"
	,	displayField	:"keterangan"
	,	dataIndex		:"penghargaan_sanksi"
	,	readOnly		:true
	,	width			:400
	});

	this.form 		= new Ext.form.FormPanel ({
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
		,	this.form_ps
		]
	});
/*
 * grid
 */
	this.fields	= new Ext.data.Record.create ([
		"id"
	,	"element"
	,	"weight_factor"
	,	"nilai"
	,	"weighted_score"
	]);

	this.reader	= new Ext.data.JsonReader ({
		root	:"evaluasi"
	}, this.fields);

	this.store		= new Ext.data.Store ({
		reader		:this.reader
	,	autoLoad	:false
	});

	this.store_nilai	= new Ext.data.ArrayStore ({
		url				:m_csm_eval_d +"data_eval_si.jsp"
	,	fields			:["score", "keterangan"]
	,	autoLoad		:false
	});

	this.form_nilai = new Ext.form.ComboBox ({
		store			:this.store_nilai
	,	forceSelection	:true
	,	resizeable		:true
	,	valueField		:"score"
	,	displayField	:"keterangan"
	,	triggerAction	:"all"
	,	mode			:"local"
	,	listWidth		:400
	,	listeners		:{
			scope		:this
		,	select		:function (combo, record, idx) {
				var v = parseFloat(combo.getValue());
				if (!v) {
					return;
				}
				var r = this.sm.getSelected();
				if (!r) {
					return;
				}
				v = v * parseFloat(r.get("weight_factor"));
				r.set("weighted_score", v.toFixed(2));
				combo.collapse();
			}
		}
	});

	this.sm				= new Ext.grid.RowSelectionModel ({
		singleSelect	:true
	});

	this.cm		= new Ext.grid.ColumnModel ({
		columns	:[
			new Ext.grid.RowNumberer()
		,{
			header		:"Evaluasi Elements"
		,	dataIndex	:"element"
		,	id			:"element"
		},{
			header		:"Weight Factor"
		,	dataIndex	:"weight_factor"
		,	align		:"center"
		,	summaryRenderer	:function(v, p, o, scope) {
				return "<center>Total:</center>";
			}
		},{
			header		:"Raw Score"
		,	dataIndex	:"nilai"
		,	align		:"center"
		,	summaryType	:"sum"
		,	editor		:this.form_nilai
		},{
			header		:"Weighted Score"
		,	dataIndex	:"weighted_score"
		,	align		:"center"
		,	summaryType	:"sum"
		,	summaryRenderer	:function(v, p, o, scope) {
				scope.total	= o.data.weighted_score;

				m_csm_store_ps.each (function (r) {
					if (this.total >= r.data["min"]
					&&  this.total <= r.data["max"]) {
						this.form_ps.setValue(r.data["id"]);
						return true;
					}
				}, scope);

				return scope.total.toFixed(2);
			}
		}]
	});

	this.summary = new Ext.ux.grid.GridSummary({scope:this});

	this.grid				= new Ext.grid.EditorGridPanel ({
		store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	plugins				:[this.summary]
	,	autoHeight			:true
	,	autoExpandColumn	:"element"
	});
/*
 * main panel
 */
	this.btn_back	= k3pl.button.Back (this);
	this.btn_ref	= k3pl.button.Refresh (this);
	this.btn_save	= k3pl.button.Save (this);

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
			this.form
		,	this.grid
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
		Ext.Ajax.request({
			params  :{
				id_proyek:m_csm_eval_id_proyek
			}
		,	url		:m_csm_eval_d +"data_evaluasi.jsp"
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

				this.store_nilai.load();

				this.form.getForm().setValues(msg);
				this.store.loadData(msg);
			}
		});
	}

	this.do_save = function ()
	{
		if (!this.form.getForm().isValid()) {
			Ext.Msg.alert("Kesalahan","Form belum diisi semuanya!");
			return;
		}
		var cfg				= this.cm.config;
		var raw_score		= 0.0;
		var weighted_score	= 0.0;
		var mr				= this.store.getModifiedRecords();
		var i				= 0;
		var e				= {};
		var eval			= [];

		raw_score 		= parseFloat(cfg[3].value);
		weighted_score	= parseFloat(cfg[4].value);

		for (; i < mr.length; i++) {
			e		= {};
			e.id	= mr[i].data["id"];
			e.nilai	= mr[i].data["nilai"];

			eval.push(e);
		}

		Ext.Ajax.request({
			params  :{
				id_proyek		:m_csm_eval_id_proyek
			,	tanggal			:this.form_date.getValue()
			,	team			:this.form_team.getValue()
			,	work_area		:this.form_workarea.getValue()
			,	raw_score		:raw_score
			,	weighted_score	:weighted_score
			,	penghargaan		:this.form_ps.getValue()
			,	evaluasi		:Ext.encode(eval)
			}
		,	url		:m_csm_eval_d +"submit_evaluasi.jsp"
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
