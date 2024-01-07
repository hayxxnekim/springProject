package com.avo.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avo.www.domain.FileVO;

public interface ProfileFileDAO {

	int proInsert(FileVO fvo);

	FileVO getProfile(String email);

	int proDelete(String email);

	List<FileVO> getProfileList(@Param("emailList") List<String> emailList);

}