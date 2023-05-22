package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.TagDto;

public interface TagRepo {
	//신규 태그 입력
	void insert(TagDto tagDto);
	//태그를 팔로우 하는 유저 수 업데이트
	void updateFollow(TagDto tagDto);
	//tag List 및 단일조회
	List<TagDto> selectList();
	TagDto selectOne(String tagName);
}
