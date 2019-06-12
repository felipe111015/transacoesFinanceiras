package br.com.tcc.consultaContratos.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Produto;
import br.com.tcc.consultaContratos.Repository.ProdutoRepository;

@Service
public class ProdutoService {

	@Autowired
	private ProdutoRepository produtoRepository;

	public Produto novoProduto(Produto produto) {
		Produto novoProduto = produtoRepository.save(produto);
		return novoProduto;
	}

	public Iterable<Produto> listaProdutos() {
		Iterable<Produto> listaProdutos = produtoRepository.findAll();
		return listaProdutos;
	}
}
