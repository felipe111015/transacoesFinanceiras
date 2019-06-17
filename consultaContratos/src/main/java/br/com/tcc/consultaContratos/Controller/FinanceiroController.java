package br.com.tcc.consultaContratos.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	@GetMapping(value = "/contrato/contratos")
	public ResponseEntity<List<Contrato>> consultaContratos(@RequestBody InPutCpfDto cpf) {
		try {
			List<Contrato> contratos = serviceContratos.buscaContratos(cpf.getCpf());
			return ResponseEntity.status(HttpStatus.OK).body(contratos);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
		}
	}

	@RequestMapping(value = "/contrato/novoContrato", method = RequestMethod.POST)
	public ResponseEntity<Contrato> novoContrato(@RequestBody Contrato contrato) {
		try {
			
			Contrato contratoFinal = serviceContratos.calculaValorContrato(contrato);
			serviceContratos.criarContrato(contratoFinal);
			return ResponseEntity.status(HttpStatus.OK).body(contratoFinal);
			
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

	@GetMapping(value = "/produto/listaProdutos")
	public ResponseEntity<Iterable<Produto>> listaProdutos() {
		try {
			Iterable<Produto> listaProdutos = produtoService.listaProdutos();
			return ResponseEntity.status(HttpStatus.OK).body(listaProdutos);
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

			return ResponseEntity.status(HttpStatus.OK).body(listaClientes);

		} catch (Exception e) {
			e.printStackTrace();

		}

		return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

	}

}
