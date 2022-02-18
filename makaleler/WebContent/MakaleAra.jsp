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
<%String EditorAd=String.valueOf(session.getAttribute("EditorAdSoyad"));
System.out.println("editor "+EditorAd);
int idd=Integer.parseInt(String.valueOf(session.getAttribute("EditorID")));%>
  <div id="background-wrapper" class="buildings" data-stellar-background-ratio="0.1">
    <div id="navigation" class="wrapper">
      <!--Hidden Header Region-->
      <div class="header-hidden collapse">
        <div class="header-hidden-inner container">
        </div>
      </div>
       <%System.out.println("geldim"); %>
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

  <!-- ======== içerik kısmı ======== -->
  <div id="content">
    <div class="showcase block block-border-bottom-grey">
      <div class="container">
           <h2>Makaleler</h2>

<table class="table table-bordered">
  <tr>
    <th>Başlık</th>
    <th>İçerik</th>
    <th>Tarih</th>
    <th>Yazar</th>
    <th>Durum</th>
    <th>Değerlendiren Hoca</th>
    <th>Kategori</th>
    <th>Makaleyi İncele</th>
    <th>Değerlendirmeye Yönlendir</th>
  </tr>
   <% 
  String kategoriId=request.getParameter("ktgsi");
   
  ResultSet rs=sayiCrud.makaleselectall();
  while(rs.next()) { 
	  String Durum=rs.getString("Durum");
	  String ktg=rs.getString("KategoriAdi");
	  String Icerik=rs.getString("Icerik");
	  String yeni=Icerik.substring(1,20);
	  if(kategoriId.equals(ktg)){
  %>
  <tr>
    <td><%=rs.getString("Baslik") %></td>
    <td><%=yeni%>...</td>
    <td><%=rs.getString("Tarih") %></td>
    <td><%=rs.getString("Yazari") %></td>
    <td><%=rs.getString("Durum") %></td>
    <td><%=rs.getString("DegerlendirenHoca") %></td>
    <td><%=rs.getString("KategoriAdi") %></td>
    <td><a href='EditorMakaleIncele.jsp?MakaleID=<%=rs.getString("MakaleID")%>' class="btn btn-more"><i class="fa fa-ellipsis-h"></i>Makaleyi İncele</a></td>
    <%if(Durum.equals("Değerlendirilmedi")){ %>
    <td ><a  onclick="successalert()" href='Degerlendirme.jsp?MakaleID=<%=rs.getString("MakaleID")%>'class="btn btn-more"><i class="fa fa-share"></i>Değerlendirmeye Yönlendir</a></td>
  <%}
    else{%>
    <td><a href=''style="color:Gray;"class="btn btn-more"><i class="fa fa-check"></i>Değerlendirmeye Yönlendirildi</a></td>	  	
   <% }
    }} %>
 </tr>
</table>

         
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
<script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script > 
   <script type="text/javascript">
      function successalert() {
    	  
          swal({
          title: "Makale Hocaya iletildi.",
              icon: "success",
              timer: 10000,
              button: "Kapat!",
          });
      }
    </script>
</body>
</html>
