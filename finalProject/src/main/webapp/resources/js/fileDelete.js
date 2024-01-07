url = window.location.pathname;
category = url.substring(url.indexOf('/')+1,url.lastIndexOf('/'));

document.addEventListener('click', (e)=>{
    console.log(e.target);
    if(e.target.classList.contains('btn-close')){
        console.log("삭제 버튼 클릭");
        let uuid = e.target.dataset.uuid;
        deleteFileToServer(category, uuid).then(result => {
            if(result == 1){
                alert("삭제성공");
                e.target.closest('li').remove();
            }else{
                alert("실패");
            }
        })
    }
})

async function deleteFileToServer(category, uuid){
    try {
        url = '/'+category+'/file/'+uuid;
        config = {
            method : 'delete'
        };

        let resp = await fetch(url, config);
        let result = await resp.text();
        return result;
        
    } catch (error) {
        console.log(error);
    }
}
