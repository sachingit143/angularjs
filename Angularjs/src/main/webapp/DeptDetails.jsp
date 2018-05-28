<%@page import="com.lok.dept.DeptDetails"%>
<%@page import="java.security.interfaces.RSAKey"%>
<%@page import="java.sql.*,java.util.*,com.*,com.google.gson.*" language="java" %>
<% 
String MY_DRIVER="oracle.jdbc.driver.OracleDriver";
String URL="jdbc:oracle:thin:@localhost:1521:xe";
String USRNAME="system";
String PASSWORD="manager";

Connection con=null;
Statement st=null;
ResultSet res=null;

try{
Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection(URL, USRNAME, PASSWORD);
st=con.createStatement();

res=st.executeQuery("select * from depttt");
ArrayList<DeptDetails> listdept=new ArrayList();
while(res.next()){
DeptDetails dep=new DeptDetails();

dep.setDeptno(res.getInt(1));
dep.setEmpname(res.getString(2));
dep.setSal(res.getInt(3));
listdept.add(dep);
}//while

Gson gsonobj=new Gson();
String jsonData=gsonobj.toJson(listdept);

response.setContentType("Application/json");
response.getWriter().write(jsonData);
}//try

catch(Exception e){
e.printStackTrace();
}//catch

finally{
st.close();
con.close();
}//finally
 %>