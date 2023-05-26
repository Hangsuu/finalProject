package com.kh.insider.service;

import java.util.List;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.vo.AlarmVO;

public interface AlarmService {

	List<AlarmVO> selectAlarm(Long memberNo);
	void check(long memeberNo);
	int isInsider(long memberNo);
	int isChat(long memberNo);
}