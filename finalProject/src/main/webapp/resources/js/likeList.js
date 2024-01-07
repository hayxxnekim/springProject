// select menu 변경 시 이벤트 처리
document.getElementById('commuLikeListSelect').addEventListener('change', ()=>{
    // 선택된 메뉴 값 가져오기
    type = document.getElementById('commuLikeListSelect').value;
    console.log("likeListcategory edit >> " + type);

    getLikeList(type);
});


// DB에서 작성글 가져오는 함수
async function getLikeListFromServer(type){
    try {
        const resp = await fetch('/myList/likeList/'+type); 
        const result = await resp.json();
        return result;
        console.log(result);
    } catch (error) {
        console.log(error);
    }
}


getLikeList();
// 정렬 할 때 쓸 기본 카테고리 지정
function getLikeList(type){
    getLikeListFromServer(type).then(result => {
        console.log("LikeList type >> ",type);
        console.log("LikeList >> ", result);
        let moreLikeArea = document.getElementById('moreLikeArea');
        if(result.length > 0 ){
            let inner = "";

            for(let like of result){
                // 날짜 시간부분 잘라내기
                // let upDate = like.pbvo.proReAt.substring(0,10);
                inner += `<div class="likeListContent">`;
                document.getElementById('likeCnt').innerHTML = `${result.length}`;
                inner += `<a href="/${like.pbvo.proCategory}`; //?
                if(like.proCategory == 'store'){
                    inner += `/detail?bno=${like.pbvo.proBno}">`;
                }else {
                    inner += `/detail?proBno=${like.pbvo.proBno}">`;
                }
                if(like.pflist.length > 0) {
                    console.log(like.pflist[0].saveDir);
                    inner += `<img alt="" src="/upload/product/${like.pflist[0].saveDir.replaceAll('\\','/')}/${like.pflist[0].uuid}_${like.pflist[0].fileName}">`;
                }else{
                    inner += `<img alt="" src="../resources/image/defaultImage.jpg">`;
                }
                inner += `<div class="likeInfoArea">`;
                inner += `<span class="proTitle">${like.pbvo.proTitle}</span>`;
                inner += `<span><strong class="payment">`;
                if(like.pbvo.proPayment){
                    inner += `${like.pbvo.proPayment} `;
                }
                let price = like.pbvo.proPrice.toLocaleString('ko-KR');
                inner += `${price} 원</strong></span>`;

                if(like.likeList.length > 0) {
                    let likeTime = new Date(like.likeList[0].liRegAt);
                    let currentTime = new Date();
                    let timeDiffInSeconds = Math.floor((currentTime - likeTime) / 1000); // 차이를 초 단위로 계산
                    let timeAgo;
                        if (timeDiffInSeconds < 60) {
                            timeAgo = `${timeDiffInSeconds}초 전`;
                        } else if (timeDiffInSeconds < 3600) {
                            let minutes = Math.floor(timeDiffInSeconds / 60);
                            timeAgo = `${minutes}분 전`;
                        } else if (timeDiffInSeconds < 86400) {
                            let hours = Math.floor(timeDiffInSeconds / 3600);
                            timeAgo = `${hours}시간 전`;
                        } else {
                            let days = Math.floor(timeDiffInSeconds / 86400);
                            timeAgo = `${days}일 전`;
                        }
                        inner += `<span class="proAddr"> ${timeAgo}</span>`;
                }
                inner += `</div>`;
                inner += `<div class="likeInfoAddr">`;
                inner += `<i class="bi bi-geo-alt"></i><span class="d-inline-block text-truncate" style="max-width: 200px;">`;
                if(like.pbvo.proCategory == 'store'){
                    let lastSpaceIndex = like.pbvo.proFullAddr.lastIndexOf(' ');
                    if (lastSpaceIndex !== -1) {
                        proFullAddr = like.pbvo.proFullAddr.substring(0, lastSpaceIndex);
                    }
                    inner += `<span class="proAddr">${proFullAddr}</span>`;
                }else {
                    inner += `<span class="proAddr">${like.pbvo.proSido} ${like.pbvo.proSigg} ${like.pbvo.proEmd}</span>`;
                }
                inner += `</div>`;
                inner += `</a>`;
                inner += `<div class="likeHeart">`;
                inner += `<input type="hidden" value="${like.pbvo.proBno}" class="proBno">`;
                inner += `<input type="hidden" value="${like.likeList[0].liUserId}" class="liUserId">`;
                inner += `<i class="bi bi-heart-fill likeBtn" id="likeBtn"></i><span> ${like.pbvo.proLikeCnt}</span>`;
                inner += `</div>`;
                inner += `</div>`;
            }   
            moreLikeArea.innerHTML = inner;
        }else{
                let inner = `찜한 게시글이 없습니다.`;
                moreLikeArea.innerHTML = inner;
                document.getElementById('likeCnt').innerHTML = ` 0`;
        }
    })
}


// 찜하기버튼 클릭시 발생

document.addEventListener('click',(e)=>{
    let checkLikeCntElement = document.getElementById('likeCnt');
    let checkLikeCnt = parseInt(checkLikeCntElement.innerText);

    // 찜버튼 클릭시 state값 -1, 버튼의 class값 바꿔서 빈 하트로 변경
    if (e.target.classList.contains('likeBtn')) {
        let likeBtn = e.target.closest('.likeHeart');
        let proBnoVal = likeBtn.querySelector('.proBno').value;
        let liUserId = likeBtn.querySelector('.liUserId').value;
        let likeListContent = likeBtn.closest('.likeListContent');
        likeListContent.remove();
        document.getElementById('likeCnt').innerText = checkLikeCnt - 1;
        likeToServer(proBnoVal, liUserId, -1); 
    }
})


async function likeToServer(proBnoVal, memEmail, state) { 
    try {
        const url = "/job/list/like";
        const config = {
            method: "post",
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                liBno: proBnoVal,
                liUserId: memEmail,
                liStatus: state
            })
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result; 
    } catch (err) {
        console.log(err);
    }
}
getLikeList();

// // 정렬 할 때 쓸 메뉴값 가져오기 
// let commuListcategory ='commuWriterList';
// console.log(commuListcategory);


// // select menu 변경 시 이벤트 처리
// document.getElementById('commuListSelect').addEventListener('change', ()=>{
//     // 선택된 메뉴 값 가져오기
//     commuListcategory = document.getElementById('commuListSelect').value;
//     console.log("commuListcategory edit >> " + commuListcategory);

//     spreadCommuListFromServer(1 , commuListcategory);
// });

// // more 버튼 클릭 시 호출될 함수
// async function loadMoreCommuList() {
//     console.log("더보기 클릭");
//     console.log(document.getElementById('commuListmoreBtn').dataset.page);
//     const currentPage = parseInt(document.getElementById('commuListmoreBtn').dataset.page);
//     console.log("currentPage >> " + currentPage);

//     spreadCommuListFromServer(currentPage, commuListcategory);
// }


// // 서버에서 community Like List랑 community write List가져오기
// async function getCommuListForServer(page, commuListcategory){
//     try {
//         const resp = await fetch('/myList/commuList/'+page+'/'+commuListcategory);
//         const result = await resp.json();
//         console.log(result);
//         return result;
//     } catch (error) {
//         console.log(error);
//     }
// }


// //특정 게시글 thumbnail 가져오는 함수
// async function getCommuThumbnailToServer(bno){
//     try {
//         const resp = await fetch('/community/thumb/'+bno);
//         const result = await resp.json();
//         return result;
//     } catch (error) {
//         console.log(error);
//     }
// }

// // 서버에서 받은 list 뿌리기
// async function spreadCommuListFromServer(page = 1, commuListcategory){
//     try {
//         const result = await getCommuListForServer(page, commuListcategory);
//         console.log(" commuListForServer >> result >> " , result);

//         // ph객체의 의 리스트에 상품(job)이 있는 경우
//         if(result.cmList.length > 0){
//             let moreCommuListArea = document.getElementById('moreCommuListArea');
//             console.log(result.cmList.length);
//             if(page == 1) {
//                 // 1page에서 초기화
//                 moreCommuListArea.innerHTML = "";
//             }
//             let inner = "";

//             for(let cm of result.cmList){
//                 // cmRegAt 날짜만 가져오기
//                 let upDate = cm.cmRegAt.substring(0,10);
//                 console.log("타입 " + result.pgvo.type + "으로 진입");
//                 inner += `<div class="commuListContent">`;
//                 inner += `<a href="/community/detail?cmBno=${cm.cmBno}">`;
//                 document.getElementById('commuListCnt').innerText = `${result.totalCount}`;

//                 let cmBno = cm.cmBno;
//                 if (cm.cmFileCnt > 0) {
//                     let thumb = await getCommuThumbnailToServer(cmBno);
//                     inner += `<img class="thumbImg" src="/upload/community/${thumb.saveDir.replaceAll('\\','/')}/${thumb.uuid}_${thumb.fileName}"  alt="...">`;
//                 }else{
//                      inner += `<img alt="commuList image error" src="../resources/image/defaultImage.jpg">`
//                 }
//                 inner += `<div class="contentWrap">`;
//                 inner += `<h3>${cm.cmTitle}</h3>`;
//                 inner += `<b>${cm.cmContent}</b>`;
//                 inner += `<small>${upDate}</small>`;
//                 inner += `</div>`;
//                 inner += `<mark><i class="bi bi-geo-alt"></i>${cm.cmSido} ${cm.cmSigg} ${cm.cmEmd}</mark>`;
//                 inner += `<input type="hidden" value="${cm.cmBno}" class="cmBno">`;
//                 inner += `<input type="hidden" value="${cm.cmEmail}" class="cmUserId">`;
//                 console.log("result.pgvo.type >> " + result.pgvo.type);
//                 console.log("result >> ", result);
//                 inner += `</a>`;
//                 // if(result.pgvo.type == 'commuLikeList'){
//                 //     console.log("commu type like list");
//                 //     inner += `<div class="likeHeart">`;
//                 //     inner += `<i class="bi bi-heart-fill commulikeBtn" id="commulikeBtn"></i><span id="cmLikeCnt"> ${cm.cmLikeCnt}</span>`;
//                 //     inner += `</div>`;
//                 // }
//                 inner += `</div>`;
                

//             }
//             moreCommuListArea.innerHTML += inner;

//         }else {
//             if(commuListcategory='commuLikeList'){
//                 let inner = `좋아요 한 게시글이 없습니다.`;
//                 moreCommuListArea.innerHTML = inner;
//             } else {
//                 let inner = `작성 한 게시글이 없습니다.`;
//                 moreCommuListArea.innerHTML = inner;
//             }
//         }

//         let commuListmoreBtn = document.getElementById('commuListmoreBtn');

        
//         if (result.pgvo.pageNo < result.endPage) {
//             commuListmoreBtn.style.visibility = 'visible';
//             commuListmoreBtn.dataset.page = page + 1;
//         } else {
//             commuListmoreBtn.style.visibility = 'hidden';
//         }

//     } catch (error) {
//         console.log(error);
        
//     }
// }

// //좋아요 버튼 클릭시 취소처리
// if(commuListcategory == 'commuLikeList'){
//     console.log("commu List 좋아요 취소!");

//     document.getElementById('commulikeBtn').addEventListener('click', ()=>{
//         let currentLikeCount = parseInt(document.getElementById('cmLikeCnt').innerText);
//         let bnoVal = likeBtn.querySelector('.cmBno').value;
//         let userEmail = likeBtn.querySelector('.cmUserId').value;
//         console.log(bnoVal + "/" + userEmail);

// 	        console.log("좋아요 취소"); 
// 			document.getElementById('cmLikeCnt').innerText = currentLikeCount - 1;
// 	        likeToServer(bnoVal, userEmail);
// })
// }

// //좋아요 정보 보내주기
// async function likeToServer(bno, email){ 
//     try{
//         const url = '/community/'+bno+'/'+email;
//         const config = {
//             method : "post"
//         };
//         const resp = await fetch(url, config);
//         const result = await resp.text();
//         return result; 
        
//     }catch(err){
//         console.log(err);
//     }
// }

// spreadCommuListFromServer();



