/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var m_luk_var;
var m_luk_var_d = _g_root +'/module/luk_var/';

function M_LUKVar()
{
	this.reader = new Ext.data.JsonReader({
		root	:'r_k3pl'
	,	fields	:[
			{name:'target_tsaf'}
		,	{name:'target_ltif'}
		,	{name:'reset_jt_min_kecelakaan'}
		,	{name:'reset_jt_min_nilai_rusak'}
		]
	});

	this.store = new Ext.data.Store({
		url	:m_luk_var_d +'data.jsp'
	,	reader	:this.reader
	,	autoLoad:false
	});

	this.form_target_tsaf = new Ext.form.NumberField({
		fieldLabel	:'Target TSAF'
	,	labelSeparator	:' = '
	,	allowDecimals	:true
	,	allowNegative	:false
	,	minValue	:'0.0'
	});

	this.form_target_ltif = new Ext.form.NumberField({
		fieldLabel	:'Target LTIF'
	,	labelSeparator	:' = '
	,	allowDecimals	:true
	,	allowNegative	:false
	,	minValue	:'0.0'
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

	this.panel = new Ext.form.FormPanel({
		id		:'luk_var_panel'
	,	title		:'Variabel Unjuk Kerja'
	,	labelAlign	:'right'
	,	padding		:6
	,	items		:[
			this.form_target_tsaf
		,	this.form_target_ltif
		]
	,	tbar		:[
			this.btn_save
		]
	});

	this.do_save = function()
	{
		Ext.Ajax.request({
			url	:m_luk_var_d +'submit.jsp'
		,	params  : {
				target_tsaf 	:this.form_target_tsaf.getValue()
			,	target_ltif	:this.form_target_ltif.getValue()
			}
		,	scope	: this
		,	waitMsg	: 'Mohon Tunggu ...'
		,	success :
				function (response)
				{
					var msg = Ext.util.JSON.decode(response.responseText);

					Ext.MessageBox.alert('Pesan Kesalahan', msg.info);
				}
		});

	}

	this.do_refresh = function(ha_level)
	{
		if (ha_level <= 0) {
			return;
		}
		if (ha_level == 1) {
			this.btn_save.setDisabled(true);
		} else {
			this.btn_save.setDisabled(false);
		}

		this.store.reload({
			scope	:this
		,	callback:function (r,options,success) {
				if (!success || r.length <= 0) {
					return;
				}

				this.form_target_tsaf.setValue(r[0].get('target_tsaf'));
				this.form_target_ltif.setValue(r[0].get('target_ltif'));
			}
		});
	}
}

m_luk_var = new M_LUKVar();

//@ sourceURL=luk_var.layout.js
