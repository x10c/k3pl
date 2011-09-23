<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	con	= (Connection) session.getAttribute("db.con");
	if (con == null || (con != null && con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	stmt1	= con.createStatement();
	Statement	stmt2	= con.createStatement();
	Statement	stmt3	= con.createStatement();

	String q= " select   id_kel_tipe_observasi "
		+ " ,        nama_kel_tipe_observasi "
		+ " from     r_kelompok_tipe_observasi "
		+ " order by id_kel_tipe_observasi ";

	ResultSet	rs	= stmt1.executeQuery(q);
	ResultSet	rs2	= null;
	ResultSet	rs3	= null;
	int		i	= 0;
	int		j	= 0;
	int		k	= 0;
	String		id_kel	= "";
	String		id_tipe	= "";
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		id_kel = rs.getString("id_kel_tipe_observasi");

		data	+= "{ id : '"+ id_kel +"' "
			+  ", text : '"+ rs.getString("nama_kel_tipe_observasi") +"' "
			+  ", tipe : [";

		q	=" select	id_tipe_observasi "
			+" ,		nama_tipe_observasi "
			+" from		r_tipe_observasi "
			+" where	id_kel_tipe_observasi = "+ id_kel;

		rs2 = stmt2.executeQuery(q);

		j = 0;
		while (rs2.next()) {
			if (j > 0) {
				data += ",";
			} else {
				j++;
			}

			id_tipe = rs2.getString("id_tipe_observasi");

			data	+="{"
				+ "  id : '"+ id_tipe +"' "
				+ ", text : '"+ rs2.getString("nama_tipe_observasi") +"' "
				+ ", details : [";

			q	=" select	id_detail_tipe_observasi "
				+" ,		nama_detail_tipe_observasi "
				+" from		r_detail_tipe_observasi "
				+" where	id_kel_tipe_observasi	= "+ id_kel
				+" and		id_tipe_observasi	= "+ id_tipe;

			rs3 = stmt3.executeQuery(q);

			k = 0;
			while (rs3.next()) {
				if (k > 0) {
					data += ",";
				} else {
					k++;
				}

				data	+="{"
					+ "  kel_id : '"+ id_kel +"' "
					+ ", tipe_id : '"+ id_tipe +"' "
					+ ", detail_id : '"+ rs3.getString("id_detail_tipe_observasi") +"' "
					+ ", detail_name : '"+ rs3.getString("nama_detail_tipe_observasi") +"' "
					+ ", safe : '0'"
					+ ", unsafe : '0'"
					+ "}";
			}

			data += "]}";
			rs3.close();
		}
		data += "]}";
		rs2.close();
	}
	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
