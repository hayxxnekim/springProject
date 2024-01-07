document.addEventListener('click',(e)=>{
    if(e.target.classList.contains('fileDel')){
        let uuid = e.target.dataset.uuid;

        removeFileToServer(uuid).then(result => {
            if(result == 1){
                // swal.fire("파일 삭제 성공");
                e.target.closest('div').remove(); //파일이 담긴 ul삭제
                location.reload(); //새로고침
            }else{
                // swal.fire("파일 삭제 실패");
            }
        })
    }
})

async function removeFileToServer(uuid){
    try{
        const url = '/job/file/'+uuid;
        const config = {
            method : 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

