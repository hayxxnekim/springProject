<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<style>
@font-face {
    font-family: 'suit';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
   font-family: fugaz;
   src: url(../resources/font/Fugaz_One/FugazOne-Regular.ttf);
}

body {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'suit';
    position: absolute;
    padding-left: 5.5px;
}

.siteTitle{
	text-align: center;
	font-size: 50px;
	font-weight: 800;
	display: block;
	color: #323f11;;
	margin-bottom: 50px;
  	font-family: fugaz;
}

.divContainer {
 /*    width: 500px;
    height: 300px; */
    position: absolute;
}

.msg {
	font-weight: 800;
    margin-bottom: 7px;
    font-family: 'suit';
    color: #334010;
    font-size: 15px;
    width: 360px;
}

.green {
	color: #84a331;
}
.divContainer select {
    padding: 5px 20px 5px 5px;
    border: 1px solid #d3d3d3;
    border-radius: 5px;
    background: url(../resources/image/down_arrow.png) no-repeat 97.5% 50%/12px auto;
    appearance: none;
    outline: none;
    font-family: 'suit';
    font-size: 14px;
    height: 24px;
    width: 330px;
    box-sizing: content-box;
}

.btnArea{
    display: flex;
    justify-content: center;
    margin-top: 70px;
}

.btnArea a:first-child{
    margin-right: 25px;
}

.btnArea button{
    background-color: #fff;
    font-size: 16px;
    width: 100px;
    height: 55px;
    border-radius: 28px;
    cursor: pointer;
}

#closeBtn {
    border: 2px solid #84a331;
    color: #84a331;
}

#closeBtn:hover{
    background-color: #84a331;
    color: #fff;
    transition: 0.2s;
}

#deleteMemBtn:disabled {
    border: 2px solid indianred;
    color: indianred;
    cursor: default;
}

#deleteMemBtn {
    border: 2px solid indianred;
    color: indianred;
}

#deleteMemBtn:not(:disabled):hover {
    background-color: indianred;
    color: #fff;
    transition: 0.2s;
}
</style>
</head>
<body>	
<div class="divContainer">
<p class="siteTitle">Avocart</p>
	<div class="msg">
	(주)아포카트에서 <b id="msg" class="green"></b> 님의 계정이 삭제됩니다.<br>
	작성한 댓글은 자동으로 삭제되지 않으며, 복구할 수 없습니다.
	</div>
	<select name="dropMenu" id="dropMenu">
	   <option value="선택" selected style="display:none">탈퇴 사유 선택</option>
	   <option value="1">찾는 물품이 없어요</option>
	   <option value="2">물품이 안 팔려요</option>
	   <option value="3">비매너 사용자를 만났어요</option>
	   <option value="4">새 계정을 만들고 싶어요</option>
	   <option value="5">개인정보를 삭제하고 싶어요</option>
	   <option value="etc">기타</option>
    </select>

	<div class="btnArea">
		<a><button id="closeBtn">취소</button></a>
		<a><button type="button" id="deleteMemBtn" disabled="disabled">탈퇴</button></a>
	</div>
</div>
</body>
<script type="text/javascript">
//탈퇴 버튼
async function deleteMemberAndClosePopup(email) {
    try {
        const url = '/hmember/deleteMember/' + email;
        const config = {
            method: 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        console.log(result);

        if (result === '1') {
            console.log("탈퇴 성공");
            window.close();
            window.opener.location.replace('http://localhost:8088/');
            Swal.fire({
                text: "탈퇴가 성공적으로 처리되었습니다.",
                icon: "success",
                showConfirmButton: false,
                width: 400,
                timer: 1000
            });
        }
    } catch (err) {
        console.log(err);
    }
}

window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);
    const encodedEmail = urlParams.get('delEmail');
    const email = decodeURIComponent(encodedEmail);

    document.getElementById('msg').innerHTML = email;

    let categoryField = document.getElementById('dropMenu');
    let deleteMemBtn = document.getElementById('deleteMemBtn');
    
    categoryField.addEventListener('input', checkFields);

    function checkFields() {
        let category = categoryField.value;

        if (category === '선택') {
            deleteMemBtn.disabled = true;
        } else {
            deleteMemBtn.disabled = false;
        }
    }
    
    // 취소
    document.getElementById('closeBtn').addEventListener('click', () => {
        window.close();
    });
    
    // 탈퇴
/*     document.getElementById('deleteMemBtn').addEventListener('click', async () => {
        try {
            //await deleteMemberAndClosePopup(email);
        	  Swal.fire({
                  text: "탈퇴가 성공적으로 처리되었습니다.",
                  icon: "success",
                  showConfirmButton: false,
                  width: 400,
                  timer: 1000
              });
        } catch (err) {
            console.log(err);
        }
    }); */

    document.getElementById('deleteMemBtn').addEventListener('click', (e) => {
        console.log('Button clicked'); // 확인용 로그
        try {
            Swal.fire({
                text: "탈퇴가 성공적으로 처리되었습니다.",
                icon: "success",
                showConfirmButton: false,
                width: 400,
                timer: 1000
            });
        } catch (err) {
            console.log(err);
        }
    });

};
</script>
</html>