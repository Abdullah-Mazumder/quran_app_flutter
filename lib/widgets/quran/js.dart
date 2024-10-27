String js = """
function addSukunToClasses(classConfig) {
    classConfig.forEach(config => {
        document.querySelectorAll(`.\${config.className}`).forEach(element => {
            element.innerHTML = element.innerHTML.replace(config.regex, config.replacement);
        });
    });
}

const classConfig = [
    { className: 'ikhf', regex: /ن(?!ْ)/g, replacement: 'نْ' },
    { className: 'madda_permissible', regex: /(?<=\b|[^ْ])([ِيُو])(?!ْ)/g, replacement: '\$1ْ' },
    { className: 'idgh_ghn', regex: /ن(?!ْ)/g, replacement: 'نْ' },
    { className: 'idgh_w_ghn', regex: /ن(?!ْ)/g, replacement: 'نْ' },
    { className: 'ikhf_shfw', regex: /م(?!ْ)/g, replacement: 'مْ' },
    { className: 'idghm_shfw', regex: /م(?!ْ)/g, replacement: 'مْ' },
];

addSukunToClasses(classConfig);

function applyColorToNextWord(className, color) {
    const elements = document.querySelectorAll(`.\${className}`);

    elements.forEach((element) => {
        let nextWordElement = element.parentElement?.nextElementSibling;

        if (nextWordElement) {
            nextWordElement.innerHTML = `<span style="color: \${color};">\${nextWordElement.textContent.charAt(0)}</span>\${nextWordElement.textContent.slice(1)}`;
        }
    });
}

applyColorToNextWord('idghm_shfw', '#f58900');
applyColorToNextWord('idgh_ghn', '#419c45');
applyColorToNextWord('ikhf_shfw', '#ffa7b6');
applyColorToNextWord('iqlb', '#b100b1');
""";
