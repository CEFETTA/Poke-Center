package com.otaku.pokemoncenterapi.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Data
public class Paciente implements Serializable {
    @Id
    private String codigoPokemon;

    @Id
    @ManyToOne
    @JoinColumn(name = "cpfDono", referencedColumnName = "cpf")
    private Pessoa cpfDono;

    @Column(nullable = false)
    private String nome;

    @Column(nullable = false)
    private BigDecimal peso;

    @Column(nullable = false)
    private BigDecimal altura;

    @Column(nullable = false)
    private String tipoSanguineo;
}
