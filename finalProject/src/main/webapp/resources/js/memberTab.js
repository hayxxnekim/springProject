let memEmail = window.location.search;
memEmail = memEmail.substring(memEmail.indexOf("=")+1);
console.log(memEmail);


// DB에서 판매상품 가져오는 함수
async function getSellListFromServer(memEmail){
    try {
        const resp = await fetch('/hmember/sell/'+memEmail);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// DB에서 구매내역 가져오는 함수
async function getBuyListFromServer(memEmail){
    try {
        const resp = await fetch('/hmember/buy/'+memEmail);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

            // <div class="oneList">
	    	// 	<img alt="" src="../resources/image/기본 프로필 배경.png">
	    	// 	<h3>물건이름</h3>
	    	// 	<b>가격</b>
	    	// 	<small>날짜</small>
	    	// 	<mark><i class="bi bi-geo-alt"></i>장소</mark>
	    	// </div>

getSellList(memEmail);
getBuyList(memEmail);

function getSellList(memEmail){
    getSellListFromServer(memEmail).then(result => {
        let sellListDiv = document.getElementById('sellList');
        if(result.length > 0){
            let sellList = "";
            for(let r of result){
                let price = r.pbvo.proPrice.toLocaleString('ko-KR');
                let upDate = r.pbvo.proReAt.substring(0,10);
                sellList += `<div class="oneList"><a href="/joongo/detail?proBno=${r.pbvo.proBno}">`;
                if(r.pflist.length > 0){
                    console.log(r.pflist[0].saveDir);
                    sellList += `<img alt="" src="/upload/product/${r.pflist[0].saveDir.replaceAll('\\','/')}/${r.pflist[0].uuid}_${r.pflist[0].fileName}">`;
                }else{
                    sellList += `<img alt="" src="../resources/image/defaultImage.jpg">`;
                }
                sellList += `<div class="contentWrap"><h3>${r.pbvo.proTitle}</h3><b>${price}원<small>${upDate}</small></b>`;
                sellList += `</div><mark><i class="bi bi-geo-alt"></i>${r.pbvo.proFullAddr}</mark></a></div>`;
            }
            sellListDiv.innerHTML = sellList;
        }else{
            sellListDiv.innerHTML = "<p>목록이 비어있습니다.</p>";
        }
    })
}

function getBuyList(memEmail){
    getBuyListFromServer(memEmail).then(result => {
        let buyListDiv = document.getElementById('buyList');
        if(result.length > 0){
            let buyList = "";
            for(let r of result){
                let price = r.bivo.buyPrice.toLocaleString('ko-KR');
                let upDate = r.bivo.buyDate.substring(0,10);
                buyList += `<div class="oneList">`;
                if(r.pflist.length > 0){
                    console.log(r.pflist[0].saveDir);
                    buyList += `<img alt="" src="/upload/product/${r.pflist[0].saveDir.replaceAll('\\','/')}/${r.pflist[0].uuid}_${r.pflist[0].fileName}">`;
                }else{
                    buyList += `<img alt="" src="../resources/image/defaultImage.jpg">`;
                }
                buyList += `<div class="contentWrap"><h3>${r.bivo.buyProTitle}</h3><b>${price}원<small>${upDate}</small></b>`;
                buyList += `</div><mark><i class="bi bi-geo-alt"></i>${r.bivo.buyFullAddr}</mark></div>`;
            }
            buyListDiv.innerHTML = buyList;
        }else{
            buyListDiv.innerHTML = "<p>목록이 비어있습니다.</p>";
        }
    })
}