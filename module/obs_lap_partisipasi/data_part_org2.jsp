<%--
 % Copyright 2013 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - mhd.sulhan (ms@kilabit.org)
 %
 % WARNING: This script is used by charts module, do not use modinit.jsp.
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%
String		db_q		= "";
Statement	db_stmt		= null;
ResultSet	db_rs		= null;
JSONObject	_return		= new JSONObject ();

String		part_tgl_1	= "";
String		part_tgl_2	= "";
String		target_bln	= "";
JSONArray	data		= null;
JSONArray	datum		= null;
String		months[]	= {	"jan", "feb", "mar", "apr"
						,	"may", "jun", "jul", "aug"
						,	"sep", "oct", "nov", "dec"
						};

try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	int	is_in_org	= Integer.parseInt (request.getParameter("is_in_org"));
	int	id_dir		= Integer.parseInt (request.getParameter("id_dir"));
	int	id_div		= Integer.parseInt (request.getParameter("id_div"));
	int	id_dep		= Integer.parseInt (request.getParameter("id_dep"));
	int	id_dinas	= Integer.parseInt (request.getParameter("id_dinas"));
	int	id_seksi	= Integer.parseInt (request.getParameter("id_seksi"));
	int	id_wilayah	= Integer.parseInt (request.getParameter("id_wilayah"));
	int	id_area		= Integer.parseInt (request.getParameter("id_area"));
	int	year		= Integer.parseInt (request.getParameter("year"));
	int	month		= Integer.parseInt (request.getParameter("month"));

	if (0 == month) {
		part_tgl_1	= (year - 1) +"-12-25";
		part_tgl_2	= year +"-12-24";

		target_bln	="		sum (jan) + sum (feb) + sum (mar) + sum (apr) "
					+"	+	sum (may) + sum (jun) + sum (jul) + sum (aug) "
					+"	+	sum (sep) + sum (oct) + sum (nov) + sum (dec) ";

	} else if (1 == month) {
		part_tgl_1	= (year - 1) +"-12-25";
		part_tgl_2	= year +"-01-24";

		target_bln	="	sum ("+ months [month - 1] +")";
	} else {
		part_tgl_1	= year +"-"+ (month - 1) +"-25";
		part_tgl_2	= year +"-"+ month +"-24";

		target_bln	="	sum ("+ months [month - 1] +")";
	}

	if (0 != is_in_org) {
		if (0 != id_seksi) {
			db_q	="	select		PEG.nipg				as id"
					+"	,			PEG.nama_pegawai		as nama"
					+"	,			isnull (TARGET.v, 0)	as target"
					+"	,			isnull (PART.v, 0)		as partisipasi"
					+"	,			100						as target_percent"
					+"	,			round ((isnull (PART.v,0) / cast (isnull (nullif (TARGEt.v, 0), 1) as float)) * 100, 2, 1)	as partisipasi_percent"
					+"	from		r_pegawai				PEG"
					+""
					+"	left join	("
					+"			select		T.nipg"
					+"			,			"+ target_bln +"		as v"
					+"			from		t_stop_target_pegawai	T"
					+"			inner join	r_pegawai				PEG	on PEG.nipg		= T.nipg"
					+"			inner join	r_seksi					SEK	on SEK.id_seksi	= PEG.id_seksi"
					+"			where		T.year					= "+ year
					+"			and			SEK.id_seksi			= "+ id_seksi
					+"			and			PEG.status_pegawai		= '1'"
					+"			group by	T.nipg"
					+"		) TARGET on TARGET.nipg		= PEG.nipg"
					+""
					+"	left join	("
					+"			select		T.nipg"
					+"			,			count (*)	as	v"
					+"			from		t_stop		T"
					+"			where		status_aktif	= '1'"
					+"			and			status			in (1,2)"
					+"			and			T.year			= "+ year
					+"			and			T.tanggal		>= cast ('"+ part_tgl_1 +"' as datetime)"
					+"			and			T.tanggal		<= cast ('"+ part_tgl_2 +"' as datetime)"
					+"			and			T.id_seksi		= "+ id_seksi
					+"			group by	T.nipg"
					+"		) PART on PART.nipg = PEG.nipg"
					+""
					+"	where		PEG.id_seksi = "+ id_seksi
					+"	order by	PEG.nama_pegawai";

		} else if (0 != id_dinas) { /* pilih semua seksi di dinas pilihan */
			db_q	="	select		SEK.id_seksi			as id"
					+"	,			SEK.nama_seksi			as nama"
					+"	,			isnull (TARGET.v, 0)	as target"
					+"	,			isnull (PART.v, 0)		as partisipasi"
					+"	,			100						as target_percent"
					+"	,			round ((isnull (PART.v,0) / cast (isnull (nullif (TARGEt.v, 0), 1) as float)) * 100, 2, 1)	as partisipasi_percent"
					+"	from		r_seksi		SEK"
					+""
					+"	left join	("
					+"			select		SEK.id_seksi"
					+"			,			"+ target_bln +"		as v"
					+"			from		t_stop_target_pegawai	T"
					+"			inner join	r_pegawai				PEG	on PEG.nipg		= T.nipg"
					+"			inner join	r_seksi					SEK	on SEK.id_seksi	= PEG.id_seksi"
					+"			where		T.year					= "+ year
					+"			and			SEK.id_dinas			= "+ id_dinas
					+"			and			PEG.status_pegawai		= '1'"
					+"			group by	SEK.id_seksi"
					+"		) TARGET on TARGET.id_seksi = SEK.id_seksi"
					+""
					+"	left join	("
					+"			select		T.id_seksi"
					+"			,			count (*)	as	v"
					+"			from		t_stop		T"
					+"			where		status_aktif	= '1'"
					+"			and			status			in (1,2)"
					+"			and			T.year			= "+ year
					+"			and			T.tanggal		>= cast ('"+ part_tgl_1 +"' as datetime)"
					+"			and			T.tanggal		<= cast ('"+ part_tgl_2 +"' as datetime)"
					+"			and			T.id_dinas		= "+ id_dinas
					+"			group by	T.id_seksi"
					+"		) PART on PART.id_seksi	= SEK.id_seksi"
					+""
					+"	where		SEK.id_dinas = "+ id_dinas
					+"	order by	SEK.nama_seksi";

		} else if (0 != id_dep) { /* pilih semua dinas di depratemen pilihan */
			db_q	="	select		DINAS.id_dinas			as id"
					+"	,			DINAS.nama_dinas		as nama"
					+"	,			isnull (TARGET.v, 0)	as target"
					+"	,			isnull (PART.v, 0)		as partisipasi"
					+"	,			100						as target_percent"
					+"	,			round ((isnull (PART.v,0) / cast (isnull (nullif (TARGEt.v, 0), 1) as float)) * 100, 2, 1)	as partisipasi_percent"
					+"	from		r_dinas					DINAS"
					+""
					+"	left join	("
					+"			select		DINAS.id_dinas"
					+"			,			"+ target_bln +"		as v"
					+"			from		t_stop_target_pegawai	T"
					+"			inner join	r_pegawai				PEG		on PEG.nipg			= T.nipg"
					+"			inner join	r_dinas					DINAS	on DINAS.id_dinas	= PEG.id_dinas"
					+"			where		T.year					= "+ year
					+"			and			DINAS.id_departemen		= "+ id_dep
					+"			and			PEG.status_pegawai		= '1'"
					+"			group by	DINAS.id_dinas"
					+"		) TARGET on TARGET.id_dinas = DINAS.id_dinas"
					+""
					+"	left join	("
					+"			select		T.id_dinas"
					+"			,			count (*)	as	v"
					+"			from		t_stop		T"
					+"			where		status_aktif	= '1'"
					+"			and			status			in (1,2)"
					+"			and			T.year			= "+ year
					+"			and			T.tanggal		>= cast ('"+ part_tgl_1 +"' as datetime)"
					+"			and			T.tanggal		<= cast ('"+ part_tgl_2 +"' as datetime)"
					+"			and			T.id_departemen	= "+ id_dep
					+"			group by	T.id_dinas"
					+"		) PART on PART.id_dinas	= DINAS.id_dinas"
					+""
					+"	where		DINAS.id_departemen = "+ id_dep
					+"	order by	DINAS.nama_dinas";

		} else if (0 != id_div) { /* pilih semua departemen di divisi pilihan */
			db_q	="	select		DEP.id_departemen		as id"
					+"	,			DEP.nama_departemen		as nama"
					+"	,			isnull (TARGET.v, 0)	as target"
					+"	,			isnull (PART.v, 0)		as partisipasi"
					+"	,			100						as target_percent"
					+"	,			round ((isnull (PART.v,0) / cast (isnull (nullif (TARGEt.v, 0), 1) as float)) * 100, 2, 1)	as partisipasi_percent"
					+"	from		r_departemen			DEP"
					+""
					+"	left join	("
					+"			select		DEP.id_departemen"
					+"			,			"+ target_bln +"		as v"
					+"			from		t_stop_target_pegawai	T"
					+"			inner join	r_pegawai				PEG	on PEG.nipg				= T.nipg"
					+"			inner join	r_departemen			DEP	on DEP.id_departemen	= PEG.id_departemen"
					+"			where		T.year					= "+ year
					+"			and			DEP.id_divprosbu		= "+ id_div
					+"			and			PEG.status_pegawai		= '1'"
					+"			group by	DEP.id_departemen"
					+"		) TARGET on TARGET.id_departemen = DEP.id_departemen"
					+""
					+"	left join	("
					+"			select		T.id_departemen"
					+"			,			count (*)	as	v"
					+"			from		t_stop		T"
					+"			where		status_aktif	= '1'"
					+"			and			status			in (1,2)"
					+"			and			T.year			= "+ year
					+"			and			T.tanggal		>= cast ('"+ part_tgl_1 +"' as datetime)"
					+"			and			T.tanggal		<= cast ('"+ part_tgl_2 +"' as datetime)"
					+"			and			T.id_divprosbu	= "+ id_div
					+"			group by	T.id_departemen"
					+"		) PART on PART.id_departemen = DEP.id_departemen"
					+""
					+"	where		DEP.id_divprosbu = "+ id_div
					+"	order by	DEP.nama_departemen";

		} else if (0 != id_dir) {
			db_q	="	select		DIV.id_divprosbu		as id"
					+"	,			DIV.nama_divprosbu		as nama"
					+"	,			isnull (TARGET.v, 0)	as target"
					+"	,			isnull (PART.v, 0)		as partisipasi"
					+"	,			100						as target_percent"
					+"	,			round ((isnull (PART.v,0) / cast (isnull (nullif (TARGEt.v, 0), 1) as float)) * 100, 2, 1)	as partisipasi_percent"
					+"	from		r_divprosbu				DIV"
					+""
					+"	left join	("
					+"			select		DIV.id_divprosbu"
					+"			,			"+ target_bln +"		as v"
					+"			from		t_stop_target_pegawai	T"
					+"			inner join	r_pegawai				PEG	on PEG.nipg				= T.nipg"
					+"			inner join	r_divprosbu				DIV	on DIV.id_divprosbu		= PEG.id_divprosbu"
					+"			where		T.year					= "+ year
					+"			and			DIV.id_direktorat		= "+ id_dir
					+"			and			PEG.status_pegawai		= '1'"
					+"			group by	DIV.id_divprosbu"
					+"		) TARGET on TARGET.id_divprosbu = DIV.id_divprosbu"
					+""
					+"	left join	("
					+"			select		T.id_divprosbu"
					+"			,			count (*)	as	v"
					+"			from		t_stop		T"
					+"			where		status_aktif	= '1'"
					+"			and			status			in (1,2)"
					+"			and			T.year			= "+ year
					+"			and			T.tanggal		>= cast ('"+ part_tgl_1 +"' as datetime)"
					+"			and			T.tanggal		<= cast ('"+ part_tgl_2 +"' as datetime)"
					+"			and			T.id_direktorat	= "+ id_dir
					+"			group by	T.id_divprosbu"
					+"		) PART on PART.id_divprosbu = DIV.id_divprosbu"
					+""
					+"	where		DIV.id_direktorat = "+ id_dir
					+"	order by	DIV.nama_divprosbu";

		} else { /* select all direktorat */
			db_q	="	select		DIR.id_direktorat		as id"
					+"	,			DIR.nama_direktorat		as nama"
					+"	,			isnull (TARGET.v, 0)	as target"
					+"	,			isnull (PART.v, 0)		as partisipasi"
					+"	,			100						as target_percent"
					+"	,			round ((isnull (PART.v,0) / cast (isnull (nullif (TARGEt.v, 0), 1) as float)) * 100, 2, 1)	as partisipasi_percent"
					+"	from		r_direktorat			DIR"
					+""
					+"	left join	("
					+"			select		DIR.id_direktorat"
					+"			,			"+ target_bln +"		as v"
					+"			from		t_stop_target_pegawai	T"
					+"			inner join	r_pegawai				PEG	on PEG.nipg				= T.nipg"
					+"			inner join	r_direktorat			DIR	on DIR.id_direktorat	= PEG.id_direktorat"
					+"			where		T.year					= "+ year
					+"			and			PEG.status_pegawai		= '1'"
					+"			group by	DIR.id_direktorat"
					+"		) TARGET on TARGET.id_direktorat = DIR.id_direktorat"
					+""
					+"	left join	("
					+"			select		T.id_direktorat"
					+"			,			count (*)	as	v"
					+"			from		t_stop		T"
					+"			where		status_aktif	= '1'"
					+"			and			status			in (1,2)"
					+"			and			T.year			= "+ year
					+"			and			T.tanggal		>= cast ('"+ part_tgl_1 +"' as datetime)"
					+"			and			T.tanggal		<= cast ('"+ part_tgl_2 +"' as datetime)"
					+"			group by	T.id_direktorat"
					+"		) PART on PART.id_direktorat = DIR.id_direktorat"
					+""
					+"	order by	DIR.nama_direktorat";
		}
	} else {
		if (0 != id_area) {
			db_q	="	select		PEG.nipg				as id"
					+"	,			PEG.nama_pegawai		as nama"
					+"	,			isnull (TARGET.v, 0)	as target"
					+"	,			isnull (PART.v, 0)		as partisipasi"
					+"	,			100						as target_percent"
					+"	,			round ((isnull (PART.v,0) / cast (isnull (nullif (TARGEt.v, 0), 1) as float)) * 100, 2, 1)	as partisipasi_percent"
					+"	from		r_pegawai				PEG"
					+""
					+"	left join	("
					+"			select		T.nipg"
					+"			,			"+ target_bln +"		as v"
					+"			from		t_stop_target_pegawai	T"
					+"			inner join	r_pegawai				PEG	on PEG.nipg		= T.nipg"
					+"			inner join	r_seksi					SEK	on SEK.id_seksi	= PEG.id_seksi"
					+"			where		T.year					= "+ year
					+"			and			SEK.id_seksi			= "+ id_area
					+"			and			PEG.status_pegawai		= '1'"
					+"			group by	T.nipg"
					+"		) TARGET on TARGET.nipg		= PEG.nipg"
					+""
					+"	left join	("
					+"			select		T.nipg"
					+"			,			count (*)	as	v"
					+"			from		t_stop		T"
					+"			where		status_aktif	= '1'"
					+"			and			status			in (1,2)"
					+"			and			T.year			= "+ year
					+"			and			T.tanggal		>= cast ('"+ part_tgl_1 +"' as datetime)"
					+"			and			T.tanggal		<= cast ('"+ part_tgl_2 +"' as datetime)"
					+"			and			T.id_seksi		= "+ id_area
					+"			group by	T.nipg"
					+"		) PART on PART.nipg = PEG.nipg"
					+""
					+"	where		PEG.id_seksi = "+ id_area
					+"	order by	PEG.nama_pegawai";

		} else if (0 != id_wilayah) {
			db_q	="	select		SEK.id_seksi			as id"
					+"	,			SEK.nama_seksi			as nama"
					+"	,			isnull (TARGET.v, 0)	as target"
					+"	,			isnull (PART.v, 0)		as partisipasi"
					+"	,			100						as target_percent"
					+"	,			round ((isnull (PART.v,0) / cast (isnull (nullif (TARGEt.v, 0), 1) as float)) * 100, 2, 1)	as partisipasi_percent"
					+"	from		r_seksi		SEK"
					+""
					+"	left join	("
					+"			select		SEK.id_seksi"
					+"			,			"+ target_bln +"		as v"
					+"			from		t_stop_target_pegawai	T"
					+"			inner join	r_pegawai				PEG	on PEG.nipg		= T.nipg"
					+"			inner join	r_seksi					SEK	on SEK.id_seksi	= PEG.id_seksi"
					+"			where		T.year					= "+ year
					+"			and			SEK.id_wilayah			= "+ id_wilayah
					+"			and			PEG.status_pegawai		= '1'"
					+"			group by	SEK.id_seksi"
					+"		) TARGET on TARGET.id_seksi = SEK.id_seksi"
					+""
					+"	left join	("
					+"			select		T.id_seksi"
					+"			,			count (*)	as	v"
					+"			from		t_stop		T"
					+"			inner join	r_seksi		SEK	on SEK.id_seksi		= T.id_seksi"
					+"			inner join	r_wilayah	WIL on WIL.id_wilayah	= SEK.id_wilayah"
					+"			where		status_aktif	= '1'"
					+"			and			status			in (1,2)"
					+"			and			T.year			= "+ year
					+"			and			T.tanggal		>= cast ('"+ part_tgl_1 +"' as datetime)"
					+"			and			T.tanggal		<= cast ('"+ part_tgl_2 +"' as datetime)"
					+"			and			WIL.id_wilayah	= "+ id_wilayah
					+"			group by	T.id_seksi"
					+"		) PART on PART.id_seksi	= SEK.id_seksi"
					+""
					+"	where		SEK.id_wilayah = "+ id_wilayah
					+"	order by	SEK.nama_seksi";

		} else {
			db_q	="	select		WIL.id_wilayah			as id"
					+"	,			WIL.nama_wilayah		as nama"
					+"	,			isnull (TARGET.v, 0)	as target"
					+"	,			isnull (PART.v, 0)		as partisipasi"
					+"	,			100						as target_percent"
					+"	,			round ((isnull (PART.v,0) / cast (isnull (nullif (TARGEt.v, 0), 1) as float)) * 100, 2, 1)	as partisipasi_percent"
					+"	from		r_wilayah				WIL"
					+""
					+"	left join	("
					+"			select		WIL.id_wilayah"
					+"			,			"+ target_bln +"		as v"
					+"			from		t_stop_target_pegawai	T"
					+"			inner join	r_pegawai				PEG	on PEG.nipg			= T.nipg"
					+"			inner join	r_seksi					SEK	on SEK.id_seksi		= PEG.id_seksi"
					+"			inner join	r_wilayah				WIL on WIL.id_wilayah	= SEK.id_wilayah"
					+"			where		T.year					= "+ year
					+"			and			PEG.status_pegawai		= '1'"
					+"			group by	WIL.id_wilayah"
					+"		) TARGET on TARGET.id_wilayah = WIl.id_wilayah"
					+""
					+"	left join	("
					+"			select		WIL.id_wilayah"
					+"			,			count (*)	as	v"
					+"			from		t_stop		T"
					+"			inner join	r_seksi		SEK	on SEK.id_seksi		= T.id_seksi"
					+"			inner join	r_wilayah	WIL on WIL.id_wilayah	= SEK.id_wilayah"
					+"			where		status_aktif	= '1'"
					+"			and			status			in (1,2)"
					+"			and			T.year			= "+ year
					+"			and			T.tanggal		>= cast ('"+ part_tgl_1 +"' as datetime)"
					+"			and			T.tanggal		<= cast ('"+ part_tgl_2 +"' as datetime)"
					+"			group by	WIL.id_wilayah"
					+"		) PART on PART.id_wilayah = WIL.id_wilayah"
					+""
					+"	order by	WIL.nama_wilayah";
		}
	}

	db_stmt	= db_con.createStatement ();
	db_rs	= db_stmt.executeQuery (db_q);
	data	= new JSONArray ();
	while (db_rs.next ()) {
		datum = new JSONArray ();
		datum.put (db_rs.getString ("nama"));
		datum.put (db_rs.getInt ("target"));
		datum.put (db_rs.getInt ("partisipasi"));
		datum.put (db_rs.getInt ("target_percent"));
		datum.put (db_rs.getInt ("partisipasi_percent"));

		data.put (datum);
	}

	out.print (data);
} catch (Exception e) {
	_return.put ("success", false);
	_return.put ("info", e);
	_return.put ("query", db_q);
	out.print (_return);
}
%>
