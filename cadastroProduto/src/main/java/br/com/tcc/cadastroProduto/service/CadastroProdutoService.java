package br.com.tcc.cadastroProduto.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.cadastroProduto.model.Produto;
import br.com.tcc.cadastroProduto.repository.CadastroProdutoRepository;

@Service
public class CadastroProdutoService {

	@Autowired
	private CadastroProdutoRepository repository;

	public Produto novoProduto(Produto produto) {
		Produto novoProduto = repository.save(produto);

		return novoProduto;
	}

	public Optional<Produto> buscarProdutoByNumero(Long numero) {
		Optional<Produto> produto = repository.findById(numero);

		return produto;
	}
}
