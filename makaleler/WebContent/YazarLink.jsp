<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<% request.setCharacterEncoding ("UTF-8"); %>
<%@page import="java.security.MessageDigest" %>
<!DOCTYPE html>
<html>
<head>
<title>Yeni Sifre</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
table.center {
  margin-left: auto; 
  margin-right: auto;
}
</style>
</head>
<body>
 <jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler"></jsp:useBean>
 <jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="page" ></jsp:useBean>
<%String randomsifre=String.valueOf(session.getAttribute("randomsifre"));%>
  <div class="container"> 
<table class="center">  
       <tr>
        <th>YENİ ŞİFRENİZ</th>  
    </tr>
    <tr>
      <td><%out.println(randomsifre);%></td>
    </tr>
</table>
</div>
</body>
</html>