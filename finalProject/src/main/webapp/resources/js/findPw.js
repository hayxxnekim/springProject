//이메일 정규표현식
let emailVal = /^(?:[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$/;
document.getElementById('emailAddr').addEventListener('input', ()=>{
    let emailAddr = document.getElementById('emailAddr').value;
    if(!emailVal.test(emailAddr)){
        document.getElementById('pwFindBtn').disabled = true;
    }else{
        document.getElementById('pwFindBtn').disabled = false;
    }
})

//임시 비밀번호 전송 메서드
document.getElementById('pwFindBtn').addEventListener('click',()=>{
    let emailAddr = document.getElementById('emailAddr').value;
    console.log(">>> emailAddr >> "+emailAddr);

    getPwFromServer(emailAddr).then(result =>{
        if(result > 0){ //전송 성공시
            document.getElementById('inner1').classList.add("off");
            document.getElementById('inner2').classList.remove("off");

        }else{ //전송 실패시
            //alert('일치하는 사용자 정보를 찾을 수 없습니다.');
            swal.fire("", "일치하는 사용자 정보를 찾을 수 없습니다.", "error");
        }
    })
})

//이메일 주소로 임시 비밀번호를 보내달라고 요청
async function getPwFromServer(email){
    try{
        const resp = await fetch('/member/findPw/'+email);
        const result = await resp.text(); 
        return result; 
        
    }catch(err){
        console.log(err);
    }
}