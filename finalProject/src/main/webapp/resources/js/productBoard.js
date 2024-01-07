// list 페이지 하단에 더보기 버튼 추가
// 더보기 버튼 id="moreBtn", data-page="1"

/*
Joongo list에서 추가하는 구조

<div class="oneList">
	<div class="card h-100">
		<img src="../resources/image/logoimage.png" class="card-img-top" alt="...">
		<div class="card-body">
		    <h5 class="card-title"><a href="/joongo/detail?proBno=${list.proBno}">${list.proTitle }</a></h5>
		    <p class="card-text">${list.proEmail }</p>
		</div>
		<div class="card-footer">
		    <small class="text-body-secondary">${list.proRegAt }</small>
		</div>
	</div>
</div>

<div class="oneList">
    <a href="/joongo/detail?proBno=${list.proBno}">
    <img src="../resources/image/logoimage.png" class="card-img-top" alt="...">
        <div class="itemInfo">
            <h5>${list.proTitle}</h5>
            <b>${price}</b>
            <p>${list.proEmd}</p>
            <small>${list.proRegAt }</small>
        </div>
    </a>
</div>
*/


// 페이지가 다 로드되면 로딩화면 삭제
window.onload = function() {
    setTimeout(()=> document.getElementById('loading').style.display = 'none', 500);
};

// 현재 페이지 링크 복사
function clip(){
	navigator.clipboard.writeText(window.location.href);
	alert('url이 복사되었습니다.');
}

// 현재 페이지 url을 가져와서 category 항목만 가져옵니다.
let url = window.location.pathname;
let category = url.substring(url.indexOf('/')+1,url.lastIndexOf('/'));
console.log(category);


// menu (세부 카테고리) 가져오기
let menu = document.getElementById('menu').value;
let sortedBy = document.getElementById('sortedBy').value;


// 셀렉트 버튼 눌렀을 때 검색
document.getElementById('menu').addEventListener('change',()=>{
    // 메뉴 설정
    menu = document.getElementById('menu').value;
    console.log(menu);

    // 로딩화면 제어
    document.getElementById('loading').style.display = 'block';
    getMoreBoard(category,1,menu,sortedBy);
    setTimeout(()=> document.getElementById('loading').style.display = 'none', 200);
})

document.getElementById('sortedBy').addEventListener('change',()=>{
    // 메뉴 설정
    sortedBy = document.getElementById('sortedBy').value;
    console.log(sortedBy);

    // 로딩화면 제어
    document.getElementById('loading').style.display = 'block';
    getMoreBoard(category,1,menu,sortedBy);
    setTimeout(()=> document.getElementById('loading').style.display = 'none', 200);
})



// 더보기 버튼을 눌렀는지 판단
document.addEventListener('click',(e)=>{
    console.log(e.target);
    if(e.target.id == 'moreBtn'){
        console.log('더보기 버튼');
        getMoreBoard(category, parseInt(e.target.dataset.page), menu, sortedBy);
    }
})

// 서버에 board 데이터 요청
async function getMoreBoardForServer(category, page, proMenu, proSort){
    try {
        const resp = await fetch('/'+category+'/page/'+page+'/'+proMenu+'/'+proSort);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 특정 게시글 thumbnail 가져오는 함수
async function getThumbnailToServer(category, bno){
    try {
        let config = {
            method : "post"
        }
        const resp = await fetch('/'+category+'/thumb/'+bno, config);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 서버에 요청한 데이터로 board 출력
async function getMoreBoard(category, page = 1, proMenu = menu, proSort = sortedBy) {
    try {
        const result = await getMoreBoardForServer(category, page, proMenu, proSort);
        console.log(result);

        if (result.prodList.length > 0) {
            document.querySelector('.boardMenuArea h3 b').innerText = result.totalCount;
            let boardArea = document.getElementById('boardArea');

            if (page == 1) {
                boardArea.innerHTML = "";
            }

            for (let prod of result.prodList) {
                let price = prod.proPrice.toLocaleString('ko-KR');
                let upDate = prod.proReAt.substring(0,10);
                let li = `<div class="oneList"><a href="/joongo/detail?proBno=${prod.proBno}">`;

                if (prod.proFileCnt > 0) {
                    let thumb = await getThumbnailToServer(category, prod.proBno);
                    li += `<img src="/upload/product/${thumb.saveDir.replaceAll('\\','/')}/${thumb.uuid}_${thumb.fileName}" alt="제품사진">`;
                } else {
                    li += `<img src="../resources/image/defaultImage.jpg" class="card-img-top" alt="사진 없을 때 띄우는 아보카도">`;
                }
                
                li += `<div class="itemInfo"><h5>${prod.proTitle}</h5><b>${price}원</b>`;
                li += `<p>${prod.proEmd}</p><small>${upDate }</small>`;
                li += `</div></a></div>`;
                boardArea.innerHTML += li;
            }
            
        } else {
            let li = `<div>Empty</div>`;
            boardArea.innerHTML = li;
        }

        let moreBtn = document.getElementById('moreBtn');

        if (result.pgvo.pageNo < result.endPage) {
            moreBtn.style.display = 'block';
            moreBtn.dataset.page = page + 1;
        } else {
            moreBtn.style.display = 'none';
        }
    } catch (error) {
        console.log(error);
    }
}


// 중고 페이지에서 로컬 스토리지의 카테고리 사용 및 초기화
document.addEventListener('DOMContentLoaded', () => {
    const selectedCategory = localStorage.getItem('selectedCategory');

    if (selectedCategory) {
        // 카테고리를 사용하여 필요한 작업 수행
        console.log(selectedCategory);
        let selectElement = document.getElementById('menu');
        let options = selectElement.options;

        for (let i = 0; i < options.length; i++) {
            if (options[i].value === selectedCategory) {
                options[i].selected = true;
                break;
            }
        }
        getMoreBoard(category,1,selectedCategory,sortedBy);
    }else{
        // board 선언
        getMoreBoard(category);
    }
    document.getElementById('loading').style.display = 'block';
    setTimeout(()=> document.getElementById('loading').style.display = 'none', 200);
});

// 페이지 언로드 시 로컬 스토리지에서 카테고리 삭제
window.onunload = function() {
    localStorage.removeItem('selectedCategory');
};