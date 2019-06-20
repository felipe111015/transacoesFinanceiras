package br.com.tcc.consultaContratos.Model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.PrimaryKeyJoinColumn;

@Entity
public class Cliente {

	@Id
	@PrimaryKeyJoinColumn
	private String cpf;
	private String nome;
	private String agencia;
	private String conta;
	@ManyToMany
	private List<Endereco> endereco;

	public Cliente() {

	}

	public Cliente(String cpf, String nome, String agencia, String conta, List<Endereco> endereco) {
		super();
		this.cpf = cpf;
		this.nome = nome;
		this.agencia = agencia;
		this.conta = conta;
		this.endereco = endereco;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getAgencia() {
		return agencia;
	}

	public void setAgencia(String agencia) {
		this.agencia = agencia;
	}

	public String getConta() {
		return conta;
	}

	public void setConta(String conta) {
		this.conta = conta;
	}

	public List<Endereco> getEndereco() {
		return endereco;
	}

	public void setEndereco(List<Endereco> endereco) {
		this.endereco = endereco;
	}

}
