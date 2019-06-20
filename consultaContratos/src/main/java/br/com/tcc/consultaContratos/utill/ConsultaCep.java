package br.com.tcc.consultaContratos.utill;

import br.com.tcc.consultaContratos.request.CepRequest;
import br.com.tcc.consultaContratos.response.CepResponse;

public interface ConsultaCep {

	public CepResponse consultaCep(final CepRequest cepRequest);

}
