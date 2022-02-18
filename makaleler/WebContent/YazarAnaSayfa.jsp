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
<%System.out.println("geldim yazar anasayfaya"); %>
<body class="page-index has-hero">
<%String YzrAd=String.valueOf(session.getAttribute("YzrAdSoyad"));
System.out.println(YzrAd);
int idd=Integer.parseInt(String.valueOf(session.getAttribute("YazarID")));%>

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
			<li class="icon-link">
                <a href="YazarAnaSayfa.jsp"><i class="fa fa-home"></i>&nbsp; AnaSayfa</a>
              </li>
                <li class="user-register"><a href="MakaleEkle.jsp"><i class="fa fa-align-justify"></i>&nbsp; Makale Yaz</a></li>
                <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>&nbsp; <%=YzrAd%><b class="caret"></b></a>
                <!-- Dropdown Menu -->
                <ul class="dropdown-menu">
                  <li><a href="YazarBilgi.jsp" tabindex="-1" class="menu-item">Kullanıcı Bilgileri</a></li>
                  <li><a href="YazarCikis.jsp" tabindex="-1" class="menu-item"><i class="fa fa-user"></i>&nbsp; Çıkış Yap</a></li>
                </ul>
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
        <h2>Makale Yazılarım</h2>

<table class="table table-bordered">
  <tr>
    <th>Baslik</th>
    <th>İçerik</th>
    <th>Tarih</th>
    <th>Durum</th>
    <th>Değerlendiren Hoca</th>
    <th>Kategorisi</th>
     <th>İncele</th>
    <th>Güncelle</th>
  </tr>
   <% 
  ResultSet rs=sayiCrud.makaleselectall();
  while(rs.next()) {
	  String yazari=rs.getString("Yazari");
	  String icerik=rs.getString("Icerik");
	  String yeni=icerik.substring(1,20);
  if(YzrAd.equals(yazari)){%>
  <tr>
    <td><%=rs.getString("Baslik") %></td>
    <td style="width:30%"><%=yeni %>...</td>
    <td><%=rs.getString("Tarih") %></td>
    <td><%=rs.getString("Durum") %></td>
    <td><%=rs.getString("DegerlendirenHoca") %></td>
    <td><%=rs.getString("KategoriAdi") %></td>
    <td><a href='YazarMakaleIncele.jsp?MakaleID=<%=rs.getString("MakaleID")%>' class="btn btn-more"><i class="fa fa-list-alt"></i>İncele</a></td>
   <td><a href='MakaleGuncelle.jsp?MakaleID=<%=rs.getString("MakaleID")%>' class="btn btn-more"><i class="fa fa-edit"></i>Güncelle</a></td>
  </tr>
  <% }} %>

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
