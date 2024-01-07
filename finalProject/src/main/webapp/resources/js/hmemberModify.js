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
document.getElementById('showPwBtn1').addEventListener('click',(e)=>{
    let pwInput = document.getElementById('pw1');
    
    if (pwInput.type === "password") {
        pwInput.type = "text";
        let showPwBtn = document.getElementById('showPwBtn1');
        showPwBtn.className = showPwBtn.className.replace('bi-eye-slash', 'bi-eye');
    } else {
        pwInput.type = "password";
        let showPwBtn = document.getElementById('showPwBtn1');
        showPwBtn.className = showPwBtn.className.replace('bi-eye', 'bi-eye-slash');
    }
})

document.getElementById('showPwBtn2').addEventListener('click',(e)=>{
    let pwInput = document.getElementById('pw2');

    if (pwInput.type === "password") {
        pwInput.type = "text";
        let showPwBtn = document.getElementById('showPwBtn2');
        showPwBtn.className = showPwBtn.className.replace('bi-eye-slash', 'bi-eye');
    } else {
        pwInput.type = "password";
        let showPwBtn = document.getElementById('showPwBtn2');
        showPwBtn.className = showPwBtn.className.replace('bi-eye', 'bi-eye-slash');
    }
})

//비밀번호 정규표현식
let pwVal = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;

document.getElementById('pw1').addEventListener('input',()=>{
    let pw1 = document.getElementById('pw1').value;
    let pw2 = document.getElementById('pw2').value;

    //문자길이
    if(pw1.length < 8 || pw1.length > 16){
        document.getElementById('pwMsg2_1').style = "display:inline-block";
        registerBtnAbled();
    }else{
        document.getElementById('pwMsg2_1').style = "display:none";
        //정규표현식
        if(!pwVal.test(pw1)){
            document.getElementById('pwMsg1_1').style = "display:inline-block";
            document.getElementById('pwMsg1_2').style = "display:none";
            registerBtnAbled();
        } else{
            document.getElementById('pwMsg1_1').style = "display:none";
            //정규식 통과 후

            //비밀번호 입력 체크
            if(pw1!=='' && pw2==='') {
                registerBtnAbled();
            } else if(pw1!=='' && pw2!==''){
                registerBtnAbled();
            } 
            
            if(pw1=='' && pw2=='') {
                document.getElementById('pwMsg1_1').style = "display:none";
                document.getElementById('pwMsg2_1').style = "display:none";
                document.getElementById('pwMsg1_2').style = "display:none";
                registerBtnAbled();
            }
            
            if(pw1!='' && pw1!=pw2){
                document.getElementById('pwMsg1_2').style = "display:inline-block";
                registerBtnAbled();
            } 
        }
    }   

    //정규식 통과 전
    if(pw1=='' && pw2=='') {
        document.getElementById('pwMsg1_1').style = "display:none";
        document.getElementById('pwMsg2_1').style = "display:none";
        document.getElementById('pwMsg1_2').style = "display:none";
        registerBtnAbled();
    }

})

document.getElementById('pw2').addEventListener('input',()=>{
    let pw1 = document.getElementById('pw1').value;
    let pw2 = document.getElementById('pw2').value;

    //비밀번호 입력 체크
    if(pw1!=='' && pw2=='') {
        document.getElementById('pwMsg2_2').style = "display:inline-block";
        registerBtnAbled();
     } else if(pw1=='' && pw2=='') {
        document.getElementById('pwMsg1_1').style = "display:none";
        document.getElementById('pwMsg2_1').style = "display:none";
        document.getElementById('pwMsg1_2').style = "display:none";
        registerBtnAbled();
     } else {
  
        //비밀번호 일치 체크
        if(pw1!=pw2){
            document.getElementById('pwMsg1_2').style = "display:inline-block";
            registerBtnAbled();
        } else {
            document.getElementById('pwMsg1_2').style = "display:none";
            registerBtnAbled();
        }
     }

     if(pw1!=='' && pw2=='') {
        document.getElementById('pwMsg1_2').style = "display:none";
        registerBtnAbled();
     }

     if(pw1=='' && pw2!=='') {
        document.getElementById('pwMsg2_1').style = "display:inline-block";
        registerBtnAbled();
     }
})

//닉네임 중복 체크
document.getElementById('nick').addEventListener('change', async ()=>{
    let nick = document.getElementById('nick').value;
    console.log(nick);
    
    const result = await hasNick(nick);
    if(result == 1){
        document.getElementById('nickMsg').style = "display:inline-block";
    }else{
        document.getElementById('nickMsg').style = "display:none";
        registerBtnAbled();
    }
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
    const pwMsg1_1 = document.getElementById('pwMsg1_1');
    const pwMsg2_1 = document.getElementById('pwMsg2_1');
    const pwMsg1_2 = document.getElementById('pwMsg1_2');
    // const pwMsg2_2 = document.getElementById('pwMsg2_2');
    const nickMsg = document.getElementById('nickMsg');
    const addrValue = document.getElementById('addr').value;
    const nickValue = document.getElementById('nick').value;

    const pwMsg1_1Display = window.getComputedStyle(pwMsg1_1).getPropertyValue('display');
    const pwMsg2_1Display = window.getComputedStyle(pwMsg2_1).getPropertyValue('display');
    const pwMsg1_2Display = window.getComputedStyle(pwMsg1_2).getPropertyValue('display');
    // const pwMsg2_2Display = window.getComputedStyle(pwMsg2_2).getPropertyValue('display');
    const nickMsgDisplay = window.getComputedStyle(nickMsg).getPropertyValue('display');

    // && pwMsg2_2Display === 'none'
    if(pwMsg1_1Display === 'none' && pwMsg2_1Display === 'none'&& pwMsg1_2Display === 'none' && nickMsgDisplay ==='none'
        && addrValue !== '' && nickValue !== ''){
       document.getElementById('regiBtn').disabled = false;
   } else {
       document.getElementById('regiBtn').disabled = true;
   }
}

//탈퇴 버튼
async function deleteMemBtn(email){
    try{
        const url = '/hmember/deleteMember/'+email;
        const config ={
            method: 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        console.log(result);

        if (result === '1') {
            console.log("success");
            window.location.replace('http://localhost:8088/');
        }
    }catch(err){
        console.log(err);
    }
}

document.getElementById('deleteMemBtn').addEventListener('click', async (e) => {
    Swal.fire({
        text: "탈퇴가 성공적으로 처리되었습니다.",
        icon: "success",
        showConfirmButton: false,
        width: 400,
        timer: 2000
    }).then((result) => {
        if (result.dismiss === Swal.DismissReason.timer) {
            deleteMemBtn(email);
        }
    });    
});

//수정 버튼
document.getElementById('regiBtn').addEventListener('click', function() {
    if (!document.getElementById('regiBtn').hasAttribute('disabled')) {
        Swal.fire({
            text: "수정이 완료되었습니다!",
            icon: "success",
            showConfirmButton: false,
            width: 400,
            timer: 2000,
            willClose: function () {
                //알람이 닫히기 전에 폼 제출
                document.getElementById('modForm').submit();
            }
        });
        event.preventDefault();
    }
});
