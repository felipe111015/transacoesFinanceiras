package br.com.tcc.consultaContratos.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Contrato;
import br.com.tcc.consultaContratos.Model.Produto;
import br.com.tcc.consultaContratos.Repository.ContratoRepository;

@Service
public class ContratoService {

	@Autowired
	ContratoRepository repository;

	public List<Contrato> buscaContratos(String cpf) {
		List<Contrato> contratos = repository.buscarContratos(cpf);

		return contratos;
	}

	public void criarContrato(Contrato contrato) {
		repository.save(contrato);

	}

	public Contrato calculaValorContrato(Contrato contrato) {
		List<Produto> produtos = contrato.getProdutos();

		for (Produto produto : produtos) {
			double valorTotal = contrato.getValor() + produto.getValor();
			contrato.setValor(valorTotal);
		}
		return contrato;
	}
}
