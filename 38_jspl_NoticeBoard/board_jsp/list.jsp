<%@ page contentType = "text/html;charset=utf-8" import="java.sql.*"%>

<%!
	Connection con;
	Statement stmt;
	public void jspInit(){   // DB연결
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:JAVA";
		String usr = "servlet";
		String pwd = "java";
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(url, usr, pwd);
			stmt = con.createStatement();
		}catch(ClassNotFoundException cbfe){
			System.out.println("Oracle driver loading fauled");
		}catch(SQLException se){
			System.out.println("se: " + se);
		}
	}
	public void jspDestroy(){   // DB연결해체
		try{
			if(stmt != null) stmt.close();
			if(con != null) con.close();
		}catch(SQLException se){}
		
	} 
%>

<meta charset='utf-8'>
<style>
	table, th, td {
	   border: 1px solid black;
	   border-collapse: collapse;
	}
	th, td {
	   padding: 5px;
	}
	a { text-decoration:none }
</style>
<center>
	<hr width='600' size='2' noshade>
	<h2>Simple Board with Servlet</h2>
		&nbsp;&nbsp;&nbsp;
	<a href='input.jsp'>글쓰기</a>
		&nbsp;&nbsp;&nbsp;
	<a href='../'>인덱스</a>
	<hr width='600' size='2' noshade>
	</center>
	<table border='1' width='600' align='center' cellpadding='2'>
	<tr>
		<th align='center' width='10%'>글번호</th>
		<th align='center' width='15%'>작성자</th>
		<th align='center' width='30%'>이메일</th>
		<th align='center' width='30%'>글제목</th>
		<th align='center' width='15%'>날짜</th>
	</tr>


<%
	ResultSet rs = null;
	String sql = "select * from BOARD order by seq desc";
	try{
		rs = stmt.executeQuery(sql);
		while(rs.next()){
			int seq = rs.getInt(1);
			String name = rs.getString(2);
			String email = rs.getString(3);
			String sbj = rs.getString(4);
			Date rdate = rs.getDate(6);    // Date는 util 하고 sql 패키지에 두개다 존재하므로 둘다 인포트 했을 경우에는 앞에다가 java.sql.Date 라고 써준다
%>
			<tr>
			<td align='center'><%=seq%></td>
			<td align='center'><%=name%></td>
			<td align='center'><%=email%></td>
			<td align='center'>
			<a href='content.jsp?seq=<%=seq%>'><%=sbj%></a>
			</td>
			<td align='center'><%=rdate%></td>
			</tr>
<%
			}
		}catch(SQLException se){
		}finally{
			try{
				if(rs != null) rs.close();
			}catch(SQLException se){}
		}
%>

</table>
<hr width='600' size='2' noshade>
</center>