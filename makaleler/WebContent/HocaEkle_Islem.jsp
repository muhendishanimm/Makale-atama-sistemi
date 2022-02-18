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
</head>
<body>
<jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler" scope="page"></jsp:useBean>
<jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="page" ></jsp:useBean>
<%
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
for (int i = 0; i < max_uzunluk - 4; i++) {
  sb.append(allArray[random.nextInt(allArray.length)]);}
String randomsifre=sb.toString();
System.out.println("random sifre "+randomsifre);
boolean sonuc=false;
DateFormat dateformat = new SimpleDateFormat("dd/MM/yy");
Date dateobj = new Date();
String Hocaka=request.getParameter("HocaKullaniciAdi");
//String HocaSf=request.getParameter("HocaSifre");
String HocaAdi=request.getParameter("HocaAdSoyad");
String HocaMail=request.getParameter("HocaMail");
String Puan="0";
String Pozisyon="Hoca";
int Alani =(Integer.parseInt(request.getParameter("ktg")));
String HocaTarih=dateformat.format(dateobj);
//md5
String plain = randomsifre;
System.out.println("plain "+ plain);
MessageDigest  md5 = MessageDigest .getInstance("MD5");
md5.update(plain.getBytes());
byte[] digest = md5.digest();
StringBuffer hex = new StringBuffer();
for (int j = 0; j < digest.length; j++) {
plain = Integer.toHexString(0xFF & digest[j]);
if (plain.length() < 2) {
plain = "0" + plain;}
hex.append(plain);}
String Md5=hex.toString();
System.out.println("md5 "+Md5);   
System.out.println(Hocaka);
System.out.println(Md5);
System.out.println(HocaAdi);
System.out.println(HocaMail);
System.out.println(Puan);
System.out.println(Pozisyon);
System.out.println(Alani);
sayiNesnesi.setHocaKullaniciAdi(Hocaka);
sayiNesnesi.setHocaSifre(Md5);
sayiNesnesi.setHocaAdSoyad(HocaAdi);
sayiNesnesi.setHocaMail(HocaMail);
sayiNesnesi.setPuan(Puan);
sayiNesnesi.setPozisyon(Pozisyon);
sayiNesnesi.setKtgId(Alani);
sayiNesnesi.setHocaTarih(HocaTarih);
sonuc=sayiCrud.hocaekle(sayiNesnesi);
if(sonuc==true){
    String result;
    final String to = HocaMail;
    final String subject = " Makale Sistemine Kaydınız Başarılı ";
    final String messg ="Kullanıcı Adınız:  "+Hocaka+"  Şireniz:  "+randomsifre;
    final String from = "sunucuproje@gmail.com";
    final String pass = "Sunucu123";
    String host = "smtp.gmail.com";
    Properties properties = System.getProperties();
    properties.put("mail.smtp.host", "smtp.gmail.com");
    properties.put("mail.smtp.port", "587");//587
    properties.put("mail.smtp.starttls.enable", "true");
    properties.put("mail.smtp.auth", "true"); 
    Session mailSession = Session.getInstance(properties, new javax.mail.Authenticator() {
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(from, pass); } });
    try {
        MimeMessage message = new MimeMessage(mailSession);
        System.out.println(from);
        message.setFrom(new InternetAddress(from));
        message.addRecipient(Message.RecipientType.TO,
                new InternetAddress(to));
        message.setSubject(subject);
        message.setText(messg);
        Transport.send(message);
        result = "Mail Gönderme Başarılı....";} catch (MessagingException mex) {
        mex.printStackTrace();
        result = "Mail Gönder Başarısız....";}%>
<title>Mail Gönderiliyor... </title>
<h1><center><font color="blue">Mail Gönderiliyor...</font></h1>
<b><center><font color="red"><% out.println(result);%></b>
<%out.println("Veriler kaydedildi...");
    response.sendRedirect("Hocalar.jsp");}%>
</body>
</html>