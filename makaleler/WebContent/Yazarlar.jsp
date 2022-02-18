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
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Makale Sistemi</title>
  <link href="Flexor/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="Flexor/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="Flexor/lib/owlcarousel/owl.carousel.min.css" rel="stylesheet">
  <link href="Flexor/lib/owlcarousel/owl.theme.min.css" rel="stylesheet">
  <link href="Flexor/lib/owlcarousel/owl.transitions.min.css" rel="stylesheet">
  <link href="Flexor/css/style.css" rel="stylesheet">
  <jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler"></jsp:useBean>
  <jsp:useBean id="sayiNesnesi" class="makaleler.VeriBilgileri" scope="page" ></jsp:useBean>
</head>
<body class="page-index has-hero">
<%String EditorAd=String.valueOf(session.getAttribute("EditorAdSoyad"));
System.out.println(EditorAd);
int idd=Integer.parseInt(String.valueOf(session.getAttribute("EditorID")));
DateFormat dateformat = new SimpleDateFormat("dd/MM/yy");
Date dateobj = new Date();
 String bugun=dateformat.format(dateobj);%>
  <div id="background-wrapper" class="buildings" data-stellar-background-ratio="0.1">
    <div id="navigation" class="wrapper">
      <!--Hidden Header Region-->
      <div class="header-hidden collapse">
        <div class="header-hidden-inner container">
        </div>
      </div>
      <!--burası en üstteki siyah yer-->
      <div class="header">
        <div class="header-inner container">
          <div class="row">
            <div class="col-md-4">
            </div>
          </div>
        </div>
      </div>
      <div class="container">
        <div class="navbar navbar-default">
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav" id="main-menu">

                <li class="user-register"><a href="Yazarlar.jsp"><i class="fa fa-users "></i>&nbsp; Yazarlar</a></li>
                <li class="user-login"><a href="Makaleler.jsp"><i class="fa fa-align-justify"></i>&nbsp; Makaleler</a></li> 
                <li class="user-login"><a href="Hocalar.jsp"><i class="fa fa-users"></i>&nbsp; Hocalar</a></li>       
               <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>&nbsp; <%=EditorAd%><b class="caret"></b></a>
                <!-- Dropdown Menu -->
                <ul class="dropdown-menu">
                  <li><a href="EditorBilgi.jsp" tabindex="-1" class="menu-item">Kullanıcı Bilgileri</a></li>
                  <li><a href="EditorCikis.jsp" tabindex="-1" class="menu-item"><i class="fa fa-user"></i>&nbsp; Çıkış Yap</a></li>
                </ul>
              </li>   
              </ul>            
          </div>
        </div>
      </div>
    </div>
  </div>
<%   ResultSet rshoca=sayiCrud.hocaselectall();
int HocaID=0;
String Kategorisi="almadı";
String pozisyon="pozisyonu yok";
String HocaAdSoyad="hocaaddı";
while(rshoca.next()) { 
	      HocaID=rshoca.getInt("HocaID");
	      HocaAdSoyad=rshoca.getString("HocaAdSoyad");
		  Kategorisi=rshoca.getString("KategoriAdi");
		  pozisyon=rshoca.getString("Pozisyon");}

ResultSet rs=sayiCrud.makaleselectall();
String makaletarih="";
int MakaleID=0;
String DegerlendirenHoca="var";
Date bugunt=dateformat.parse(bugun);
while(rs.next()) { 
	 
	  String Durum=rs.getString("Durum");
	  String Icerik=rs.getString("Icerik");
	  String Kategori=rs.getString("KategoriAdi");
	  makaletarih=rs.getString("Tarih");
	  Date makaletariht=dateformat.parse(makaletarih);
	  String yeni=Icerik.substring(1,20);
	  long fark = bugunt.getTime() - makaletariht.getTime();
	  long gun= (fark  / (1000 * 60 * 60 * 24))  % 365;
	  System.out.println("kaç gün olmuş "+gun);
	    if(gun>5){
	    	if(Durum.equals("Değerlendirme Bekleniyor")){
	    	MakaleID=rs.getInt("MakaleID");
	    	DegerlendirenHoca=rs.getString("DegerlendirenHoca");
	    	 System.out.println("MakaleID "+MakaleID);
	    	 System.out.println("DegerlendirenHoca "+DegerlendirenHoca);
	    	 pozisyon="Hoca";
				sayiNesnesi.setPozisyon(pozisyon);

				boolean islemSonucuu=sayiCrud.hocapozisyongeri(sayiNesnesi,DegerlendirenHoca);
				if (islemSonucuu==true){
	    	 String durum="Değerlendirilmedi";
	       	    String Tarih=dateformat.format(dateobj);
	       	    DegerlendirenHoca="-";
	       	    sayiNesnesi.setTarih(Tarih);
	       		sayiNesnesi.setDurum(durum);
	       		sayiNesnesi.setDegerlendirenHoca(DegerlendirenHoca);
	       		boolean islemSonucu=sayiCrud.makaleguncelle(sayiNesnesi,MakaleID);
	       		if (islemSonucu==true){
	       			System.out.println("İşlemlerin hepsini yaptım");
    				}}}}
	    if(gun>=14)//14. günde olduğu için büyük eşit
	    {
	    	if(Durum.equals("Değerlendiriliyor"))
	    	{
	    		MakaleID=rs.getInt("MakaleID");
	    		DegerlendirenHoca=rs.getString("DegerlendirenHoca");
	    		 ResultSet rsh=sayiCrud.hocaselectall();
	    		 while(rsh.next()) { 
	    			 HocaAdSoyad=rsh.getString("HocaAdSoyad");
	    			 if(DegerlendirenHoca.equals(HocaAdSoyad))
	    					 {
	    				      String HocaMail=rsh.getString("HocaMail");
	    				      System.out.println("Hocamail "+HocaMail);
	         					   //Creating a result for getting status that messsage is delivered or not!
	         					    String result;
	         					    // Get recipient's email-ID, message & subject-line from index.html page
	         					    final String to = HocaMail;
	         					    final String subject = " Makale Sisteminden Bilgilendirme";
	         					    final String messg ="Değerlendirdirmekte Olduğunuz Makaleye  DEğerlendirme Raporu Yüklemek İçin Son Bir Haftasınız Kalmıştır.";
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
	         					
	         				   }
	         				}
	    					 }
	    			 }
	    if(gun>21){
	    	if(Durum.equals("Değerlendiriliyor")){
		    	MakaleID=rs.getInt("MakaleID");
		    	DegerlendirenHoca=rs.getString("DegerlendirenHoca");
		    	 System.out.println("MakaleID "+MakaleID);
		    	 System.out.println("DegerlendirenHoca "+DegerlendirenHoca);
		    	 pozisyon="Hoca";
					sayiNesnesi.setPozisyon(pozisyon);

					boolean islemSonucuu=sayiCrud.hocapozisyongeri(sayiNesnesi,DegerlendirenHoca);
					if (islemSonucuu==true){
		    	 String durum="Değerlendirilmedi";
		       	    String Tarih=dateformat.format(dateobj);
		       	    DegerlendirenHoca="-";
		       	    sayiNesnesi.setTarih(Tarih);
		       		sayiNesnesi.setDurum(durum);
		       		sayiNesnesi.setDegerlendirenHoca(DegerlendirenHoca);
		       		boolean islemSonucu=sayiCrud.makaleguncelle(sayiNesnesi,MakaleID);
		       		if (islemSonucu==true){
		       			System.out.println("İşlemlerin hepsini yaptım 21 gün için");
	    				}}}
	    	if(Durum.equals("Değerlendirildi"))
	    	{
	    		System.out.println("Hiçbir sorun yok");
	    	}
	    	
	    }
	    	
} %>
  <!-- ======== içerik kısmı ======== -->
  <div id="content">
    <div class="showcase block block-border-bottom-grey">
      <div class="container">
      
        <div class="item-carousel" data-toggle="owlcarousel" data-owlcarousel-settings='{"items":4, "pagination":false, "navigation":true, "itemsScaleUp":true}'>
          <div class="item">
        <h2>YAZARLAR</h2>

<table class="table table-bordered">
  <tr>
    <th>AdSoyad</th>
    <th>Mail</th>
    <th>Alanı</th>
  </tr>
   <% 
  ResultSet rsyazar=sayiCrud.yazarselectall();
  System.out.println("burda ");
  while(rsyazar.next()) {
	  System.out.println("burda mısın");%>
  <tr>
    <td><%=rsyazar.getString("YzrAdSoyad") %></td>
    <td><%=rsyazar.getString("YzrMail") %></td>
    <td><%=rsyazar.getString("KategoriAdi") %></td>
   
  </tr>
  <%} %>

</table>
          </div>
        </div>
      </div>
    </div>
  </div>

   <!-- ======== alt kısmı ======== -->
  <footer id="footer" class="block block-bg-grey-dark" data-block-bg-img="Flexor/img/bg_footer-map.png" data-stellar-background-ratio="0.4">
    <div class="container">
      <div class="row" id="contact">
       
      </div>
    </div>
  </footer>
  <script src="Flexor/lib/jquery/jquery.min.js"></script>
  <script src="Flexor/lib/bootstrap/js/bootstrap.min.js"></script>
  <script src="Flexor/lib/owlcarousel/owl.carousel.min.js"></script>
  <script src="Flexor/lib/stellar/stellar.min.js"></script>
  <script src="Flexor/lib/waypoints/waypoints.min.js"></script>
  <script src="Flexor/lib/counterup/counterup.min.js"></script>
  <script src="Flexor/contactform/contactform.js"></script>
  <script src="Flexor/js/custom.js"></script>
  <script src="Flexor/js/color-switcher.js"></script>
  <script src="Flexor/contactform/contactform.js"></script>
</body>
</html>
