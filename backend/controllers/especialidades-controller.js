const mysql = require('../mysql');

exports.getEspecialidade = async (req, res, next) => {
    try{
        const query = `SELECT DISTINCT especialidade FROM MEDICO;`;

        const result = await mysql.execute(query);

        if(result === 0){
            return res.status(404).send({mensagem: 'Nenhuma especialidade encontrada.'});
        }

        return res.status(200).send({
            mensagem: 'Especialidades retornadas com sucesso',
            quantidade: result.length,
            especialidades: result
        });
    }catch(error){
        return res.status(500).send({error:error});
    }
}

exports.getMedicoByEspecialidade = async (req, res, next) => {
    try{
        const query = `SELECT * FROM MEDICO 
                        INNER JOIN FUNCIONARIO ON MEDICO.cpf=FUNCIONARIO.cpf AND MEDICO.especialidade=?
                        INNER JOIN PESSOA ON MEDICO.cpf=PESSOA.cpf AND MEDICO.especialidade=?;`;
        
        const result = await mysql.execute(query, [req.params.especialidade, req.params.especialidade]);

        if(result.length === 0){
            return res.status(404).send({
                mensagem: `Não foi encontrado nenhum médico com a especialidade ${req.params.especialidade}`
            });
        }

        const response = {
            mensagem: 'Médicos retornados com sucesso.',
            quantidade: result.length,
            medicos: result.map(medico => {
                const {cpf, data_contrato, salario, nome, email, telefone, cep, logradouro, bairro, cidade, estado, especialidade, crm} = medico;
                return {

                    medico: {
                        cpf: cpf,
                        especialidade: especialidade,
                        crm: crm
                    },
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
                    }
                }
            })
        }

        return res.status(200).send(response);
    }catch(error){
        return res.status(500).send({error:error});
    }
}