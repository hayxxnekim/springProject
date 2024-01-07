package com.avo.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ProductBoardVO {
   private long proBno;
   private String proEmail;
   private String proNickName;
   private String proTitle;
   private String proContent;
   
   private String proPayment;
   private int proPrice;
   private String proCategory;
   private String proMenu;
   
   private int proLikeCnt;
   private int proReadCnt;
   private int proChatCnt;
   private int proFileCnt;
   
   private String proRegAt;
   private String proModAt;
   private String proReAt;
   
   private String proSido;
   private String proSigg;
   private String proEmd;
   
   private String proIsDel;	
   
   private String proFullAddr; //업체 주소
   private String proDetailAddr; //업체 상세 주소
}
