package br.com.tcc.consultaContratos.utill;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import br.com.tcc.consultaContratos.request.CepRequest;
import br.com.tcc.consultaContratos.response.CepResponse;

@Component
public class BuscaCepClient implements ConsultaCep {

	@Autowired
	RestTemplate restTemplate;

	@Override
	public CepResponse consultaCep(CepRequest cepRequest) {

		ResponseEntity<CepResponse> cepResponse = null;

		try {

			cepResponse = this.restTemplate.getForEntity(
					"https://webmaniabr.com/api/1/" + cepRequest.getCep() + "?app_key=aHon09X3CQ1OyW4BdPwFKFBqSqewAuj8"
							+ "&app_secret=Ro6VM0ZHrjNHLQ0rx1l8YAJp65VHb5TOJWTqmnmC0qWdcRXw",
					CepResponse.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cepResponse.getBody();
	}

}
