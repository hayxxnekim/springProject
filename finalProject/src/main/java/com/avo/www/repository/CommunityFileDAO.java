package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.FileVO;

public interface CommunityFileDAO {

	int insertFile(FileVO fvo);

	List<FileVO> getFileList(long cmBno);

	int deleteFile(String uuid);

	List<FileVO> getAllFileList();

	int boardFileCount(long cmBno);

	int deleteAll(long cmBno);

	FileVO getProfile(String cmEmail);

}
