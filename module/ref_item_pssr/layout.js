var m_ref_item_pssr;
var m_ref_item_pssr_d = _g_root +'/module/ref_item_pssr/';
var m_ref_item_pssr_kel;
var m_ref_item_pssr_tipe;
var m_ref_item_pssr_detail;
var m_ref_item_pssr_id_kel	= '0';
var m_ref_item_pssr_id_tipe	= '0';
var m_ref_item_pssr_ha_level	= 0;

function kat_on_select_load_tipe()
{
	if (typeof m_ref_item_pssr_kel	== 'undefined'
	||  typeof m_ref_item_pssr_tipe	== 'undefined'
	||  m_ref_item_pssr_id_kel		== '0') {
		return;
	}

	m_ref_item_pssr_tipe.do_load();
}

function item_on_select_load_detail()
{
	if (typeof m_ref_item_pssr_tipe	== 'undefined'
	||  typeof m_ref_item_pssr_detail	== 'undefined'
	||  m_ref_item_pssr_id_kel		== '0'
	||  m_ref_item_pssr_id_tipe		== '0') {
		return;
	}

	m_ref_item_pssr_detail.do_load();
}

function M_RefKategori()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'name'}
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_item_pssr_d +'data_kategori.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,{
			id		: 'name'
		,	header		: 'Nama'
		,	dataIndex	: 'name'
		,	sortable	: true
		,	editor	: this.form_name
		}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						if (m_ref_item_pssr_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_ref_item_pssr_id_kel = data[0].data['id'];
					} else {
						this.btn_del.setDisabled(true);
						m_ref_item_pssr_id_kel = '0';
					}

					kat_on_select_load_tipe();
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
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
			title		: 'Kategori'
		,	region		: 'west'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'name'
		,	collapsible	: true
		,	width		: '33%'
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit();
					}
                        }
		});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id	: ''
			,	name: ''
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
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_item_pssr_d +'submit_kategori.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.store.load();
				}
		,	scope	: this
		});
	}

	this.do_edit = function()
	{
		if (m_ref_item_pssr_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function()
	{
		if (m_ref_item_pssr_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
		this.do_load();
	}
}

function M_RefItem()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'name'}
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_item_pssr_d +'data_item.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama Item'
			, dataIndex	: 'name'
			, sortable	: true
			, editor	: this.form_name
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						if (m_ref_item_pssr_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
						m_ref_item_pssr_id_tipe = data[0].data['id'];
					} else {
						this.btn_del.setDisabled(true);
						m_ref_item_pssr_id_tipe = '0';
					}

					item_on_select_load_detail();
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
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
			title		: 'Item'
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'name'
		,	listeners       : {
				scope		: this
			,	rowclick	: function (g, r, e) {
					return this.do_edit();
				}
			}
		});

	this.do_add = function()
	{
		if (m_ref_item_pssr_id_kel == '0') {
			Ext.Msg.alert("Kesalahan Operasi"
		, "Silahkan pilih salah satu kelompok observasi terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id	: ''
			,	name: ''
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
				id_kat	: m_ref_item_pssr_id_kel
			,	id		: record.data['id']
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_item_pssr_d +'submit_item.jsp'
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
		if (m_ref_item_pssr_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_kat	: m_ref_item_pssr_id_kel
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_item_pssr_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
		this.do_load();
	}
}

function M_RefDetail()
{
	this.dml_type = 0;

	this.record = new Ext.data.Record.create([
			{name:'id'}
		,	{name:'name'}
		]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_item_pssr_d +'data_detail.jsp'
		,	autoLoad: false
		});

	this.form_name = new Ext.form.TextField({
			allowBlank	: false
		});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'name'
			, header	: 'Nama Detail'
			, dataIndex	: 'name'
			, sortable	: true
			, editor	: this.form_name
			}
		];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length
					&& m_ref_item_pssr_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
		});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
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
			title		: 'Detail'
		,	region		: 'east'
		,	store		: this.store
		,	sm		: this.sm
		,	columns		: this.columns
		,	plugins		: this.editor
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'name'
		,	width		: '33%'
		,       listeners       : {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
                        }

		});

	this.do_add = function()
	{
		if (m_ref_item_pssr_id_kel  == '0'
		||  m_ref_item_pssr_id_tipe == '0') {
			Ext.Msg.alert("Kesalahan Operasi"
		, "Silahkan pilih salah satu Kategori dan item PSSR terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id	: ''
			,	name: ''
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
				id_kat	: m_ref_item_pssr_id_kel
			,	id_item	: m_ref_item_pssr_id_tipe
			,	id		: record.data['id']
			,	name	: record.data['name']
			,	dml_type: this.dml_type
			}
		,	url		: m_ref_item_pssr_d +'submit_detail.jsp'
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
		if (m_ref_item_pssr_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_kat	: m_ref_item_pssr_id_kel
			,	id_item	: m_ref_item_pssr_id_tipe
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_ref_item_pssr_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_RefItemPssr()
{
	m_ref_item_pssr_kel	= new M_RefKategori();
	m_ref_item_pssr_tipe	= new M_RefItem();
	m_ref_item_pssr_detail= new M_RefDetail();

	this.panel = new Ext.Container({
			id		: 'ref_item_pssr_panel'
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
				m_ref_item_pssr_kel.panel
			,	m_ref_item_pssr_tipe.panel
			,	m_ref_item_pssr_detail.panel
			]
		});

	this.do_refresh = function(ha_level)
	{
		m_ref_item_pssr_ha_level	= ha_level;
		m_ref_item_pssr_id_kel 	= '0';
		m_ref_item_pssr_id_tipe	= '0';

		m_ref_item_pssr_kel.do_refresh();
		m_ref_item_pssr_tipe.do_refresh();
		m_ref_item_pssr_detail.do_refresh();
	}
}

m_ref_item_pssr = new M_RefItemPssr();

//@ sourceURL=ref_item_pssr.layout.js
