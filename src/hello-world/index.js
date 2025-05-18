const express = require('express');
const functions = require('@google-cloud/functions-framework');

const app = express();

app.use(express.json());

app.get('/', (_, res) => res.send());
app.post('/', (_, res) => res.status(500).send());

functions.http('helloWorld', app);