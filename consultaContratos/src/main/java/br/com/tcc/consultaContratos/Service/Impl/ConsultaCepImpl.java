package br.com.tcc.consultaContratos.Service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Service.ConsultaCep;
import br.com.tcc.consultaContratos.request.CepRequest;
import br.com.tcc.consultaContratos.response.CepResponse;
import br.com.tcc.consultaContratos.utill.BuscaCepClient;

@Service
public class ConsultaCepImpl implements ConsultaCep {

	@Autowired
	BuscaCepClient buscaCepClient;

	@Override
	public CepResponse consultaCep(CepRequest cepRequest) {
		CepResponse consultaCep = null;
		try {
			consultaCep = this.buscaCepClient.consultaCep(cepRequest);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return consultaCep;
	}

}
