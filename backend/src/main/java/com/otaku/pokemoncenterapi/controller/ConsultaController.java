package com.otaku.pokemoncenterapi.controller;

import com.otaku.pokemoncenterapi.swagger.api.ConsultaApi;
import com.otaku.pokemoncenterapi.swagger.model.Agenda;
import com.otaku.pokemoncenterapi.swagger.model.Endereco;
import com.otaku.pokemoncenterapi.swagger.model.Funcionario;
import com.otaku.pokemoncenterapi.swagger.model.Paciente;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ConsultaController implements ConsultaApi {
    @Override
    public ResponseEntity<List<Agenda>> getAgendamentos(String crm) {
        return null;
    }

    @Override
    public ResponseEntity<List<Endereco>> getEnderecos() {
        return null;
    }

    @Override
    public ResponseEntity<List<Funcionario>> getFuncionarios() {
        return null;
    }

    @Override
    public ResponseEntity<List<Paciente>> getPacientes() {
        return null;
    }
}
