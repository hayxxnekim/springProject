package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.ProductBoardVO;

public interface JobFileDAO {

	int insertFile(FileVO fvo);

	List<FileVO> getFileList(long proBno);

	int removeFileAll(long proBno);

	List<FileVO> allFlieList();

	FileVO getProfileImg(String proEmail);

	int removeFileOne(String uuid);

}
