package com.otaku.pokemoncenterapi.controller;

import com.otaku.pokemoncenterapi.repository.PessoaRepository;
import com.otaku.pokemoncenterapi.swagger.api.LoginApi;
import com.otaku.pokemoncenterapi.swagger.model.Mensagem;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
public class LoginController implements LoginApi {
    private PessoaRepository repository;
    @Override
    public ResponseEntity<Mensagem> validarLogin(String email, String senha) {
        Mensagem mensagem = new Mensagem();
        mensagem.setMensagem(repository.findById("123456").get().toString());
        return ResponseEntity.ok(mensagem);
    }
}
