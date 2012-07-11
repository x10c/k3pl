/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - Prasetya (prasetya.yanuar@googlemail.com)
 *	 - m.shulhan (ms@kilabit.org)
 */

var m_list_pegawai_komite;
var m_list_kel_jabatan_komite;
var m_list_kel_jabatan_csc;
var m_ref_ha_level	= 0;
var m_list_pegawai_komite_id	= '';
var m_kel_jabatan_komite_id = '';
var m_kel_jabatan_csc_id = '';
var m_jabatan_komite_old = '';

function keljab_on_select_load_peg_komite()
{
	if (typeof m_list_kel_jabatan_komite == 'undefined'
	||  m_kel_jabatan_komite_id == '') {
		return;
	}

	m_list_pegawai_komite.do_load();
}

function keljabcsc_on_select_load_peg_komite()
{
	if (typeof m_list_kel_jabatan_komite == 'undefined'
	||  typeof m_list_kel_jabatan_csc == 'undefined' 
	||  m_kel_jabatan_csc_id == '') {
		return;
	}
	m_list_kel_jabatan_komite.do_load();
	m_list_pegawai_komite.do_load();
}

function M_ValidatePegawaiKomite(){
	if (typeof m_ref_peg_con == 'undefined'
		||  (m_kel_jabatan_komite_id == '' && m_kel_jabatan_csc_id == '')) {
			return 0;
		}
	return 1;
}

function M_RefKelJabatanKomite()
{
	this.record = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'nama'}
		]);

	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root: 'rows'
		}
		, this.record);

	this.store = new Ext.data.Store({
			url		: _g_root +'/module/ref_pegawai_komite/data_kel_jabatan_komite.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});

	this.form_nama_kel_jabatan_komite = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nama'
			, header	: 'Nama'
			, dataIndex	: 'nama'
			, sortable	: true
			, editor	: this.form_nama_kel_jabatan_komite
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();

					if (data.length) {
						m_kel_jabatan_komite_id = data[0].data.id;
					} else {
						m_kel_jabatan_komite_id = '';
					}
					keljab_on_select_load_peg_komite();
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
		});

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_ref
			]
		});

	this.grid = new Ext.grid.GridPanel({
			title			: "Daftar Sub Komite"
		,	region			: 'south'
		,	store			: this.store
		,	sm				: this.sm
		,	columns			: this.columns
		,	plugins			: this.editor
		,	tbar			: this.toolbar
		,	width			: '35%'
		,	autoExpandColumn: 'nama'
		});

	this.do_load = function()
	{
		this.store.load({
			params	: {
							id_kel_csc : m_kel_jabatan_csc_id
						}
			});
	}

	this.do_refresh = function()
	{
	}
}

function M_RefKelJabatanCSC()
{
	this.id_direktorat 	= '0';
	this.id_divprosbu	= '0';
	this.record = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'nama'}
		,	{name:'id_direktorat'}
		,	{name:'id_divprosbu'}
		]);

	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root: 'rows'
		}
		, this.record);

	this.store = new Ext.data.Store({
			url		: _g_root +'/module/ref_pegawai_komite/data_kel_jabatan_csc.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});
	
	this.store_direktorat = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_direktorat.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_divprosbu.load({
						params	: {
							id_direktorat : this.id_direktorat
						}
					});
				}
			}
	});

	this.store_divprosbu = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_divprosbu.jsp'
		,	autoLoad	: false
		,	idIndex		: 1
	});

	this.form_divprosbu = new Ext.form.ComboBox({
			fieldLabel		: 'Divisi/Proyek/SBU'
		,	store			: this.store_divprosbu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 400
	});

	this.form_direktorat = new Ext.form.ComboBox({
			fieldLabel		: 'Direktorat'
		,	store			: this.store_direktorat
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 400
	});
	
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nama'
			, header	: 'Nama'
			, dataIndex	: 'nama'
			, sortable	: true
			}
		,	{ id		: 'id_direktorat'
			, header	: 'Direktorat'
			, dataIndex	: 'id_direktorat'
			, width		: 100
			, sortable	: true
			, renderer	: combo_renderer(this.form_direktorat)
			}
		,	{ id		: 'id_divprosbu'
			, header	: 'Divisi/ Proyek/ SBU'
			, dataIndex	: 'id_divprosbu'
			, width		: 100
			, sortable	: true
			, renderer	: combo_renderer(this.form_divprosbu)
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();

					if (data.length) {
						m_kel_jabatan_csc_id = data[0].data.id;
					} else {
						m_kel_jabatan_csc_id = '';
					}
					keljabcsc_on_select_load_peg_komite();
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
		});

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_ref
			]
		});

	this.grid = new Ext.grid.GridPanel({
			title			: "Daftar Central Komite"
		,	region			: 'center'
		,	store			: this.store
		,	sm				: this.sm
		,	columns			: this.columns
		,	plugins			: this.editor
		,	tbar			: this.toolbar
		,	width			: '35%'
		,	autoExpandColumn: 'nama'
		});

	this.do_load = function()
	{
		this.store_direktorat.load();
		this.store_divprosbu.load({
					callback : function(){
						this.store.load();
					}
				,	scope : this
		});
		
	}

	this.do_refresh = function()
	{
		this.do_load();
	}
}

function M_ListPegawai()
{
	this.id_dep		= 0;
	this.id_dinas		= 0;
	this.id_seksi		= 0;
	
	this.record = new Ext.data.Record.create([
			{name:'nipg'}
		,	{name:'nama_klasifikasi_pegawai'}
		,	{name:'nama_jabatan'}
		,	{name:'nama_departemen'}
		,	{name:'nama_dinas'}
		,	{name:'nama_seksi'}
		,	{name:'nama_pegawai'}
		,	{name:'email'}
		,	{name:'status_pegawai'}
		]);
	
	this.set_org = new k3pl.form.SetOrganisasi({
			itemAll		:true
		,	scope		:this
		,	onCheckClick	:function() {
				this.scope.set_checked()
			}
		});
	this.reader = new Ext.data.JsonReader({
			id	: 'nipg'
		,	root: 'rows'
		}
		, this.record);

	this.store = new Ext.data.Store({
			url		: _g_root +'/module/ref_pegawai_komite/data_pegawai.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			id			: 'nipg'
		,	header		: 'NIPG'
		,	dataIndex	: 'nipg'
		},{
			header		: 'Nama'
		,	dataIndex	: 'nama_pegawai'
		},{
			header		: 'Klasifikasi'
		,	dataIndex	: 'nama_klasifikasi_pegawai'
		},{
			header		: 'Jabatan'
		,	dataIndex	: 'nama_jabatan'
		,	width		: 200
		},{
			header		: 'Departemen'
		,	dataIndex	: 'nama_departemen'
		,	width		: 200
		},{
			header		: 'Dinas'
		,	dataIndex	: 'nama_dinas'
		,	width		: 200
		},{
			header		: 'Seksi'
		,	dataIndex	: 'nama_seksi'
		,	width		: 200
		},{
			header		: 'Email'
		,	dataIndex	: 'email'
		}];

	this.cm = new Ext.grid.ColumnModel({
			columns		:this.columns
		,	defaults	:{
				sortable	:true
			}
		});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: false
		,	viewConfig		: {forceFit:true}
		});

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.do_load();
			}
		});

	this.btn_pilih = new Ext.Button({
			text		: 'Pilih'
		,	iconCls		: 'add16'
		,	scope		: this
		,	handler		: function() {
				var pegawaiSelected = this.sm.getSelections();

				if (!pegawaiSelected.length){
					return;
				}

				m_list_pegawai_komite.editor.stopEditing();
				m_list_pegawai_komite.store.insert(0, pegawaiSelected);
				m_list_pegawai_komite.sm.selectRow(0);
				m_list_pegawai_komite.editor.startEditing(0);

				m_ref_peg_con.layout.setActiveItem(0);
			}
		});

	this.btn_cancel = new Ext.Button({
			text		: 'Batal'
		,	iconCls		: 'del16'
		,	scope		: this
		,	handler		: function() {
				m_ref_peg_con.layout.setActiveItem(0);
			}
		});

	this.btn_filter = new Ext.Button({
		text		: 'Filter'
	,	listeners	: {
			scope	: this
		,	click	: function(btn, e) {
				this.store_load_param(
						this.set_org.formDirektorat.getValue()
					,	this.set_org.formDivProSBU.getValue()
					,	this.set_org.formDepartemen.getValue()
					,	this.set_org.formDinas.getValue()
					,	this.set_org.formSeksi.getValue()
				);
			}
		}
	});
	
	this.filterOrg = new Ext.form.FormPanel({
		frame		: true
	,	region		: 'center'
	,	width		: 450
	,	autoHeight	: true
	,	autoScroll	: true
	,	labelAlign	: 'right'
	,	items		: [
			this.set_org
		]
	,	buttonAlign	: 'center'
	,	buttons		: [
			this.btn_filter
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title		: 'Daftar Pegawai'
		,	region		: 'south'
		,	height		: 250
		,	store		: this.store
		,	sm			: this.sm
		,	cm			: this.cm
		,	tbar		: [
				this.btn_cancel
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_pilih
			]
		});
	
	this.panel = new Ext.Container({
			id			: 'list_pegawai_panel'
		,	layout		: 'border'
		,	bodyBorder	: false
		,	autoScroll	: true
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    		}
		,	items		: [
				this.filterOrg
			,	this.grid
			]
		});
	
	this.store_load_param = function (id_direktorat,id_divprosbu,id_departemen,id_dinas,id_seksi){
		this.store.load({
			scope		: this
		,	params		: {
				id_direktorat		: id_direktorat
			,	id_divprosbu		: id_divprosbu
			,	id_departemen		: id_departemen
			,	id_dinas			: id_dinas
			,	id_seksi			: id_seksi
			}
		});
	}
	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.do_load();
		this.set_org.do_load();
	}
}

function M_RefPegawaiKomite()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
			{name:'nipg'}
		,	{name:'nama_pegawai'}
		,	{name:'id_jabatan_komite'}
		,	{name:'nama_jabatan_komite'}
		]);

	this.reader = new Ext.data.JsonReader({
			id	: 'id'
		,	root: 'rows'
		}
		, this.record);

	this.store = new Ext.data.Store({
			url		: _g_root +'/module/ref_pegawai_komite/data_pegawai_komite.jsp'
		,	reader	: this.reader
		,	autoLoad: false
		});

	this.store_jabatan_komite = new Ext.data.ArrayStore({
			fields	: ['id_jabatan_komite','nama_jabatan_komite']
		,	url		: _g_root +'/module/ref_pegawai_komite/data_jabatan_komite_com.jsp'
		,	autoLoad: false
		});

	this.cb_jabatan_komite = new Ext.form.ComboBox({
			store		: this.store_jabatan_komite
		,	valueField	: 'id_jabatan_komite'
		,	displayField	: 'nama_jabatan_komite'
		,	mode		: 'local'
		,	allowBlank	: false
		,	typeAhead	: true
		,	triggerAction	: 'all'
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'nipg'
			, header	: 'NIPG'
			, dataIndex	: 'nipg'
			, sortable	: true
			}
		,	{ id		: 'nama_pegawai'
			, header	: 'Nama Pegawai'
			, dataIndex	: 'nama_pegawai'
			, sortable	: true
			}
		,	{ id		: 'id_jabatan_komite'
			, header	: 'Jabatan Komite'
			, dataIndex	: 'id_jabatan_komite'
			, sortable	: true
			, editor	: this.cb_jabatan_komite
			, renderer	: combo_renderer(this.cb_jabatan_komite)
			}	
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length
					&&  m_ref_jab_kom_ha_level == 4) {
						this.btn_del.setDisabled(false);
						m_jabatan_komite_old = data[0].data.id_jabatan_komite;
					} else {
						this.btn_del.setDisabled(true);
						m_jabatan_komite_old ='';
					}
				}
			}
		});

	this.editor = new Ext.ux.grid.RowEditor({
			saveText : 'Simpan'
		,	listeners: {
				scope		: this
			,	canceledit	:
					function(roweditor, state) {
						if (state === true) {
							this.do_cancel();
						}
					}
			,	afteredit	:
					function(roweditor, object, record, idx) {
						this.do_save(record);
					}
			}
		});

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
		});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
		});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
		});

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		});

	this.panel = new Ext.grid.GridPanel({
			title		: 'Daftar Pegawai Komite'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: [this.editor]
		,	tbar		: this.toolbar
		,	listeners	: {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
				}
			}
		});

	this.do_add = function()
	{	
		if (!M_ValidatePegawaiKomite()){
			return;
		}
		this.dml_type = 2;

		this.do_load_peg();
		this.do_load_jab_komite();
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
		this.do_load();
	}

	this.do_cancel = function()
	{
		var data = this.sm.getSelections();

		if (this.dml_type == 2) {
			this.store.remove(data);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				nipg				: record.data['nipg']
			,	id_jabatan_komite	: record.data['id_jabatan_komite']
			,	id_jabatan_komite_old	: m_jabatan_komite_old
			,	id_kel				: m_kel_jabatan_komite_id
			,   dml_type			: this.dml_type
			}
		,	url		: _g_root +'/module/ref_pegawai_komite/submit_pegawai_komite.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
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
		var data = this.sm.getSelections();

		if (m_ref_jab_kom_ha_level >= 3) {
			if (Ext.isEmpty(data[0].data.id_jabatan_komite)) {
				this.dml_type = 2;
			}else{
				this.dml_type = 3;
			}
			return true;
		}
		return false;
	}

	this.do_load_peg = function()
	{
		m_list_pegawai.store.load({
			callback: function() {
				m_ref_peg_con.layout.setActiveItem(1);
			}
		,	scope	: this
		});
	}
	
	this.do_load_jab_komite = function (){
		this.store_jabatan_komite.load({
			params		:{
				id_kel_csc	: m_kel_jabatan_csc_id
			,	id_kel		: m_kel_jabatan_komite_id
			}
		});
	}
	
	this.do_load = function()
	{
		this.do_load_jab_komite();
		this.store.load({
			params		:{
				id_kel	: m_kel_jabatan_komite_id
			,	id_kel_csc	: m_kel_jabatan_csc_id
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		m_ref_jab_kom_ha_level = ha_level;
		if (m_ref_jab_kom_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

function M_PegawaiKomite()
{
	m_list_kel_jabatan_csc		= new M_RefKelJabatanCSC();
	m_list_kel_jabatan_komite	= new M_RefKelJabatanKomite();
	m_list_pegawai_komite		= new M_RefPegawaiKomite();
	m_list_pegawai				= new M_ListPegawai();

	this.col_left = new Ext.Container({
		region		: 'west'
	,	layout		: 'border'
	,	width		: '50%'
	,	align		: 'scretch'
	,	defaults	: {
			loadMask	: {msg: 'Pemuatan...'}
		,	split		: true
		,	autoScroll	: true
		,	animCollapse	: true
			}
	,	items	: [
			m_list_kel_jabatan_csc.grid
		,	m_list_kel_jabatan_komite.grid
		]
	});

	m_ref_peg_con = new Ext.Panel({
			region		: 'center'
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
		,	items		: [
				m_list_pegawai_komite.panel
			,	m_list_pegawai.panel
			]
		});

	this.panel = new Ext.Panel({
			id			: 'ref_pegawai_komite_panel'
		,	layout		: 'border'
		,	bodyBorder	: false
		,	autoScroll	: true
		,	scope		: this
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse: true
			}
		,	items		: [
				this.col_left
			 ,	m_ref_peg_con
			]
		});

	this.do_refresh = function(ha_level)
	{
		m_ref_ha_level = ha_level;
		m_list_pegawai.do_refresh(m_ref_ha_level);
		m_list_kel_jabatan_csc.do_refresh(m_ref_ha_level);
		m_list_kel_jabatan_komite.do_refresh(m_ref_ha_level);
		m_list_pegawai_komite.do_refresh(m_ref_ha_level);
	}
}

var m_ref_pegawai_komite = new M_PegawaiKomite();

//@ sourceURL=ref_pegawai_komite.layout.js
