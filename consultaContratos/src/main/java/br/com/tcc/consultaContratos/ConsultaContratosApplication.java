package br.com.tcc.consultaContratos;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class ConsultaContratosApplication {

	public static void main(String[] args) {
		SpringApplication.run(ConsultaContratosApplication.class, args);
	}
	
	@RequestMapping(value="/home", method = RequestMethod.GET)
	public String home() {
		return "Home Page";
	}

}
