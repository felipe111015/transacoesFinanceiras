package br.com.tcc.consultaContratos.exceptions;

public class ProdutoException extends Exception {

	private static final long serialVersionUID = 1L;

	private String message;

	public ProdutoException(String message) {
		super();

		this.message = message;
	}

	public ProdutoException() {

	}

}
