package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardLikeDto {
	private Long memberNo;
	private Integer boardNo;
	private Date boardLikeTime;
}
