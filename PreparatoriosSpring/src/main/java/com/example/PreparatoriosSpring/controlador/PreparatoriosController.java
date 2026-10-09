package com.example.PreparatoriosSpring.controlador;

import com.example.PreparatoriosSpring.modelo.Preparatorios;
import com.example.PreparatoriosSpring.servicio.PreparatoriosService;
import java.util.List;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/preparatorios")
public class PreparatoriosController {

    private final PreparatoriosService preparatoriosService;

    public PreparatoriosController(PreparatoriosService preparatoriosService) {
        this.preparatoriosService = preparatoriosService;
    }

    // GET http://localhost:8080/preparatorios
    @GetMapping
    public List<Preparatorios> listarPreparatorios() {
        return preparatoriosService.listarPreparatorios();
    }

    // GET http://localhost:8080/preparatorios/1
    @GetMapping("/{id}")
    public Preparatorios buscarPorId(@PathVariable int id) {
        return preparatoriosService.buscarPorId(id).orElse(null);
    }

    // GET http://localhost:8080/preparatorios/buscar?titulo=civil
    @GetMapping("/buscar")
    public List<Preparatorios> buscarPorTitulo(@RequestParam String titulo) {
        return preparatoriosService.buscarPorTitulo(titulo);
    }

    // POST http://localhost:8080/preparatorios
    @PostMapping
    public Preparatorios guardar(@RequestBody Preparatorios preparatorio) {
        return preparatoriosService.guardar(preparatorio);
    }

    // PUT http://localhost:8080/preparatorios/1
    @PutMapping("/{id}")
    public Preparatorios actualizar(@PathVariable int id, @RequestBody Preparatorios preparatorio) {

        Preparatorios preparatorioExistente = preparatoriosService.buscarPorId(id).orElse(null);

        if (preparatorioExistente == null) {
            return null;
        }

        preparatorioExistente.setValorPago(preparatorio.getValorPago());
        preparatorioExistente.setFechaEvaluacion(preparatorio.getFechaEvaluacion());
        preparatorioExistente.setLugarEvaluacion(preparatorio.getLugarEvaluacion());
        preparatorioExistente.setEstado(preparatorio.isEstado());
        preparatorioExistente.setValorPagado(preparatorio.getValorPagado());
        preparatorioExistente.setIdTipoEvaluacion(preparatorio.getIdTipoEvaluacion());
        preparatorioExistente.setLimiteInscritos(preparatorio.getLimiteInscritos());
        preparatorioExistente.setFechaLimitePago(preparatorio.getFechaLimitePago());
        preparatorioExistente.setMostrarRecibo(preparatorio.isMostrarRecibo());
        preparatorioExistente.setTitulo(preparatorio.getTitulo());
        preparatorioExistente.setAcuerdo(preparatorio.getAcuerdo());

        return preparatoriosService.guardar(preparatorioExistente);
    }

    // DELETE http://localhost:8080/preparatorios/1
    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable int id) {
        preparatoriosService.eliminar(id);
    }
}