<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<% request.setCharacterEncoding ("UTF-8"); %>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html><html><head>
<meta charset="ISO-8859-1">
<title>Insert title here</title></head><body>
<jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler" scope="page"></jsp:useBean>
<jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="page" ></jsp:useBean>
<%
boolean sonuc=false;
DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
Date dateobj = new Date();
String Baslik=request.getParameter("Baslik");
String Icerik=request.getParameter("Icerik");
String Tarih=dateformat.format(dateobj);
String YzrAd=String.valueOf(session.getAttribute("YzrAdSoyad"));
String Durum="Değerlendirilmedi";
String DegerlendirenHoca="-";
int KategoriId=Integer.parseInt(String.valueOf(session.getAttribute("KtgIdsi")));
//int KategoriId =(Integer.parseInt(request.getParameter("deneme")));
//String kategori=request.getParameter("KtgAdi");
//int uKategori=Integer.valueOf(kategori);
System.out.println("aldığını yazdır"+KategoriId);
sayiNesnesi.setBaslik(Baslik);
sayiNesnesi.setIcerik(Icerik);
sayiNesnesi.setTarih(Tarih);
sayiNesnesi.setYazari(YzrAd);
sayiNesnesi.setDurum(Durum);
sayiNesnesi.setDegerlendirenHoca(DegerlendirenHoca);
sayiNesnesi.setKategoriId(KategoriId);
sonuc=sayiCrud.makaleekle(sayiNesnesi);
if(sonuc==true)
	out.println("Veriler kaydedildi...");
    response.sendRedirect("YazarAnaSayfa.jsp");
%>
</body>
</html>