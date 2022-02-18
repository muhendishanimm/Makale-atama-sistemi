<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
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
//seçilen makaleyi aldım makalenin kategorisini aldım   
   int  MakaleID=Integer.parseInt(request.getParameter("MakaleID"));
   int KategoriId=0;
   ResultSet rs=sayiCrud.makaleselectdata( MakaleID);
   if (rs.next()){
	   KategoriId=rs.getInt("KategoriId");
	   System.out.println("aldım kategorisini"+KategoriId);
   	session.setAttribute("MakaleID", MakaleID);
   }
 //hocanın pozisyonu hakem değilse ve makalenin kategorisi ile hocanın kategorisi eşit ise 
 //puanlar arasında karşılaştırma yaparak en küçük puanlı hocayı bul 
   int i=0;
   int enkucukpuan=-1;//hocalar sisteme 0 puanla kayıt olduğu için
   int HocaID=0;
   String HocaAdSoyad="";
   ResultSet rsh=sayiCrud.hocaselectall();
   while(rsh.next()) { 
   	int KtgId=rsh.getInt("KtgId");
    System.out.println("aldım hoca kategorisini"+KtgId);
   	String Pozisyon=rsh.getString("Pozisyon");
    System.out.println("aldım hoca Pozisyon"+Pozisyon);
   	if(Pozisyon.equals("Hoca"))
   	{
       if(KategoriId==KtgId)
       		{
       	if(i==0){
       		enkucukpuan=Integer.parseInt(rsh.getString("Puan"));   		    		
       	}    	    	
       	int Puan=Integer.parseInt(rsh.getString("Puan"));
           if(Puan<enkucukpuan)
           {
        	   enkucukpuan=Puan;            	      	
           }
           i+=1;
    }}
   	}
//puanı en küçük olan hocanın adını alma
   ResultSet rshoca=sayiCrud.hocaselectall();
   while(rshoca.next()) {
   	int puan=Integer.parseInt(rshoca.getString("Puan"));
 	int KtgId=rshoca.getInt("KtgId");
   	String Pozisyon=rshoca.getString("Pozisyon");
   	System.out.println("Pozisyon "+Pozisyon);
   	if(!Pozisyon.equals("Hakem"))
   	{  		
   	 if(KategoriId==KtgId)
       		{  
       	if(puan==enkucukpuan)
       	{   			
       		HocaID=rshoca.getInt("HocaID");
       		HocaAdSoyad=rshoca.getString("HocaAdSoyad");
       		   //guncellemeyi burada yapmayı dene
       	//makale güncelleme içinde hoca güncelleme yapılacak
       		DateFormat dateformat = new SimpleDateFormat("dd/MM/yy");
       		Date dateobj = new Date();
       	    String durum="Değerlendirme Bekleniyor";
       	    String Tarih=dateformat.format(dateobj);
       	    String DegerlendirenHoca=HocaAdSoyad;
       	    sayiNesnesi.setTarih(Tarih);
       		sayiNesnesi.setDurum(durum);
       		sayiNesnesi.setDegerlendirenHoca(DegerlendirenHoca);

       		boolean islemSonucu=sayiCrud.makaleguncelle(sayiNesnesi,MakaleID);
       		if (islemSonucu==true){
       			
       			 String pozisyon="Hakem";
       				sayiNesnesi.setPozisyon(pozisyon);

       				boolean islemSonucuu=sayiCrud.hocapozisyonguncelle(sayiNesnesi,HocaID);
       				if (islemSonucuu==true){
       					
       					int j=0;
       					int kayitsayisi=0;
       					ResultSet rsmail=sayiCrud.hocaselectall();
       						while(rsmail.next()) {
       							kayitsayisi+=1;
       							String HocaMail=rsmail.getString("HocaMail");
       							System.out.println(HocaMail);
       							int dbhoca=rsmail.getInt("HocaID");
       						if(HocaID==dbhoca){
       						session.setAttribute("HocaMail",HocaMail);
       					   //Creating a result for getting status that messsage is delivered or not!
       					    String result;
       					    // Get recipient's email-ID, message & subject-line from index.html page
       					    final String to = HocaMail;
       					    final String subject = " Makale Sisteminden Bilgilendirme";
       					    final String messg ="Değerlendirebileceğiniz Bir Makale Sisteminize Gönderilmiştir. Sistemden Makaleyi Görüntüleyip Kabul veya Reddetedebilirsiniz. Onay İçin Süreniz 5 Gündür. Kabul Ederseniz Değerlendirmek için Süreniz 21 Gündür. Sisteme Gözat: http://localhost:8080/makaleler/HocaGiris.jsp";
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
       					            return new PasswordAuthentication(from, pass);
       					        }
       					    });
       					    try {

       					        // Create a default MimeMessage object.
       					        MimeMessage message = new MimeMessage(mailSession);
       					        // Set From: header field of the header.
       					        System.out.println(from);
       					        message.setFrom(new InternetAddress(from));
       					        // Set To: header field of the header.
       					        message.addRecipient(Message.RecipientType.TO,
       					                new InternetAddress(to));
       					        // Set Subject: header field
       					        message.setSubject(subject);
       					        // Now set the actual message
       					        message.setText(messg);
       					        // Send message
       					        Transport.send(message);
       					        result = "Mail Gönderme Başarılı....";
       					    } catch (MessagingException mex) {
       					        mex.printStackTrace();
       					        result = "Mail Gönder Başarısız....";
       					    }
       					%>
       					<title>Mail Gönderiliyor... </title>

       					<h1><center><font color="blue">Mail Gönderiliyor...</font></h1>

       					<b><center><font color="red"><% out.println(result);%></b>

       					<% break;}
       						else if(HocaID!=dbhoca)
       						{
       							j+=1;	
       							System.out.println("bu hocaya değil"); 
       						}  
       						}
       						if (j==kayitsayisi){
       							System.out.println("bu hocaya değil"); 
       						}
       					  response.sendRedirect("Makaleler.jsp");
       				   }
       				}
       	}
       	else{
       		System.out.println("hoca kalmadı"); 
       		response.sendRedirect("Makaleler.jsp");
       	}
       		}}
   	}

   %>
</body>
</html>