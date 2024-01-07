// document.getElementById('delBtn').addEventListener('click', function(event) {
//     Swal.fire({
//         text: "게시글이 삭제되었습니다!",
//         icon: "success",
//         showConfirmButton: false,
//         width: 400,
//         timer: 1000
//     }).then(() => {
//         window.location.href = this.parentElement.getAttribute('href');
//     });
//     event.preventDefault();
// });


//좋아요 여부 체크
let isLiked  = false;

async function checkLike(user, bno) {
    try {
        const url = '/store/checkLike/'+user+'/'+bno;
        const resp = await fetch(url);
        const isLiked = await resp.text();
        console.log(isLiked);

        likeOrNot(isLiked === '1');
    } catch (err) {
        console.log(err);
    }
}

//좋아요 눌렀을 경우 빨간 하트 보여주기
function likeOrNot(isLiked) {
    const heartIcon = document.getElementById('like');

    if (isLiked) {
        //기존에 좋아요를 누른 경우
        heartIcon.classList.replace('bi-heart','bi-heart-fill');
    } 
}

async function updateLike(likeData) {
    try {
        const url = '/store/updateLike';
        const config = {
            method : 'post',
            headers : {
                'Content-Type':'application/json; charset=utf-8'
            },
            body : JSON.stringify(likeData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (err) {
        console.log(err);
    }
}

async function likeOrDislike(bno, user) {
    let likeData = {
        liBno : bno,
        liUserId : user
    };
    
    try {
        const result = await updateLike(likeData);
        const likeCount = document.getElementById('likeCount');
        likeCount.innerHTML =  `관심 ${result }`;
        
    } catch (err) {
        console.error(err);
    }
}

//현재 url 변수로 가져오기
let detailPageUrl = window.location.href;

function clip(){ 
	//detailPageUrl 변수에 담긴 주소를
  	navigator.clipboard.writeText(detailPageUrl).then(res=>{
        swal.fire({
            text: "주소가 복사되었습니다!",
            icon: "success",
            showConfirmButton: false,
            width: 400,
            timer: 1000
        });
	})
}

function toLogin() {
    window.location.href = 'http://localhost:8088/member/login';
};