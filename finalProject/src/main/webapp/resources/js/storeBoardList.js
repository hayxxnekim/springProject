// 페이지가 다 로드되면 로딩화면 삭제
window.onload = function() {
    setTimeout(()=> document.getElementById('loading').style.display = 'none', 500);
};

// console.log("전체 업체 개수 : " + listLength);
// var remainder = listLength % 2;
// console.log("나머지 : " + remainder);
// //오른쪽 : 줄이기

// if (remainder === 1) {
//     const lastLi = document.querySelector(".listContainer ul li:last-child");
//     lastLi.style.marginRight = "376px";
// }

async function spreadStoreFromServer(page, type, sort){
    try{
        const resp = await fetch('/store/page/'+page+'/'+type+'/'+sort);
        const result = await resp.json();
        return result;
    }catch(err){
        console.log(err);
    }
}

//페이지가 처음 로드될 때 전체 업체 표시
function getStoreList(page = 1, type = null, sort = null) {
    spreadStoreFromServer(page, type, sort).then(result => {
        console.log(result);
        const ul = document.getElementById('ulZone');
        const moreBtn = document.getElementById('moreBtn');
        let cnt = result.totalCount;
        document.querySelector('.totalCnt').innerHTML = `등록 업체 <b>${cnt}</b>개`;

        if (page === 1) {
            ul.innerHTML = "";
        }

        if (result.prodList.length > 0) {
            for (let i = 0; i < result.prodList.length; i++) {
                let svo = result.prodList[i];
                let reviewCnt = result.reviewCntList[i];  

                const matchingFvo = result.prodFileList.find(f => f.bno === svo.proBno);

                let imgSrc = "";
                
                if (matchingFvo) {
                    // matchingFvo가 존재할 경우 이미지 경로 설정
                    imgSrc = `/upload/product/${matchingFvo.saveDir.replace('\\', '/')}/${matchingFvo.uuid}_${matchingFvo.fileName}`;
                } else {
                    // matchingFvo가 없는 경우 기본 이미지 
                    imgSrc = "../resources/image/defaultImage.jpg";
                }
            
                // li 생성
                const li = document.createElement('li');
                li.innerHTML = `
                    <a href="/store/detail?bno=${svo.proBno}">     
                            <div class="profileContainer">
                                <img class="profile" src="${imgSrc}">
                            </div>

                        <div class="textContainer">                          
                           <span class="title">${svo.proTitle}</span>                            
                            <span class="content">${svo.proContent}</span>
                            
                            <div class="infoTexts">
                               <span class="gray">${svo.proEmd } | ${svo.proMenu} | 후기 ${reviewCnt}</span>
                            </div>   
                        </div>
                    </a>
                `;
                // li 추가
                ul.appendChild(li);
            }

            if (result.pgvo.pageNo < result.endPage) {
                moreBtn.style.visibility = 'visible';
                moreBtn.dataset.page = page + 1;
            } else {
                moreBtn.style.visibility = 'hidden';
            }
        } else {
            //result.prodList가 비어있는 경우
            const noResultMessage = document.createElement('div');
            noResultMessage.innerText = '게시글이 존재하지 않습니다.';
            ul.appendChild(noResultMessage);
            moreBtn.style.visibility = 'hidden';
        }
    });
}


let cateType; 
let sortType;

document.addEventListener('change', (e) => {
    let cateSelect = document.getElementsByName("categorySelect")[0];
    cateType = cateSelect.options[cateSelect.selectedIndex].value;
    
    let sortSelect = document.getElementsByName("sortSelect")[0];
    sortType = sortSelect.options[sortSelect.selectedIndex].value;
    const targetId = e.target.id;

    if (targetId === 'categorySelect') {
        document.getElementById('loading').style.display = 'block';
        getStoreList(1, cateType, sortType);
        setTimeout(() => document.getElementById('loading').style.display = 'none', 200);
    } else if(targetId === 'sortSelect') {
        document.getElementById('loading').style.display = 'block';
        getStoreList(1, cateType, sortType);
        setTimeout(() => document.getElementById('loading').style.display = 'none', 200);
    }
});

document.addEventListener('click', (e) => {
    const targetId = e.target.id;

    if (targetId === 'moreBtn') {
        document.getElementById('loading').style.display = 'block';
        getStoreList(parseInt(e.target.dataset.page), cateType, sortType);
        setTimeout(() => document.getElementById('loading').style.display = 'none', 500);
    }
});