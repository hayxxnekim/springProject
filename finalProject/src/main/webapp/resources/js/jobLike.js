let like = document.getElementsByClassName('bi-heart');
let likeBtn = document.getElementById('likeBtn');


//like 여부 지정하는 변수
let state = 0;

async function likeOrDislike(proBnoVal, memEmail) {
    let likeData = {
        liBno : proBnoVal,
        liUserId : memEmail
    };
    
    try {
        const result = await updateLike(likeData);
        
    } catch (err) {
        console.error(err);
    }
}

// //좋아요 버튼 클릭시
// document.getElementById('likeBtn').addEventListener('click', ()=>{
// 	let currentLikeCount = parseInt(document.getElementById('checkJobLikeCnt').innerText);

// 	if(!(userEmail)){
// 		alert('로그인을 해주세요.');
// 	}

// 	if(userEmail){
// 	    if(document.getElementById('likeBtn').classList.contains('bi-heart')){ //안 누른 상태면
// 	        console.log("좋아요 등록");
//             state = 1;
// 	        document.getElementById('likeBtn').classList.replace('bi-heart', 'bi-heart-fill');
// 			document.getElementById('checkJobLikeCnt').innerText = currentLikeCount + 1;
// 	        likeToServer(proBnoVal, memEmail, state);
// 	    }else if(document.getElementById('likeBtn').classList.contains('bi-heart-fill')){ //이미 누른 상태면
// 	        console.log("좋아요 취소"); 
//             state = -1;
// 	        document.getElementById('likeBtn').classList.replace('bi-heart-fill', 'bi-heart');
// 			document.getElementById('checkJobLikeCnt').innerText = currentLikeCount - 1;
//             likeToServer(proBnoVal, memEmail, state);

// 	    }
// 	}    
// })


// 찜하기
likeBtn.addEventListener('click', () => {
    let checkLikeCntElement = document.getElementById('checkJobLikeCnt');
    let checkLikeCnt = parseInt(checkLikeCntElement.innerText);
    
    
    console.log("checkLikeCnt>>" + checkLikeCnt);
    
    console.log("memEmail>>" + "'" + memEmail+"'");

    if (memEmail == null && memEmail == undefined || memEmail == '') {
        alert("로그인 해주세요.");
    }

    if(memEmail){
        // 찜 클릭시 상황에 따라 아이콘 toggle 및 state값 설정
        if (likeBtn.classList.contains('bi-heart-fill')) {
            // 찜취소
            // 취소 시 status -1 변경
            state = -1;
            document.getElementById('likeBtn').classList.replace('bi-heart-fill', 'bi-heart');
            document.getElementById('checkJobLikeCnt').innerText = checkLikeCnt - 1;
            
        } else {
            state = 1;
            document.getElementById('likeBtn').classList.replace('bi-heart', 'bi-heart-fill');
            document.getElementById('checkJobLikeCnt').innerText = checkLikeCnt + 1;
        }
        
        likeToServer(proBnoVal, memEmail, state);
        console.log("proBnoVal>>" + proBnoVal + "/ memEmail>>" + memEmail + "/ state>>" + state);

    }
});



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
