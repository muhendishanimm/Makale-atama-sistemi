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
<%String HocaAd=String.valueOf(session.getAttribute("HocaAdSoyad"));
System.out.println("editor "+HocaAd);
int idd=Integer.parseInt(String.valueOf(session.getAttribute("HocaID")));%>
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
                <a href="HocaGelenMakale.jsp"><i class="fa fa-home"></i>&nbsp; AnaSayfa</a>
              </li>
               <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>&nbsp; <%=HocaAd%><b class="caret"></b></a>
                <!-- Dropdown Menu -->
                <ul class="dropdown-menu">
                  <li><a href="HocaBilgi.jsp" tabindex="-1" class="menu-item">Kullanıcı Bilgileri</a></li>
                  <li><a href="HocaCikis.jsp" tabindex="-1" class="menu-item"><i class="fa fa-user"></i>&nbsp; Çıkış Yap</a></li>
                </ul>
              </li>    </ul>           
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- ======== içerik kısmı ======== -->
  <div id="content">
    <div class="showcase block block-border-bottom-grey">
      <div class="container">
      
    <%int  MakaleID=Integer.parseInt(request.getParameter("MakaleID"));
   String Baslik, Icerik, Durum,DegerlendirenHoca;
   ResultSet rs=sayiCrud.makaleselectdata( MakaleID);
   if (rs.next()){
	  Durum=rs.getString("Durum");
	  DegerlendirenHoca=rs.getString("DegerlendirenHoca");
	  Baslik=rs.getString("Baslik");
	  Icerik=rs.getString("Icerik");
   	session.setAttribute("MakaleID", MakaleID);
   	if(DegerlendirenHoca.equals(HocaAd)){
   %>
        <div class="item-carousel" data-toggle="owlcarousel" data-owlcarousel-settings='{"items":4, "pagination":false, "navigation":true, "itemsScaleUp":true}'>
          <div class="item">
        
<form action="MakaleEkle_Islem.jsp" class="form-group" method="post">
<label>Başlık</label>
<div> 
        <input type="text" style="width: 600px; height: 40px;"  class="form-control"  name="Baslik" value="<%=rs.getString("Baslik")%>" required=""disabled="disabled"/>  
    </div>
 	<label>İçerik</label>
<div> 
           <textarea type="text" style="width: 600px; height: 400px;" name="Icerik" class="form-control" required="" disabled="disabled"><%=rs.getString("Icerik")%> </textarea>   
    </div><%if(Durum.equals("Değerlendirme Bekleniyor")){ %>
    <br>
    <td><a href='HocaMakaleKabul.jsp?MakaleID=<%=rs.getString("MakaleID")%>' style="color:Blue" class="btn btn-more"><i class="fa fa-check"></i>Kabul Et</a></td>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<td><a href='HocaMakaleRed.jsp?MakaleID=<%=rs.getString("MakaleID")%>' style="color:Red" class="btn btn-more"><i class="fa fa-remove"></i>Red Et</a></td>
  
  <%}
    else{%>
    <br>
    <td><a href=''  class="btn btn-more"><i class="fa fa-file"></i>Değerlendir</a></td>	  	
   <% }
    }} %>
</form> 
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
