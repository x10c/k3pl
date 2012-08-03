/**
 * Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - mhd.sulhan (ms@kilabit.org)
 */

var m_repo_browse;
var m_repo_browse_tree;
var m_repo_browse_content;
var m_repo_browse_d = _g_root +'/module/repo_browse/';
var m_repo_browse_id	= 1;
var m_repo_browse_pid	= 0;
var m_repo_browse_path	= "";
var m_repo_browse_rpath	= "";

function MRepoBrowseContent()
{
/*
 * windows upload
 */
	this.form_file = new Ext.form.TextField({
		fieldLabel	:"Pilih File"
	,	inputType	:"file"
	});

	this.btn_up = new Ext.Button({
		text	:"Upload"
	,	iconCls	:"upload16"
	,	scope	:this
	,	handler	:function() {
			this.do_upload();
		}
	});
	this.form_upload = new Ext.form.FormPanel({
		fileUpload	:true
	,	labelAlign	:"right"
	,	buttonAlign	:"center"
	,	padding		:10
	,	items		:[
			this.form_file
		]
	,	buttons		:[
			this.btn_up
		]
	});

	this.win_upload = new Ext.Window({
		title		:"Upload Dokumen"
	,	modal		:true
	,	autoHeight	:true
	,	closeAction	:"hide"
	,	width		:400
	,	items		:[
			this.form_upload
		]
	});

/*
 * grid
 */
	this.fields = new Ext.data.Record.create([
		{name:"id"}
	,	{name:"pid"}
	,	{name:"type"}
	,	{name:"name"}
	,	{name:"owner"}
	,	{name:"group"}
	,	{name:"size"}
	,	{name:"perm"}
	,	{name:"uploader"}
	,	{name:"upload_date"}
	]);

	this.reader = new Ext.data.JsonReader({
		root:"data"
	}, this.fields);

	this.store = new Ext.data.Store({
		url		:m_repo_browse_d +"data_content.jsp"
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	:[{
			header		:"Nama"
		,	id			:"name"
		,	dataIndex	:"name"
		,	renderer	:function (v, md, r) {
				if (r.get("type") != 0) {
					return "<a class='doc' target='_blank'"
						+" href='" + _g_root + "/module/repo_browse/download.jsp?id="+ r.get("id") +"'>"
						+ v +"</a>";
				}

				if (r.get("name") == "..") {
					return "<span class='dirup'>"+ v +"</span>";
				}

				return "<span class='dir'>"+ v +"</span>";
			}
		},{
			header		:"Ukuran"
		,	dataIndex	:"size"
		},{
			header		:"Tanggal"
		,	dataIndex	:"upload_date"
		,	align		:"center"
		,	width		:160
		}]
	,	defaults	:{
			sortable	:true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	:true
	});

	this.btn_mkdir = new Ext.Button({
		text	:"Buat Direktori"
	,	iconCls	:"add16"
	,	scope	:this
	,	handler	:function() {
			this.do_mkdir();
		}
	});

	this.btn_del = new Ext.Button({
		text	:"Hapus"
	,	iconCls	:"del16"
	,	scope	:this
	,	handler	:function() {
			this.do_del();
		}
	});

	this.btn_rename = new Ext.Button({
		text	:"Ubah Nama"
	,	iconCls	:"edit16"
	,	scope	:this
	,	handler	:function() {
			this.do_rename();
		}
	});

	this.btn_upload	= new Ext.Button({
		text	:"Upload"
	,	iconCls	:"upload16"
	,	scope	:this
	,	handler	:function() {
			this.win_upload.show ();
		}
	});

	this.panel = new Ext.grid.GridPanel({
		store			:this.store
	,	cm				:this.cm
	,	sm				:this.sm
	,	autoExpandColumn:"name"
	,	bodyBorder		:false
	,	border			:false
	,	region			:"center"
	,	tbar			:[
			this.btn_del	, "-"
		,	this.btn_rename	, "-"
		,	this.btn_mkdir	, "-"
		,	this.btn_upload
		]
	,	listeners		:{
			scope		:this
		,	rowdblclick	:function(grid, idx, eo) {
				var r	= this.store.getAt(idx);
				var t	= r.get("type");

				if (t != 0) {
					return;
				}

				var node;
				var name = r.get("name");

				if (name == "..") {
					if (m_repo_browse_pid == 0) {
						return;
					}

					node = m_repo_browse_tree.panel.getNodeById(m_repo_browse_pid);

					m_repo_browse_id	= m_repo_browse_pid;
					m_repo_browse_pid	= node ? node.attributes.pid : 0;
				} else {
					m_repo_browse_id	= r.get("id");
					m_repo_browse_pid	= r.get("pid");

					node = m_repo_browse_tree.panel.getNodeById(m_repo_browse_id);
				}

				m_repo_browse_rpath	= node ? node.getPath("text") : "///";
				m_repo_browse_path	= m_repo_browse_rpath.substring(2);

				m_repo_browse_tree.panel.selectPath(m_repo_browse_path);

				this.do_load();
			}
		}
	});

	this.is_name_exist = function(name)
	{
		var i = 0;
		var l = this.store.getCount();
		var r;

		for (; i < l; i++) {
			r = this.store.getAt(i);

			if (r.get("name") == name) {
				return 1;
			}
		}
		return 0;
	}

	this.do_del = function()
	{
		var r = this.sm.getSelected();
		if (!r) {
			Ext.Msg.alert("Pesan"
			,"Pilih file/direktori yang akan dihapus terlebih dahulu!");
			return;
		}

		var name = r.get("name");
		var type = r.get("type");

		Ext.Msg.confirm("Konfirmasi"
			, "Apakah anda yakin akan menghapus '"+ name +"' ?"
			, function fn(btn) {
				if (btn == "no") {
					return;
				}

				main_load.show();

				Ext.Ajax.request({
					url		:m_repo_browse_d +"submit_del.jsp"
				,	scope	:this
				,	params	:{
						id		:r.get("id")
					,	type	:type
					,	name	:name
					,	path	:m_repo_browse_path
					}
				,	failure	:function (r, o) {
						var msg = Ext.util.JSON.decode(r.responseText);
						Ext.Msg.alert('Error', msg.info);
						main_load.hide();
					}
				,	success	:function (r, o) {
						var msg = Ext.util.JSON.decode(r.responseText);

						if (msg.success == false) {
							Ext.Msg.alert('Pesan', msg.info);
						}

						m_repo_browse_tree.do_refresh();
						this.do_load();
						main_load.hide();
					}
				});
			}
			, this
		);
	}

	this.do_rename = function()
	{
		if (m_repo_browse_id <= 0) {
				Ext.Msg.alert("Pesan", "Silahkan pilih direktori terlebih dahulu!");
				return;
		}

		var r = this.sm.getSelected();
		if (!r) {
			return;
		}

		var name = r.get("name");

		Ext.Msg.prompt("Ubah Nama File/Direktori"
			, "Nama Direktori"
			, function fn(btn, text) {
				if (btn != "ok" || text == "") {
					return;
				}

				var s = this.is_name_exist(text);

				if (s) {
					Ext.Msg.alert("Pesan"
						,"Nama yang sama telah ada di dalam direktori!"
					);
					return;
				}

				main_load.show();

				Ext.Ajax.request({
					url		:m_repo_browse_d +"submit_rename.jsp"
				,	scope	:this
				,	params	:{
						id		:r.get("id")
					,	path	:m_repo_browse_path
					,	from	:r.get("name")
					,	to		:text
					}
				,	failure	:function(r) {
						var msg = Ext.util.JSON.decode(r.responseText);

						Ext.Msg.alert('Error', msg.info);
						main_load.hide();
					}
				,	success	:function(r) {
						m_repo_browse_tree.do_refresh();
						this.do_load();
						main_load.hide();
					}
				});
			}
			, this
			, false
			, name
		);
	}

	this.do_mkdir = function(name)
	{
		if (m_repo_browse_id <= 0) {
				Ext.Msg.alert("Pesan", "Silahkan pilih direktori terlebih dahulu!");
				return;
		}

		Ext.Msg.prompt("Buat Direktori Baru"
			, "Nama Direktori"
			, function fn(btn, text) {
				if (btn != "ok" || text == "") {
					return;
				}

				/* check file with the same name in the current dir */
				var s = this.is_name_exist(text);

				if (s) {
					Ext.Msg.alert("Pesan"
						,"Nama yang sama telah ada di dalam direktori!"
					);
					return;
				}

				main_load.show();

				Ext.Ajax.request({
					url		:m_repo_browse_d +"submit_mkdir.jsp"
				,	scope	:this
				,	params	:{
						id		:m_repo_browse_id
					,	path	:m_repo_browse_path
					,	name	:text
					}
				,	failure	:function(r) {
						var msg = Ext.util.JSON.decode(r.responseText);

						Ext.Msg.alert('Error', msg.info);
						main_load.hide();
					}
				,	success	:function(r) {
						m_repo_browse_tree.do_refresh();
						this.do_load();
						main_load.hide();
					}
				});
			}
			, this
		);
	}

	this.do_upload = function()
	{
		var name = this.form_file.getValue();
		if (name == "") {
			return;
		}

		var s = name.lastIndexOf("\\");
		if (s > 0) {
			name = name.substring(s + 1);
		}

		s = this.is_name_exist(name);

		if (s) {
			Ext.Msg.alert("Pesan"
				,"Dokumen dengan nama yang sama telah ada di dalam direktori!"
			);
			return;
		}

		main_load.show();

		this.form_upload.getForm().doAction("submit", {
			url		:m_repo_browse_d +"submit_file.jsp"
		,	params	:{
				id		:m_repo_browse_id
			,	path	:m_repo_browse_path
			,	name	:name
			}
		,	scope	:this
		,	failure	:function (form, action) {
				Ext.Msg.alert("Pesan", action.result.info);
				main_load.hide();
			}
		,	success	:function (form, action) {
				main_load.hide();

				if (action.result.success == false) {
					this.win_upload.show ();
					Ext.Msg.alert ("Kesalahan", action.result.info);
				} else {
					this.do_load();
				}
			}
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params	:{
				id	:m_repo_browse_id
			,	pid	:m_repo_browse_pid
			}
		});
	}

	this.do_refresh = function()
	{
	}
}

function MRepoBrowseTree()
{
	this.loader = new Ext.tree.TreeLoader({
		dataUrl		:m_repo_browse_d +"data_tree.jsp"
	,	listeners	: {
			scope	:this
		,	load	:function() {
				this.panel.expandAll();

				if (m_repo_browse_rpath != "") {
					this.panel.selectPath(m_repo_browse_rpath);
				} else {
					this.panel.collapseAll();
				}
			}
		}
	});

	this.btn_refresh = new Ext.Button({
		text	:"Refresh"
	,	iconCls	:"refresh16"
	,	scope	:this
	,	handler	:function () {
			this.do_refresh();
		}
	});

	this.panel = new Ext.tree.TreePanel({
		title		:"Navigasi"
	,	region		:"west"
	,	autoScroll	:true
	,	animate		:true
	,	bodyBorder	:false
	,	border		:false
	,	collapsible	:true
	,	rootVisible	:false
	,	split		:true
	,	useArrows	:true
	,	width		:"30%"
	,	loader		:this.loader
	,	tbar		:[
			this.btn_refresh
		]
	,	listeners	: {
			click	: function(node) {
				this.node_on_click(node);
			}
		,	scope		:this
		}
	,	root		: {
			id		:0
		,	text	:""
		}
	});

	this.node_on_click = function(node)
	{
		m_repo_browse_id	= node.id;
		m_repo_browse_pid	= node.attributes.pid;
		m_repo_browse_rpath	= node.getPath("text");
		m_repo_browse_path	= m_repo_browse_rpath.substring(2);

		m_repo_browse_content.do_load();
	}

	this.do_refresh = function()
	{
		this.loader.load(this.panel.getRootNode());
	}
}

function MRepoBrowse()
{
	m_repo_browse_tree		= new MRepoBrowseTree();
	m_repo_browse_content	= new MRepoBrowseContent();

	this.panel = new Ext.Panel({
		id			:"repo_browse_panel"
	,	layout		:"border"
	,	bodyBorder	:false
	,	border		:false
	,	items		:[
			m_repo_browse_tree.panel
		,	m_repo_browse_content.panel
		]
	});

	this.do_refresh = function()
	{
		m_repo_browse_content.do_refresh();
	}
}

m_repo_browse = new MRepoBrowse();

//@ sourceURL=repo_browse.layout.js
