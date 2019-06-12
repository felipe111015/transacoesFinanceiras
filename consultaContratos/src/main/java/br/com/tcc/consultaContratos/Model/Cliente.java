package br.com.tcc.consultaContratos.Model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Cliente {

	@Id
	private String cpf;
	private String nome;
	private String agencia;
	private String conta;
	@OneToMany
	@JsonManagedReference
	private List<Contrato> contrato;

	public Cliente() {

	}

	public Cliente(String cpf, String nome, String agencia, String conta, List<Contrato> contrato) {
		super();
		this.cpf = cpf;
		this.nome = nome;
		this.agencia = agencia;
		this.conta = conta;
		this.contrato = contrato;
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

	public List<Contrato> getContrato() {
		return contrato;
	}

	public void setContrato(List<Contrato> contrato) {
		this.contrato = contrato;
	}

}
