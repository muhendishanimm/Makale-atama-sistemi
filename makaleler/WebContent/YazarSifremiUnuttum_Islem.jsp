<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<% request.setCharacterEncoding ("UTF-8"); %>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%@page import="java.security.MessageDigest" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html><html><head>
<meta charset="ISO-8859-1">
<title>Insert title here</title></head>
 <jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler"></jsp:useBean>
 <jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="page" ></jsp:useBean>
<body>
<%
boolean sonuc=false;
String YzrMail=request.getParameter("YzrMail");
out.println(YzrMail);
if(sonuc==true)
	out.println("Veriler kaydedildi...");
%>
<%
int i=0;
int kayitsayisi=0;
DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
Date dateobj = new Date();
String Tarih=dateformat.format(dateobj);
ResultSet rs=sayiCrud.yazarlistesi();
	while(rs.next()) {
		kayitsayisi+=1;
		String dbYzrMail=rs.getString("YzrMail");
		System.out.println(dbYzrMail);
	if(YzrMail.equals(dbYzrMail)){
	session.setAttribute("dbUyeMail",dbYzrMail);
    response.sendRedirect("YazarGiris.jsp");
   //Creating a result for getting status that messsage is delivered or not!
    String result;
    // Get recipient's email-ID, message & subject-line from index.html page
    final String to = YzrMail;
    final String subject = "Yeni Şifre";
    final String messg ="http://localhost:8080/makaleler/YazarLink.jsp";
    // Sender's email ID and password needs to be mentioned
    final String from = "sunucuproje@gmail.com";
    final String pass = "Sunucu123";
    // Defining the gmail host
    String host = "smtp.gmail.com";
    // ozellik nesnesi olusturuluyor
    Properties properties = System.getProperties();
    // mail server ayarlari yapiliyor
    properties.put("mail.smtp.host", "smtp.gmail.com");
    properties.put("mail.smtp.port", "587");//587
    properties.put("mail.smtp.starttls.enable", "true");
    properties.put("mail.smtp.auth", "true"); 
    // Authorized the Session object.
    Session mailSession = Session.getInstance(properties, new javax.mail.Authenticator() {
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(from, pass); }});
    try {
        MimeMessage message = new MimeMessage(mailSession);
        System.out.println(from);
        message.setFrom(new InternetAddress(from));
        message.addRecipient(Message.RecipientType.TO,
                new InternetAddress(to));
        message.setSubject(subject);
        message.setText(messg);
        Transport.send(message);
        result = "Mail Gönderme Başarılı....";
        final int max_uzunluk = 9;
        java.util.Random random = new java.util.Random();
        final String number= "123456789";
        final String kucuk_karakter = "abcdefghjkmnpqrstuvwxyz";
        final String buyuk_karakter = "ABCDEFGHJKMNPQRSTUVWXYZ";
        final String ALL = number + kucuk_karakter + buyuk_karakter;
        final char[] buyuk_karakterArray = buyuk_karakter.toCharArray();
        final char[] kucuk_karakterArray = kucuk_karakter.toCharArray();
        final char[] numberArray = number.toCharArray();
        final char[] allArray = ALL.toCharArray();
        StringBuilder sb = new StringBuilder();
        sb.append(kucuk_karakterArray[random.nextInt(kucuk_karakterArray.length)]);
        sb.append(buyuk_karakterArray[random.nextInt(buyuk_karakterArray.length)]);
        sb.append(numberArray[random.nextInt(numberArray.length)]);
        for (int a = 0; a < max_uzunluk - 4; a++) {
            sb.append(allArray[random.nextInt(allArray.length)]);}
        String randomsifre=sb.toString();
        System.out.println("random sifre "+randomsifre);
        session.setAttribute("randomsifre",randomsifre);
        System.out.println("bu mail "+YzrMail);
        String plainText = randomsifre;
        MessageDigest  mdAlgorithm = MessageDigest .getInstance("MD5");
        mdAlgorithm.update(plainText.getBytes());
        byte[] digest = mdAlgorithm.digest();
        StringBuffer hexString = new StringBuffer();
        for (int b = 0; b < digest.length; b++) {
            plainText = Integer.toHexString(0xFF & digest[b]);
            if (plainText.length() < 2) {
                plainText = "0" + plainText;}
            hexString.append(plainText);}
        String md5=hexString.toString();
        System.out.print("md5li "+hexString.toString());
        sayiNesnesi.setYzrSifre(md5);
        sayiNesnesi.setYazarTarih(Tarih);
        boolean islemSonucu=sayiCrud.yazarSifreguncelle(sayiNesnesi,YzrMail);
        } catch (MessagingException mex) {
        mex.printStackTrace();
        result = "Mail Gönder Başarısız....";}
%>
<title>Mail Gönderiliyor... </title>

<h1><center><font color="blue">Mail Gönderiliyor...</font></h1>

<b><center><font color="red"><% out.println(result);%></b>

<%  break;
}
	else if(!YzrMail.equals(dbYzrMail))
	{
		i+=1;	
		System.out.println("hatalı üye mail"); 
	}  
	}
	if (i==kayitsayisi){
		System.out.println("Böyle bir mail yok"); 
		response.sendRedirect("UyeSifremiUnuttum.jsp" );
	}
	%>
</body>
</html>