//현재 날짜
let today = new Date();
let year = today.getFullYear();
let month = ('0' + (today.getMonth() + 1)).slice(-2);
let day = ('0' + today.getDate()).slice(-2);

//가입 날짜
let regYear = regAt.slice(0,4);
let regMonth = regAt.slice(5,7);
let regDay = regAt.slice(8,10);

//현재 날짜와 가입 날짜 차이 계산
let timeDifference = Math.abs(today - new Date(regYear, regMonth-1, regDay)); 
let daysDifference = Math.ceil(timeDifference / (1000*60*60*24));

//주소, 가입일 수정
document.getElementById('userAddr').innerHTML = `<i class="bi bi-geo-alt-fill"></i>주소<span class="black">${sido} ${sigg} ${emd}</span>`;
document.getElementById('calcDate').innerHTML = `<i class="bi bi-calendar"></i>아보카트 가입일<span class="black">${daysDifference} 일 전</span>`;

//기본 프로필일 경우, 삭제 버튼 가리기
document.addEventListener('DOMContentLoaded', function() {
    if (mainSrc === "../resources/image/기본 프로필.png") {
        document.getElementById('delBtn').style.display = 'none';
        document.querySelector('#editProfile ul li:nth-child(1)').style.borderBottom = 'none';
    }
});

//프로필 수정, 삭제 버튼 보이기
function editProfile(event) {
    const editProfile = document.getElementById('editProfile');

    //클릭한 좌표
    const x = event.clientX;
    const y = event.clientY;

    //editProfile 위치 설정
    editProfile.style.left = `${x}px`;
    editProfile.style.top = `${y}px`;

    editProfile.style.display = editProfile.style.display === 'block' ? 'none' : 'block';
}

document.getElementById('mainPro').addEventListener('click', editProfile);
 
document.getElementById('editBtn').addEventListener('click',()=>{
    const editProfile = document.getElementById('editProfile');
    document.getElementById('profile').click();
    editProfile.style.display = 'none';
});

const regExp = new RegExp("\.(exe|sh|bat|js|msi|dll)$");
const regExpImg = new RegExp("\.(jpg|jpeg|png)$"); 
const maxSize = 1024*1024*20;

function fileValidation(fileName, fileSize){
   if(!regExpImg.test(fileName)){
       return 0;
   }else 
    if(regExp.test(fileName)){
        return 0;
    }else if(fileSize > maxSize){
        return 0;
    }else {
        return 1;
    }
}

function profileToServer(email, files) {
    const formData = new FormData();
    formData.append('file', files[0]);
    const url = baseUrl + email;

    $.ajax({
        url: url,
        type: 'post',
        data: formData,
        contentType: false,
        processData: false,

        success: function(result) {
            console.log(result);
            document.getElementById('profile').value = "";
            location.reload();
        },
        error: function(err) {
            console.log('Error:', err);
        }
    });
}

// 프로필 사진 서버 전송
document.addEventListener('change', (e) => {
    if (e.target.id == 'profile') {
        let files = $('#profile')[0].files;

        if (files.length > 0) {
            let fileName = files[0].name;
            let fileSize = files[0].size;
            let validResult = fileValidation(fileName, fileSize);

            if (validResult === 0) {
                alert("업로드할 수 없는 파일입니다.");
                document.getElementById('profile').value = "";
            } else {
                profileToServer(email, files);
            }
        }
    }
});

async function deleteProfileToServer(email) {
    try {
        const url = '/hmember/deleteFile/'+email;
        const config = {
            method : 'delete',
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        location.reload();
        return result;
    } catch (err) {
        console.log(err);
    }
}

//프로필 삭제 버튼
document.getElementById('delBtn').addEventListener('click',()=>{
    const editProfile = document.getElementById('editProfile');
    editProfile.style.display = 'none';
    deleteProfileToServer(email);
});

//리뷰 리스트
// async function spreadReviewFromServer(page, type, sort){
//     try{
//         const resp = await fetch('/store/reviewPage/'+page+'/'+type);
//         const result = await resp.json();
//         return result;
//     }catch(err){
//         console.log(err);
//     }
// }

// // 스타 레이팅을 동적으로 계산하는 함수
// function setStarRating(rating) {
//     var fillStars = document.getElementById('fillStars');
//     var widthPercentage = (rating / 5) * 100; // 5점 만점 기준으로 비율 계산
//     fillStars.style.width = widthPercentage + '%';
// }

// //페이지가 처음 로드될 때 전체 리뷰 표시
// function getReviewList(page = 1, type = 'joongo') {
//     spreadReviewFromServer(page, type).then(result => {
//     	const reviewData = result;
//     	console.log(reviewData);
    	
//     	//리뷰 총합 계산
//     	const totalScore = reviewData.reviewList.reduce((sum, review) => sum + review.reScore, 0);
//     	console.log("총합"+totalScore);
    	
//     	//리뷰 개수
//     	const reviewCount = reviewData.reviewList.length;
//     	console.log("개수"+reviewCount);
    	
//     	//리뷰 평균
//     	const averageScore = reviewCount > 0 ? totalScore / reviewCount : 0;
//         console.log("평균"+averageScore);
        
        
//         // 리뷰 평균에 따라 동적으로 스타 레이팅 업데이트
//         setStarRating(averageScore);
        
//         const ul = document.getElementById('ulZone');

      
//     });
// }
