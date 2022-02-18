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
</head>

<body class="fullscreen-centered page-login">
  <div id="background-wrapper" class="benches" data-stellar-background-ratio="0.8">
    <!-- ======== @Region: #content ======== -->
    <div id="content">
      <div class="header">
      <%System.out.println("geldim"); %>
      </div>
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">
                 <span class="input-group-addon">YAZAR GİRİŞ</span>
                </h3>
            </div>
            <div class="panel-body">
              <form action="YazarSifremiUnuttum_Islem.jsp" class="form-group" method="post" accept-charset="UTF-8" role="form">
                <fieldset>
                  <div class="form-group">
                    <div class="input-group input-group-lg">
                      <span class="input-group-addon"><i class="fa fa-fw fa-user"></i></span>
                      <input type="email" class="form-control" name="YzrMail" placeholder="Mail ">
                    </div>
                  </div>
                  
                  <input class="btn btn-lg btn-primary btn-block" type="submit" value="Şifre Gönder">
                </fieldset>
              </form>
              </div>
          </div>
        </div>
      </div>
    </div>
  </div>
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
