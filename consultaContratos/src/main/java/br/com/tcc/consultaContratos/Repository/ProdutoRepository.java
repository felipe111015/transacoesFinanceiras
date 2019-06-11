package br.com.tcc.consultaContratos.Repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import br.com.tcc.consultaContratos.Model.Produto;

@Repository
public interface ProdutoRepository extends CrudRepository<Produto, Integer> {

}
