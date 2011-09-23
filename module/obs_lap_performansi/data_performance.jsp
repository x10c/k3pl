<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
String	q			= "";
String	q_nipg		= "";
String	q_org		= "";
String	q_target	= "";
String	q_idx		= "";
String	q_time		= "";
String	q_sum		= "";
String	q_part		= "";
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

	q_nipg	=" and nipg in ("
			+"	select	A.nipg"
			+"	from	r_pegawai	A"
			+"	,		r_seksi		B"
			+"	where	A.status_pegawai = '1'";

	q_part	=" select	count(id_stop) as total_part"
			+" from		t_stop"
			+" where	status_aktif	= '1'"
			+" and		status			in (1,2)"
			+" and		year			= "+ year;

	q_idx	=" select	cast(convert(decimal(18,2),"
			+"				case when sum(a.jumlah_unsafe) is null"
			+"				then 0"
			+"				else (1.0 * (sum(a.jumlah_unsafe) * 100))"
			+"				end"
			+"			/ isnull((sum(a.jumlah_unsafe) + sum(a.jumlah_safe)),1)) as varchar) as unsafe_act_index"
			+" from		t_stop_detail	as a"
			+" ,		t_stop			as b"
			+" where	a.id_stop		= b.id_stop"
			+" and		b.status_aktif	= '1'"
			+" and		b.year			= "+ year;

	q_time	=" select	isnull(sum(lama_observasi), 0) v"
			+" from		t_stop"
			+" where	status_aktif	= '1'"
			+" and		year			= "+ year;

	q_sum	=" select	isnull(sum(a.jumlah_unsafe),0) v"
			+" from		t_stop_detail	as a"
			+" ,		t_stop			as b"
			+" where	a.id_stop				= b.id_stop"
			+" and		b.status_aktif			= '1'"
			+" and		b.year					= "+ year;

	/* filter/aggregate by month */
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
		q_target	=" select isnull(sum("+ months[month - 1] +"),1) as target";
		q_part		+=" and month	= "+ month;
		q_idx		+=" and b.month	= "+ month;
		q_time		+=" and month	= "+ month;
		q_sum		+=" and b.month	= "+ month;
	}

	q_target	+=" from	t_stop_target_pegawai"
				+" where	year = "+ year + q_nipg;
	
	q_part		+= q_nipg;
	q_idx		+= q_nipg;
	q_time		+= q_nipg;
	q_sum		+= q_nipg;

	if (is_in_org.equals("1")) {
		/* query by organisasi */
		if (!id_seksi.equals("0")) {
			/* select partisipasi by single seksi */
			q_where	=" and A.id_seksi = ";

			q_org	=" select	id_seksi	as id"
					+" ,		nama_seksi	as name"
					+" from		r_seksi"
					+" where	id_seksi = "+ id_seksi;
		} else {
			if (!id_dinas.equals("0")) {
				/* select all seksi in one dinas */
				q_where	=" and A.id_seksi = ";

				q_org	=" select	id_seksi	as id"
						+" ,		nama_seksi	as name"
						+" from		r_seksi"
						+" where	id_dinas = "+ id_dinas;
			} else {
				if (!id_dep.equals("0")) {
					/* select all dinas in one departement */
					q_where =" and A.id_dinas = ";

					q_org	=" select	id_dinas	as id"
							+" ,		nama_dinas	as name"
							+" from		r_dinas"
							+" where	id_departemen = "+ id_dep;
				} else {
					/* select all departement */
					q_where =" and A.id_departemen = ";

					q_org	=" select	id_departemen	as id"
							+" ,		nama_departemen	as name"
							+" from		r_departemen";
				}
			}
		}
	} else {
		/* query by wilayah/area */
		if (!id_area.equals("0")) {
			/* select partisipasi by single area */
			q_where	=" and A.id_seksi = ";

			q_org	=" select	id_seksi	as id"
					+" ,		nama_seksi	as name"
					+" from		r_seksi"
					+" where	id_seksi = "+ id_area;
		} else {
			if (!id_wilayah.equals("0")) {
				/* select all area in one wilayah */
				q_where	=" and A.id_seksi = ";

				q_org	=" select	id_seksi	as id"
						+" ,		nama_seksi	as name"
						+" from		r_seksi"
						+" where	id_wilayah = "+ id_wilayah;
			} else {
				/* select all wilayah */
				q_where =" and A.id_seksi = B.id_seksi"
						+" and B.id_wilayah = ";

				q_org	=" select	id_wilayah	as id"
						+" ,		nama_wilayah	as name"
						+" from		r_wilayah";
			}
		}
	}

	data	="[";
	rs_org	= stmt_org.executeQuery(q_org);
	i		= 0;
	while (rs_org.next()) {
		id		= rs_org.getString("id");
		name	= rs_org.getString("name");

		q	=" select	round((P.total_part"
			+"			/ cast(isnull(nullif(T.target,0),1) as float))"
			+"			* 100, 2, 1)		as total_part_percent"
			+" ,		I.unsafe_act_index"
			+" ,		round((N_UNSAFE.v / (case TIME.v when 0 then 1.00 else TIME.v * 1.00 end)), 2, 1) as unsafe_act_hour"
			+" from ("+ q_target	+ q_where + id +")) T"
			+" ,	("+ q_part		+ q_where + id +")) P"
			+" ,	("+ q_idx		+ q_where + id +")) I"
			+" ,	("+ q_sum		+ q_where + id +")) N_UNSAFE"
			+" ,	("+ q_time		+ q_where + id +")) TIME";

		rs = db_stmt.executeQuery(q);

		while (rs.next()) {
			if (i > 0) {
				data += ",";
			} else {
				i = 1;
			}
			data	+="[\""+ name +"\""
					+ ","+ rs.getString("total_part_percent")
					+ ","+ rs.getString("unsafe_act_index")
					+ ","+ rs.getString("unsafe_act_hour")
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
