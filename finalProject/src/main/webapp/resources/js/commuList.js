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

//            console.log("좋아요 취소"); 
//          document.getElementById('cmLikeCnt').innerText = currentLikeCount - 1;
//            likeToServer(bnoVal, userEmail);
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





// select menu 변경 시 이벤트 처리
document.getElementById('commuListSelect').addEventListener('change', ()=>{
    // 선택된 메뉴 값 가져오기
    type = document.getElementById('commuListSelect').value;
    console.log("commuListcategory edit >> " + type);

    getCommuList(type);
});


// DB에서 작성글 가져오는 함수
async function getCommuListFromServer(type){
    try {
        const resp = await fetch('/myList/commuList/'+type); 
        const result = await resp.json();
        return result;
        console.log(result);
    } catch (error) {
        console.log(error);
    }
}


getCommuList();
// 정렬 할 때 쓸 기본 카테고리 지정
function getCommuList(type = 'commuWriterList'){
    getCommuListFromServer(type).then(result => {
        console.log("commulist type >> ",type);
        console.log("commulist >> ", result);
        let moreCommuListArea = document.getElementById('moreCommuListArea');
        if(result.length > 0 ){
            let inner = "";

            for(let cm of result){
                // 날짜 시간부분 잘라내기
                let upDate = cm.bvo.cmModAt.substring(0,10);
                inner += `<div class="commuListContent">`;
                inner += `<a href="/community/detail?cmBno=${cm.bvo.cmBno}">`;
                document.getElementById('commuListCnt').innerText = `${result.length}`;
                if(cm.flist.length > 0) {
                    console.log(cm.flist[0].saveDir);
                    inner += `<img alt="" src="/upload/community/${cm.flist[0].saveDir.replaceAll('\\','/')}/${cm.flist[0].uuid}_${cm.flist[0].fileName}">`;
                }else{
                    inner += `<img alt="" src="../resources/image/defaultImage.jpg">`;
                }
                inner += `<div class="contentWrap">`;
                inner += `<h3>${cm.bvo.cmTitle}</h3>`;
                inner += `<b>${cm.bvo.cmContent}</b>`;
                inner += `<small>${upDate}</small>`;
                inner += `</div>`;
                inner += `<mark><i class="bi bi-geo-alt"></i>${cm.bvo.cmSido} ${cm.bvo.cmSigg} ${cm.bvo.cmEmd}</mark>`;
                inner += `<input type="hidden" value="${cm.bvo.cmEmail}" class="cmUserId">`;
                inner += `</a>`;
                // if(type == 'commuLikeList'){
                //     inner += `<div class="likeHeart">`;
                //     inner += `<i class="bi bi-heart-fill commulikeBtn" id="commulikeBtn"></i><span id="cmLikeCnt"> ${cm.bvo.cmLikeCnt}</span>`;
                //     inner += `</div>`;
                // }
                inner += `</div>`;
            }   
            moreCommuListArea.innerHTML = inner;
        }else{
            if(type='commuLikeList'){
                let inner = `좋아요 한 게시글이 없습니다.`;
                moreCommuListArea.innerHTML = inner;
            } else {
                let inner = `작성 한 게시글이 없습니다.`;
                moreCommuListArea.innerHTML = inner;
            }
        }
    })
}
