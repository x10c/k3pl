/**
 * Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 *
 * Author(s):
 * + PT. Awakami
 *   - m.shulhan (ms@kilabit.org)
 */

var _g_form_login;

function M_Login()
{
	this.tf_user = new Ext.form.TextField({
			name		: 'nipg'
		,	fieldLabel	: '<b>NIPG</b>'
		,	allowBlank	: false
		,	blankText	: 'NIPG harus di isi'
		,	plugins		: [ Ext.ux.FieldLabeler ]
		});

	this.tf_pass = new Ext.form.TextField({
			name		: 'password'
		,	fieldLabel	: '<b>Kata Kunci</b>'
		,	allowBlank	: false
		,	blankText	: 'Kata Kunci harus di isi'
		,	inputType	: 'password'
		,	plugins		: [ Ext.ux.FieldLabeler ]
		,	listeners	: {
				specialkey	:
					function(field, e) {
						if (e.getKey() === e.ENTER) {
							this.do_login();
						}
					}
			,	scope		: this
			}
		});

	this.btn_login = new Ext.Button({
			text	: '<b>Masuk</b>'
		,	handler	:
				function() {
					this.do_login();
				}
		,	scope	: this
		});

	this.form = new Ext.form.FormPanel({
			baseCls		: 'x-plain'
		,	labelAlign	: 'top'
		,	layout		: {
				type	: 'vbox'
			,	align	: 'stretch'  // Child items are stretched to full width
			}
		,	items		: [
				this.tf_user
			,	this.tf_pass
			]
		});

	this.win = new Ext.Window({
			title		: "<div style='text-align: center; font-size: 12;'> Pengesahan Pemakai </div>"
		,	width		: 250
		,	height		: 200
		,	closable	: false
		,	resizable	: false
		,	draggable	: false
		,	plain		: true
		,	layout		: 'fit'
		,	bodyStyle	: 'padding:5px;'
		,	items		: this.form
		,	buttonAlign	: 'center'
		,	buttons		: [
				this.btn_login
			]
		});

	this.do_login = function() {
		if (! this.form.form.isValid()) {
			Ext.MessageBox.alert('Kesalahan'
				, 'NIPG dan Kata Kunci harus di isi');
			return;
		}

		var pass = Sha256.hash(this.tf_pass.getValue(), true);

		Ext.Ajax.request({
			url	: _g_root +'/module/login/submit.jsp'
		,	params	: {
				nipg	: this.tf_user.getValue()
			,	pass	: pass
			}
		,	waitMsg	: 'Pemuatan ...'
		,	failure	:
				function(form, action) {
					Ext.MessageBox.alert('Kesalahan', action.result.errorInfo);
				}
		,	success	:
				function(response) {
					var res = Ext.util.JSON.decode(response.responseText);

					if (res.success == false) {
						Ext.MessageBox.alert('Kesalahan'
								, res.info);
					} else {
						this.hide();
						window.location = _g_root +'/module/main/index.jsp';
					}
				}
		,	scope	: this
		});
	}

	this.show = function() {
		this.win.show();
	}

	this.hide = function() {
		this.win.hide();
	}
}

Ext.onReady(
function() {
	if (typeof _g_form_login == 'undefined') {
		_g_form_login = new M_Login();
	}

	_g_form_login.show();
});

//@ sourceURL=login.layout.js
