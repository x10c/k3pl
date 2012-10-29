/**
 * Copyright 2012 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_obs_input_stop;
var m_obs_input_stop_d	= _g_root +'/module/obs_input_stop/';
var m_stop_form_obs		= [];
var m_stop_n_discuss	= 0;
var m_stop_n_observed	= 1;

function cb_all_safe_clicked(cb_id, form_id)
{
	var cb	= document.getElementById(cb_id);
	var o	= Ext.getCmp(form_id);
	var i, r;

	o.colModel.is_all_safe = cb.checked;

	for (i = 0; i < o.store.getCount(); i++) {
		r = o.store.getAt(i);
		r.set('safe', m_stop_n_observed + '');
		r.set('unsafe', '0');
	}
}

function M_ObsInputDetail(_i, _j, id, title, data)
{
	this._i			= _i;
	this._j			= _j;
	this.id			= id;
	this.title		= title;
	this.data		= data;
	this.cb_id		= 'cb_all_safe_'+ _i +'_'+ _j;

	this.reader = new Ext.data.JsonReader({
		fields		: [
			{name: 'kel_id'}
		,	{name: 'tipe_id'}
		,	{name: 'detail_id'}
		,	{name: 'detail_name'}
		,	{name: 'safe'}
		,	{name: 'unsafe'}
		]
	,	root		: 'details'
	,	idProperty	: 'detail_id'
	});

	this.store = new Ext.data.Store({
			data 	: this.data
		,	reader	: this.reader
		});

	this.form_safe = new Ext.ux.form.SpinnerField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	value			: 0
		,	minValue		: 0
// request: remove validation.
//		,	maxValue		: m_stop_n_observed
		});

	this.form_unsafe = new Ext.ux.form.SpinnerField ({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	value			: 0
		,	minValue		: 0
// request: remove validation.
//		,	maxValue		: m_stop_n_observed
		});

	this.cm = new Ext.grid.ColumnModel({
		is_all_safe	: false
	,	columns		: [
			{
				dataIndex	: 'unsafe'
			,	header		: 'Tidak Aman'
			,	css			: 'background-color: #FFB5C1;'
			,	width		: 50
			,	editor		: this.form_unsafe
			},{
				id		: 'detail_name'
			,	dataIndex	: 'detail_name'
			,	width		: 220
			,	align		: 'left'
			,	header		: '<form class="input_cb_all_safe">'
					+' Semua Aman '
					+' <input id="'+ this.cb_id +'" '
					+'  type="checkbox" '
					+'  onclick="cb_all_safe_clicked(\''
							+ this.cb_id +'\',\''
							+ this.id +'\')"/>'
					+'</form>'
			},{
				dataIndex	: 'safe'
			,	header		: 'Aman'
			,	css			: 'background-color: #CBFFBB;'
			,	editor		: this.form_safe
			,	width		: 50
			}]
	,	defaults	: {
			align		: 'center'
		,	menuDisabled	: true
		,	hideable	: false
		}
	,	isCellEditable	: function(row, col) {
			return !this.is_all_safe;
		}
	,	scope	: this
	});

	this.panel = new Ext.grid.EditorGridPanel({
			title			: this.title
		,	id				: this.id
		,	style			: 'margin-bottom: 5px;'
		,	autoHeight		: true
		,	autoScroll		: true
		,	stripeRows		: true
		,	clicksToEdit	: 1
		,	store			: this.store
		,	colModel		: this.cm
		,	listeners		: {
				afteredit		: function(e) {
// request: remove validation.
//					if (e.field == 'safe') {
//						e.record.set('unsafe', m_stop_n_observed - e.record.get('safe'));
//					} else if (e.field == 'unsafe') {
//						e.record.set('safe', m_stop_n_observed - e.record.get('unsafe'));
//					}
				}
			}
		});
}

function M_ObsInputStop()
{
	this.ha_level	= 0;
	this.data_obs	= '';
	this.dml_type	= 0;
	this.id_stop	= '';
	this.nipg		= '';

	/* user data */

	this.store_area = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	url	: m_obs_input_stop_d +'data_area.jsp'
		,	autoLoad: false
		});

	this.form_username = new Ext.form.TextField({
			fieldLabel	: 'Nama (NIPG)'
		,	readOnly	: true
		,	width		: 260
		});

	this.form_obs_date = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Observasi'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 260
		});

	this.form_site = new Ext.form.TextField({
			fieldLabel	: 'Site'
		,	emptyText	: 'Wilayah Observasi'
		,	allowBlank	: false
		,	width		: 260
		,	msgTarget	: 'side'
		});

	this.form_area = new Ext.form.ComboBox({
			fieldLabel	: 'Area'
		,	store		: this.store_area
		,	valueField	: 'id'
		,	displayField	: 'name'
		,	mode		: 'local'
		,	allowBlank	: false
		,	forceSelection	: true
		,	typeAhead	: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width		: 400
		});

	this.form_shift = new Ext.form.TextField({
			fieldLabel	: 'Shift'
		,	emptyText	: 'Shift'
		,	allowBlank	: false
		,	width		: 260
		,	msgTarget	: 'side'
		});

	this.form_obs_time = new Ext.form.NumberField({
			fieldLabel	: 'Lama Observasi'
		,	emptyText	: 'Lama observasi dalam hitungan menit'
		,	allowBlank	: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	minValue	: 1
		,	value		: 1
		,	width		: 100
		,	msgTarget	: 'side'
		});

	this.form_n_discuss = new Ext.form.NumberField({
			fieldLabel	: 'Jumlah Orang Yang Diajak Diskusi'
		,	allowBlank	: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	minValue	: m_stop_n_discuss
		,	value		: m_stop_n_discuss
		,	width		: 100
		,	msgTarget	: 'side'
		,	validator	: function(v)
			{
				if (v > m_stop_n_observed) {
					return false;
				}
				return true;
			}
		,	listeners	: {
				valid	: function (form) {
					m_stop_n_discuss = form.getRawValue ();
				}
			,	scope	: this
			}
		});

	this.form_n_observed = new Ext.form.NumberField({
			fieldLabel	: 'Jumlah Orang Yang Diobservasi'
		,	invalidText	: 'Jumlah orang yang diobservasi tidak boleh lebih dari jumlah orang yang diajak diskusi.'
		,	allowBlank	: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	minValue	: m_stop_n_observed
		,	value		: m_stop_n_observed
		,	width		: 100
		,	msgTarget	: 'side'
		,	listeners	: {
				change	: function (form, newvalue, oldvalue)
				{
					m_stop_n_observed = newvalue;
					this.form_n_discuss.setMaxValue (newvalue);

					/* don't change safe value if user edit the data */
// request: remove validation.
//					this.set_detail_max_value(m_stop_n_observed);
				}
			,	scope	: this
			}
		});

	this.form_safe = new Ext.form.TextArea({
			fieldLabel	: 'Tindakan Aman Yang Diamati'
		,	width		: 400
		});

	this.form_unsafe = new Ext.form.TextArea({
			fieldLabel	: 'Tindakan Tidak Aman Yang Diamati'
		,	width		: 400
		});

	/* observation data */
	this.panel_user = new Ext.form.FormPanel({
		labelAlign	: 'right'
	,	labelWidth	: 230
	,	autoWidth	: true
	,	autoHeight	: true
	,	style		: 'margin: 8px;'
	,	bodyCssClass	: 'stop-panel-form'
	,	items		: [
			this.form_username
		,	this.form_obs_date
		,	this.form_site
		,	this.form_area
		,	this.form_shift
		,{
				xtype	: 'compositefield'
			,	items	: [
					this.form_obs_time
				,{		xtype:'displayfield'
					,	value:'menit'
				}]
		}
		,	this.form_n_observed
		,	this.form_n_discuss
		,	this.form_safe
		,	this.form_unsafe
		]
		});

	/* main panel */
	this.btn_cancel = new Ext.Button({
			text	: 'Batal'
		,	iconCls	: 'del16'
		,	scope	: this
		,	handler	: function() {
				this.do_cancel();
			}
		});

	this.btn_save	= new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
		});

	this.panel_obs = new Ext.Panel({
			layout		:'column'
		});

	this.panel = new Ext.Panel({
		title		: 'Input Data Observasi'
	,	bodyBorder	: false
	,	autoScroll	: true
	,	buttonAlign	: 'center'
	,	tbar		: [
			this.btn_cancel
		,	'->'
		,	this.btn_save
		]
	,	items		: [
			this.panel_user
		,	this.panel_obs
		]
	});

// request: remove validation.
/*
	this.set_detail_max_value = function(v)
	{
		var i, j, k, r, tipe, o;

		for (i = 0; i < m_stop_form_obs.length; i++) {
			tipe = m_stop_form_obs[i].tipe;
			for (j = 0; j < tipe.length; j++) {
				o = m_stop_form_obs[i].tipe[j];

				tipe[j].form_safe.setMaxValue(v);
				tipe[j].form_unsafe.setMaxValue (v);

				// set all safe value to n-observed
				for (k = 0; k < o.store.getCount(); k++) {
					r = o.store.getAt(k);
					r.set('safe', 0);
					r.set('unsafe', 0);
				}
			}
		}
	}
*/
	this.create_obs_form = function()
	{
		var i,j;
		var id;
		var kel;
		var tipe;
		var detail;

		kel = this.data_obs;
		for (i = 0; i < kel.length; i++) {
			m_stop_form_obs[i] = {};

			/* create group of observasi */
			m_stop_form_obs[i].tipe		= [];
			m_stop_form_obs[i].id		= kel[i].id;
			m_stop_form_obs[i].content	= new Ext.Panel({
				style		: {
					marginTop	: '16px'
				,	marginRight	: 'auto'
				,	marginLeft	: 'auto'
				,	padding		: '8px'
				}
			,	bodyCssClass	: 'stop-panel-form'
			,	autoScroll	: true
			,	autoHeight	: true
			,	headerCfg	: {
					cls			: 'stop-header-form'
				,	html		: ''+ kel[i].text
				}
			});

			/* create input detail observasi */
			tipe = kel[i].tipe;

			for (j = 0; j < tipe.length; j++) {
				id = 'obs_input_detail_'+ kel[i].id +'_'+ tipe[j].id;

				m_stop_form_obs[i].tipe[j] = new M_ObsInputDetail(i, j, id, tipe[j].text, tipe[j]);

				m_stop_form_obs[i].content.add(m_stop_form_obs[i].tipe[j].panel);
			}

			m_stop_form_obs[i].content.doLayout();
			this.panel_obs.add(m_stop_form_obs[i].content);
		}
		this.panel_obs.doLayout();
		this.panel.doLayout();
	}

	this.get_obs_form = function()
	{
		Ext.Ajax.request({
			url		: m_obs_input_stop_d +'data_obs_form.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.Msg.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
					return;
				}

				this.data_obs = msg;
				this.create_obs_form();
			}
		,	scope	: this
		});
	}

	this.do_load_area = function()
	{
		this.store_area.load({
			callback: function() {
				var record = this.store_area.getAt(0);

				if (record) {
					this.form_area.setValue(record.get('id'));
				}
			}
		,	scope	: this
		});
	}

	this.is_valid = function()
	{
		if (!this.form_obs_date.isValid()) {
			return false;
		}
		if (!this.form_site.isValid()) {
			return false;
		}
		if (!this.form_area.isValid()) {
			return false;
		}
		if (!this.form_shift.isValid()) {
			return false;
		}
		if (!this.form_obs_time.isValid()) {
			return false;
		}
		if (!this.form_n_discuss.isValid()) {
			return false;
		}
		if (!this.form_n_observed.isValid() && m_stop_n_observed != 0) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_obs_input_stop.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.Msg.alert('Kesalahan', 'Form belum terisi semuanya atau ada kesalahan pada isian.');
			return;
		}

		main_load.show();

		var i, j, k, l, t, r;
		var out = "[";

		l = 0;
		for (i = 0; i < m_stop_form_obs.length; i++) {
			t = m_stop_form_obs[i].tipe;
			for (j = 0; j < t.length; j++) {
				r = t[j].store.getRange();
				for (k = 0; k < r.length; k++) {
					if (l > 0) {
						out += ",";
					} else {
						l++;
					}
					out	+="{ kel_id   : '"+ r[k].get('kel_id') +"' "
						+ ", tipe_id  : '"+ r[k].get('tipe_id') +"' "
						+ ", detail_id: '"+ r[k].get('detail_id') +"' "
						+ ", safe     : '"+ r[k].get('safe') +"' "
						+ ", unsafe   : '"+ r[k].get('unsafe') +"' "
						+" }"
				}
			}
		}
		out += "]";

		var	d, m ,y;
		var periode = 0;
		var obs_date = new Date (this.form_obs_date.getValue ());

		d = obs_date.format ('d');
		m = obs_date.format ('m');
		y = obs_date.format ('Y');

		if (d <= 15){
			periode = 1;
		} else {
			periode = 2;
		}

		Ext.Ajax.request({
			url	: m_obs_input_stop_d +'submit.jsp'
		,	params	: {
				dml_type: this.dml_type
			,	id_stop	: this.id_stop
			,	nipg	: this.nipg
			,	id_area_seksi	: this.form_area.getValue()
			,	tanggal	: this.form_obs_date.getValue()
			,	site	: this.form_site.getValue()
			,	shift	: this.form_shift.getValue()
			,	lama	: this.form_obs_time.getValue()
			,	n_obs	: m_stop_n_observed
			,	n_dis	: m_stop_n_discuss
			,	safe	: this.form_safe.getValue()
			,	unsafe	: this.form_unsafe.getValue()
			,	st_aktif: '1'
			,	periode	: periode
			,	bulan	: m
			,	tahun	: y
			,	detail	: out
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.Msg.alert('Gagal', response.responseText);
				main_load.hide();
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Kesalahan', msg.info);
					return;
				}

				Ext.Msg.alert('Informasi', msg.info);

				main_load.hide();
				m_obs_input_stop.panel.layout.setActiveItem(0);
				m_obs_input_stop.do_load();
			}
		,	scope	: this
		});
	}

	this.do_reset = function()
	{
		var record = this.store_area.getAt(0);

		if (record) {
			this.form_area.setValue(record.get('id'));
		}

		m_stop_n_observed	= 1;
		m_stop_n_discuss	= 0;
		this.form_obs_date.setValue('');
		this.form_site.setValue('');
		this.form_shift.setValue('');
		this.form_obs_time.setValue(1);
		this.form_n_discuss.setValue(m_stop_n_discuss);
		this.form_n_observed.setValue(m_stop_n_observed);
		this.form_safe.setValue('');
		this.form_unsafe.setValue('');

// request: remove validation.
//		this.set_detail_max_value (0);
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
		this.nipg		= _g_usernipg;
	}

	this.edit_fill_form = function(data)
	{
		var i, x;
		var d = data.details;
		var grid;
		var grid_id;

		m_stop_n_observed	= parseFloat(data.jml_org_observasi);
		m_stop_n_discuss	= parseFloat(data.jml_org_diskusi);

		this.nipg = data.nipg;
		this.form_username.setValue(data.nama_pegawai +' ('+ data.nipg +')');
		this.form_area.setValue(data.id_area_seksi);
		this.form_obs_date.setValue(data.tanggal);
		this.form_site.setValue(data.site);
		this.form_shift.setValue(data.shift);
		this.form_obs_time.setValue(data.lama_observasi);
		this.form_n_discuss.setValue(data.jml_org_diskusi);
		this.form_n_observed.setValue(data.jml_org_observasi);
		this.form_safe.setValue(data.safe);
		this.form_unsafe.setValue(data.unsafe);

// request: remove validation.
//		this.set_detail_max_value (m_stop_n_observed);

		for (i = 0; i < d.length; i++) {
			grid_id = 'obs_input_detail_'+ d[i].kel_id +'_'+ d[i].tipe_id;
			grid = Ext.getCmp(grid_id);
			if (grid == undefined) {
				continue;
			}

			x = grid.store.find('detail_id', d[i].detail_id);
			if (x == -1) {
				continue;
			}

			r = grid.store.getAt(x);

			r.set('safe', d[i].safe +'');
			r.set('unsafe', d[i].unsafe +'');
		}
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;
		this.id_stop	= id;

		Ext.Ajax.request({
			url	: m_obs_input_stop_d +'data_obs.jsp'
		,	params	: {
				id_stop: id
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.Msg.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Pesan', msg.info);
					return;
				}

				this.edit_fill_form(msg);
			}
		,	scope	: this
		});
	}

	this.set_min_max_date = function()
	{
		var d_min;
		var d_max;
		var d		= new Date();
		var day		= d.format ('d');
		var month	= d.format ('m');
		var year	= d.format ('Y');

		if (day <= 15) {
			d_min = new Date(year, month, 1);
			d_max = new Date(year, month, 15);
		} else {
			d_min = new Date(year, month, 16);
			d_max = new Date(year, month + 1, 0);
		}

		this.form_obs_date.setMinValue(d_min);
		this.form_obs_date.setMaxValue(d_max);
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level <= 1) {
			Ext.Msg.alert('Hak Akses'
, 'Maaf, Anda tidak memiliki hak akses untuk input data observasi!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.form_username.setValue(_g_username +' ('+ _g_usernipg +')');

		if (this.ha_level < 4) {
			this.set_min_max_date();
		}
		this.do_load_area();
	}
}

function M_ObsDataStop()
{
	this.periode_status = 0;
	this.ha_level		= 0;

	this.store = new Ext.data.ArrayStore({
			fields	: [
			  'id'
			, 'nipg'
			, 'nama_pegawai'
			, 'date'
			, 'area'
			, 'site'
			, 'shift'
			, 'obs_time'
			, 'n_obs'
			, 'n_dis'
			, 'status_aktif'
			]
		,	url	: m_obs_input_stop_d +'data_list_stop.jsp'
		,	autoLoad: false
		});
/*
 * forms
 */
	this.form_status = new Ext.form.Checkbox();

	this.cm = new Ext.ux.grid.LockingColumnModel({
		columns	: [
			new Ext.grid.RowNumberer({
				locked	: true
		}),{
			header		: 'NIPG'
		,	dataIndex	: 'nipg'
		,	locked		: true
		},{
			header		: 'Nama Pegawai'
		,	dataIndex	: 'nama_pegawai'
		,	locked		: true
		,	width		: 200
		},{
			header		: 'Tanggal'
		,	dataIndex	: 'date'
		,	width		: 160
		},{
			header		: 'Area'
		,	dataIndex	: 'area'
		,	width		: 240
		},{
			header		: 'Site'
		,	dataIndex	: 'site'
		,	width		: 240
		},{
			header		: 'Shift'
		,	dataIndex	: 'shift'
		,	width		: 120
		},{
			header		: 'Lama Observasi'
		,	dataIndex	: 'obs_time'
		,	width		: 120
		,	align		: 'center'
		},{
			header		: 'Jumlah Orang Diskusi'
		,	dataIndex	: 'n_dis'
		,	width		: 120
		,	align		: 'center'
		},{
			header		: 'Jumlah Orang Diobservasi'
		,	dataIndex	: 'n_obs'
		,	width		: 140
		,	align		: 'center'
		},{
			header		: 'Status'
		,	dataIndex	: 'status_aktif'
		,	editor		: this.form_status
		,	renderer	: checkbox_renderer(this.form_status, 'Aktif', '-')
		}]
	,	defaults : {
			sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_del();
			}
		});

	this.btn_edit = new Ext.Button({
			text		: 'Ubah'
		,	iconCls		: 'edit16'
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

	this.btn_add = new Ext.Button({
			text		: 'Tambah'
		,	iconCls		: 'add16'
		,	scope		: this
		,	handler		: function() {
				this.do_add();
			}
		});

	this.editor = new MyRowEditor(this);

	this.panel_list = new Ext.grid.GridPanel({
			title		: 'Data Observasi'
		,	store		: this.store
		,	cm			: this.cm
		,	sm			: this.sm
		,	plugins		: this.editor
		,	view		: new Ext.ux.grid.LockingGridView({
				syncHeights	: true
			})
		,	autoScroll	: true
		,	tbar		: [
				this.btn_del, '-'
			,	this.btn_edit, '-'
			,	this.btn_ref, '-'
			,	this.btn_add
			]
		,	listeners	: {
				scope		: this
			,	rowdblclick	: function(grid, row_idx, e) {
					if (this.ha_level < 4) {
						return false;
					}
					return true;
				}
			}
		});

	this.panel_add = new M_ObsInputStop();

	this.panel_add.get_obs_form();

	this.panel = new Ext.Panel({
			id			: 'obs_data_stop_panel'
		,	bodyBorder	: false
		,	layout		: 'card'
		,	activeItem	: 0
		,	border		: false
		,	autoWidth	: true
		,	autoScroll	: true
		,	items		: [
				this.panel_list
			,	this.panel_add.panel
			]
		});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Ajax.request({
			url	: m_obs_input_stop_d +'submit.jsp'
		,	params	: {
				dml_type	: 4
			,	id_stop		: data.get('id')
			,	nipg		: ''
			,	id_area_seksi	: ''
			,	tanggal		: '1900-01-01'
			,	site		: ''
			,	shift		: ''
			,	lama		: ''
			,	n_obs		: ''
			,	n_dis		: ''
			,	safe		: ''
			,	unsafe		: ''
			,	st_aktif	: ''
			,	periode		: 0
			,	bulan		: 0
			,	tahun		: 0
			,	detail		: '[]'
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.Msg.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Kesalahan', msg.info);
					return;
				}

				Ext.Msg.alert('Informasi', msg.info);

				this.do_load();
			}
		,	scope	: this
		});
	}

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		this.panel_add.do_edit(data.get('id'));
		this.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		this.panel_add.do_add();
		this.panel.layout.setActiveItem(1);
	}

	this.do_cancel = function()
	{
	}

	this.do_save = function(record)
	{
		var aktif = (this.form_status.getValue() == true) ? '1' : '0';

		Ext.Ajax.request({
			url	: m_obs_input_stop_d +'submit_stat.jsp'
		,	params	: {
				dml_type	: 3
			,	id_stop		: record.data['id']
			,	status_aktif	: aktif
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.Msg.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.Msg.alert('Kesalahan', msg.info);
					return;
				}

				Ext.Msg.alert('Informasi', msg.info);

				this.do_load();
			}
		,	scope	: this
		});
	}

	this.do_load = function()
	{
		var load_type = 'user';

		if (this.ha_level == 4) {
			load_type = 'all';
		}

		this.store.load({
			params	: {
				load_type : load_type
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level < 1) {
			Ext.Msg.alert('Hak Akses'
			, 'Maaf, Anda tidak memiliki hak akses untuk Data Observasi!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (ha_level == 4) {
			this.btn_del.setDisabled(false);
			this.cm.setHidden(10, false);
		} else {
			this.btn_del.setDisabled(true);
			this.cm.setHidden(10, true);
		}

		this.do_load();
		this.panel_add.do_refresh(this.ha_level);
	}
}

m_obs_input_stop = new M_ObsDataStop();

//@ sourceURL=obs_input_stop.layout.js
