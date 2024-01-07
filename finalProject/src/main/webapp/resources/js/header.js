// 현재 경로 가져오기
let path = window.location.pathname;
console.log("path : "+path);
let activePath = path.substring(path.indexOf('/')+1,path.lastIndexOf('/'));
console.log("activePath : "+activePath);
if(activePath == 'cs'){
    activePath = 'faq';
}

// nav의 li 요소 가져오기
let liList = document.querySelectorAll('nav ul li');

for(let li of liList){
    // 이전 active 클래스 삭제
    li.classList.remove('active');

    // 현재 링크에 특정 path가 포함되면 active 클래스 적용
    switch (activePath){
        case '':
            break;
        case '/':
            break;
        case 'member':
            activePath = path.substring(path.lastIndexOf('/'));
        default:
            if(li.firstChild.href.includes(activePath))
                li.classList.add('active');
            break;
    }
}

//프로필 버튼 클릭시 메뉴 나타나게(토글)
document.addEventListener('click',(e)=>{
    if(e.target.classList.contains('my')){
        let myMenu = document.getElementById('myMenu');
        if(myMenu != null){
            document.getElementById('myMenu').classList.toggle('off');
        }else{
            //로그인 안 했을 시 누르면 로그인 화면으로 넘어가도록
            window.location.href = '/member/login';
        }
    }else{
        document.getElementById('myMenu').classList.add('off');
    }
})

// 검색
// 검색어를 입력할 때
document.getElementById('searchInput').addEventListener('input',(e)=>{
    // 검색어가 openMenu 창의 input에도 들어가도록 설정
    let keyword = document.getElementById('searchInput').value;
    console.log(keyword);
    document.getElementById('keyword').value = keyword;
    document.querySelector('.deleteInputText').classList.remove('deleteIconOff');
    if(keyword == null || keyword == ''){
        document.querySelector('.deleteInputText').classList.add('deleteIconOff');
    }
})

//검색창 클릭시 검색메뉴 나오고, 그외 화면 아무데나 클릭시 사라짐
document.addEventListener('click',(e)=>{
    console.log("target >>"+e.target);
    if(e.target.id == 'searchInput' || e.target.id == 'keyword' || e.target.closest('.searchLabel')){
        document.getElementById('searchMenu').classList.remove('off');
    }else{
        document.getElementById('searchMenu').classList.add('off');
    }
})

document.getElementById('textCancelBtn').addEventListener('click', ()=>{
    document.getElementById('searchInput').value = '';
    document.getElementById('keyword').value = '';
    document.querySelector('.deleteInputText').classList.add('deleteIconOff');
})


// 검색 조건 가져오기
function getSearchCondition(){
    // 선택된 목록 가져오기
    const query = "input[name='srcCondit']:checked";
    const sltSearch = document.querySelectorAll(query);

    // 선택된 목록에서 value 찾기
    let result = '';
    sltSearch.forEach((e)=>{
        result += e.value + ',';
    });
    result = result.slice(0,-1);

    // 확인
    console.log(result);
    return result;
}


// document.getElementById('checkCondit').addEventListener('click',()=>{
//     getSearchCondition();
// })


//로그아웃
document.getElementById('logoutLink').addEventListener('click', (e)=>{
   e.preventDefault(); //기존에 있던 이벤트를 없애는 형태
   document.getElementById('logoutForm').submit();
})