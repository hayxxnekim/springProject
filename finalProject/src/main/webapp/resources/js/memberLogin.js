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

let emailVal = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
document.addEventListener('input', () => {
    let email = document.getElementById('email').value;
    let pw = document.getElementById('pw').value;

    if(emailVal.test(email)){
        document.getElementById('emailMsg').style = "display:none";
        if (pw) {
            document.getElementById('loginBtn').disabled = false;
        }else{
            document.getElementById('loginBtn').disabled = true;
        }
    }else{
        document.getElementById('emailMsg').style = "display:inline-block";
        document.getElementById('loginBtn').disabled = true;
    }

})