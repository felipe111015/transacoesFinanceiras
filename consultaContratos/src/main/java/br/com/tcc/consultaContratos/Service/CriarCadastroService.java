package br.com.tcc.consultaContratos.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Contrato;
import br.com.tcc.consultaContratos.Repository.ConsultaContratoRepository;

@Service
public class CriarCadastroService {

	@Autowired
	ConsultaContratoRepository repository;
	
	public void criarContrato(Contrato contrato){
		 repository.save(contrato);
		
	}
}
