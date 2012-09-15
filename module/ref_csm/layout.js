/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_ref_csm;
var m_ref_csm_d = _g_root +"/module/ref_csm/";
var m_ref_csm_perfevalsi;
var m_ref_csm_perfeval_ps;
var m_ref_csm_nilai_utama;
var m_ref_csm_nilai_tambah;
var m_ref_csm_penilaian;
var m_ref_csm_penilaian_elemen;
var m_ref_csm_penilaian_detail;
var m_ref_csm_penilaian_detail2;
var m_ref_csm_penilaian_penilaian;
var m_ref_csm_penilaian_id_elemen;
var m_ref_csm_penilaian_id_detail;
var m_ref_csm_penilaian_id_detail2;
var m_ref_csm_ha_level = 0;

function RefCSMPerfEvalSI ()
{
	this.fields = new Ext.data.Record.create ([
		"id", "min", "max", "keterangan"
	]);

	this.store	= new Ext.data.ArrayStore ({
		url		:m_ref_csm_d +"data_perf_eval_SI.jsp"
	,	fields	:this.fields
	,	autoLoad:false
	});

	this.form_min			= new Ext.form.NumberField({
			allowBlank		:false
		,	allowNegative	:false
		});

	this.form_max			= new Ext.form.NumberField({
			allowBlank		:false
		,	allowNegative	:false
		});

	this.form_ket		= new Ext.form.TextField({
		allowBlank		:false
	});

	this.cm		= new Ext.grid.ColumnModel ({
		columns	:[{
			header		:"Nilai Min."
		,	dataIndex	:"min"
		,	align		:"center"
		,	width		:100
		,	editor		:this.form_min
		},{
			header		:"Nilai Maks."
		,	dataIndex	:"max"
		,	align		:"center"
		,	width		:100
		,	editor		:this.form_max
		},{
			header		:"Keterangan"
		,	id			:"keterangan"
		,	dataIndex	:"keterangan"
		,	editor		:this.form_ket
		}]
	});

	this.sm		= new Ext.grid.RowSelectionModel ({
		singleSelect	:true
	});

	this.editor	= MyRowEditor (this);
	this.btn_del = k3pl.button.Delete (this);
	this.btn_ref = k3pl.button.Refresh (this);
	this.btn_add = k3pl.button.Add (this);

	this.panel				= new Ext.grid.GridPanel ({
		title				:"Evaluasi - Score Index"
	,	autoExpandColumn	:"keterangan"
	,	store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	plugins				:[this.editor]
	,	tbar				:[
			this.btn_del	, "-"
		,	this.btn_ref	, "-"
		,	this.btn_add
		]
	,	listeners			:{
			scope			:this
		,	rowdblclick		:function (grid, row, e) {
				this.do_edit (row);
			}
		}
	});

	this.do_refresh = function ()
	{
		this.store.load ();
	}

	this.do_del = function ()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		this.dml = 4;
		this.do_save (r);
	}

	this.do_edit = function ()
	{
		this.dml = 3;
	}

	this.do_add = function ()
	{
		this.record_new = new this.fields({
				id			:''
			,	min			:0.0
			,	max			:0.0
			,	keterangan	:''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml = 2;
	}

	this.do_cancel = function ()
	{
		if (this.dml == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function (r)
	{
		Ext.Ajax.request({
			params  :{
				id			:r.data['id']
			,	min			:r.data['min']
			,	max			:r.data['max']
			,	keterangan	:r.data['keterangan']
			,	dml			:this.dml
			}
		,	url		:m_ref_csm_d +'submit_perf_eval_SI.jsp'
		,	waitMsg	:'Mohon Tunggu ...'
		,	scope	:this
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.store.load();
				}
		});
	}
}

function RefCSMPerfEvalPS ()
{
	this.fields = new Ext.data.Record.create ([
		"id"
	,	"nilai_min"
	,	"nilai_max"
	,	"keterangan"
	]);

	this.store	= new Ext.data.ArrayStore ({
		url		:m_ref_csm_d +"data_eval_ps.jsp"
	,	fields	:this.fields
	,	autoLoad:false
	});

	this.form_nilai_min	= new Ext.form.NumberField ({
		allowBlank		:false
	,	allowNegative	:false
	});

	this.form_nilai_max	= new Ext.form.NumberField ({
		allowBlank		:false
	,	allowNegative	:false
	});

	this.form_ket = new Ext.form.TextField ({
		allowBlank		:false
	});

	this.cm		= new Ext.grid.ColumnModel ({
		columns	:[{
			header		:"Nilai Min."
		,	dataIndex	:"nilai_min"
		,	align		:"center"
		,	editor		:this.form_nilai_min
		},{
			header		:"Nilai Maks."
		,	dataIndex	:"nilai_max"
		,	align		:"center"
		,	editor		:this.form_nilai_max
		},{
			header		:"Penghargaan/Sanksi"
		,	dataIndex	:"keterangan"
		,	id			:"ket"
		,	editor		:this.form_ket
		}]
	});

	this.editor		= MyRowEditor (this);
	this.btn_del	= k3pl.button.Delete (this);
	this.btn_edit	= k3pl.button.Edit (this);
	this.btn_ref	= k3pl.button.Refresh (this);
	this.btn_add	= k3pl.button.Add (this);

	this.sm				= new Ext.grid.RowSelectionModel ({
		singleSelect	:true
	});

	this.panel				= new Ext.grid.GridPanel ({
		title				:"Evaluasi - Penghargaan/Sanksi"
	,	store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	plugins				:this.editor
	,	autoExpandColumn	:"ket"
	,	tbar				:[
			this.btn_del	,"-"
		,	this.btn_edit	,"-"
		,	this.btn_ref	,"-"
		,	this.btn_add
		]
	,	listeners			:{
			scope		:this
		,	rowdblclick	:function (grid, rowidx, e) {
				this.do_edit (rowidx);
			}
		}
	});

	this.do_del = function ()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		Ext.Msg.confirm ("Penghapusan Data"
		,"Apakah anda yakin akan menghapus data ?"
		,function (btn_id, text, opt) {
			if (btn_id == 'yes') {
				this.dml = 4;
				this.do_save (r);
			}
		}
		,this);
	}

	this.do_edit = function (rowidx)
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		this.dml = 3;
		this.editor.startEditing (r, true);
	}

	this.do_refresh = function ()
	{
		this.store.load ();
	}

	this.do_add = function ()
	{
		this.record_new = new this.fields({
				id			:0
			,	keterangan	:''
			,	nilai_min	:0
			,	nilai_max	:0
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml = 2;
	}

	this.do_cancel = function ()
	{
		if (this.dml == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function (r)
	{
		Ext.Ajax.request({
			params  :{
				id			:r.data['id']
			,	keterangan	:r.data['keterangan']
			,	nilai_min	:r.data['nilai_min']
			,	nilai_max	:r.data['nilai_max']
			,	dml			:this.dml
			}
		,	url		:m_ref_csm_d +'submit_eval_ps.jsp'
		,	waitMsg	:'Mohon Tunggu ...'
		,	scope	:this
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
				}

				this.do_refresh ();
			}
		});
	}
}

function RefCSMEvaluasiDetail ()
{
	this.id_penilaian = 0;

	this.fields	= new Ext.data.Record.create([
		"id"
	,	"id_penilaian"
	,	"nilai"
	,	"keterangan"
	]);

	this.store		= new Ext.data.ArrayStore ({
		url			:m_ref_csm_d +"data_penilaian_detail.jsp"
	,	fields		:this.fields
	,	autoLoad	:false
	});

	this.form_nilai		= new Ext.form.NumberField ({
		allowBlank		:false
	,	allowNegative	:false
	,	allowNegative	:false
	});

	this.form_ket	= new Ext.form.TextField ({
		allowBlank	:false
	});

	this.cm		= new Ext.grid.ColumnModel ({
		columns	:[{
			header		:"Nilai"
		,	dataIndex	:"nilai"
		,	editor		:this.form_nilai
		},{
			header		:"Keterangan"
		,	dataIndex	:"keterangan"
		,	id			:"keterangan"
		,	editor		:this.form_ket
		}]
	});

	this.sm				= new Ext.grid.RowSelectionModel ({
		singleSelect	:true
	});

	this.editor		= MyRowEditor (this);
	this.btn_add	= k3pl.button.Add (this);
	this.btn_edit	= k3pl.button.Edit (this);
	this.btn_ref	= k3pl.button.Refresh (this);
	this.btn_del	= k3pl.button.Delete (this);

	this.panel				= new Ext.grid.GridPanel({
		region				:"center"
	,	store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	plugins				:[this.editor]
	,	autoExpandColumn	:"keterangan"
	,	tbar				:[
			this.btn_del	,"-"
		,	this.btn_edit	,"-"
		,	this.btn_ref	,"-"
		,	this.btn_add
		]
	,	listeners			:{
			scope		:this
		,	rowdblclick	:function (grid, rowidx, e) {
				this.do_edit (rowidx);
			}
		}
	});

	this.do_del = function ()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		Ext.Msg.confirm ("Penghapusan Data"
		,"Apakah anda yakin akan menghapus data ?"
		,function (btn_id, text, opt) {
			if (btn_id == 'yes') {
				this.dml = 4;
				this.do_save (r);
			}
		}
		,this);
	}

	this.do_edit = function (rowidx)
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		this.dml = 3;
		this.editor.startEditing (r, true);
	}

	this.do_refresh = function ()
	{
		this.store.load ({
			params	:{
				id_penilaian	:this.id_penilaian
			}
		});
	}

	this.do_add = function ()
	{
		this.record_new = new this.fields({
				id			:0
			,	id_penilaian:this.id_penilaian
			,	nilai		:0
			,	keterangan	:''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml = 2;
	}

	this.do_cancel = function ()
	{
		if (this.dml == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function (r)
	{
		Ext.Ajax.request({
			params  :{
				id				:r.data['id']
			,	id_penilaian	:this.id_penilaian
			,	nilai			:r.data['nilai']
			,	keterangan		:r.data['keterangan']
			,	dml				:this.dml
			}
		,	url		:m_ref_csm_d +'submit_penilaian_detail.jsp'
		,	waitMsg	:'Mohon Tunggu ...'
		,	scope	:this
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
				}

				this.do_refresh ();
			}
		});
	}
}

function RefCSMEvaluasi (id_faktor, detail)
{
	this.id_faktor	= id_faktor;
	this.dml		= 0;
	this.detail		= detail;

	this.fields	= new Ext.data.Record.create([
		"id"
	,	"id_faktor"
	,	"keterangan"
	]);

	this.store	= new Ext.data.ArrayStore({
		url		:m_ref_csm_d +"data_penilaian.jsp"
	,	fields	:this.fields
	,	autoLoad:false
	});

	this.form_ket	= new Ext.form.TextField({
		allowBlank	:false
	});

	this.cm	= new Ext.grid.ColumnModel ({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		:"Keterangan"
		,	dataIndex	:"keterangan"
		,	id			:"keterangan"
		,	editor		:this.form_ket
		}]
	});

	this.sm				= new Ext.grid.RowSelectionModel({
		singleSelect	:true
	});

	this.editor		= MyRowEditor (this);

	this.btn_add	= k3pl.button.Add (this);
	this.btn_ref	= k3pl.button.Refresh (this);
	this.btn_edit	= k3pl.button.Edit (this);
	this.btn_del	= k3pl.button.Delete (this);

	this.panel				= new Ext.grid.GridPanel ({
		region				:"north"
	,	height				:300
	,	split				:true
	,	store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	plugins				:[this.editor]
	,	autoExpandColumn	:"keterangan"
	,	tbar				:[
			this.btn_del	,"-"
		,	this.btn_edit	,"-"
		,	this.btn_ref	,"-"
		,	this.btn_add
		]
	,	listeners			:{
			scope		:this
		,	rowclick	:function (grid, rowidx, e) {
				var r = this.sm.getSelected();
				if (!r) {
					return;
				}

				this.detail.id_penilaian = r.data["id"];
				this.detail.do_refresh ();
			}
		,	rowdblclick	:function (grid, rowidx, e) {
				this.do_edit (rowidx);
			}
		}
	});

	this.do_del = function ()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		Ext.Msg.confirm ("Penghapusan Data"
		,"Apakah anda yakin akan menghapus data ?"
		,function (btn_id, text, opt) {
			if (btn_id == 'yes') {
				this.dml = 4;
				this.do_save (r);
			}
		}
		,this);
	}

	this.do_edit = function (rowidx)
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		this.dml = 3;
		this.editor.startEditing (r, true);
	}

	this.do_refresh = function ()
	{
		this.store.load ({
			params	:{
				id_faktor	:this.id_faktor
			}
		});
	}

	this.do_add = function ()
	{
		this.record_new = new this.fields({
				id			:0
			,	id_faktor	:this.id_faktor
			,	keterangan	:''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml = 2;
	}

	this.do_cancel = function ()
	{
		if (this.dml == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function (r)
	{
		Ext.Ajax.request({
			params  :{
				id			:r.data['id']
			,	id_faktor	:this.id_faktor
			,	keterangan	:r.data['keterangan']
			,	dml			:this.dml
			}
		,	url		:m_ref_csm_d +'submit_penilaian.jsp'
		,	waitMsg	:'Mohon Tunggu ...'
		,	scope	:this
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
				}

				this.do_refresh ();
			}
		});
	}
}

function RefCSMEvaluasiMD (id, title)
{
	this.detail = new RefCSMEvaluasiDetail ();
	this.master = new RefCSMEvaluasi (id, this.detail);

	this.panel	= new Ext.Panel ({
		title	:title
	,	layout	:"border"
	,	items	:[
			this.master.panel
		,	this.detail.panel
		]
	});

	this.do_refresh = function ()
	{
		this.master.do_refresh ();
		this.detail.id_penilaian = 0;
		this.detail.do_refresh ();
	}
}

function elemen_on_select_load_detail ()
{
	if (typeof m_ref_csm_penilaian_elemen == 'undefined') {
		return;
	}
	m_ref_csm_penilaian_detail.do_load ();
	m_ref_csm_penilaian_detail2.store.removeAll ();
	m_ref_csm_penilaian_penilaian.store.removeAll ();
}

function detail_on_select_load_detail2 ()
{
	if (typeof m_ref_csm_penilaian_id_elemen == 'undefined'
	||  typeof m_ref_csm_penilaian_id_detail == 'undefined') {
		return;
	}
	m_ref_csm_penilaian_detail2.do_load ();
	m_ref_csm_penilaian_penilaian.store.removeAll ();
}

function detail2_on_select_load_penilaian ()
{
	if (typeof m_ref_csm_penilaian_id_elemen == 'undefined'
	||  typeof m_ref_csm_penilaian_id_detail == 'undefined'
	||  typeof m_ref_csm_penilaian_id_detail2 == 'undefined') {
		return;
	}
	m_ref_csm_penilaian_penilaian.do_load ();
}

function RefCSMPenilaian_elemen ()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
		{ name	: 'id' }
	,	{ name	: 'elemen' }
	,	{ name	: 'nilai' }
	]);

	this.store = new Ext.data.ArrayStore ({
			fields	: this.record
		,	url		: m_ref_csm_d +'data_penilaian_elemen.jsp'
		,	autoLoad: false
	});

	this.form_elemen = new Ext.form.TextField ({
			allowBlank	: false
		});

	this.form_nilai = new Ext.form.NumberField ({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Elemen Penilaian'
		,	id			: 'elemen'
		,	dataIndex	: 'elemen'
		,	sortable	: true
		,	editor		: this.form_elemen
		,	width		: 100
		},{
			header		: 'Maks'
		,	id			: 'nilai'
		,	dataIndex	: 'nilai'
		,	sortable	: true
		,	editor		: this.form_nilai
		,	width		: 60
		}];

	this.sm = new Ext.grid.RowSelectionModel ({
			singleSelect	: true
		,	listeners		: {
				scope			: this
			,	rowselect		: function (sm, row_id, r) {
					if (m_ref_csm_ha_level == 4) {
						this.btn_del.setDisabled (false);
					}
					m_ref_csm_penilaian_id_elemen = r.data['id'];

					elemen_on_select_load_detail();
				}
			}
		});

	this.editor		= new MyRowEditor(this);
	this.btn_add	= k3pl.button.Add (this);
	this.btn_ref	= k3pl.button.Refresh (this);
	this.btn_del	= k3pl.button.Delete (this);

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		});

	this.grid = new Ext.grid.GridPanel({
			title		: 'Elemen Penilaian'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'elemen'
		,	listeners	: {
				scope		: this
			,	rowdblclick	: function (g, r, e) {
					return this.do_edit (r);
				}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id		: 0
			,	elemen	: ''
			,	nilai	: 0
			});

		this.editor.stopEditing ();
		this.store.insert (0, this.record_new);
		this.sm.selectRow (0);
		this.editor.startEditing (0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save (data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id		: record.data['id']
			,	elemen	: record.data['elemen']
			,	nilai	: record.data['nilai']
			,	dml		: this.dml_type
			}
		,	url		: m_ref_csm_d +'submit_penilaian_elemen.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success	:
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_ref_csm_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		m_ref_csm_penilaian_detail.store.removeAll ();
		m_ref_csm_penilaian_detail2.store.removeAll ();
		m_ref_csm_penilaian_penilaian.store.removeAll ();

		this.store.load({
			scope	:this
		,	callback: function(r,options,success) {
				if (!success) {
					return;
				}
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_csm_ha_level <= 1) {
			this.btn_add.setDisabled (true);
		} else {
			this.btn_add.setDisabled (false);
		}
		this.btn_del.setDisabled (true);

		this.do_load();
	}
}

function RefCSMPenilaian_detail ()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
		{ name	: 'id' }
	,	{ name	: 'elemen' }
	]);

	this.store = new Ext.data.ArrayStore ({
			fields	: this.record
		,	url		: m_ref_csm_d +'data_penilaian2_detail.jsp'
		,	autoLoad: false
	});

	this.form_elemen = new Ext.form.TextField ({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Elemen Penilaian'
		,	id			: 'elemen'
		,	dataIndex	: 'elemen'
		,	sortable	: true
		,	editor		: this.form_elemen
		,	width		: 100
		}];

	this.sm = new Ext.grid.RowSelectionModel ({
			singleSelect	: true
		,	listeners		: {
				scope			: this
			,	rowselect		: function (sm, row_id, r) {
					if (m_ref_csm_ha_level == 4) {
						this.btn_del.setDisabled (false);
					}
					m_ref_csm_penilaian_id_detail = r.data['id'];

					detail_on_select_load_detail2 ();
				}
			}
		});

	this.editor		= new MyRowEditor (this);
	this.btn_add	= k3pl.button.Add (this);
	this.btn_ref	= k3pl.button.Refresh (this);
	this.btn_del	= k3pl.button.Delete (this);

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		});

	this.grid = new Ext.grid.GridPanel({
			title			: 'Elemen Penilaian - Detail'
		,	store			: this.store
		,	sm				: this.sm
		,	columns			: this.columns
		,	plugins			: this.editor
		,	tbar			: this.toolbar
		,	autoExpandColumn: 'elemen'
		,	listeners		: {
				scope			: this
			,	rowdblclick		: function (g, r, e) {
					return this.do_edit (r);
				}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id		: 0
			,	elemen	: ''
			});

		this.editor.stopEditing ();
		this.store.insert (0, this.record_new);
		this.sm.selectRow (0);
		this.editor.startEditing (0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save (data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id				: record.data['id']
			,	id_penilaian	: m_ref_csm_penilaian_id_elemen
			,	elemen			: record.data['elemen']
			,	dml				: this.dml_type
			}
		,	url		: m_ref_csm_d +'submit_penilaian2_detail.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success	:
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_ref_csm_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function ()
	{	
		if (m_ref_csm_penilaian_id_elemen == 0) {
			this.store.removeAll ();
			return;
		}

		m_ref_csm_penilaian_detail2.store.removeAll ();
		m_ref_csm_penilaian_penilaian.store.removeAll ();

		this.store.load ({
			scope	:this
		,	params	: {
				id_elemen	: m_ref_csm_penilaian_id_elemen
			}
		,	callback: function (r,options,success) {
				if (!success) {
					return;
				}
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_csm_ha_level <= 1) {
			this.btn_add.setDisabled (true);
		} else {
			this.btn_add.setDisabled (false);
		}
		this.btn_del.setDisabled (true);

		this.do_load ();
	}
}

function RefCSMPenilaian_detail2 ()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
		{ name	: 'id' }
	,	{ name	: 'elemen' }
	]);

	this.store = new Ext.data.ArrayStore ({
			fields	: this.record
		,	url		: m_ref_csm_d +'data_penilaian2_detail2.jsp'
		,	autoLoad: false
	});

	this.form_elemen = new Ext.form.TextField ({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Elemen Penilaian'
		,	id			: 'elemen'
		,	dataIndex	: 'elemen'
		,	sortable	: true
		,	editor		: this.form_elemen
		,	width		: 100
		}];

	this.sm = new Ext.grid.RowSelectionModel ({
			singleSelect	: true
		,	listeners		: {
				scope			: this
			,	rowselect		: function (sm, row_id, r) {
					if (m_ref_csm_ha_level == 4) {
						this.btn_del.setDisabled (false);
					}
					m_ref_csm_penilaian_id_detail2 = r.data['id'];

					detail2_on_select_load_penilaian ();
				}
			}
		});

	this.editor		= new MyRowEditor (this);
	this.btn_add	= k3pl.button.Add (this);
	this.btn_ref	= k3pl.button.Refresh (this);
	this.btn_del	= k3pl.button.Delete (this);

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		});

	this.grid = new Ext.grid.GridPanel({
			title			: 'Elemen Penilaian - Detail 2'
		,	store			: this.store
		,	sm				: this.sm
		,	columns			: this.columns
		,	plugins			: this.editor
		,	tbar			: this.toolbar
		,	autoExpandColumn: 'elemen'
		,	listeners		: {
				scope			: this
			,	rowdblclick		: function (g, r, e) {
					return this.do_edit (r);
				}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id		: 0
			,	elemen	: ''
			});

		this.editor.stopEditing ();
		this.store.insert (0, this.record_new);
		this.sm.selectRow (0);
		this.editor.startEditing (0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save (data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id				: record.data['id']
			,	id_penilaian	: m_ref_csm_penilaian_id_elemen
			,	id_detail		: m_ref_csm_penilaian_id_detail
			,	elemen			: record.data['elemen']
			,	dml				: this.dml_type
			}
		,	url		: m_ref_csm_d +'submit_penilaian2_detail2.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success	:
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_ref_csm_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function ()
	{	
		if (m_ref_csm_penilaian_id_elemen == 0
		||  m_ref_csm_penilaian_id_detail == 0) {
			this.store.removeAll ();
			return;
		}

		m_ref_csm_penilaian_penilaian.store.removeAll ();

		this.store.load ({
			scope	:this
		,	params	: {
				id_elemen	: m_ref_csm_penilaian_id_elemen
			,	id_detail	: m_ref_csm_penilaian_id_detail
			}
		,	callback: function (r,options,success) {
				if (!success) {
					return;
				}
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_csm_ha_level <= 1) {
			this.btn_add.setDisabled (true);
		} else {
			this.btn_add.setDisabled (false);
		}
		this.btn_del.setDisabled (true);

		this.do_load ();
	}
}

function RefCSMPenilaian_penilaian ()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
		{ name	: 'id' }
	,	{ name	: 'penilaian' }
	,	{ name	: 'nilai' }
	]);

	this.store = new Ext.data.ArrayStore ({
			fields	: this.record
		,	url		: m_ref_csm_d +'data_penilaian2_penilaian.jsp'
		,	autoLoad: false
	});

	this.form_elemen = new Ext.form.TextField ({
			allowBlank	: false
		});

	this.form_nilai = new Ext.form.NumberField ({
			allowBlank		: false
		,	allowNegative	: false
		,	allowDecimal	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Penilaian'
		,	id			: 'penilaian'
		,	dataIndex	: 'penilaian'
		,	sortable	: true
		,	editor		: this.form_elemen
		,	width		: 100
		},{
			header		: 'Nilai'
		,	id			: 'nilai'
		,	dataIndex	: 'nilai'
		,	sortable	: false
		,	editor		: this.form_nilai
		,	width		: 60
		}];

	this.sm = new Ext.grid.RowSelectionModel ({
			singleSelect	: true
		,	listeners		: {
				scope			: this
			,	rowselect		: function (sm, row_id, r) {
					if (m_ref_csm_ha_level == 4) {
						this.btn_del.setDisabled (false);
					}
				}
			}
		});

	this.editor		= new MyRowEditor (this);
	this.btn_add	= k3pl.button.Add (this);
	this.btn_ref	= k3pl.button.Refresh (this);
	this.btn_del	= k3pl.button.Delete (this);

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		});

	this.grid = new Ext.grid.GridPanel({
			title			: 'Dokumen Penilaian'
		,	store			: this.store
		,	sm				: this.sm
		,	columns			: this.columns
		,	plugins			: this.editor
		,	tbar			: this.toolbar
		,	autoExpandColumn: 'penilaian'
		,	listeners		: {
				scope			: this
			,	rowdblclick		: function (g, r, e) {
					return this.do_edit (r);
				}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id			: 0
			,	penilaian	: ''
			,	nilai		: 0
			});

		this.editor.stopEditing ();
		this.store.insert (0, this.record_new);
		this.sm.selectRow (0);
		this.editor.startEditing (0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save (data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id				: record.data['id']
			,	id_penilaian	: m_ref_csm_penilaian_id_elemen
			,	id_detail		: m_ref_csm_penilaian_id_detail
			,	id_detail2		: m_ref_csm_penilaian_id_detail2
			,	penilaian		: record.data['penilaian']
			,	nilai			: record.data['nilai']
			,	dml				: this.dml_type
			}
		,	url		: m_ref_csm_d +'submit_penilaian2_penilaian.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success	:
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_ref_csm_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function ()
	{
		if (m_ref_csm_penilaian_id_elemen == 0
		||  m_ref_csm_penilaian_id_detail == 0
		||  m_ref_csm_penilaian_id_detail2 == 0) {
			this.store.removeAll ();
			return;
		}
		this.store.load ({
			scope	:this
		,	params	: {
				id_elemen	: m_ref_csm_penilaian_id_elemen
			,	id_detail	: m_ref_csm_penilaian_id_detail
			,	id_detail2	: m_ref_csm_penilaian_id_detail2
			}
		,	callback: function (r,options,success) {
				if (!success) {
					return;
				}
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_csm_ha_level <= 1) {
			this.btn_add.setDisabled (true);
		} else {
			this.btn_add.setDisabled (false);
		}
		this.btn_del.setDisabled (true);

		this.do_load ();
	}
}

function RefCSMPenilaian ()
{
	m_ref_csm_penilaian_elemen		= new RefCSMPenilaian_elemen ();
	m_ref_csm_penilaian_detail		= new RefCSMPenilaian_detail ();
	m_ref_csm_penilaian_detail2		= new RefCSMPenilaian_detail2 ();
	m_ref_csm_penilaian_penilaian	= new RefCSMPenilaian_penilaian ();

	this.panel = new Ext.Panel({
			title		: 'Penilaian'
		,	layout		: 'hbox'
		,	autoScroll	: true
		,	layoutConfig: {
				align		: 'stretch'
			,	pack		: 'start'
			}
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	width			: 300
			,	autoScroll		: true
			}
		,	items		: [
				m_ref_csm_penilaian_elemen.grid
			,	m_ref_csm_penilaian_detail.grid
			,	m_ref_csm_penilaian_detail2.grid
			,	m_ref_csm_penilaian_penilaian.grid
			]
		});

	this.do_refresh = function (ha_level)
	{
		m_ref_csm_ha_level				= ha_level;
		m_ref_csm_penilaian_id_elemen	= 0;
		m_ref_csm_penilaian_id_detail	= 0;
		m_ref_csm_penilaian_id_detail2	= 0;

		m_ref_csm_penilaian_elemen.do_refresh ();
		m_ref_csm_penilaian_detail.do_refresh ();
		m_ref_csm_penilaian_detail2.do_refresh ();
		m_ref_csm_penilaian_penilaian.do_refresh ();
	}
}

function RefCSM ()
{
	m_ref_csm_penilaian		= new RefCSMPenilaian ();
	m_ref_csm_perfevalsi	= new RefCSMPerfEvalSI ();
	m_ref_csm_nilai_utama	= new RefCSMEvaluasiMD (1, "Evaluasi - Faktor Utama");
	m_ref_csm_nilai_tambah	= new RefCSMEvaluasiMD (2, "Evaluasi - Faktor Tambahan");
	m_ref_csm_perfeval_ps	= new RefCSMPerfEvalPS ();

	this.panel = new Ext.TabPanel ({
		id				:"ref_csm_panel"
	,	activeTab		:0
	,	animScroll		:true
	,	autoScroll		:true
	,	enableTabScroll	:true
	,	items			:[
			m_ref_csm_penilaian.panel
		,	m_ref_csm_nilai_utama.panel
		,	m_ref_csm_nilai_tambah.panel
		,	m_ref_csm_perfevalsi.panel
		,	m_ref_csm_perfeval_ps.panel
		]
	});

	this.do_refresh = function (ha_level)
	{
		m_ref_csm_penilaian.do_refresh (ha_level);
		m_ref_csm_perfevalsi.do_refresh ();
		m_ref_csm_nilai_utama.do_refresh ();
		m_ref_csm_nilai_tambah.do_refresh ();
		m_ref_csm_perfeval_ps.do_refresh ();
	}
}

m_ref_csm = new RefCSM ();

//@ sourceURL=ref_csm.layout.js
