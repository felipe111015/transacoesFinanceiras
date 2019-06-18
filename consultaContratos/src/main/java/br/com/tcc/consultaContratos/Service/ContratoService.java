package br.com.tcc.consultaContratos.Service;

import java.util.List;

import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Contrato;
import br.com.tcc.consultaContratos.exceptions.ContratoException;

@Service
public interface ContratoService {

	public void criarContrato(Contrato contrato) throws ContratoException;

	public List<Contrato> buscaContratos(String cpf) throws ContratoException;
	
	public Iterable<Contrato> listaContratos() throws ContratoException;

}
