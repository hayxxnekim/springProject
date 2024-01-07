package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.FileVO;

public interface StoreFileDAO {

	int insertFile(FileVO fvo);

	List<FileVO> getFileList(long bno);

	int removeFile(String uuid);

	int removeFileAll(long bno);

	List<FileVO> getAllFileList(@Param("bnoList") List<Long> bnoList);

}
