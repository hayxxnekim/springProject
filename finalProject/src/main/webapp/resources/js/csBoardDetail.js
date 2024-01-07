//댓글 등록 버튼 클릭시
document.getElementById("cmtPostBtn").addEventListener('click', ()=>{
    const cmtText = document.getElementById('cmtText').value;
    const cmtEmail = document.getElementById('cmtEmail').value;

    if(cmtText == "" || cmtText == null){ //댓글을 안 적었을 때
        alert("댓글을 입력해주세요.");
        document.getElementById('cmtText').focus();
        return false; //메서드 종료
    }else{
        let cmtData = {
            cmtBno : bnoVal, //jsp에서 보내준 값
            cmtEmail : cmtEmail,
            cmtContent : cmtText
        };
        console.log(cmtData);
        
        //전송 function
        postCommentToServer(cmtData).then(result => {
            if(result == 1){
                window.location.reload();
            }

            spreadCommentList(bnoVal);
        })
    }//if문
})

let cmtField = document.getElementById('cmtText');
cmtField.addEventListener('input', cmtBtnDisabled);

function cmtBtnDisabled(){
    const cmtText = document.getElementById('cmtText').value;
    const cmtPostBtn = document.getElementById('cmtPostBtn');

    if(cmtText == "" || cmtText == null){
        cmtPostBtn.disabled = true;
    }else{
        cmtPostBtn.disabled = false;  
    }
}

//댓글 전송 메서드
async function postCommentToServer(cmtData){
    try{
        const url ="/csCmt/post"; 
        const config = { 
            method : "post",
            headers : { 
                'Content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtData) 
        };

        const resp = await fetch(url, config);
        const result = await resp.text(); 
        return result;

    }catch(err){
        console.log(err);
    }
}

//서버에 댓글 리스트를 달라고 요청
async function getCommentListFromServer(bno){ 
    try{
        const resp = await fetch('/csCmt/'+bno);
        const result = await resp.json(); 
        return result; 
        
    }catch(err){
        console.log(err);
    }
}

//화면에 뿌리기
function spreadCommentList(bno){
    getCommentListFromServer(bno).then(result => {
        const div = document.getElementById('answerLine'); 

        if(result != null){ //답변이 있다면
            let str = `<p class="A">A. </p>`;
            str += `<div class="answerDiv">
	                    <textarea class="csTextAreas" readonly="readonly">${result.cmtContent}</textarea>
	                    <p class="ansReg">${result.cmtRegAt}</p>
                    </div>`;
            div.innerHTML = str;
            
        }else{ //답변이 없다면
            let str = `<p class="A">A. </p>`;
            str += `<div class="answerDiv">
            			<p class="noAnsText">답변 대기 상태입니다.</p>
            		</div>`;
            div.innerHTML = str;
        }

        // 모든 'answerArea' 클래스를 가진 textarea 요소 찾기
        let textareas = document.querySelectorAll('.csTextAreas');

        // 각 textarea에 대해 adjustTextareaRows 함수 호출
        textareas.forEach(function(textarea) {
            adjustTextareaRows(textarea);
        });
    })
}

// 특정 textarea의 줄 수를 조정하는 함수
function adjustTextareaRows(textarea) {
    // 글 내용에서 줄바꿈 수를 세어 변수 저장
    let lineCount = (textarea.value.match(/\n/g) || []).length + 1;

    if(lineCount < 5 && textarea.readOnly == false){
        textarea.rows = 5;
    }else{
        textarea.rows = lineCount;
    }
}

let ansTextArea = document.getElementById('cmtText');
// 글을 입력할 때마다 adjustTextareaRows 함수 호출
ansTextArea.addEventListener('input',()=>{
    adjustTextareaRows(ansTextArea);
})
