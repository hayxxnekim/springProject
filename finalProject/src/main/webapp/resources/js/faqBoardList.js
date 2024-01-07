document.addEventListener('click',(e)=>{
    if(e.target.classList.contains('questionBtn')){
        let index = e.target.closest('li').id;
        let upBtn = document.getElementById(`up-${index}`);
        let answerArea = document.getElementById(`text-${index}`)

        if(upBtn.classList.contains('bi-chevron-up')){
            upBtn.classList.replace('bi-chevron-up', 'bi-chevron-down');
        }else{
            upBtn.classList.replace('bi-chevron-down', 'bi-chevron-up');
        }

		if (answerArea.style.display === "none") {
		    answerArea.style.display = "block";
		} else {
		    answerArea.style.display = "none";
		}
    }
})

// 특정 textarea의 줄 수를 조정하는 함수
function adjustTextareaRows(textarea) {
    // 글 내용에서 줄바꿈 수를 세어 변수 저장
    let lineCount = (textarea.value.match(/\n/g) || []).length + 1;

    textarea.rows = lineCount;
}

// 페이지가 로드되면 모든 answerArea에 대해 adjustTextareaRows 함수 실행
document.addEventListener('DOMContentLoaded', function() {
    // 모든 'answerArea' 클래스를 가진 textarea 요소 찾기
    let textareas = document.querySelectorAll('.answerArea');

    // 각 textarea에 대해 adjustTextareaRows 함수 호출
    textareas.forEach(function(textarea) {
        adjustTextareaRows(textarea);
    });
});

//현재 fullPath
let fullPath = window.location.href;
console.log(fullPath);
let mappingPath = path.substring(path.lastIndexOf('/')+1);
console.log(mappingPath);
//div의 a 요소 가져오기
let aList = document.querySelectorAll('.category');
console.log(aList);


for(let a of aList){
    // 이전 active 클래스 삭제
    if(fullPath != `http://localhost:8088//faq/${mappingPath}`){
        a.classList.remove('faqActive');
    }

    //현재 링크와 a태그의 링크가 동일하면 active 클래스 적용
    if(a.href == fullPath){
        a.classList.add('faqActive');
    }
}