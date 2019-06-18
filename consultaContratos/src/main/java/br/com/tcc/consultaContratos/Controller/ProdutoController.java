package br.com.tcc.consultaContratos.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import br.com.tcc.consultaContratos.Model.Produto;
import br.com.tcc.consultaContratos.Service.Impl.ProdutoServiceImpl;

@RestController
public class ProdutoController {

	@Autowired
	ProdutoServiceImpl produtoService;

	@PostMapping(value = "/produto/novoProduto")
	public ResponseEntity<Produto> novoProduto(@RequestBody Produto produto) {
		try {
			Produto novoProduto = produtoService.novoProduto(produto);
			return ResponseEntity.status(HttpStatus.OK).body(novoProduto);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

	@GetMapping(value = "/produto/listaProdutos")
	public ResponseEntity<Iterable<Produto>> listaProdutos() {
		try {
			Iterable<Produto> listaProdutos = produtoService.listaProdutos();
			return ResponseEntity.status(HttpStatus.OK).body(listaProdutos);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}

}
