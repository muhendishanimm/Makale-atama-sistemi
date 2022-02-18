<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<% request.setCharacterEncoding ("UTF-8"); %>
<%@page import="java.security.MessageDigest" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="session" ></jsp:useBean>
<jsp:useBean id="islemler" class="makaleler.VeriIslemler" scope="session"></jsp:useBean>
</head>
<%System.out.println("yazar giriş"); %>
<body>
<% 
boolean sonuc=false;
  //  int id=Integer.parseInt(String.valueOf(session.getAttribute("HbrID")));
    String ad = request.getParameter("YzrKullaniciAdi");
    String sifre = request.getParameter("YzrSifre");
    int i=0;
    int kayitsayisi=0;
//md5
String plain = sifre;
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

    ResultSet rs=islemler.yazarlistesi();
    	while(rs.next())
    	{
    		kayitsayisi+=1;
    		String dbad=rs.getString("YzrKullaniciAdi");
    		String dbsf=rs.getString("YzrSifre");
    	if(ad.equals(dbad)&& Md5.equals(dbsf))
    	{	int id=rs.getInt("YazarID");
    	    String YzrAd=rs.getString("YzrAdSoyad");
    	    int KtgIdsi=rs.getInt("KtgIdsi");
    		response.sendRedirect("YazarAnaSayfa.jsp" );
    		session.setAttribute("YazarID",id);
    		session.setAttribute("YzrAdSoyad",YzrAd);
    		session.setAttribute("KtgIdsi",KtgIdsi);


    		System.out.println(YzrAd);
    		break;
    	}
    	else if(!ad.equals(dbad)|| !Md5.equals(dbsf))
    	{
    		i+=1;	
    		System.out.println("hatali kullanici adi veya sifre"); 
    	}       
    	}
    	if (i==kayitsayisi){
    		System.out.println("hatali kullanici adi veya sifre i==kayitsayisi"); 
    		
    	}
    %>
</body>
</html>