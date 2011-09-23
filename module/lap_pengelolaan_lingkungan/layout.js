/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_lap_pengelolaan_lingkungan;

function M_LapPengelolaanLingkungan()
{
	this.ha_level	= 0;
	this.year		= (new Date).getFullYear();

	this.store_month = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [['1','Januari'],
					   ['2','Februari'],
					   ['3','Maret'],
					   ['4','April'],
					   ['5','Mei'],
					   ['6','Juni'],
					   ['7','Juli'],
					   ['8','Agustus'],
					   ['9','September'],
					   ['10','Oktober'],
					   ['11','November'],
					   ['12','Desember']]
		});

	this.form_month = new Ext.form.ComboBox({
			store			: this.store_month
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		});

	this.form_month.setValue(this.store_month.getAt(0).data['id']);		

	this.form_month_label = new Ext.form.Label({
			html	: '<b>Bulan :</b>&nbsp;&nbsp;'
		});
	
	this.get_form_year_data = function()
	{
		var d		= new Date();
		var cur_year	= d.getFullYear();
		var years	= '[["'+ cur_year +'"]';

		for(var i=1; i<=10; i++) {
			years += ',["'+ (cur_year - i) +'"]';
		}

		years += ']';

		return Ext.util.JSON.decode(years);
	}

	this.store_year = new Ext.data.ArrayStore({
		fields	: ['year']
	,	data	: this.get_form_year_data()
	});

	this.form_year = new Ext.form.ComboBox({
			store			: this.store_year
		,	valueField		: 'year'
		,	displayField	: 'year'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		});

	this.form_year.setValue(this.store_year.getAt(0).data['year']);

	this.form_year_label = new Ext.form.Label({
			html	: '<b>Tahun :</b>&nbsp;&nbsp;'
		});

	this.btn_proses = new Ext.Button({
			text	: 'Filter'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_proses(this.form_year.getValue(),this.form_month.getValue());
			}
		});

	this.store = new Ext.data.ArrayStore({
			fields	: [
			  'nama_wilayah'
			, 'lokasi_pengelolaan_lingkungan'
			, 'tipe_station'
			, 'parameter'
			, 'sumber_dampak'
			]
		,	url	: _g_root +'/module/lap_pengelolaan_lingkungan/data.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,{
			header		: 'Wilayah'
		,	dataIndex	: 'nama_wilayah'
		,	width		: 200
		},{
			header		: 'Lokasi'
		,	dataIndex	: 'lokasi_pengelolaan_lingkungan'
		,	width		: 200
		,	css			: 'background-color: #f0f0f0;'
		},{
			header		: 'Tipe Station'
		,	dataIndex	: 'tipe_station'
		,	width		: 200
		},{
			header		: 'Parameter Yang Diambil'
		,	dataIndex	: 'parameter'
		,	width		: 200
		,	css			: 'background-color: #f0f0f0;'
		},{
			header		: 'Sumber Dampak'
		,	dataIndex	: 'sumber_dampak'
		,	width		: 200
		}]
	,	defaults : {
			hideable	: false
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});
	
	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});

	this.panel = new Ext.grid.GridPanel({
		id					: 'lap_pengelolaan_lingkungan_panel'
	,	title				: 'Laporan Pengelolaan Lingkungan'
	,	store				: this.store
	,	cm					: this.cm
	,	autoHeight			: true
	,	autoScroll			: true
	,	autoExpandColumn	: 'sumber_dampak'
	,	viewConfig			: {forceFit: true}
	,	tbar		: [
			this.form_month_label
		,	this.form_month
		,	'-'
		,	this.form_year_label
		,	this.form_year
		,	'-'
		,	this.btn_proses
		,	'->'
		,	this.btn_print
		]
	});
	
	this.do_print = function(){
		var form;
		form = document.createElement('form');
		
		form.setAttribute('method', 'post');
		form.setAttribute('action', _g_root +'/module/lap_pengelolaan_lingkungan/data_lingkungan_export.jsp');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'year');
        hiddenField1.setAttribute('value', this.year);
		
		var hiddenField2 = document.createElement ('input');
        hiddenField2.setAttribute('type', 'hidden');
        hiddenField2.setAttribute('name', 'month');
        hiddenField2.setAttribute('value', this.month);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		document.body.appendChild(form);
		form.submit();
	}

	this.do_proses = function(year, month)
	{
		this.year		= year;
		this.month		= month;
		
		this.store.load({
			scope	: this
		,	params	: {
				year	: year
			,	month	: month
			}
		});
		this.btn_print.setDisabled(false);
	}
	
	this.do_refresh = function(ha_level)
	{
		this.ha_level	= ha_level;

		if (ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses'
			, 'Maaf, Anda tidak memiliki hak akses untuk Laporan Pengelolaan Lingkungan!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}
		
		this.btn_print.setDisabled(true);
	}
}

m_lap_pengelolaan_lingkungan = new M_LapPengelolaanLingkungan()

//@ sourceURL=lap_pengelolaan_lingkungan.layout.js
