package com.otaku.pokemoncenterapi.controller;



import com.otaku.pokemoncenterapi.swagger.api.AgendamentoApi;
import com.otaku.pokemoncenterapi.swagger.model.DadosMedico;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class AgendamentoController implements AgendamentoApi {
    @Override
    public ResponseEntity<List<String>> getEspecialidade() {
        return null;
    }

    @Override
    public ResponseEntity<List<List<String>>> getHorarios(String crm, String data) {
        return null;
    }

    @Override
    public ResponseEntity<List<DadosMedico>> getMedicos(String especialidade) {
        return null;
    }
}
