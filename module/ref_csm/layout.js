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
		,	width		:60
		,	editor		:this.form_min
		},{
			header		:"Nilai Maks."
		,	dataIndex	:"max"
		,	align		:"center"
		,	width		:60
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

function RefCSMPenilaianDetail ()
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

function RefCSMPenilaian (id_faktor, detail)
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

function RefCSMPenilaianMD (id, title)
{
	this.detail = new RefCSMPenilaianDetail ();
	this.master = new RefCSMPenilaian (id, this.detail);

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

function RefCSM ()
{
	m_ref_csm_perfevalsi	= new RefCSMPerfEvalSI ();
	m_ref_csm_nilai_utama	= new RefCSMPenilaianMD (1, "Penilaian - Faktor Utama");
	m_ref_csm_nilai_tambah	= new RefCSMPenilaianMD (2, "Penilaian - Faktor Tambahan");
	m_ref_csm_perfeval_ps	= new RefCSMPerfEvalPS ();

	this.panel = new Ext.TabPanel ({
		id				:"ref_csm_panel"
	,	activeTab		:0
	,	animScroll		:true
	,	autoScroll		:true
	,	enableTabScroll	:true
	,	items			:[
			m_ref_csm_nilai_utama.panel
		,	m_ref_csm_nilai_tambah.panel
		,	m_ref_csm_perfevalsi.panel
		,	m_ref_csm_perfeval_ps.panel
		]
	});

	this.do_refresh = function ()
	{
		m_ref_csm_perfevalsi.do_refresh ();
		m_ref_csm_nilai_utama.do_refresh ();
		m_ref_csm_nilai_tambah.do_refresh ();
		m_ref_csm_perfeval_ps.do_refresh ();
	}
}

m_ref_csm = new RefCSM ();

//@ sourceURL=ref_csm.layout.js
