package br.com.tcc.consultaContratos.Service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.tcc.consultaContratos.Model.Contrato;
import br.com.tcc.consultaContratos.Model.Produto;
import br.com.tcc.consultaContratos.Repository.ContratoRepository;
import br.com.tcc.consultaContratos.Service.ContratoService;
import br.com.tcc.consultaContratos.exceptions.ContratoException;

@Service
public class ContratoServiceImpl implements ContratoService {

	@Autowired
	ContratoRepository repository;

	public List<Contrato> buscaContratos(String cpf) throws ContratoException {
		List<Contrato> contratos = null;

		try {
			contratos = repository.buscarContratos(cpf);
		} catch (Exception e) {
			throw new ContratoException("Erro ao Buscar Contrato!");
		}

		return contratos;
	}

	public void criarContrato(Contrato contrato) throws ContratoException {
		try {
			Contrato contratoFinal = this.calculaValorContrato(contrato);
			double calculaValorParcela = this.calculaValorParcela(contratoFinal);
			contratoFinal.setValorParcela(calculaValorParcela);
			repository.save(contratoFinal);
		} catch (Exception e) {
			throw new ContratoException("Erro na requisição!");
		}

	}

	public Iterable<Contrato> listaContratos() throws ContratoException {
		Iterable<Contrato> listaContratos = null;
		try {
			listaContratos = repository.findAll();
		} catch (Exception e) {
			throw new ContratoException("Erro ao listar Contratos!");
		}

		return listaContratos;
	}

	private Contrato calculaValorContrato(Contrato contrato) {
		List<Produto> produtos = contrato.getProdutos();

		for (Produto produto : produtos) {
			double valorTotal = contrato.getValor() + produto.getValor();
			contrato.setValor(valorTotal);
		}
		return contrato;
	}

	private double calculaValorParcela(Contrato contrato) {
		double valorParcela = 0;

		valorParcela = contrato.getValor() / contrato.getQtdeParcelas();

		return valorParcela;
	}
}
