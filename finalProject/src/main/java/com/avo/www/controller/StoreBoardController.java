package com.avo.www.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.avo.www.domain.FileVO;
import com.avo.www.domain.LikeItemVO;
import com.avo.www.domain.PagingVO;
import com.avo.www.domain.ProductBoardVO;
import com.avo.www.domain.StoreBoardDTO;
import com.avo.www.domain.StoreMenuVO;
import com.avo.www.handler.FileHandler;
import com.avo.www.handler.PagingHandler;
import com.avo.www.security.AuthMember;
import com.avo.www.security.MemberVO;
import com.avo.www.service.HmemberService;
import com.avo.www.service.StoreBoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/store/*")
public class StoreBoardController {
   @Inject
   private StoreBoardService ssv;
   
   @Inject 
	private HmemberService hsv;
   
   @Inject
   private FileHandler fh;
   
   @GetMapping("/register")
   public void register() {}
   
   @PostMapping("/register")
   public String register(RedirectAttributes re, ProductBoardVO pvo, StoreMenuVO svo,
         @RequestParam(name = "menus", required = false) List<String> menus,
         @RequestParam(name = "prices", required = false) List<String> prices,
         @RequestParam(name = "explains", required = false) List<String> explains,
         @RequestParam(name="files", required = false)MultipartFile[] files
         ){	     	   
      List<FileVO> flist = new ArrayList<FileVO>();

      if(files[0].getSize() > 0) {
         flist = fh.uploadFiles(files, "product");
      }
      
      //메뉴 등록
       List<StoreMenuVO> mlist = new ArrayList<>();
       if(menus != null && prices != null && explains != null) {
          for (int i = 0; i < menus.size(); i++) {
              StoreMenuVO menu = new StoreMenuVO();
              menu.setStrMenu(menus.get(i));
              menu.setStrPrice(prices.get(i));
              menu.setStrExplain(explains.get(i));
              mlist.add(menu);
          }
       }
       
        //사용자 객체 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        //Principal => AuthMember 변환
        AuthMember member = (AuthMember) authentication.getPrincipal();
        //email 추출
        String email = member.getUsername();
        
      //alert 추가하기 위한 isOk
      int isOk = ssv.insert(new StoreBoardDTO(pvo, flist, mlist), email);
      return "redirect:/store/list";
   }
   
   @GetMapping("/list")
   public void list() {}   
   
   @GetMapping({"/detail", "/modify"})
   public void detail(Model m, @RequestParam("bno")long bno, Principal principal) {      
		//끌올, 수정 , 삭제 위한 유저 체크 
		if (principal != null) {
			m.addAttribute("email", principal.getName());
		}
		String email = ssv.getEmail(bno);
		FileVO fvo = hsv.getProfile(email);
		String mainSrc = null;
		if(fvo!=null) {
			mainSrc = "/upload/profile/" + fvo.getSaveDir().replace('\\', '/') + "/" + fvo.getUuid() + "_" + fvo.getFileName();
		} else {
			mainSrc = "../resources/image/기본 프로필.png";
		}
		
      m.addAttribute("sdto", ssv.getDetail(bno));
      m.addAttribute("mainSrc", mainSrc);
   }
   
   @PostMapping("/modify")
   public String modify(RedirectAttributes re, ProductBoardVO pvo,
         @RequestParam(name = "menus", required = false) List<String> menus,
         @RequestParam(name = "prices", required = false) List<String> prices,
         @RequestParam(name = "explains", required = false) List<String> explains,
         @RequestParam(name="files", required = false)MultipartFile[] files){
	   
      List<FileVO> flist = new ArrayList<FileVO>();
      if(files[0].getSize() > 0) {
         flist = fh.uploadFiles(files, "product");
      }
      
      //기존 메뉴 삭제
      long bno = pvo.getProBno();
      int isOk = ssv.removeBeforeMenu(bno);
            
      //메뉴 등록
       List<StoreMenuVO> mlist = new ArrayList<>();
       if(menus != null && prices != null && explains != null) {
          for (int i = 0; i < menus.size(); i++) {
              StoreMenuVO menu = new StoreMenuVO();
              menu.setStrMenu(menus.get(i));
              menu.setStrPrice(prices.get(i));
              menu.setStrExplain(explains.get(i));
              mlist.add(menu);
          }
       }
       
       //사용자 객체 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        //Principal => AuthMember 변환
        AuthMember member = (AuthMember) authentication.getPrincipal();
        //email 추출
        String email = member.getUsername();
        
      isOk = ssv.modify(new StoreBoardDTO(pvo,flist, mlist), email);   
      re.addAttribute("bno", pvo.getProBno());
      return "redirect:/store/detail"; 
   }
   
   @GetMapping("/remove")
   public String remove(RedirectAttributes re, @RequestParam("bno")long bno) {
      int isDel = ssv.remove(bno);
      return "redirect:/store/list";   
   }
   
   @GetMapping(value = "/page/{page}/{type}/{sort}", produces = MediaType.APPLICATION_JSON_VALUE)
   public ResponseEntity<PagingHandler> spread(@PathVariable("page") int page, 
         @PathVariable("type") String type,
         @PathVariable("sort") String sort
         ){
      PagingVO pgvo = new PagingVO(page, 8, type);
      pgvo.setSorted(sort);
      return new ResponseEntity<PagingHandler>(
            ssv.getList(pgvo), HttpStatus.OK);
   }
   
   @GetMapping("/repost")
   public String repost(RedirectAttributes re, @RequestParam("bno")long bno) {
      int isOk = ssv.repost(bno);
      return "redirect:/store/list";   
   }
   
   @DeleteMapping(value="/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
   public ResponseEntity<String> removeFile(@PathVariable("uuid")String uuid){
      return ssv.removeFile(uuid) > 0? 
         new ResponseEntity<String>("1", HttpStatus.OK)
          : new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   @DeleteMapping(value="/menu/{id}", produces = MediaType.TEXT_PLAIN_VALUE)
   public ResponseEntity<String> removeMenu(@PathVariable("id")long id){
      return ssv.removeMenu(id) > 0? 
         new ResponseEntity<String>("1", HttpStatus.OK)
          : new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
   }
   
   @GetMapping(value="/checkLike/{user}/{bno}")
   public ResponseEntity<String> checkLike(@PathVariable("user") String user, @PathVariable("bno") long bno) {
       int isLiked = ssv.checkLike(user, bno);
       return ResponseEntity.ok(isLiked > 0 ? "1" : "0");
   }

   @PostMapping(value="/updateLike", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
   public ResponseEntity<String> updateLike(@RequestBody LikeItemVO lvo){
      int updateLike = ssv.updateLike(lvo);
      return updateLike > 0? new ResponseEntity<String>(String.valueOf(updateLike), HttpStatus.OK) :
          new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);   
   }
   
}