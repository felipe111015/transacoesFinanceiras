package br.com.tcc.consultaContratos.exceptions;

public class ContratoException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String message;

	public ContratoException(String message) {
		super();

		this.message = message;
	}

	public ContratoException() {

	}

}
