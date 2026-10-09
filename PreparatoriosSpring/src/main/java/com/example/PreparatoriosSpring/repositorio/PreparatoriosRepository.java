package com.example.PreparatoriosSpring.repositorio;

import com.example.PreparatoriosSpring.modelo.Preparatorios;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PreparatoriosRepository extends JpaRepository<Preparatorios, Integer> {

    // Busca preparatorios cuyo título contenga el texto (sin importar mayúsculas)
    List<Preparatorios> findByTituloContainingIgnoreCase(String titulo);
}