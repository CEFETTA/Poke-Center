const mysql = require('../mysql');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

exports.logar = async (req, res, next) => {
    try{
        var query = `SELECT * FROM FUNCIONARIO f JOIN PESSOA p ON f.cpf=p.cpf AND p.email=?;`;

        var result = await mysql.execute(query, [req.body.email]);

        if(result.length === 0){
            return res.status(401).send({ message: 'Falha na autenticação' });
        }

        if(await bcrypt.compareSync(req.body.senha, result[0].senha_hash)){
            query = `SELECT * FROM MEDICO WHERE cpf=?;`;

            var medico = await mysql.execute(query, result[0].cpf);

            medico = medico.length === 0 ? {} : medico[0];

            const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado} = result[0];

            // decode do login middleware
            const token = jwt.sign({
                cpf: cpf
            }, 
            process.env.JWT_KEY, 
            {expiresIn: "1d"},
            );

            return res.status(200).send({
                mensagem: 'Autenticado', 
                token: token,
                funcionario: {
                    cpf: cpf,
                    data_contrato: data_contrato,
                    salario: salario,
                },
                pessoa: {
                    cpf: cpf,
                    nome: nome,
                    email: email,
                    telefone: telefone,
                    cep: cep,
                    logradouro: logradouro,
                    bairro: bairro,
                    cidade: cidade,
                    estado: estado
                },
                medico: medico
            });
        }

        return res.status(401).send({ message: 'Falha na autenticação' })
    }catch(error){
        return res.status(500).send({error:error});
    }
}