package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.BeanProduto;
import dao.DaoProduto;

/**
 * Servlet implementation class Produto
 */
@WebServlet("/salvarProduto")
public class Produto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private DaoProduto daoProduto = new DaoProduto();

	public Produto() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String acao = request.getParameter("acao") != null ? request.getParameter("acao") : "listartodos";
			String produto = request.getParameter("produto");
			
			RequestDispatcher view = request.getRequestDispatcher("/cadastroProduto.jsp");
			
			if (acao.equalsIgnoreCase("delete")) {
				daoProduto.delete(produto);
				request.setAttribute("produtos", daoProduto.listar());

			} else if (acao.equalsIgnoreCase("editar")) {
				BeanProduto beanProduto = daoProduto.consultar(produto);
				request.setAttribute("produto", beanProduto);

			} else if (acao.equalsIgnoreCase("listartodos")) {
				request.setAttribute("produtos", daoProduto.listar());
			}
			
			request.setAttribute("categorias", daoProduto.listaCategorias());
			view.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String acao = request.getParameter("acao");

		if (acao != null && acao.equalsIgnoreCase("reset")) {
			try {
				RequestDispatcher view = request.getRequestDispatcher("/cadastroProduto.jsp");
				request.setAttribute("produtos", daoProduto.listar());
				view.forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String quantidadeproduto = request.getParameter("quantidadeproduto");
			String valorproduto = request.getParameter("valorproduto");
			String categoria = request.getParameter("categoria_id"); //pegando o name que vem da jsp
			try {

				String msgL = null;
				boolean podeCadastrar = true;

				
				/*validando entrada de dados*/
				if (nome == null || nome.isEmpty()) {
					msgL = "O nome deve ser informado!";
					podeCadastrar = false;
				} else if (quantidadeproduto == null || quantidadeproduto.isEmpty()) {
					msgL = "A quantidade deve ser informada";
					podeCadastrar = false;
				} else if (valorproduto == null || valorproduto.isEmpty()) {
					msgL = "O valor deve ser informado";
					podeCadastrar = false;
				}else if (id == null || id.isEmpty() && !daoProduto.validarProduto(nome)) {
					msgL = "Esse produto já foi cadastrado anteriormente!";
					podeCadastrar = false;
				}
				
				BeanProduto produto = new BeanProduto();
				produto.setNome(nome);
				produto.setId(!id.isEmpty() ? Long.parseLong(id) : null);
				produto.setCategoria_id(Long.parseLong(categoria));
				

				if (quantidadeproduto != null && !quantidadeproduto.isEmpty()) {
					produto.setQuantidadeProduto(Double.parseDouble(quantidadeproduto));
				}

				if (valorproduto != null && !valorproduto.isEmpty()){
					String valorParse = valorproduto.replaceAll("\\.", "");// 10500,20
					valorParse = valorParse.replaceAll("\\,", ".");//10500.20
					produto.setValorProduto(Double.parseDouble(valorParse)); 
				}
				
				if (msgL != null) {
					request.setAttribute("msgE", msgL);
					request.setAttribute("produto", produto);
				} else if (id == null || id.isEmpty() && daoProduto.validarProduto(nome) && podeCadastrar) {
					daoProduto.Salvar(produto);
					request.setAttribute("msgC", "Novo produto cadastrado com sucesso! ");
				}
				
				else if (id != null && !id.isEmpty() && podeCadastrar) {
					daoProduto.atualizar(produto);
					request.setAttribute("msgC", "Produto Atualizado com sucesso!");
				}
				if(!podeCadastrar) {
					request.setAttribute("produto", produto);
				}

				RequestDispatcher view = request.getRequestDispatcher("/cadastroProduto.jsp");
				request.setAttribute("produtos", daoProduto.listar());
				request.setAttribute("categorias", daoProduto.listaCategorias());
				view.forward(request, response); //redirecionando para o cadastro de produtos

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
