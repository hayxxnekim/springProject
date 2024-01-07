package com.avo.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FileVO {

   private String uuid;
   private long bno;
   private String saveDir;
   private String fileName;
   private int fileType;
   private long fileSize;
   private String regAt;
   private String category;
   private String prEmail;
}