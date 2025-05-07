package com.esoom.cmstest.board.controller;

import java.util.List;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cryptography.EgovEnvCryptoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class DropZoneController {
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	/** 암호화서비스 */
	private static EgovEnvCryptoService cryptoService;

	@Resource(name = "egovEnvCryptoService")
	public void setEgovEnvCryptoService(EgovEnvCryptoService cryptoService) {
		this.cryptoService = cryptoService;
	}
	
	@Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	@Value("${nas.dir}")
	public String nasRoot;
	 
	@Value("${dropzone.file.dir}")
	public String fileRoot;
	
	/*
	@RequestMapping(value = "/dropzone")
	public String dropzone() {
		log.info("/dropzone ");
		return "dropzone/upload";
    }
	*/
	 
	@ResponseBody
	@RequestMapping(value ="/dropzone/upload.do", method=RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String upload(@RequestParam("file") List<MultipartFile> files, @RequestParam("bbsId") String bbsId, @RequestParam("fileId") String fileId) throws Exception {
		//String bbsId = board.getBbsId(); 
	    String folderPath = "bbs" + bbsId.substring(bbsId.length()-3);
		
	    List<FileVO> result = null;
	    String atchFileId = "";
	    String encFileId = "";
	    //log.info(fileRoot, files);
	    int cnt = 0;
		
		if (!files.isEmpty()) {
			System.out.print(">>>>>>>>>>>>>>>>>>" + fileId);
			if (fileId == null || "".equals(fileId)) {
				result = fileUtil.parseFileInf(files, "BBS_", cnt, "", "",folderPath);
		    	atchFileId = fileMngService.insertFileInfs(result);
			} else {
				FileVO fvo = new FileVO();
			    fvo.setAtchFileId(fileId);
			    cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, fileId, "",folderPath);
			    fileMngService.updateFileInfs(_result);
			    atchFileId = fileId;
			    encFileId = cryptoService.encrypt(fileId);
			}
	    }
		
		return "{\"fileId\":\"" + atchFileId +"\", \"encFileId\":\"" + encFileId +"\", \"sn\":\"" + cnt +"\"}";
	}
	
}
