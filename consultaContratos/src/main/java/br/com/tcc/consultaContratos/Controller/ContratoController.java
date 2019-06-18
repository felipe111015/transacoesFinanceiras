package br.com.tcc.consultaContratos.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import br.com.tcc.consultaContratos.DTO.InPutCpfDto;
import br.com.tcc.consultaContratos.Model.Contrato;
import br.com.tcc.consultaContratos.Service.Impl.ContratoServiceImpl;
import br.com.tcc.consultaContratos.exceptions.ContratoException;

@RestController

public class ContratoController {

	@Autowired
	ContratoServiceImpl serviceContratos;

	@GetMapping(value = "/contrato/contratosCliente")
	public ResponseEntity<List<Contrato>> consultaContratos(@RequestBody InPutCpfDto cpf) {
		List<Contrato> contratos = null;
		try {
			contratos = serviceContratos.buscaContratos(cpf.getCpf());
			return ResponseEntity.status(HttpStatus.OK).body(contratos);
		} catch (ContratoException e) {

			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(contratos);
		}
	}

	@GetMapping(value = "/contrato/listaContratos")
	public ResponseEntity<Iterable<Contrato>> listaContratos() {
		Iterable<Contrato> listaContratos = null;
		try {
			listaContratos = serviceContratos.listaContratos();
			return ResponseEntity.status(HttpStatus.OK).body(listaContratos);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(listaContratos);
		}
	}

	@PostMapping(value = "/contrato/novoContrato")
	public ResponseEntity<Contrato> novoContrato(@RequestBody Contrato contrato) {
		try {

			serviceContratos.criarContrato(contrato);
			return ResponseEntity.status(HttpStatus.OK).body(contrato);

		} catch (ContratoException e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

}
