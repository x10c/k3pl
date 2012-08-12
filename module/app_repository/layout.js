var m_app_repository;
var m_app_repository_d = _g_root +'/module/app_repository/';

function AppRepository ()
{
	this.btn_save = new Ext.Button ({
			text		: 'Simpan' 
		,	iconCls		: 'save16'
		,	scope		: this
		,	handler		: function()
			{
				this.do_save ();
			} 
		});

	this.field_repo_size = new Ext.form.NumberField ({
			itemId			: 'repo_max_file_size'
		,	name			: 'repo_max_file_size'
		,	fieldLabel		: 'Ukuran maksimum upload (MB)'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	minValue		: 1
		});

	this.panel = new Ext.form.FormPanel ({
			itemId		: "app_repository_panel"
		,	title		: "Pengaturan Repository"
		,	labelAlign	: "right"
		,	labelWidth	: 210
		,	padding		: 6
		,	url			: m_app_repository_d +'/submit.jsp'
		,	tbar		: [
				this.btn_save
			]
		,	items		: [
				this.field_repo_size
			]
		});

	this.do_refresh = function (ha_level)
	{
		if (ha_level <= 0) {
			return;
		}
		if (ha_level < 3) {
			this.btn_save.setDisabled (true);
		} else {
			this.btn_save.setDisabled (false);
		}

		var form = this.panel.getForm ();

		form.load ({
			url		: m_app_repository_d +'/data.jsp'
		});
	}

	this.do_save = function ()
	{
		var form = this.panel.getForm ();

		if (! form.isValid ()) {
			return;
		}

		form.submit ();
	}
}

m_app_repository = new AppRepository ();
