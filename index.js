const express = require('express');
const app = express();

const REGION = process.env.REGION || 'unknown';

app.get('/', (req, res) => {
  console.log('Hello world received a request.');
  res.send(`Hello from ${REGION} region`);
});

app.get('/ping', (req, res) => {
    res.json({ok: true, region: REGION});
});

const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log('Hello world listening on port', port);
});