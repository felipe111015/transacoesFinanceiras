package br.com.tcc.consultaContratos.Model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Produto {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long codigoProduto;
	private String nome;
	private String descricao;
	private double valor;

	public Produto() {

	}

	public Produto(Integer codigoProduto, String nome, String descricao, double valor) {
		super();
		this.codigoProduto = codigoProduto;
		this.nome = nome;
		this.descricao = descricao;
		this.valor = valor;

	}

	public long getCodigoProduto() {
		return codigoProduto;
	}

	public void setId(long codigoProduto) {
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

}
