<%--
	Copyright 2013 - PT. Perusahaan Gas Negara Tbk.

	Author(s):
	- mhd.sulhan (ms@kilabit.org)

	WARNING: This script is used by charts module. DO NOT USE MODINIT.JSP.
--%>

<%@ page import="java.sql.*" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
String	q		= "";
String	q_org		= "";
String	q_target	= "";
String	q_part2		= "";
String	q_where		= "";
String	months[]	= {	"jan", "feb", "mar", "apr"
			,	"may", "jun", "jul", "aug"
			,	"sep", "oct", "nov", "dec"
			};
String		part_tgl_1	= "";
String		part_tgl_2	= "";

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
	int			is_in_org		= ServletUtilities.getIntParameter (request, "is_in_org", 1);
	int			id_dir			= ServletUtilities.getIntParameter (request, "id_dir", 0);
	int			id_div			= ServletUtilities.getIntParameter (request, "id_div", 0);
	int			id_dep			= ServletUtilities.getIntParameter (request, "id_dep", 0);
	int			id_dinas		= ServletUtilities.getIntParameter (request, "id_dinas", 0);
	int			id_seksi		= ServletUtilities.getIntParameter (request, "id_seksi", 0);
	int			id_wilayah		= ServletUtilities.getIntParameter (request, "id_wilayah", 0);
	int			id_area			= ServletUtilities.getIntParameter (request, "id_area", 0);
	int			year			= ServletUtilities.getIntParameter (request, "year", 0);
	int			month			= ServletUtilities.getIntParameter (request, "month", 0);
	int			hide_inaktif	= ServletUtilities.getIntParameter (request, "hide_inaktif", 1);
	String		data;
	String		nipg;
	int			i,x;

	q_part2	="	select	count (A.nipg) 			as total_part"
			+" 	from	t_rca_auditor			A"
			+" 	,		t_rca					B"
			+"	,		r_pegawai				C"
			+"	,		r_seksi					D"
			+"	,		__user					E"
			+"	,		__user_grup				F"
			+"	,		__grup_user				G"
			+" 	where	A.id_rca				= B.id_rca"
			+"	and		A.nipg					= C.nipg"
			+"	and		C.id_seksi				= D.id_seksi"
			+"	and		C.nipg					= E.nipg"
			+"	and		E.nipg					= F.nipg"
			+"	and		F.id_grup				= G.id_grup"
			+"	and		G.id_grup				= 5";

	if (1 == hide_inaktif) {
		q_part2	+="	and		C.status_pegawai		= '1'"
				+"	and		E.status_user			= 1";
	}

	if (month == 0) {
		part_tgl_1	= (year - 1) +"-12-25";
		part_tgl_2	= year +"-12-24";

		q_target	="	select (sum (isnull(A.jan,0))"
					+"	+		sum (isnull(A.feb,0))"
					+"	+		sum (isnull(A.mar,0))"
					+"	+		sum (isnull(A.apr,0))"
					+"	+		sum (isnull(A.may,0))"
					+"	+		sum (isnull(A.jun,0))"
					+"	+		sum (isnull(A.jul,0))"
					+"	+		sum (isnull(A.aug,0))"
					+"	+		sum (isnull(A.sep,0))"
					+"	+		sum (isnull(A.oct,0))"
					+"	+		sum (isnull(A.nov,0))"
					+"	+		sum (isnull(A.dec,0))"
					+"	) as target";

		q_part2		+=" and B.tanggal_rca >= cast ('"+ part_tgl_1 +"' as datetime)"
					+ " and B.tanggal_rca <= cast ('"+ part_tgl_2 +"' as datetime)";
	} else {
		if (month == 1) {
			part_tgl_1	= (year - 1) +"-12-25";
			part_tgl_2	= year +"-01-24";
		} else {
			part_tgl_1	= year +"-"+ (month - 1) +"-25";
			part_tgl_2	= year +"-"+ month +"-24";
		}

		q_target	="	select isnull(sum(A."+ months[month - 1] +"),0) as target";

		q_part2		+=" and B.tanggal_rca >= cast ('"+ part_tgl_1 +"' as datetime)"
					+ " and B.tanggal_rca <= cast ('"+ part_tgl_2 +"' as datetime)";
	}

	q_target	+=" from	t_rca_target_pegawai	A"
				+"	,		r_pegawai				C"
				+"	,		r_seksi					D"
				+"	,		__user					E"
				+"	,		__user_grup				F"
				+"	,		__grup_user				G"
				+"	where	A.year					= "+ year
				+"	and		A.nipg					= C.nipg"
				+"	and		C.id_seksi				= D.id_seksi"
				+"	and		C.nipg					= E.nipg"
				+"	and		E.nipg					= F.nipg"
				+"	and		F.id_grup				= G.id_grup"
				+"	and		G.id_grup				= 5";

	if (1 == hide_inaktif) {
		q_target	+="	and		C.status_pegawai		= '1'"
					+"	and		E.status_user			= 1";
	}

	/* query by organisasi */
	if (1 == is_in_org) {
		if (0 != id_seksi) {
			/* select partisipasi by single seksi */
			q_where	=" and C.nipg = ";

			q_org	=" select	A.nipg			as id"
					+" ,		A.nama_pegawai	as name"
					+" from		r_pegawai		A"
					+" ,		__user			B"
					+" where	A.id_seksi		= "+ id_seksi
					+" and		A.nipg			= B.nipg";

			if (1 == hide_inaktif) {
				q_org	+="	and A.status_pegawai	= 1"
						+ " and B.status_user		= 1";
			}

		} else if (0 != id_dinas) {
			/* select all seksi in one dinas */
			q_where	=" and D.id_seksi = ";

			q_org	=" select	id_seksi	as id"
					+" ,		nama_seksi	as name"
					+" from		r_seksi"
					+" where	id_dinas = "+ id_dinas;

		} else if (0 != id_dep) {
			/* select all dinas in one departement */
			q_where =" and D.id_dinas = ";

			q_org	=" select	id_dinas	as id"
					+" ,		nama_dinas	as name"
					+" from		r_dinas"
					+" where	id_departemen = "+ id_dep;

		} else if (0 != id_div) {
			/* select all departement */
			q_where =" and D.id_departemen = ";

			q_org	=" select	id_departemen	as id"
					+" ,		nama_departemen	as name"
					+" from		r_departemen"
					+" where	id_divprosbu = "+ id_div;

		} else if (0 != id_dir) {
			/* select all divisi */
			q_where =" and D.id_divprosbu = ";

			q_org	=" select	id_divprosbu	as id"
					+" ,		nama_divprosbu	as name"
					+" from		r_divprosbu"
					+" where	id_direktorat = "+ id_dir;
		} else {
			/* select all direktorat */
			q_where =" and D.id_direktorat = ";

			q_org	=" select	id_direktorat	as id"
					+" ,		nama_direktorat	as name"
					+" from		r_direktorat";
		}
	} else { /* query by wilayah/area */
		if (0 != id_area) {
			/* select partisipasi by single area */
			q_where	=" and C.nipg = ";

			q_org	=" select	A.nipg			as id"
					+" ,		B.nama_pegawai	as name"
					+" from		r_pegawai		A"
					+" ,		__user			B"
					+" where	A.id_seksi		= "+ id_area
					+" and		A.nipg			= B.nipg";

			if (1 == hide_inaktif) {
				q_org	+="	and A.status_pegawai	= 1"
						+ " and B.status_user		= 1";
			}
		} else {
			if (0 != id_wilayah) {
				/* select all area in one wilayah */
				q_where	=" and D.id_seksi = ";

				q_org	=" select	id_seksi	as id"
						+" ,		nama_seksi	as name"
						+" from		r_seksi"
						+" where	id_wilayah = "+ id_wilayah;
			} else {
				/* select all wilayah */
				q_where =" and C.id_seksi		= D.id_seksi"
						+" and D.id_wilayah		= ";

				q_org	=" select	id_wilayah		as id"
						+" ,		nama_wilayah	as name"
						+" from		r_wilayah";
			}
		}
	}

	q_org	+=" order by name";

	/* loop by organisasi */
	data	="[";
	rs_org	= stmt_org.executeQuery(q_org);
	i		= 0;
	while (rs_org.next()) {
		id		= rs_org.getString("id");
		name	= rs_org.getString("name");

		q	=" select	isnull (T.target, 0)	target"
			+" ,		P.total_part"
			+" ,		100	as target_percent"
			+" ,		round((P.total_part/cast(isnull(nullif(T.target,0),1) as float)) * 100, 2, 1) as total_part_percent"
			+" from ("
			+ q_target
			+ q_where
			+ ((id_seksi != 0 || id_area != 0) ? "'"+ id +"'" : id)
			+") T,("
			+ q_part2
			+ q_where
			+ ((id_seksi != 0 || id_area != 0) ? "'"+ id +"'" : id)
			+") P";

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
	out.print (q);
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
