/*
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	+ PT. Awakami
		- mhd.sulhan (ms@kilabit.org)
 */

function form_charts_on_select(r, id)
{
	if (id == 0 || id == undefined) {
		charts_start();
	} else {
		var cid = r.get('id');

		charts_stop();

		m_charts.panel.charts[cid].do_refresh();
		m_charts.panel.layout.setActiveItem(cid);
	}
}

function form_sbu_on_select (r, id)
{
	m_charts_id_div = r.get ('id');
	charts_start ();
}

function charts_init()
{
	this.store_charts = new Ext.data.ArrayStore({
		fields	:['id','name']
	,	data	:[
			[-1	,'(Auto Refresh)']
		,	[0	,'Grafik Persentasi Partisipasi Observasi']
		,	[1	,'Grafik Persentasi Partisipasi RCA']
		,	[2	,'Grafik Performansi per Kategori']
		,	[3	,'Grafik Safe/Unsafe Index']
		,	[4	,'Grafik Safe/Unsafe per Hour']
		,	[5	,'Grafik Jam Kerja Aman Kumulatif']
		,	[6	,'Grafik LTIF']
		,	[7	,'Grafik TSAF']
		]
	});

	this.form_charts = new Ext.form.ComboBox({
		store			: this.store_charts
	,	value			: -1
	,	valueField		: 'id'
	,	displayField	: 'name'
	,	width			: 240
	,	listWidth		: 240
	,	allowBlank		: false
	,	editable		: false
	,	triggerAction	: 'all'
	,	mode			: 'local'
	,	listeners		: {
			scope			: this
		,	select			: function (cb, record, id) {
				form_charts_on_select(record, id);
			}
		}
	});

	this.form_sbu = new k3pl.form.DivProSBU ({
		itemAll		:true
	,	listeners	: {
			scope		: this
		,	select		: function (cb, record, id) {
				form_sbu_on_select (record, id);
			}
		}
	});

	this.form_sbu.do_load ();

	m_charts = new M_Charts();

	m_charts.panel.setHeight(400);
	m_charts.panel.getTopToolbar().add(this.form_sbu);
	m_charts.panel.getTopToolbar().add('->');
	m_charts.panel.getTopToolbar().add(this.form_charts);

	m_charts.panel.render('main_charts');
	m_charts.panel.doLayout();

	charts_start();
}

function call_do_login(){
	var pass = Sha256.hash(document.login_form.password.value, true);

	Ext.Ajax.request({
		url	: _g_root +'/module/login/submit.jsp'
	,	params	: {
			nipg	: document.login_form.nipg.value
		,	pass	: pass
		}
	,	waitMsg	: 'Pemuatan ...'
	,	failure	: function(form, action) {
			Ext.MessageBox.alert('Kesalahan', action.result.errorInfo);
		}
	,	success	: function(response) {
			var res = Ext.util.JSON.decode(response.responseText);

			if (res.success == false) {
				Ext.MessageBox.alert('Kesalahan', res.info);
			} else {
				charts_stop();
				window.location = _g_root +'/module/main/index.jsp';
			}
		}
	});
}

function form_pass_on_keydown(e)
{
	var keycode;

	if (window.event) {
		keycode = e.keyCode;
	} else if (e.which) {
		keycode = e.which;
	}

	if (keycode != 13) {
		return;
	}

	call_do_login();
}

Ext.onReady (function() {
	new Ext.ux.Carousel ('slideshow', {
		itemSelector		:'img'
	,	interval			:_g_gallery_delay || 5
	,	autoPlay			:true
	,	showPlayButton		:true
	,	pauseOnNavigate		:true
	,	freezeOnHover		:true
	,	transitionType		:'fade'
	,	navigationOnHover	:true
	});

	charts_init ();
});
