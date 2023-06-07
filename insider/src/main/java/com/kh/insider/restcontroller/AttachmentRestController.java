package com.kh.insider.restcontroller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.configuration.FileUploadProperties;
import com.kh.insider.dto.AttachmentDto;
import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.MemberProfileDto;
import com.kh.insider.repo.AttachmentRepo;
import com.kh.insider.repo.BoardAttachmentRepo;
import com.kh.insider.repo.MemberProfileRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/attachment")
public class AttachmentRestController {
    //준비물
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Autowired
	private FileUploadProperties fileUploadProperties;
	
	@Autowired
	private MemberProfileRepo memberProfileRepo;
	
	@Autowired 
	private BoardAttachmentRepo boardAttachmentRepo;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
//	//업로드
//	@PostMapping("/insert")
//	public AttachmentDto upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
//		if(!attach.isEmpty()) {//파일이 있을 경우
//			//번호 생성
//			int attachmentNo = attachmentRepo.sequence();
//			
//			//파일 저장(저장 위치는 임시로 생성)
//			File target = new File(dir, String.valueOf(attachmentNo));//파일명=시퀀스
//			attach.transferTo(target);
//			
//			//DB 저장
//			attachmentRepo.insert(AttachmentDto.builder()
//							.attachmentNo(attachmentNo)
//							.attachmentName(attach.getOriginalFilename())
//							.attachmentType(attach.getContentType())
//							.attachmentSize(attach.getSize())
//						.build());
//			
//			return attachmentRepo.selectOne(attachmentNo);//DTO를 반환
//		}
//		
//		return null;//또는 예외 발생
//	}
//	
	//다운로드
	@GetMapping("/download/{attachmentNo}")
	public ResponseEntity<ByteArrayResource> download(
									@PathVariable int attachmentNo) throws IOException {
		//DB 조회
		AttachmentDto attachmentDto = attachmentRepo.selectOne(attachmentNo);
		if(attachmentDto == null) {//없으면 404
			return ResponseEntity.notFound().build();
		}
		
		//파일 찾기
		File target = new File(dir, String.valueOf(attachmentNo));
		
		//보낼 데이터 생성
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
//		제공되는 모든 상수와 명령을 동원해서 최대한 오류 없이 편하게 작성
		return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_TYPE, 
							MediaType.APPLICATION_OCTET_STREAM_VALUE)
					.contentType(MediaType.APPLICATION_OCTET_STREAM)
					.contentLength(attachmentDto.getAttachmentSize())
					.header(HttpHeaders.CONTENT_ENCODING, 
												StandardCharsets.UTF_8.name())
					.header(HttpHeaders.CONTENT_DISPOSITION,
						ContentDisposition.attachment()
									.filename(
											attachmentDto.getAttachmentName(), 
											StandardCharsets.UTF_8
									).build().toString()
					)
					.body(resource);
	}

	
	//프로필 업로드
	@PostMapping("/upload/profile")
	public int uploadProfile(@RequestParam MultipartFile attach,
			HttpSession session) throws IllegalStateException, IOException {
		int attachmentNo=0;
		long memberNo = (Long)session.getAttribute("memberNo");
		if(!attach.isEmpty()) {	//파일이 있을 경우
			attachmentNo = attachmentRepo.sequence();
			
			//파일 저장(저장 위치는 임시로 생성)
			File target = new File(dir, String.valueOf(attachmentNo));//파일명=시퀀스
			attach.transferTo(target);
			
			//DB 저장
			attachmentRepo.insert(AttachmentDto.builder()
							.attachmentNo(attachmentNo)
							.attachmentName(attach.getOriginalFilename())
							.attachmentType(attach.getContentType())
							.attachmentSize(attach.getSize())
						.build());
			
			//기존 프로필 정보 삭제
			memberProfileRepo.delete(memberNo);
			
			//프로필 사진 DB 입력
			MemberProfileDto memberProfileDto = new MemberProfileDto();
			memberProfileDto.setMemberNo(memberNo);
			memberProfileDto.setAttachmentNo(attachmentNo);
			
			memberProfileRepo.insert(memberProfileDto);
		}
		return attachmentNo;
	}
	
	//게시물 수정시 사진 삭제
	@DeleteMapping("/delete/{attachmentNo}")
	public void delete(@PathVariable int attachmentNo,
			@RequestParam int boardNo
			,Model model) {
		attachmentRepo.delete(attachmentNo);
		List<BoardAttachmentDto> findImage = boardAttachmentRepo.selectList(boardNo);
		List<Integer> imageList = new ArrayList<>();
		for(BoardAttachmentDto attDto : findImage) {
			imageList.add(attDto.getAttachmentNo());
		}
		model.addAttribute("image",imageList);
	}
	
	//비디오 
	@GetMapping("/video/{attachmentNo}")
	public ResponseEntity<InputStreamResource> video(@PathVariable int attachmentNo) throws IOException {
	    // DB 조회
	    AttachmentDto attachmentDto = attachmentRepo.selectOne(attachmentNo);
	    if (attachmentDto == null) {
	        return ResponseEntity.notFound().build();
	    }

	    // 동영상 파일 찾기
	    File target = new File(dir, String.valueOf(attachmentNo));
	    if (!target.exists()) {
	        return ResponseEntity.notFound().build();
	    }

	    // InputStreamResource 생성(동영상에서 씀)
	    InputStreamResource resource = new InputStreamResource(new FileInputStream(target));

	    // ResponseEntity 생성
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, 
						MediaType.APPLICATION_OCTET_STREAM_VALUE)
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(attachmentDto.getAttachmentSize())
				.header(HttpHeaders.CONTENT_ENCODING, 
											StandardCharsets.UTF_8.name())
				.header(HttpHeaders.CONTENT_DISPOSITION,
					ContentDisposition.attachment()
								.filename(
										attachmentDto.getAttachmentName(), 
										StandardCharsets.UTF_8
								).build().toString()
				)
				.body(resource);
	}
}
