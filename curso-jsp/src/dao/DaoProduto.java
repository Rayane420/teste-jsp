package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.BeanCategoria;
import beans.BeanProduto;
import connection.SingleConnection;

public class DaoProduto {

	private Connection connection;

	public DaoProduto() {
		connection = SingleConnection.getConnection();
	}

	public void Salvar(BeanProduto produto) {
		try {
			String sql = "insert into produto(nome, valorproduto, quantidadeproduto, categoria_id) values (?, ?, ?, ?)";
			PreparedStatement insert = connection.prepareStatement(sql);
			insert.setString(1, produto.getNome());
			insert.setDouble(2, produto.getValorProduto());
			insert.setDouble(3, produto.getQuantidadeProduto());
			insert.setLong(4, produto.getCategoria_id());
			insert.execute();
			connection.commit();

		} catch (Exception e) {
			e.printStackTrace();

			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}

	public List<BeanProduto> listar() throws Exception {
		List<BeanProduto> listar = new ArrayList<BeanProduto>();

		String sql = "select * from produto";
		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet resultSet = statement.executeQuery();

		while (resultSet.next()) {
			BeanProduto beanProduto = new BeanProduto();
			beanProduto.setId(resultSet.getLong("id"));
			beanProduto.setNome(resultSet.getString("nome"));
			beanProduto.setQuantidadeProduto(resultSet.getInt("quantidadeproduto"));
			beanProduto.setValorProduto(resultSet.getDouble("valorproduto"));
			beanProduto.setCategoria_id(resultSet.getLong("categoria_id"));
			
			listar.add(beanProduto);
		}

		return listar;
	}
	
	public List<BeanCategoria> listaCategorias() throws Exception{
		List<BeanCategoria> retorno = new ArrayList<BeanCategoria>();
		
		String sql = "select * from categoria";
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultSet = statement.executeQuery();
		
		while (resultSet.next()) {
			BeanCategoria categoria = new BeanCategoria();
			categoria.setId(resultSet.getLong("id"));
			categoria.setNome(resultSet.getString("nome"));
			retorno.add(categoria);
		}
		return retorno;
	}

	public void delete(String id) {
		try {
			String sql = "delete from produto where id = '" + id + "' ";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.execute();
			connection.commit();

		} catch (Exception e) {
			e.printStackTrace();

			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}

		}

	}

	public BeanProduto consultar(String id) throws Exception {
		String sql = "select * from produto where id='" + id + "' ";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();

		if (resultSet.next()) {
			BeanProduto beanProduto = new BeanProduto();
			beanProduto.setId(resultSet.getLong("id"));
			beanProduto.setNome(resultSet.getString("nome"));
			beanProduto.setQuantidadeProduto(resultSet.getInt("quantidadeproduto"));
			beanProduto.setValorProduto(resultSet.getDouble("valorproduto"));
			beanProduto.setCategoria_id(resultSet.getLong("categoria_id"));

			return beanProduto;
		}

		return null;
	}
	
	public void atualizar (BeanProduto produto) {
		try {
			String sql = "update produto set nome = ?, valorproduto = ?, quantidadeproduto = ?, categoria_id = ? where id =" + produto.getId();
			
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, produto.getNome());
			preparedStatement.setDouble(2, produto.getValorProduto());
			preparedStatement.setDouble(3, produto.getQuantidadeProduto());
			preparedStatement.setLong(4, produto.getCategoria_id());
			
			preparedStatement.executeUpdate();
			
			connection.commit();
			
		}catch (Exception e) {
			e.printStackTrace();
			
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
		}
	}
	
	public boolean validarProduto(String nome) throws Exception{
		String sql = "select count(1) as qtd from produto where nome='" + nome + "' ";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();
		
		if(resultSet.next()) {
			return resultSet.getInt("qtd") <= 0;
		}
		
		return false;
	}
	
	

}