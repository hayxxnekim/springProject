package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.FileVO;

public interface ProductFileDAO {

	int insertFile(FileVO fvo);

	List<FileVO> getFileList(long bno);

	int deleteFile(String uuid);

	void deleteAllFile(long bno);

}
