package br.com.tcc.consultaContratos.Model;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Contrato {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long numeroContrato;
	private double valor;
	private int qtdeParcelas;
	private LocalDate dataContratação;

	@ManyToOne
	private Cliente cliente;

	@OneToMany
	private List<Produto> produto;

	public Contrato() {

	}

	public Contrato(long numeroContrato, double valor, int qtdeParcelas, LocalDate dataContratação, Cliente cliente,
			List<Produto> produto) {
		super();
		this.numeroContrato = numeroContrato;
		this.valor = valor;
		this.qtdeParcelas = qtdeParcelas;
		this.dataContratação = dataContratação;
		this.cliente = cliente;
		this.produto = produto;
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

	public LocalDate getDataContratação() {
		return dataContratação;
	}

	public void setDataContratação(LocalDate dataContratação) {
		this.dataContratação = dataContratação;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public List<Produto> getProduto() {
		return produto;
	}

	public void setProduto(List<Produto> produto) {
		this.produto = produto;
	}

}
