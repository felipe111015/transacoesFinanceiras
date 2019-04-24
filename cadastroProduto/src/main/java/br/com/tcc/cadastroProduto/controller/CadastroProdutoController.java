package br.com.tcc.cadastroProduto.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.tcc.cadastroProduto.model.Produto;
import br.com.tcc.cadastroProduto.service.CadastroProdutoService;

@RestController
@RequestMapping(value = "/produto")
public class CadastroProdutoController {

	@Autowired
	private CadastroProdutoService service;

	@RequestMapping(value = "/novoProduto")
	public ResponseEntity<Produto> novoProduto(@RequestBody Produto produto) {
		try {
			Produto novoProduto = service.novoProduto(produto);
			return ResponseEntity.status(HttpStatus.CREATED).body(novoProduto);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
}
