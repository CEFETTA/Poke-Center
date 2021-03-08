package com.otaku.pokemoncenterapi.controller;



import com.otaku.pokemoncenterapi.swagger.api.CadastroApi;
import com.otaku.pokemoncenterapi.swagger.model.Funcionario;
import com.otaku.pokemoncenterapi.swagger.model.Medico;
import com.otaku.pokemoncenterapi.swagger.model.Mensagem;
import com.otaku.pokemoncenterapi.swagger.model.Pessoa;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController

public class CadastroController implements CadastroApi {
    @Override
    public ResponseEntity<Mensagem> cadastrarFuncionario(@Valid Funcionario funcionario) {
        return null;
    }

    @Override
    public ResponseEntity<Mensagem> cadastrarMedico(@Valid Medico medico) {
        return null;
    }

    @Override
    public ResponseEntity<Mensagem> cadastrarPessoa(@Valid Pessoa pessoa) {
        return null;
    }
}
