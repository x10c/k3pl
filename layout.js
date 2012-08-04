/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

$(document).ready(function() {
	// Featured Slider
	$('.image-display').cycle({
		fx					:'scrollUp'
	,	pager				:'.image-list'
	,	timeout				:_g_gallery_delay
	,	pagerAnchorBuilder	:function (idx, slide) {
			return '<img src="'+ slide.src +'" width=50 height=50/>';
		}
	});

	$(".right p a").hover(
		function() {
			$(this).stop().animate({
				paddingLeft		:'10'
			,	paddingRight	:'10'
			},{
				duration		:'700'
			,	easing			:'easeInSine'
			});
			return true;
		}
	,	function () {
			$(this).stop().animate(
			{
				paddingLeft	:'0'
			,	paddingRight	:'0'
			},{
				duration	:'700'
			,	easing		:'easeOutSine'
			});
		}
	);

	$('.horizontal_scroller').SetScroller({
		velocity	:60
	,	direction	:'horizontal'
	,	startfrom	:'right'
	,	loop		:'infinite'
	,	movetype	:'linear'
	,	onstartup	:'play'
	,	cursor		:'pointer'
	});

	charts_init();
});

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

function charts_init()
{
	this.store_charts = new Ext.data.ArrayStore({
		fields	:['id','name']
	,	data	:[
			[-1	,'(Auto Refresh)']
		,	[0	,'Grafik Persentasi Partisipasi STOP']
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
	,	width			: 200
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

	m_charts = new M_Charts();

	m_charts.panel.setHeight(400);
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

