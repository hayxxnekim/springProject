package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.FileVO;

public interface CSFileDAO {

	int insertFile(FileVO fvo);

	List<FileVO> getFileList(long csBno);

}
