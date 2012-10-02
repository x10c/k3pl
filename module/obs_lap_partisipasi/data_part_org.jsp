<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %
 % WARNING: This script is used by charts module.
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
String	q			= "";
String	q_org		= "";
String	q_target	= "";
String	q_part		= "";
String	q_part2		= "";
String	q_where		= "";
String	months[]	= {	"jan", "feb", "mar", "apr"
			,	"may", "jun", "jul", "aug"
			,	"sep", "oct", "nov", "dec"
			};

try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	stmt_org	= db_con.createStatement();
	Statement	db_stmt		= db_con.createStatement();
	ResultSet	rs_org;
	ResultSet	rs;
	String		id, name;
	String		is_in_org	= request.getParameter("is_in_org");
	String		id_dir		= request.getParameter("id_dir");
	String		id_div		= request.getParameter("id_div");
	String		id_dep		= request.getParameter("id_dep");
	String		id_dinas	= request.getParameter("id_dinas");
	String		id_seksi	= request.getParameter("id_seksi");
	String		id_wilayah	= request.getParameter("id_wilayah");
	String		id_area		= request.getParameter("id_area");
	String		year		= request.getParameter("year");
	int			month		= Integer.parseInt(request.getParameter("month"));

	String		data;
	String		nipg;
	int			i,x;

	q_part	=" select	count(id_stop) as total_part"
		+" from		t_stop"
		+" where	status_aktif	= '1'"
		+" and		status			in (1,2)"
		+" and		year			= "+ year;

	q_part2	=" select	count(id_stop) as total_part"
		+" from		t_stop	A"
		+" where	status_aktif	= '1'"
		+" and		status			in (1,2)"
		+" and		year			= "+ year;

	if (month == 0) {
		q_target ="select (";

		for (i = 0; i < months.length; i++) {
			if (i > 0) {
				q_target +="+";
			}
			q_target += " isnull(sum("+ months[i] +"),0)";
		}

		q_target +=") as target";
	} else {
		q_target=" select isnull(sum("+ months[month - 1]
							+"),1) as target";

		q_part	+=" and month = "+ month;
	}

	q_target
	+=" from	t_stop_target_pegawai"
	+" where	year	= "+ year
	+" and		nipg in ("
	+"	select	A.nipg"
	+"	from	r_pegawai	A"
	+"	,		r_seksi		B"
	+"	where	A.status_pegawai = '1'";

	q_part
	+=" and nipg in ("
	+"	select	A.nipg"
	+"	from	r_pegawai	A"
	+"	,		r_seksi		B"
	+"	where	A.status_pegawai = '1'";

	q_part
	+=" and nipg in ("
	+"	select	A.nipg"
	+"	from	r_pegawai	A"
	+"	,		r_seksi		B"
	+"	where	A.status_pegawai in ('0','1')";

	/* query by organisasi */
	if (is_in_org.equals("1")) {
		if (!id_seksi.equals("0")) {
			/* select partisipasi by single seksi */
			q_where	=" and A.nipg = '";

			q_org	=" select	nipg			as id"
					+" ,		nama_pegawai	as name"
					+" from		r_pegawai"
					+" where	id_seksi = "+ id_seksi
					+" order by nama_pegawai";
		} else if (!id_dinas.equals("0")) {
			/* select all seksi in one dinas */
			q_where	=" and A.id_seksi = ";

			q_org	=" select	id_seksi	as id"
					+" ,		nama_seksi	as name"
					+" from		r_seksi"
					+" where	id_dinas = "+ id_dinas
					+" order by nama_seksi";
		} else if (!id_dep.equals("0")) {
			/* select all dinas in one departement */
			q_where =" and A.id_dinas = ";

			q_org	=" select	id_dinas	as id"
					+" ,		nama_dinas	as name"
					+" from		r_dinas"
					+" where	id_departemen = "+ id_dep
					+" order by nama_dinas";
		} else if (!id_div.equals ("0")) {
			/* select all departement */
			q_where =" and A.id_departemen = ";

			q_org	=" select	id_departemen	as id"
					+" ,		nama_departemen	as name"
					+" from		r_departemen"
					+" where	id_divprosbu = "+ id_div
					+" order by nama_departemen";
		} else if (!id_dir.equals ("0")) {
			/* select all divisi */
			q_where =" and A.id_divprosbu = ";

			q_org	=" select	id_divprosbu	as id"
					+" ,		nama_divprosbu	as name"
					+" from		r_divprosbu"
					+" where	id_direktorat = "+ id_dir
					+" order by nama_divprosbu";
		} else {
			/* select all direktorat */
			q_where =" and A.id_direktorat = ";

			q_org	=" select	id_direktorat	as id"
					+" ,		nama_direktorat	as name"
					+" from		r_direktorat"
					+" order by nama_direktorat";
		}
	} else { /* query by wilayah/area */
		if (!id_area.equals("0")) {
			/* select partisipasi by single area */
			q_where	=" and A.nipg = '";

			q_org	=" select	nipg			as id"
					+" ,		nama_pegawai	as name"
					+" from		r_pegawai"
					+" where	id_seksi = "+ id_area
					+" order by nama_pegawai";
		} else {
			if (!id_wilayah.equals("0")) {
				/* select all area in one wilayah */
				q_where	=" and A.id_seksi = ";

				q_org	=" select	id_seksi	as id"
						+" ,		nama_seksi	as name"
						+" from		r_seksi"
						+" where	id_wilayah = "+ id_wilayah
						+" order by nama_seksi";
			} else {
				/* select all wilayah */
				q_where =" and A.id_seksi = B.id_seksi"
						+" and B.id_wilayah = ";

				q_org	=" select	id_wilayah	as id"
						+" ,		nama_wilayah	as name"
						+" from		r_wilayah"
						+" order by nama_wilayah";
			}
		}
	}

	/* loop by organisasi */
	data	="[";
	rs_org	= stmt_org.executeQuery(q_org);
	i		= 0;
	while (rs_org.next()) {
		id		= rs_org.getString("id");
		name	= rs_org.getString("name");

		q	=" select	T.target"
			+" ,		P.total_part"
			+" ,		100	as target_percent"
			+" ,		round((P.total_part/cast(isnull(nullif(T.target,0),1) as float)) * 100, 2, 1) as total_part_percent"
			+" from ("+ q_target + q_where;

		if (!id_seksi.equals("0") || !id_area.equals("0")) {
			q	+= id +"'";
		} else {
			q	+= id;
		}

		q	+=")) T,("+ q_part2	+ q_where;

		if (!id_seksi.equals("0") || !id_area.equals("0")) {
			q	+= id +"'";
		} else {
			q	+= id;
		}

		q +=") P";

		rs = db_stmt.executeQuery(q);

		while (rs.next()) {
			if (i > 0) {
				data += ",";
			} else {
				i = 1;
			}
			data	+="[\""+ name +"\""
				+ ","+ rs.getString("target")
				+ ","+ rs.getString("total_part")
				+ ","+ rs.getString("target_percent")
				+ ","+ rs.getString("total_part_percent")
				+ "]";
		}

		rs.close();
	}
	rs_org.close();
	data += "]";

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
