package com.kh.insider.service;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.BoardDto;
import com.kh.insider.repo.AttachmentRepo;
import com.kh.insider.repo.BoardAttachmentRepo;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.vo.PaginationVO;

@Service
public class BoardAttachServiceImpl implements BoardAttachService{

	@Autowired
	private BoardAttachmentRepo boardAttachmentRepo;
	@Autowired
	private BoardRepo boardRepo;
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Transactional
	@Override
	public void insert(BoardDto boardDto, List<MultipartFile> boardAttachment) throws IllegalStateException, IOException {
		BoardDto newDto = boardRepo.insert(boardDto);
		if (boardAttachment != null) {
		for(MultipartFile file : boardAttachment) {
			int attachmentNo = attachmentRepo.save(file);
			boardAttachmentRepo.insert(BoardAttachmentDto.builder()
					.boardNo(newDto.getBoardNo())
					.attachmentNo(attachmentNo)
					.build());
			}
		}
	}
	@Transactional
	@Override
	public void delete(int boardNo) {
		boardRepo.delete(boardNo);
		boardAttachmentRepo.delete(boardNo);
	}
	



}
