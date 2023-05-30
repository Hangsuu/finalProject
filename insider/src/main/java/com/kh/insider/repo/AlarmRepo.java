package com.kh.insider.repo;

import java.sql.Date;

public interface AlarmRepo{
	
	int getBoardNo();
	Date getBoardTime();
	Date getBoardLikeTime();
	Long getMemberNo();
	String getMemberNick();
	int getReplyNo();
	Date getReplyTime();
	long getFollowFollower();
	Date getFollowTime();
}
