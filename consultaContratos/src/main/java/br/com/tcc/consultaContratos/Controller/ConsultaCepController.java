package br.com.tcc.consultaContratos.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.tcc.consultaContratos.Service.Impl.ConsultaCepImpl;
import br.com.tcc.consultaContratos.request.CepRequest;
import br.com.tcc.consultaContratos.response.CepResponse;

@RestController
@RequestMapping(value = "/cep")
public class ConsultaCepController {

	@Autowired
	ConsultaCepImpl consultaCepImpl;

	@GetMapping(value = "/consultaCep")
	public ResponseEntity<CepResponse> consultaCep(@RequestBody CepRequest cepRequest) {
		CepResponse consultaCep = null;
		try {
			consultaCep = this.consultaCepImpl.consultaCep(cepRequest);

			return ResponseEntity.status(HttpStatus.OK).body(consultaCep);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

}
