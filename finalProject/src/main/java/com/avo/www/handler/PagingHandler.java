package com.avo.www.handler;

import java.util.List;

import com.avo.www.domain.CommunityBoardVO;
import com.avo.www.domain.CommunityCmtVO;
import com.avo.www.domain.CommunityReCmtVO;
import com.avo.www.domain.FileVO;
import com.avo.www.domain.JobBoardDTO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.domain.ReviewVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingHandler {

   private int startPage;
   private int endPage;
   private int realEndPage;
   
   private int totalCount;
   private PagingVO pgvo;
   
   private List<ProductBoardVO> prodList;
   private List<CommunityCmtVO> cmtList;
   private List<CommunityReCmtVO> reCmtList;
   private List<CommunityBoardVO> cmList;
   
   private List<FileVO> prodFileList;
   private List<Integer> reviewCntList;

   //23.12.06 미수 추가 리뷰 페이징용
   private List<ReviewVO> jobReList;
   
   // 23.12.22 미수 추가 like 페이징용
   private List<LikeItemVO> likeList;
   
   public PagingHandler(PagingVO pgvo, int totalCount, int minus) {
      
      this.pgvo = pgvo;
      this.totalCount = totalCount;
      
      this.endPage = 
            (int)Math.ceil(pgvo.getPageNo() / (double)pgvo.getQty()) * pgvo.getQty();
     this.startPage = endPage - minus;
     
     this.realEndPage = (int)Math.ceil(totalCount / (double)pgvo.getQty());
     if(this.realEndPage < this.endPage) {
         this.endPage = this.realEndPage;
      }
     
     
   }
   
   // 게시글 페이징용
   public PagingHandler(PagingVO pgvo, int totalCount, List<ProductBoardVO> prodList) {
      this(pgvo, totalCount, 7);
      this.prodList = prodList;
   }
   
   //댓글 페이징용
   public PagingHandler(int totalCount, PagingVO pgvo, List<CommunityCmtVO> cmtList, List<CommunityReCmtVO> reCmtList) {
      this(pgvo, totalCount, 9);
      this.cmtList = cmtList;
      this.reCmtList = reCmtList;
   }
   
   //업체 페이징용
   public PagingHandler(PagingVO pgvo, int totalCount, List<ProductBoardVO> prodList, List<FileVO> prodFileList, List<Integer> reviewCntList) {
         this(pgvo, totalCount, 9);
         this.prodList = prodList;
         this.prodFileList =  prodFileList;
         this.reviewCntList = reviewCntList;
      }
   
   //커뮤니티 페이징용
   public PagingHandler(int totalCount, PagingVO pgvo, List<CommunityBoardVO> cmList) {
	      this(pgvo, totalCount, 9);
	      this.cmList = cmList;
	}

   // 23.12.06 미수 추가 리뷰 페이징용
   public PagingHandler(PagingVO pgvo, List<ReviewVO> jobReList, int totalCount) {
	    this(pgvo, totalCount, 5);
	    this.jobReList = jobReList;
	}
   
   public PagingHandler(PagingVO pgvo, int totalCount, List<CommunityBoardVO> cmList, int minus) {
	   this(pgvo, totalCount, minus);
	   this.cmList = cmList;
   }
   
   // 23.12.22 미수 추가 like 페이징용
   public PagingHandler(PagingVO pgvo, int totalCount, int i, List<LikeItemVO> likeList) {
	   this(pgvo, totalCount, i);
	   this.likeList = likeList;
	   
   }

}