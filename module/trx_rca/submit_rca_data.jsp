<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.io.FileUtils"%>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Cookie[]	cookies		= request.getCookies ();
	String		c_name		= "";
	String		user_nipg	= null;
	String		user_name	= null;
	String		user_email	= null;
	String		path		= config.getServletContext().getRealPath("/") +"/repository/rca/";

	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			c_name = cookies[i].getName ();
			if (c_name.equalsIgnoreCase ("user.nipg")) {
				user_nipg = cookies[i].getValue ();
			} else if (c_name.equalsIgnoreCase ("user.name")) {
				user_name = cookies[i].getValue ();
			} else if (c_name.equalsIgnoreCase ("user.email")) {
				user_email = cookies[i].getValue ();
			}
		}
	}

	Statement	db_stmt = db_con.createStatement();

	int			dml							= Integer.parseInt(request.getParameter("dml_type"));
	String		id_rca						= request.getParameter("id_rca");
	String		tanggal_rca					= request.getParameter("tanggal_rca");
	String		auditor_direktorat			= request.getParameter("auditor_direktorat");
	String		auditor_divprosbu			= request.getParameter("auditor_divprosbu");
	String		auditor_departemen			= request.getParameter("auditor_departemen");
	String		auditor_dinas				= request.getParameter("auditor_dinas");
	String		auditor_seksi				= request.getParameter("auditor_seksi");
	String		nama_tempat_rca				= request.getParameter("nama_tempat_rca");
	String		penanggung_jawab_direktorat	= request.getParameter("penanggung_jawab_direktorat");
	String		penanggung_jawab_divprosbu	= request.getParameter("penanggung_jawab_divprosbu");
	String		penanggung_jawab_departemen	= request.getParameter("penanggung_jawab_departemen");
	String		penanggung_jawab_dinas		= request.getParameter("penanggung_jawab_dinas");
	String		penanggung_jawab_seksi		= request.getParameter("penanggung_jawab_seksi");
	String		penanggung_jawab_nipg		= request.getParameter("penanggung_jawab_nipg");
	String		waktu_audit					= request.getParameter("waktu_audit");
	String		lama_audit					= request.getParameter("lama_audit");
	String		cuaca						= request.getParameter("cuaca");
	int			periode						= Integer.parseInt(request.getParameter("periode"));
	int			bulan						= Integer.parseInt(request.getParameter("bulan"));
	int			tahun						= Integer.parseInt(request.getParameter("tahun"));
	JSONArray	auditor						= new JSONArray((String)request.getParameter("auditor"));
	JSONArray	rca_detail					= new JSONArray((String)request.getParameter("rca_detail"));
	int			status	= 0;
	int			jumlah	= 0;
	String		query	= "";
	String		q 		= "";
	String		q2 		= "";
	String		q3		= "";
	int			i,l,k;
	JSONObject	detail;
	ResultSet	rs;

	Date		date	= new Date();

	nama_tempat_rca	= nama_tempat_rca.replace("'", "''");
	cuaca			= cuaca.replace("'", "''");

	switch (dml) {
	case 2:
		id_rca	= Long.toString(date.getTime());

		q	=" insert into t_rca (id_rca, tanggal_rca, auditor_direktorat, auditor_divprosbu, auditor_departemen, auditor_dinas, auditor_seksi,"
			+" nama_tempat_rca, penanggung_jawab_direktorat, penanggung_jawab_divprosbu, penanggung_jawab_departemen, penanggung_jawab_dinas, penanggung_jawab_seksi,"
			+" penanggung_jawab_nipg, waktu_audit, lama_audit, cuaca, id_user)"
			+" values ("+ id_rca +" ,'"+ tanggal_rca +"' ,"+ auditor_direktorat +" ,"+ auditor_divprosbu +" ,"+ auditor_departemen +" ,"+ auditor_dinas +" ,"+ auditor_seksi +" ,"
			+" '"+ nama_tempat_rca +"' ,"+ penanggung_jawab_direktorat +" ,"+ penanggung_jawab_divprosbu +" ,"+ penanggung_jawab_departemen +" ,"+ penanggung_jawab_dinas +" ,"+ penanggung_jawab_seksi +" ,"
			+" '"+ penanggung_jawab_nipg + "' ,'"+ waktu_audit +"' ,"+ lama_audit +" ,'"+ cuaca +"' ,'"+ user_nipg + "')";

		l = auditor.length();
		if (l > 0) {
			q2	=" insert into t_rca_auditor (id_rca, nipg, status, id_user)";
			for (i = 0; i < l; i++) {
				if (periode == 1){
					query	=" select	isnull(count(*),0) as jumlah"
							+" from		t_rca	as a"
							+" where	year(a.tanggal_rca) = " + tahun
							+" and		month(a.tanggal_rca) = " + bulan
							+" and		day(a.tanggal_rca) between 1 and 15"
							+" and		'" + auditor.getString(i) +"' in ("
							+"				select	b.nipg"
							+"				from	t_rca_auditor	as b"
							+"				where	a.id_rca		= b.id_rca"
							+"				)";
							
					rs = db_stmt.executeQuery(query);
					
					if (rs.next()){
						jumlah = rs.getInt("jumlah");
					}
					
					if (jumlah > 0){
						status = 0;
					} else {
						status = 1;
					}
				} else {
					query	=" select	isnull(count(*),0) as jumlah"
							+" from		t_rca	as a"
							+" where	year(a.tanggal_rca) = " + tahun
							+" and		month(a.tanggal_rca) = " + bulan
							+" and		day(a.tanggal_rca) between 16 and 31"
							+" and		'" + auditor.getString(i) +"' in ("
							+"				select	b.nipg"
							+"				from	t_rca_auditor	as b"
							+"				where	a.id_rca		= b.id_rca"
							+"				)";
							
					rs = db_stmt.executeQuery(query);
					
					if (rs.next()){
						jumlah = rs.getInt("jumlah");
					}
					
					if (jumlah > 0){
						status = 0;
					} else {
						status = 2;
					}
				}
				q2	+=" select "+ id_rca
					+",'"+ auditor.getString(i) +"'"
					+","+ status
					+",'"+ user_nipg +"'";

				if (i < (l-1)) {
					q2 +=" union all";
				}
			}
		}

		k = rca_detail.length();
		if (k > 0) {
			q3	=" insert into t_rca_detail (id_rca, description, good_citizens, violators, number_of_violations, id_severity, "
				+" violation_x_severity, li_45, li_apd, li_housekeeping, li_process_safety, li_fire_safety, actions, "
				+" status, completion_date_target, completion_date_actual, note, id_user)";
			for (i = 0; i < k; i++) {
				detail = rca_detail.getJSONObject(i);
				q3	+=" select "+ id_rca
					+",'"+ detail.getString("description") +"'"
					+","+ detail.getString("good_citizens") +""
					+","+ detail.getString("violators") +""
					+","+ detail.getString("number_of_violations") +""
					+","+ detail.getString("id_severity") +""
					+","+ detail.getString("violation_x_severity") +""
					+","+ detail.getString("li_45") +""
					+","+ detail.getString("li_apd") +""
					+","+ detail.getString("li_housekeeping") +""
					+","+ detail.getString("li_process_safety") +""
					+","+ detail.getString("li_fire_safety") +""
					+",'"+ detail.getString("actions") +"'"
					+",'"+ detail.getString("status") +"'"
					+",'"+ detail.getString("completion_date_target") +"'"
					+",'"+ detail.getString("completion_date_actual") +"'"
					+",'"+ detail.getString("note") +"'"
					+",'"+ user_nipg +"'";

				if (i < (k-1)) {
					q3 +=" union all";
				}
			}
		}
		break;

	case 3:
		q	=" update t_rca "
			+" set "
			+"   tanggal_rca					= cast('"+ tanggal_rca +"' as datetime) "
			+" , auditor_direktorat				= "+ auditor_direktorat +" "
			+" , auditor_divprosbu				= "+ auditor_divprosbu +" "
			+" , auditor_departemen				= "+ auditor_departemen +" "
			+" , auditor_dinas					= "+ auditor_dinas +" "
			+" , auditor_seksi					= "+ auditor_seksi +" "
			+" , nama_tempat_rca				= '"+ nama_tempat_rca +"' "
			+" , penanggung_jawab_direktorat	= "+ penanggung_jawab_direktorat +" "
			+" , penanggung_jawab_divprosbu		= "+ penanggung_jawab_divprosbu +" "
			+" , penanggung_jawab_departemen	= "+ penanggung_jawab_departemen +" "
			+" , penanggung_jawab_dinas			= "+ penanggung_jawab_dinas +" "
			+" , penanggung_jawab_seksi			= "+ penanggung_jawab_seksi +" "
			+" , penanggung_jawab_nipg			= '"+ penanggung_jawab_nipg +"' "
			+" , waktu_audit					= '"+ waktu_audit +"' "
			+" , lama_audit						= "+ lama_audit +" "
			+" , cuaca							= '"+ cuaca +"' "
			+" , id_user						= '"+ user_nipg +"' "
			+" , tanggal_akses					= getdate() "
			+" where id_rca						=  "+ id_rca;
			
		q2	= " delete from t_rca_auditor where id_rca = " + id_rca;
		
		l = auditor.length();
		if (l > 0) {
			q3	=" insert into t_rca_auditor (id_rca, nipg, status, id_user)";
			for (i = 0; i < l; i++) {
				if (periode == 1){
					query	=" select	isnull(count(*),0) as jumlah"
							+" from		t_rca	as a"
							+" where	year(a.tanggal_rca) = " + tahun
							+" and		month(a.tanggal_rca) = " + bulan
							+" and		day(a.tanggal_rca) between 1 and 15"
							+" and		'" + auditor.getString(i) +"' in ("
							+"				select	b.nipg"
							+"				from	t_rca_auditor	as b"
							+"				where	a.id_rca		= b.id_rca"
							+"				)";
							
					rs = db_stmt.executeQuery(query);
					
					if (rs.next()){
						jumlah = rs.getInt("jumlah");
					}
					
					if (jumlah > 0){
						status = 0;
					} else {
						status = 1;
					}
				} else {
					query	=" select	isnull(count(*),0) as jumlah"
							+" from		t_rca	as a"
							+" where	year(a.tanggal_rca) = " + tahun
							+" and		month(a.tanggal_rca) = " + bulan
							+" and		day(a.tanggal_rca) between 16 and 31"
							+" and		'" + auditor.getString(i) +"' in ("
							+"				select	b.nipg"
							+"				from	t_rca_auditor	as b"
							+"				where	a.id_rca		= b.id_rca"
							+"				)";
							
					rs = db_stmt.executeQuery(query);
					
					if (rs.next()){
						jumlah = rs.getInt("jumlah");
					}
					
					if (jumlah > 0){
						status = 0;
					} else {
						status = 2;
					}
				}
				
				q3	+=" select "+ id_rca
					+",'"+ auditor.getString(i) +"'"
					+","+ status
					+",'"+ user_nipg +"'";

				if (i < (l-1)) {
					q3 +=" union all";
				}
			}
		}out.print (q3);
		break;

	case 4:
		q	=" delete from t_rca_images"
			+" where  id_rca = "+ id_rca +";"
			+" delete from t_rca_auditor "
			+" where  id_rca =  "+ id_rca;

		q2	=" delete from t_rca_detail "
			+" where  id_rca =  "+ id_rca;

		q3	=" delete from t_rca "
			+" where  id_rca =  "+ id_rca;

		break;

	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);
	if (!q2.equals("")) {
		db_stmt.executeUpdate(q2);
	}
	if (!q3.equals("")) {
		db_stmt.executeUpdate(q3);
	}

	q	=" insert into __log (nipg, nama_menu, status_akses) values ('"
		+ session.getAttribute("user.nipg") +"','"
		+ session.getAttribute("menu.id") +"','"+ dml +"')";

	db_stmt.executeUpdate(q);

	log ("delete :"+ path + id_rca);
	FileUtils.deleteDirectory (new File (path + id_rca));

	out.print("{success:true, info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false, info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
