/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_trx_rca;
var m_trx_rca_list;
var m_trx_rca_add;
var m_trx_rca_edit;
var m_trx_rca_id_rca	= '';
var m_trx_rca_ha_level	= 0;
var m_trx_rca_id_seksi	= '';
var m_trx_rca_pic		= '';
var m_trx_rca_user		= '';
var m_trx_rca_dir 		= _g_root +'/module/trx_rca/';

var m_trx_rca_store_auditor = new Ext.data.ArrayStore({
		url			: m_trx_rca_dir +'data_ref_auditor.jsp'
	,	fields		: ['nipg','nama_pegawai','id_seksi']
	,	autoLoad	: false
});

var m_trx_rca_store_penanggung_jawab = new Ext.data.ArrayStore({
		url			: m_trx_rca_dir +'data_ref_penanggung_jawab.jsp'
	,	fields		: ['id_seksi','id_dinas','id_departemen','id_divprosbu','id_direktorat','nama_seksi','kepala_seksi']
	,	autoLoad	: false
});

var m_trx_rca_store_direktorat = new Ext.data.ArrayStore({
		fields		: ['id_direktorat', 'nama_direktorat']
	,	url			: m_trx_rca_dir + 'data_ref_direktorat.jsp'
	,	autoLoad	: false
});

var m_trx_rca_store_divprosbu = new Ext.data.ArrayStore({
		fields		: ['id_divprosbu', 'nama_divprosbu']
	,	url			: m_trx_rca_dir + 'data_ref_divprosbu.jsp'
	,	autoLoad	: false
});

var m_trx_rca_store_departemen = new Ext.data.ArrayStore({
		fields		: ['id_departemen', 'nama_departemen']
	,	url			: m_trx_rca_dir + 'data_ref_departemen.jsp'
	,	autoLoad	: false
});

var m_trx_rca_store_dinas = new Ext.data.ArrayStore({
		fields		: ['id_dinas', 'nama_dinas']
	,	url			: m_trx_rca_dir + 'data_ref_dinas.jsp'
	,	autoLoad	: false
});

var m_trx_rca_store_seksi = new Ext.data.ArrayStore({
		fields		: ['id_seksi', 'id_dinas', 'id_departemen', 'id_divprosbu', 'id_direktorat', 'nama_seksi']
	,	url			: m_trx_rca_dir + 'data_ref_seksi.jsp'
	,	autoLoad	: false
});

var m_trx_rca_store_severity = new Ext.data.ArrayStore({
		fields		: ['id_severity', 'nama_severity']
	,	url			: m_trx_rca_dir +'data_ref_severity.jsp'
	,	autoLoad	: false
});

function M_TrxRCADetail()
{
	this.s		= 0;
	this.v_x_s 	= 0;
	this.sev	= 0;
	this.nov	= 0;
	this.status = '';
	
	this.store_status = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	data	: [
				[1, 'Open']
			,	[2, 'Process']
		]
	});

	this.record = new Ext.data.Record.create([
			{
				name	: 'id_rca'
			},{
				name	: 'description'
			},{
				name	: 'good_citizens'
			},{
				name	: 'violators'
			},{
				name	: 'number_of_violations'
			},{
				name	: 'id_severity'
			},{
				name	: 'violation_x_severity'
			},{
				name	: 'li_45'
			},{
				name	: 'li_apd'
			},{
				name	: 'li_housekeeping'
			},{
				name	: 'li_process_safety'
			},{
				name	: 'li_fire_safety'
			},{
				name	: 'actions'
			},{
				name	: 'status'
			},{
				name		: 'completion_date_target'
			,	type		: 'date'
			,	dateFormat	: 'Y-m-d'
			},{
				name		: 'completion_date_actual'
			,	type		: 'date'
			,	dateFormat	: 'Y-m-d'
			},{
				name	: 'note'
			}
	]);

	this.store = new Ext.data.ArrayStore({
		fields	:this.record
	,	data	:[]
	});

	this.form_description = new Ext.form.TextField({
			allowBlank	: false
	});

	this.form_good_citizens = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_violators = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_number_of_violations = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.s		= this.form_severity.getValue();
					this.v_x_s	= newvalue * this.s;
					this.form_violation_x_severity.setValue(this.v_x_s);
					
					if (this.s == 4 || this.s == 5){
						this.form_li_45.setValue(newvalue);
					} else {
						this.form_li_45.setValue(0);
					}
				}
			,	scope	: this
			}
	});
	
	this.form_severity = new Ext.form.ComboBox({
			store			: m_trx_rca_store_severity
		,	allowBlank		: false
		,	valueField		: 'id_severity'
		,	displayField	: 'id_severity'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 50
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.sev	= record.get('id_severity');
					this.nov	= this.form_number_of_violations.getValue();
					this.v_x_s 	= this.sev * this.nov;
					this.form_violation_x_severity.setValue(this.v_x_s);
					
					if (this.sev == 4 || this.sev == 5){
						this.form_li_45.setValue(this.nov);
					} else {
						this.form_li_45.setValue(0);
					}
				}
		}
	});

	this.form_violation_x_severity = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_45 = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_apd = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_housekeeping = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_process_safety = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_fire_safety = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_actions = new Ext.form.TextField();

	this.form_status = new Ext.form.ComboBox({
			allowBlank		: false
		,	store			: this.store_status
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_completion_date_target = new Ext.form.DateField({
			emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: true
	});

	this.form_completion_date_actual = new Ext.form.DateField({
			emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	disabled	: true
	});
	
	this.form_note = new Ext.form.TextField({
			width		: 400
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
				new Ext.grid.RowNumberer()
			,{
				header		: 'Desription'
			,	id			: 'description'
			,	dataIndex	: 'description'
			,	width		: 300
			,	editor		: this.form_description
			,	summaryRenderer	: function() {
					return '<center><b>Total :</b></center>';
				}
			},{
				header		: 'Good Citizens'
			,	id			: 'good_citizens'
			,	dataIndex	: 'good_citizens'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_good_citizens
			,	summaryType	: 'sum'
			},{
				header		: 'Violators'
			,	id			: 'violators'
			,	dataIndex	: 'violators'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_violators
			,	summaryType	: 'sum'
			},{
				header		: 'Number of Violations'
			,	id			: 'number_of_violations'
			,	dataIndex	: 'number_of_violations'
			,	width		: 70
			,	align		: 'center'
			,	editor		: this.form_number_of_violations
			,	summaryType	: 'sum'
			},{
				header		: 'Severity'
			,	id			: 'id_severity'
			,	dataIndex	: 'id_severity'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_severity
			,	renderer	: combo_renderer(this.form_severity)
			,	summaryType	: 'sum'
			},{
				header		: 'Violation X Severity'
			,	id			: 'violation_x_severity'
			,	dataIndex	: 'violation_x_severity'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_violation_x_severity
			,	summaryType	: 'sum'
			},{
				header		: '4 & 5'
			,	id			: 'li_45'
			,	dataIndex	: 'li_45'
			,	width		: 40
			,	align		: 'center'
			,	editor		: this.form_li_45
			,	summaryType	: 'sum'
			},{
				header		: 'APD'
			,	id			: 'li_apd'
			,	dataIndex	: 'li_apd'
			,	width		: 40
			,	align		: 'center'
			,	editor		: this.form_li_apd
			,	summaryType	: 'sum'
			},{
				header		: 'House keeping'
			,	id			: 'li_housekeeping'
			,	dataIndex	: 'li_housekeeping'
			,	width		: 60
			,	editor		: this.form_li_housekeeping
			,	summaryType	: 'sum'
			},{
				header		: 'Process Safety'
			,	id			: 'li_process_safety'
			,	dataIndex	: 'li_process_safety'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_li_process_safety
			,	summaryType	: 'sum'
			},{
				header		: 'Fire Safety'
			,	id			: 'li_fire_safety'
			,	dataIndex	: 'li_fire_safety'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_li_fire_safety
			,	summaryType	: 'sum'
			},{
				header		: 'Actions'
			,	id			: 'actions'
			,	dataIndex	: 'actions'
			,	width		: 250
			,	editor		: this.form_actions
			},{
				header		: 'Status'
			,	id			: 'status'
			,	dataIndex	: 'status'
			,	width		: 80
			,	editor		: this.form_status
			,	renderer	: combo_renderer(this.form_status)
			},{
				header		: 'Target'
			,	id			: 'completion_date_target'
			,	dataIndex	: 'completion_date_target'
			,	width		: 100
			,	align		: 'center'
			,	editor		: this.form_completion_date_target
			,	xtype		: 'datecolumn'
			,	format		: 'Y-m-d'
			},{
				header		: 'Actual'
			,	id			: 'completion_date_actual'
			,	dataIndex	: 'completion_date_actual'
			,	width		: 100
			,	align		: 'center'
			,	editor		: this.form_completion_date_actual
			,	xtype		: 'datecolumn'
			,	format		: 'Y-m-d'
			},{
				header		: 'Note'
			,	id			: 'note'
			,	dataIndex	: 'note'
			,	width		: 150
			,	editor		: this.form_note
			}]
	,	defaults : {
			sortable	: false
		,	hideable	: false
		}
	});
	
	this.col_hdr = [{
			colspan	: 2
		},{
			header	: 'People'
		,	colspan	: 2
		},{
			header	: 'Violations'
		,	colspan	: 3
		},{
			header	: 'Leading Indicator'
		,	colspan	: 5
		},{	colspan	: 1
		},{	colspan	: 1
		},{
			header	: 'Completion Date'
		,	colspan	: 2
		},{
			colspan	: 1
	}];

	this.hdr = new Ext.ux.grid.ColumnHeaderGroup({
		rows	: [this.col_hdr]
	});

	this.summary = new Ext.ux.grid.GridSummary();
	
	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
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

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_rca					: ''
			,	description				: ''
			,	good_citizens			: 0
			,	violators				: 0
			,	number_of_violations	: 0
			,	id_severity				: ''
			,	violation_x_severity	: 0
			,	li_45					: 0
			,	li_apd					: 0
			,	li_housekeeping			: 0
			,	li_process_safety		: 0
			,	li_fire_safety			: 0
			,	actions					: ''
			,	status					: '1'
			,	completion_date_target	: ''
			,	completion_date_actual	: ''
			,	note					: ''
		});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);
		
		this.status = 'insert';
	}

	this.do_edit = function(row)
	{
		this.status = 'update';
		return true;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		Ext.Msg.confirm ("Konfirmasi", "Apakah anda yakin akan menghapus data ?", function (btn_id, text, opt) {
			if (btn_id == 'yes') {
				this.store.remove(data[0]);
				this.do_calculate();
			}
		}
		,this);
	}

	this.do_cancel = function()
	{
		if (this.status == 'insert'){
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_calculate = function()
	{
		var good_citizens 		= 0;
		var violators = 0;
		var number_of_violations = 0;
		var severity = 0;
		var violation_x_severity = 0;
		var li_45 = 0;
		var li_apd = 0;
		var li_housekeeping = 0;
		var li_process_safety = 0;
		var li_fire_safety = 0;
		
		var good_citizens_violators = 0;
		var observed_people = 0;
		var average_severity_of_violations = 0;
		var percent_severity_45 = 0;
		var number_people_on_site = 0;
		var percent_workers_observed = 0;

		var jml = this.store.getCount();
		
		if (jml != 0){
			for (i=0; i < jml; i++){
				good_citizens += this.store.getAt(i).get('good_citizens')
				violators += this.store.getAt(i).get('violators')
				number_of_violations += this.store.getAt(i).get('number_of_violations')
				severity += this.store.getAt(i).get('id_severity')
				violation_x_severity += this.store.getAt(i).get('violation_x_severity')
				li_45 += this.store.getAt(i).get('li_45')
				li_apd += this.store.getAt(i).get('li_apd')
				li_housekeeping += this.store.getAt(i).get('li_housekeeping')
				li_process_safety += this.store.getAt(i).get('li_process_safety')
				li_fire_safety += this.store.getAt(i).get('li_fire_safety')
			}
		}
		
		if (violators != 0){
			good_citizens_violators = good_citizens + violators
			number_people_on_site = good_citizens + violators
			percent_workers_observed = good_citizens_violators / number_people_on_site * 100
			m_trx_rca_add.form_approximate_workers_observed.setValue(good_citizens_violators);
			m_trx_rca_add.form_people_on_site.setValue(good_citizens_violators);
			m_trx_rca_add.form_workers_observed.setValue(percent_workers_observed);
			
		} else {
			m_trx_rca_add.form_approximate_workers_observed.setValue(0);
			m_trx_rca_add.form_people_on_site.setValue(0);
			m_trx_rca_add.form_workers_observed.setValue(0);
		}
		
		if (good_citizens != 0 && violators != 0){
			observed_people = good_citizens / good_citizens_violators * 100
			m_trx_rca_add.form_observed_people.setValue(observed_people)
		} else {
			m_trx_rca_add.form_observed_people.setValue(0);
		}
		
		if (number_of_violations != 0){
			m_trx_rca_add.form_no_of_violations.setValue(number_of_violations);
		} else {
			m_trx_rca_add.form_no_of_violations.setValue(0);
		}

		if (violation_x_severity != 0){
			average_severity_of_violations = violation_x_severity / number_of_violations
			m_trx_rca_add.form_avg_sev_of_violations.setValue(average_severity_of_violations);
		} else {
			m_trx_rca_add.form_avg_sev_of_violations.setValue(0);
		}

		if (li_45 != 0){
			percent_severity_45 = li_45 / number_of_violations * 100
			m_trx_rca_add.form_severity_45.setValue(li_45);
			m_trx_rca_add.form_percent_severity_45.setValue(percent_severity_45);
		} else {
			m_trx_rca_add.form_severity_45.setValue(0);
			m_trx_rca_add.form_percent_severity_45.setValue(0);
		}
	}
	
	this.do_save = function()
	{
		this.store.commitChanges();
		
		this.do_calculate();
	}
	
	this.btn_add = new Ext.Button({
		text	:'Tambah'
	,	iconCls	:'add16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_add();
		}
	});

	this.btn_del = new Ext.Button({
		text	:'Hapus'
	,	iconCls	:'del16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_del();
		}
	});

	this.grid = new Ext.grid.GridPanel({
		title				: 'Data RCA Detail'
	,	store				: this.store
	,	cm					: this.cm
	,	sm					: this.sm
	,	autoScroll			: true
	,	height				: 250
	,	autoWidth			: true
	,	plugins				: [this.summary, this.editor, this.hdr]
	//,	headerCfg			: {	cls: 'rca-header-form' }
	,	viewConfig			: {
			forceFit		: true
		}
	,	tbar				:[
			this.btn_add,'-'
		,	this.btn_del
		]
	,   listeners   : {
			scope		: this
		,	rowclick	:
				function (g, r, e) {
					return this.do_edit(r);
				}
		}
	});
	
	this.do_reset = function()
	{
		this.store.removeAll();
	}
}

function M_TrxEditRCADetail()
{
	this.dml_type	= 2;
	this.s			= 0;
	this.v_x_s 		= 0;
	this.sev		= 0;
	this.nov		= 0;
	this.status		= 0;
	
	this.store_status = new Ext.data.ArrayStore({
			fields	: ['id','name']
		,	data	: [
				[1, 'Open']
			,	[2, 'Process']
			,	[3, 'Closed']
		]
	});

	this.record = new Ext.data.Record.create([
			{
				name	: 'id_rca'
			},{
				name	: 'id_rca_detail'
			},{
				name	: 'description'
			},{
				name	: 'good_citizens'
			},{
				name	: 'violators'
			},{
				name	: 'number_of_violations'
			},{
				name	: 'id_severity'
			},{
				name	: 'violation_x_severity'
			},{
				name	: 'li_45'
			},{
				name	: 'li_apd'
			},{
				name	: 'li_housekeeping'
			},{
				name	: 'li_process_safety'
			},{
				name	: 'li_fire_safety'
			},{
				name	: 'actions'
			},{
				name	: 'status'
			},{
				name		: 'completion_date_target'
			,	type		: 'date'
			,	dateFormat	: 'Y-m-d'
			},{
				name		: 'completion_date_actual'
			,	type		: 'date'
			,	dateFormat	: 'Y-m-d'
			},{
				name	: 'note'
			}
	]);

	this.store = new Ext.data.ArrayStore({
			url			: m_trx_rca_dir +'data_rca_detail.jsp'
		,	fields		: this.record
		,	autoLoad	: false
	});

	this.form_description = new Ext.form.TextField({
			allowBlank	: false
	});

	this.form_good_citizens = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_violators = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_number_of_violations = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.s		= this.form_severity.getValue();
					this.v_x_s	= newvalue * this.s;
					this.form_violation_x_severity.setValue(this.v_x_s);
					
					if (this.s == 4 || this.s == 5){
						this.form_li_45.setValue(newvalue);
					} else {
						this.form_li_45.setValue(0);
					}
				}
			,	scope	: this
			}
	});
	
	this.form_severity = new Ext.form.ComboBox({
			store			: m_trx_rca_store_severity
		,	allowBlank		: false
		,	valueField		: 'id_severity'
		,	displayField	: 'id_severity'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 50
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.sev	= record.get('id_severity');
					this.nov	= this.form_number_of_violations.getValue();
					this.v_x_s 	= this.sev * this.nov;
					this.form_violation_x_severity.setValue(this.v_x_s);
					
					if (this.sev == 4 || this.sev == 5){
						this.form_li_45.setValue(this.nov);
					} else {
						this.form_li_45.setValue(0);
					}
				}
		}
	});

	this.form_violation_x_severity = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_45 = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_apd = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_housekeeping = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_process_safety = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_li_fire_safety = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_actions = new Ext.form.TextField();

	this.form_status = new Ext.form.ComboBox({
			allowBlank		: false
		,	store			: this.store_status
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
	});

	this.form_completion_date_target = new Ext.form.DateField({
			emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
	});

	this.form_completion_date_actual = new Ext.form.DateField({
			emptyText	: 'Y-M-D'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	disabled	: true
	});
	
	this.form_note = new Ext.form.TextField({
			width		: 400
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
				new Ext.grid.RowNumberer()
			,{
				header		: 'Desription'
			,	id			: 'description'
			,	dataIndex	: 'description'
			,	width		: 300
			,	editor		: this.form_description
			,	summaryRenderer	: function() {
					return '<center><b>Total :</b></center>';
				}
			},{
				header		: 'Good Citizens'
			,	id			: 'good_citizens'
			,	dataIndex	: 'good_citizens'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_good_citizens
			,	summaryType	: 'sum'
			},{
				header		: 'Violators'
			,	id			: 'violators'
			,	dataIndex	: 'violators'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_violators
			,	summaryType	: 'sum'
			},{
				header		: 'Number of Violations'
			,	id			: 'number_of_violations'
			,	dataIndex	: 'number_of_violations'
			,	width		: 70
			,	align		: 'center'
			,	editor		: this.form_number_of_violations
			,	summaryType	: 'sum'
			},{
				header		: 'Severity'
			,	id			: 'id_severity'
			,	dataIndex	: 'id_severity'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_severity
			,	renderer	: combo_renderer(this.form_severity)
			,	summaryType	: 'sum'
			},{
				header		: 'Violation X Severity'
			,	id			: 'violation_x_severity'
			,	dataIndex	: 'violation_x_severity'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_violation_x_severity
			,	summaryType	: 'sum'
			},{
				header		: '4 & 5'
			,	id			: 'li_45'
			,	dataIndex	: 'li_45'
			,	width		: 40
			,	align		: 'center'
			,	editor		: this.form_li_45
			,	summaryType	: 'sum'
			},{
				header		: 'APD'
			,	id			: 'li_apd'
			,	dataIndex	: 'li_apd'
			,	width		: 40
			,	align		: 'center'
			,	editor		: this.form_li_apd
			,	summaryType	: 'sum'
			},{
				header		: 'House keeping'
			,	id			: 'li_housekeeping'
			,	dataIndex	: 'li_housekeeping'
			,	width		: 60
			,	editor		: this.form_li_housekeeping
			,	summaryType	: 'sum'
			},{
				header		: 'Process Safety'
			,	id			: 'li_process_safety'
			,	dataIndex	: 'li_process_safety'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_li_process_safety
			,	summaryType	: 'sum'
			},{
				header		: 'Fire Safety'
			,	id			: 'li_fire_safety'
			,	dataIndex	: 'li_fire_safety'
			,	width		: 60
			,	align		: 'center'
			,	editor		: this.form_li_fire_safety
			,	summaryType	: 'sum'
			},{
				header		: 'Actions'
			,	id			: 'actions'
			,	dataIndex	: 'actions'
			,	width		: 250
			,	editor		: this.form_actions
			},{
				header		: 'Status'
			,	id			: 'status'
			,	dataIndex	: 'status'
			,	width		: 80
			,	editor		: this.form_status
			,	renderer	: combo_renderer(this.form_status)
			},{
				header		: 'Target'
			,	id			: 'completion_date_target'
			,	dataIndex	: 'completion_date_target'
			,	width		: 100
			,	align		: 'center'
			,	editor		: this.form_completion_date_target
			,	xtype		: 'datecolumn'
			,	format		: 'Y-m-d'
			},{
				header		: 'Actual'
			,	id			: 'completion_date_actual'
			,	dataIndex	: 'completion_date_actual'
			,	width		: 100
			,	align		: 'center'
			,	editor		: this.form_completion_date_actual
			,	xtype		: 'datecolumn'
			,	format		: 'Y-m-d'
			},{
				header		: 'Note'
			,	id			: 'note'
			,	dataIndex	: 'note'
			,	width		: 150
			,	editor		: this.form_note
			}]
	,	defaults : {
			sortable	: false
		,	hideable	: false
		}
	});
	
	this.col_hdr = [{
			colspan	: 2
		},{
			header	: 'People'
		,	colspan	: 2
		},{
			header	: 'Violations'
		,	colspan	: 3
		},{
			header	: 'Leading Indicator'
		,	colspan	: 5
		},{	colspan	: 1
		},{	colspan	: 1
		},{
			header	: 'Completion Date'
		,	colspan	: 2
		},{
			colspan	: 1
	}];

	this.hdr = new Ext.ux.grid.ColumnHeaderGroup({
		rows	: [this.col_hdr]
	});

	this.summary = new Ext.ux.grid.GridSummary();
	
	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					
					if (data.length) {
						this.status = data[0].data['status'];						
					} else {
						this.status = 0;
					}
					
					if (this.status == 3){
						this.btn_del.setDisabled(true);
					} else {
						this.btn_del.setDisabled(false);
					}
					
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_rca					: ''
			,	id_rca_detail			: ''
			,	description				: ''
			,	good_citizens			: 0
			,	violators				: 0
			,	number_of_violations	: 0
			,	id_severity				: ''
			,	violation_x_severity	: 0
			,	li_45					: 0
			,	li_apd					: 0
			,	li_housekeeping			: 0
			,	li_process_safety		: 0
			,	li_fire_safety			: 0
			,	actions					: ''
			,	status					: '1'
			,	completion_date_target	: ''
			,	completion_date_actual	: ''
			,	note					: ''
		});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);
		
		this.dml_type = 2;
	}

	this.do_edit = function(row)
	{
		this.dml_type = 3;
		return true;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		
		if (!data.length) {
			return;
		}

		Ext.Msg.confirm ("Konfirmasi", "Apakah anda yakin akan menghapus data ?", function (btn_id, text, opt) {
			if (btn_id == 'yes') {
				this.dml_type = 4;
				this.do_save(data[0]);
			}
		}
		,this);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_calculate = function()
	{
		var good_citizens 			= 0;
		var violators 				= 0;
		var number_of_violations 	= 0;
		var severity 				= 0;
		var violation_x_severity 	= 0;
		var li_45 					= 0;
		var li_apd 					= 0;
		var li_housekeeping 		= 0;
		var li_process_safety 		= 0;
		var li_fire_safety 			= 0;
		
		var good_citizens_violators 		= 0;
		var observed_people 				= 0;
		var average_severity_of_violations 	= 0;
		var percent_severity_45 			= 0;
		var number_people_on_site 			= 0;
		var percent_workers_observed 		= 0;

		var jml = this.store.getCount();
		
		if (jml != 0){
			for (i=0; i < jml; i++){
				good_citizens += this.store.getAt(i).get('good_citizens')
				violators += this.store.getAt(i).get('violators')
				number_of_violations += this.store.getAt(i).get('number_of_violations')
				severity += this.store.getAt(i).get('id_severity')
				violation_x_severity += this.store.getAt(i).get('violation_x_severity')
				li_45 += this.store.getAt(i).get('li_45')
				li_apd += this.store.getAt(i).get('li_apd')
				li_housekeeping += this.store.getAt(i).get('li_housekeeping')
				li_process_safety += this.store.getAt(i).get('li_process_safety')
				li_fire_safety += this.store.getAt(i).get('li_fire_safety')
			}
		}
		
		if (violators != 0){
			good_citizens_violators = good_citizens + violators
			number_people_on_site = good_citizens + violators
			percent_workers_observed = good_citizens_violators / number_people_on_site * 100
			m_trx_rca_edit.form_approximate_workers_observed.setValue(good_citizens_violators);
			m_trx_rca_edit.form_people_on_site.setValue(good_citizens_violators);
			m_trx_rca_edit.form_workers_observed.setValue(percent_workers_observed);
			
		} else {
			m_trx_rca_edit.form_approximate_workers_observed.setValue(0);
			m_trx_rca_edit.form_people_on_site.setValue(0);
			m_trx_rca_edit.form_workers_observed.setValue(0);
		}
		
		if (good_citizens != 0 && violators != 0){
			observed_people = good_citizens / good_citizens_violators * 100
			m_trx_rca_edit.form_observed_people.setValue(observed_people)
		} else {
			m_trx_rca_edit.form_observed_people.setValue(0);
		}
		
		if (number_of_violations != 0){
			m_trx_rca_edit.form_no_of_violations.setValue(number_of_violations);
		} else {
			m_trx_rca_edit.form_no_of_violations.setValue(0);
		}

		if (violation_x_severity != 0){
			average_severity_of_violations = violation_x_severity / number_of_violations
			m_trx_rca_edit.form_avg_sev_of_violations.setValue(average_severity_of_violations);
		} else {
			m_trx_rca_edit.form_avg_sev_of_violations.setValue(0);
		}

		if (li_45 != 0){
			percent_severity_45 = li_45 / number_of_violations * 100
			m_trx_rca_edit.form_severity_45.setValue(li_45);
			m_trx_rca_edit.form_percent_severity_45.setValue(percent_severity_45);
		} else {
			m_trx_rca_edit.form_severity_45.setValue(0);
			m_trx_rca_edit.form_percent_severity_45.setValue(0);
		}
	}
	
	this.do_save = function(record)
	{
		Ext.Ajax.request({
			params  : {
				id_rca					: m_trx_rca_id_rca
			,	id_rca_detail			: record.data['id_rca_detail']
			,	description				: record.data['description']
			,	good_citizens			: record.data['good_citizens']
			,	violators				: record.data['violators']
			,	number_of_violations	: record.data['number_of_violations']
			,	id_severity				: record.data['id_severity']
			,	violation_x_severity	: record.data['violation_x_severity']
			,	li_45					: record.data['li_45']
			,	li_apd					: record.data['li_apd']
			,	li_housekeeping			: record.data['li_housekeeping']
			,	li_process_safety		: record.data['li_process_safety']
			,	li_fire_safety			: record.data['li_fire_safety']
			,	actions					: record.data['actions']
			,	status					: record.data['status']
			,	completion_date_target	: record.data['completion_date_target']
			,	completion_date_actual	: record.data['completion_date_actual']
			,	note					: record.data['note']
			,   dml_type				: this.dml_type
			}
		,	url	: m_trx_rca_dir +'submit_rca_detail.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					if (msg.success == false) {
						Ext.MessageBox.alert('Pesan', msg.info);
					}

					this.do_load();
					this.do_calculate();
				}
		,	scope	: this
		});
	}
	
	this.btn_add = new Ext.Button({
		text	:'Tambah'
	,	iconCls	:'add16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_add();
		}
	});

	this.btn_del = new Ext.Button({
		text	:'Hapus'
	,	iconCls	:'del16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_del();
		}
	});

	this.grid = new Ext.grid.GridPanel({
		title				: 'Data RCA Detail'
	,	store				: this.store
	,	cm					: this.cm
	,	sm					: this.sm
	,	autoScroll			: true
	,	height				: 250
	,	autoWidth			: true
	,	plugins				: [this.summary, this.editor, this.hdr]
	//,	headerCfg			: {	cls: 'rca-header-form' }
	,	viewConfig			: {
			forceFit		: true
		}
	,	tbar				:[
			this.btn_add,'-'
		,	this.btn_del
		]
	,   listeners   : {
			scope		: this
		,	rowclick	:
				function (g, r, e) {
					return this.do_edit(r);
				}
		}
	});

	this.do_load = function()
	{
		this.store.load({
			params		: {
				id_rca	: m_trx_rca_id_rca
			}
		,	callback	: function(){
				this.do_calculate();
			}
		,	scope		: this
		});
	}
}

function M_TrxRCAAdd()
{
	this.dml_type		= 2;
	this.id_rca			= '';
	this.id_direktorat	= '0';
	this.id_divprosbu	= '0';
	this.id_departemen	= '0';
	this.id_dinas		= '0';
	this.id_seksi		= '0';
	this.direktorat		= '0';
	this.divprosbu		= '0';
	this.departemen		= '0';
	this.dinas			= '0';
	this.seksi			= '0';
	this.pic			= '';
	this.nipg_1			= '';
	this.nipg_2			= '';
	this.nipg_3			= '';
	this.jumlah			= 0;

	this.record_auditor = new Ext.data.Record.create([
		{
			name	: 'nipg'
		}
	]);

	this.store_auditor = new Ext.data.ArrayStore({
			fields	: this.record_auditor
		,	data	: []
	});

	this.form_satuan_kerja_auditor_on_select = function(record)
	{
		this.id_seksi 		= record.get('id_seksi');
		this.id_dinas 		= record.get('id_dinas');
		this.id_departemen 	= record.get('id_departemen');
		this.id_divprosbu 	= record.get('id_divprosbu');
		this.id_direktorat 	= record.get('id_direktorat');

		if (this.id_seksi != 'undefined' && this.id_seksi != '') {
			this.form_dinas_auditor.setValue(this.id_dinas);
			this.form_departemen_auditor.setValue(this.id_departemen);
			this.form_divprosbu_auditor.setValue(this.id_divprosbu);
			this.form_direktorat_auditor.setValue(this.id_direktorat);
		}
		
		m_trx_rca_store_auditor.removeAll();
		
		m_trx_rca_store_auditor.load({
			params	: {
				id_seksi	: this.id_seksi
			}
		});
		
		this.form_nama_auditor_1.setValue('');
		this.form_nama_auditor_2.setValue('');
		this.form_nama_auditor_3.setValue('');
		
		this.form_nama_auditor_1.clearFilter(true);
		this.form_nama_auditor_2.clearFilter(true);
		this.form_nama_auditor_3.clearFilter(true);
		
		this.form_nama_auditor_1.setDisabled(false);
		this.form_nama_auditor_2.setDisabled(true);
		this.form_nama_auditor_3.setDisabled(true);
		
		this.nipg_1 = '';
		this.nipg_2 = '';
		this.nipg_3 = '';
	}

	this.form_nama_auditor_1_on_select = function(nipg)
	{
		this.nipg_1	= nipg;
		
		if (this.nipg_1 != 'undefined' && this.nipg_1 != '') {
			this.form_nama_auditor_2.clearFilter(true);
			this.form_nama_auditor_2.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
			this.form_nama_auditor_3.clearFilter(true);
			this.form_nama_auditor_3.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
		} else {
			this.form_nama_auditor_2.clearFilter(true);
			this.form_nama_auditor_3.clearFilter(true);
		}
		
		this.form_nama_auditor_2.setDisabled(false);
	}

	this.form_nama_auditor_2_on_select = function(nipg)
	{
		this.nipg_2	= nipg;
		
		if (this.nipg_2 != 'undefined' && this.nipg_2 != '') {
			this.form_nama_auditor_1.clearFilter(true);
			this.form_nama_auditor_1.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
			this.form_nama_auditor_3.clearFilter(true);
			this.form_nama_auditor_3.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
		} else {
			this.form_nama_auditor_1.clearFilter(true);
			this.form_nama_auditor_3.clearFilter(true);
		}
		
		this.form_nama_auditor_3.setDisabled(false);
	}

	this.form_nama_auditor_3_on_select = function(nipg)
	{
		this.nipg_3	= nipg;
		
		if (this.nipg_3 != 'undefined' && this.nipg_3 != '') {
			this.form_nama_auditor_1.clearFilter(true);
			this.form_nama_auditor_1.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
			this.form_nama_auditor_2.clearFilter(true);
			this.form_nama_auditor_2.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
		} else {
			this.form_nama_auditor_1.clearFilter(true);
			this.form_nama_auditor_2.clearFilter(true);
		}		
	}

	this.form_penanggung_jawab_on_select = function(record)
	{
		this.seksi		= record.get('id_seksi');
		this.dinas 		= record.get('id_dinas');
		this.departemen = record.get('id_departemen');
		this.divprosbu	= record.get('id_divprosbu');
		this.direktorat = record.get('id_direktorat');
		this.pic		= record.get('kepala_seksi');
	}

	this.form_tanggal_rca = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Audit'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 150
	});

	this.form_direktorat_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'Direktorat'
		,	store			: m_trx_rca_store_direktorat
		,	valueField		: 'id_direktorat'
		,	displayField	: 'nama_direktorat'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	disabled		: true
		,	hidden			: true
		,	width			: 300
	});

	this.form_divprosbu_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'DivProSBU'
		,	store			: m_trx_rca_store_divprosbu
		,	valueField		: 'id_divprosbu'
		,	displayField	: 'nama_divprosbu'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	disabled		: true
		,	hidden			: true
		,	width			: 300
	});

	this.form_departemen_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'Departemen'
		,	store			: m_trx_rca_store_departemen
		,	valueField		: 'id_departemen'
		,	displayField	: 'nama_departemen'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	disabled		: true
		,	hidden			: true
		,	width			: 300
	});

	this.form_dinas_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'Dinas'
		,	store			: m_trx_rca_store_dinas
		,	valueField		: 'id_dinas'
		,	displayField	: 'nama_dinas'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	disabled		: true
		,	hidden			: true
		,	width			: 300
	});

	this.form_satuan_kerja_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'Satuan Kerja Auditor'
		,	store			: m_trx_rca_store_seksi
		,	valueField		: 'id_seksi'
		,	displayField	: 'nama_seksi'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_satuan_kerja_auditor_on_select(record);
				}
		}
	});

	this.form_nama_auditor_1 = new Ext.form.ComboBox({
			fieldLabel		: 'Nama Auditor 1'
		,	store			: m_trx_rca_store_auditor
		,	valueField		: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	disabled		: true
		,	listeners		: {
				scope	: this
				,	select	: function(cb, record, index) {
					this.form_nama_auditor_1_on_select(record.get('nipg'));
				}
		}
	});

	this.form_nama_auditor_2 = new Ext.form.ComboBox({
			fieldLabel		: 'Nama Auditor 2'
		,	store			: m_trx_rca_store_auditor
		,	valueField		: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	disabled		: true
		,	listeners		: {
				scope	: this
				,	select	: function(cb, record, index) {
					this.form_nama_auditor_2_on_select(record.get('nipg'));
				}
		}
	});
	
	this.form_nama_auditor_3 = new Ext.form.ComboBox({
			fieldLabel		: 'Nama Auditor 3'
		,	store			: m_trx_rca_store_auditor
		,	valueField		: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	disabled		: true
		,	listeners		: {
				scope	: this
				,	select	: function(cb, record, index) {
					this.form_nama_auditor_3_on_select(record.get('nipg'));
				}
		}
	});

	this.form_nama_tempat_rca = new Ext.form.TextField({
			fieldLabel	: 'Nama Tempat'
		,	width		: 200
		,	msgTarget	: 'side'
	});

	this.form_penanggung_jawab = new Ext.form.ComboBox({
			fieldLabel		: 'Penanggung Jawab'
		,	store			: m_trx_rca_store_penanggung_jawab
		,	valueField		: 'id_seksi'
		,	displayField	: 'nama_seksi'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_penanggung_jawab_on_select(record);
				}
		}
	});

	this.form_waktu_audit = new Ext.form.TextField({
			fieldLabel	: 'Waktu Audit'
		,	width		: 150
		,	msgTarget	: 'side'
	});

	this.form_lama_audit = new Ext.form.NumberField({
			fieldLabel		: 'Lama Audit'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_cuaca = new Ext.form.TextField({
			fieldLabel	: 'Cuaca'
		,	width		: 150
		,	msgTarget	: 'side'
	});

	this.form_rca_detail = new M_TrxRCADetail();
	
	this.form_observed_people = new Ext.form.NumberField({
			fieldLabel			: '% of Observed People Working Safely/Good Citizens'
		,	readOnly			: true
		,	decimalPrecision	: 2
		,	width				: 50
		,	style				: 'text-align: right'
	});

	this.form_no_of_violations = new Ext.form.NumberField({
			fieldLabel			: 'No of Violation'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_avg_sev_of_violations = new Ext.form.NumberField({
			fieldLabel			: 'Average Severity of Violations'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_severity_45 = new Ext.form.NumberField({
			fieldLabel			: 'Number of Severity 4 & 5 Violations'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_percent_severity_45 = new Ext.form.NumberField({
			fieldLabel			: '% Number of Severity 4 & 5 Violations'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});
	
	this.form_approximate_workers_observed = new Ext.form.NumberField({
			fieldLabel			: 'Approximate No of Workers Observed'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_people_on_site = new Ext.form.NumberField({
			fieldLabel			: 'Number of People on Site'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_workers_observed = new Ext.form.NumberField({
			fieldLabel			: '% of Workers Observed'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.panel_form = new Ext.form.FormPanel({
			layout		: 'column'
		,	autoWidth	: true
		,	items		: [
				{
					columnWidth	: 0.5
				,	layout		: 'form'
				,	baseCls		: 'x-plain'
				,	labelAlign	: 'right'
				,	labelWidth	: 120
				,	items		: [
						this.form_tanggal_rca
					,	this.form_satuan_kerja_auditor
					,	this.form_nama_auditor_1
					,	this.form_nama_auditor_2
					,	this.form_nama_auditor_3
					]
				}
			,	{
					columnWidth	: 0.5
				,	layout		: 'form'
				,	baseCls		: 'x-plain'
				,	labelAlign	: 'right'
				,	labelWidth	: 120
				,	items		: [
						this.form_nama_tempat_rca
					,	this.form_penanggung_jawab
					,	this.form_waktu_audit
					,	{
							xtype	: 'compositefield'
						,	items	: [
								this.form_lama_audit
							,	{	
									xtype	: 'displayfield'
								,	value	: 'menit'
								}
							]
						}
					,	this.form_cuaca
					]
				}
			]
	});

	this.panel_summary = new Ext.form.FormPanel({
			labelAlign	: 'right'
		,	labelWidth	: 300
		,	autoWidth	: true
		,	items		: [
				{
						xtype	: 'compositefield'
					,	items	: [
							this.form_observed_people
						,	{	
								xtype	: 'displayfield'
							,	value	: '%'
							}
						]
				}
				,	this.form_no_of_violations
				,	this.form_avg_sev_of_violations
				,	this.form_severity_45
				,{
						xtype	: 'compositefield'
					,	items	: [
							this.form_percent_severity_45
						,	{	
								xtype	: 'displayfield'
							,	value	: '%'
							}
						]
				}
				,	this.form_approximate_workers_observed
				,	this.form_people_on_site
				,{
						xtype	: 'compositefield'
					,	items	: [
							this.form_workers_observed
						,	{	
								xtype	: 'displayfield'
							,	value	: '%'
							}
						]
				}
			]
	});
	
	this.btn_cancel = new Ext.Button({
			text	: 'Kembali'
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

	this.panel = new Ext.Panel({
			title		: 'Tambah Data RCA'
		,	autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: [
				this.btn_cancel
			,	'->'
			,	this.btn_save
			]
		,	defaults	:{
				style		:{
					marginLeft		:'auto'
				,	marginRight		:'auto'
				,	marginBottom	:'8px'
				}
			}
		,	items		: [
				this.panel_form
			,	this.form_rca_detail.grid
			,	this.panel_summary
			]
	});

	this.do_load = function()
	{
		m_trx_rca_store_direktorat.load();
		m_trx_rca_store_divprosbu.load();
		m_trx_rca_store_departemen.load();
		m_trx_rca_store_dinas.load();
		m_trx_rca_store_seksi.load();
		m_trx_rca_store_penanggung_jawab.load();
		m_trx_rca_store_severity.load();
	}

	this.is_valid = function()
	{
		if (!this.form_tanggal_rca.isValid()) {
			return false;
		}

		if (!this.form_satuan_kerja_auditor.isValid()) {
			return false;
		}

		if (!this.form_dinas_auditor.isValid()) {
			return false;
		}
		
		if (!this.form_departemen_auditor.isValid()) {
			return false;
		}
		
		if (!this.form_divprosbu_auditor.isValid()) {
			return false;
		}
		
		if (!this.form_direktorat_auditor.isValid()) {
			return false;
		}

		if (!this.form_nama_tempat_rca.isValid()) {
			return false;
		}

		if (!this.form_penanggung_jawab.isValid()) {
			return false;
		}

		if (!this.form_waktu_audit.isValid()) {
			return false;
		}

		if (!this.form_lama_audit.isValid()) {
			return false;
		}

		if (!this.form_cuaca.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_trx_rca.panel.layout.setActiveItem(0);
	}

	this.do_reset = function()
	{
		this.form_tanggal_rca.setValue('');
		this.form_satuan_kerja_auditor.setValue('');
		this.form_dinas_auditor.setValue('');
		this.form_departemen_auditor.setValue('');
		this.form_divprosbu_auditor.setValue('');
		this.form_direktorat_auditor.setValue('');
		this.form_nama_auditor_1.setValue('');
		this.form_nama_auditor_1.setDisabled(true);
		this.form_nama_auditor_2.setValue('');
		this.form_nama_auditor_2.setDisabled(true);
		this.form_nama_auditor_3.setValue('');
		this.form_nama_auditor_3.setDisabled(true);
		this.form_nama_tempat_rca.setValue('');
		this.form_penanggung_jawab.setValue('');
		this.form_waktu_audit.setValue('');
		this.form_lama_audit.setValue(0);
		this.form_cuaca.setValue('');
		
		this.form_rca_detail.do_reset();
		
		this.form_observed_people.setValue(0);
		this.form_no_of_violations.setValue(0);
		this.form_avg_sev_of_violations.setValue(0);
		this.form_severity_45.setValue(0);
		this.form_percent_severity_45.setValue(0);
		this.form_approximate_workers_observed.setValue(0);
		this.form_people_on_site.setValue(0);
		this.form_workers_observed.setValue(0);
		
		m_trx_rca_store_auditor.removeAll();
	}

	this.send_email = function()
	{
		Ext.Ajax.request({
			url		: m_trx_rca_dir +'send_email.jsp'
		,	params	: {
				penanggung_jawab_nipg		: this.pic
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Notifikasi Email Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Notifikasi Email Gagal', msg.info);
					return;
				}
			}
		,	scope	: this
		});
	}
	
	this.do_save = function()
	{
		if (this.pic == undefined || this.pic == 'undefined'
		|| this.pic == 'null' || this.pic == '')
		{
			Ext.MessageBox.alert('Kesalahan', 'Area pada Penanggung Jawab belum memiliki Kepala Seksi!<br/>'
			+' Tambah/ubah data pegawai dengan jabatan Kepala Seksi pada Area bersangkutan.' );
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		this.store_auditor.removeAll();
		
		if (this.nipg_1 != ''){
			this.record_new = new this.record_auditor({
				nipg	: "'" + this.nipg_1 + "'"
			});

			this.store_auditor.add(this.record_new);
		}

		if (this.nipg_2 != ''){
			this.record_new = new this.record_auditor({
				nipg	: "'" + this.nipg_2 + "'"
			});

			this.store_auditor.add(this.record_new);
		}

		if (this.nipg_3 != ''){
			this.record_new = new this.record_auditor({
				nipg	: "'" + this.nipg_3 + "'"
			});

			this.store_auditor.add(this.record_new);
		}
		
		var i		= 0;
		var auditor	= '[';

		this.store_auditor.each(function(r) {
			if (i > 0) {
				auditor += ",";
			} else {
				i = 1;
			}
			auditor += r.get('nipg');
		});
		auditor += ']';

		var j			= 0;
		var rca_detail	= '[';
		var date;
		var date_target;
		var date_actual;

		this.form_rca_detail.store.each(function(r) {
			if (j > 0) {
				rca_detail += ",";
			} else {
				j = 1;
			}
			
			if (r.get('completion_date_target') != ''){
				date = new Date(r.get('completion_date_target'));
				date_target = (1900 + date.getYear()) +'-'+ (1 + date.getMonth()) +'-'+ date.getDate();
			} else {
				date_target = '1900-01-01'
			}

			if (r.get('completion_date_actual') != ''){
				date = new Date(r.get('completion_date_actual'));
				date_actual = (1900 + date.getYear()) +'-'+ (1 + date.getMonth()) +'-'+ date.getDate();
			} else {
				date_actual = '1900-01-01'
			}

			rca_detail += "{description: '" + r.get('description')
					   +"', good_citizens: " + r.get('good_citizens')
					   +",  violators: " + r.get('violators')
					   +",  number_of_violations: " + r.get('number_of_violations')
					   +",  id_severity: " + r.get('id_severity')
					   +",  violation_x_severity: " + r.get('violation_x_severity')
					   +",  li_45: " + r.get('li_45')
					   +",  li_apd: " + r.get('li_apd')
					   +",  li_housekeeping: " + r.get('li_housekeeping')
					   +",  li_process_safety: " + r.get('li_process_safety')
					   +",  li_fire_safety: " + r.get('li_fire_safety')
					   +",  actions: '" + r.get('actions')
					   +"', status: '" + r.get('status')
					   +"', completion_date_target: '" + date_target
					   +"', completion_date_actual: '" + date_actual
					   +"', note: '" + r.get('note')
					   +"'}"
		});
		rca_detail += ']';

		main_load.show();
		
		var	d, m ,y;
		var periode = 0;
		
		d = this.form_tanggal_rca.getValue();
		d = d.getDate();
		m = this.form_tanggal_rca.getValue();
		m = 1 + m.getMonth();
		y = this.form_tanggal_rca.getValue();
		y = 1900 + y.getYear();
		
		if (d <= 15){
			periode = 1;
		} else {
			periode = 2;
		}
		
		Ext.Ajax.request({
			url	: m_trx_rca_dir +'submit_rca_data.jsp'
		,	params	: {
				dml_type					: this.dml_type
			,	id_rca						: this.id_rca
			,	tanggal_rca					: this.form_tanggal_rca.getValue()
			,	auditor_direktorat			: this.form_direktorat_auditor.getValue()
			,	auditor_divprosbu			: this.form_divprosbu_auditor.getValue()
			,	auditor_departemen			: this.form_departemen_auditor.getValue()
			,	auditor_dinas				: this.form_dinas_auditor.getValue()
			,	auditor_seksi				: this.form_satuan_kerja_auditor.getValue()
			,	nama_tempat_rca				: this.form_nama_tempat_rca.getValue()
			,	penanggung_jawab_direktorat	: this.direktorat
			,	penanggung_jawab_divprosbu	: this.divprosbu
			,	penanggung_jawab_departemen	: this.departemen
			,	penanggung_jawab_dinas		: this.dinas
			,	penanggung_jawab_seksi		: this.form_penanggung_jawab.getValue()
			,	penanggung_jawab_nipg		: this.pic
			,	waktu_audit					: this.form_waktu_audit.getValue()
			,	lama_audit					: this.form_lama_audit.getValue()
			,	cuaca						: this.form_cuaca.getValue()
			,	periode						: periode
			,	bulan						: m
			,	tahun						: y
			,	auditor						: auditor
			,	rca_detail					: rca_detail
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				main_load.hide();
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				main_load.hide();
				
				Ext.MessageBox.alert('Informasi', msg.info);

				m_trx_rca_list.store.reload();
				m_trx_rca.panel.layout.setActiveItem(0);
				
				this.send_email();
			}
		,	scope	: this
		});	
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.set_min_max_date = function()
	{
		var d_min;
		var d_max;
		var d		= new Date();
		var day		= d.getDate();
		var month	= d.getMonth();
		var year	= 1900 + d.getYear();

		if (day <= 15) {
			d_min = new Date(year, month, 1);
			d_max = new Date(year, month, 15);
		} else {
			d_min = new Date(year, month, 16);
			d_max = new Date(year, month + 1, 0);
		}

		this.form_tanggal_rca.setMinValue(d_min);
		this.form_tanggal_rca.setMaxValue(d_max);
	}

	this.do_refresh = function()
	{
		if (m_trx_rca_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input data RCA!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_trx_rca_ha_level < 4) {
			// this.set_min_max_date();
		}

		this.do_load();
	}
}

function M_TrxRCAEdit()
{
	this.dml_type		= 3;
	this.id_direktorat	= '0';
	this.id_divprosbu	= '0';
	this.id_departemen	= '0';
	this.id_dinas		= '0';
	this.id_seksi		= '0';
	this.direktorat		= '0';
	this.divprosbu		= '0';
	this.departemen		= '0';
	this.dinas			= '0';
	this.seksi			= '0';
	this.pic			= '';
	this.nipg_1			= '';
	this.nipg_2			= '';
	this.nipg_3			= '';

	this.store_auditor = new Ext.data.ArrayStore({
			url			: m_trx_rca_dir +'data_rca_auditor.jsp'
		,	fields		: ['id_rca','nipg']
		,	autoLoad	: false
	});

	this.record_nama_auditor = new Ext.data.Record.create([
		{
			name	: 'nipg'
		}
	]);

	this.store_nama_auditor = new Ext.data.ArrayStore({
			fields	: this.record_nama_auditor
		,	data	: []
	});

	this.form_satuan_kerja_auditor_on_select = function(record)
	{
		this.id_seksi 		= record.get('id_seksi');
		this.id_dinas 		= record.get('id_dinas');
		this.id_departemen 	= record.get('id_departemen');
		this.id_divprosbu 	= record.get('id_divprosbu');
		this.id_direktorat 	= record.get('id_direktorat');

		if (this.id_seksi != 'undefined' && this.id_seksi != '') {
			this.form_dinas_auditor.setValue(this.id_dinas);
			this.form_departemen_auditor.setValue(this.id_departemen);
			this.form_divprosbu_auditor.setValue(this.id_divprosbu);
			this.form_direktorat_auditor.setValue(this.id_direktorat);
		}
		
		m_trx_rca_store_auditor.removeAll();
		
		m_trx_rca_store_auditor.load({
			params	: {
				id_seksi	: this.id_seksi
			}
		});

		this.form_nama_auditor_1.setValue('');
		this.form_nama_auditor_2.setValue('');
		this.form_nama_auditor_3.setValue('');
		
		this.form_nama_auditor_1.clearFilter(true);
		this.form_nama_auditor_2.clearFilter(true);
		this.form_nama_auditor_3.clearFilter(true);
		
		this.form_nama_auditor_1.setDisabled(false);
		this.form_nama_auditor_2.setDisabled(true);
		this.form_nama_auditor_3.setDisabled(true);
		
		this.nipg_1 = '';
		this.nipg_2 = '';
		this.nipg_3 = '';
	}

	this.form_nama_auditor_1_on_select = function(nipg)
	{
		this.nipg_1	= nipg;
		
		if (this.nipg_1 != 'undefined' && this.nipg_1 != '') {
			this.form_nama_auditor_2.clearFilter(true);
			this.form_nama_auditor_2.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
			this.form_nama_auditor_3.clearFilter(true);
			this.form_nama_auditor_3.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
		} else {
			this.form_nama_auditor_2.clearFilter(true);
			this.form_nama_auditor_3.clearFilter(true);
		}
		
		this.form_nama_auditor_2.setDisabled(false);
	}

	this.form_nama_auditor_2_on_select = function(nipg)
	{
		this.nipg_2	= nipg;
		
		if (this.nipg_2 != 'undefined' && this.nipg_2 != '') {
			this.form_nama_auditor_1.clearFilter(true);
			this.form_nama_auditor_1.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
			this.form_nama_auditor_3.clearFilter(true);
			this.form_nama_auditor_3.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
		} else {
			this.form_nama_auditor_1.clearFilter(true);
			this.form_nama_auditor_3.clearFilter(true);
		}
		
		this.form_nama_auditor_3.setDisabled(false);
	}

	this.form_nama_auditor_3_on_select = function(nipg)
	{
		this.nipg_3	= nipg;
		
		if (this.nipg_3 != 'undefined' && this.nipg_3 != '') {
			this.form_nama_auditor_1.clearFilter(true);
			this.form_nama_auditor_1.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
			this.form_nama_auditor_2.clearFilter(true);
			this.form_nama_auditor_2.filterBy(function(r, id){
				return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
			}, this);
		} else {
			this.form_nama_auditor_1.clearFilter(true);
			this.form_nama_auditor_2.clearFilter(true);
		}		
	}
	
	this.form_penanggung_jawab_on_select = function(record)
	{
		this.seksi		= record.get('id_seksi');
		this.dinas 		= record.get('id_dinas');
		this.departemen = record.get('id_departemen');
		this.divprosbu 	= record.get('id_divprosbu');
		this.direktorat = record.get('id_direktorat');
		this.pic		= record.get('kepala_seksi');
	}

	this.form_tanggal_rca = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Audit'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	allowBlank	: false
		,	width		: 150
	});

	this.form_direktorat_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'Direktorat'
		,	store			: m_trx_rca_store_direktorat
		,	valueField		: 'id_direktorat'
		,	displayField	: 'nama_direktorat'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	disabled		: true
		,	width			: 300
	});

	this.form_divprosbu_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'DivProSBU'
		,	store			: m_trx_rca_store_divprosbu
		,	valueField		: 'id_divprosbu'
		,	displayField	: 'nama_divprosbu'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	disabled		: true
		,	width			: 300
	});

	this.form_departemen_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'Departemen'
		,	store			: m_trx_rca_store_departemen
		,	valueField		: 'id_departemen'
		,	displayField	: 'nama_departemen'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	disabled		: true
		,	width			: 300
	});

	this.form_dinas_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'Dinas'
		,	store			: m_trx_rca_store_dinas
		,	valueField		: 'id_dinas'
		,	displayField	: 'nama_dinas'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	disabled		: true
		,	width			: 300
	});

	this.form_satuan_kerja_auditor = new Ext.form.ComboBox({
			fieldLabel		: 'Satuan Kerja Auditor'
		,	store			: m_trx_rca_store_seksi
		,	valueField		: 'id_seksi'
		,	displayField	: 'nama_seksi'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_satuan_kerja_auditor_on_select(record);
				}
		}
	});

	this.form_nama_auditor_1 = new Ext.form.ComboBox({
			fieldLabel		: 'Nama Auditor 1'
		,	store			: m_trx_rca_store_auditor
		,	valueField		: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	disabled		: true
		,	listeners		: {
				scope	: this
				,	select	: function(cb, record, index) {
					this.form_nama_auditor_1_on_select(record.get('nipg'));
				}
		}
	});

	this.form_nama_auditor_2 = new Ext.form.ComboBox({
			fieldLabel		: 'Nama Auditor 2'
		,	store			: m_trx_rca_store_auditor
		,	valueField		: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	disabled		: true
		,	listeners		: {
				scope	: this
				,	select	: function(cb, record, index) {
					this.form_nama_auditor_2_on_select(record.get('nipg'));
				}
		}
	});
	
	this.form_nama_auditor_3 = new Ext.form.ComboBox({
			fieldLabel		: 'Nama Auditor 3'
		,	store			: m_trx_rca_store_auditor
		,	valueField		: 'nipg'
		,	displayField	: 'nama_pegawai'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 300
		,	disabled		: true
		,	listeners		: {
				scope	: this
				,	select	: function(cb, record, index) {
					this.form_nama_auditor_3_on_select(record.get('nipg'));
				}
		}
	});
	
	this.form_nama_tempat_rca = new Ext.form.TextField({
			fieldLabel	: 'Nama Tempat'
		,	width		: 200
		,	msgTarget	: 'side'
	});

	this.form_penanggung_jawab = new Ext.form.ComboBox({
			fieldLabel		: 'Penanggung Jawab'
		,	store			: m_trx_rca_store_penanggung_jawab
		,	valueField		: 'id_seksi'
		,	displayField	: 'nama_seksi'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	selectOnFocus	: true
		,	triggerAction	: 'all'
		,	width			: 200
		,	listWidth		: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_penanggung_jawab_on_select(record);
				}
		}
	});

	this.form_waktu_audit = new Ext.form.TextField({
			fieldLabel	: 'Waktu Audit'
		,	width		: 150
		,	msgTarget	: 'side'
	});

	this.form_lama_audit = new Ext.form.NumberField({
			fieldLabel		: 'Lama Audit'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_cuaca = new Ext.form.TextField({
			fieldLabel	: 'Cuaca'
		,	width		: 150
		,	msgTarget	: 'side'
	});

	this.form_rca_detail = new M_TrxEditRCADetail();

	this.form_observed_people = new Ext.form.NumberField({
			fieldLabel			: '% of Observed People Working Safely/Good Citizens'
		,	readOnly			: true
		,	decimalPrecision	: 2
		,	width				: 50
		,	style				: 'text-align: right'
	});

	this.form_no_of_violations = new Ext.form.NumberField({
			fieldLabel			: 'No of Violation'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_avg_sev_of_violations = new Ext.form.NumberField({
			fieldLabel			: 'Average Severity of Violations'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_severity_45 = new Ext.form.NumberField({
			fieldLabel			: 'Number of Severity 4 & 5 Violations'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_percent_severity_45 = new Ext.form.NumberField({
			fieldLabel			: '% Number of Severity 4 & 5 Violations'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});
	
	this.form_approximate_workers_observed = new Ext.form.NumberField({
			fieldLabel			: 'Approximate No of Workers Observed'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_people_on_site = new Ext.form.NumberField({
			fieldLabel			: 'Number of People on Site'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});

	this.form_workers_observed = new Ext.form.NumberField({
			fieldLabel			: '% of Workers Observed'
		,	readOnly			: true
		,	width				: 50
		,	decimalPrecision	: 2
		,	style				: 'text-align: right'
	});
	
	this.panel_form = new Ext.form.FormPanel({
			layout		: 'column'
		,	autoWidth	: true
		,	items		: [
				{
					columnWidth	: 0.5
				,	layout		: 'form'
				,	baseCls		: 'x-plain'
				,	labelAlign	: 'right'
				,	labelWidth	: 120
				,	items		: [
						this.form_tanggal_rca
					,	this.form_satuan_kerja_auditor
					,	this.form_nama_auditor_1
					,	this.form_nama_auditor_2
					,	this.form_nama_auditor_3
					]
				}
			,	{
					columnWidth	: 0.5
				,	layout		: 'form'
				,	baseCls		: 'x-plain'
				,	labelAlign	: 'right'
				,	labelWidth	: 120
				,	items		: [
						this.form_nama_tempat_rca
					,	this.form_penanggung_jawab
					,	this.form_waktu_audit
					,	{
							xtype	: 'compositefield'
						,	items	: [
								this.form_lama_audit
							,	{	
									xtype	: 'displayfield'
								,	value	: 'menit'
								}
							]
						}
					,	this.form_cuaca
					]
				}
			]
	});

	this.panel_summary = new Ext.form.FormPanel({
			labelAlign	: 'right'
		,	labelWidth	: 300
		,	autoWidth	: true
		,	items		: [
				{
						xtype	: 'compositefield'
					,	items	: [
							this.form_observed_people
						,	{	
								xtype	: 'displayfield'
							,	value	: '%'
							}
						]
				}
				,	this.form_no_of_violations
				,	this.form_avg_sev_of_violations
				,	this.form_severity_45
				,{
						xtype	: 'compositefield'
					,	items	: [
							this.form_percent_severity_45
						,	{	
								xtype	: 'displayfield'
							,	value	: '%'
							}
						]
				}
				,	this.form_approximate_workers_observed
				,	this.form_people_on_site
				,{
						xtype	: 'compositefield'
					,	items	: [
							this.form_workers_observed
						,	{	
								xtype	: 'displayfield'
							,	value	: '%'
							}
						]
				}
			]
	});
	
	this.btn_cancel = new Ext.Button({
			text	: 'Kembali'
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

	this.panel = new Ext.Panel({
			title		: 'Edit Data RCA'
		,	autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: [
				this.btn_cancel
			,	'->'
			,	this.btn_save
			]
		,	defaults	:{
				style		:{
					marginLeft		:'auto'
				,	marginRight		:'auto'
				,	marginBottom	:'8px'
				}
			}
		,	items		: [
				this.panel_form
			,	this.form_rca_detail.grid
			,	this.panel_summary
			]
	});

	this.do_load = function()
	{
		m_trx_rca_store_direktorat.load();
		m_trx_rca_store_divprosbu.load();
		m_trx_rca_store_departemen.load();
		m_trx_rca_store_dinas.load();
		m_trx_rca_store_seksi.load();
		m_trx_rca_store_penanggung_jawab.load();
		m_trx_rca_store_severity.load();
		
		m_trx_rca_store_auditor.removeAll();
		
		m_trx_rca_store_auditor.load({
			params	: {
				id_seksi	: m_trx_rca_id_seksi
			}
		});

		this.store_auditor.load({
			params: {
				id_rca	: m_trx_rca_id_rca
			}
		});

		this.form_rca_detail.do_load();
	}

	this.is_valid = function()
	{
		if (!this.form_tanggal_rca.isValid()) {
			return false;
		}

		if (!this.form_satuan_kerja_auditor.isValid()) {
			return false;
		}

		if (!this.form_dinas_auditor.isValid()) {
			return false;
		}
		
		if (!this.form_departemen_auditor.isValid()) {
			return false;
		}

		if (!this.form_divprosbu_auditor.isValid()) {
			return false;
		}

		if (!this.form_direktorat_auditor.isValid()) {
			return false;
		}

		if (!this.form_nama_tempat_rca.isValid()) {
			return false;
		}

		if (!this.form_penanggung_jawab.isValid()) {
			return false;
		}

		if (!this.form_waktu_audit.isValid()) {
			return false;
		}

		if (!this.form_lama_audit.isValid()) {
			return false;
		}

		if (!this.form_cuaca.isValid()) {
			return false;
		}

		return true;
	}

	this.do_cancel = function()
	{
		m_trx_rca.panel.layout.setActiveItem(0);
	}

	this.do_save = function()
	{
		if (this.pic == undefined || this.pic == 'undefined'
		|| this.pic == 'null' || this.pic == '')
		{
			Ext.MessageBox.alert('Kesalahan', 'Area pada Penanggung Jawab belum memiliki Kepala Seksi!<br/>'
			+' Tambah/ubah data pegawai dengan jabatan Kepala Seksi pada Area bersangkutan.' );
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		if (this.form_nama_auditor_1.getValue() == ''){
			this.nipg_1 = ''
		}

		if (this.form_nama_auditor_2.getValue() == ''){
			this.nipg_2 = ''
		}

		if (this.form_nama_auditor_3.getValue() == ''){
			this.nipg_3 = ''
		}
		
		this.store_nama_auditor.removeAll();
		
		if (this.nipg_1 != '' ){
			this.record_new = new this.record_nama_auditor({
				nipg	: "'" + this.nipg_1 + "'"
			});

			this.store_nama_auditor.add(this.record_new);
		}

		if (this.nipg_2 != ''){
			this.record_new = new this.record_nama_auditor({
				nipg	: "'" + this.nipg_2 + "'"
			});

			this.store_nama_auditor.add(this.record_new);
		}

		if (this.nipg_3 != ''){
			this.record_new = new this.record_nama_auditor({
				nipg	: "'" + this.nipg_3 + "'"
			});

			this.store_nama_auditor.add(this.record_new);
		}

		var i		= 0;
		var auditor	= '[';

		this.store_nama_auditor.each(function(r) {
			if (i > 0) {
				auditor += ",";
			} else {
				i = 1;
			}
			auditor += r.get('nipg');
		});
		auditor += ']';

		var rca_detail 	= '[]';
		var	d, m ,y;
		var periode = 0;

		d = this.form_tanggal_rca.getValue();
		d = d.getDate();
		m = this.form_tanggal_rca.getValue();
		m = 1 + m.getMonth();
		y = this.form_tanggal_rca.getValue();
		y = 1900 + y.getYear();

		if (d <= 15){
			periode = 1;
		} else {
			periode = 2;
		}

		Ext.Ajax.request({
			url	: m_trx_rca_dir +'submit_rca_data.jsp'
		,	params	: {
				dml_type					: this.dml_type
			,	id_rca						: this.id_rca
			,	tanggal_rca					: this.form_tanggal_rca.getValue()
			,	auditor_direktorat			: this.form_direktorat_auditor.getValue()
			,	auditor_divprosbu			: this.form_divprosbu_auditor.getValue()
			,	auditor_departemen			: this.form_departemen_auditor.getValue()
			,	auditor_dinas				: this.form_dinas_auditor.getValue()
			,	auditor_seksi				: this.form_satuan_kerja_auditor.getValue()
			,	nama_tempat_rca				: this.form_nama_tempat_rca.getValue()
			,	penanggung_jawab_direktorat	: this.direktorat
			,	penanggung_jawab_divprosbu	: this.divprosbu
			,	penanggung_jawab_departemen	: this.departemen
			,	penanggung_jawab_dinas		: this.dinas
			,	penanggung_jawab_seksi		: this.form_penanggung_jawab.getValue()
			,	penanggung_jawab_nipg		: this.pic
			,	waktu_audit					: this.form_waktu_audit.getValue()
			,	lama_audit					: this.form_lama_audit.getValue()
			,	cuaca						: this.form_cuaca.getValue()
			,	periode						: periode
			,	bulan						: m
			,	tahun						: y
			,	auditor						: auditor
			,	rca_detail					: rca_detail
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Kesalahan', msg.info);
					return;
				}

				Ext.MessageBox.alert('Informasi', msg.info);

				m_trx_rca_list.store.reload();
				m_trx_rca.panel.layout.setActiveItem(0);
			}
		,	scope	: this
		});
	}

	this.edit_fill_form = function(data)
	{
		this.form_tanggal_rca.setValue(data.tanggal_rca);
		this.form_satuan_kerja_auditor.setValue(data.auditor_seksi);
		this.form_dinas_auditor.setValue(data.auditor_dinas);
		this.form_departemen_auditor.setValue(data.auditor_departemen);
		this.form_divprosbu_auditor.setValue(data.auditor_divprosbu);
		this.form_direktorat_auditor.setValue(data.auditor_direktorat);
		this.form_nama_tempat_rca.setValue(data.nama_tempat_rca);
		this.form_penanggung_jawab.setValue(data.penanggung_jawab_seksi);
		this.dinas = data.penanggung_jawab_dinas;
		this.departemen = data.penanggung_jawab_departemen;
		this.divprosbu = data.penanggung_jawab_divprosbu;
		this.direktorat = data.penanggung_jawab_direktorat;
		this.pic = data.penanggung_jawab_nipg;
		this.form_waktu_audit.setValue(data.waktu_audit);
		this.form_lama_audit.setValue(data.lama_audit);
		this.form_cuaca.setValue(data.cuaca);

		var i;
		var jml = this.store_auditor.getCount();
		
		if (jml != 0){
			for (i=0; i < jml; i++){
				if (i == 0){
					this.form_nama_auditor_1.setValue(this.store_auditor.getAt(i).get('nipg'));
					this.form_nama_auditor_1.setDisabled(false);
					this.nipg_1 = this.form_nama_auditor_1.getValue();
				}
				if (i == 1){
					this.form_nama_auditor_2.setValue(this.store_auditor.getAt(i).get('nipg'));
					this.form_nama_auditor_2.setDisabled(false);
					this.nipg_2 = this.form_nama_auditor_2.getValue();
				}
				if (i == 2){
					this.form_nama_auditor_3.setValue(this.store_auditor.getAt(i).get('nipg'));
					this.form_nama_auditor_3.setDisabled(false);
					this.nipg_3 = this.form_nama_auditor_3.getValue();
				}				
			}
		} else {
			this.form_nama_auditor_1.setDisabled(false);
			this.form_nama_auditor_1.setValue('');
			this.form_nama_auditor_2.setDisabled(true);
			this.form_nama_auditor_2.setValue('');
			this.form_nama_auditor_3.setDisabled(true);
			this.form_nama_auditor_3.setValue('');
			this.nipg_1 = '';
			this.nipg_2 = '';
			this.nipg_3 = '';
		}
		
		this.form_nama_auditor_1.clearFilter(true);
		this.form_nama_auditor_1.filterBy(function(r, id){
			return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
		}, this);
		this.form_nama_auditor_2.clearFilter(true);
		this.form_nama_auditor_2.filterBy(function(r, id){
			return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
		}, this);
		this.form_nama_auditor_3.clearFilter(true);
		this.form_nama_auditor_3.filterBy(function(r, id){
			return (r.get('nipg') != this.nipg_1 && r.get('nipg') != this.nipg_2 && r.get('nipg') != this.nipg_3);
		}, this);
	}

	this.do_check = function()
	{
		if (m_trx_rca_pic == m_trx_rca_user){
			this.form_tanggal_rca.setDisabled(true);
			this.form_satuan_kerja_auditor.setDisabled(true);
			this.form_dinas_auditor.setDisabled(true);
			this.form_departemen_auditor.setDisabled(true);
			this.form_divprosbu_auditor.setDisabled(true);
			this.form_direktorat_auditor.setDisabled(true);
			this.form_nama_tempat_rca.setDisabled(true);
			this.form_penanggung_jawab.setDisabled(true);
			this.form_nama_auditor_1.setDisabled(true);
			this.form_nama_auditor_2.setDisabled(true);
			this.form_nama_auditor_3.setDisabled(true);
			this.form_waktu_audit.setDisabled(true);
			this.form_lama_audit.setDisabled(true);
			this.form_cuaca.setDisabled(true);
			
			this.form_rca_detail.form_description.setDisabled(true);
			this.form_rca_detail.form_good_citizens.setDisabled(true);
			this.form_rca_detail.form_violators.setDisabled(true);
			this.form_rca_detail.form_number_of_violations.setDisabled(true);
			this.form_rca_detail.form_severity.setDisabled(true);
			this.form_rca_detail.form_violation_x_severity.setDisabled(true);
			this.form_rca_detail.form_li_45.setDisabled(true);
			this.form_rca_detail.form_li_apd.setDisabled(true);
			this.form_rca_detail.form_li_housekeeping.setDisabled(true);
			this.form_rca_detail.form_li_process_safety.setDisabled(true);
			this.form_rca_detail.form_li_fire_safety.setDisabled(true);
			this.form_rca_detail.form_actions.setDisabled(true);
			
			this.form_rca_detail.form_status.setDisabled(false);
			this.form_rca_detail.form_status.clearFilter(true);
			this.form_rca_detail.form_status.filterBy(function(r, id){
				return (r.get('id') == 3);
			}, this);

			this.form_rca_detail.form_completion_date_target.setDisabled(true);
			this.form_rca_detail.form_completion_date_actual.setDisabled(false);
			this.form_rca_detail.btn_add.setDisabled(true);
			this.form_rca_detail.btn_del.setDisabled(true);
			this.btn_save.setDisabled(true);
			
		} else {
			this.form_tanggal_rca.setDisabled(false);
			this.form_satuan_kerja_auditor.setDisabled(false);
			this.form_dinas_auditor.setDisabled(false);
			this.form_departemen_auditor.setDisabled(false);
			this.form_divprosbu_auditor.setDisabled(false);
			this.form_direktorat_auditor.setDisabled(false);
			this.form_nama_tempat_rca.setDisabled(false);
			this.form_penanggung_jawab.setDisabled(false);
			this.form_nama_auditor_1.setDisabled(false);
			this.form_nama_auditor_2.setDisabled(false);
			this.form_nama_auditor_3.setDisabled(false);
			this.form_waktu_audit.setDisabled(false);
			this.form_lama_audit.setDisabled(false);
			this.form_cuaca.setDisabled(false);
			
			this.form_rca_detail.form_description.setDisabled(false);
			this.form_rca_detail.form_good_citizens.setDisabled(false);
			this.form_rca_detail.form_violators.setDisabled(false);
			this.form_rca_detail.form_number_of_violations.setDisabled(false);
			this.form_rca_detail.form_severity.setDisabled(false);
			this.form_rca_detail.form_violation_x_severity.setDisabled(false);
			this.form_rca_detail.form_li_45.setDisabled(false);
			this.form_rca_detail.form_li_apd.setDisabled(false);
			this.form_rca_detail.form_li_housekeeping.setDisabled(false);
			this.form_rca_detail.form_li_process_safety.setDisabled(false);
			this.form_rca_detail.form_li_fire_safety.setDisabled(false);
			this.form_rca_detail.form_actions.setDisabled(false);
			
			this.form_rca_detail.form_status.setDisabled(false);
			this.form_rca_detail.form_status.clearFilter(true);
			this.form_rca_detail.form_status.filterBy(function(r, id){
				return (r.get('id') == 1 || r.get('id') == 2);
			}, this);
			
			this.form_rca_detail.form_completion_date_target.setDisabled(false);
			this.form_rca_detail.form_completion_date_actual.setDisabled(true);
			this.form_rca_detail.btn_add.setDisabled(false);
			this.form_rca_detail.btn_del.setDisabled(false);
			this.btn_save.setDisabled(false);
		}
	}
	
	this.do_edit = function(id)
	{
		this.dml_type	= 3;
		this.id_rca		= id;
		
		Ext.Ajax.request({
			url	: m_trx_rca_dir +'data_rca.jsp'
		,	params	: {
				id_rca: id
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.edit_fill_form(msg);
				this.do_check();
			}
		,	scope	: this		
		});
	}
	
	this.set_min_max_date = function()
	{
		var d_min;
		var d_max;
		var d		= new Date();
		var day		= d.getDate();
		var month	= d.getMonth();
		var year	= 1900 + d.getYear();

		if (day <= 15) {
			d_min = new Date(year, month, 1);
			d_max = new Date(year, month, 15);
		} else {
			d_min = new Date(year, month, 16);
			d_max = new Date(year, month + 1, 0);
		}

		this.form_tanggal_rca.setMinValue(d_min);
		this.form_tanggal_rca.setMaxValue(d_max);
	}

	this.do_refresh = function()
	{
		if (m_trx_rca_ha_level <= 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk input data RCA!');

			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_trx_rca_ha_level < 4) {
			// this.set_min_max_date();
		}

		this.do_load();
	}
}

function M_TrxRCAList()
{
	this.dml_type		= 0;
	this.periode_status = 0;
	
	this.reader = new Ext.data.ArrayReader({}, [
		{
			name	: 'id_rca'
		},{
			name	: 'tanggal_rca'
		},{
			name	: 'id_seksi'
		},{
			name	: 'auditor_seksi'
		},{
			name	: 'nama_auditor'
		},{
			name	: 'penanggung_jawab_seksi'
		},{
			name	: 'pic'
		},{
			name	: 'nama_pic'
		},{
			name	: 'user_login'
		},{
			name	: 'id_user'
		}
	]);

	this.store = new Ext.data.GroupingStore({
			url	: _g_root +'/module/trx_rca/data_rca_list.jsp'
		,	reader		: this.reader
		,	groupField	: 'id_user'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
				new Ext.grid.RowNumberer()
			,	{
					id			: 'tanggal_rca'
				,	header		: 'Tanggal'
				,	dataIndex	: 'tanggal_rca'
				,	align		: 'center'
				,	width		: 90
				}
			,	{
					id			: 'auditor_seksi'
				,	header		: 'Satuan Kerja Auditor'
				,	dataIndex	: 'auditor_seksi'
				,	width		: 250
				}
			,	{
					id			: 'nama_auditor'
				,	header		: 'Nama Auditor'
				,	dataIndex	: 'nama_auditor'
				,	width		: 250
				}
			,	{
					id			: 'penanggung_jawab_seksi'
				,	header		: 'Satuan Kerja Penanggung Jawab'
				,	dataIndex	: 'penanggung_jawab_seksi'
				,	width		: 250
				}
			,	{
					header		: 'NIPG'
				,	dataIndex	: 'id_user'
				,	hidden		: true
				}
		]
	,	defaults : {
			sortable	: true
		,	hideable	: false
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_trx_rca_id_rca 	= data[0].data['id_rca'];
						m_trx_rca_id_seksi 	= data[0].data['id_seksi'];
						m_trx_rca_pic 		= data[0].data['pic'];
						m_trx_rca_user 		= data[0].data['user_login'];
					} else {
						m_trx_rca_id_rca 	= '';
						m_trx_rca_id_seksi 	= ''
						m_trx_rca_pic 		= '';
						m_trx_rca_user 		= ''
					}
				}
			}
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
				this.store.reload();
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

	this.toolbar = new Ext.Toolbar({
			items	: [
				this.btn_del
			,	'-'
			,	this.btn_edit
			,	'-'
			,	this.btn_ref
			,	'-'
			,	this.btn_add
			]
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
			title				: 'Risk Containment Audit (RCA)'
		,	store				: this.store
		,	cm					: this.cm
		,	sm					: this.sm
		,	autoScroll			: true
		,	autoExpandColumn	: 'penanggung_jawab_seksi'
		,	tbar				: this.toolbar
		,	view				: this.grid_view
	});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.Msg.confirm ("Konfirmasi", "Apakah anda yakin akan menghapus data ?", function (btn_id, text, opt) {
			if (btn_id == 'yes') {
				Ext.Ajax.request({
					url		: m_trx_rca_dir +'submit_rca_data.jsp'
				,	params	: {
						dml_type					: 4
					,	id_rca						: data.get('id_rca')
					,	tanggal_rca					: ''
					,	auditor_direktorat			: ''
					,	auditor_divprosbu			: ''
					,	auditor_departemen			: ''
					,	auditor_dinas				: ''
					,	auditor_seksi				: ''
					,	nama_tempat_rca				: ''
					,	penanggung_jawab_direktorat	: ''
					,	penanggung_jawab_divprosbu	: ''
					,	penanggung_jawab_departemen	: ''
					,	penanggung_jawab_dinas		: ''
					,	penanggung_jawab_seksi		: ''
					,	penanggung_jawab_nipg		: ''
					,	waktu_audit					: ''
					,	lama_audit					: ''
					,	cuaca						: ''
					,	periode						: 0
					,	bulan						: 0
					,	tahun						: 0
					,	auditor						: '[]'
					,	rca_detail					: '[]'
					}
				,	waitMsg	: 'Mohon Tunggu ...'
				,	failure	: function(response) {
						Ext.MessageBox.alert('Gagal', response.responseText);
					}
				,	success : function (response) {
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Kesalahan', msg.info);
							return;
						}

						Ext.MessageBox.alert('Informasi', msg.info);

						this.do_load();
					}
				,	scope	: this
				});
			}
		}
		,this);
	}
	
	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_trx_rca_edit.do_refresh();
		m_trx_rca_edit.do_edit(data.get('id_rca'));
		m_trx_rca.panel.layout.setActiveItem(2);
	}

	this.do_add = function()
	{
		m_trx_rca_add.do_add();
		m_trx_rca_add.do_refresh();
		m_trx_rca.panel.layout.setActiveItem(1);
	}

	this.do_load = function()
	{
		var load_type = 'user';

		if (m_trx_rca_ha_level == 4) {
			load_type = 'all';
		}

		this.store.load({
			params	: {
				load_type : load_type
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_trx_rca_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk Data RCA!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_trx_rca_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_trx_rca_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_trx_rca_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_TrxRCA()
{
	m_trx_rca_list	= new M_TrxRCAList();
	m_trx_rca_add	= new M_TrxRCAAdd();
	m_trx_rca_edit	= new M_TrxRCAEdit();

	this.panel	= new Ext.Panel({
			id			: 'trx_rca_panel'
		,	layout		: 'card'
		,	activeItem	: 0
		,	autoWidth	: true
		,	autoScroll	: true
		,	items		: [
				m_trx_rca_list.panel
			,	m_trx_rca_add.panel
			,	m_trx_rca_edit.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_trx_rca_ha_level	= ha_level;
		m_trx_rca_id_rca 	= '';

		m_trx_rca_list.do_refresh();
	}
}

m_trx_rca = new M_TrxRCA();

//@ sourceURL=trx_rca.layout.js
