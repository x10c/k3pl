/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - prasetya (mieh100freak@gmail.com)
 */

var m_lap_rangkuman_keg;
var m_lap_input_kegiatan_master;
var m_lap_kegiatan_master;
var m_lap_kegiatan_detail;
var m_lap_input_area_perhatian_master;
var m_lap_area_perhatian_master;
var m_lap_area_perhatian_detail;
var m_lap_kegiatan_tahun = '';
var m_lap_kegiatan_bulan = '';
var m_lap_area_perhatian_tahun = '';
var m_lap_area_perhatian_bulan = '';
var m_lap_kegiatan_ha_level = 0;

function M_LapKegiatanMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
		{
			name	: 'tahun'
		},{
			name	: 'bulan'
		},{
			name	: 'nama_bulan'
		},{
			name	: 'is_audit'
		},{
			name	: 'is_pelatihan'
		},{
			name	: 'is_rapat'
		},{
			name	: 'is_inspeksi'
		},{
			name	: 'is_jsa'
		},{
			name	: 'is_institusi'
		},{
			name	: 'is_investigasi'
		},{
			name	: 'is_pemantauan'
		},{
			name	: 'is_lainnya'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/lap_rangkuman_keg/data_list_kegiatan_master.jsp'
		,	autoLoad: false
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ id		: 'tahun'
			, header	: 'Tahun'
			, dataIndex	: 'tahun'
			, align		: 'center'
			, width		: 100
			, sortable	: true
			}
		,	{ id		: 'nama_bulan'
			, header	: 'Bulan'
			, dataIndex	: 'nama_bulan'
			, align		: 'center'
			, width		: 150
			, sortable	: true
			}
		]
	,	defaults	: {
			hideable	: false
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						m_lap_kegiatan_tahun = data[0].data['tahun'];
						m_lap_kegiatan_bulan = data[0].data['bulan'];
						this.btn_print.setDisabled(false);
					} else {
						m_lap_kegiatan_tahun = '';
						m_lap_kegiatan_bulan = '';
						this.btn_print.setDisabled(true);
					}
				}
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

	this.btn_print = new Ext.Button({
			text		: 'Print'
		,	iconCls		: 'print16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});
		
	this.grid = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	cm			: this.cm
		,	sm			: this.sm
		,	autoScroll	: true
		, 	autoHeight	: true
		,	tbar		: [this.btn_ref,'->',this.btn_print]
	});

	this.do_print = function(){
		var form;
		form = document.createElement('form');
		
		form.setAttribute('method', 'post');
		form.setAttribute('action', _g_root +'/module/lap_rangkuman_keg/data_lapkeg_export.jsp');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'tahun');
        hiddenField1.setAttribute('value', m_lap_kegiatan_tahun);
		
		var hiddenField2 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField2.setAttribute('name', 'bulan');
        hiddenField2.setAttribute('value', m_lap_kegiatan_bulan);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		document.body.appendChild(form);
		form.submit();
	}

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function()
	{
		this.do_load();
	}
}

function M_LapKegiatanK3PL()
{
	m_lap_kegiatan_master				= new M_LapKegiatanMaster('Data Kegiatan K3PL Master');

	this.panel = new Ext.Panel({
			id				: 'lap_rangkuman_keg_panel'
		,	autoScroll		: true
		,	region			: 'center'
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    		}
        ,	items		: [
				m_lap_kegiatan_master.grid
			]
    });
	
	this.do_refresh = function(ha_level)
	{
		m_lap_kegiatan_ha_level		= ha_level;
		m_lap_kegiatan_tahun 		= '';
		m_lap_kegiatan_bulan 		= '';

		m_lap_kegiatan_master.do_refresh();
	}
}

m_lap_rangkuman_keg = new M_LapKegiatanK3PL();

//@ sourceURL=lap_rangkuman_keg.layout.js
