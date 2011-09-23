/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_ref_kontraktor;
var m_ref_kontraktor_dml = 0;
var m_ref_kontraktor_id = '';
var m_ref_kontraktor_tipe;
var m_ref_kontraktor_jab;
var m_ref_kontraktor_d = _g_root +"/module/ref_kontraktor/";
var m_repo_browse_d = _g_root +"/module/repo_browse/";

function MRefKontraktorTipe()
{
	this.dml = 0;

	this.fields = new Ext.data.Record.create([
		{name:"id"}
	,	{name:"name"}
	]);

	this.reader = new Ext.data.JsonReader({
		root:"data"
	}, this.fields);

	this.store = new Ext.data.Store({
		url		:m_ref_kontraktor_d +"data_tipe.jsp"
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.form_name = new Ext.form.TextField({
		allowBlank: false
	});

	this.columns = [
		new Ext.grid.RowNumberer()
	,{
		header		:"Tipe Perusahaan"
	,	dataIndex	:"name"
	,	width		:200
	,	editor		:this.form_name
	}]

	this.cm = new Ext.grid.ColumnModel({
		columns		:this.columns
	});

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect:true
	});

	this.btn_del = k3pl.button.Delete(this);
	this.btn_ref = k3pl.button.Refresh(this);
	this.btn_add = k3pl.button.Add(this);

	this.editor = MyRowEditor(this);

	this.panel = new Ext.grid.GridPanel({
		title	:"Referensi Tipe Perusahaan"
	,	store	:this.store
	,	cm		:this.cm
	,	sm		:this.sm
	,	plugins	:[this.editor]
	,	tbar	:[
			this.btn_del
		,	"-"
		,	this.btn_ref
		,	"-"
		,	this.btn_add
		]
	,	listeners	: {
			scope		:this
		,	rowdblclick	:function() {
				this.dml = 3;
			}
		}
	});

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		this.dml = 4;
		this.do_save(r);
	}

	this.do_add = function()
	{
		this.record_new = new this.fields();

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml = 2;
	}

	this.do_save = function(r)
	{
		Ext.Ajax.request({
			url		:m_ref_kontraktor_d +"submit_tipe.jsp"
		,	scope	:this
		,	params	:{
				dml		:this.dml
			,	id		:r.data["id"]
			,	name	:r.data["name"]
			}
		,	failure	:function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);
				Ext.Msg.alert('Error', msg.info);
			}
		,	success :function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
				}

				this.store.load();
			}
		});
	}

	this.do_cancel = function()
	{
		if (this.dml == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_refresh = function()
	{
		this.store.load();
	}
}

m_ref_kontraktor_tipe = new MRefKontraktorTipe();

function MRefKontraktorJab()
{
	this.dml = 0;

	this.fields = new Ext.data.Record.create([
		{name:"id"}
	,	{name:"name"}
	]);

	this.reader = new Ext.data.JsonReader({
		root:"data"
	}, this.fields);

	this.store = new Ext.data.Store({
		url		:m_ref_kontraktor_d +"data_jab.jsp"
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.form_name = new Ext.form.TextField({
		allowBlank: false
	});

	this.columns = [
		new Ext.grid.RowNumberer()
	,{
		header		:"Jabatan"
	,	dataIndex	:"name"
	,	width		:200
	,	editor		:this.form_name
	}]

	this.cm = new Ext.grid.ColumnModel({
		columns		:this.columns
	});

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect:true
	});

	this.btn_del = k3pl.button.Delete(this);
	this.btn_ref = k3pl.button.Refresh(this);
	this.btn_add = k3pl.button.Add(this);

	this.editor = MyRowEditor(this);

	this.panel = new Ext.grid.GridPanel({
		title	:"Referensi Jabatan"
	,	store	:this.store
	,	cm		:this.cm
	,	sm		:this.sm
	,	plugins	:[this.editor]
	,	tbar	:[
			this.btn_del
		,	"-"
		,	this.btn_ref
		,	"-"
		,	this.btn_add
		]
	,	listeners	: {
			scope		:this
		,	rowdblclick	:function() {
				this.dml = 3;
			}
		}
	});

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		this.dml = 4;
		this.do_save(r);
	}

	this.do_add = function()
	{
		this.record_new = new this.fields();

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml = 2;
	}

	this.do_save = function(r)
	{
		Ext.Ajax.request({
			url		:m_ref_kontraktor_d +"submit_jab.jsp"
		,	scope	:this
		,	params	:{
				dml		:this.dml
			,	id		:r.data["id"]
			,	name	:r.data["name"]
			}
		,	failure	:function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);
				Ext.Msg.alert('Error', msg.info);
			}
		,	success :function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
				}

				this.store.load();
			}
		});
	}

	this.do_cancel = function()
	{
		if (this.dml == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_refresh = function()
	{
		this.store.load();
	}
}

m_ref_kontraktor_jab = new MRefKontraktorJab();

function MRefKontraktorPimpinan()
{
	this.fields = new Ext.data.Record.create([
		{name:"id"}
	,	{name:"id_kontraktor"}
	,	{name:"id_jab"}
	,	{name:"nama"}
	,	{name:"lama_bekerja"}
	]);

	this.reader	= new Ext.data.JsonReader({
		root	:"data"
	}, this.fields);

	this.store		= new Ext.data.Store({
		url			:m_ref_kontraktor_d +"data_pimpinan.jsp"
	,	reader		:this.reader
	,	autoLoad	:false
	});

	this.form_jab		= new Ext.form.ComboBox({
		name			:"id_jab"
	,	store			:m_ref_kontraktor_jab.store
	,	valueField		:"id"
	,	displayField	:"name"
	,	triggerAction	:"all"
	,	allowBlank		:false
	,	mode			:"local"
	});

	this.form_nama	= new Ext.form.TextField({
		name		:"nama"
	,	allowBlank	:false
	});

	this.form_bekerja	= new Ext.form.NumberField({
		name			:"lama_bekerja"
	,	allowBlank		:false
	,	allowDecimals	:false
	,	allowNegative	:false
	});

	this.cm			= new Ext.grid.ColumnModel({
		columns		: [{
			header		:"Jabatan"
		,	dataIndex	:"id_jab"
		,	editor		:this.form_jab
		,	renderer	:combo_renderer(this.form_jab)
		,	width		:200
		},{
			header		:"Nama"
		,	dataIndex	:"nama"
		,	editor		:this.form_nama
		,	width		:200
		},{
			header		:"Lama Bekerja (tahun)"
		,	dataIndex	:"lama_bekerja"
		,	editor		:this.form_bekerja
		,	width		:100
		}]
	});

	this.sm				= new Ext.grid.RowSelectionModel({
		singleSelect	:true
	});

	this.editor		= MyRowEditor(this);
	this.btn_add	= k3pl.button.Add(this);
	this.btn_del	= k3pl.button.Delete(this);

	this.panel		= new Ext.grid.GridPanel({
		title		:"Pimpinan"
	,	store		:this.store
	,	cm			:this.cm
	,	sm			:this.sm
	,	autoScroll	:true
	,	autoHeight	:true
	,	plugins		:[this.editor]
	,	tbar		:[
			this.btn_del, "-"
		,	this.btn_add
		]
	,	listeners	:{
			scope		:this
		,	rowdblclick	:function() {
				this.dml = 3;
			}
		}
	});

	this.do_save = function(r)
	{
		if (m_ref_kontraktor_dml == 2) {
			return;
		}

		Ext.Ajax.request({
			url		:m_ref_kontraktor_d +"submit_pimpinan.jsp"
		,	params	:{
				dml				:this.dml
			,	id				:r.get("id")
			,	id_kontraktor	:m_ref_kontraktor_id
			,	id_jab			:r.get("id_jab")
			,	nama			:r.get("nama")
			,	lama_bekerja	:r.get("lama_bekerja")
			}
		,	scope	:this
		,	failure	:function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);
				Ext.Msg.alert('Error', msg.info);
			}
		,	success :function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
				}

				this.store.reload();
			}
		});
	}

	this.do_cancel = function()
	{
		this.store.remove(this.record_new);
		this.sm.selectRow(0);
	}

	this.do_add = function()
	{
		this.record_new = new this.fields;

		this.dml = 2;
		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);
	}

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		if (m_ref_kontraktor_dml == 2) {
			this.store.remove(r);
		} else {
			this.dml = 4;
			this.do_save(r);
		}
	}

	this.do_refresh = function(id)
	{
		this.store.load({
			params	:{
				id	:id
			}
		});
	}
}

function MRefKontraktorPemilik()
{
	this.form_nama	= new Ext.form.TextField({
		fieldLabel	:"Nama"
	,	name		:"pemilik_nama"
	,	allowBlank	:false
	,	width		:200
	});

	this.form_alamat= new Ext.form.TextArea({
		fieldLabel	:"Alamat"
	,	name		:"pemilik_alamat"
	,	allowBlank	:false
	,	width		:400
	});

	this.panel		= new Ext.FormPanel({
		title		:"Pemilik Perusahaan"
	,	padding		:10
	,	labelAlign	:"right"
	,	items		:[
			this.form_nama
		,	this.form_alamat
		]
	});

	this.do_reset = function()
	{
		this.form_nama.setValue('');
		this.form_alamat.setValue('');
	}
}

function MRefKontraktorPUL()
{
	this.fields = new Ext.data.Record.create([
		{name:"id"}
	,	{name:"id_kontraktor"}
	,	{name:"nama"}
	,	{name:"alamat"}
	,	{name:"telp"}
	]);

	this.reader	= new Ext.data.JsonReader({
		root	:"data"
	}, this.fields);

	this.store	= new Ext.data.Store({
		url		:m_ref_kontraktor_d +"data_pul.jsp"
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.form_nama	= new Ext.form.TextField({
		name		:"nama"
	,	allowBlank	:false
	});

	this.form_alamat= new Ext.form.TextField({
		name		:"alamat"
	});

	this.form_telp	= new Ext.form.TextField({
		name		:"telp"
	});

	this.cm			= new Ext.grid.ColumnModel({
		columns		:[{
			header		:"Nama"
		,	dataIndex	:"nama"
		,	editor		:this.form_nama
		,	width		:200
		},{
			header		:"Alamat"
		,	dataIndex	:"alamat"
		,	editor		:this.form_alamat
		,	id			:"alamat"
		},{
			header		:"Telpon"
		,	dataIndex	:"telp"
		,	editor		:this.form_telp
		,	width		:120
		}]
	});

	this.sm				= new Ext.grid.RowSelectionModel({
		singleSelect	:true
	});

	this.editor		= MyRowEditor(this);
	this.btn_add	= k3pl.button.Add(this);
	this.btn_del	= k3pl.button.Delete(this);

	this.panel				= new Ext.grid.GridPanel({
		title				:"Perusahaan Lain Dimiliki"
	,	store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	plugins				:[this.editor]
	,	autoExpandColumn	:"alamat"
	,	tbar				:[
			this.btn_del	,"-"
		,	this.btn_add
		]
	,	listeners			:{
			scope		:this
		,	rowdblclick	: function () {
				this.dml = 3;
			}
		}
	});

	this.do_add = function()
	{
		this.record_new = new this.fields;

		this.dml = 2;
		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);
	}

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		if (m_ref_kontraktor_dml == 2) {
			this.store.remove(r);
		} else {
			this.dml = 4;
			this.do_save(r);
		}
	}

	this.do_cancel = function()
	{
		this.store.remove(this.record_new);
		this.sm.selectRow(0);
	}

	this.do_save = function(r)
	{
		if (m_ref_kontraktor_dml == 2) {
			return;
		}

		Ext.Ajax.request({
			url		:m_ref_kontraktor_d +"submit_pul.jsp"
		,	params	:{
				dml				:this.dml
			,	id				:r.get("id")
			,	id_kontraktor	:m_ref_kontraktor_id
			,	nama			:r.get("nama")
			,	alamat			:r.get("alamat")
			,	telp			:r.get("telp")
			}
		,	scope	:this
		,	failure	:function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);
				Ext.Msg.alert('Error', msg.info);
			}
		,	success :function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
				}

				this.store.reload();
			}
		});
	}

	this.do_refresh = function(id)
	{
		this.store.load({
			params	:{
				id	:id
			}
		});
	}
}

function MRefKontraktorAsuransi()
{
	this.cb_asuransi= new Ext.form.Checkbox({
		fieldLabel	:"Perusahaan Diasuransikan"
	,	name		:"asuransi_status"
	,	scope		:this
	,	handler		:function(item, v) {
			this.cb_asuransi_checked(v);
		}
	});

	this.form_nama	= new Ext.form.TextField({
		fieldLabel	:"Penanggung Asuransi"
	,	name		:"asuransi_pj"
	,	disabled	:true
	,	width		:200
	});

	this.form_alamat= new Ext.form.TextArea({
		fieldLabel	:"Alamat"
	,	name		:"asuransi_alamat"
	,	disabled	:true
	,	width		:400
	});

	this.form_telp	= new Ext.form.TextField({
		fieldLabel	:"Telpon"
	,	name		:"asuransi_telp"
	,	disabled	:true
	,	width		:200
	});

	this.panel			= new Ext.FormPanel({
		title			:"Asuransi"
	,	labelWidth		:200
	,	labelAlign		:"right"
	,	padding			:10
	,	items			:[
			this.cb_asuransi
		,	this.form_nama
		,	this.form_alamat
		,	this.form_telp
		]
	});

	this.cb_asuransi_checked = function(v)
	{
		this.form_nama.setDisabled(!v);
		this.form_alamat.setDisabled(!v);
		this.form_telp.setDisabled(!v);
	}

	this.do_reset = function()
	{
		this.cb_asuransi.setValue(false);
		this.form_nama.setValue('');
		this.form_alamat.setValue('');
		this.form_telp.setValue('');
	}
}

function MRefKontraktorPenawar()
{
	this.form_nama	= new Ext.form.TextField({
		fieldLabel	:"Nama"
	,	name		:"penawar_nama"
	,	width		:200
	});

	this.form_jab		= new Ext.form.ComboBox({
		fieldLabel		:"Jabatan"
	,	name			:"penawar_jab"
	,	store			:m_ref_kontraktor_jab.store
	,	valueField		:"id"
	,	displayField	:"name"
	,	triggerAction	:"all"
	,	mode			:"local"
	,	width			:200
	});

	this.form_telp	= new Ext.form.TextField({
		fieldLabel	:"Telpon"
	,	name		:"penawar_telp"
	,	width		:200
	});

	this.form_fax	= new Ext.form.TextField({
		fieldLabel	:"Fax"
	,	name		:"penawar_fax"
	,	width		:200
	});

	this.panel		= new Ext.FormPanel({
		title		:"Petugas Peminta Penawaran"
	,	padding		:10
	,	labelAlign	:"right"
	,	items		:[
			this.form_nama
		,	this.form_jab
		,	this.form_telp
		,	this.form_fax
		]
	});

	this.do_reset = function()
	{
		this.form_nama.setValue('');
		this.form_jab.setValue(m_ref_kontraktor_jab.store.getAt(0).get("id"));
		this.form_telp.setValue('');
		this.form_fax.setValue('');
	}
}

function MRefKontraktorPengisi()
{
	this.form_nama	= new Ext.form.TextField({
		fieldLabel	:"Nama"
	,	name		:"pengisi_nama"
	,	width		:200
	});

	this.form_jab		= new Ext.form.ComboBox({
		fieldLabel		:"Jabatan"
	,	name			:"pengisi_jab"
	,	store			:m_ref_kontraktor_jab.store
	,	valueField		:"id"
	,	displayField	:"name"
	,	triggerAction	:"all"
	,	mode			:"local"
	,	width			:200
	});

	this.form_telp	= new Ext.form.TextField({
		fieldLabel	:"Telpon"
	,	name		:"pengisi_telp"
	,	width		:200
	});

	this.form_fax	= new Ext.form.TextField({
		fieldLabel	:"Fax"
	,	name		:"pengisi_fax"
	,	width		:200
	});

	this.panel		= new Ext.FormPanel({
		title		:"Pengisi Formulir"
	,	padding		:10
	,	labelAlign	:"right"
	,	items		:[
			this.form_nama
		,	this.form_jab
		,	this.form_telp
		,	this.form_fax
		]
	});

	this.do_reset = function()
	{
		this.form_nama.setValue("");
		this.form_jab.setValue(m_ref_kontraktor_jab.store.getAt(0).get("id"));
		this.form_telp.setValue("");
		this.form_fax.setValue("");
	}
}

function MRefKontraktorJUL()
{
	this.fields	= new Ext.data.Record.create([
		{name:"id"}
	,	{name:"ket"}
	]);

	this.reader = new Ext.data.JsonReader({
		root	:"data"
	}, this.fields);

	this.store		= new Ext.data.Store({
		url			:m_ref_kontraktor_d +"data_jul.jsp"
	,	reader		:this.reader
	,	autoLoad	:false
	});

	this.form_ket = new Ext.form.TextField();

	this.cm		= new Ext.grid.ColumnModel({
		columns	:[{
			header		:"Keterangan"
		,	dataIndex	:"ket"
		,	id			:"ket"
		,	editor		:this.form_ket
		}]
	});

	this.sm				= new Ext.grid.RowSelectionModel({
		singleSelect	:true
	});

	this.editor		= MyRowEditor(this);
	this.btn_add	= k3pl.button.Add(this);
	this.btn_del	= k3pl.button.Delete(this);

	this.panel				= new Ext.grid.GridPanel({
		title				:"Pekerjaan Di-subkontrakan"
	,	autoExpandColumn	:"ket"
	,	store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	plugins				:[this.editor]
	,	tbar				:[
			this.btn_del, "-"
		,	this.btn_add
		]
	,	listeners			:{
			scope		:this
		,	rowdblclick	:function() {
				this.dml = 3;
			}
		}
	});

	this.do_add = function()
	{
		this.record_new = new this.fields;

		this.dml = 2;
		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);
	}

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		if (m_ref_kontraktor_dml == 2) {
			this.store.remove(r);
		} else {
			this.dml = 4;
			this.do_save(r);
		}
	}

	this.do_cancel = function()
	{
		this.store.remove(this.record_new);
		this.sm.selectRow(0);
	}

	this.do_save = function(r)
	{
		if (m_ref_kontraktor_dml == 2) {
			return;
		}

		Ext.Ajax.request({
			url		:m_ref_kontraktor_d +"submit_jul.jsp"
		,	params	:{
				dml				:this.dml
			,	id				:r.get("id")
			,	id_kontraktor	:m_ref_kontraktor_id
			,	ket				:r.get("ket")
			}
		,	scope	:this
		,	failure	:function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);
				Ext.Msg.alert('Error', msg.info);
			}
		,	success :function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
				}

				this.store.reload();
			}
		});
	}

	this.do_refresh = function(id)
	{
		this.store.load({
			params	:{
				id	:id
			}
		});
	}
}

function MRefKontraktorPSTD(title, url_data, url_submit)
{
	this.fields	= new Ext.data.Record.create([
		{name:"id"}
	,	{name:"tempat"}
	,	{name:"jenis"}
	,	{name:"nilai"}
	]);

	this.reader = new Ext.data.JsonReader({
		root	:"data"
	}, this.fields);

	this.store		= new Ext.data.Store({
		url			:m_ref_kontraktor_d + url_data
	,	reader		:this.reader
	,	autoLoad	:false
	});

	this.sm				= new Ext.grid.RowSelectionModel({
		singleSelect	:true
	});

	this.form_tempat	= new Ext.form.TextField();
	this.form_jenis		= new Ext.form.TextField();
	this.form_nilai		= new Ext.form.TextField();

	this.cm	= new Ext.grid.ColumnModel({
		columns	:[{
			header		:"Lokasi/Perusahaan"
		,	dataIndex	:"tempat"
		,	width		:240
		,	editor		:this.form_tempat
		},{
			header		:"Jenis Pekerjaan"
		,	dataIndex	:"jenis"
		,	width		:200
		,	editor		:this.form_jenis
		},{
			header		:"Nilai"
		,	dataIndex	:"nilai"
		,	width		:200
		,	editor		:this.form_nilai
		}]
	});

	this.editor		= MyRowEditor(this);
	this.btn_add	= k3pl.button.Add(this);
	this.btn_del	= k3pl.button.Delete(this);

	this.panel		= new Ext.grid.GridPanel({
		title		:title
	,	store		:this.store
	,	cm			:this.cm
	,	sm			:this.sm
	,	plugins		:[this.editor]
	,	tbar		:[
			this.btn_del, "-"
		,	this.btn_add
		]
	,	listeners	:{
			scope		:this
		,	rowdblclick	:function() {
				this.dml = 3;
			}
		}
	});

	this.do_add = function()
	{
		this.record_new = new this.fields;

		this.dml = 2;
		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);
	}

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		if (m_ref_kontraktor_dml == 2) {
			this.store.remove(r);
		} else {
			this.dml = 4;
			this.do_save(r);
		}
	}

	this.do_cancel = function()
	{
		this.store.remove(this.record_new);
		this.sm.selectRow(0);
	}

	this.do_save = function(r)
	{
		if (m_ref_kontraktor_dml == 2) {
			return;
		}

		Ext.Ajax.request({
			url		:m_ref_kontraktor_d + url_submit
		,	params	:{
				dml				:this.dml
			,	id				:r.get("id")
			,	id_kontraktor	:m_ref_kontraktor_id
			,	tempat			:r.get("tempat")
			,	jenis			:r.get("jenis")
			,	nilai			:r.get("nilai")
			}
		,	scope	:this
		,	failure	:function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);
				Ext.Msg.alert('Error', msg.info);
			}
		,	success :function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
				}

				this.store.reload();
			}
		});
	}

	this.do_refresh = function(id)
	{
		this.store.load({
			params	:{
				id	:id
			}
		});
	}
}

function MRefKontraktorKlaim()
{
	this.fields	= new Ext.data.Record.create([
		{name:"id"}
	,	{name:"id_repo"}
	]);

	this.reader	= new Ext.data.JsonReader({
		root	:"data"
	}, this.fields);

	this.store	= new Ext.data.Store({
		url		:m_ref_kontraktor_d +"data_klaim.jsp"
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.sm				= new Ext.grid.RowSelectionModel({
		singleSelect	:true
	});

	this.store_dok	= new Ext.data.ArrayStore({
		url			:m_repo_browse_d +"data_repo_combobox.jsp"
	,	fields		:[
			{name:"id"}
		,	{name:"name"}
		,	{name:"path"}
		]
	,	autoLoad	:false
	});

	this.form_dok	= new Ext.form.ComboBox({
		store			:this.store_dok
	,	valueField		:"id"
	,	displayField	:"name"
	,	triggerAction	:"all"
	,	mode			:"local"
	});

	this.cm		= new Ext.grid.ColumnModel({
		columns	:[{
			header		:"Nama Dokumen"
		,	dataIndex	:"id_repo"
		,	width		:200
		,	editor		:this.form_dok
		,	renderer	:combo_renderer(this.form_dok)
		}]
	});

	this.editor		= MyRowEditor(this);
	this.btn_add	= k3pl.button.Add(this);
	this.btn_del	= k3pl.button.Delete(this);

	this.panel		= new Ext.grid.GridPanel({
		title		:"Lampiran Klaim/Tuntutan"
	,	store		:this.store
	,	sm			:this.sm
	,	cm			:this.cm
	,	disabled	:true
	,	plugins		:[this.editor]
	,	tbar		:[
			this.btn_del, "-"
		,	this.btn_add
		]
	});

	this.do_add = function()
	{
		this.record_new = new this.fields;

		this.dml = 2;
		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);
	}

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		if (m_ref_kontraktor_dml == 2) {
			this.store.remove(r);
		} else {
			this.dml = 4;
			this.do_save(r);
		}
	}

	this.do_cancel = function()
	{
		this.store.remove(this.record_new);
		this.sm.selectRow(0);
	}

	this.do_save = function(r)
	{
		if (m_ref_kontraktor_dml == 2) {
			return;
		}

		Ext.Ajax.request({
			url		:m_ref_kontraktor_d +"submit_klm.jsp"
		,	params	:{
				dml				:this.dml
			,	id				:r.get("id")
			,	id_kontraktor	:m_ref_kontraktor_id
			,	id_repo			:r.get("id_repo")
			}
		,	scope	:this
		,	failure	:function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);
				Ext.Msg.alert('Error', msg.info);
			}
		,	success :function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
				}

				this.store.reload();
			}
		});
	}

	this.do_refresh = function(id)
	{
		this.store.load({
			params	:{
				id	:id
			}
		});
	}
}

function MRefKontraktorBangkrut()
{
	this.cb_status = new Ext.form.Checkbox({
		fieldLabel	:"Perusahaan pernah bangkrut ?"
	,	name		:"bangkrut_status"
	,	scope		:this
	,	handler		:function(item, v) {
			this.cb_checked(v);
		}
	});

	this.form_detail	= new Ext.form.TextArea({
		fieldLabel	:"Keterangan"
	,	name		:"bangkrut_detail"
	,	disabled	:true
	,	width		:400
	,	height		:160
	});

	this.panel		= new Ext.FormPanel({
		title		:"Bangkrut"
	,	labelWidth	:220
	,	labelAlign	:"right"
	,	padding		:10
	,	items		:[
			this.cb_status
		,	this.form_detail
		]
	});

	this.cb_checked = function(v)
	{
		this.form_detail.setDisabled(!v);
	}

	this.do_reset = function()
	{
		this.cb_status.setValue(false);
		this.form_detail.setValue("");
	}
}

function MRefKontraktorData()
{
	this.fields = new Ext.data.Record.create([
		{name:"id"}
	,	{name:"tipe"}
	,	{name:"nama"}
	,	{name:"alamat"}
	,	{name:"telp"}
	,	{name:"fax"}
	,	{name:"pemilik_nama"}
	,	{name:"pemilik_alamat"}
	,	{name:"asuransi_status"}
	,	{name:"asuransi_pj"}
	,	{name:"asuransi_alamat"}
	,	{name:"asuransi_telp"}
	,	{name:"penawar_nama"}
	,	{name:"penawar_jab"}
	,	{name:"penawar_telp"}
	,	{name:"penawar_fax"}
	,	{name:"pengisi_nama"}
	,	{name:"pengisi_jab"}
	,	{name:"pengisi_telp"}
	,	{name:"pengisi_fax"}
	,	{name:"klaim_status"}
	,	{name:"bangkrut_status"}
	,	{name:"bangkrut_detail"}
	]);

	this.store = new Ext.data.ArrayStore({
		url		:m_ref_kontraktor_d +"data.jsp"
	,	fields	:this.fields
	,	autoLoad:false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [{
			header		:"Nama"
		,	dataIndex	:"nama"
		},{
			header		:"Alamat"
		,	dataIndex	:"alamat"
		,	id			:"alamat"
		},{
			header		:"Telpon"
		,	dataIndex	:"telp"
		}]
	});

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	:true
	});

	this.btn_add	= k3pl.button.Add(this);
	this.btn_ref	= k3pl.button.Refresh(this);
	this.btn_edit	= k3pl.button.Edit(this);
	this.btn_del	= k3pl.button.Delete(this);

	this.grid				= new Ext.grid.GridPanel({
		store				:this.store
	,	cm					:this.cm
	,	sm					:this.sm
	,	autoExpandColumn	:"alamat"
	,	tbar				:[
			this.btn_del	,"-"
		,	this.btn_edit	,"-"
		,	this.btn_ref	,"-"
		,	this.btn_add	,"-"
		]
	});
	/*
	 * Form
	 */
	this.form_id	= new Ext.form.TextField({
		name		:"id"
	,	hidden		:true
	});

	this.form_nama	= new Ext.form.TextField({
		fieldLabel	:"Nama"
	,	name		:"nama"
	,	allowBlank	:false
	,	width		:200
	});

	this.form_tipe		= new Ext.form.ComboBox({
		fieldLabel		:"Tipe"
	,	name			:"tipe"
	,	store			:m_ref_kontraktor_tipe.store
	,	valueField		:"id"
	,	displayField	:"name"
	,	triggerAction	:"all"
	,	allowBlank		:false
	,	mode			:"local"
	,	width			:200
	});

	this.form_alamat= new Ext.form.TextArea({
		fieldLabel	:"Alamat"
	,	name		:"alamat"
	,	allowBlank	:false
	,	width		:300
	,	height		:76
	});

	this.form_telp	= new Ext.form.TextField({
		fieldLabel	:"Telpon"
	,	name		:"telp"
	,	width		:200
	});

	this.form_fax	= new Ext.form.TextField({
		fieldLabel	:"Fax"
	,	name		:"fax"
	,	width		:200
	});

	this.cb_klaim	= new Ext.form.Checkbox({
		boxLabel	:"Perusahaan memiliki klaim/tuntutan <br/>"
	,	name		:"klaim_status"
	,	scope		:this
	,	handler		:function(item, v) {
			this.cb_klaim_checked(v);
		}
	});

	this.form_ket_umum	= new Ext.FormPanel({
		region			:"north"
	,	layout			:"column"
	,	labelAlign		:"right"
	,	autoHeight		:true
	,	flex			:1
	,	defaults		:{
			padding		:10
		,	layout		:"form"
		,	border		:false
		}
	,	items			:[{
			columnWidth	:.43
		,	labelWidth	:60
		,	items		:[
				this.form_id
			,	this.form_nama
			,	this.form_tipe
			,	this.form_telp
			,	this.form_fax
			]
		},{
			columnWidth	:.57
		,	labelWidth	:60
		,	autoHeight	:true
		,	items		:[
			 	this.form_alamat
			,	this.cb_klaim
			]
		}]
	});

	this.form_pemilik	= new MRefKontraktorPemilik();
	this.form_pul		= new MRefKontraktorPUL();
	this.form_pim		= new MRefKontraktorPimpinan();
	this.form_asuransi	= new MRefKontraktorAsuransi();
	this.form_penawar	= new MRefKontraktorPenawar();
	this.form_pengisi	= new MRefKontraktorPengisi();
	this.form_jul		= new MRefKontraktorJUL();
	this.form_psd		= new MRefKontraktorPSTD("Pekerjaan Sedang Dilaksanakan"
								, "data_psd.jsp", "submit_psd.jsp");
	this.form_ptd		= new MRefKontraktorPSTD("Pekerjaan Telah Dilaksanakan"
								, "data_ptd.jsp", "submit_ptd.jsp");
	this.form_klm		= new MRefKontraktorKlaim();
	this.form_bangkrut	= new MRefKontraktorBangkrut();

	/*
	 * Tab Kontraktor Detail
	 */
	this.form_detail	= new Ext.TabPanel({
		region			:"center"
	,	flex			:2.6
	,	activeTab		:0
	,	plain			:true
	,	deferredRender	:false
	,	autoScroll		:true
	,	enableTabScroll	:true
	,	items			:[
			this.form_pemilik.panel
		,	this.form_pul.panel
		,	this.form_pim.panel
		,	this.form_asuransi.panel
		,	this.form_penawar.panel
		,	this.form_pengisi.panel
		,	this.form_jul.panel
		,	this.form_psd.panel
		,	this.form_ptd.panel
		,	this.form_klm.panel
		,	this.form_bangkrut.panel
		]
	});

	this.btn_save	= k3pl.button.Save(this);
	this.btn_cancel	= k3pl.button.Cancel(this);

	this.form		= new Ext.Panel({
		layout		:{
			type	:"vbox"
		,	align	:"stretch"
		,	padding	:5
		}
	,	tbar		:[
			this.btn_cancel
		,	"->"
		,	this.btn_save
		]
	,	items		:[
			this.form_ket_umum
		,	this.form_detail
		]
	});

	/*
	 * main panel
	 */
	this.panel = new Ext.Panel({
		title		:"Data Kontraktor"
	,	layout		:"card"
	,	activeItem	:0
	,	items		:[
			this.grid
		,	this.form
		]
	});

	this.cb_klaim_checked = function(v)
	{
		this.form_klm.panel.setDisabled(!v)
	}

	this.is_valid = function()
	{
		if (!this.form_pemilik.panel.getForm().isValid()) {
			return false;
		}
		return true;
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.Msg.alert("Kesalahan"
			, "Masih ada form yang belum terisi!");
			return;
		}

		var id;
		var pul	= "[";
		var pim = "[";
		var jul	= "[";
		var psd	= "[";
		var ptd	= "[";
		var klm = "[";

		if (m_ref_kontraktor_dml == 2) {
			id = (new Date()).getTime();
		} else {
			id = this.form_id.getValue();
		}

		var asuransi_status = this.form_asuransi.cb_asuransi.getValue();
		asuransi_status		= asuransi_status == true ? 1 : 0;
		var asuransi_pj		= "";
		var asuransi_alamat	= "";
		var asuransi_telp	= "";

		if (asuransi_status) {
			asuransi_pj		= this.form_asuransi.form_nama.getValue();
			asuransi_alamat	= this.form_asuransi.form_alamat.getValue();
			asuransi_telp	= this.form_asuransi.form_telp.getValue();
		}

		/* pul */
		var rs	= this.form_pul.store.getModifiedRecords();
		var i	= 0;

		for (; i < rs.length; i++) {
			if (i > 0) {
				pul	+= ",";
			}
			pul	+=	'{nama:'+ Ext.encode(rs[i].get("nama"))
				+	',alamat:'+ Ext.encode(rs[i].get("alamat"))
				+	',telp:'+ Ext.encode(rs[i].get("telp"))
				+	'}';
		}

		pul += "]";

		/* pim */
		rs = this.form_pim.store.getModifiedRecords();

		for (i = 0; i < rs.length; i++) {
			if (i > 0) {
				pim += ",";
			}
			pim	+=	'{id_jab:'+ rs[i].get("id_jab")
				+	',nama:'+ Ext.encode(rs[i].get("nama"))
				+	',lama_bekerja:'+ rs[i].get("lama_bekerja")
				+	'}';
		}

		pim += "]";

		/* jul */
		rs = this.form_jul.store.getModifiedRecords();

		for (i = 0; i < rs.length; i++) {
			if (i > 0) {
				jul += ",";
			}
			jul	+=	'{ket:'+ Ext.encode(rs[i].get("ket")) +'}';
		}

		jul += "]";

		/* psd */
		rs = this.form_psd.store.getModifiedRecords();

		for (i = 0; i < rs.length; i++) {
			if (i > 0) {
				psd += ",";
			}
			psd	+=	'{ tempat	:'+ Ext.encode(rs[i].get("tempat"))
				+	', jenis	:'+ Ext.encode(rs[i].get("jenis"))
				+	', nilai	:'+ Ext.encode(rs[i].get("nilai"))
				+	'}';
		}

		psd += "]";

		/* ptd */
		rs = this.form_ptd.store.getModifiedRecords();

		for (i = 0; i < rs.length; i++) {
			if (i > 0) {
				ptd += ",";
			}
			ptd	+=	'{ tempat	:'+ Ext.encode(rs[i].get("tempat"))
				+	', jenis	:'+ Ext.encode(rs[i].get("jenis"))
				+	', nilai	:'+ Ext.encode(rs[i].get("nilai"))
				+	'}';
		}

		ptd += "]";

		/* klaim */
		var klaim_status	= this.cb_klaim.getValue() == true
							? 1 : 0;
		if (klm) {
			rs = this.form_klm.store.getModifiedRecords();

			for (i = 0; i < rs.length; i++) {
				if (i > 0) {
					klm += ",";
				}
				klm	+=	'{id_repo:'+ Ext.encode(rs[i].get("id_repo")) +'}';
			}
		}
		klm += "]";


		var bangkrut_detail	= "";
		var bangkrut_status = this.form_bangkrut.cb_status.getValue();
		bangkrut_status = bangkrut_status == true ? 1 : 0;
		if (bangkrut_status) {
			bangkrut_detail = this.form_bangkrut.form_detail.getValue();
		}

		Ext.Ajax.request({
			url		:m_ref_kontraktor_d +"submit.jsp"
		,	params	:{
				dml				:m_ref_kontraktor_dml
			,	id				:id
			,	tipe			:this.form_tipe.getValue()
			,	nama			:this.form_nama.getValue()
			,	alamat			:this.form_alamat.getValue()
			,	telp			:this.form_telp.getValue()
			,	fax				:this.form_fax.getValue()
			,	pemilik_nama	:this.form_pemilik.form_nama.getValue()
			,	pemilik_alamat	:this.form_pemilik.form_alamat.getValue()
			,	asuransi_status	:asuransi_status
			,	asuransi_pj		:asuransi_pj
			,	asuransi_alamat	:asuransi_alamat
			,	asuransi_telp	:asuransi_telp
			,	penawar_nama	:this.form_penawar.form_nama.getValue()
			,	penawar_jab		:this.form_penawar.form_jab.getValue()
			,	penawar_telp	:this.form_penawar.form_telp.getValue()
			,	penawar_fax		:this.form_penawar.form_fax.getValue()
			,	pengisi_nama	:this.form_pengisi.form_nama.getValue()
			,	pengisi_jab		:this.form_pengisi.form_jab.getValue()
			,	pengisi_telp	:this.form_pengisi.form_telp.getValue()
			,	pengisi_fax		:this.form_pengisi.form_fax.getValue()
			,	klaim_status	:klaim_status
			,	bangkrut_status	:bangkrut_status
			,	bangkrut_detail	:bangkrut_detail
			,	pul				:pul
			,	pim				:pim
			,	jul				:jul
			,	psd				:psd
			,	ptd				:ptd
			,	klm				:klm
			}
		,	scope	:this
		,	failure	:function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);
				Ext.Msg.alert('Error', msg.info);
			}
		,	success :function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
				}

				this.panel.setTitle("Data Kontraktor");
				this.panel.getLayout().setActiveItem(0);
				this.store.reload();
			}
		});
	}

	this.do_cancel = function()
	{
		this.panel.setTitle("Data Kontraktor");
		this.panel.getLayout().setActiveItem(0);
	}

	this.do_reset = function()
	{
		this.form_id.setValue('');
		this.form_nama.setValue('');
		this.form_tipe.setValue(1);
		this.form_alamat.setValue('');
		this.form_telp.setValue('');
		this.form_fax.setValue('');

		this.form_pemilik.do_reset();
		this.form_asuransi.do_reset();
		this.form_penawar.do_reset();
		this.form_pengisi.do_reset();
		this.form_bangkrut.do_reset();

		this.form_pul.store.removeAll();
		this.form_pim.store.removeAll();
		this.form_jul.store.removeAll();
		this.form_psd.store.removeAll();
		this.form_ptd.store.removeAll();
		this.form_klm.store.removeAll();
	}

	this.do_add = function()
	{
		this.do_reset();

		m_ref_kontraktor_dml = 2;
		this.panel.getLayout().setActiveItem(1);
		this.panel.setTitle("Form Kontraktor");
	}

	this.do_edit = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		m_ref_kontraktor_id = r.get("id");

		this.form_ket_umum.getForm().loadRecord(r);
		this.form_pemilik.panel.getForm().loadRecord(r);
		this.form_asuransi.panel.getForm().loadRecord(r);
		this.form_penawar.panel.getForm().loadRecord(r);
		this.form_pengisi.panel.getForm().loadRecord(r);
		this.form_bangkrut.panel.getForm().loadRecord(r);

		this.form_pul.do_refresh(m_ref_kontraktor_id);
		this.form_pim.do_refresh(m_ref_kontraktor_id);
		this.form_jul.do_refresh(m_ref_kontraktor_id);
		this.form_psd.do_refresh(m_ref_kontraktor_id);
		this.form_ptd.do_refresh(m_ref_kontraktor_id);
		this.form_klm.do_refresh(m_ref_kontraktor_id);

		m_ref_kontraktor_dml = 3;
		this.panel.getLayout().setActiveItem(1);
		this.panel.setTitle("Form Kontraktor");
	}

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		Ext.Ajax.request({
			url		:m_ref_kontraktor_d +"submit.jsp"
		,	params	:{
				dml		:4
			,	id		:r.get("id")
			,	pul		:"[]"
			,	pim		:"[]"
			,	jul		:"[]"
			,	psd		:"[]"
			,	ptd		:"[]"
			,	klm		:"[]"
			}
		,	scope	:this
		,	failure	:function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);
				Ext.Msg.alert('Error', msg.info);
			}
		,	success :function (res) {
				var msg = Ext.util.JSON.decode(res.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
				}

				this.store.load();
				this.panel.setTitle("Data Kontraktor");
				this.panel.getLayout().setActiveItem(0);
			}
		});
	}

	this.do_refresh = function()
	{
		this.store.load();
		this.form_klm.store_dok.load();
	}
}

function MRefKontraktor()
{
	this.kont_data	= new MRefKontraktorData();

	this.panel		= new Ext.TabPanel({
		id			:"ref_kontraktor_panel"
	,	activeTab	:0
	,	items		:[
			this.kont_data.panel
		,	m_ref_kontraktor_tipe.panel
		,	m_ref_kontraktor_jab.panel
		]
	});

	this.do_refresh = function()
	{
		m_ref_kontraktor_tipe.do_refresh();
		m_ref_kontraktor_jab.do_refresh();
		this.kont_data.do_refresh();
	}
}

m_ref_kontraktor = new MRefKontraktor();

//@ sourceURL=ref_kontraktor.layout.js
