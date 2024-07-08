const correctUsername = "ritchie";
const correctPassword = "My_H@rd3st_P@$$w0rd_Y3t";

function login() {
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const errorMessage = document.getElementById('error-message');

    if (username === correctUsername && password === correctPassword) {
        errorMessage.textContent = '';
        localStorage.setItem('loggedIn', 'true');
        window.location.href = 'index.php';
    } else {
        errorMessage.textContent = 'Incorrect username or password';
    }
}

function checkLogin() {
    const loggedIn = localStorage.getItem('loggedIn');
    if (loggedIn !== 'true') {
        window.location.href = 'login.html';
    } else {
        document.body.style.display = 'block';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    if (window.location.pathname.includes('index.php')) {
        checkLogin();
    }
});