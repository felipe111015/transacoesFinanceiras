package br.com.tcc.consultaContratos.Service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Produto;
import br.com.tcc.consultaContratos.Repository.ProdutoRepository;

@Service
public class ProdutoService {

	private ProdutoRepository produtoRepository;

	public Produto novoProduto(Produto produto) {
		Produto novoProduto = produtoRepository.save(produto);
		return novoProduto;
	}

	public Iterable<Produto> listaProdutos() {
		Iterable<Produto> listaProdutos = produtoRepository.findAll();
		return listaProdutos;
	}

	public Optional<Produto> listaProdutoById(Long id) {
		Optional<Produto> produtoById = produtoRepository.findById(id);
		return produtoById;
	}

	public void deletaProdutoById(Long id) {
		produtoRepository.deleteById(id);
	}
}
