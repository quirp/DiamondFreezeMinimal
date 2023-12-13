const vscode = require('vscode');

function activate(context) {
    let disposable = vscode.commands.registerCommand('extension.showFileName', function () {
        const editor = vscode.window.activeTextEditor;
        if (!editor) {
            vscode.window.showInformationMessage('No editor is active');
            return;
        }

        const filename = editor.document.fileName;
        const panel = vscode.window.createWebviewPanel(
            'showFileName', 
            "Current Filename", 
            vscode.ViewColumn.One,
            {}
        );

        panel.webview.html = getWebviewContent(filename);
    });

    context.subscriptions.push(disposable);
}

function getWebviewContent(filename) {
    return `<!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Current Filename</title>
            </head>
            <body>
                <h1>Current Filename:</h1>
                <p>${filename}</p>
            </body>
            </html>`;
}

function deactivate() {}

module.exports = {
    activate,
    deactivate
};
