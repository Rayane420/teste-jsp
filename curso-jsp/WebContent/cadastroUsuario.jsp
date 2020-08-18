<%@page import="beans.BeanCursoJsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="ISO-8859-1">
<title>Cadastro de Usuário</title>
<link rel="stylesheet" href="resources/css/cadastro.css">

<!-- Adicionando JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>

</head>
<body>

	<a href="acessoliberado.jsp"><img src="resources/img/home2.png" alt="Home" title="Voltar para o Inicio" width="40px" height="40px"></a>
	<a href="index.jsp"><img src="resources/img/Sair.png" alt="Home" title="Sair do sistema" width="40px" height="40px"></a>
		
	<center>
		<h1>Cadastro De Usuários</h1>
		<br/>
		<h3 style="color: #00FF00">${msgC}</h3>
		<h3 style="color: #FF4500">${msg}</h3>
	</center>	
		<center>
			<form action="salvarUsuario" method="post" id="formUser"
				onsubmit="return validarCampos()? true : false;"
				enctype="multipart/form-data">
				<ul class="form-style-1">
					<li>
						<table>

							<tr>
								<td>Id do Usuário: :</td>
								<td><input type="text" readonly="readonly" id="id" style="width: 150px" name="id" value="${user.id}"
									class="field-long"  placeholder="-----------"></td>
								<td>Ativo:</td>
								<td><input type="checkbox" id="ativo" name="ativo"
								<%
									if(request.getAttribute("user") != null){
										BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
										if(user.isAtivo()){
											out.print(" ");
											out.print("checked=\"checked\"");
											out.print(" ");
											
										}
									}
								%>
								>
								&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Perfil: &nbsp;
								<select id="perfil" name="perfil" style="width: 177px;">
									<option value="nao_informado">-----Selecione-----</option>
									
									<option value="administrador"
									<%
									if(request.getAttribute("user") != null){
										BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
										if(user.getPerfil().equalsIgnoreCase("administrador")){
											out.print(" ");
											out.print("selected=\"selected\"");
											out.print(" ");
											
										}
									}
									%>
									>Administrador</option>
									
									
									<option value="secretario"
									<%
									if(request.getAttribute("user") != null){
										BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
										if(user.getPerfil().equalsIgnoreCase("secretario")){
											out.print(" ");
											out.print("selected=\"selected\"");
											out.print(" ");
											
										}
									}
									%>
									>Secretário(a)</option>
									
									
									<option value="gerente"
									<%
									if(request.getAttribute("user") != null){
										BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
										if(user.getPerfil().equalsIgnoreCase("gerente")){
											out.print(" ");
											out.print("selected=\"selected\"");
											out.print(" ");
											
										}
									}
									%>
									>Gerente</option>
									
									
									<option value="funcionario"
									<%
									if(request.getAttribute("user") != null){
										BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
										if(user.getPerfil().equalsIgnoreCase("funcionario")){
											out.print(" ");
											out.print("selected=\"selected\"");
											out.print(" ");
											
										}
									}
									%>
									>Funcionario</option>
								</select>
								</td>
								
							</tr>
							<tr>
								<td>Nome:</td>
								<td><input type="text" id="nome" name="nome" maxlength="100"
									style="width: 300px" value="${user.nome}"
									placeholder="Informe o nome"></td>
								<td>Login:</td>
								<td><input type="text" id="login" name="login" maxlength="10"
									style="width: 300px" value="${user.login}"
									placeholder="Informe o login"></td>
							</tr>
							<tr>
								<td>Telefone:</td>
								<td><input type="text" id="telefone" name="telefone" maxlength="20"
									style="width: 300px" value="${user.telefone}"
									placeholder="Informe telefone"></td>
								<td>Senha:</td>
								<td><input type="password" id="senha" name="senha" maxlength="10"
									style="width: 300px" value="${user.senha}"
									placeholder="Informe a senha"></td>
							</tr>
							<tr>
								<td></p></td>
							</tr>
							<tr>
								<td>Sexo:</td>
								<td>
									<input type="radio" name="sexo" 
									<%
									if(request.getAttribute("user") != null){
										BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
										if(user.getSexo().equalsIgnoreCase("feminino")){
											out.print(" ");
											out.print("checked=\"checked\"");
											out.print(" ");
											
										}
									}
									%>
									value="feminino">Feminino</input>
									
									<input type="radio" name="sexo" 
									<%
									if(request.getAttribute("user") != null){
										BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
										if(user.getSexo().equalsIgnoreCase("masculino")){
											out.print(" ");
											out.print("checked=\"checked\"");
											out.print(" ");
											
										}
									}
									%>									
									value="masculino">Masculino</input>
								</td>
							</tr>

							<tr>
								<td></p></td>
							</tr>
							<tr>
								<td>Cep:</td>
								<td><input type="text" id="cep" name="cep" maxlength="9"
									style="width: 300px" onblur="consultaCep();"
									value="${user.cep}" placeholder="Informe um cep Válido"></td>
								<td>Rua:</td>
								<td><input type="text" id="rua" name="rua" maxlength="50"
									style="width: 300px" value="${user.rua}"></td>
							</tr>
							<tr>
								<td>Bairro:</td>
								<td><input type="text" id="bairro" name="bairro" maxlength="50"
									style="width: 300px" value="${user.bairro}"></td>
								<td>Cidade:</td>
								<td><input type="text" id="cidade" name="cidade"
									style="width: 300px" value="${user.cidade}"></td>
							</tr>
							<tr>
								<td>Uf:</td>
								<td><input type="text" id="estado" name="estado"
									style="width: 300px" value="${user.estado}"></td>
								<td>IBGE</td>
								<td><input type="text" id="ibge" name="ibge"
									style="width: 300px" value="${user.ibge}"></td>
							</tr>
							<tr>
								<td>Foto:</td>
								<td><input type="file" name="foto" value="foto"/></td>
							</tr>
							<tr>
								<td>Curriculo:</td>
								<td><input type="file" name="curriculo" value="curriculo" style="width: 300px"/></td>
							</tr>
							<tr>
								<td></td>
								<td><input type="submit" value="Salvar"	style="width: 148px"> 
								<input type="submit" value="Cancelar" style="width: 148px" onclick="document.getElementById('formUser').action = 'salvarUsuario?acao=reset'">
								</td>
							</tr>
						</table>
						
					</li>
				</ul>

			</form>
		</center>
	
	<br/>
	
	<center>
	<form method="post" action="servletPesquisa" >
	
	<ul class="form-style-1">
		<li>
			<table >
				<tr >
					<tr>
					<td></p></td>
					</tr>
					<tr>
					<td></p></td>
					</tr>
					<td>Descrição:</td>	
					<td><input type="text" id="descricaoconsulta" name="descricaoconsulta" style="width:230px"></td>
					<td><input type="submit" value="pesquisar"></td>			
					<tr>
					<td></p></td>
					</tr>
					<tr>
					<td></p></td>
					</tr>
				</tr>			
			</table>
		</li>	
	</ul>
	
	
	</form>
	</center>
		<table class="container">
			<thead>
				<tr>
					<th><h1>ID</h1></th>
					<th><h1>Login</h1></th>
					<th><h1>Foto</h1></th>
					<th><h1>Curriculo</h1></th>
					<th><h1>Nome</h1></th>
					<th><h1>Telefone</h1></th>
					<th><h1>Excluir</h1></th>
					<th><h1>Editar</h1></th>
					
				</tr>
			</thead>

			<caption>
				<h1>Lista de Usuários Cadastrados</h1>
			</caption>
			<c:forEach items="${usuarios}" var="user">

				<tbody>
					<tr>
						<td style="width: 80px"><c:out value="${user.id}" /></td>
						<td style="width: 150px"><c:out value="${user.login}" /></td>

						<c:if test="${user.fotoBase64Miniatura || user.fotoBase64Miniatura.isEmpty() != null}">
							<td style="width: 110px">
							<a	href="salvarUsuario?acao=download&tipo=imagem&user=${user.id}"><img src='<c:out value="${user.fotoBase64Miniatura}"/>' 
									title="Imagem User" width="60px" height="60px"/></a>
							</td>
						</c:if>	
						
						<c:if test="${user.fotoBase64Miniatura || user.fotoBase64Miniatura.isEmpty() == null}">
							<td style="width: 150px"><img alt="Imagem User"
								src="resources/img/usersemfoto.png" title="User sem foto" width="40px" height="40px" onclick="alert('Não possui Foto')">
							</td>
						</c:if>

						<c:if test="${user.curriculoBase64.isEmpty() == false}">
							<td style="width: 150px">
							<a	href="salvarUsuario?acao=download&tipo=curriculo&user=${user.id}">
							<img alt="Curriculo User" src="resources/img/pdf.webp" width="40px"
									height="40px"></a></td>
						</c:if>

						<c:if test="${user.curriculoBase64 == null}">
							<td>
							<img alt="Curriculo User" 
							src="resources/img/pdf.webp" alt="User sem curriculo" 
							title="User sem pdf" width="40px" height="40px" onclick="alert('Não possui pdf')"></td>
						</c:if>

						<td style="width: 200px"><c:out value="${user.nome}"></c:out></td>
						
						<td style="width: 100px">
						<a href="salvarTelefone?acao=addFone&user=${user.id}">
						<img src="resources/img/phone.png" alt="Telefones" title="Telefones" width="20px" height="20px"></a>
						</td>

						<td style="width: 100px">
						<a href="salvarUsuario?acao=delete&user=${user.id}" onclick="return confirm('Deseja confirmar a exclusão?')">
						<img src="resources/img/lixeira.png" alt="Excluir" title="Excluir Cadastro" width="20px" height="20px"><></a>
						</td>
						
						<td style="width: 100px">
						<a href="salvarUsuario?acao=editar&user=${user.id}">
						<img src="resources/img/editar.png" alt="Editar" title="Editar Cadastro" width="20px" height="20px"></a>
						</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		
		<script type="text/javascript">
			function validarCampos() {
				if (document.getElementById("login").value == '') {
					alert('Por favor informe seu login');
					return false;
				} else if (document.getElementById("senha").value == '') {
					alert('Por favor informe sua senha');
					return false;
				} else if (document.getElementById("nome").value == '') {
					alert('Por favor informe seu nome');
					return false;
				} else if (document.getElementById("telefone").value == '') {
					alert('Por favor informe seu telefone');
					return false;
				}
				return true;
			}

			/**Adicionando o web service de consulta de cep*/
			function consultaCep() {
				var cep = $("#cep").val();

				$.getJSON("https://viacep.com.br/ws/" + cep
						+ "/json/?callback=?", function(dados) {

					if (!("erro" in dados)) {

						$("#rua").val(dados.logradouro);
						$("#bairro").val(dados.bairro);
						$("#cidade").val(dados.localidade);
						$("#estado").val(dados.uf);
						$("#ibge").val(dados.ibge);

					} //end if.
					else {
						//CEP pesquisado não foi encontrado.

						$("#cep").val('');
						$("#rua").val('');
						$("#bairro").val('');
						$("#cidade").val('');
						$("#estado").val('');
						$("#ibge").val('');

						alert("CEP não encontrado.");
					}
				});
			}
		</script>
</body>
</html>