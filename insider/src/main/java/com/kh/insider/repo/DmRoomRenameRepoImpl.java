package com.kh.insider.repo;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmRoomRenameDto;

@Repository
public class DmRoomRenameRepoImpl implements DmRoomRenameRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("dmRoomRename.sequence");
	}

	@Override
	public void RenameInsert(DmRoomRenameDto dmRoomRenameDto) {
		sqlSession.insert("dmRoomRename.RenameInsert", dmRoomRenameDto);
	}

	@Override
	public void updateRoomRename(DmRoomRenameDto dmRoomRenameDto) {
		sqlSession.update("dmRoomRename.updateRoomRename", dmRoomRenameDto);
	}

	@Override
	public boolean existsByRoomNo(int roomNo) {
		return sqlSession.selectOne("dmRoomRename.existsByRoomNo", roomNo);
	}

	@Override
	public void deleteRename(int roomNo, long memberNo) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("roomNo", roomNo);
	    params.put("memberNo", memberNo);
	    sqlSession.delete("dmRoomRename.deleteRename", params);
	}

}
