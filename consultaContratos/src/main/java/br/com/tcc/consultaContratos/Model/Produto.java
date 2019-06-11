package br.com.tcc.consultaContratos.Model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Produto {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer codigoProduto;
	private String nome;
	private String descricao;
	private double valor;

	@OneToMany
	private List<Contrato> contrato;

	public Produto() {

	}

	public Produto(Integer codigoProduto, String nome, String descricao, double valor, List<Contrato> contrato) {
		super();
		this.codigoProduto = codigoProduto;
		this.nome = nome;
		this.descricao = descricao;
		this.valor = valor;
		this.contrato = contrato;
	}

	public Integer getCodigoProduto() {
		return codigoProduto;
	}

	public void setId(Integer codigoProduto) {
		this.codigoProduto = codigoProduto;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public double getValor() {
		return valor;
	}

	public void setValor(double valor) {
		this.valor = valor;
	}

	public List<Contrato> getContrato() {
		return contrato;
	}

	public void setContrato(List<Contrato> contrato) {
		this.contrato = contrato;
	}

}
