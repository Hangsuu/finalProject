package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDto {
	private int memberNo;
	private String memberName;
	private String memberPassword;
	private String memberEmail;
	private Date memberLogin;
	private int memberLat;
	private int memberLon;
	private String memberPost;
	private String memberBasicAddr;
	private String memberDetailAddr;
	private int memberLevel;
	private String memberMsg;
	private String memberTel;
	private String memberGender;
	private int memberReport;
	private Date memberBirth;
}