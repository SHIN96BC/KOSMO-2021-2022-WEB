<%@ page contentType="text/html;charset=utf-8" import="javax.sql.DataSource, java.sql.*"%>
<jsp:useBean id="dbcp" class="sbc.dbcp.DbcpBean" scope="application"/>

<%
		
		String seqStr = request.getParameter("seq");
		int seq = -1;
		if(seqStr == null){
			response.sendRedirect("list.jsp");
			return;
		}
		seqStr = seqStr.trim();
		if(seqStr.length() == 0){
			response.sendRedirect("list.jsp");
			return;
		}else{
			try{
				seq = Integer.parseInt(seqStr);
			}catch(NumberFormatException nfe){
				response.sendRedirect("list.jsp");
				return;
			}
		}

		DataSource ds = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "delete from BOARD where SEQ=?";
		out.println("<script>");
		try{
			ds = dbcp.getDs();
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, seq);
			pstmt.executeUpdate();
		}catch(SQLException se){
		}finally{
			try{
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();  // �������� �޼ҵ� ȣ���ؼ� �ݴ´�.
			}catch(SQLException se){}
		}
		response.sendRedirect("list.jsp");
%>