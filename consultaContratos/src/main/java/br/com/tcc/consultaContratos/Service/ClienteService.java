package br.com.tcc.consultaContratos.Service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Cliente;
import br.com.tcc.consultaContratos.Repository.ClienteRepository;

@Service
public class ClienteService {

	@Autowired
	ClienteRepository clienteRepository;

	public Iterable<Cliente> listaClientes() {
		Iterable<Cliente> listaClientes = clienteRepository.findAll();
		return listaClientes;
	}

	public Optional<Cliente> listaClienteByCpf(String cpf) {
		Optional<Cliente> listaClienteByCpf = clienteRepository.findById(cpf);

		return listaClienteByCpf;
	}

	public Cliente novoCliente(Cliente cliente) {
		Cliente novoCliente = clienteRepository.save(cliente);
		return novoCliente;
	}

	public void deletaClienteByCpf(String cpf) {
		clienteRepository.deleteById(cpf);

	}

}
