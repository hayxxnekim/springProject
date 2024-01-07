//좋아요 버튼 클릭시
document.getElementById('likeBtn').addEventListener('click', ()=>{
	let currentLikeCount = parseInt(document.getElementById('cmLikeCnt').innerText);

	if(!(userEmail)){
		alert('로그인을 해주세요.');
	}

	if(userEmail){
	    if(document.getElementById('likeBtn').classList.contains('bi-heart')){ //안 누른 상태면
	        console.log("좋아요 등록");
	        document.getElementById('likeBtn').classList.replace('bi-heart', 'bi-heart-fill');
			document.getElementById('cmLikeCnt').innerText = currentLikeCount + 1;
	        likeToServer(bnoVal, userEmail);
	    }else if(document.getElementById('likeBtn').classList.contains('bi-heart-fill')){ //이미 누른 상태면
	        console.log("좋아요 취소"); 
	        document.getElementById('likeBtn').classList.replace('bi-heart-fill', 'bi-heart');
			document.getElementById('cmLikeCnt').innerText = currentLikeCount - 1;
	        likeToServer(bnoVal, userEmail);

	    }
	}    
})

//좋아요 정보 보내주기
async function likeToServer(bno, email){ 
    try{
        const url = '/community/'+bno+'/'+email;
        const config = {
            method : "post"
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result; 
        
    }catch(err){
        console.log(err);
    }
}

//프로필을 받아오기 위해 이메일 보내주기
async function getProfileToServer(email){
	try{
		const url = '/community/profile/'+email;
		const config = {
            method : "post"
        };
        const resp = await fetch(url, config);
        const result = await resp.json();
        return result; 
        
    }catch(err){
        console.log(err);
    }
}

function communityProfile(email, id){
	getProfileToServer(email).then(result =>{
		if(result != null){
			document.getElementById(id).src = `/upload/profile/${result.saveDir.replace('\\','/')}/${result.uuid}_${result.fileName}`;
		}
	})
}

//시간 제외 날짜만 나오게 하기
function onlyDate(date){
	let dateOnly = new Date(date); 
	const year = dateOnly.getFullYear();
	const month = (dateOnly.getMonth() + 1).toString().padStart(2, '0');
	const day = dateOnly.getDate().toString().padStart(2, '0');
	const extractedDate = `${year}-${month}-${day}`;
	document.getElementById('onlyDate').innerText = extractedDate;
}

document.getElementById('linkBtn').addEventListener('click',()=>{
	let url = window.location.href;

    navigator.clipboard.writeText(url).then(() => {
		swal.fire({
            text: "주소가 복사되었습니다!",
            icon: "success",
            showConfirmButton: false,
            width: 400,
            timer: 1000
        });
    }).catch(err => {
        console.error('클립보드에 복사 실패:', err);
    });
})
