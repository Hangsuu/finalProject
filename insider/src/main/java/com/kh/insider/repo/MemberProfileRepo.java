package com.kh.insider.repo;

import com.kh.insider.dto.MemberProfileDto;

public interface MemberProfileRepo {
	void insert(MemberProfileDto memberProfileDto);
	void delete(long memberNo);
	
	//멤버 프로필
	Integer selectAttachNo(long memberNo);
}
