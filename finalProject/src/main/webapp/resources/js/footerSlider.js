let slider = document.getElementById('sliderUl');

// 서버에서 공지 리스트 불러오는 함수
async function getInfoListForServer(){
    try {
        const resp = await fetch("/info/slider");
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 페이지가 로드되면 공지 불러오기
window.addEventListener('DOMContentLoaded', async function(){
    await getInfoListForServer().then(result=>{
        let sliderA = "";
        console.log(result);
        if(result.length > 0){
            for(let r of result){
                sliderA += `<a class="splide__slide" href="/info/detail?bno=${r.infoBno}">${r.infoTitle}</a>`;
            }
            slider.innerHTML = sliderA;
        }
    })
    
    var splide = new Splide('.splide', {
    	type : 'loop',
		direction: 'ttb',
		height : '60px',
		arrows : false,
		autoplay : true,
		pagination : false
	});

	splide.mount();
})