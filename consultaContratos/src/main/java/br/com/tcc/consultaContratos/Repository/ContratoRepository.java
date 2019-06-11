package br.com.tcc.consultaContratos.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import br.com.tcc.consultaContratos.Model.Contrato;

@Repository
public interface ContratoRepository extends CrudRepository<Contrato, Long> {
	
	@Query("SELECT c  FROM Contrato c where c.cliente.cpf = :cpf")
	public List<Contrato> buscarContratos(@Param("cpf") String cpf);
	

}
