package br.com.tcc.consultaContratos.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.tcc.consultaContratos.DTO.InPutCpfDto;
import br.com.tcc.consultaContratos.Model.Cliente;
import br.com.tcc.consultaContratos.Model.Contrato;
import br.com.tcc.consultaContratos.Model.Produto;
import br.com.tcc.consultaContratos.Service.ClienteService;
import br.com.tcc.consultaContratos.Service.ContratoService;
import br.com.tcc.consultaContratos.Service.ProdutoService;

@RestController
@RequestMapping(value = "/financeiro")
public class FinanceiroController {

	@Autowired
	ContratoService serviceContratos;

	@Autowired
	ProdutoService produtoService;
	@Autowired
	ClienteService clienteService;

	@GetMapping(value = "/contratos/listaContratosCliente")
	public ResponseEntity<List<Contrato>> consultaContratos(@RequestBody InPutCpfDto cpf) {
		try {
			List<Contrato> contratos = serviceContratos.buscaContratos(cpf.getCpf());
			return ResponseEntity.status(HttpStatus.OK).body(contratos);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
		}
	}

	@SuppressWarnings("unchecked")
	@PostMapping(value = "/contratos/novoContrato")
	public ResponseEntity<Contrato> novoContrato(@RequestBody Contrato contrato) {
		try {
			serviceContratos.criarContrato(contrato);
			return (ResponseEntity<Contrato>) ResponseEntity.status(HttpStatus.OK);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

	@PostMapping(value = "/produto/novoProduto")
	public ResponseEntity<Produto> novoProduto(@RequestBody Produto produto) {
		try {
			Produto novoProduto = produtoService.novoProduto(produto);
			return ResponseEntity.status(HttpStatus.OK).body(novoProduto);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

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

			if (listaClientes != null) {
				return ResponseEntity.status(HttpStatus.OK).body(listaClientes);
			}

		} catch (Exception e) {
			e.printStackTrace();

		}

		return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

	}

}
