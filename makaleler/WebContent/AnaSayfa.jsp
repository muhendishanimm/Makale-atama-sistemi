<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<% request.setCharacterEncoding ("UTF-8"); %>
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
 
</head>
<body class="page-index has-hero">
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
              <div  class="navbar-slogan" style="text-align: center; font-weight: bold;">
                <h2  style="font-family: Verdana, sans-serif;">MAKALE DEĞERLENDİRME SİSTEMİ</h2>            
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="container">
        <div class="navbar navbar-default">
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav" id="main-menu">
              <li class="icon-link">
                <a href=""><i class="fa fa-home"></i>&nbsp; AnaSayfa</a>
              </li>
                <li class="user-login"><a href="YazarGiris.jsp"><i class="fa fa-user "></i>&nbsp; Yazar Giriş</a></li>
                <li class="user-login"><a href="HocaGiris.jsp"><i class="fa fa-user"></i>&nbsp; Hoca Giriş</a></li> 
                <li class="user-login"><a href="EditorGiris.jsp"><i class="fa fa-user"></i>&nbsp; Editor Giriş</a></li>    
               <li class="user-login"> 
                  <div class="navbar-text social-media social-media-inline pull-right">
          <form action="AnaSayfa.jsp" method="post">
                    
                           <input type="text" id="search" name="search" placeholder="Search">
                            <button type="submit" class="btn btn-more"><i class="fa fa-search"></i>Ara</button>
                             </form> 
          </div>
               
                           </li>
              </ul>            
          </div>
        </div>
      </div>
    </div>
  </div>
          
  <!-- ======== içerik kısmı ======== -->
  <div id="content">
    <div class="showcase block block-border-bottom-grey">
      <div class="container">
        <div class="item-carousel" data-toggle="owlcarousel" data-owlcarousel-settings='{"items":4, "pagination":false, "navigation":true, "itemsScaleUp":true}'>
          <div class="item">
            <div class="item-details bg-noise">
             <div class="container">
   <%  String arama=request.getParameter("search");
   System.out.println("arama"+arama);
   ResultSet rs;
   if(arama==null){
  rs=sayiCrud.makaleselectall(); }
     else {rs=sayiCrud.kategoriara(arama);}
  while(rs.next()) { 
	  String DegerlendirenHoca=rs.getString("DegerlendirenHoca");
	  String Icerik=rs.getString("Icerik");
	  String yeni=Icerik.substring(1,20);
	  if(!DegerlendirenHoca.equals("-")){ %>
    <h2><%=rs.getString("Baslik")%></h2>
    <h3><%=yeni%>...</h3>
    <h3><a href='HocaMakaleKabul.jsp?MakaleID=<%=rs.getString("MakaleID")%>' class="btn btn-more"><i class="fa fa-ellipsis-h"></i>Devamını Oku</a></h3>
   <%}}%>
      </div>       
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
   <!-- ======== yorum kısmı ======== -->
  <footer id="footer" class="block block-bg-grey-dark" data-block-bg-img="Flexor/img/bg_footer-map.png" data-stellar-background-ratio="0.4">
    <div class="container">
      <div class="row" id="contact">
        <div class="col-md-6">
          <h4 class="text-uppercase">
             Makalelerimize Yaptığınız Yorumlar Bizim Için Değerli
            </h4>
          <div class="form">
            <div id="sendmessage">Your message has been sent. Thank you!</div>
            <div id="errormessage"></div>
            <form action="" method="post" role="form" class="contactForm">
              <div class="form-group">
                <input type="text" name="name" class="form-control" id="name" placeholder="Your Name" data-rule="minlen:4" data-msg="Please enter at least 4 chars" />
                <div class="validation"></div>
              </div>
              <div class="form-group">
                <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" data-rule="email" data-msg="Please enter a valid email" />
                <div class="validation"></div>
              </div>
              <div class="form-group">
                <input type="text" class="form-control" name="subject" id="subject" placeholder="Subject" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" />
                <div class="validation"></div>
              </div>
              <div class="form-group">
                <textarea class="form-control" name="message" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="Message"></textarea>
                <div class="validation"></div>
              </div>
              <div class="text-center"><button type="submit">Send Message</button></div>
            </form>
          </div>
        </div>
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
