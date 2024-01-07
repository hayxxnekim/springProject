//메뉴 보이게
document.addEventListener('DOMContentLoaded', function() {
    let menuZone = document.getElementById('menuZone');
    
    if (mlist>0) {
        menuZone.style.display = 'block';
    }
});

//파일 삭제
async function removeFileToServer(uuid){
    try{
        const url = '/store/file/'+uuid;
        const config ={
            method: 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(err){
        console.log(err);
    }
}

document.addEventListener('click',(e)=>{
    if(e.target.classList.contains('file-x')){
        removeFileToServer(e.target.dataset.uuid).then(result =>{
            if(parseInt(result)){
                e.target.closest('li').remove();
                location.reload();  
            }
        })
    }
})

//메뉴 삭제
async function removeMenuToServer(id){
    try{
        const url = '/store/menu/'+id;
        const config ={
            method: 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(err){
        console.log(err);
    }
}

document.addEventListener('click',(e)=>{
    if(e.target.classList.contains('menu-x')){
        removeMenuToServer(e.target.dataset.id).then(result =>{
            if(parseInt(result)){
                e.target.closest('li').remove();
                location.reload();  
            }
        })
    }
})