const express = require('express');
const { exec } = require('child_process');
const path = require('path');
const app = express();
const port = 3000;

app.use(express.static(path.join(__dirname, 'dist')));

app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist/index.html'));
});

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});

// Additional routes for file operations and executing scripts wil
app.get('/run-script', (req, res) => {
    exec('your-script.sh', (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return res.status(500).send('Script execution failed');
        }
        res.send(`Script executed successfully: ${stdout}`);
    });
});

app.get('/a', (req, res) => {
    res.send("Hello")
});