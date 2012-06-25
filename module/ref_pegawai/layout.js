/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_ref_pegawai;
var m_ref_pegawai_d = _g_root +'/module/ref_pegawai/';

function M_RefPegawai()
{
	this.dml_type		= 0;
	this.ha_level		= 0;
	this.id_direktorat	= '0';
	this.id_divprosbu	= '0';
	this.id_departemen	= '0';
	this.id_dinas		= '0';
	this.id_seksi		= '0';
/*
 * record and stores
 */
	this.record = new Ext.data.Record.create([
		{ name: 'nipg' }
	,	{ name: 'id_klasifikasi_pegawai' }
	,	{ name: 'id_jabatan' }
	,	{ name: 'id_direktorat' }
	,	{ name: 'id_divprosbu' }
	,	{ name: 'id_departemen' }
	,	{ name: 'id_dinas' }
	,	{ name: 'id_seksi' }
	,	{ name: 'nama_pegawai' }
	,	{ name: 'email' }
	,	{ name: 'status_pegawai' }
		]);

	this.store = new Ext.ux.data.PagingArrayStore({
			url		: m_ref_pegawai_d +'data.jsp'
		,	fields	: this.record
		,	idIndex	: 0
		,	autoLoad: false
		});

	this.store_klas = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url		: _g_root +'/module/ref_klas_pegawai/data.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_jabatan.load();
				}
			}
		});

	this.store_jabatan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: _g_root +'/module/ref_jabatan/data_jabatan.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_direktorat.load();
				}
			}
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
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_departemen.load({
						params	: {
							id_direktorat	: this.id_direktorat
						,	id_divprosbu	: this.id_divprosbu
						}
					});
				}
			}
	});

	this.store_departemen = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id_divprosbu', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_departemen.jsp'
		,	autoLoad	: false
		,	idIndex		: 2
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_dinas.load({
						params	: {
							id_direktorat	: this.id_direktorat
						,	id_divprosbu	: this.id_divprosbu
						,	id_departemen	: this.id_departemen
						}
					});
				}
			}
	});

	this.store_dinas = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id_divprosbu', 'id_departemen', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_dinas.jsp'
		,	autoLoad	: false
		,	idIndex		: 3
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.store_seksi.load({
						params	: {
							id_direktorat	: this.id_direktorat
						,	id_divprosbu	: this.id_divprosbu
						,	id_departemen	: this.id_departemen
						,	id_dinas		: this.id_dinas
						}
					});
				}
			}
	});

	this.store_seksi = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id_divprosbu', 'id_departemen', 'id_dinas', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_seksi.jsp'
		,	autoLoad	: false
		,	idIndex		: 4
		,	listeners	: {
				scope	: this
			,	load	: function(store, records, options) {
					this.do_load();
				}
			}
	});
	
/*
 * forms
 */
	this.form_nipg = new Ext.form.TextField({
			fieldLabel	: 'NIPG'
		,	allowBlank	: false
		,	width		: 200
	});

	this.form_name = new Ext.form.TextField({
			fieldLabel	: 'Nama Pegawai'
		,	allowBlank	: false
		,	width		: 200
	});

	this.form_email = new Ext.form.TextField({
			fieldLabel	: 'E-mail'
		,	vtype		: 'email'
		,	vtypeText	: 'Format email: nama@domain.tld'
		,	width		: 200
	});

	this.form_klas = new Ext.form.ComboBox({
			fieldLabel		: 'Klasifikasi'
		,	store			: this.store_klas
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 200
	});

	this.form_jabatan = new Ext.form.ComboBox({
			fieldLabel		: 'Jabatan'
		,	store			: this.store_jabatan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 200
	});

	this.form_seksi = new Ext.form.ComboBox({
			fieldLabel		: 'Seksi'
		,	store			: this.store_seksi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	editable		: false
		,	triggerAction	: 'all'
		,	width			: 400
	});

	this.form_dinas = new Ext.form.ComboBox({
			fieldLabel		: 'Dinas'
		,	store			: this.store_dinas
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	editable		: false
		,	triggerAction	: 'all'
		,	width			: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_dinas_on_select(record.get('id'));
				}
			}
	});

	this.form_departemen = new Ext.form.ComboBox({
			fieldLabel		: 'Departemen'
		,	store			: this.store_departemen
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_departemen_on_select(record.get('id'));
				}
			}
	});

	this.form_divprosbu = new Ext.form.ComboBox({
			fieldLabel		: 'Divisi/Proyek/SBU'
		,	store			: this.store_divprosbu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_divprosbu_on_select(record.get('id'));
				}
			}
	});

	this.form_direktorat = new Ext.form.ComboBox({
			fieldLabel		: 'Direktorat'
		,	store			: this.store_direktorat
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	width			: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_direktorat_on_select(record.get('id'));
				}
			}
	});

	this.form_status = new Ext.form.Checkbox({
			fieldLabel	: 'Status Aktif'
	});
/*
 * Buttons
 */
	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.btn_edit = new Ext.Button({
			text		: 'Ubah'
		,	iconCls		: 'edit16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_edit();
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

	this.btn_cancel = new Ext.Button({
			text		: 'Cancel'
		,	iconCls		: 'del16'
		,	scope		: this
		,	handler		: function() {
				this.do_cancel();
			}
	});

	this.btn_save = new Ext.Button({
			text		: 'Simpan'
		,	iconCls		: 'save16'
		,	scope		: this
		,	handler		: function() {
				this.do_save();
			}
	});
	
/*
 * grid
 */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
		});

	this.columns = [
		new Ext.grid.RowNumberer({
			locked		: true
		,	width		: 40
		}),{
			id		: 'nipg'
		,	header		: 'NIPG'
		,	dataIndex	: 'nipg'
		,	sortable	: true
		,	locked		: true
		,	filterable	: true
		},{
			header		: 'Nama'
		,	dataIndex	: 'nama_pegawai'
		,	sortable	: true
		,	locked		: true
		,	filterable	: true
		,	width		: 200
		},{
			header		: 'Klasifikasi'
		,	dataIndex	: 'id_klasifikasi_pegawai'
		,	sortable	: true
		,	renderer	: combo_renderer(this.form_klas)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_klas
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Jabatan'
		,	dataIndex	: 'id_jabatan'
		,	sortable	: true
		,	width		: 200
		,	renderer	: combo_renderer(this.form_jabatan)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_jabatan
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Direktorat'
		,	dataIndex	: 'id_direktorat'
		,	sortable	: true
		,	width		: 250
		,	renderer	: combo_renderer(this.form_direktorat)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_direktorat
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Divisi/Proyek/SBU'
		,	dataIndex	: 'id_divprosbu'
		,	sortable	: true
		,	width		: 250
		,	renderer	: combo_renderer(this.form_divprosbu)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_divprosbu
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Departemen'
		,	dataIndex	: 'id_departemen'
		,	sortable	: true
		,	width		: 250
		,	renderer	: combo_renderer(this.form_departemen)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_departemen
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Dinas'
		,	dataIndex	: 'id_dinas'
		,	sortable	: true
		,	width		: 300
		,	renderer	: combo_renderer(this.form_dinas)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_dinas
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Seksi'
		,	dataIndex	: 'id_seksi'
		,	sortable	: true
		,	width		: 300
		,	renderer	: combo_renderer(this.form_seksi)
		,	filter		: {
				type		: 'list'
			,	store		: this.store_seksi
			,	labelField	: 'name'
			,	phpMode		: false
			}
		},{
			header		: 'Email'
		,	dataIndex	: 'email'
		,	sortable	: true
		,	width		: 120
		,	filterable	: true
		},{
			header		: 'Status'
		,	dataIndex	: 'status_pegawai'
		,	align		: 'center'
		,	sortable	: true
		,	width		: 80
		,	editor		: this.form_status
		,	renderer	: checkbox_renderer(this.form_status, 'Aktif', 'Non-Aktif')
		,	filter		: {
				type	:'boolean'
			}
		}];

	this.cm = new Ext.ux.grid.LockingColumnModel({
		columns : this.columns
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	viewConfig	: {forceFit:true}
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

	this.grid = new Ext.grid.GridPanel({
			title		: 'Pegawai'
		,	autoScroll	: true
		,	autoWidth	: true
		,	store		: this.store
		,	sm			: this.sm
		,	cm			: this.cm
		,	view		: new Ext.ux.grid.LockingGridView({
				syncHeights	:true
			})
		,	plugins		: [this.filters]
		,	tbar		: [
				this.btn_del
			,	'-'
			,	this.btn_edit
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
		,	bbar		: new Ext.PagingToolbar({
				store	: this.store
			,	pageSize: 50
			,	plugins	: [this.filters]
			})
		,	listeners	:{
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
/*
 * panel form add
 */
	this.form = new Ext.form.FormPanel({
		title		: 'Data Pegawai'
	,	padding		: 6
	,	labelAlign	: 'right'
	,	labelWidth	: 120
	,	tbar		: [
			this.btn_cancel
		,	'->'
		,	this.btn_save
		]
	,	items		: [
			this.form_nipg
		,	this.form_name
		,	this.form_klas
		,	this.form_jabatan
		,	this.form_direktorat
		,	this.form_divprosbu
		,	this.form_departemen
		,	this.form_dinas
		,	this.form_seksi
		,	this.form_email
		,	this.form_status
		]
	});

	this.panel = new Ext.Container({
		id			: 'ref_pegawai_panel'
	,	layout		: 'card'
	,	activeItem	: 0
	,	items		: [
			this.grid
		,	this.form
		]
	});
/*
 * functions
 */
	this.form_seksi_filter = function(r,id)
	{
		return (
			r.get('id_direktorat')	== this.id_direktorat
		&&	r.get('id_divprosbu') 	== this.id_divprosbu
		&&	r.get('id_departemen') 	== this.id_departemen
		&&	r.get('id_dinas') 		== this.id_dinas
		);
	}

	this.form_dinas_on_select = function(id_dinas)
	{
		this.id_dinas = id_dinas;

		if (this.id_dinas != 'undefined' && this.id_dinas != '') {
			this.form_seksi.clearFilter(true);
			this.form_seksi.filterBy(this.form_seksi_filter, this);
			this.form_seksi.setValue(this.store_seksi.getAt(0).get('id'));
		} else {
			this.form_seksi.clearFilter(true);
		}
	}

	this.form_dinas_filter = function(r,id)
	{
		return (
			r.get('id_direktorat')	== this.id_direktorat
		&&	r.get('id_divprosbu') 	== this.id_divprosbu
		&&	r.get('id_departemen') 	== this.id_departemen
		);
	}

	this.form_departemen_on_select = function(id_departemen)
	{
		this.id_departemen = id_departemen;

		if (this.id_departemen != 'undefined'
		&&  this.id_departemen != '') {
			this.form_dinas.clearFilter(true);
			this.form_dinas.filterBy(this.form_dinas_filter, this);

			var id = this.store_dinas.getAt(0).get('id');

			this.form_dinas.setValue(id);
			this.form_dinas_on_select(id);
		} else {
			this.form_dinas.clearFilter(true);
		}
	}

	this.form_departemen_filter = function(r,id)
	{
		return (
			r.get('id_direktorat')	== this.id_direktorat
		&&	r.get('id_divprosbu') 	== this.id_divprosbu
		);
	}

	this.form_divprosbu_on_select = function(id_divprosbu)
	{
		this.id_divprosbu = id_divprosbu;

		if (this.id_divprosbu != 'undefined'
		&&  this.id_divprosbu != '') {
			this.form_departemen.clearFilter(true);
			this.form_departemen.filterBy(this.form_departemen_filter, this);

			var id = this.store_departemen.getAt(0).get('id');

			this.form_departemen.setValue(id);
			this.form_departemen_on_select(id);
		} else {
			this.form_departemen.clearFilter(true);
		}
	}

	this.form_divprosbu_filter = function(r,id)
	{
		return (
			r.get('id_direktorat')	== this.id_direktorat
		);
	}

	this.form_direktorat_on_select = function(id_direktorat)
	{
		this.id_direktorat = id_direktorat;

		if (this.id_direktorat != 'undefined'
		&&  this.id_direktorat != '') {
			this.form_divprosbu.clearFilter(true);
			this.form_divprosbu.filterBy(this.form_divprosbu_filter, this);

			var id = this.store_divprosbu.getAt(0).get('id');

			this.form_divprosbu.setValue(id);
			this.form_divprosbu_on_select(id);
		} else {
			this.form_divprosbu.clearFilter(true);
		}
	}

	this.do_reset = function()
	{
		this.form_seksi.clearFilter(true);
		this.form_dinas.clearFilter(true);
		this.form_departemen.clearFilter(true);
		this.form_divprosbu.clearFilter(true);

		this.form_nipg.setDisabled(false);
		this.form_nipg.setValue('');
		this.form_name.setValue('');
		this.form_email.setValue('');
		this.form_status.setValue('1');

		this.form_klas.setValue(this.store_klas.getAt(0).get('id'));
		this.form_jabatan.setValue(this.store_jabatan.getAt(0).get('id'));

		var id = this.store_direktorat.getAt(0).get('id');
		this.form_direktorat.setValue(id);
		this.form_direktorat_on_select(id);
	}

	this.do_add = function()
	{
		this.dml_type = 2;
		this.do_reset();
		this.panel.layout.setActiveItem(this.form);
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

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		this.form_divprosbu.clearFilter(true);
		this.form_departemen.clearFilter(true);
		this.form_dinas.clearFilter(true);
		this.form_seksi.clearFilter(true);
		this.panel.layout.setActiveItem(this.grid);
	}

	this.form_is_valid = function()
	{
		if (!this.form_nipg.isValid()) {
			return false;
		}
		if (!this.form_name.isValid()) {
			return false;
		}
		if (this.form_email.getValue() != '' && !this.form_email.isValid()) {
			return false;
		}

		return true;
	}

	this.do_save = function(record)
	{
		if (this.dml_type == 2 || this.dml_type == 3) {
			if (!this.form_is_valid()) {
				return;
			}
		}

		var aktif = (this.form_status.getValue() == true) ? '1' : '0';

		Ext.Ajax.request({
			params  : {
				nipg			: this.form_nipg.getValue()
			,	nama_pegawai		: this.form_name.getValue()
			,	email			: this.form_email.getValue()
			,	id_klasifikasi_pegawai	: this.form_klas.getValue()
			,	id_jabatan		: this.form_jabatan.getValue()
			,	id_direktorat		: this.form_direktorat.getValue()
			,	id_divprosbu		: this.form_divprosbu.getValue()
			,	id_departemen		: this.form_departemen.getValue()
			,	id_dinas		: this.form_dinas.getValue()
			,	id_seksi		: this.form_seksi.getValue()
			,	status_pegawai		: aktif
			,	dml_type				: this.dml_type
			}
		,	url	: m_ref_pegawai_d +'submit.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					Ext.MessageBox.alert('Pesan', msg.info);

					if (msg.success == false) {
						return;
					}

					this.form_divprosbu.clearFilter(true);
					this.form_departemen.clearFilter(true);
					this.form_dinas.clearFilter(true);
					this.form_seksi.clearFilter(true);
					this.do_load();
					this.panel.layout.setActiveItem(this.grid);
				}
		,	scope	: this
		});
	}

	this.do_fill_form = function(record)
	{
		this.form_nipg.setValue(record.data['nipg']);
		this.form_name.setValue(record.data['nama_pegawai']);
		this.form_email.setValue(record.data['email']);
		this.form_status.setValue(record.data['status_pegawai']);
		this.form_klas.setValue(record.data['id_klasifikasi_pegawai']);
		this.form_jabatan.setValue(record.data['id_jabatan']);

		var id = record.data['id_direktorat'];
		this.form_direktorat.setValue(id);
		this.form_direktorat_on_select(id);

		id = record.data['id_divprosbu'];
		this.form_divprosbu.setValue(id);
		this.form_divprosbu_on_select(id);

		id = record.data['id_departemen'];
		this.form_departemen.setValue(id);
		this.form_departemen_on_select(id);
		
		id = record.data['id_dinas'];
		this.form_dinas.setValue(id);
		this.form_dinas_on_select(id);

		this.form_seksi.setValue(record.data['id_seksi']);
	}

	this.do_edit = function()
	{
		if (this.ha_level < 3) {
			return false;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 3;
		this.form_nipg.setDisabled(true);
		this.do_fill_form(data[0]);
		this.panel.layout.setActiveItem(this.form);

		return true;
	}

	this.do_load = function()
	{
		delete this.store.lastParams;

		this.store.load({
			params	: {
				start	: 0
			,	limit	: 50
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;
		this.store_klas.load();

		if (ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}
	}
}

m_ref_pegawai = new M_RefPegawai();

//@ sourceURL=ref_pegawai.layout.js
