package com.kh.insider.restcontroller;

import java.util.List;
import java.util.concurrent.CompletableFuture;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.DmUserDto;
import com.kh.insider.repo.DmMemberInfoRepo;
import com.kh.insider.repo.DmUserRepo;
import com.kh.insider.service.NoticeService;
import com.kh.insider.service.NoticeServiceImpl;
import com.kh.insider.vo.NoticeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/notice")
public class NoticeRestController {

	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private NoticeServiceImpl noticeServiceImpl;
	
	@Autowired
	private DmMemberInfoRepo dmMemberInfoRepo;
	
	
	@GetMapping("/")
	public List<NoticeVO> selectList(
									HttpSession session){
		Long memberNo = (Long) session.getAttribute("memberNo");
//	    List<NoticeVO> noticeList = noticeService.selectNotice(memberNo);
	    //log.debug("notice목록: {}", noticeList);
//		SseEmitter emitter = new SseEmitter();
//
//		// Start a new thread to fetch the notice list and send updates to the client
//		CompletableFuture.runAsync(() -> {
//			try {
//				List<NoticeVO> noticeList = noticeService.selectNotice(memberNo);
//				// Send the initial notice list to the client
//				emitter.send(noticeList);
//
//				while (true) {
//					
//					List<NoticeVO> updates = noticeService.fetchUpdates(memberNo);
//					if (!updates.isEmpty()) {
//						emitter.send(updates);
//					}
//
//					Thread.sleep(5000);
//				}
//			} catch (Exception e) {
//				emitter.completeWithError(e);
//			}
//		});
//
//		emitter.onCompletion(() -> noticeService.cleanup(memberNo));
//
//		return emitter;
//	}
	    
		return noticeService.selectNotice(memberNo);
	}

	@PutMapping("/check")
	public void checkAlarm(
							HttpSession session) {
		Long memberNo = (Long)session.getAttribute("memberNo");
		noticeService.check(memberNo);
	}
	
	//dm 읽지 않은 메세지 수 알림
	@GetMapping("/isChat")
	public Integer isChat(HttpSession session) {
		Long memberNo = (Long)session.getAttribute("memberNo");
		Integer totalUnreadNum = dmMemberInfoRepo.getUnreadMessages(memberNo);
		return totalUnreadNum;
	}

	
}