import 'reflect-metadata';
const express = require('express');

import { AppDataSource } from './database/data-source';
import { router } from './routes';
import "./database/data-source";

const cors = require('cors');
const app = express();

app.use((req, res, next) => {

    //Qualquer endereço pode fazer requisição "*"
    res.header("Access-Control-Allow-Origin", "*");

    //Tipos de métodos que a API aceita
    res.header("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE");

    //Permitir o envio de dados para API
    res.header("Access-Control-Allow-Headers", "*");

    //Executar o cors
    app.use(cors());

    //Quando não houver erro deve continuar o processamento
    next();
});

app.use(express.json());

app.use(router);


app.listen(3332, () => {
    console.log("Server started on port 3332");
    AppDataSource.initialize().then( () => {
        console.log("Database ok");
    })
})
