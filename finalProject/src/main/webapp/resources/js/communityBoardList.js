document.addEventListener('click',(e)=>{
        // 메뉴 클릭시
        if (e.target.classList.contains("menu")) {
            // 모든 메뉴 버튼에서 'choiceMenu' 클래스를 제거
            document.querySelectorAll('.menu').forEach(menu => {
                menu.classList.remove('choiceMenu');
            });
    
            // 클릭된 메뉴 버튼에 'choiceMenu' 클래스 추가
            e.target.classList.add('choiceMenu');
    
            // 나머지 코드는 그대로 유지
            myMenu = e.target.textContent;
            getMoreBoard(1, myMenu);
        }
    //더보기 버튼 클릭시
    if(e.target.id == 'moreBtn'){
        getMoreBoard(parseInt(e.target.dataset.page), myMenu);
    }

})

//서버에 board 데이터 요청
async function getMoreBoardForServer(page, menu){
    try {
        const resp = await fetch('/community/page/'+page+'/'+menu);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//특정 게시글 thumbnail 가져오는 함수
async function getThumbnailToServer(bno){
    try {
        const resp = await fetch('/community/thumb/'+bno);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//서버에 요청한 데이터로 board 출력
async function getMoreBoard(page = 1, menu) {
    try {
        const result = await getMoreBoardForServer(page, menu);
        console.log(result);

        if (result.cmList.length > 0) {
            let cmBoard = document.getElementById('cmBoard');

            if (page == 1) {
                cmBoard.innerHTML = "";
            }

            for (let bvo of result.cmList) {
                let upDate = bvo.cmRegAt.substring(0,10);

                let str = `<div class="oneBoard">`;
                str += `<p class="boardMenuName">${bvo.cmMenu }</p>`;
                str += `<div class="user_profile">
                            <img id="cmListProfile-${bvo.cmBno}" class="cmUserProfile" alt="" src="/resources/image/기본 프로필.png">
                            <b class="cmListNick">${bvo.cmNickName}</b>
                            <p class="cmListDate">${upDate }</p>
                            <p class="cmListEmd"><i class="bi bi-geo-alt-fill cmWriterLocationIcon"></i>${bvo.cmEmd }</p>
                            </div>`;

                str += `<div class="communityContentLine"><a class="contentAtag" href="/community/detail?cmBno=${bvo.cmBno }">`;
                str += `<p>${bvo.cmTitle }</p>`;
                if (bvo.cmFileCnt > 0) {
                    let thumb = await getThumbnailToServer(bvo.cmBno);
                    str += `<img class="thumbImg" src="/upload/community/${thumb.saveDir.replaceAll('\\','/')}/${thumb.uuid}_${thumb.fileName}"  alt="...">`;
                }
                str += `</a></div>`;

                str += `<div class="item-info">
                            <div>
                                <i class="bi bi-eye"></i>
                                <span>${bvo.cmReadCnt } </span>
                                <i class="bi bi-heart"></i>
                                <span>${bvo.cmLikeCnt } </span>
                            </div>
                            <div>
                                <i class="bi bi-chat-right-dots"></i>
                                <span class="readCount">${bvo.cmCmtCnt }</span>
                            </div>
                        </div>`;
                str += `</div>`;
	            communityProfile(bvo.cmEmail, `cmListProfile-${bvo.cmBno}`);
                cmBoard.innerHTML += str;
            }
        } else {
            let str = `<div class="noBoard">게시글이 존재하지 않습니다.</div>`;
            cmBoard.innerHTML = str;
        }

        let moreBtn = document.getElementById('moreBtn');

        if (result.pgvo.pageNo < result.endPage) {
            moreBtn.style = 'display:inline-block';
            moreBtn.dataset.page = page + 1;
        } else {
            moreBtn.style = 'display:none';
        }
    } catch (error) {
        console.error(error);
    }
}

//로딩페이지
window.onload = function() {
    setTimeout(()=> document.getElementById('loading').style.display = 'none', 500);
};

//현재 fullPath
let fullPath = window.location.href;
console.log(fullPath);
//div의 a 요소 가져오기
let aList = document.querySelectorAll('.CommunityCategory a');
console.log(aList);

for(let a of aList){
    // 이전 active 클래스 삭제
    if(fullPath != "http://localhost:8088//community/list"){
        a.classList.remove('cmActive');
    }

    //현재 링크와 a태그의 링크가 동일하면 active 클래스 적용
    if(a.href == fullPath){
        a.classList.add('cmActive');
    }
}