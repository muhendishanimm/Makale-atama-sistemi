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
   <link href="Flexor/css/dene.css" rel="stylesheet">
  <jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler"></jsp:useBean>
</head>
<body class="fullscreen-centered page-register">
  <div id="background-wrapper" class="benches" data-stellar-background-ratio="0.8">
    <div id="content">
      <div class="header">
 <div id="message">
  <h3>Parola aşağıdakileri içermelidir:</h3>
  <p id="letter" class="invalid">Küçük Karakter</p>
  <p id="capital" class="invalid">Büyük Karakter</p>
  <p id="number" class="invalid">Numara</p>
  <p id="length" class="invalid">Minimum 8 Karakter</p>
</div>
      </div>
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">
                 <span class="input-group-addon">YAZAR KAYIT OL</span>
                </h3>
            </div>
            <div class="panel-body">
              <form action="YazarKayitOl_Islem.jsp" class="form-group" method="post" accept-charset="UTF-8" role="form">
                <fieldset>
                <div class="form-group">
                    <div class="input-group input-group-lg">
                      <span class="input-group-addon"><i class="fa fa-fw fa-user"></i></span>
                      <input type="text" class="form-control" name="YzrAdSoyad" placeholder="Ad Soyad">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="input-group input-group-lg">
                      <span class="input-group-addon"><i class="fa fa-fw fa-user"></i></span>
                      <input type="text" class="form-control" name="YzrKullaniciAdi" placeholder="Kullanıcı Adı">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="input-group input-group-lg">
                      <span class="input-group-addon"><i class="fa fa-fw fa-envelope"></i></span>
                      <input type="email" class="form-control" name="YzrMail" placeholder="Mail">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="input-group input-group-lg">
                      <span class="input-group-addon"><i class="fa fa-bars"></i></span>
                     	<select id="KategoriID" name="ktg" style="width: 520px; height: 48px;" >
   		<% 
	ResultSet rs=sayiCrud.kategorilistesi();
  	while(rs.next()) 
  	{ %> 
  <option value="<%=rs.getInt("KategoriID")%>"><%=rs.getString("KategoriAdi")%></option>
  	<% } %></select> </div>
                    </div>
                  <div class="form-group">
                    <div class="input-group input-group-lg">
                      <span class="input-group-addon"><i class="fa fa-fw fa-lock"></i></span>
                      <input type="password" class="form-control" id="YzrSifre" name="YzrSifre" placeholder="Şifre" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}">
                    </div>
                  </div>
                    <div class="form-group">
                    <div class="input-group input-group-lg">
                      <span class="input-group-addon"><i class="fa fa-fw fa-lock"></i></span>
                      <input type="password" class="form-control" name="SifreTekrar" placeholder="Şifre Tekrar">
                    </div>
                  </div>
                  <input class="btn btn-lg btn-primary btn-block" type="submit" value="Kayit Ol">
                </fieldset>
              </form>
              </div>            
              <div class="credits">
            </div>
            </div>
          </div>
        </div>
      </div>
    </div>  
   <script>
var myInput = document.getElementById("YzrSifre");
var letter = document.getElementById("letter");
var capital = document.getElementById("capital");
var number = document.getElementById("number");
var length = document.getElementById("length");

// When the user clicks on the password field, show the message box
myInput.onfocus = function() {
  document.getElementById("message").style.display = "block";
}

// When the user clicks outside of the password field, hide the message box
myInput.onblur = function() {
  document.getElementById("message").style.display = "none";
}

// When the user starts to type something inside the password field
myInput.onkeyup = function() {
  // Validate lowercase letters
  var lowerCaseLetters = /[a-z]/g;
  if(myInput.value.match(lowerCaseLetters)) {  
    letter.classList.remove("invalid");
    letter.classList.add("valid");
  } else {
    letter.classList.remove("valid");
    letter.classList.add("invalid");
  }
  
  // Validate capital letters
  var upperCaseLetters = /[A-Z]/g;
  if(myInput.value.match(upperCaseLetters)) {  
    capital.classList.remove("invalid");
    capital.classList.add("valid");
  } else {
    capital.classList.remove("valid");
    capital.classList.add("invalid");
  }

  // Validate numbers
  var numbers = /[0-9]/g;
  if(myInput.value.match(numbers)) {  
    number.classList.remove("invalid");
    number.classList.add("valid");
  } else {
    number.classList.remove("valid");
    number.classList.add("invalid");
  }
  
  // Validate length
  if(myInput.value.length >= 8) {
    length.classList.remove("invalid");
    length.classList.add("valid");
  } else {
    length.classList.remove("valid");
    length.classList.add("invalid");
  }
}
</script>
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
