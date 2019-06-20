package br.com.tcc.consultaContratos.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.tcc.consultaContratos.Model.Endereco;
import br.com.tcc.consultaContratos.Service.Impl.EnderecoServiceImpl;

@RestController
@RequestMapping(value = "/endereco")
public class EnderecoController {
	@Autowired
	EnderecoServiceImpl enderecoServiceImpl;

	@PostMapping(value = "/novoEndereco")
	public ResponseEntity<Endereco> novoEndereco(@RequestBody Endereco endereco) {
		Endereco novoEndereco = null;
		try {
			novoEndereco = enderecoServiceImpl.novoEndereco(endereco);
			return ResponseEntity.status(HttpStatus.OK).body(novoEndereco);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}

	}

}
