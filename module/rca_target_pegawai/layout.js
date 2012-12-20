/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 *	 - agus sugianto (agus.delonge@gmail.com)
 */

var m_rca_target_pegawai;
var m_rca_target_peg_d = _g_root +'/module/rca_target_pegawai/';

function M_RCATargetPegawai()
{
	this.records = [
		{name:'nipg'}
	,	{name:'name'}
	,	{name:'jan'}
	,	{name:'feb'}
	,	{name:'mar'}
	,	{name:'apr'}
	,	{name:'may'}
	,	{name:'jun'}
	,	{name:'jul'}
	,	{name:'aug'}
	,	{name:'sep'}
	,	{name:'oct'}
	,	{name:'nov'}
	,	{name:'dec'}
	];

	this.reader = new Ext.data.JsonReader(
		{ root:'rows'}
	,	this.records
	);

	this.store = new Ext.data.Store({
		url	:m_rca_target_peg_d +'data.jsp'
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.form_number = new Ext.form.NumberField({
		allowBlank	: false
	,	allowDecimals	: false
	,	allowNegative	: false
	,	value		: '0'
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	:[
			new Ext.grid.RowNumberer({width:30})
		,{
			header		:'Nama'
		,	dataIndex	:'name'
		,	align		:'left'
		,	width		: 300
		},{
			header		:'Jan'
		,	dataIndex	:'jan'
		},{
			header		:'Feb'
		,	dataIndex	:'feb'
		},{
			header		:'Mar'
		,	dataIndex	:'mar'
		},{
			header		:'Apr'
		,	dataIndex	:'apr'
		},{
			header		:'Mei'
		,	dataIndex	:'may'
		},{
			header		:'Jun'
		,	dataIndex	:'jun'
		},{
			header		:'Jul'
		,	dataIndex	:'jul'
		},{
			header		:'Agu'
		,	dataIndex	:'aug'
		},{
			header		:'Sep'
		,	dataIndex	:'sep'
		},{
			header		:'Okt'
		,	dataIndex	:'oct'
		},{
			header		:'Nov'
		,	dataIndex	:'nov'
		},{
			header		:'Des'
		,	dataIndex	:'dec'
		}]
	,	defaults	:{
			editor		:this.form_number
		,	align		:'center'
		,	sortable	:true
		,	hideable	:false
		,	width		:50
		}
	});

	this.form_year = new Ext.ux.form.SpinnerField ({
		width			:100
	,	minValue		:1990
	,	maxValue		:2100
	,	allowBlank		:false
	,	editable		:false
	});

	this.form_month = new Ext.form.ComboBox({
		store		:new Ext.data.ArrayStore({
			fields	:['id','name']
		,	data	:k3pl_months
		})
	,	valueField	:'id'
	,	displayField	:'name'
	,	mode		:'local'
	,	triggerAction	:'all'
	,	typeAhead	:true
	,	width		: 100
	});

	this.form_target = new Ext.form.NumberField({
		minValue	:0
	,	value		:2
	,	allowDecimals	:false
	,	allowNegative	:false
	,	width		:50
	});

	this.btn_ref = new Ext.Button({
		text	:'Refresh'
	,	iconCls	:'refresh16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_load();
		}
	});

	this.btn_save = new Ext.Button({
		text	:'Simpan'
	,	iconCls	:'save16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_save();
		}
	});

	this.btn_set_all = new Ext.Button({
		text	:'Set all'
	,	iconCls	:'save16'
	,	scope	:this
	,	handler	:function()
		{
			this.do_set_all();
		}
	});

	this.panel = new Ext.grid.EditorGridPanel({
		title		:'Target Partisipasi RCA Pegawai'
	,	id		:'rca_target_pegawai_panel'
	,	store		:this.store
	,	cm		:this.cm
	,	autoScroll	:true
	,	autoWidth	:true
	,	stripeRows	: true
	,	columnLines	: true
	,	viewConfig	:{
			forceFit		:true
		,	scrollOffset	:50
		}
	,	tbar		:[
			' Tahun : '
		,	this.form_year
		,	'-'
		,	this.btn_ref
		,	'->'
		,	this.btn_save
		]
	,	bbar		:[
			' Bulan : '
		,	this.form_month
		,	'-'
		,	' Target : '
		,	this.form_target
		,	'-'
		,	this.btn_set_all
		]
	});

	this.do_set_all = function()
	{
		var m = this.form_month.getValue();
		var v = this.form_target.getValue();

		this.store.each(function(r) {
			switch (m) {
			case 1:
				r.set('jan', v);
				break;
			case 2:
				r.set('feb', v);
				break;
			case 3:
				r.set('mar', v);
				break;
			case 4:
				r.set('apr', v);
				break;
			case 5:
				r.set('may', v);
				break;
			case 6:
				r.set('jun', v);
				break;
			case 7:
				r.set('jul', v);
				break;
			case 8:
				r.set('aug', v);
				break;
			case 9:
				r.set('sep', v);
				break;
			case 10:
				r.set('oct', v);
				break;
			case 11:
				r.set('nov', v);
				break;
			case 12:
				r.set('dec', v);
				break;
			}
		}, this);
	}

	this.do_save = function()
	{
		var data	= "[";
		var mods	= this.store.getModifiedRecords();
		var changes;
		var i,j;

		main_load.show();

		for (i = 0; i < mods.length; i++) {
			if (i > 0) {
				data += ",";
			}

			data	+="{ nipg: '"+ mods[i].get('nipg') +"' "
				+ ", cols: {";

			changes = mods[i].getChanges();
			j = 0;
			Ext.iterate(changes, function(k,v) {
				if (j > 0) {
					data += ",";
				} else {
					j = 1;
				}

				data += k +":'"+ v +"'";
			});

			data +="}}";
		}
		data +="]";

		Ext.Ajax.request({
			url	: m_rca_target_peg_d +'submit.jsp'
		,	params	: {
				year	: this.form_year.getValue()
			,	rows	: data
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	scope	: this
		,	failure	: function(response) {
				Ext.Msg.alert('Gagal', response.responseText);
				main_load.hide();
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				main_load.hide();

				if (msg.success == false) {
					Ext.Msg.alert('Kesalahan', msg.info);
				} else {
					Ext.Msg.alert('Informasi', msg.info);
					this.do_load();
				}
			}
		});
	}

	this.do_load = function()
	{
		this.store.load({
			scope	:this
		,	params	:{
				year	:this.form_year.getValue()
			}
		});
	}

	this.do_refresh = function()
	{
		this.form_year.setValue(new Date ().getFullYear());
		this.do_load();
	}
}

m_rca_target_pegawai = new M_RCATargetPegawai();

//@ sourceURL=rca_target_pegawai.layout.js
