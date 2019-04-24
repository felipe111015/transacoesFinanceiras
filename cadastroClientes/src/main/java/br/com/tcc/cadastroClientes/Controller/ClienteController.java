package br.com.tcc.cadastroClientes.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.tcc.cadastroClientes.Model.Cliente;
import br.com.tcc.cadastroClientes.Service.ClienteService;

@RestController
@RequestMapping(value = "/cliente")
public class ClienteController {

	@Autowired
	ClienteService service;

	@PostMapping(value = "/novoCliente")
	public ResponseEntity<Cliente> novoCliente(@RequestBody Cliente cliente) {
		try {
			Cliente ClienteCadastrado = service.adicionarCliente(cliente);
			return ResponseEntity.status(HttpStatus.CREATED).body(ClienteCadastrado);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

	
	@GetMapping(value="/listaClientes")
	public ResponseEntity<Iterable<Cliente>> buscaClientes() {
		try {

			Iterable<Cliente> listaClientes = service.buscarClientes();

			while (listaClientes != null) {
				return ResponseEntity.status(HttpStatus.FOUND).body(listaClientes);
			}

		} catch (Exception e) {
			e.printStackTrace();

			
		}
		
		return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		

	}

}
