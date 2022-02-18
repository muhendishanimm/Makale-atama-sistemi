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
System.out.println(EditorAd);
int idd=Integer.parseInt(String.valueOf(session.getAttribute("EditorID")));%>
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
  <!-- ======== içerik kısmı ======== -->
  <div id="content">
    <div class="showcase block block-border-bottom-grey">
      <div class="container">
      
        <div class="item-carousel" data-toggle="owlcarousel" data-owlcarousel-settings='{"items":4, "pagination":false, "navigation":true, "itemsScaleUp":true}'>
          <div class="item">
           <h2>HOCALAR</h2>

<table class="table table-bordered">
  <tr>
    <th>AdSoyad</th>
    <th>Mail</th>
    <th>Puan</th>
    <th>Pozisyon</th>
    <th>Alanı</th>
    <th>Sil</th>
  </tr>
   <% 
  ResultSet rs=sayiCrud.hocaselectall();
  while(rs.next()) { %>
  <tr>
    <td><%=rs.getString("HocaAdSoyad") %></td>
    <td><%=rs.getString("HocaMail") %></td>
    <td><%=rs.getString("Puan") %></td>
    <td><%=rs.getString("Pozisyon") %></td>
    <td><%=rs.getString("KategoriAdi") %></td>
    <td><a href='HocaSil.jsp?HocaID=<%=rs.getString("HocaID")%>' style="color:red;" onclick="successalert()">Sil<span class="glyphicon glyphicon-remove" style="font-size:24px;"></span></a></td>
  
  </tr>
  <%} %>

</table>
<a href="HocaEkle.jsp" class="btn btn-more"><i class="fa fa-check"></i>Ekle</a> 
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
      <script src = " https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script > 
   <script type="text/javascript">
      function successalert() {
    	  swal({
    		  title: "Are you sure?",
    		  text: "Once deleted, you will not be able to recover this imaginary file!",
    		  icon: "warning",
    		  timer: 10000,
    		  buttons: true,
    		  dangerMode: true,
    		})
    		.then((willDelete) => {
    		  if (willDelete) {
    		    swal("Poof! Your imaginary file has been deleted!", {
    		      icon: "success",
    		    });
    		  } else {
    		    swal("Your imaginary file is safe!");
    		  }
    		});
      }
    </script>
</body>
</html>
