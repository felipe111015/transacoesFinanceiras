package br.com.tcc.cadastroProduto.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import br.com.tcc.cadastroProduto.model.Produto;

@Repository
public interface CadastroProdutoRepository extends CrudRepository<Produto, Long> {

}
