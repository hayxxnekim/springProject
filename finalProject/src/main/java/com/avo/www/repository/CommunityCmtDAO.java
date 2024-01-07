package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.CommunityCmtVO;
import com.avo.www.domain.PagingVO;

public interface CommunityCmtDAO {

	int insert(CommunityCmtVO cvo);

	List<CommunityCmtVO> getList(long cmtBno);

	int update(CommunityCmtVO cvo);

	int selectOneBnoTotalCount(long cmtBno);

	//List<CommunityCmtVO> getListPaging(@Param("cmtBno")long cmtBno, @Param("pgvo")PagingVO pgvo);

	int boardCmtDelete(long cmBno);

	int updateIsDel(long cmtCno);

	int updateReCnt(long reCmtCno);

	int afterDelUpdateReCnt(long reCmtCno);


}
