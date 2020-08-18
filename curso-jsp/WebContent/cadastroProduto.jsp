<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>Cadastro de Produto</title>

<script src="resources/javascript/jquery.min.js" type="text/javascript"></script>
<script src="resources/javascript/jquery.maskMoney.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/cadastro.css">
</head>
<body>
	<a href="acessoliberado.jsp"><img src="resources/img/home2.png"
		alt="Home" title="Voltar para o Inicio" width="40px" height="40px"></a>
	<a href="index.jsp"><img src="resources/img/Sair.png" alt="Home"
		title="Sair do sistema" width="40px" height="40px"></a>
	<center>
		<h1>Cadastro de Novos Produtos</h1>
		<h3 style="color: #FF4500">${msgE}</h3>
		<h3 style="color: #00FF00">${msgC}</h3>
	</center>
		<center>
			<form action="salvarProduto" method="post" id="formProduto"
				onsubmit="return validarCampos()? true : false;">
				<ul class="form-style-1">
					<li>
						<table>
							<tr>
								<td>Id do Produto:</td>
								<td><input type="text" readonly="readonly" id="id"
									style="width: 100px" name="id" value="${produto.id}"
									class="field-long"></td>
							</tr>
							<tr>
								<td>Nome:</td>
								<td><input type="text" id="nome" name="nome" maxlength="100" style="width: 200px"
									value="${produto.nome}"></td>
							</tr>
							<tr>
								<td>Quantidade:</td>
								<td><input type="text" id="quantidadeproduto" name="quantidadeproduto" maxlength="10"
									style="width: 150px" value="${produto.quantidadeProduto}"></td>
							</tr>
							<tr>
								<td>Valor R$:</td>
								<td>
								<input type="text" id="valorproduto" name="valorproduto" data-thousands="." data-decimal="," data-precision="2" 
								value="${produto.valorEmTexto}" maxlength="8" style="width: 150px" ></td>
							</tr>
							<tr>
								<td>Categoria:</td>
								<td>
									<select id="categorias" name="categoria_id">
										<c:forEach items="${categorias}" var="cat">
											<option value="${cat.id}" id="${cat.id}"
												<c:if test="${cat.id == produto.categoria_id }">
													<c:out value = "selected=selected" />
												</c:if>
											>	
												${cat.nome}
											</option>									
										</c:forEach>
									</select>
								</td>
							</tr>
							
							<tr>
								<td></td>
								<td><input type="submit" value="Salvar" style="width: 90px"> 
								<input type="submit" value="Cancelar" style="width: 90px"
									onclick="document.getElementById('formProduto').action = 'salvarProduto?acao=reset' "></td>
							</tr>
						</table>
					</li>
				</ul>
			</form>
		</center>
		<p />
		<p />
		<table class="container">
			<thead>
				<tr>
					<th><h1>ID</h1></th>
					<th><h1>Nome</h1></th>
					<th><h1>Quantidade</h1></th>
					<th><h1>Valor</h1></th>
					<th><h1>Exclusão</h1></th>
					<th><h1>Edição</h1></th>
				</tr>
			</thead>
			<p />
			<p />
			<caption>
				<h1>Lista de Produtos Cadastrados</h1>
			</caption>
			
			<c:forEach items="${produtos}" var="produto">
				<tbody>
					<tr>
						<td style="width: 150px"><c:out value="${produto.id}"></c:out></td>
						<td style="width: 150px"><c:out value="${produto.nome}"></c:out></td>
						<td><c:out value="${produto.quantidadeProduto}"></c:out></td>
						<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${produto.valorProduto}"/></td>
						

						<td style="width: 100px"><a
							href="salvarProduto?acao=delete&produto=${produto.id}" onclick="return confirm('Deseja confirmar a exclusão?')"><img
								src="resources/img/lixeira.png" alt="Excluir"
								title="Excluir Produto" width="20px" height="20px"><></a></td>
						<td style="width: 100px"><a
							href="salvarProduto?acao=editar&produto=${produto.id}"><img
								src="resources/img/editar.png" alt="Editar"
								title="Editar Produto" width="20px" height="20px"></a></td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		
		<script type="text/javascript">
					function validarCampos() {

						if (document.getElementById("nome").value == '') {
							alert('Por favor informe o nome do produto!');
							return false;
						} else if (document.getElementById("quantidadeproduto").value == '') {
							alert('Por favor informe a quantidade!');
							return false;
						} else if (document.getElementById("valorproduto").value == '') {
							alert('Por favor informe o valor');
							return false;
						}
						return true;
					}
		</script>
</body>
<script type="text/javascript">
	$(function() {
		$('#valorproduto').maskMoney();
	});

	$(document).ready(function() {
		$("#quantidadeproduto").keyup(function() {
			$("#quantidadeproduto").val(this.value.match(/[0-9]*/));
		});
	});
</script>
</html>