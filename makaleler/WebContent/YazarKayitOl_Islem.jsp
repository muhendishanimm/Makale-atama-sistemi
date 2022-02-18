<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<% request.setCharacterEncoding ("UTF-8"); %>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.security.MessageDigest" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler" scope="page"></jsp:useBean>
<jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="page" ></jsp:useBean>
</head>
<body>
<%boolean sonuc=false;
DateFormat dateformat = new SimpleDateFormat("dd/MM/yy");
Date dateobj = new Date();
String YzrAdSoyad=request.getParameter("YzrAdSoyad");
String YzrKullaniciAdi=request.getParameter("YzrKullaniciAdi");
String YzrSifre=request.getParameter("YzrSifre");
String SifreTekrar=request.getParameter("SifreTekrar");
String YzrMail=request.getParameter("YzrMail");
String YazarTarih=dateformat.format(dateobj);
int KtgIdsi =(Integer.parseInt(request.getParameter("ktg")));
//md5
String plain = YzrSifre;
System.out.println("plain "+ plain);
MessageDigest  md5 = MessageDigest .getInstance("MD5");
md5.update(plain.getBytes());
byte[] digest = md5.digest();
StringBuffer hex = new StringBuffer();
for (int j = 0; j < digest.length; j++) {
plain = Integer.toHexString(0xFF & digest[j]);
if (plain.length() < 2) {
plain = "0" + plain;
}
hex.append(plain);
}
String Md5=hex.toString();
System.out.println("md5 "+Md5);   

//md5
String plainst = SifreTekrar;
System.out.println("plainst "+ plainst);
MessageDigest  md5st = MessageDigest .getInstance("MD5");
md5st.update(plainst.getBytes());
byte[] digestst = md5st.digest();
StringBuffer hexst = new StringBuffer();
for (int a = 0; a < digestst.length; a++) {
plainst = Integer.toHexString(0xFF & digestst[a]);
if (plainst.length() < 2) {
plainst = "0" + plainst;
}
hexst.append(plainst);
}
String Md5st=hexst.toString();
System.out.println("md5st "+Md5st);

sayiNesnesi.setYzrAdSoyad(YzrAdSoyad);
sayiNesnesi.setYzrKullaniciAdi(YzrKullaniciAdi);
sayiNesnesi.setYzrSifre(Md5st);
sayiNesnesi.setYzrMail(YzrMail);
sayiNesnesi.setYazarTarih(YazarTarih);
sayiNesnesi.setKtgIdsi(KtgIdsi);

if(Md5.equals(Md5st)){
	
sonuc=sayiCrud.yazarekle(sayiNesnesi);
if(sonuc==true){
	out.println("Veriler kaydedildi...");
    response.sendRedirect("YazarGiris.jsp");}}%>
</body>
</html>