
document.addEventListener('click',(e)=>{
    // tabMenu li 요소 가져오기
    let liList = document.querySelectorAll('.tabArea .tabMenu li');
    console.log(liList);

    // liList에서 클릭한 li의 index 번호 저장
    let index = Array.from(liList).indexOf(e.target.parentNode);
    console.log(index);

    // liList 요소를 클릭했다면 if문 실행
    if(index != -1){
        for(let li of liList){
            // 이전 active 클래스 삭제
            li.classList.remove('active');

            if(e.target.parentNode == li){
                console.log('메뉴 클릭');
                // 클릭한 메뉴에 active 클래스 추가
                e.target.parentNode.classList.add('active');
            }
        }

        let contentDiv = document.querySelectorAll('.tabArea .tabContents > div');

        for(let div of contentDiv){
            // 이전 on 클래스 삭제
            div.classList.remove('on');
        }
        contentDiv[index].classList.add('on');
    }

})
