package br.com.tcc.consultaContratos.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import br.com.tcc.consultaContratos.Model.Cliente;
import br.com.tcc.consultaContratos.Service.Impl.ClienteServiceImpl;

@RestController
public class ClienteController {

	@Autowired
	ClienteServiceImpl clienteService;

	@PostMapping(value = "/cliente/novoCliente")
	public ResponseEntity<Cliente> novoCliente(@RequestBody Cliente cliente) {
		try {
			Cliente ClienteCadastrado = clienteService.novoCliente(cliente);
			return ResponseEntity.status(HttpStatus.OK).body(ClienteCadastrado);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

	@GetMapping(value = "/cliente/listaClientes")
	public ResponseEntity<Iterable<Cliente>> buscaClientes() {
		try {

			Iterable<Cliente> listaClientes = clienteService.listaClientes();

			return ResponseEntity.status(HttpStatus.OK).body(listaClientes);

		} catch (Exception e) {
			e.printStackTrace();

		}

		return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

	}

}
