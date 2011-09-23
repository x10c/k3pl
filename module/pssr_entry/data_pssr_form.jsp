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

	String q= " select   id_kategori_item_pssr "
		+ " ,        nama_kategori_item_pssr "
		+ " from     r_kategori_item_pssr "
		+ " order by id_kategori_item_pssr ";

	ResultSet	rs	= stmt1.executeQuery(q);
	ResultSet	rs2	= null;
	ResultSet	rs3	= null;
	int		i	= 0;
	int		j	= 0;
	int		k	= 0;
	String		id_kat	= "";
	String		id_item	= "";
	String		data	= "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		id_kat = rs.getString("id_kategori_item_pssr");

		data	+= "{ id : '"+ id_kat +"' "
			+  ", text : '"+ rs.getString("nama_kategori_item_pssr") +"' "
			+  ", item : [";

		q	=" select	id_item_pssr "
			+" ,		nama_item_pssr "
			+" from		r_item_pssr "
			+" where	id_kategori_item_pssr = "+ id_kat;

		rs2 = stmt2.executeQuery(q);

		j = 0;
		while (rs2.next()) {
			if (j > 0) {
				data += ",";
			} else {
				j++;
			}

			id_item = rs2.getString("id_item_pssr");

			data	+="{"
				+ "  id : '"+ id_item +"' "
				+ ", text : '"+ rs2.getString("nama_item_pssr") +"' "
				+ ", details : [";

			q	=" select	id_item_detail_pssr "
				+" ,		nama_item_detail_pssr "
				+" from		r_item_detail_pssr "
				+" where	id_kategori_item_pssr	= "+ id_kat
				+" and		id_item_pssr	= "+ id_item;

			rs3 = stmt3.executeQuery(q);

			k = 0;
			while (rs3.next()) {
				if (k > 0) {
					data += ",";
				} else {
					k++;
				}

				data	+="{"
					+ "  kat_id : '"+ id_kat +"' "
					+ ", item_id : '"+ id_item +"' "
					+ ", detail_id : '"+ rs3.getString("id_item_detail_pssr") +"' "
					+ ", detail_name : '"+ rs3.getString("nama_item_detail_pssr") +"' "
					+ ", applicable : '0'"
					+ ", confirm_ok : '0'"
					+ ", punchlist : '0'"
					+ ", keterangan : ''"
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
