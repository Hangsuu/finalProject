package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.BoardWithNickDto;
import com.kh.insider.vo.AdminBoardSearchVO;
import com.kh.insider.vo.BoardListVO;
import com.kh.insider.vo.BoardSearchVO;
import com.kh.insider.vo.BoardTagStatsResponseVO;
import com.kh.insider.vo.BoardTagStatsSearchVO;
import com.kh.insider.vo.BoardTimeStatsResponseVO;
import com.kh.insider.vo.BoardTimeStatsSearchVO;

public interface BoardRepo {
	List<BoardDto> selectListPaging(int page);
	
	List<BoardListVO> myPageSelectListPaging(int page, long memberNo);

	int sequence();
	
	//게시물 생성
	BoardDto insert(BoardDto boardDto);
	
	//게시물 단일 조회
	BoardWithNickDto selectOne(int boardNo);
	
	//게시물 삭제
	void delete(int boardNo);
	
	//게시물 수정
	boolean update(BoardDto boardDto);

	void updateLikeCount(int boardNo, int count);
	
	//컨텐트까지 포함한 리스트 출력(팔로우, 차단 x)
	List<BoardListVO> selectListWithAttach(AdminBoardSearchVO vo);
	int selectAdminCount(AdminBoardSearchVO vo);
	//팔로우 차단 구현 리스트 출력
	List<BoardListVO> selectListWithFollow(BoardSearchVO vo);
	//팔로우 차단 구현 리스트 출력(3일 이내)
	List<BoardListVO> selectListWithFollowNew(BoardSearchVO vo);
	//팔로우 차단 구현 리스트 출력(3일 이후)
	List<BoardListVO> selectListWithFollowOld(BoardSearchVO vo);	 
	//차단 구현 리스트 출력(찾기 게시판에서 씀)
	List<BoardListVO> selectListWithoutFollow(BoardSearchVO vo);
	//차단 구현 리스트 출력(
	List<BoardListVO> selectListWithoutFollowOutDistance(BoardSearchVO vo);
	// 전체 게시물 개수
	int getTotalPostCount(Long MemberNo);
	// 마이페이지 전체 게시물 조회
	List<BoardListVO> getTotalMyPost(long memberNo);
	
	//신고수 추가
	void addReport(int boardNo);
	
	//게시물 생성 통계
	List<BoardTimeStatsResponseVO> getBoardTimeStats(BoardTimeStatsSearchVO boardTimeStatsSearchVO);

	//태그 생성 통계
	List<BoardTagStatsResponseVO> getBoardTagStats(BoardTagStatsSearchVO boardTagStatsSearchVO);
	
	//계층형 단일조회
	BoardListVO selectOneBoard(int boardNo);
	
	//태그로 계층형 조회
	List<BoardListVO> selectListWithTag(BoardSearchVO vo);
	//태그 조회 개수 반환
	int selectListWithTagCount(BoardSearchVO vo);
	
	//리플 개수 업데이트
	void updateReply(int boardNo);
	//신고수가 1이상인 게시물 반환
	List<BoardListVO> selectListReported(long memberNo);
	
	// 북마크 게시물 조회
	List<BoardListVO> bookmarkMyPost(long memberNo);
}
