//전화번호 정규표현식 체크
let regExp = /^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/;
document.getElementById('phoneNum').addEventListener('input', ()=>{
    let phoneNum = document.getElementById('phoneNum').value;
    if(!regExp.test(phoneNum)){
        document.getElementById('findBtn').disabled = true;
    }else{
        document.getElementById('findBtn').disabled = false;
    }
})

//이메일 찾기 메서드
document.getElementById('findBtn').addEventListener('click',()=>{
    let phoneNum = document.getElementById('phoneNum').value;
    console.log(">>> phone >> "+phoneNum);

    getEmailFromServer(phoneNum).then(result => {
        console.log(">> 결과 >> "+result);
        let id = result.memEmail.slice(0, result.memEmail.indexOf("@")-1);
        console.log("id > "+id);
        let newId = id.slice(0,1).padEnd(id.length, "*");
        console.log("newId > "+newId);
        let mailAddr = result.memEmail.slice(result.memEmail.indexOf("@")-1);
        console.log("mailAddr > "+mailAddr);
        let newEmail = newId+mailAddr;
        console.log("newEmai l> "+newEmail);

        if(result !== undefined){ //가입된 번호면
            document.getElementById('inner1').classList.add("off");
            document.getElementById('inner2').classList.remove("off");
            document.getElementById('findedEmail').innerHTML = newEmail;

        }else{ //가입 안된 번호면
            swal.fire("", "일치하는 사용자 정보를 찾을 수 없습니다.", "error");
        }
    })

})

//전화번호를 주고 이메일을 달라고 요청
async function getEmailFromServer(phone){ 
    try{
        const resp = await fetch('/member/findEmail/'+phone);
        const result = await resp.json(); 
        return result; 
        
    }catch(err){
        console.log(err);
    }
}