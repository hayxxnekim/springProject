let url = window.location.pathname;
let category = url.substring(url.indexOf('/')+1,url.lastIndexOf('/'));

// 트리거 버튼 누르면 파일 업로드 시작
document.getElementById('trigger').addEventListener('click',()=>{
    document.getElementById('files').click();
})

// 실행파일, 이미지 파일에 대한 정규 표현식
const regExp = new RegExp("\.(exe|sh|bat|js|msi|dll)$"); // 실행파일
const regExpImg = new RegExp("\.(jpg|jpeg|png|gif)$"); // 이미지파일
const maxSize = 1024*1024*20; // 파일 최대 사이즈 20MB

function fileValidation(fileName, fileSize){
    if(!regExpImg.test(fileName)){
        return 0;
    }else if(regExp.test(fileName)){
        return 0;
    }else if(fileSize > maxSize){
        return 0;
    }else{
        return 1;
    }
}

// async function insertFileToServer(category, file){
//     try {
//         let path = "/"+category+"/"+file;
//         let config = {
//             method : "post",
//             headers : {
//                 "content-type" : "application/json; charset=UTF-8"
//             },
//             body : JSON.stringify(file)
//         };

//         const resp = await fetch(path, config);
//         const result = await resp.text();
//         return result;
//     } catch (error) {
//         console.log(error);
//     }
// }

// 파일을 업로드했을 경우
document.addEventListener('change', (e) => {
    if (e.target.id == 'files') {
        document.getElementById('fileZone').style = "display:block";
        document.getElementById('fileForm').style = "margin-bottom:0px";
        //파일을 다시 추가할 때는 버튼 상태를 원래대로 변경. true가 된 애를 다시 열어주기 위해
        document.getElementById('regBtn').disabled = false;
        //input file element에 저장된 file의 정보를 가져오는 property
        const fileObj = document.getElementById('files').files;
        console.log(fileObj);

        //첨부파일에 대한 정보를 fileZone에 기록
        let div = document.getElementById('fileZone');
        //기존 값이 있다면 삭제
        div.innerHTML = "";

        let isOk = 1; //여러 파일이 모두 검증에 통과해야 하기 때문에
                      //*로 각 파일마다 통과여부 확인
        let ul = `<ul class="imageUl">`;

        //비동기 로딩 처리를 위한 Promise 배열 생성
        const promises = [];

        for (let i = 0; i < fileObj.length; i++) {
            let file = fileObj[i];
            let validResult = fileValidation(file.name, file.size);
            isOk *= validResult;

            //Promise를 생성하고 배열에 추가
            const promise = new Promise((resolve) => {
                var reader = new FileReader();
                reader.onload = function (e) {
                    ul += `<li class="imageLi ${i === fileObj.length - 1 ? 'last-file' : ''}" id="${file.name}">`;
                    ul += `<div class="oneImg">`; // 마지막 파일일 때 클래스 추가
                    ul += `<img src="${e.target.result}" alt="preview" style="width: 50px; height: 50px; margin-right: 10px;">`; // 미리보기 이미지
                    ul += `${file.name} `;
                    ul += `<span class="${validResult ? 'imgOk' : 'imgNo'}"> ${validResult ? '가능' : '불가능'}</span></div>
                            <button class="imageCancelBtn" data-filename="${file.name}">X</button></li>`;
                    resolve();
                };
                reader.readAsDataURL(file);
            });
            promises.push(promise);
        }
        
        //모든 Promise가 완료될 때까지 대기 후 ul 조작
        Promise.all(promises).then(() => {
            ul += `</ul>`;
            div.innerHTML = ul;

            if (isOk == 0) { //첨부 불가능한 파일이 있다면
                document.getElementById('regBtn').disabled = true;
            }
            checkFormBlank();
        });
    }
});


//파일 삭제버튼 메서드
document.addEventListener('click', (e) => {
    const fileInput = document.getElementById('files');
    const fileObj = fileInput.files;
    let fileObjLength = fileObj.length;

    if (e.target.classList.contains('imageCancelBtn')) {
        const filename = e.target.dataset.filename;
        const liToRemove = document.getElementById(filename);
        
        if (liToRemove) {
            fileObjLength--;
            liToRemove.remove();
    
            // 새로운 FileList 생성
            const newFileList = createFileListWithoutFileName(fileObj, filename);
    
            // 새로운 FileList를 input에 설정
            fileInput.files = newFileList;
        }
    
        console.log(fileObjLength);
    
        if (fileObjLength == 0) {
            document.getElementById('fileZone').style = "display:none";
            document.getElementById('fileForm').style = "margin-bottom:30px";
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
    const newFileList = new DataTransfer();
    
    for (const file of newFiles) {
        newFileList.items.add(file);
    }
    
    return newFileList.files;
}

/*
<ul class="list-group">
  <li class="list-group-item">An item</li>
</ul>

*/