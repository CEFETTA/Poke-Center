package com.otaku.pokemoncenterapi.controller;

import com.otaku.pokemoncenterapi.swagger.api.EnderecoApi;
import com.otaku.pokemoncenterapi.swagger.model.Endereco;
import com.otaku.pokemoncenterapi.swagger.model.Mensagem;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
public class EnderecoController implements EnderecoApi {
    @Override
    public ResponseEntity<Mensagem> cadastrar(@Valid Endereco endereco) {
        return null;
    }
}
