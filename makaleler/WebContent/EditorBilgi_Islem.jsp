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
</head>
<jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler" scope="page"></jsp:useBean>
<jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="page" ></jsp:useBean>

<body>
<%
boolean sonuc=false;
DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
Date dateobj = new Date();
String Tarih=dateformat.format(dateobj);
int idd=Integer.parseInt(String.valueOf(session.getAttribute("EditorID")));
System.out.println(idd);
String KullaniciAdi=request.getParameter("EditorKullaniciAdi");
String AdSoyad=request.getParameter("EditorAdSoyad");
String EditorMail=request.getParameter("EditorMail");
String Sifre=request.getParameter("EditorSifre");
String YeniSifre=request.getParameter("YeniSifre");
String SifreTekrar=request.getParameter("SifreTekrar");

System.out.println(KullaniciAdi);
System.out.println(AdSoyad);
System.out.println(EditorMail);
System.out.println(Sifre);
System.out.println(YeniSifre);
System.out.println(SifreTekrar);
System.out.println(Tarih);
//md5
String plain = Sifre;
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
String Md5Sifre=hex.toString();
System.out.println("md5 "+Md5Sifre);

//md5 yenisifre
String plainyenisifre = YeniSifre;
System.out.println("plain "+ plainyenisifre);
MessageDigest  md5yenisifre = MessageDigest .getInstance("MD5");
md5yenisifre.update(plainyenisifre.getBytes());
byte[] digestyenisifre = md5yenisifre.digest();
StringBuffer hexyenisifre = new StringBuffer();
for (int a = 0; a < digestyenisifre.length; a++) {
plainyenisifre = Integer.toHexString(0xFF & digestyenisifre[a]);
if (plainyenisifre.length() < 2) {
plainyenisifre = "0" + plainyenisifre;
}
hexyenisifre.append(plainyenisifre);
}
String Md5YeniSifre=hexyenisifre.toString();
System.out.println("Md5YeniSifre "+Md5YeniSifre);

//md5 sifretekrar
String plainsifretekrar = SifreTekrar;
System.out.println("plain "+ plainsifretekrar);
MessageDigest  md5sifretekrar = MessageDigest .getInstance("MD5");
md5sifretekrar.update(plainsifretekrar.getBytes());
byte[] digestsifretekrar = md5sifretekrar.digest();
StringBuffer hexsifretekrar = new StringBuffer();
for (int b = 0; b< digestsifretekrar.length; b++) {
plainsifretekrar = Integer.toHexString(0xFF & digestsifretekrar[b]);
if (plainsifretekrar.length() < 2) {
plainsifretekrar = "0" + plainsifretekrar;
}
hexsifretekrar.append(plainsifretekrar);
}
String Md5sifretekrar=hexsifretekrar.toString();
System.out.println("Md5sifretekrar "+Md5sifretekrar);

ResultSet rs=sayiCrud.editorlistesi();
while (rs.next()){
	int AlinanID=rs.getInt("EditorID");
	System.out.println("buda eşlecek "+ AlinanID);
	if(idd==AlinanID){
		String dbsifre=rs.getString("EditorSifre");
		if(Md5Sifre.equals(dbsifre)){
			if(Md5YeniSifre.equals(Md5sifretekrar)){
				sayiNesnesi.setEditorSifre(Md5sifretekrar);
				sayiNesnesi.setEditorMail(EditorMail);
				sayiNesnesi.setEditorTarih(Tarih);
				boolean islemSonucu=sayiCrud.editorguncelle(sayiNesnesi,idd);
				if (islemSonucu==true){
					  response.sendRedirect("Makaleler.jsp" );
				}}}}}
%>
</body>
</html>