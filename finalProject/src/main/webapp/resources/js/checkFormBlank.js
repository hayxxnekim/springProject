let title = document.getElementById('title');
let price = document.getElementById('price');
let menu = document.getElementById('menu');
let dynamicTextarea = document.getElementById('dynamicTextarea');
let addr = document.getElementById('proFullAddr');
let form = document.querySelector('.bodyContainer form');
let regBtn = document.getElementById('regBtn');

// 글을 작성하지 않은 상태에서 버튼 막기
regBtn.disabled = true;

// form에 변경사항이 있다면 코드 실행
form.addEventListener('input',()=>{
	checkFormBlank();
})
form.addEventListener('change',()=>{
	checkFormBlank();
})

function checkFormBlank(){
	let selectedMenu = menu.options[menu.selectedIndex].value
	
	// 필수 요소를 작성하지 않았을 경우에만 버튼 막기
    if(title.value.trim() == "" || price.value == "" || selectedMenu == "선택" || dynamicTextarea.value.trim() == "" || addr.value == ""){
        regBtn.disabled = true;
    }else{
        regBtn.disabled = false;
    }
}