// 글 내용에 따라 textarea 줄 수 조정하는 함수
function adjustTextareaRows() {
    var textarea = document.getElementById('dynamicTextarea');
    
    // 글 내용에서 줄바꿈 수를 세어 변수 저장
    var lineCount = (textarea.value.match(/\n/g) || []).length + 1;

    if(lineCount < 8 && textarea.readOnly == false){
        textarea.rows = 8;
    }else{
        textarea.rows = lineCount;
    }
}

// 페이지가 로드되면 adjustTextareaRows 함수 설정
document.addEventListener('DOMContentLoaded', adjustTextareaRows);
// textarea에 글을 입력할 때도 adjustTextareaRows 함수 설정
document.getElementById('dynamicTextarea').addEventListener('input', adjustTextareaRows);