package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ReplyDto;

@Repository
public class ReplyRepoImpl implements ReplyRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ReplyDto replydto) {
		sqlSession.insert("reply.insert",replydto);
	}

	@Override
	public List<ReplyDto> selectList(int replyOrigin) {
		return sqlSession.selectList("reply.selectList", replyOrigin);
	}
	
	@Override
	public boolean delete(int replyNo) {
		return sqlSession.delete("reply.delete",replyNo) > 0;
	}
	

	@Override
	public ReplyDto selectOne(int replyNo) {
		return sqlSession.selectOne("reply.selectOne",replyNo);
	}

	@Override
	public void updateLikeCount(int count, int replyNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("count", count);
		param.put("replyNo", replyNo);
		sqlSession.update("reply.updateLikeCount",param);
	}




	
}
