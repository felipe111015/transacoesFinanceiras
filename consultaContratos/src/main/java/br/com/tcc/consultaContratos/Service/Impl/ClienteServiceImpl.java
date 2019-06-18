package br.com.tcc.consultaContratos.Service.Impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Cliente;
import br.com.tcc.consultaContratos.Repository.ClienteRepository;
import br.com.tcc.consultaContratos.Service.ClienteService;
import br.com.tcc.consultaContratos.exceptions.ClienteException;

@Service
public class ClienteServiceImpl implements ClienteService {

	@Autowired
	ClienteRepository clienteRepository;

	public Iterable<Cliente> listaClientes() throws ClienteException {
		Iterable<Cliente> listaClientes = null;

		try {
			listaClientes = clienteRepository.findAll();
		} catch (Exception e) {
			throw new ClienteException("Erro ao Listar Clientes!");
		}

		return listaClientes;
	}

	public Optional<Cliente> listaClienteByCpf(String cpf) throws ClienteException {
		Optional<Cliente> listaClienteByCpf = null;
		try {
			listaClienteByCpf = clienteRepository.findById(cpf);
		} catch (Exception e) {
			throw new ClienteException("Erro ao buscar cliente!");
		}

		return listaClienteByCpf;
	}

	public Cliente novoCliente(Cliente cliente) throws ClienteException {
		Cliente novoCliente = null;
		try {
			novoCliente = clienteRepository.save(cliente);
		} catch (Exception e) {
			throw new ClienteException("Erro ao cadastrar novo Cliente!");
		}

		return novoCliente;
	}

	public void deletaClienteByCpf(String cpf) throws ClienteException {
		try {
			clienteRepository.deleteById(cpf);
		} catch (Exception e) {
			throw new ClienteException("Erro ao deletar cliente!");
		}

	}

}
