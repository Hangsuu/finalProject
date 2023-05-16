package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.SearchDto;

@Repository
public class SearchRepoImpl implements SearchRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SearchDto> selectList(String searchInput) {
		return sqlSession.selectList("search.selectList", searchInput);
	}

}
