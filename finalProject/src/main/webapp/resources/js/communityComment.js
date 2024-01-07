//댓글 등록 버튼 클릭시
document.getElementById("cmtPostBtn").addEventListener('click', ()=>{
    const cmtText = document.getElementById('cmtText').value;
    const cmtWriter = document.getElementById('cmtWriter').innerText; 
    const cmtEmail = document.getElementById('cmtEmail').value;

    if(cmtText == "" || cmtText == null){ //댓글을 안 적었을 때
        document.getElementById('cmtPostBtn').disabled = true;  
        document.getElementById('cmtText').focus();
        return false; //메서드 종료
    }else{
        let cmtData = {
            cmtBno : bnoVal, //jsp에서 보내준 값
            cmtEmail : cmtEmail,
            cmtNickName : cmtWriter,
            cmtContent : cmtText
        };
        console.log(cmtData);
        
        //전송 function
        postCommentToServer(cmtData).then(result => {
            if(result == 1){
                //alert("댓글 등록 성공");
                //댓글 등록 후 인풋 빈값으로 만들어주기
                document.getElementById('cmtText').value = '';
            }

            //화면에 뿌리기
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
        const url ="/communityCmt/post"; 
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
async function getCommentListFromServer(bno){ //페이징을 위해 나중에 page 추가
    try{
        const resp = await fetch('/communityCmt/'+bno);
        const result = await resp.json(); 
        return result; 
        
    }catch(err){
        console.log(err);
    }
}

// 특정 textarea의 줄 수를 조정하는 함수
function textAreaRows(textarea) {
    // 글 내용에서 줄바꿈 수를 세어 변수 저장
    let lineCount = (textarea.value.match(/\n/g) || []).length + 1;
	
	textarea.rows = lineCount;
}

let cmtText = document.getElementById('cmtText');
// 글을 입력할 때마다 adjustTextareaRows 함수 호출
cmtText.addEventListener('input',()=>{
    textAreaRows(cmtText);
})

//화면에 뿌리기
function spreadCommentList(bno){
    getCommentListFromServer(bno).then(result => {
        console.log(result); //ph객체 : pgvo, totalCount, cmtList
        const ul = document.getElementById('cmtListArea'); //댓글 영역을 감싸는 ul
        if(result.length > 0){ //댓글이 있다면
            //다시 댓글을 뿌릴 때 기존 값 삭제 1page일 경우만
            
                ul.innerHTML = ""; //jsp에 임시로 넣어둔 댓글 표시영역을 지우고, 비어있는 값으로 바꿔버리기
            
            for(let cvo of result){
                console.log(cvo.cmtIsDel);
                //부모댓글
                if(cvo.cmtIsDel == 'Y'){
                    if(cvo.cmtAnswerCnt > 0){
                        let str = `<li class="cmtLi" data-cmtcno="${cvo.cmtCno}">삭제된 댓글입니다.</li>`;
                        str += `<ul class="repliesUl" id="replies-${cvo.cmtCno}">`; // 자식 댓글을 위한 ul 요소 추가
                        ul.innerHTML += str;
                    }  
                }else{
                    let str = `<li class="cmtLi" data-cmtcno="${cvo.cmtCno}">`;
                    str += `<div class="cmtContainer">`; 
    
                    str += `<div class="cmtUserLine">
                            <div><img id="cmtProfile-${cvo.cmtCno}" class="cmUserProfile" alt="" src="/resources/image/기본 프로필.png"> <p class="cmtNickName">${cvo.cmtNickName}</p> `;
                            communityProfile(cvo.cmtEmail, `cmtProfile-${cvo.cmtCno}`);
                    if(cvo.cmtEmail == boardWriterEmail){
                        str += `<span class="boardWriterSpan">작성자</span>`; 
                    } 
                    str += `<span class="cmtDate"> ${cvo.cmtModAt}</span></div>`;
                    //수정, 삭제 버튼
                    if(cvo.cmtEmail == userEmail){ 
                        str += `<div class="userDropdownMenu">
                        <button class="boardUserBtn cmtUserBtn" type="button">
                            <i class="bi bi-three-dots cmtUserBtn"></i>
                        </button>
                        <ul class="cmtUserMenu menu-off" style="display:none">
                            <a class="modBtn" href="#" data-cmtcontent="${cvo.cmtContent}" data-bs-toggle="modal" data-bs-target="#myModal">수정하기</a>
                            <a class="delBtn" href="#">삭제하기</a>
                        </ul>
                        </div>`
                    }
                    str += `</div>`;
                    
                    str += `<textarea class="cmtContentLine" spellcheck="false">${cvo.cmtContent}</textarea>`;

                    if(userEmail){
                        str += `<div class="cmtReBtnLine"><button class="reCmtBtn no-${cvo.cmtCno}" data-cmtnickname="${cvo.cmtNickName}">답글쓰기</button></div>`;
                    }
                    
                    str += `</div></li></ul>`;

                    if(cvo.cmtAnswerCnt > 0){
                        str += `<ul class="repliesUl" id="replies-${cvo.cmtCno}">`; // 자식 댓글을 위한 ul 요소 추가
                    }
                    
                    ul.innerHTML += str;
                    
                }
                
                //자식댓글
                hasReply(cvo.cmtCno).then(result =>{
                    if(result.length > 0){
                        for(let cvo of result){ 
                            let reUl = document.getElementById(`replies-${cvo.reCmtCno}`);

                            let str = `<li class="cmtLi2" data-recno=${cvo.reCno}>`;
                            str += `<div class="cmtContainer">`; 

                            str += `<div class="cmtUserLine">
                                    <div><img id="reCmtProfile-${cvo.reCno}" class="cmUserProfile" alt="" src="/resources/image/기본 프로필.png"> <p class="cmtNickName">${cvo.reNickName}</p> `;
                                    communityProfile(cvo.reEmail, `reCmtProfile-${cvo.reCno}`);
                            if(cvo.reEmail == boardWriterEmail){
                                str += `<span class="boardWriterSpan">작성자</span>`; 
                            } 
                            str += `<span class="cmtDate"> ${cvo.reModAt}</span></div>`;
                            //수정, 삭제 버튼
                            if(cvo.reEmail == userEmail){
                                str += `<div class="userDropdownMenu">
                                <button class="boardUserBtn cmtUserBtn" type="button">
                                    <i class="bi bi-three-dots cmtUserBtn"></i>
                                </button>
                                <ul class="cmtUserMenu menu-off" style="display:none">
                                    <a class="reModBtn" href="#" data-recontent="${cvo.reContent}" data-bs-toggle="modal" data-bs-target="#myModal">수정하기</a>
                                    <a class="reDelBtn" href="#" data-recmtcno="${cvo.reCmtCno}">삭제하기</a>
                                </ul>
                                </div>`
                            }
                            str += `</div>`;
                            
                            str += `<textarea class="cmtContentLine" spellcheck="false">${cvo.reContent}</textarea>`;
                            
                            str += `</div></li></ul>`;
                            
                            reUl.innerHTML += str;
                        }
                    }
                })

            }
            
        }else{
            let str = `<li class="noComment">첫 댓글을 남겨주세요</li>`;
            ul.innerHTML = str;
        }
        
        // 마지막 댓글에 클래스 추가
        const lastComment = ul.lastElementChild;
        lastComment.classList.add('last-comment');
        
        // 모든 'answerArea' 클래스를 가진 textarea 요소 찾기
        let textareas = document.querySelectorAll('.cmtContentLine');

        // 각 textarea에 대해 adjustTextareaRows 함수 호출
        textareas.forEach(function(textarea) {
            textAreaRows(textarea);
        });
        
    })
}

//수정
async function editCommentToServer(cmtModData){
    try{
        const url = '/communityCmt/'+cmtModData.cmtCno;
        const config = {
            method : 'put',
            headers : {
                'content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtModData)
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
        
    }catch(err){
        console.log(err);
    }
}

//삭제
async function removeCommentToServer(cno){
    try{
        const url = '/communityCmt/'+cno;
        const config = {
            method : 'delete',
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

document.addEventListener('click', (e)=>{
    console.log(e.target);
    //수정버튼 클릭시
    if(e.target.classList.contains('modBtn')){
        console.log('수정버튼 클릭!');
        let li = e.target.closest('li');
        //nextSibling() : 같은 부모의 다음 형제 객체를 반환 => ${cvo.content}
        //let cmtText = li.querySelector('.fw-bold').nextSibling;
        let cmtText = e.target.dataset.cmtcontent;
        console.log(">>> cmtText >> "+cmtText);
        //기존 내용 모달창에 반영
        document.getElementById('cmtTextMod').value = cmtText; 
        //value는 input태그에만 사용
        //nodeValue = innerText(div로 쌓여있을 때)
        //cmtModBtn에 data-cno 달기 
        console.log(li.dataset.cmtcno);
        document.getElementById('cmtModBtn').setAttribute('data-cmtcno', li.dataset.cmtcno);
        //dataset 대문자 인식X 소문자로만 cmtcno
    //모달창의 수정버튼 클릭시
    }else if(e.target.id == 'cmtModBtn'){
        let cmtModData = {
            cmtCno : e.target.dataset.cmtcno,
            cmtContent : document.getElementById('cmtTextMod').value
        };
        console.log(cmtModData);

        editCommentToServer(cmtModData).then(result => {
            if(result == 1){
                document.querySelector('.btn-close').click();
                //alert("댓글 수정 성공");
            spreadCommentList(bnoVal);
            }
        })

    //삭제버튼 클릭시
    }else if(e.target.classList.contains('delBtn')){
        console.log('삭제버튼 클릭!');
        let li = e.target.closest('li');
        let cnoVal = li.dataset.cmtcno;

        removeCommentToServer(cnoVal).then(result => {
            if(result == 1){
                //alert("댓글 삭제 성공");
            spreadCommentList(bnoVal);
            }
        })

    }
})

//-------------------------------------------------------------
//대댓글!

//서버에 cno를 주고 대댓글 리스트 받아오기
async function hasReply(cno){ 
    try{
        const resp = await fetch('/reCmt/'+cno);
        const result = await resp.json(); 
        return result; 
        
    }catch(err){
        console.log(err);
    }
}

document.addEventListener('click', (e)=>{
    //답글쓰기 눌렀을 때
    if(e.target.classList.contains('reCmtBtn')){
        let li = e.target.closest('li');
        let cmtCno = li.dataset.cmtcno;
        let button = li.querySelector('.reCmtBtn');
        button.remove();
    
        let str = `<div class="reCommentWrite">`;
        str += `<input type="hidden" id="writerEmail" value="${userEmail}">
                <input type="hidden" id="cmtCno" value=${cmtCno}>
                <span class="cmtWriter" id="reWriter">${userNick}</span>
                <textarea rows="1" class="cmtText reText" id="reText" placeholder="댓글을 남겨주세요"></textarea>
                <button type="button" id="rePostBtn" class="cmtPostBtn rePostBtn" disabled="disabled">등록</button>
                <button type="button" id="cancelBtn" class="cmtCancelBtn cancelBtn">취소</button></div>`; 
        
        li.innerHTML += str;

        //답글작성버튼 disabled
        let reCmtField = document.getElementById('reText');
        reCmtField.addEventListener('input', reBtnDisabled);
        
        function reBtnDisabled(){
            const reText = document.getElementById('reText').value;
            const rePostBtn = document.getElementById('rePostBtn');
        
            if(reText == "" || reText == null){
                rePostBtn.disabled = true;
            }else{
                rePostBtn.disabled = false;  
            }
        }

        //취소 버튼 눌렀을 때
        let cancelBtn = li.querySelector('.cancelBtn');
        cancelBtn.addEventListener('click', ()=> {
            // 입력 폼을 제거
            li.querySelector('.reCommentWrite').remove();

            // 답글 쓰기 버튼을 다시 보이게 함
            li.appendChild(button);
        });

    }

    let reText = document.getElementById('reText');
    // 글을 입력할 때마다 adjustTextareaRows 함수 호출
    reText.addEventListener('input',()=>{
        textAreaRows(reText);
    })
    
    //대댓글 등록 버튼 눌렀을 때
    if(e.target.classList.contains('rePostBtn')){
        const cmtCno = document.getElementById('cmtCno').value;
        const writerEmail = document.getElementById('writerEmail').value;
        const reWriter = document.getElementById('reWriter').innerText;
        const reText = document.getElementById('reText').value;

        if(reText == "" || reText == null){ //댓글을 안 적었을 때
            alert("댓글을 입력해주세요.");
            document.getElementById('reText').focus();
            return false; //메서드 종료
        }else{
            let reData = {
                reCmtCno : cmtCno, 
                reBno : bnoVal,
                reEmail : writerEmail,
                reNickName : reWriter,
                reContent : reText
            };
            console.log(reData);

            //전송 function
            postReplyToServer(reData).then(result => {
                if(result == 1){
                    // alert("대댓글 등록 성공");
                spreadCommentList(bnoVal);
                }

                //화면에 뿌리기
            })
        }
    }
    
})

//대댓글 전송 메서드
async function postReplyToServer(reData){
    try{
        const url ="/reCmt/post"; 
        const config = { 
            method : "post",
            headers : { 
                'Content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(reData) 
        };

        const resp = await fetch(url, config);
        const result = await resp.text(); 
        return result;

    }catch(err){
        console.log(err);
    }
}

//대댓글 수정
async function reEditToServer(reModData){
    try{
        const url = '/reCmt/'+reModData.reCno;
        const config = {
            method : 'put',
            headers : {
                'content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(reModData)
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
        
    }catch(err){
        console.log(err);
    }
}

//대댓글 삭제
async function reRemoveToServer(cno, cmtCno){
    try{
        const url = '/reCmt/'+cno+'/'+cmtCno;
        const config = {
            method : 'delete',
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

document.addEventListener('click', (e)=>{
    //수정버튼 클릭시
    if(e.target.classList.contains('reModBtn')){
        console.log('수정버튼 클릭!');
        let li = e.target.closest('li');
        //nextSibling() : 같은 부모의 다음 형제 객체를 반환 => ${cvo.content}
        //let cmtText = li.querySelector('.fw-bold').nextSibling;
        let cmtText = e.target.dataset.recontent;
        console.log(cmtText);
        //기존 내용 모달창에 반영
        document.getElementById('cmtTextMod').value = cmtText; 
        //value는 input태그에만 사용
        //nodeValue = innerText(div로 쌓여있을 때)
        //cmtModBtn에 data-cno 달기 
        console.log(li.dataset.cmtcno);
        document.getElementById('cmtModBtn').setAttribute('data-recno', li.dataset.recno);
        //dataset 대문자 인식X 소문자로만 cmtcno
    //모달창의 수정버튼 클릭시
    }else if(e.target.id == 'cmtModBtn'){
        let reModData = {
            reCno : e.target.dataset.recno,
            reContent : document.getElementById('cmtTextMod').value
        };
        console.log(reModData);

        reEditToServer(reModData).then(result => {
            if(result == 1){
                document.querySelector('.btn-close').click();
                //alert("대댓글 수정 성공");
            spreadCommentList(bnoVal);
            }
        })

    //삭제버튼 클릭시
    }else if(e.target.classList.contains('reDelBtn')){
        console.log('삭제버튼 클릭!');
        let li = e.target.closest('li');
        let cnoVal = li.dataset.recno;
        let cmtCnoVal = e.target.dataset.recmtcno;
        console.log("cmtcno >> "+cmtCnoVal);

        reRemoveToServer(cnoVal, cmtCnoVal).then(result => {
            if(result == 1){
                //alert("대댓글 삭제 성공");
            spreadCommentList(bnoVal);
            }
        })
    }
})


document.addEventListener('click', (e) => {
    // 게시글 삭제, 수정 버튼 보이게 하기
    if (e.target.id === 'boardUserMenuBtn') {
        let userMenu = document.getElementById('boardUserMenu');
        userMenu.classList.toggle('menu-on', !userMenu.classList.contains('menu-on'));
        userMenu.style.display = userMenu.classList.contains('menu-on') ? 'inline-block' : 'none';

    }else if (e.target.id === 'boardUserMenuBtn2') {
        let userMenu = document.getElementById('boardUserMenu');
        userMenu.classList.toggle('menu-on', !userMenu.classList.contains('menu-on'));
        userMenu.style.display = userMenu.classList.contains('menu-on') ? 'inline-block' : 'none';

    // 댓글 수정, 삭제 버튼 보이게 하기
    }else if (e.target.classList.contains('cmtUserBtn')) {
        const userMenu = e.target.closest('.cmtContainer').querySelector('.cmtUserMenu');
        userMenu.classList.toggle('menu-on', !userMenu.classList.contains('menu-on'));
        userMenu.style.display = userMenu.classList.contains('menu-on') ? 'inline-block' : 'none';
    
    // 화면의 다른 부분을 클릭했을 때 메뉴 숨기기
    }else {
        const boardUserMenu = document.getElementById('boardUserMenu');
        if (boardUserMenu && boardUserMenu.classList.contains('menu-on')) {
            boardUserMenu.classList.replace('menu-on', 'menu-off');
            boardUserMenu.style.display = 'none';
        }

        document.querySelectorAll('.cmtUserMenu').forEach(menu => {
            if (menu.classList.contains('menu-on')) {
                menu.classList.replace('menu-on', 'menu-off');
                menu.style.display = 'none';
            }
        });
    }
});