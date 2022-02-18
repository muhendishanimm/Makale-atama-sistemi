<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<% request.setCharacterEncoding ("UTF-8"); %>
<%@page import="java.security.MessageDigest" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="session" ></jsp:useBean>
<jsp:useBean id="islemler" class="makaleler.VeriIslemler" scope="session"></jsp:useBean>
</head>
<body>
<% 
boolean sonuc=false;
  //  int id=Integer.parseInt(String.valueOf(session.getAttribute("HbrID")));
    String ad = request.getParameter("EditorKullaniciAdi");
    String sifre = request.getParameter("EditorSifre");
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

    ResultSet rs=islemler.editorlistesi();
    	while(rs.next())
    	{
    		kayitsayisi+=1;
    		String dbad=rs.getString("EditorKullaniciAdi");
    		String dbsf=rs.getString("EditorSifre");
    	if(ad.equals(dbad)&& Md5.equals(dbsf))
    	{	int id=rs.getInt("EditorID");
    	    String EditorAd=rs.getString("EditorAdSoyad");
    		response.sendRedirect("Yazarlar.jsp" );
    		session.setAttribute("EditorID",id);
    		session.setAttribute("EditorAdSoyad",EditorAd);
    		break;
    	}
    	else if(!ad.equals(dbad)|| !Md5.equals(dbsf))
    	{
    		i+=1;	
    		System.out.println("hatali kullanici adi veya sifre"); 
    	}       
    	}
    	if (i==kayitsayisi){
    		System.out.println("hatali kullanici adi veya sifre"); 
    		
    	}
    %>
</body>
</html>