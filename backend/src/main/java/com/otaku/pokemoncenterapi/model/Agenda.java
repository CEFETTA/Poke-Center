package com.otaku.pokemoncenterapi.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalTime;
import java.util.Date;

@Entity
@Data
public class Agenda implements Serializable {
    @Id
    @ManyToOne
    @JoinColumn(name = "crm", referencedColumnName = "crm")
    private Medico crm;

    @Id
    private Date data;

    @Id
    private LocalTime horario;

    @Column(nullable = false)
    private String cpf;

    @Column(nullable = false)
    private String codigoPokemon;

    @Column(nullable = false)
    private String nomeDono;

    @Column(nullable = false)
    private String nomePokemon;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String telefone;

}
