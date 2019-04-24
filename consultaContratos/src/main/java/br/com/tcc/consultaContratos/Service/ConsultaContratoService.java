package br.com.tcc.consultaContratos.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Contrato;
import br.com.tcc.consultaContratos.Repository.ConsultaContratoRepository;

@Service
public class ConsultaContratoService {

	@Autowired
	ConsultaContratoRepository repository;

	public List<Contrato> buscaContratos(String cpf) {
		List<Contrato> contratos = repository.buscarContratos(cpf);

		return contratos;
	}
}
