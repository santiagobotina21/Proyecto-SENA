package com.example.PreparatoriosSpring.servicio;

import com.example.PreparatoriosSpring.modelo.Preparatorios;
import com.example.PreparatoriosSpring.repositorio.PreparatoriosRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Service;

@Service
public class PreparatoriosService {

    private final PreparatoriosRepository preparatoriosRepository;

    public PreparatoriosService(PreparatoriosRepository preparatoriosRepository) {
        this.preparatoriosRepository = preparatoriosRepository;
    }

    // Listar todos los preparatorios
    public List<Preparatorios> listarPreparatorios() {
        return preparatoriosRepository.findAll();
    }

    // Buscar preparatorio por ID
    public Optional<Preparatorios> buscarPorId(int id) {
        return preparatoriosRepository.findById(id);
    }

    // Buscar preparatorios por título
    public List<Preparatorios> buscarPorTitulo(String titulo) {
        return preparatoriosRepository.findByTituloContainingIgnoreCase(titulo);
    }

    // Guardar preparatorio (crear o actualizar)
    public Preparatorios guardar(Preparatorios preparatorio) {
        return preparatoriosRepository.save(preparatorio);
    }

    // Eliminar preparatorio
    public void eliminar(int id) {
        preparatoriosRepository.deleteById(id);
    }
}