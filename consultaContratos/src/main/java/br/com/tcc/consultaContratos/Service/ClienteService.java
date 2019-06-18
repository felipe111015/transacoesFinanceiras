package br.com.tcc.consultaContratos.Service;

import java.util.Optional;

import br.com.tcc.consultaContratos.Model.Cliente;
import br.com.tcc.consultaContratos.exceptions.ClienteException;

public interface ClienteService {

	public Iterable<Cliente> listaClientes() throws ClienteException;

	public Optional<Cliente> listaClienteByCpf(String cpf) throws ClienteException;

	public Cliente novoCliente(Cliente cliente) throws ClienteException;

	public void deletaClienteByCpf(String cpf) throws ClienteException;

}
