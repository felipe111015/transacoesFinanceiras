package br.com.tcc.consultaContratos.Service;

import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.request.CepRequest;
import br.com.tcc.consultaContratos.response.CepResponse;

@Service
public interface ConsultaCep {

	public CepResponse consultaCep(CepRequest cepRequest);

}
