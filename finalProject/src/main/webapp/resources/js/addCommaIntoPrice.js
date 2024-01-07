// 가격 input에 컴마 붙이기
const input = document.getElementById('price');
// 가격을 입력할 때마다 함수 실행
input.addEventListener('keyup', (e) => {
  let priceValue = e.target.value;
  // value값에 컴마가 붙어있다면 전부 빼서 number값으로 변경
  priceValue = Number(priceValue.replaceAll(',', ''));
  
  // 범위 외 값 처리
  if(isNaN(priceValue)){
    input.value = 0;
  }else if(priceValue < 0) {
	priceValue *= -1;
	input.value = priceValue;
  }else{
    const formatValue = priceValue.toLocaleString('ko-KR');
    input.value = formatValue;
  }
  
  // 숫자로 변경된 가격 값을 numPrice input에 세팅
  let numPrice = document.getElementById('numPrice');
  numPrice.value = priceValue;
})