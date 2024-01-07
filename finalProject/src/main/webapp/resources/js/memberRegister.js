//지도 api
document.getElementById('addr').addEventListener('click', ()=>{
    //카카오 지도 발생
    new daum.Postcode({
        oncomplete: function(data) { //선택시 입력값 세팅
            console.log(data);
            // document.getElementById('addr').value = data.address;
            document.getElementById('addr').value = `${data.sido} ${data.sigungu} ${data.bname}`;
            document.getElementById('sido').value = data.sido;
            document.getElementById('sigg').value = data.sigungu;
            document.getElementById('emd').value = data.bname;
            registerBtnAbled();
        }
    }).open();

})

//비밀번호 눈 버튼 
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

//이메일 정규표현식&중복체크
let emailVal = /^(?:[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$/;
document.getElementById('email').addEventListener('input', ()=>{
    let email = document.getElementById('email').value;
    console.log(email);
    //정규표현식
    if(!emailVal.test(email)){
        document.getElementById('emailMsg').style = "display:inline-block";
        document.getElementById('emailMsg2').style = "display:none";
        document.getElementById('testBtn').disabled = true;
    }else{
        document.getElementById('emailMsg').style = "display:none";
        //이메일 존재 여부
        hasEmail(email).then(result =>{
            if(result == 1){
                document.getElementById('emailMsg2').style = "display:inline-block";
                document.getElementById('testBtn').disabled = true;
            }else{
                document.getElementById('emailMsg2').style = "display:none";
                document.getElementById('testBtn').disabled = false;
            }
        })
        
    }
    registerBtnAbled();

    if(email !== ''){
        document.getElementById('emailMsg3').style = "display:none";
    }

})
//이메일 전송 메서드
async function hasEmail(email){
    try{
        const resp = await fetch('/member/email/'+email);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

//비밀번호 정규표현식
let pwVal = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
document.getElementById('pw').addEventListener('input',()=>{
    let pw = document.getElementById('pw').value;
    console.log(pw);

    //문자길이
    if(pw.length < 8 || pw.length > 16){
        document.getElementById('pwMsg2').style = "display:inline-block";
    }else{
        document.getElementById('pwMsg2').style = "display:none";
        //정규표현식
        if(!pwVal.test(pw)){
            document.getElementById('pwMsg').style = "display:inline-block";
        }else{
            document.getElementById('pwMsg').style = "display:none";
        }
    }
    
    registerBtnAbled();
})

//닉네임 중복체크
document.getElementById('nick').addEventListener('input', async ()=>{
    let nick = document.getElementById('nick').value;
    console.log(nick);
    
    const result = await hasNick(nick);
    if(result == 1){
        document.getElementById('nickMsg').style = "display:inline-block";
    }else{
        document.getElementById('nickMsg').style = "display:none";
    }
    registerBtnAbled();

})
//닉네임 전송 메서드
async function hasNick(nick){
    try{
        const resp = await fetch('/member/nick/'+nick);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

//전화번호 중복체크
let regExp = /^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/;
document.getElementById('phone').addEventListener('input', async ()=>{
    let phone = document.getElementById('phone').value;
    console.log(phone);
    if(!regExp.test(phone)){
        document.getElementById('phoneMsg1').style = "display:inline-block";
        document.getElementById('phoneMsg2').style = "display:none";
    }else{
        document.getElementById('phoneMsg1').style = "display:none";

        const result = await hasPhone(phone);
        if(result == 1){
            document.getElementById('phoneMsg2').style = "display:inline-block";
        }else{
            document.getElementById('phoneMsg2').style = "display:none";
        }
    }
    registerBtnAbled();

})
//전화번호 전송 메서드
async function hasPhone(phone){
    try{
        const resp = await fetch('/member/phone/'+phone);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

//모든 조건 충족시 가입하기 버튼오픈
function registerBtnAbled(){
    const emailMsg = document.getElementById('emailMsg');
    const emailMsg2 = document.getElementById('emailMsg2');
    const test = document.getElementById('testO');
    const pwMsg = document.getElementById('pwMsg');
    const pwMsg2 = document.getElementById('pwMsg2');
    const nickMsg = document.getElementById('nickMsg');
    const phoneMsg1 = document.getElementById('phoneMsg1');
    const phoneMsg2 = document.getElementById('phoneMsg2');
    const addrValue = document.getElementById('addr').value;
    const allCheckboxChecked = document.getElementById('all').checked;
    const nickValue = document.getElementById('nick').value;
    const phoneValue = document.getElementById('phone').value;

    const emailMsgDisplay = window.getComputedStyle(emailMsg).getPropertyValue('display');
    const emailMsg2Display = window.getComputedStyle(emailMsg2).getPropertyValue('display');
    const testDisplay = window.getComputedStyle(test).getPropertyValue('display');
    const pwMsgDisplay = window.getComputedStyle(pwMsg).getPropertyValue('display');
    const pwMsg2Display = window.getComputedStyle(pwMsg2).getPropertyValue('display');
    const nickMsgDisplay = window.getComputedStyle(nickMsg).getPropertyValue('display');
    const phoneMsgDisplay1 = window.getComputedStyle(phoneMsg1).getPropertyValue('display');
    const phoneMsgDisplay2 = window.getComputedStyle(phoneMsg2).getPropertyValue('display');

    if(emailMsgDisplay === 'none' && emailMsg2Display === 'none' && testDisplay === 'inline-block'
     && pwMsgDisplay === 'none' && pwMsg2Display === 'none' && nickMsgDisplay === 'none' && phoneMsgDisplay1 === 'none' && phoneMsgDisplay2 === 'none'
     && addrValue !== '' && nickValue !== '' && phoneValue !== '' && allCheckboxChecked){
        document.getElementById('regiBtn').disabled = false;
    } else {
        document.getElementById('regiBtn').disabled = true;
    }
}

//약관 + / - 버튼 아코디언
document.getElementById('open').addEventListener('click', ()=>{
    let check_sub = document.getElementById('check_sub');
    if(document.getElementById('openIcon').classList.contains('bi-plus-lg')){
        document.getElementById('openIcon').classList.replace('bi-plus-lg', 'bi-dash-lg');
        check_sub.style = "display:inline-block";
    }else{
        document.getElementById('openIcon').classList.replace('bi-dash-lg', 'bi-plus-lg');
        check_sub.style = "display:none";
    }

})
document.getElementById('open2').addEventListener('click', ()=>{
    let check_sub = document.getElementById('check_sub2');
    if(document.getElementById('openIcon2').classList.contains('bi-plus-lg')){
        document.getElementById('openIcon2').classList.replace('bi-plus-lg', 'bi-dash-lg');
        check_sub.style = "display:inline-block";
    }else{
        document.getElementById('openIcon2').classList.replace('bi-dash-lg', 'bi-plus-lg');
        check_sub.style = "display:none";
    }

})

//체크 관련 js
document.getElementById('all').addEventListener('click', () => {
    const checkboxes = document.getElementsByClassName('check');
    const emptySquares = document.getElementsByClassName('emptySquare');

    if (document.getElementById('all').checked) {
        for (const checkbox of checkboxes) {
            checkbox.checked = true;
        }
        for(const emptySquare of emptySquares){
            emptySquare.classList.replace('bi-check-square', 'bi-check-square-fill');
        }
    } else {
        for (const checkbox of checkboxes) {
            checkbox.checked = false;
        }
        for(const emptySquare of emptySquares){
            emptySquare.classList.replace('bi-check-square-fill', 'bi-check-square');
        }
    }
    registerBtnAbled();
});
document.addEventListener('click',(e)=>{
    const serviceChecked = document.getElementById('service').checked;
    const personalChecked = document.getElementById('personal').checked;

    if(serviceChecked){
        document.getElementById('serviceAgree').classList.replace('bi-check-square', 'bi-check-square-fill');
    }else{
        document.getElementById('serviceAgree').classList.replace('bi-check-square-fill', 'bi-check-square');
    }

    if(personalChecked){
        document.getElementById('personalAgree').classList.replace('bi-check-square', 'bi-check-square-fill');
    }else{
        document.getElementById('personalAgree').classList.replace('bi-check-square-fill', 'bi-check-square');
    }

    if (serviceChecked && personalChecked) {
        document.getElementById('all').checked = true;
        document.getElementById('allAgree').classList.replace('bi-check-square', 'bi-check-square-fill');
    } else {
        document.getElementById('all').checked = false;
        document.getElementById('allAgree').classList.replace('bi-check-square-fill', 'bi-check-square');
    }
    registerBtnAbled();
})

document.getElementById('event').addEventListener('click', () => {
    const checkboxes = document.getElementsByClassName('check2');
    const emptySquares = document.getElementsByClassName('emptySquare2');
    
    if (document.getElementById('event').checked) {
        for (const checkbox of checkboxes) {
            checkbox.checked = true;
        }
        for(const emptySquare of emptySquares){
            emptySquare.classList.replace('bi-check-square', 'bi-check-square-fill');
        }
    } else {
        for (const checkbox of checkboxes) {
            checkbox.checked = false;
        }
        for(const emptySquare of emptySquares){
            emptySquare.classList.replace('bi-check-square-fill', 'bi-check-square');
        }
    }
});
document.addEventListener('click',(e)=>{
    const appChecked = document.getElementById('app').checked;
    const messageChecked = document.getElementById('message').checked;
    const emailChecked = document.getElementById('agreeEmail').checked;

    if(appChecked){
        document.getElementById('appAgree').classList.replace('bi-check-square', 'bi-check-square-fill');
    }else{
        document.getElementById('appAgree').classList.replace('bi-check-square-fill', 'bi-check-square');
    }

    if(messageChecked){
        document.getElementById('messageAgree').classList.replace('bi-check-square', 'bi-check-square-fill');
    }else{
        document.getElementById('messageAgree').classList.replace('bi-check-square-fill', 'bi-check-square');
    }

    if(emailChecked){
        document.getElementById('emailAgree').classList.replace('bi-check-square', 'bi-check-square-fill');
    }else{
        document.getElementById('emailAgree').classList.replace('bi-check-square-fill', 'bi-check-square');
    }

    if (appChecked && messageChecked && emailChecked) {
        document.getElementById('event').checked = true;
        document.getElementById('eventAgree').classList.replace('bi-check-square', 'bi-check-square-fill');
    } else {
        document.getElementById('event').checked = false;
        document.getElementById('eventAgree').classList.replace('bi-check-square-fill', 'bi-check-square');
    }

})

//메일
document.getElementById('testBtn').addEventListener('click',()=>{
    swal.fire({
        text: "인증메일 발송",
        icon: "success",
        showConfirmButton: false,
        width: 400,
        timer: 1000
    });
    const email = document.getElementById('email').value;
    const emailMsg = document.getElementById('emailMsg');
    const emailMsg2 = document.getElementById('emailMsg2');
    const emailMsgDisplay = window.getComputedStyle(emailMsg).getPropertyValue('display');
    const emailMsg2Display = window.getComputedStyle(emailMsg2).getPropertyValue('display');
    
    if(emailMsgDisplay === 'inline-block' || emailMsg2Display === 'inline-block'){
        document.getElementById('emailMsg3').style = "display:none";
    }else if(email == ''){
        document.getElementById('emailMsg3').style = "display:inline-block";
    }
    
    //이메일을 controller에 전송해서 해당 이메일로 인증번호 보내고 
    //인증번호를 result값으로 받아와 내가 input에 적은 인증번호와 같은지 확인
    mailTest(email).then(result => {
        document.getElementById('testNum').addEventListener('input',()=>{
            if(result == document.getElementById('testNum').value){
                document.getElementById('testO').style = "display:inline-block";
                document.getElementById('testX').style = "display:none";
            }else{
                document.getElementById('testO').style = "display:none";
                document.getElementById('testX').style = "display:inline-block";
            }
            registerBtnAbled();
        })

    });
})

async function mailTest(email){
    try{
        const resp = await fetch('/member/test/'+email);
        const result = await resp.text();
        return result; //인증번호

    }catch(err){
        console.log(err);
    }
}
document.getElementById('testNum').addEventListener('input',()=>{
    if(document.getElementById('email').value == ''){
        document.getElementById('emailMsg3').style = "display:inline-block";
    }else{
        document.getElementById('emailMsg3').style = "display:none";
    }
})