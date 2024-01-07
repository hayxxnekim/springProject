package com.avo.www;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.avo.www.domain.ProductBoardVO;
import com.avo.www.repository.StoreBoardDAO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.avo.www.config.RootConfig.class})
public class StoreBoardTest {
	@Inject
	private StoreBoardDAO sdao;
	
	@Test
	public void insertStoreBoard() {
		for(int i=0; i<16; i++) {
			ProductBoardVO pvo = new ProductBoardVO();
			pvo.setProTitle("음식점"+i);
			pvo.setProContent("Test Content");
			pvo.setProCategory("store");
			pvo.setProMenu("음식점");
			pvo.setProEmail("email");
			pvo.setProNickName("nickname");
			sdao.insert(pvo);
		}
	}
}
