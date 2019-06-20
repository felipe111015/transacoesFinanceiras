package br.com.tcc.consultaContratos.Service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Endereco;
import br.com.tcc.consultaContratos.Repository.EnderecoRepository;
import br.com.tcc.consultaContratos.Service.EnderecoService;

@Service
public class EnderecoServiceImpl implements EnderecoService {

	@Autowired
	private EnderecoRepository enderecoRepository;

	@Override
	public Endereco novoEndereco(Endereco endereco) {
		Endereco novoEndereco = null;
		try {
			novoEndereco = enderecoRepository.save(endereco);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return novoEndereco;

	}

}
