package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardWithNickDto {
	public int boardNo;
	public long memberNo;
	public String boardContent;
	public int boardLike;
	public int boardLat;
	public int boardLon;
	public Date boardTime;
	public int boardReply;
	public int boardReplyValid;
	public int boardLikeValid;
	public int boardReport;
	public int boardHide;
	public int boardKid;
	public int boardSize;
	
	private String memberNick;
	private Integer attachmentNo;
}