// 더보기 버튼을 눌렀는지 판단
document.addEventListener('click',(e)=>{
    switch(e.target.id){
        case 'moreJoongoBtn':
            getMoreSearchJoongoResult(parseInt(e.target.dataset.page));
            break;
        case 'moreStoreBtn':
            getMoreSearchStoreResult(parseInt(e.target.dataset.page));
            break;
        case 'moreJobBtn':
            getMoreSearchJobResult(parseInt(e.target.dataset.page));
            break;
        case 'moreCommunityBtn':
            getMoreSearchCommunityResult(parseInt(e.target.dataset.page));
            break;
        default:
            break;
    }
})

// 서버에 joongo 검색결과 데이터 요청
async function getMoreSearchJoongoResultForServer(page){
    try {
        const resp = await fetch('/common/joongo/'+page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log("getMoreSearchJoongoResultForServer >>>> "+error);
    }
}
// 서버에 store 검색결과 데이터 요청
async function getMoreSearchStoreResultForServer(page){
    try {
        const resp = await fetch('/common/store/'+page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}
// 서버에 job 검색결과 데이터 요청
async function getMoreSearchJobResultForServer(page){
    try {
        const resp = await fetch('/common/job/'+page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}
// 서버에 community 검색결과 데이터 요청
async function getMoreSearchCommunityResultForServer(page){
    try {
        const resp = await fetch('/common/community/'+page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

let checkJoongoFirstResult = false;
let checkStoreFirstResult = false;
let checkJobFirstResult = false;
let checkCommunityFirstResult = false;
// 서버에 요청한 joongo 데이터로 검색결과 출력
function getMoreSearchJoongoResult(page = 1) {
    getMoreSearchJoongoResultForServer(page).then(result => {
        console.log(result);
        let boardListArea = document.querySelector('#joongo .boardListArea');
        let div = document.getElementById('joongo');
        if(!checkJoongoFirstResult){
            div.firstElementChild.innerText += ' 검색결과 '+result.totalCount+'개';
            checkJoongoFirstResult = true;
        }

        if (result.prodList.length > 0) {

            if (page == 1) {
                boardListArea.innerHTML = '';
            }

            for (let prod of result.prodList) {
                let price = prod.proPrice.toLocaleString('ko-KR');
                let upDate = prod.proReAt.substring(0,10);
                let li = `<div class="oneList"><a href="/joongo/detail?proBno=${prod.proBno}">`;

                li += `<div class="itemInfo"><h5>${prod.proTitle}</h5><b>${price}원</b>`;
                li += `<p>${prod.proEmd}</p><small>${upDate }</small>`;
                li += `</div></a></div>`;
                boardListArea.innerHTML += li;
            }
            
        } else {
            let li = `<div class="empty"><p>검색 결과가 없습니다.</p>`;
            li += `<p>검색어가 올바르게 입력되었는지 확인해 주세요.</p></div>`;
            boardListArea.innerHTML = li;
        }

        let moreBtn = document.getElementById('moreJoongoBtn');

        if (result.pgvo.pageNo < result.endPage) {
            moreBtn.style.display = 'block';
            moreBtn.dataset.page = page + 1;
        } else {
            moreBtn.style.display = 'none';
        }
    
    })
}

// 서버에 요청한 store 데이터로 검색결과 출력
function getMoreSearchStoreResult(page = 1) {
    getMoreSearchStoreResultForServer(page).then(result => {
        console.log(result);
        let boardListArea = document.querySelector('#store .boardListArea');
        let div = document.getElementById('store');
        if(!checkStoreFirstResult){
            div.firstElementChild.innerText += ' 검색결과 '+result.totalCount+'개';
            checkStoreFirstResult = false;
        }

        if (result.prodList.length > 0) {

            if (page == 1) {
                boardListArea.innerHTML = '';
            }

            for (let prod of result.prodList) {
                let li = `<div class="oneList"><a href="/store/detail?bno=${prod.proBno}">`;
                li += `<div class="itemInfo">`;
                li += `<h5>${prod.proTitle}</h5>`;
                li += `<p>${prod.proEmd}</p>`;
                li += `<span>${prod.proContent}</span>`;
                li += `<p>${prod.proMenu}</p>`
                li += `</div></a></div>`;
                boardListArea.innerHTML += li;
            }
            
        } else {
            let li = `<div class="empty"><p>검색 결과가 없습니다.</p>`;
            li += `<p>검색어가 올바르게 입력되었는지 확인해 주세요.</p></div>`;
            boardListArea.innerHTML = li;
        }

        let moreBtn = document.getElementById('moreStoreBtn');

        if (result.pgvo.pageNo < result.endPage) {
            moreBtn.style.display = 'block';
            moreBtn.dataset.page = page + 1;
        } else {
            moreBtn.style.display = 'none';
        }
    
    })
}

// 서버에 요청한 job 데이터로 검색결과 출력
function getMoreSearchJobResult(page = 1) {
    getMoreSearchJobResultForServer(page).then(result => {
        console.log(result);
        let boardListArea = document.querySelector('#job .boardListArea');
        let div = document.getElementById('job');
        if(!checkJobFirstResult){
            div.firstElementChild.innerText += ' 검색결과 '+result.totalCount+'개';
            checkJobFirstResult = false;
        }

        if (result.prodList.length > 0) {

            if (page == 1) {
                boardListArea.innerHTML = '';
            }

            for (let prod of result.prodList) {
                let price = prod.proPrice.toLocaleString('ko-KR');
                let li = `<div class="oneList"><a href="/job/detail?proBno=${prod.proBno}">`;
                li += `<div class="itemInfo">`;
                li += `<h5>${prod.proTitle}</h5>`;
                li += `<p>${prod.proEmd}</p>`;
                li += `<p>${prod.proMenu}<strong>${price}</strong></p>`;
                li += `</div></a></div>`;
                boardListArea.innerHTML += li;
            }
            
        } else {
            let li = `<div class="empty"><p>검색 결과가 없습니다.</p>`;
            li += `<p>검색어가 올바르게 입력되었는지 확인해 주세요.</p></div>`;
            boardListArea.innerHTML = li;
        }

        let moreBtn = document.getElementById('moreJobBtn');

        if (result.pgvo.pageNo < result.endPage) {
            moreBtn.style.display = 'block';
            moreBtn.dataset.page = page + 1;
        } else {
            moreBtn.style.display = 'none';
        }
    
    })
}

// 서버에 요청한 Community 데이터로 검색결과 출력
function getMoreSearchCommunityResult(page = 1) {
    getMoreSearchCommunityResultForServer(page).then(result => {
        console.log(result);
        let boardListArea = document.querySelector('#community .boardListArea');
        let div = document.getElementById('community');
        if(!checkCommunityFirstResult){
            div.firstElementChild.innerText += ' 검색결과 '+result.totalCount+'개';
            checkCommunityFirstResult = false;
        }

        if (result.cmList.length > 0) {

            if (page == 1) {
                boardListArea.innerHTML = '';
            }

            for (let commu of result.cmList) {
                let upDate = commu.cmRegAt.substring(0,10);
                let li = `<div class="oneList"><a href="/community/detail?cmBno=${commu.cmBno}">`;

                li += `<div class="itemInfo"><h5>${commu.cmTitle}</h5>`;
                li += `<p>${commu.cmEmd}</p><small>${upDate}</small>`;
                li += `</div></a></div>`;
                boardListArea.innerHTML += li;
            }
            
        } else {
            let li = `<div class="empty"><p>검색 결과가 없습니다.</p>`;
            li += `<p>검색어가 올바르게 입력되었는지 확인해 주세요.</p></div>`;
            boardListArea.innerHTML = li;
        }

        let moreBtn = document.getElementById('moreCommunityBtn');

        if (result.pgvo.pageNo < result.endPage) {
            moreBtn.style.display = 'block';
            moreBtn.dataset.page = page + 1;
        } else {
            moreBtn.style.display = 'none';
        }
    
    })
}

// 출력 선언
getMoreSearchJoongoResult();
getMoreSearchStoreResult();
getMoreSearchJobResult();
getMoreSearchCommunityResult();

