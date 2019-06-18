package br.com.tcc.consultaContratos.Model;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

@Entity
public class Contrato {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long numeroContrato;

	private double valor;

	private int qtdeParcelas;
	private double valorParcela;

	private LocalDate dataContratacao;

	@ManyToOne
	private Cliente cliente;

	@ManyToMany
	private List<Produto> produtos;

	public Contrato() {

	}

	public Contrato(double valorParcela, long numeroContrato, double valor, int qtdeParcelas, LocalDate dataContratacao,
			Cliente cliente, List<Produto> produtos) {
		super();
		this.numeroContrato = numeroContrato;
		this.valor = valor;
		this.qtdeParcelas = qtdeParcelas;
		this.dataContratacao = dataContratacao;
		this.cliente = cliente;
		this.produtos = produtos;
		this.valorParcela = valorParcela;
	}

	public long getNumeroContrato() {
		return numeroContrato;
	}

	public void setNumeroContrato(long numeroContrato) {
		this.numeroContrato = numeroContrato;
	}

	public Double getValor() {
		return valor;
	}

	public void setValor(double valor) {
		this.valor = valor;
	}

	public int getQtdeParcelas() {
		return qtdeParcelas;
	}

	public void setQtdeParcelas(int qtdeParcelas) {
		this.qtdeParcelas = qtdeParcelas;
	}

	public LocalDate getDataContratacao() {
		return dataContratacao;
	}

	public void setDataContratacao(LocalDate dataContratacao) {
		this.dataContratacao = dataContratacao;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public List<Produto> getProdutos() {
		return produtos;
	}

	public void setProdutos(List<Produto> produtos) {
		this.produtos = produtos;
	}

	public double getValorParcela() {
		return valorParcela;
	}

	public void setValorParcela(double valorParcela) {
		this.valorParcela = valorParcela;
	}

}
