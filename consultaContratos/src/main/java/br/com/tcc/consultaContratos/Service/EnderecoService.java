package br.com.tcc.consultaContratos.Service;

import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Endereco;

@Service
public interface EnderecoService {

	public Endereco novoEndereco(Endereco endereco);	

}
