<jsp:useBean id="calcula" class="beans.BeanCursoJsp"
	type="beans.BeanCursoJsp" scope="page" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bem vindo</title>
<link rel="stylesheet" href="resources/css/cadastro.css">
</head>
<body>
	<a href="index.jsp"><img src="resources/img/Sair.png" alt="Home"
		title="Sair do sistema" width="40px" height="40px"></a>
	 <center style="padding-top: 10%">
	 <img src="resources/img/bv2.png" width="350px" height="110px"> </p>
	<a href="salvarUsuario?acao=listartodos"><img src="resources/img/CadP2.png" alt="Adicionar novo usuário" title="Adicionar usuário" width="230px" height="220px"></a>
	<a href="salvarProduto?acao=listartodos" ><img src="resources/img/CadU.png" alt="Adicionar novo produto" title="Adicionar produto" width="240px" height="200px"></a>
	</center>
</body>
</html>