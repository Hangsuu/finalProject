package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.BlockWithProfileDto;
import com.kh.insider.repo.BlockRepo;

@RestController
@RequestMapping("/rest/block")
public class BlockRestController {
	@Autowired
	private BlockRepo blockRepo;
	
	@PutMapping("/{blockNo}")
	public boolean block(@PathVariable long blockNo, HttpSession session) {
		long memberNo = (long)session.getAttribute("memberNo");
		if(blockNo==memberNo) return false;
		BlockDto blockDto = new BlockDto();
		blockDto.setMemberNo(memberNo);
		blockDto.setBlockNo(blockNo);
		BlockDto checkDto = blockRepo.selectOne(blockDto);
		if(checkDto==null) {
			blockRepo.insert(blockDto);
			return true;
		}
		else {
			return false;
		}
		
	}
	@GetMapping("/")
	public List<BlockWithProfileDto> blockList(HttpSession session) {
		long memberNo = (long) session.getAttribute("memberNo");
		return blockRepo.getBlockList(memberNo);
	}
	@DeleteMapping("/{blockNo}")
	public void deleteBlock(@PathVariable long blockNo, HttpSession session) {
		long memberNo = (long) session.getAttribute("memberNo");
		BlockDto blockDto = new BlockDto();
		blockDto.setBlockNo(blockNo);
		blockDto.setMemberNo(memberNo);
		blockRepo.delete(blockDto);
	}
}
