console.log("boardRegister.js connect");
//주소입력창 클릭시 카카오주소 연결
document.getElementById('proFullAddr').addEventListener('click', ()=>{
    new daum.Postcode({
        oncomplete: function(data) { //선택시 입력값 세팅
            console.log(data);
   
            //db에 넣을 주소값 설정
            document.getElementById('proSido').value = data.sido;
            document.getElementById('proSigg').value = data.sigungu;
            document.getElementById('proEmd').value = data.bname;
            document.getElementById('proFullAddr').value = data.address;
        }
    }).open();
   })


// 트리거 버튼 클릭 시 file 업로드 실행
document.getElementById('trigger').addEventListener('click', () => {
    document.getElementById('files').click();
});

// 이미지 파일만 가능한 정규표현식 작성
const regExpImg = /\.(jpg|jpeg|png)$/; // 이미지 파일만 
const maxSize = 1024 * 1024 * 20; // 파일 최대 크기

function fileValidation(fileName, fileSize) {
    return regExpImg.test(fileName) && fileSize < maxSize ? 1 : 0;
}

document.addEventListener('change', (e) => {
    console.log("change >> e.target", e.target);
    if (e.target.id === 'files') {
        // 파일을 다시 추가할 때는 버튼 상태를 원래대로 변경
        document.getElementById('regBtn').disabled = false;

        // input file element에 저장된 file의 정보를 가져오는 property 
        const fileObj = document.getElementById('files').files;
        console.log(fileObj);

        // 첨부파일에 대한 정보를 fileZone에 기록
        let div = document.getElementById('fileZone');

        // 기존 값이 있다면 삭제
        div.innerHTML = "";

        let isOk = 1; // 여러 파일이 모두 검증에 통과해야 하기 때문에 * 로 각 파일마다 통과여부 확인
        let ul = `<ul class="list-group list-group-flush">`;
        for (let file of fileObj) {
            let validResult = fileValidation(file.name, file.size); // 0 또는 1로 리턴
            isOk *= validResult;
            const imageUrl = URL.createObjectURL(file); // 파일 미리보기를 위한 URL 생성
            ul += `<li class="list-group-item d-flex justify-content-between align-items-center">`;
            ul += `<div class="img">`;
            ul += `<img alt="첨부이미지영역" src="${imageUrl}" style="max-width: 75px; max-height: 75px;">`;
            ul += `</div>`;
            ul += `${file.name}</div>`;
            ul += `<span class="${validResult ? 'imgOk' : 'imgNo'}">${validResult ? '가능' : '불가능'}</span></div>`;
            ul += `<button type="button" class="imageCancelBtn" data-filename="${file.name}">X</button></li>`;
        }
        ul += `</ul>`;
        div.innerHTML = ul;

        if (isOk === 0) {
            document.getElementById('regBtn').disabled = true;
        }
    }
    
});

document.addEventListener('click', (e) => {
    const fileInput = document.getElementById('files');
    const fileObj = fileInput.files;
    let fileObjLength = fileObj.length;
    console.log(" fileObjLength >> " , fileObjLength)

    // 삭제버튼 눌렀을 때
    if (e.target.classList.contains('imageCancelBtn')) {
        const filename = e.target.dataset.filename;

        if (filename) {
            const liToRemove = e.target.closest('li');
            liToRemove.remove();
            fileObjLength--;
            console.log(" liToRemove >> " , liToRemove)
            console.log(" 삭제 후 fileObjLength >> " , fileObjLength)

            // 새로운 FileList 생성
            const newFileList = createFileListWithoutFileName(fileObj, filename);
            console.log("newFileList >> " , newFileList);

            // 새로운 FileList를 input에 설정
            fileInput.files = newFileList;
            if(newFileList.length <= 0){
                newFileList.remove();
            }
        }

        if (fileObjLength == 0) {
            document.getElementById('fileZone').style = "display:none";
        }
    }
});

function createFileListWithoutFileName(fileList, fileNameToRemove) {
    const newFiles = [];

    for (let i = 0; i < fileList.length; i++) {
        if (fileList[i].name !== fileNameToRemove) {
            newFiles.push(fileList[i]);
        }
    }
    console.log(newFiles);
    // 새로운 FileList 생성
    let newFileList = new DataTransfer();

    for (let file of newFiles) {
        newFileList.items.add(file);
    }
    console.log("newfileList>>"+newFileList.files);
    return newFileList.files;
}



// 파일제외 모든 항목에 input 발생시 regBtn 활성화 및 class 변경
//각 항목 변수
const regBtn = document.getElementById('regBtn');
const proTitle = document.getElementById('proTitle');
const proMenu = document.getElementById('proMenu');
const proPayment = document.getElementById('proPayment');
const proPrice = document.getElementById('proPrice');
const proFullAddr = document.getElementById('proFullAddr');
const proContent = document.getElementById('proContent');
const attention = document.getElementById('attention');

regBtn.disabled = true;

proTitle.addEventListener('input', checkFields);
proMenu.addEventListener('input', checkFields);
proPayment.addEventListener('input', checkFields);
proPrice.addEventListener('input', checkFields);
proFullAddr.addEventListener('input', checkFields);
proContent.addEventListener('input', checkFields);

function checkFields() {
    const proTitleValue = proTitle.value;
    const proMenuValue = proMenu.value;
    const proPaymentValue = proPayment.value;
    const proPriceValue = proPrice.value;
    const proFullAddrValue = proFullAddr.value;
    const proContentValue = proContent.value;

    console.log("proTitleValue >> " + proTitleValue + " / proMenuValue >> " + proMenuValue + " / proPaymentValue >> " + proPaymentValue + " / proPriceValue >> " + proPriceValue + " / proFullAddrValue >> " + proFullAddrValue + " / proContentValue >> " + proContentValue)

    if (proTitleValue.trim() === '' || proMenuValue === '선택' ||proPaymentValue === '선택' || proPriceValue.trim() === '' || proFullAddrValue.trim() === '' || proContentValue.trim() === '') {
        regBtn.disabled = true;
        // attention.innerHTML="※ 빈 칸을 작성해주세요.";
    } else {
        regBtn.disabled = false;
        // attention.innerHTML= '<br>';
    }

}

