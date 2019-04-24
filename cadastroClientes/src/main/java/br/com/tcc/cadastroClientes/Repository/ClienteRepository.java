package br.com.tcc.cadastroClientes.Repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import br.com.tcc.cadastroClientes.Model.Cliente;

@Repository
public interface ClienteRepository extends CrudRepository<Cliente, String> {

}
