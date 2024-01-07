const urlParams = new URL(location.href).searchParams;
const userEmail = urlParams.get('memEmail');

console.log(userEmail)

let h3 = document.getElementById('reviewSize');
let starScore =  document.getElementById('starScore');
let star = '★';
let percentText = document.getElementById('percentText');

async function spreadReviewFromServer(type){
    try{
        const resp = await fetch('/hmember/reviewPage/'+type+'/'+userEmail);
        const result = await resp.json();
        return result;
    }catch(err){
        console.log(err);
    }
}

function setStarRating(rating) {
    var fillStars = document.getElementById('fillStars');
    var widthPercentage = (rating / 5) * 100;
    fillStars.style.width = widthPercentage + '%';
}

//페이지 처음 로드될 때 
function getReviewList(type = 'joongo') {
    spreadReviewFromServer(type).then(result => {
        console.log(result);
        const plist = result.plist;
        const rlist = result.rlist;
        const ul = document.getElementById('ulZone');
        let naming = '';

        if(type==='store') {
            naming = '업체'
        } else if(type==='job') {
            naming = '구인'
        } else {
            naming ='거래'
        }
        
    	let reviewData = rlist;       
    	
        //리뷰 점수 합산
        let totalScore = reviewData.reduce((sum, review) => sum + review.reScore, 0);
    	
    	//리뷰 개수
    	let reviewCount = reviewData.length;
        h3.innerHTML = `${naming}후기 <b>${reviewCount}</b>`;

    	//리뷰 평균
    	let averageScore = reviewCount > 0 ? totalScore / reviewCount : 0;
        starScore.innerHTML = `${averageScore % 1 !== 0 ? averageScore.toFixed(1) : averageScore}`;
               
        let percent = `${Math.round(averageScore * 20)}`;
        percentText.innerText = percent+"%";
        
        setStarRating(averageScore);

        ul.innerHTML = '';
        if(rlist.length>0) {
            for(let i = 0; i < rlist.length; i++) {
                let rvo = rlist[i];
                const dateString = rvo.regAt; 
                const date = new Date(dateString);
                const formattedDate = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`;

                const matchingFvo = result.plist.find(p => p.prEmail === rvo.senderEmail);
                let imgSrc = "";
                
                if (matchingFvo) {
                    // matchingFvo가 존재할 경우 이미지 경로 설정
                    imgSrc = `/upload/profile/${matchingFvo.saveDir.replace('\\', '/')}/${matchingFvo.uuid}_${matchingFvo.fileName}`;
                } else {
                    // matchingFvo가 없는 경우 기본 이미지 
                    imgSrc = "../resources/image/기본 프로필.png";
                }

                const li = document.createElement('li');
                li.classList.add('reviewLi');
                li.innerHTML = `
                <div class="reviewLiContanier">  
                            <a href="/hmember/detail?memEmail=${rvo.senderEmail}">     
                        <div class="senderInfo">  
                            <img class="reviewProfile" src="${imgSrc}" alt="프사자리">
                            </a>
                            <div class="innerSender">
                            <div class="reviewDate">${formattedDate}</div> 
                                <div class="reviewNick">${rvo.reSenderNick}</div>
                                <div class="starContainer">
                                    <span class="goldStar">${'★'.repeat(rvo.reScore)}</span><span class="grayStar">${'★'.repeat(5-rvo.reScore)}</span>
                                </div>
                            </div>
                        </div>
                    <div class="textContainer">                                                     
                        <textarea cols="50" rows="3" class="reviewContent" readonly="readonly">${rvo.reContent}</textarea>
                    </div>
                </div>
            `;                    
            // li 추가
            ul.appendChild(li);               
            }
        } else {
            const noResultMessage = document.createElement('div');
            noResultMessage.innerText = '작성된 후기가 없습니다.';
            ul.appendChild(noResultMessage);
        }    
    });
}

document.addEventListener('change', (e) => {
    if (e.target.name === 'categorySelect') {
        let cateType = e.target.value;
        getReviewList(cateType);
    }
});

