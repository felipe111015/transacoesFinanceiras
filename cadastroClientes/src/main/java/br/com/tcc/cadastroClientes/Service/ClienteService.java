package br.com.tcc.cadastroClientes.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.cadastroClientes.Model.Cliente;
import br.com.tcc.cadastroClientes.Repository.ClienteRepository;

@Service
public class ClienteService {

	@Autowired
	ClienteRepository repository;
	
	
	public Cliente adicionarCliente(Cliente cliente){
		Cliente clienteCadastrado = repository.save(cliente);
		return clienteCadastrado;
	}
	
	public Iterable<Cliente> buscarClientes(){
		Iterable<Cliente> findAll = repository.findAll();
		return findAll;
	}
	
}
