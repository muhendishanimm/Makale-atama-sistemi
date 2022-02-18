<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<% request.setCharacterEncoding ("UTF-8"); %>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler"></jsp:useBean>
 <jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="page" ></jsp:useBean>
</head>
<body>
<%
DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
Date dateobj = new Date();
String Baslik=request.getParameter("Baslik");
String Icerik=request.getParameter("Icerik");
String Tarih=dateformat.format(dateobj);
sayiNesnesi.setBaslik(Baslik);
sayiNesnesi.setIcerik(Icerik);
sayiNesnesi.setTarih(Tarih);
//out.println(String.valueOf(session.getAttribute("id_no")));
int id=Integer.parseInt(String.valueOf(session.getAttribute("MakaleID")));
boolean islemSonucu=sayiCrud.yazarmakaleguncelle(sayiNesnesi,id);
if (islemSonucu==true)
	out.println("Basariyla kaydedilmistir...");
    response.sendRedirect("YazarAnaSayfa.jsp");
%>
</body>
</html>