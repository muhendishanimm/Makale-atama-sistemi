<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<% request.setCharacterEncoding ("UTF-8"); %>
<%@page import="java.security.MessageDigest" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="session" ></jsp:useBean>
<jsp:useBean id="islemler" class="makaleler.VeriIslemler" scope="session"></jsp:useBean>
</head>
<body>
<% 
boolean sonuc=false;
  //  int id=Integer.parseInt(String.valueOf(session.getAttribute("HbrID")));
    String ad = request.getParameter("HocaKullaniciAdi");
    String sifre = request.getParameter("HocaSifre");
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

DateFormat dateformat = new SimpleDateFormat("dd/MM/yy");
Date dateobj = new Date();
String bugun=dateformat.format(dateobj);
Date bugunt=dateformat.parse(bugun);

    ResultSet rs=islemler.hocalistesi();
   
    	while(rs.next())
    	{  String HocaTarih=rs.getString("HocaTarih");
  	       Date HocaTariht=dateformat.parse(HocaTarih);
  	       long fark = bugunt.getTime() - HocaTariht.getTime();
  	       long gun= (fark  / (1000 * 60 * 60 * 24))  % 365;
  	       System.out.println("kaç gün olmuş "+gun);
    		
  	       kayitsayisi+=1;
    	   String dbad=rs.getString("HocaKullaniciAdi");
    	   String dbsf=rs.getString("HocaSifre");
    	if(ad.equals(dbad)&& Md5.equals(dbsf))
    	{	
    		if(gun>30){
    			int id=rs.getInt("HocaID");
        	    String HocaAd=rs.getString("HocaAdSoyad");
        	    String HocaMail=rs.getString("HocaMail");
        		response.sendRedirect("HocaSifreGuncelle.jsp" );
        		session.setAttribute("HocaID",id);
        		session.setAttribute("HocaAdSoyad",HocaAd);
        		session.setAttribute("HocaMail",HocaMail);
        		break;
    		}
    		else{
    		int id=rs.getInt("HocaID");
    	    String HocaAd=rs.getString("HocaAdSoyad");
    	    String HocaMail=rs.getString("HocaMail");
    		response.sendRedirect("HocaGelenMakale.jsp" );
    		session.setAttribute("HocaID",id);
    		session.setAttribute("HocaAdSoyad",HocaAd);
    		session.setAttribute("HocaMail",HocaMail);
    		break;
    		}
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