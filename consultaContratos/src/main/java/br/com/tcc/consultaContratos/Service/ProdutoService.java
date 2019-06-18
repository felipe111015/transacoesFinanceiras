package br.com.tcc.consultaContratos.Service;

import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Produto;
import br.com.tcc.consultaContratos.exceptions.ProdutoException;

@Service
public interface ProdutoService {
	public Produto novoProduto(Produto produto) throws ProdutoException;

	public Iterable<Produto> listaProdutos() throws ProdutoException;
}
