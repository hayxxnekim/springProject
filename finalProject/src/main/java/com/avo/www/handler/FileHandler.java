package com.avo.www.handler;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.avo.www.domain.FileVO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Component
public class FileHandler {
   
   private String UP_DIR = "C:\\_fileupload\\";
   
   public List<FileVO> uploadFiles(MultipartFile[] files, String dir){ // dir : 게시판별 업로드 폴더명
      List<FileVO> flist = new ArrayList<FileVO>();
      
      // 날짜를 폴더로 생성하여 그날그날 업로드 파일을 관리
      LocalDate date = LocalDate.now();
      String today = date.toString();
      today = today.replace("-", File.separator);
      
      // 각 페이지 별 파일 업로드 폴더 위치 설정
      switch (dir) {
		case "product":
			UP_DIR = "C:\\_fileupload\\product";
			break;
		case "profile":
			UP_DIR = "C:\\_fileupload\\profile";
			break;
		case "community":
			UP_DIR = "C:\\_fileupload\\community";
			break;
		case "cs":
			UP_DIR = "C:\\_fileupload\\cs";
			break;
      }
      
      File folders = new File(UP_DIR, today);
      
      // 폴더 생성
      if(!folders.exists()) {
         folders.mkdirs();
      }
      
      // files 객체에 대한 설정
      for(MultipartFile file : files) {
         // 기본 ProductFileVO 생성
         FileVO fvo = new FileVO();
         fvo.setCategory(dir);
         fvo.setSaveDir(today);
         fvo.setFileSize(file.getSize());
         String originalFileName = file.getOriginalFilename();
         log.info(">>>>>>>> original >>>>> "+originalFileName);
         String fileName = originalFileName.substring(
               originalFileName.lastIndexOf(File.separator)+1);
         fvo.setFileName(fileName);
         
         UUID uuid = UUID.randomUUID();
         fvo.setUuid(uuid.toString());
         
         // 디스크에 저장할 파일 객체 생성
         String fullFileName = uuid.toString()+"_"+fileName;
         File storeFile = new File(folders, fullFileName);
         
         try {
            file.transferTo(storeFile); //저장
            
            // 이미지 파일일 경우에만 썸네일 생성
            if(isImageFile(storeFile)) {
               fvo.setFileType(1);
               
               File thumbNail = new File(folders,
                     uuid.toString()+"_th_"+fileName);
               Thumbnails.of(storeFile).size(75, 75).toFile(thumbNail);
            }
            
         } catch (Exception e) {
            log.debug(">>>>> file 생성 오류");
            e.printStackTrace();
         }
         
         // flist에 fvo 추가
         flist.add(fvo);
         
      }// for end
      
      return flist;
   }

   private boolean isImageFile(File storeFile) throws IOException {
      String mimeType = new Tika().detect(storeFile);
      return mimeType.startsWith("image")? true : false;
   }

}