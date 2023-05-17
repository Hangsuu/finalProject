package com.kh.insider.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class BoardAttachmentDto {

	public Long boardNo;
	public int attachmentNo;
	
	public String getImageURL() {
		if(attachmentNo == 0) return "https://via.placeholder.com/150x150";
		else return "/download?attachmentNo="+attachmentNo;
	}
}
