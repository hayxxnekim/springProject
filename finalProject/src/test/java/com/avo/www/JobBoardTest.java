package com.avo.www;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.avo.www.domain.ProductBoardVO;
import com.avo.www.repository.JobBoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.avo.www.config.RootConfig.class})
public class JobBoardTest {
	
	@Inject
	private JobBoardDAO jdao;
	
	@Test
	public void insertBoard() {
		for(int i=0; i<300; i++) {
			ProductBoardVO pbvo = new ProductBoardVO();
			pbvo.setProTitle("Test Title"+i);
			pbvo.setProEmail("test"+i+"@naver.com");
			pbvo.setProNickName("tester"+(int)((Math.random()*30)+1));
			pbvo.setProContent("Test Content"+i);
			pbvo.setProPrice(i);
			pbvo.setProMenu("월급");
			jdao.post(pbvo);
		}
	}
}
