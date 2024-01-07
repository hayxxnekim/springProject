document.getElementById('showPwBtn').addEventListener('click',(e)=>{
    let pwInput = document.getElementById('pw');

    if (pwInput.type === "password") {
        pwInput.type = "text";
        let showPwBtn = document.getElementById('showPwBtn');
        showPwBtn.className = showPwBtn.className.replace('bi-eye-slash', 'bi-eye');
    } else {
        pwInput.type = "password";
        let showPwBtn = document.getElementById('showPwBtn');
        showPwBtn.className = showPwBtn.className.replace('bi-eye', 'bi-eye-slash');
    }
})

let resultZone = document.getElementById('resultZone');
if (isOk == -1) {
    resultZone.innerText = '비밀번호가 일치하지 않습니다.';
} 

let loginBtn = document.getElementById('loginBtn');
let pwInput = document.getElementById('pw');
pwInput.addEventListener('input', (e) => {
    if (pwInput.value.trim() !== '') {
        loginBtn.disabled = false;
    } else {
        loginBtn.disabled = true;
    }
});