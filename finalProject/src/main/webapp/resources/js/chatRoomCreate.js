async function insertChatRoomForServer(chatRoomData){
    try {
        let url = '/common/chating';
        let config = {
            method : 'post',
            headers : {
                'content-type' : 'application/json; charset=UTF-8'
            },
            body : JSON.stringify(chatRoomData)
        }
        const resp = await fetch(url,config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.getElementById('chatRoomBtn').addEventListener('click',()=>{
    // 채팅룸 만들기
    chatRoomData = {
        chatBno : bnoVal,
        chatSendUserId : userEmail,
        chatGetUserId : writerEmail
    }
    insertChatRoomForServer(chatRoomData);

    // 링크 이동
    location.href = "/common/chating";
})