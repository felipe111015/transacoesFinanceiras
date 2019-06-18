package br.com.tcc.consultaContratos.Service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Produto;
import br.com.tcc.consultaContratos.Repository.ProdutoRepository;
import br.com.tcc.consultaContratos.Service.ProdutoService;
import br.com.tcc.consultaContratos.exceptions.ProdutoException;

@Service
public class ProdutoServiceImpl implements ProdutoService {

	@Autowired
	private ProdutoRepository produtoRepository;

	public Produto novoProduto(Produto produto) throws ProdutoException {
		Produto novoProduto = null;
		try {
			novoProduto = produtoRepository.save(produto);
		} catch (Exception e) {
			throw new ProdutoException("Erro ao cadastrar produto!");
		}

		return novoProduto;
	}

	public Iterable<Produto> listaProdutos() throws ProdutoException {

		Iterable<Produto> listaProdutos = null;
		try {
			listaProdutos = produtoRepository.findAll();
		} catch (Exception e) {
			throw new ProdutoException("Erro ao listar produtos!");
		}

		return listaProdutos;
	}
}
