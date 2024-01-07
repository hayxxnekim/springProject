package com.avo.www.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingVO {
	private int pageNo; // 페이지 번호
	private int qty; // 한 페이지에 보여줄 글 개수
	private String keyword; // 검색어
	private String type; // 카테고리 타입
	private String srcCondit; // 검색조건 ex)제목,내용,작성자 등
	private String sorted; // 정렬 ex) 최신순, 오래된 순
	
	public PagingVO() {
		this(1,8); // 한 페이지당 글 8개씩 출력
	}
	
	public PagingVO(int pageNo, int qty) {
		this.pageNo = pageNo;
		this.qty = qty;
	}
	
	public PagingVO(int pageNo, int qty, String type) {
		this.pageNo = pageNo;
		this.qty = qty;
		this.type = type;
	}
	
	// limit getPageStart, qty
	public int getPageStart() {
		return (this.pageNo-1)*qty;
	}
	
	public String[] getConditToArray() {
		return this.srcCondit == null ? new String[] {} : this.srcCondit.split(",");
	}
	
	// faq 검색용
	public String[] getTypeToArray() {
		return this.type == null ? new String[] {} : this.type.split("");
	}
}
