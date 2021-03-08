package com.otaku.pokemoncenterapi.repository;

import com.otaku.pokemoncenterapi.model.Pessoa;
import org.springframework.data.jpa.repository.JpaRepository;


public interface PessoaRepository extends JpaRepository<Pessoa, String> {

}
