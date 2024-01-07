package com.avo.www.repository;

import java.util.List;

import com.avo.www.domain.StoreMenuVO;

public interface StoreMenuDAO {

	int insertMenu(StoreMenuVO svo);

	List<StoreMenuVO> getMenuList(long bno);

	int removeMenu(long id);

	int removeMenuAll(long bno);

}
