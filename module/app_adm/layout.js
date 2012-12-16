/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_app_adm;
var m_app_adm_d = _g_root +'/module/app_adm/';

var m_adm_grup;
var m_adm_user;
var m_adm_menu;
var m_adm_ha_level	= 0;
var m_adm_grup_id	= '';

function grup_on_select_load_others()
{
	if (typeof m_adm_grup == 'undefined'
	||  m_adm_grup_id     == '') {
		return;
	}
	if (typeof m_adm_user != 'undefined') {
		m_adm_user.do_load();
	}
	if (typeof m_adm_menu != 'undefined') {
		m_adm_menu.do_load();
	}
}

function M_AdmGrup()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
		{ name	: 'id_grup' }
	,	{ name	: 'nama_grup' }
	,	{ name	: 'keterangan_grup' }
	]);

	this.store = new Ext.data.ArrayStore({
			url		: m_app_adm_d +'data_grup.jsp'
		,	fields	: this.record
		,	autoLoad: false
		});

	this.form_nama_grup = new Ext.form.TextField({
			allowBlank	: false
		});

	this.form_ket_grup = new Ext.form.TextField({
			allowBlank	: true
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			id			: 'nama_grup'
		,	header		: 'Nama'
		,	dataIndex	: 'nama_grup'
		,	sortable	: true
		,	editor		: this.form_nama_grup
		},{
			header		: 'Keterangan'
		,	dataIndex	: 'keterangan_grup'
		,	editor		: this.form_ket_grup
		}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();

					if (data.length) {
						if (m_adm_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_adm_grup_id = data[0].data['id_grup'];
						grup_on_select_load_others();
					} else {
						this.btn_del.setDisabled(true);
						m_adm_grup_id = '';
					}
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah Grup'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
		});

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.do_refresh(m_adm_ha_level);
			}
		});

	this.btn_del = new Ext.Button({
			text		: 'Hapus Grup'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
		});

	this.panel = new Ext.grid.GridPanel({
			title		: 'Grup User'
		,	region		: 'center'
		,	height		: 200
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		,	collapsible		: true
		,	autoExpandColumn: 'nama_grup'
		,	listeners		: {
				scope		: this
			,	rowdblclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
			}
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_grup		: ''
			,	nama_grup	: ''
			,	keterangan_grup	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelected();
		if (!data) {
			return;
		}

		Ext.Msg.confirm("Hapus Grup"
		, "Apakah anda yakin menghapus grup '"+ data.get('nama_grup') +"' ?"
		, function(btn) {
			if (btn == 'no') {
				return;
			}
			this.dml_type = 4;
			this.do_save(data);
		}
		, this);
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
				id_grup			: record.data['id_grup']
			,	nama_grup		: record.data['nama_grup']
			,	keterangan_grup	: record.data['keterangan_grup']
			,	dml_type		: this.dml_type
			}
		,	url		: m_app_adm_d +'submit_grup.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert(
						'Pesan Kesalahan', msg.info);
					}

					this.store.load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_adm_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}

		return false;
	}

	this.do_refresh = function()
	{
		if (m_adm_ha_level <= 1) {
			this.btn_add.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
		}

		this.store.reload();
	}
}

function M_AdmUser()
{
	this.dml_type = 0;

	this.record_user = new Ext.data.Record.create([
			{name: 'nipg'}
		,	{name: 'nama_pegawai'}
		]);

	this.store = new Ext.data.ArrayStore({
			url	: m_app_adm_d +'data_user_in_group.jsp'
		,	fields	: ['nipg', 'name', 'nama_direktorat', 'nama_divprosbu', 'nama_departemen']
		,	autoLoad: false
		});

	this.store_peg = new Ext.data.ArrayStore({
			fields	: this.record_user
		,	url	: m_app_adm_d +'data_user.jsp'
		,	autoLoad: false
		});

	this.form_nipg = new Ext.form.TextField({
			disabled	: true
		});

	this.form_user = new Ext.form.ComboBox({
			fieldLabel	: 'User'
		,	store		: this.store_peg
		,	valueField	: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode		: 'local'
		,	triggerAction	: 'all'
		,	allowBlank	: false
		,	typeAhead	: true
		,	listeners	: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_nipg.setValue(record.data['nipg']);
				}
			}
		});

	this.cm = new Ext.grid.ColumnModel({
		columns: [
				new Ext.grid.RowNumberer()
			,{
				header		: 'NIPG'
			,	dataIndex	: 'nipg'
			,	editor		: this.form_nipg
			,	width		:180
			},{
				id			: 'name'
			,	header		: 'Nama'
			,	dataIndex	: 'name'
			,	flex		:1
			,	editor		: this.form_user
			,	renderer	: combo_renderer(this.form_user)
			},{
				header		:'Direktorat'
			,	dataIndex	:'nama_direktorat'
			,	width		:180
			,	hidden		:true
			},{
				header		:'Divisi/Proyek/SBU'
			,	dataIndex	:'nama_divprosbu'
			,	width		:180
			,	hidden		:true
			},{
				header		:'Departemen'
			,	dataIndex	:'nama_departemen'
			,	width		:180
			,	hidden		:true
			}
		]
	,	defaults: {
			sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();

					if (data.length && m_adm_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.btn_add = new Ext.Button({
			text	: 'Tambah User'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
		});

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.do_load();
			}
		});

	this.btn_del = new Ext.Button({
			text		: 'Hapus User'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
		});

	this.editor = new MyRowEditor(this);

	this.panel = new Ext.grid.EditorGridPanel({
			title			: 'Daftar User'
		,	region			: 'south'
		,	autoExpandColumn: 'name'
		,	store			: this.store
		,	sm				: this.sm
		,	cm				: this.cm
		,	plugins			: this.editor
		,	collapsible		:true
		,	height			: 200
		,	tbar			: [
				this.btn_del
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		,	listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return false;
					}
			}
		});

	this.do_add = function()
	{
		if (m_adm_grup_id == '') {
			return;
		}

		this.record_new = new this.record_user({
				nipg			: ''
			,	nama_pegawai	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_save = function(record)
	{
		if (m_adm_grup_id == '') {
			return;
		}

		Ext.Ajax.request({
			params  : {
				dml_type	: this.dml_type
			,	id_grup		: m_adm_grup_id
			,	nipg		: record.data['nipg']
			}
		,	url	: m_app_adm_d +'submit_user.jsp'
		,	scope	: this
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert(
						'Pesan Kesalahan', msg.info);
					}

					this.do_load();
				}
		});
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_load = function()
	{
		if (m_adm_grup_id == '') {
			return;
		}

		this.store.load({
			params	: {
				id_grup : m_adm_grup_id
			}
		});
		this.store_peg.load();
	}

	this.do_refresh = function()
	{
		if (m_adm_ha_level <= 1) {
			this.btn_add.setDisabled(true);
		} else {
			this.btn_add.setDisabled(false);
		}
		this.do_load();
	}
}

function M_AdmMenu()
{
	this.reader = new Ext.data.ArrayReader({}, [
		{ name:'menu_parent'}
	,	{ name:'menu_id'}
	,	{ name:'menu_name'}
	,	{ name:'ha_level'}
	,	{ name:'ha_level_org'}
	]);

	this.store = new Ext.data.GroupingStore({
			url		: m_app_adm_d +'data_menu.jsp'
		,	reader		: this.reader
		,	groupField	: 'menu_parent'
		,	autoLoad	: false
		});

	this.store_ha_level = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['0', 'No Access']
			,	['1', 'View']
			,	['2', 'Insert']
			,	['3', 'Update']
			,	['4', 'Delete']
			]
		})

	this.cb_ha_level = new Ext.form.ComboBox({
			store		: this.store_ha_level
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		});

	this.cm = new Ext.grid.ColumnModel({
		columns: [
			new Ext.grid.RowNumberer()
		,{
			id			: 'menu_name'
		,	header		: 'Nama'
		,	dataIndex	: 'menu_name'
		},{
			header		: 'Hak Akses'
		,	dataIndex	: 'ha_level'
		,	align		: 'center'
		,	editor		: this.cb_ha_level
		,	renderer	: combo_renderer(this.cb_ha_level)
		,	width		: 30
		},{
			header		: 'Menu'
		,	dataIndex	: 'menu_parent'
		,	hidden		: true
		,	hideable	: false
		}
		]
	,	defaults: {
			sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text		: 'Refresh'
		,	iconCls		: 'refresh16'
		,	scope		: this
		,	handler		: function() {
				this.do_load();
			}
		});

	this.grid_view = new Ext.grid.GroupingView({
		forceFit		: true
	,	remoteGroup		: true
	,	groupOnSort		: true
	,	enableGroupingMenu	: false
	,	showGroupName		: false
	,	onLoad			: Ext.emptyFn
	,	listeners		: {
			beforerefresh	: function(v)
			{
				v.scrollTop	= v.scroller.dom.scrollTop;
				v.scrollHeight	= v.scroller.dom.scrollHeight;
			}
		,	refresh		: function(v)
			{
				v.scroller.dom.scrollTop = v.scrollTop
					+ (v.scrollTop == 0 ? 0
					: v.scroller.dom.scrollHeight - v.scrollHeight);
			}
		}
	});

	this.panel = new Ext.grid.GridPanel({
			region		: 'center'
		,	title		: 'Daftar Menu'
		,	store		: this.store
		,	sm		: this.sm
		,	cm		: this.cm
		,	plugins		: this.editor
		,	autoExpandColumn: 'menu_name'
		,	view		: this.grid_view
		,	tbar		: [
				this.btn_ref
			]
		,       listeners       : {
				scope		: this
			,	rowdblclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
                       }
		});

	this.do_edit = function()
	{
		if (m_adm_ha_level >= 3) {
			return true;
		}

		return false;
	}

	this.do_cancel = function()
	{
		var data = this.sm.getSelections();

		if (!data.length) {
			return;
		}

		var record = data[0];

		this.cb_ha_level.setValue(record.data['ha_level_org']);
	}

	this.do_save = function(record)
	{
		var ha_level		= record.data['ha_level'];
		var ha_level_org	= record.data['ha_level_org'];

		if (ha_level == ha_level_org) {
			return;
		}

		Ext.Ajax.request({
			params  : {
				id_grup		: m_adm_grup_id
			,	menu_id		: record.data['menu_id']
			,	ha_level	: ha_level
			,	ha_level_org	: ha_level_org
			}
		,	url	: m_app_adm_d +'submit_menu.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert(
						'Pesan Kesalahan', msg.info);
					}

					this.do_load();
				}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		if (m_adm_grup_id == '') {
			return;
		}

		this.store.load({
			params	: {
				id_grup : m_adm_grup_id
			}
		});
	}
}

function M_Administrasi()
{
	m_adm_grup	= new M_AdmGrup();
	m_adm_user	= new M_AdmUser();
	m_adm_menu	= new M_AdmMenu();

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
				m_adm_grup.panel
			,	m_adm_user.panel
			]
		});

	this.panel = new Ext.Container({
			id		: 'app_adm_panel'
		,	layout		: 'border'
		,	scope		: this
		,	autoScroll	: true
		,	defaults	: {
				loadMask	: {msg: 'Pemuatan...'}
			,	split		: true
			,	autoScroll	: true
			,	animCollapse	: true
    			}
		,	items		: [
				this.col_left
			,	m_adm_menu.panel
			]
		});

	this.do_refresh = function(ha_level)
	{
		m_adm_ha_level = ha_level;

		m_adm_grup.do_refresh();
		m_adm_user.do_refresh();
	}
}

m_app_adm = new M_Administrasi();

//@ sourceURL=app_adm.layout.js
