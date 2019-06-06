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
import br.com.tcc.consultaContratos.Model.Contrato;
import br.com.tcc.consultaContratos.Service.ConsultaContratoService;
import br.com.tcc.consultaContratos.Service.CriarCadastroService;

@RestController
@RequestMapping(value = "/contratos")
public class ConsultaContratosController {

	@Autowired
	ConsultaContratoService serviceConsultaContratos;
	@Autowired
	CriarCadastroService serviceNovoCadastro;

	@GetMapping(value = "/listaContratos")
	public ResponseEntity<List<Contrato>> consultaContratos(@RequestBody InPutCpfDto cpf) {
		try {
			List<Contrato> contratos = serviceConsultaContratos.buscaContratos(cpf.getCpf());
			return ResponseEntity.status(HttpStatus.OK).body(contratos);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
		}
	}

	@SuppressWarnings("unchecked")
	@PostMapping(value = "/novoContrato")
	public ResponseEntity<Contrato> novoContrato(@RequestBody Contrato contrato) {
		try {
			serviceNovoCadastro.criarContrato(contrato);
			return (ResponseEntity<Contrato>) ResponseEntity.status(HttpStatus.CREATED);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

}
