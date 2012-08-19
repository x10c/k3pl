/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_rca_grafik_performance;

function M_RCAGrafikPerformance()
{
	this.ha_level		= 0;
	this.id_direktorat	= 0;
	this.id_divprosbu	= 0;
	this.tahun_1		= 0;
	this.tahun_2		= 0;
	this.tahun_3		= 0;
	this.bulan_1		= 0;
	this.bulan_2		= 0;
	this.bulan_3		= 0;
	this.year			= (new Date).getFullYear();

	this.store_direktorat = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_direktorat.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_divprosbu = new Ext.data.ArrayStore({
			fields		: ['id_direktorat', 'id', 'name']
		,	url			: _g_root +'/module/ref_organisasi/data_divprosbu.jsp'
		,	idIndex		: 1
		,	autoLoad	: false
	});

	this.form_direktorat = new Ext.form.ComboBox({
			store			: this.store_direktorat
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	fieldLabel		: 'Direktorat'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 300
		,	listWidth		: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.form_direktorat_on_select(record.get('id'));
				}
			}
	});

	this.form_divprosbu = new Ext.form.ComboBox({
			store			: this.store_divprosbu
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	fieldLabel		: 'Divisi/Proyek/SBU'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 300
		,	listWidth		: 400
		,	listeners		: {
				scope	: this
			,	select	: function(cb, record, index) {
					this.id_divprosbu	= record.get('id');
				}
			}
	});
	
	this.store_month = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [[1,'Januari'],
					   [2,'Februari'],
					   [3,'Maret'],
					   [4,'April'],
					   [5,'Mei'],
					   [6,'Juni'],
					   [7,'Juli'],
					   [8,'Agustus'],
					   [9,'September'],
					   [10,'Oktober'],
					   [11,'November'],
					   [12,'Desember']]
		});

	this.form_month = new Ext.form.ComboBox({
			store			: this.store_month
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	fieldLabel		: 'Bulan'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		});

	this.form_month.setValue(this.store_month.getAt(0).data['id']);		

	this.get_form_year_data = function()
	{
		var d			= new Date();
		var cur_year	= d.getFullYear();
		var years		= '[["'+ cur_year +'"]';

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
		,	fieldLabel		: 'Tahun'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		});

	this.form_year.setValue(this.store_year.getAt(0).data['year']);

	this.store_jenis = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				[1, 'Grafik Partisipasi RCA']
			,	[2, 'Grafik Severity 4/5']
			,	[3, 'Grafik Tindak Lanjut Temuan 4/5']
			,	[4, 'Grafik Tindak Lanjut Temuan Non 4/5']
			]
		});

	this.form_jenis = new Ext.form.ComboBox({
			store			: this.store_jenis
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	fieldLabel		: 'Jenis Grafik'
		,	mode			: 'local'
		,	allowBlank		: false
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 250
	});
	
	this.form_jenis.setValue(this.store_jenis.getAt(0).data['id']);
	
	this.btn_print = new Ext.Button({
			text	: 'Print'
		,	iconCls	: 'print16'
		,	scope	: this
		,	handler	: function() {
				this.do_print();
			}
		});

	this.panel_form = new Ext.form.FormPanel({
		autoHeight	: true
	,	buttonAlign	: 'center'
	,	frame		: true
	,	labelWidth	: 150
	,	labelAlign	: 'right'
	,	width		: 500
	,	buttons		: [
			this.btn_print
		]
	,	items		:[
			this.form_direktorat
		,	this.form_divprosbu
		,	this.form_month
		,	this.form_year
		,	this.form_jenis
		]
	});

	this.panel = new Ext.Panel({
		id			: 'rca_grafik_performance_panel'
	,	title		: 'GRAFIK PERFORMANSI RCA'
	,	autoScroll	: true
	,	defaults	:{
			style		:{
					marginLeft		: 'auto'
				,	marginRight		: 'auto'
				,	marginBottom	: '8px'
			}
		}
	,	items		: [
			this.panel_form
		]
	});

	this.do_print = function()
	{
		this.tahun_1	= this.form_year.getValue();
		this.bulan_1	= this.form_month.getValue();
		
		if (this.bulan_1 == 1){
			this.tahun_2 = this.tahun_1 - 1;
			this.bulan_2 = 12;
			this.tahun_3 = this.tahun_1 - 1;
			this.bulan_3 = 11;
		} else if(this.bulan_1 == 2){
			this.tahun_2 = this.tahun_1;
			this.bulan_2 = this.bulan_1 - 1;
			this.tahun_3 = this.tahun_1 - 1;
			this.bulan_3 = 12;
		} else {
			this.tahun_2 = this.tahun_1;
			this.bulan_2 = this.bulan_1 - 1;
			this.tahun_3 = this.tahun_1;
			this.bulan_3 = this.bulan_1 - 2;
		}
		
		var form;
		var id_report	= '20';
		var tipe_report	= 'doc';
		
		switch(this.form_jenis.getValue()){
			case 1	:
				id_report	= '20';
				break;
			case 2	:
				id_report	= '21';
				break;
			case 3	:
				id_report	= '22';
				break;
			case 4	:
				id_report	= '34';
				break;
		}

		form = document.createElement('form');

		form.setAttribute('method', 'post');
		form.setAttribute('target', '_blank');		
		form.setAttribute('action', _g_root +'/report');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'id');
        hiddenField1.setAttribute('value', id_report);
		
		var hiddenField2 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField2.setAttribute('name', 'type');
        hiddenField2.setAttribute('value', tipe_report);

		var hiddenField3 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField3.setAttribute('name', 'year_1');
        hiddenField3.setAttribute('value', this.tahun_1);
		
		var hiddenField4 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField4.setAttribute('name', 'year_2');
        hiddenField4.setAttribute('value', this.tahun_2);
		
		var hiddenField5 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField5.setAttribute('name', 'year_3');
        hiddenField5.setAttribute('value', this.tahun_3);
		
		var hiddenField6 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField6.setAttribute('name', 'month_1');
        hiddenField6.setAttribute('value', this.bulan_1);
		
		var hiddenField7 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField7.setAttribute('name', 'month_2');
        hiddenField7.setAttribute('value', this.bulan_2);
		
		var hiddenField8 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField8.setAttribute('name', 'month_3');
        hiddenField8.setAttribute('value', this.bulan_3);
		
		var hiddenField9 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField9.setAttribute('name', 'id_dir');
        hiddenField9.setAttribute('value', this.id_direktorat);
		
		var hiddenField10 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField10.setAttribute('name', 'id_div');
        hiddenField10.setAttribute('value', this.id_divprosbu);
				
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
		form.appendChild(hiddenField4);
		form.appendChild(hiddenField5);
		form.appendChild(hiddenField6);
		form.appendChild(hiddenField7);
		form.appendChild(hiddenField8);
		form.appendChild(hiddenField9);
		form.appendChild(hiddenField10);
		document.body.appendChild(form);
		form.submit();
	}
	
	this.form_direktorat_on_select = function(id_direktorat)
	{
		this.id_direktorat = id_direktorat;

		this.form_divprosbu.clearFilter(true);
		this.form_divprosbu.filterBy(function (r, id)
		{
			var id_dir	= r.get('id_direktorat');
			var id_div	= r.get('id');

			if (id_dir	== 0
			|| id_div	== 0
			|| id_dir	== this.id_direktorat) {
				return true;
			}
			return false;
		}
		, this);

		this.form_divprosbu.setValue(this.store_divprosbu.getAt(0).get('id'));
	}

	this.do_load = function()
	{
		this.store_direktorat.load({
				scope		: this
			,	callback	: function(){
					var record_all_direktorat = new Ext.data.Record ({
							id		: 0
						,	name	: 'Semua Direktorat'
					});
								
					this.store_direktorat.insert(0, record_all_direktorat);

					if (this.store_direktorat.getTotalCount() > 0) {
						this.form_direktorat.setValue(this.store_direktorat.getAt(0).get('id'));
					}

					this.store_divprosbu.load({
							scope		: this
						,	params		: {
								id_direktorat	: this.id_direktorat
							}
						,	callback	:  function(){
								var record_all_divprosbu = new Ext.data.Record ({
										id_direktorat	: 0
									,	id				: 0
									,	name			: 'Semua Divisi/Proyek/SBU'
								});
											
								this.store_divprosbu.insert(0, record_all_divprosbu);
								
								if (this.store_divprosbu.getTotalCount() > 0) {
									this.form_divprosbu.setValue(this.store_divprosbu.getAt(0).get('id'));
								}
							}
					});
				}
		});		
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level	= ha_level;

		if (ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses'
			, 'Maaf, Anda tidak memiliki hak akses untuk melihat Grafik Performance RCA!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
			
			this.do_load();
		}
	}
}

m_rca_grafik_performance = new M_RCAGrafikPerformance()

//@ sourceURL=rca_grafik_performance.layout.js
