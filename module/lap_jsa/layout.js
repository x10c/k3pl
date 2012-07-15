/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *	 - agus sugianto (agus.delonge@gmail.com)
 */

var m_lap_jsa;
var m_lap_jsa_master;
var m_lap_jsa_id_jsa	= '';
var m_lap_jsa_ha_level	= 0;

function M_LapJSAMaster(title)
{
	this.title	= title;
	this.dml_type	= ''

	this.record = new Ext.data.Record.create([
		{
			name	: 'id_jsa'
		},{
			name	: 'no_dokumen'
		},{
			name	: 'revisi'
		},{
			name	: 'no_kontrak'
		},{
			name	: 'nama_perusahaan'
		},{
			name	: 'nama_proyek'
		},{
			name	: 'nama_pic'
		},{
			name	: 'aktifitas_pekerjaan'
		},{
			name	: 'tanggal_jsa'
		},{
			name	: 'alat_pelindung_diri_digunakan'
		}
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url	: _g_root +'/module/lap_jsa/data_jsa_master.jsp'
		,	autoLoad: false
	});

	this.form_no_dokumen = new Ext.form.TextField({
			allowBlank	: false
	});

	this.form_revisi = new Ext.form.TextField({
	});

	this.form_no_kontrak = new Ext.form.TextField({
	});

	this.form_nama_perusahaan = new Ext.form.TextField({
	});

	this.form_nama_proyek = new Ext.form.TextField({
	});

	this.form_nama_pic = new Ext.form.TextField({
	});

	this.form_aktifitas_pekerjaan = new Ext.form.TextArea({
	});

	this.form_tanggal_jsa = new Ext.form.DateField({
			emptyText	: 'Y-m-d'
		,	format		: 'Y-m-d'
		,	editable	: false
	});

	this.form_alat_pelindung_diri_digunakan = new Ext.form.TextArea({
	});
		
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id		: 'no_dokumen'
			, header	: 'No.Dokumen'
			, dataIndex	: 'no_dokumen'
			, sortable	: true
			, width		: 200
			}
		,	{ id		: 'revisi'
			, header	: 'Revisi'
			, dataIndex	: 'revisi'
			, sortable	: true
			, width		: 50
			}
		,	{ id		: 'no_kontrak'
			, header	: 'No.Kontrak'
			, dataIndex	: 'no_kontrak'
			, sortable	: true
			, width		: 200
			}
		,	{ id		: 'nama_perusahaan'
			, header	: 'Nama Perusahaan'
			, dataIndex	: 'nama_perusahaan'
			, sortable	: true
			, width		: 300
			}
		,	{ id		: 'nama_proyek'
			, header	: 'Nama Proyek'
			, dataIndex	: 'nama_proyek'
			, sortable	: true
			, width		: 300
			}
		,	{ id		: 'nama_pic'
			, header	: 'Nama PIC'
			, dataIndex	: 'nama_pic'
			, sortable	: true
			, width		: 300
			}
		,	{ id		: 'aktifitas_pekerjaan'
			, header	: 'Aktifitas Pekerjaan'
			, dataIndex	: 'aktifitas_pekerjaan'
			, sortable	: true
			, width		: 400
			}
		,	{ id		: 'tanggal_jsa'
			, header	: 'Tanggal JSA'
			, dataIndex	: 'tanggal_jsa'
			, sortable	: true
			, width		: 100
			, align		: 'center'
			}
		,	{ id		: 'alat_pelindung_diri_digunakan'
			, header	: 'Alat Pelindung Diri Digunakan'
			, dataIndex	: 'alat_pelindung_diri_digunakan'
			, sortable	: true
			, width		: 400
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length) {
						if (m_lap_jsa_ha_level == 4) {
							this.btn_print.setDisabled(false);
						}
						m_lap_jsa_id_jsa = data[0].data['id_jsa'];
					} else {
						this.btn_print.setDisabled(true);
						m_lap_jsa_id_jsa = '';
					}

				}
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

	this.btn_print = new Ext.Button({
			text		: ' Print'
		,	iconCls		: 'print16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_print();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_print
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	tbar				: this.toolbar
		,	collapsible			: true
		,   listeners       	: {
				scope		: this
			,	rowclick	:
					function (g, r, e) {
						return this.do_edit(r);
					}
            }
	});
	
	this.do_print = function(){
		var form;
		var id_report	= '18';
		var tipe_report	= 'doc';

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
		hiddenField3.setAttribute('name', 'id_jsa');
        hiddenField3.setAttribute('value', m_lap_jsa_id_jsa);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
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

function M_LapJSA()
{
	m_lap_jsa_master	= new M_LapJSAMaster('Job Safety Analysis');

	this.panel = new Ext.Panel({
			id				: 'lap_jsa_panel'
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_lap_jsa_master.grid
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_lap_jsa_ha_level	= ha_level;
		m_lap_jsa_id_jsa 	= '';

		m_lap_jsa_master.do_refresh();
	}
}

m_lap_jsa = new M_LapJSA();

//@ sourceURL=lap_jsa.layout.js
