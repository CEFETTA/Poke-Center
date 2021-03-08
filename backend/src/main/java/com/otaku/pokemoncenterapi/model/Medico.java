package com.otaku.pokemoncenterapi.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
public class Medico implements Serializable {
    @Id
    @OneToOne
    @JoinColumn(name = "cpf", referencedColumnName = "cpf")
    private Funcionario cpf;

    @Id
    @Column(nullable = false)
    private String especialidade;

    @Column(nullable = false, unique = true)
    private String crm;

}
