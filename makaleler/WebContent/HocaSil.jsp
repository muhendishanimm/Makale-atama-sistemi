<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:useBean id="sayiCrud" class="makaleler.VeriIslemler"></jsp:useBean>
</head>
<body>
 <% 

  int id=Integer.parseInt(request.getParameter("HocaID"));
  
  boolean sonuc=sayiCrud.hocasil(id);
  if (sonuc) {
	  response.sendRedirect("Hocalar.jsp");
	  } 
  %>
</body>
</html>