package com.otaku.pokemoncenterapi.model;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Data
@NotNull
public class Funcionario implements Serializable {

    @Id
    @OneToOne
    @JoinColumn(name = "cpf", referencedColumnName = "cpf")
    private Pessoa cpf;

    @Column(nullable = false)
    private BigDecimal salario;

    @Column(nullable = false)
    private Date dataContrato;

    @Column(nullable = false)
    private String senha;
}
