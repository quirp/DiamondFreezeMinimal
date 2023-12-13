import * as monaco from 'monaco-editor';
console.log("In Script")
// Define editor globally
let editor;

// Initialize Monaco Editor
function initMonacoEditor() {
    editor = monaco.editor.create(document.getElementById('container'), {
        value: "Your Solidity code here...",
        language: 'solidity'
    });

    editor.onDidChangeModelContent((event) => {
        const code = editor.getValue();
        // Call Solhint and get linting results
        // Display linting results in the editor
    });
}

// Call the function to initialize the editor
initMonacoEditor();

document.getElementById('fileInput').addEventListener('change', function (event) {
    const file = event.target.files[0];
    const reader = new FileReader();

    reader.onload = function (e) {
        // Update the editor model with the new file's content
        editor.setModel(monaco.editor.createModel(e.target.result, 'solidity'));
    };

    reader.readAsText(file);
});

document.getElementById('saveButton').addEventListener('click', () => {
    saveFile();
});

document.getElementById('runScriptButton').addEventListener('click', () => {
    fetch('/run-script')
        .then(response => response.text())
        .then(data => console.log(data));
});

function saveFile() {
    const data = new Blob([editor.getValue()], {type: 'text/plain'});
    const textFile = window.URL.createObjectURL(data);
  
    // Create a link to download it
    const a = document.createElement('a');
    a.href = textFile;
    a.download = 'mysolidityfile.sol';
    a.click();
}
