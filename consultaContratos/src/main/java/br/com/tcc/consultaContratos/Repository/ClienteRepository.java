package br.com.tcc.consultaContratos.Repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import br.com.tcc.consultaContratos.Model.Cliente;

@Repository
public interface ClienteRepository extends CrudRepository<Cliente, String> {

}
