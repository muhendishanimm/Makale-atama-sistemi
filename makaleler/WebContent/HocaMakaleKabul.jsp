<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<%request.setCharacterEncoding ("UTF-8"); %>
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
 int HocaID=Integer.parseInt(String.valueOf(session.getAttribute("HocaID")));
 String HocaAd=String.valueOf(session.getAttribute("HocaAdSoyad"));
 System.out.println("editor "+HocaAd);
//seçilen makaleyi aldım makalenin kategorisini aldım   
   int  MakaleID=Integer.parseInt(request.getParameter("MakaleID"));
   String Durum,Tarih,DegerlendirenHoca;
   ResultSet rs=sayiCrud.makaleselectdata( MakaleID);
   if (rs.next()){
	   Durum=rs.getString("Durum");
	   Tarih=rs.getString("Tarih");
	   System.out.println("aldım durum"+Durum);
   	session.setAttribute("MakaleID", MakaleID);
   }
   DateFormat dateformat = new SimpleDateFormat("dd/MM/yy");
   Date dateobj = new Date();
   String durum="Değerlendiriliyor";
   Tarih=dateformat.format(dateobj);
   DegerlendirenHoca=HocaAd;
   sayiNesnesi.setTarih(Tarih);
   sayiNesnesi.setDurum(durum);
   sayiNesnesi.setDegerlendirenHoca(DegerlendirenHoca);
	boolean islemSonucu=sayiCrud.makaleguncelle(sayiNesnesi,MakaleID);
	if (islemSonucu==true){	
				  response.sendRedirect("HocaGelenMakale.jsp");
				  
		 }
   %>
</body>
</html>