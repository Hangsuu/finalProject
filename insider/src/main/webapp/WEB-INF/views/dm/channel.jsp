<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insider DM</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<style>
    .card-scroll{
       	overflow-y: auto;
       	-ms-overflow-style: none;
	}        
    .card-scroll::-webkit-scrollbar {
		display: none;
	} 
	.cardList-scroll{
       	overflow-y: auto;
       	-ms-overflow-style: none;
	}   
	.cardList-scroll::-webkit-scrollbar {
		width: 5px;
		background-color: transparent;
	}
	.cardList-scroll::-webkit-scrollbar-thumb {
		background-color: rgba(0, 0, 0, 0.3); 
		border-radius: 3px;
	}
	.hover {
		background-color: rgb(244, 246, 248)
	}
	.content-body .fa-x,
	.content-body .fa-trash,
	.content-body .fa-heart {
	  visibility: hidden;
	}
	.content-body:hover .fa-x,
	.content-body:hover .fa-trash,
	.content-body:hover .fa-heart {
	  visibility: visible;
	}
	.room-image {
	    min-width:50px;
	    width:100%;
	}
	@media screen and (max-width:576px) {
	    .room-image {
	    display: none;
	    }
	}
	.message-wrapper {
        background-color: white;
        overflow: hidden;
    }
	.message-wrapper > .message {
	    display: flex;
	    font-size: 17.5px;
	    margin-top: 0.65em;
	    display: block;
	}
	.message-wrapper > .message > .message-content > .profile-wrapper {
	    min-width: 45px;
	    max-width: 45px;
	}
	.message-wrapper > .message > .message-content > .profile-wrapper > img {
	    border-radius: 50%;
	    width:100%;
	}
	.message-wrapper > .message > .message-content > .content-wrapper {
	    flex-grow: 1;
	    display: flex;
	    flex-direction: column;
	    padding: 0 0.5em;
	}
	.message-wrapper > .message > .message-content > .content-wrapper > .content-header {
	    font-size: 0.90em;
	    padding-right: 0.3em;
	    padding-left: 0.3em;
	    color: #3c6382;
	}
	.message-wrapper > .message > .message-content > .content-wrapper > .content-body {
	    display: flex;
	    font-weight: normal;
	    padding-top: 0.35em;
	    padding-right: 0.4em;
	    align-items: flex-end;
	}
	.message-wrapper > .message > .message-content > .content-wrapper > .content-body > .message-wrapper {
	    background-color: rgba(239, 239, 239);
	    font-size: 0.85em;
	    border-radius: 1.5em;
	    max-width: 500px;
	    word-break: break-all;
	    padding-top: 0.35em;
		padding-bottom: 0.35em;
		padding-left: 0.9em;
		padding-right: 0.9em;
	}
	.message-wrapper > .message > .message-content > .content-wrapper > .content-body > .info-wrapper {
	    min-width: 50px;
	}
	.message-wrapper > .message > .message-content > .content-wrapper > .content-body > .info-wrapper > .time-wrapper {
	    font-size: 0.5em;
	    padding: 0 0.30em;
	}
	.message-wrapper > .message >.message-content >  .content-wrapper > .content-body > .info-wrapper > .number-wrapper {
	    font-size: 0.6em;
	    padding: 0 0.45em;
	    color: orange;
	    font-weight: bold;
	}
	.message-wrapper > .message > .message-content > .content-wrapper > .content-footer {
	    padding-top: 0.05em;
	    align-items: flex-end;
	}
	.message-wrapper > .message > .message-content > .content-wrapper > .content-footer > .heart {
	    display: inline-block;
	    padding-left: 0.75em;
	}
	.message-wrapper > .message > .message-content > .content-wrapper > .content-footer > .heart-number {
	    display: inline-block;
	    padding-left: 0.28em;
	    font-size: 0.7em;
	    color: #c23616;
	}
	
	.message-wrapper > .message.my > .message-content > .content-wrapper > .content-header {
	    text-align: right;
	    padding-right: 0.9em;
	}
	.message-wrapper > .message.my > .message-content > .content-wrapper > .content-body {
	    flex-direction: row-reverse;
	}
	.message-wrapper > .message.my > .message-content > .content-wrapper > .content-body > .message-wrapper {
	    background-color: rgba(75, 161, 255);
	    color: white;
	}
	.message-wrapper > .message.my > .message-content > .content-wrapper > .content-body > .info-wrapper > .time-wrapper {
	    text-align: right;
	    padding-right: 0.45em;
	}
	.message-wrapper > .message.my > .message-content > .content-wrapper > .content-body > .info-wrapper > .number-wrapper {
	    text-align: right;
	    padding-right: 0.45em;
	}
	.message-wrapper > .message.my > .message-content > .content-wrapper > .content-footer {
	    text-align: right;
	}
	.message-wrapper > .message.my > .message-content > .content-wrapper > .content-footer > .heart {
	    padding-left: 0.65em;
	    padding-right:0.02em;
	}
	.message-wrapper > .message.my > .message-content > .content-wrapper > .content-footer >.heart-number {
	    padding-left: 0.28em;
	    font-size: 0.7em;
	    padding-right: 1.5em;
	    color: #c23616;
	}
	.dateShow {
	    color:  gray;
	    font-size: 0.78em;
	    text-align: center;
	    display: block;
	}
	.message-content {
	    display: flex;
	}
</style>

</head>
<body>

	<div id="app">
	
		<div class="container-fluid">
			<div class="row">
				<div class="row mt-3" style="width:1000px;margin-bottom:0;margin-left:7px; margin-right:0px;height:70px;">
					<!-- 로그인한 회원 프로필 -->
					<div class="card col-3" style="width:290px;border-radius:0;padding-bottom:0;align-content: center;flex-wrap: wrap;flex-direction: row;">
						<div style="padding-left: 0.4em;">
							<a href="${pageContext.request.contextPath}/member/login" style="color: black; text-decoration: none;">
							<img v-if="${attach!=0}" src="${pageContext.request.contextPath}/rest/attachment/download/${attach}" width="45" height="45" class="profile rounded-circle" style="position:absolute; top:0.75em" >
							<img v-else src="https://via.placeholder.com/45x45?text=P" style="border-radius: 50%; position:absolute; margin-top:0em;">
								<span style="padding-left:3.5em; word-wrap:normal;">
										${sessionScope.memberNick}
								</span>
							</a>
						</div>
						<span v-if="this.roomNo == null" style="position:absolute; top:21px; right:0; margin-right:15px;">
							<i class="fa-regular fa-pen-to-square fa-lg" style="margin-right: 11px; cursor:pointer;" @click="fetchFollowerList(); showCreateRoomModal();"></i>
						</span>
						<span v-else style="position:absolute; top:21px; right:0; margin-right:15px;">
							<i class="fa-regular fa-pen-to-square fa-lg" style="margin-right: 15px; cursor:pointer;" @click="fetchFollowerList(); showCreateRoomModal();"></i>
							<i class="fa-solid fa-user-plus fa-lg" style="cursor:pointer;" @click="fetchFollowerList();  showInviteModal();"></i>
						</span>
					</div>
					
					<!-- 채팅방 이름 -->
					<div class="card col-8" style="border-radius:0;border-left:0;align-content: center;flex-wrap: wrap;flex-direction: row;">
						<div class="room" v-for="(room, index) in dmRoomList" :key="room.roomNo">
							<div v-if="this.roomNo != null">
								<div v-if="this.roomNo === room.roomNo">
									<img v-if="room.attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+room.attachmentNo"
										width="45" height="45" class="profile rounded-circle" style="position:absolute; top:0.75em; left:1.3em;" >
					          		<img v-else src="https://via.placeholder.com/34x34?text=P" style="border-radius: 50%; position:absolute; margin-top:0em;">
									<span style="font-size:0.86em;padding-left:4.7em; word-wrap:normal;">{{room.roomName}}</span>
								</div>
								<span style="position:absolute; top:21px; right:0; margin-right:19px;">
									<i class="fa-solid fa-file-pen fa-xl" style="margin-right: 15px; cursor:pointer; color: #b2bec3" @click="showRoomNameModal()"></i>
									<i class="fa-solid fa-door-open fa-xl" style="margin-right: 15px; cursor:pointer; color: #b2bec3" @click="showExitModal()"></i>
									<i class="fa-solid fa-circle-info fa-xl" style="cursor:pointer; color: #b2bec3" @click="showMembersInRoomModal()"></i>
								</span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row" style="width:1000px;margin-left:7px; margin-right:100px; margin-top:0; height:70vh">
					<!-- 채팅방 목록 -->
					<div class="card col-3" style="width:290px;border-radius:0;border-top:none;padding:0;">
						<div class="card-body cardList-scroll" style="padding:0;padding-top:10px; max-height: 720px;">
							<div class="room" v-for="(room, index) in dmRoomList" :key="room.roomNo":class="{'hover': isHovered[index] }"
         						@mouseover="isHovered[index] = true" @mouseleave="isHovered[index] = false" @click="enterRoom(room.roomNo)" style="padding-bottom: 5px;padding-top: 4px;padding-left: 13px;cursor:pointer;">
							    <div style="position:relative; height: 2.4em; display: flex; align-items: center;">
							    	<img v-if="room.attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+room.attachmentNo"class="profile rounded-circle" style="position:absolute; 
								    	width:34px; height:34px; margin-top:0em;cursor:pointer;">
				          			<img v-else src="https://via.placeholder.com/34x34?text=P" style="border-radius: 50%; position:absolute; margin-top:0em;">
								    <span style="font-size:0.86em;padding-left:3.2em; word-wrap:normal;">
									     {{ room.roomName.length > 11 ? room.roomName.slice(0, 11) + '...' : room.roomName }}
			   						</span>
			   						<span v-if="unreadMessage[index] > 0" style="color:#eb4d4b; font-size:0.85em;padding-left:1.5em; padding-top:0.1em">
			   						 	{{unreadMessage[index]}}
			   						</span>
			   						<span v-if="unreadMessage[index] > 0" style="color:#eb4d4b; position:absolute;right:15px; top:13px;font-size: 10px;">
			   							<i class="fa-solid fa-circle"></i>
			   						</span>
							    </div>
			   					<div style="word-wrap:normal;display: flex; align-items: center;">
			   						<span v-if="room.messageContent" style="font-size:0.75em;word-wrap:normal;display: inline-block;width: 73%;text-overflow: 
			   							ellipsis;white-space: nowrap;overflow: hidden;vertical-align:bottom; text-overflow: ellipsis; padding-left:3.5em; color:#aaa69d;">
			   							{{JSON.parse(room.messageContent).content}}
			   						</span>
				   					<span v-if="room.messageSendTime" style="font-size:0.7em;word-wrap:normal;color:gray; top:3px; display: inline-block; padding-left:1.1em;">
					   					&nbsp; {{dateCount(room.messageSendTimeAuto)}}
				   					</span>
				   				</div>
							</div>
						</div>
					</div>
					
					<!-- 채팅창 -->
					<div class="card col-8" style="border-radius:0;border-top:none;border-left:0;padding-right:0;">
						<div class="card-body card-scroll" ref="scrollContainer" style="padding:0; max-height: 570px;" v-show="isRoomJoin">
					        <div class="message-wrapper">
					            <div class="message" v-for="(message, index) in messageList" :key="message.no" :class="{my:checkMyMessage(index)}">
						            <div v-if="dateCheck(index)" class="dateShow">
										 <div>{{timeFormat2(message.time)}}</div>
									</div>
									<div class="message-content">
						                <div class="profile-wrapper" v-if="!checkMyMessage(index)">
	                                			<img src="https://via.placeholder.com/100x100?text=P" width="100%" v-if="!checkSameTime(index)">
						                </div>
						                <div class="content-wrapper">
							                <div class="content-header" v-if="!checkSameTime(index)">
							                	{{message.memberNick}}
							                </div>
							                <div class="content-body">
								                <div v-if="message.attachmentNo == 0" class="message-wrapper">{{message.content}}</div>
								                <img class="photo" v-if="message.attachmentNo > 0" 
													:src="'${pageContext.request.contextPath}/rest/attachment/download/'+message.attachmentNo">
								                <div class="info-wrapper">
								                	<div class="number-wrapper" v-show="unreadCount[index] !== 0">{{unreadCount[index]}}</div>
								                	<div class="time-wrapper" v-if="calculateDisplay(index)">{{timeFormat(message.time)}}</div>
								                </div>
							                	<i class="fa-solid fa-x fa-xs" @click="deleteMessage(index)"  style="padding-bottom: 0.51em; padding-right: 0.6em; padding-left: 0.7em; color: #ced6e0; cursor:pointer;"></i>
							                	<i class="fa-solid fa-trash fa-xs" style="padding-bottom: 0.51em; padding-right: 0.51em; padding-left: 0.51em; color: #ced6e0; cursor:pointer;"></i>
							                </div>
							                <div class="content-footer">
							                	<div class=heart><i class="fa-heart fa-xs" :class="{'fa-solid':memberLike[index]==1, 'fa-regular':memberLike[index]==0}" style="color: #c23616;" @click="dmLike(message.messageNo, index)"></i></div>
							             	   <div class=heart-number>{{likeCount[index]}}</div>
							                </div>
							            </div>
							    	</div>
					            </div>
						      </div>
					        <div class="input-wrapper" style="position: absolute; bottom: 0; left: 0; width: 100%; padding: 5px;">
						        <div class="row justify-content-between" style="margin-top:10px;margin-bottom:10px;padding-left:calc(var(--bs-gutter-x) * .5);padding-right:calc(var(--bs-gutter-x) * .5);height:38px;">
							        <!-- 입력창 -->
							        <input type="text" v-model="text" v-on:input="text=$event.target.value" placeholder="메세지 입력" style="border-radius: 3rem;width:75%;">
							        <label for="fileDm" style="display: contents;">
										<i class="fa-solid fa-image" style="font-size: xx-large;color: #eb6864;padding-top: 3px;"></i>
									</label>
							        	<input type="file" name="fileDm" id="fileDm" @input="sendPicture()" style="display:none;" accept=".png, .jpg, .gif" ref="fileInput">
							        <button @click="sendMessage" style="border-radius: 3rem; width:15%;">전송</button>
						        </div>
					        </div>
						</div>
					</div>
					
				</div>
				
			</div>
		</div>
		
		<!-- 회원 목록을 모달창으로 불러오기 - 채팅방 생성 -->
		<div class="modal fade" tabindex="-1" id="memberListModal" data-bs-backdrop="static" ref="memberListModal">
		  <div class="modal-dialog modal-dialog-scrollable" style="width:400px; margin: 0; position: fixed; top: 60%; left: 50%; transform: translate(-50%, -50%);">
		    <div class="modal-content" style="align-content: center;flex-wrap: wrap;">
		      <div class="modal-header" style="width:300px;">
		        <h4 class="modal-title" id="memberListModalLabel" style="font-weight: bold; color: #222f3e;">메세지 보내기</h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" style="width:300px;">
		        <div style="margin-bottom:10px;">
		          <input type="text" placeholder="검색" v-model="keyword" class="form-control me-sm-2" @input="keyword = $event.target.value">
		        </div>
		        <div v-if="searchDmList.length==0" >
			        <div v-for="(member,index) in dmMemberList" :key="member.memberNo" style="margin-top:20px;position:relative;">
			          <img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+member.attachmentNo" class="profile rounded-circle" style="object-fit:cover; position:absolute; top:0.3em; width:45px; height:45px;">
			          <span style="padding-left:3.3em;font-size:0.9em;">{{member.memberNick}}</span>
			          <br>
			          <span style="padding-left:4.2em; padding-bottom: 1.5m; font-size:0.75em;color:#7f8c8d;">{{member.memberName}}</span>
			          <span style="position:absolute;right:0;top:10px;">
			          	<input type="checkbox" v-model="selectedMembers" :value="member.memberNo" style="transform: scale(1.2); margin-right:1em;">
			          </span>
			        </div>
		        </div>
		        <div v-if="searchDmList.length>0">
			        <div v-for="(member,index) in searchDmList" :key="member.memberNo"style="margin-top:20px;position:relative;">
			          <img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+member.attachmentNo"class="profile rounded-circle" style="object-fit:cover; position:absolute; top:0.3em; width:40px; height:40px;">
			          <span style="padding-left:3.3em;font-size:0.9em;">{{member.memberNick}}</span>
			          <br>
			          <span style="padding-left:4.2em; padding-bottom: 1.5m; font-size:0.75em;color:#7f8c8d;">{{member.memberName}}</span>
			          <span style="position:absolute;right:0;top:10px;">
					  	<input type="checkbox" v-model="selectedMembers" :value="member.memberNo" style="transform: scale(1.2); margin-right:1em;">
			          </span>
			        </div>
		      	</div>
		      </div>
		      <div class="modal-footer" style="width:300px;">
		      	<button class="btn btn-outline-primary" @click="createRoomAndInvite" :disabled="selectedMembers.length === 0"
        			data-bs-dismiss="modal" data-bs-target="#my-modal" aria-label="Close">채팅</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- 회원 목록을 모달창으로 불러오기 - 초대 -->
		<div class="modal fade" tabindex="-1" id="inviteModal" data-bs-backdrop="static" ref="inviteModal">
		  <div class="modal-dialog modal-dialog-scrollable" style="width:400px; margin: 0; position: fixed; top: 60%; left: 50%; transform: translate(-50%, -50%);">
		    <div class="modal-content" style="align-content: center;flex-wrap: wrap;">
		      <div class="modal-header" style="width:300px;">
		        <h4 class="modal-title" id="memberListModalLabel" style="font-weight: bold; color: #222f3e;">회원 초대</h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" style="width:300px;">
		        <div style="margin-bottom:10px;">
		          <input type="text" placeholder="검색" v-model="keyword" class="form-control me-sm-2" @input="keyword = $event.target.value">
		        </div>
		        <div v-if="searchDmList.length==0" >
			        <div v-for="(member,index) in dmMemberList" :key="member.memberNo" style="margin-top:20px;position:relative;">
			          <img v-if="dmMemberList[index].attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+member.attachmentNo" class="profile rounded-circle" style="object-fit:cover; position:absolute; top:0.3em; width:40px; height:40px;">
			          <img v-else src="https://via.placeholder.com/42x42?text=profile"style="border-radius: 50%; position:absolute; top:0.3em;">
			          <span style="padding-left:3.3em;font-size:0.9em;">{{member.memberNick}}</span>
			          <br>
			          <span style="padding-left:4.2em; padding-bottom: 1.5m; font-size:0.75em;color:#7f8c8d;">{{member.memberName}}</span>
			          <span style="position:absolute;right:0;top:10px;">
			          	<input type="checkbox" v-model="selectedMembers" :value="member.memberNo" style="transform: scale(1.2); margin-right:1em;">
			          </span>
			        </div>
		        </div>
		        <div v-if="searchDmList.length>0">
			        <div v-for="(member,index) in searchDmList" :key="member.memberNo"style="margin-top:20px;position:relative;">
			          <img v-if="searchDmList[index].attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+member.attachmentNo" class="profile rounded-circle" style="object-fit:cover;position:absolute; top:0.3em; width:40px; height:40px;">
			          <img v-else src="https://via.placeholder.com/42x42?text=profile"style="border-radius: 50%; position:absolute; top:0.3em;">
			          <span style="padding-left:3.3em;font-size:0.9em;">{{member.memberNick}}</span>
			          <br>
			          <span style="padding-left:4.2em; padding-bottom: 1.5m; font-size:0.75em;color:#7f8c8d;">{{member.memberName}}</span>
			          <span style="position:absolute;right:0;top:10px;">
			          	<input type="checkbox" v-model="selectedMembers" :value="member.memberNo" style="transform: scale(1.2); margin-right:1em;">
			          </span>
			        </div>
		      	</div>
		      </div>
		      <div class="modal-footer" style="width:300px;">
		      	<button class="btn btn-outline-danger" @click="inviteRoom" :disabled="selectedMembers.length === 0"
        			data-bs-dismiss="modal" data-bs-target="#my-modal" aria-label="Close">초대</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- 채팅방 퇴장 모달창 -->
		<div class="modal fade" id="exitModal" tabindex="-1" data-bs-backdrop="static"  ref="exitModal" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" style="width:450px;">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" >채팅방을 퇴장 하시겠습니까?</h5>
		      </div>
		      <div class="modal-body" style="display: flex; align-items: center; color:grey;font-size:0.9em; height: 7em;">
					채팅방 퇴장 시, 회원님의 채팅 메세지가 모두 삭제됩니다. <br>
					다른 사람의 채팅방에는 메시지가 계속 표시됩니다.
		      </div>
		      <div class="modal-footer btn-center">
		        <button type="button" class="btn" @click="leaveTheRoom" data-bs-dismiss="modal" aria-label="Close" style="color:red; margin-right: 10.8em; height: 2em;">나가기</button>
		      </div>
		      <div class="modal-footer btn-center">
		        <button type="button" class="btn" data-bs-dismiss="modal" style="margin-right: 11.3em; height: 2em;">취소</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- 채팅방 이름 변경 -->
		<div class="modal fade" id="roomNameModal" tabindex="-1" data-bs-backdrop="static"  ref="roomNameModal" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" style="width:450px;">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" >채팅방 이름을 변경하시겠습니까?</h5>
		      </div>
		      <div class="modal-body" style="display: flex; align-items: center; color:grey;font-size:0.9em; height: 7em;">
			  	<input type="text" id="roomNameInput" v-model="roomName" placeholder="채팅방 이름을 입력하세요." @keyup.enter="clickConfirmButton" 
			  		style="width: 100%; padding: 20px; font-size: 1.2em; border: none; outline: none; border-bottom: none;" maxlength="49">
		      <span>{{roomNameLen}} / 49</span>
		      </div>
		      <div class="modal-footer btn-center">
		        <button type="button" class="btn" @click="changeRoomName" data-bs-dismiss="modal" aria-label="Close" 
		        	:disabled="!roomName" style="color:#0652DD; margin-right: 11em; height: 2em;">수정</button>
		      </div>
		      <div class="modal-footer btn-center">
		        <button type="button" class="btn" data-bs-dismiss="modal" @click="hideRoomNameModal" style="margin-right: 11em; height: 2em;">취소</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- 나에게만 메세지 삭제 - messageNo를 가져 오지 못해 사용 불가 -->
		<div class="modal fade" id="deleteMsgModal" tabindex="-1" data-bs-backdrop="static"  ref="deleteMsgModal" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" style="width:450px;">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" >나에게만 메세지 삭제</h5>
		      </div>
		      <div class="modal-body" style="display: flex; align-items: center; color:grey;font-size:0.9em; height: 7em;">
					나에게만 해당 메세지가 삭제됩니다. <br>
					다른 사람의 채팅방에는 메시지가 계속 표시됩니다.
		      </div>
		      <div class="modal-footer btn-center">
		        <button type="button" class="btn" data-bs-dismiss="modal" aria-label="Close" style="color:red; margin-right: 11em; height: 2em;">삭제</button>
		      </div>
		      <div class="modal-footer btn-center">
		        <button type="button" class="btn" data-bs-dismiss="modal" style="margin-right: 11em; height: 2em;">취소</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- 채팅방에 참여 중인 회원 -->
		<div class="modal fade" tabindex="-1" id="membersInRoomModal" data-bs-backdrop="static" ref="membersInRoomModal">
		  <div class="modal-dialog modal-dialog-scrollable modal-fullscreen-sm-down" style="width:400px; margin: 0; position: fixed; top: 60%; left: 50%; transform: translate(-50%, -50%);">
		    <div class="modal-content" style="align-content: center;flex-wrap: wrap;">
		      <div class="modal-header" style="width:300px;">
		        <h4 class="modal-title" style="font-weight: bold; color: #222f3e;">대화 상대</h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" style="width:300px;">
		        <div v-for="(member,index) in membersInRoomList" :key="index" style="margin-top:20px;position:relative;">
		          <a href="${pageContext.request.contextPath}/member/{member.memberNick}" style="color: black; text-decoration: none;">
			          <img v-if="member.attachmentNo > 0"  :src="'${pageContext.request.contextPath}/rest/attachment/download/'+member.attachmentNo"class="profile rounded-circle" style="object-fit:cover;position:absolute; top:0.3em; width:40px; height:40px;">
				      <img v-else src="https://via.placeholder.com/42x42?text=profile"style="border-radius: 50%; position:absolute; top:0.3em;">
			          <span style="padding-left:3.3em;font-size:0.9em;">{{member.memberNick}}</span>
		          </a>
		          <br>
		          <span style="padding-left:4.2em; padding-bottom: 1.5m; font-size:0.75em;color:#7f8c8d;">{{member.memberName}}</span>
		          <span style="position:absolute;right:0;top:10px;">
		            <button class="btn btn-outline-secondary" style="padding: 0.3rem 0.2rem;font-weight: 100;line-height: 1;font-size:0.8em; margin-right: 0.5em;"data-bs-dismiss="modal" aria-label="Close" >
		              차단
		            </button>
		            <button class="btn btn-outline-danger" style="padding: 0.3rem 0.2rem;font-weight: 100;line-height: 1;font-size:0.8em;"data-bs-dismiss="modal"  aria-label="Close" >
		              신고
		            </button>
		          </span>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
		
	</div>
    
	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>

    <script>
        Vue.createApp({
            data(){
                return {
                    text:"",//사용자가 입력하는 내용
                    messageList:[],//채팅 기록
                    memberNick:"${sessionScope.memberNick}",
                    memberNo:"${sessionScope.memberNo}",
                    socket:null,//웹소켓 연결 객체
                    dmMemberList:[],//팔로워 회원 목록

                    //modal 제어
                    createRoomModal:null, 
                    exitModal:null,
                    inviteModal:null,
                    
                    //차단한 회원을 제외한 전체 회원 검색
                    searchDmList:[],
                    keyword:"",
                    
                    dmRoomList: [], //채팅방 목록
                    isRoomJoin:false,
                    
                    //채팅방 참가자 시간 정보 리스트
                    userTimeList:[],
                    //한 개의 메세지에 다른 회원이 읽지 않은 수
                    unreadCount:[],
                    //특정 회원의 채팅방에서 읽지 않은 메세지 수(비동기)
                    unreadMessage: [],
                    
                    //초대
                    selectedMembers:[],
                    roomNo:null, //vue에 반환
                   
   					roomName: "",
   					roomType: "",
   					roomRename:"",
   					
   					isHovered: [],
   					scrollContainer: null, //스크롤
   					
   					membersInRoomList:[], //채팅방 회원 목록
   					
   					//좋아요 개수 목록 및 내가 좋아요한 여부
   					likeCount:[],
   					memberLike:[],
                };
            },
            methods:{
            	enterRoom(roomNo) {
           		    this.roomNo = roomNo;
           		 	this.openHandler(roomNo);
           		    this.loadMessage(roomNo);
           		},
            	// 메세지 불러오는 함수
            	async loadMessage(roomNo) {
            	    if(roomNo==null){
            	    	this.isRoomJoin=false; 
            	    	return;
            	    }
            	    this.isRoomJoin=true;
            	    const url = "${pageContext.request.contextPath}/rest/message/"+roomNo;

            	    try {
            	        const resp = await axios.get(url);
            	        this.messageList = resp.data.map(msg => JSON.parse(msg.messageContent));
            	        //좋아요 개수 및 내가 좋아요 했는지 여부 반환
            	        this.likeCount = resp.data.map(msg=>JSON.parse(msg.likeCount));
            	        this.memberLike= resp.data.map(msg=>JSON.parse(msg.memberLike));
            	        
        				//스크롤 바닥으로 이동
        				this.$nextTick(() => {
                            const scrollContainer = this.$refs.scrollContainer;
                            scrollContainer.scrollTo({ top: scrollContainer.scrollHeight, behavior: 'smooth' });
                        });
        				// 읽지 않은 메세지 수 수정
        			    await this.updateUnreadDm(roomNo);
        				this.setUnreadCountOnMessage();
            	    } 
            	    catch (err) {
            	        console.error("메세지를 불러올 수 없습니다.");
            	    }
            	},
            	// 메세지 리스트 불러오는 함수
           		displayMessageList(resp) {
				    this.messageList = resp.map((msg) => {
				        const msgContent = JSON.parse(msg.messageContent);
				        let formattedMsg = {
				                messageNo: msgContent.messageNo,  // 메세지 삭제를 위해 추가
				                memberNick: msgContent.memberNick,
				                time: this.timeFormat(msgContent.time),
				                messageType: msgContent.messageType // 메세지 타입 추가
				            };

				            if(msgContent.messageType === 1) {
				                formattedMsg.content = msgContent.content;
				            } else if(msgContent.messageType === 7) {
				                formattedMsg.attachmentNo = msgContent.attachmentNo;
				            }
				            return formattedMsg;
				    });
				},
				//이미지 메세지 전송
				async sendPicture() {
				    const fileInput = this.$refs.fileInput;
				    const file = fileInput.files[0];
				    if(!file) {
				        console.log("선택된 이미지 메세지 파일이 없습니다.");
				        return;
				    }
				    const formData = new FormData();
				    formData.append("attach", file);
				
				    const url = "${pageContext.request.contextPath}/rest/attachment/dm";
				    try {
				        const resp = await axios.post(url, formData, {
				            headers: {
				                'Content-Type': 'multipart/form-data'
				            }
				        });
				        if(resp.data) {
				            const data = {
				                    type: 7, 
				                    attachmentNo: resp.data.attachmentNo,
				                    content: "이미지 메세지"
				            }
				            this.socket.send(JSON.stringify(data));
				            fileInput.value = null;
				        }
				    } catch (error) {
				        console.error("이미지 메세지 업로드 실패", error);
				    }
				},
				//모달창
				showCreateRoomModal(){
                    if(this.createRoomModal == null) return;
                    this.selectedMembers = []; 
                    this.dmMemberList = [];
                    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
                    checkboxes.forEach(checkbox => (checkbox.checked = false));
                    this.createRoomModal.show();
                    //모달창 스크롤바를 사용할 때, 페이지 스크롤바 사용 불가능
                    document.body.style.overflow = "hidden";
                },
                hideCreateRoomModal(){
                    if(this.createRoomModal == null) return;
                    this.createRoomModal.hide();
                  //모달창 스크롤바를 사용할 때, 페이지 스크롤바 사용 불가능
                    document.body.style.overflow = "unset";
                },
				showExitModal(){
                    if(this.exitModal == null) return;
                    this.exitModal.show();
                },
                hideExitModal(){
                    if(this.exitModal == null) return;
                    this.exitModal.hide();
                },
				showInviteModal(){
                    if(this.inviteModal == null) return;
                    this.selectedMembers = []; 
                    this.dmMemberList = [];
                    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
                    checkboxes.forEach(checkbox => (checkbox.checked = false));
                    this.inviteModal.show();
                    document.body.style.overflow = "hidden";
                },
                hideInviteModal(){
                    if(this.inviteModal == null) return;
                    this.inviteModal.hide();
                    document.body.style.overflow = "unset";
                },
				showRoomNameModal(){
                    if(this.roomNameModal == null) return;
                    this.roomNameModal.show();
                },
                hideRoomNameModal(){
                    if(this.roomNameModal == null) return;
                    this.roomNameModal.hide();
                    this.roomName = "";
                },
				showDeleteMsgModal(){
                    if(this.deleteMsgModal == null) return;
                    this.deleteMsgModal.show();
                },
                hideDeleteMsgModal(){
                    if(this.deleteMsgModal == null) return;
                    this.deleteMsgModal.hide();
                },
				showMembersInRoomModal(){
                    if(this.membersInRoomModal == null) return;
                    this.fetchUsersByRoomNo(this.roomNo);
                    this.membersInRoomModal.show();
                    document.body.style.overflow = "hidden";
                },
                hideMembersInRoomModal(){
                    if(this.membersInRoomModal == null) return;
                    this.membersInRoomModal.hide();
                    document.body.style.overflow = "unset";
                },
			    connect(){
            		const url = "${pageContext.request.contextPath}/ws/channel";
            		this.socket = new SockJS(url);
            		
            		//this = 웹소켓 객체이므로 개조 (this가 view이어야 사용 가능)
            		const app = this;
            		this.socket.onopen = function(){
            			app.openHandler();
            		};
            		this.socket.onclose = function(){
            			app.closeHandler();
            		};
            		this.socket.onerror = function(){
            			app.errorHandler();
            		};
            		this.socket.onmessage = function(e){
            			app.messageHandler(e);
            		};
            	},
            	openHandler(roomNo){
                    const data = { type:2, room:roomNo };
                    this.socket.send(JSON.stringify(data));
                    console.log("서버에 연결되었습니다.");
            	},
            	closeHandler(){
            		console.log("서버와의 연결이 종료되었습니다.");
            	},
            	errorHandler(){
            		console.log("연결 중 오류가 발생했습니다.");
            	},
            	messageHandler(e){
            		const message = JSON.parse(e.data);
            		
            		//리스트 형태(시간정보 배열) 일때
            		if(message.length>0){
            			this.userTimeList=[...message];
            			this.setUnreadCountOnMessage();
            		}
            		//메세지 일 때
            		else{
	                    // 읽지 않은 메세지 수 테스트2
						if (message.messageType === 6) { // 새로운 메시지 수
							this.fetchDmRoomList();
						}
						else if(message.messageType===8){ //좋아요
							const index = this.messageList.findIndex(obj => obj.messageNo === message.messageNo);
							this.likeCount[index]=message.likeCount;
						}
						else{
		            		this.messageList.push(message);
		            		this.likeCount.push(0);
		            		this.memberLike.push(0);
						}
	            		
            		}
	            },
            	sendMessage() {
            		if(this.text.length == 0) return;
            		this.socket.send(this.jsonText);
            		this.text = "";
            	},
            	timeFormat(time) {
            		return moment(time).format("A h:mm");
            	},
            	timeFormat2(time) {
            		return moment(time).format("YYYY년 M월 D일");
            	},
            	//메세지 삭제
            	deleteMessage(index) {
            	    const messageNo = this.messageList[index].messageNo;
            	    const data = { type: 3, messageNo: messageNo, memberNo: this.memberNo };
            	    this.socket.send(JSON.stringify(data));
            	    this.loadMessage(this.roomNo);
            	},
            	//디자인 - 시간
                checkSameTime(index) {
                    if(index == 0) return false;
                    const before = this.messageList[index-1];
                    const current = this.messageList[index];
                    
                    if(before.memberNick != current.memberNick) return false;
                    if(this.timeFormat(before.time) != this.timeFormat(current.time)) return false;
                    return true;
               },
               //디자인 - 프로필
               calculateDisplay(index) {
                    if(index + 1 == this.messageList.length) return true;
                    const after = this.messageList[index+1];
                    const current = this.messageList[index];
                    if(current.memberNick != after.memberNick) return true;
                    if(this.timeFormat(current.time) != this.timeFormat(after.time)) return true;
                    return false;
               },
               //디자인 - 본인 메세지
               checkMyMessage(index) {
                    if(this.memberNick == this.messageList[index].memberNick) return true;
                    return false;
               },
               //날짜
				dateCheck(index) {
				    if (index != 0) {
				        const currentMessageDate = moment(this.messageList[index].time).format('YYYY-MM-DD');
				        const previousMessageDate = moment(this.messageList[index - 1].time).format('YYYY-MM-DD');
				        return currentMessageDate !== previousMessageDate;
				    }
				    return true;  //첫 번째 메세지는 항상 새로운 날짜로 간주
				},
               //팔로우 회원 목록
               async fetchFollowerList() {
            	   const url = "${pageContext.request.contextPath}/rest/dmMemberList";
            	    try {
            	      const resp = await axios.get(url);
            	      this.dmMemberList.splice(0);
	                  this.dmMemberList.push(...resp.data);
            	    } 
            	    catch (error) {
            	      console.error(error);
            	    }
            	},
                //차단한 회원을 제외한 전체 회원 검색
				async chooseDmSearch() {
				    const url = "${pageContext.request.contextPath}/rest/dmMemberSearch";
				    try {
				        const resp = await axios.get(url, {
				            params: {
				                keyword: this.keyword
				            }
				        });
				        this.searchDmList.splice(0);
	                    this.searchDmList.push(...resp.data);
				    } catch (error) {
				        console.error(error);
				    }
				},			
				//로그인한 회원의 채팅방 목록
				async fetchDmRoomList() {
				    try {
				        const resp = await axios.get("${pageContext.request.contextPath}/rest/dmRoomList");
				        const countUrl = "${pageContext.request.contextPath}/rest/countUsersInDmRoom";
				        this.dmRoomList=[...resp.data];
				
				        //채팅방 나에게만 이름 변경
				        this.dmRoomList.forEach(async (item) => {
				    	// 채팅방 총 인원 수
				        const countResp = await axios.get(countUrl, { params: { roomNo: item.roomNo } });
				        const count = countResp.data;
				        	//채팅방 이름이 변경 되었고, 변경한 사람이 로그인한 회원 본인일 경우
				            if (item.roomRename != null || item.memberNo === this.memberNo) {
				                item.roomName = item.roomRename;
				            } else {
				                item.roomName = item.memberNick;
				                
				                //채팅방 이름이 변경되지 않았고, 그룹 채팅일 경우
				                if (item.roomType === 0) {
							        item.roomName = item.memberNick + " 외 " + (count - 1) + "명";
				                }
				            }
				        });
				        this.unreadDmCount();
				    } catch (error) {
				        console.error(error);
				    }
				},
				//채팅방에 참여한 회원 목록
				async fetchUsersByRoomNo() {
					const roomNo = this.roomNo;
					const url = "${pageContext.request.contextPath}/rest/users/"+roomNo;
					console.log("roomNo : ", roomNo);
					try {
						const resp = await axios.get(url);
						console.log("resp : ", resp);
						this.membersInRoomList.splice(0);
						this.membersInRoomList.push(...resp.data);
					} catch (error) {
						console.error(error);
					}
				},
				//채팅방 생성 및 입장, 초대
				async createRoomAndInvite() {
				    try {
				        //방 생성
				        const dmRoomVO = await axios.post("${pageContext.request.contextPath}/rest/createChatRoom");
				        const roomNo = dmRoomVO.data.roomNo;
				        
				        //채팅 유저 저장
				        const user = {
				            roomNo: roomNo,
				            memberList: [...this.selectedMembers, parseInt(this.memberNo)] 
				        };
				        const url = "${pageContext.request.contextPath}/rest/enterUsers";
				        await axios.post(url, user);
				        
				        //일대일 채팅방이 아닐 경우
				        if (this.selectedMembers.length >= 2) {
				            const updateRoomUrl = "${pageContext.request.contextPath}/rest/updateRoomInfo";
				            const updateRoomData = {
				                roomNo: roomNo,
				                roomType: 0,
				                roomName: this.memberNick  + " 외 " + (this.selectedMembers.length) + "명"
				            };
				            await axios.put(updateRoomUrl, updateRoomData);
				        }
				        await this.fetchDmRoomList(); //채팅방 목록 불러오기
				        window.location.href = "${pageContext.request.contextPath}/dm/channel?room=" + roomNo;
				        console.log("방 생성, 입장, 초대가 성공적으로 수행되었습니다.");
				    } catch (error) {
				        console.error("방 생성, 입장, 초대 중 오류가 발생했습니다.", error);
				    }
				},
				//회원 초대
				async inviteRoom() {
					try {
						const inviteUrl = "${pageContext.request.contextPath}/rest/inviteUser";
						const countUrl = "${pageContext.request.contextPath}/rest/countUsersInDmRoom";
						const searchUrl = "${pageContext.request.contextPath}/rest/searchDmRoom";
						const data = {
								roomNo: this.roomNo,
								memberList: this.selectedMembers
						}
						await axios.post(inviteUrl, data);
					    console.log("초대가 성공적으로 수행되었습니다.");
					    
					 	//회원 초대 후, 총 회원수 가져오기
						const countResp = await axios.get(countUrl, {params: {roomNo: this.roomNo}});
						const count = countResp.data;
					
						if (count >= 3) {
							const roomInfoResp = await axios.get(searchUrl, {params: {roomNo: this.roomNo}});
				            const roomInfo = roomInfoResp.data;
							const updateRoomUrl = "${pageContext.request.contextPath}/rest/updateRoomInfo";
				            const updateRoomData = {
				                roomNo: this.roomNo,
				                roomType: 0,
				                roomName: roomInfo.roomName
				            };
				            await axios.put(updateRoomUrl, updateRoomData);
						}
					} catch (error) {
				        console.error("채팅 유저 초대 중 오류가 발생했습니다.", error);
				    }
	            },
	            //유저 초대 다중 선택
	            toggleSelection(memberNo) {
				    if (this.selectedMembers.includes(memberNo)) {
				      // 이미 선택된 회원인 경우, 선택 해제
				      const index = this.selectedMembers.indexOf(memberNo);
				      this.selectedMembers.splice(index, 1);
				    } else {
				      // 선택되지 않은 회원인 경우, 선택 추가
				      this.selectedMembers.push(memberNo);
				    }
				},
            	//회원 퇴장 및 회원이 존재하지 않는 채팅방 삭제
				async leaveTheRoom() {
				    try {
				        const memberNo = this.memberNo;
				        const roomNo = this.roomNo;
				        const exitData = {
				            memberNo: memberNo,
				            roomNo: roomNo
				        };
				        const exitUrl = "${pageContext.request.contextPath}/rest/exitDmRoom";
				        await axios.post(exitUrl, exitData);
				        
				        const deleteUrl = "${pageContext.request.contextPath}/rest/deleteDmRoom";
				        await axios.post(deleteUrl, {roomNo: roomNo});
				        
				     	//변경된 채팅방 이름 삭제
				        await this.deleteRoomRename();
				        
				        //퇴장 메시지 전송
				        const message = {
				        type: 5,
				        room: roomNo,
				        content: this.memberNick + " 님이 퇴장하셨습니다."
					    };
					    this.socket.send(JSON.stringify(message));
				        
				        console.log("회원이 퇴장 하였습니다.");
				        window.location.href = "${pageContext.request.contextPath}/dm/channel";
				        
        				await this.fetchDmRoomList(); // 채팅방 목록 불러오기
        				this.roomNo=null;
				    } catch (error) {
				        console.error("회원 퇴장에서 오류가 발생하였습니다.", error);
				    }
				},
				//알림 메세지 전송
				sendWebSocketMessage(roomNo, content) {
					//퇴장 메세지
				    const message = {
				        type: 5,
				        room: roomNo,
				        content: content
				    };
				    this.socket.send(JSON.stringify(message));
				},
				//채팅방 이름 변경
				async changeRoomName() {
				    try {
				    	const checkUrl = "${pageContext.request.contextPath}/rest/existsRoomNo";
				        const renameUrl = "${pageContext.request.contextPath}/rest/changeRoomRename";
				        const insertUrl = "${pageContext.request.contextPath}/rest/roomRenameInsert";
				        
				        const resp = await axios.get(checkUrl, { params: { roomNo: this.roomNo } });
				        const data = {
					            roomNo: this.roomNo,
					            memberNo: this.memberNo,
					            roomRename: roomNameInput.value
					    };
				        if (resp.data === true) {
				            await axios.put(renameUrl, data);
				            console.log("채팅방 이름이 성공적으로 변경되었습니다.");
				        } else {
				            await axios.post(insertUrl, data);
				            console.log("채팅방 이름이 성공적으로 추가되었습니다.");
				        }
				
				        await this.fetchDmRoomList();
				    } catch (error) {
				        console.error("채팅방 이름 변경 중 오류가 발생했습니다.", error);
				    }
				},
				//채팅방 이름 변경 확인 버튼
				clickConfirmButton() {
				    if (this.roomName) {
				        this.changeRoomName()
				            .then(() => {
				                this.hideRoomNameModal();
				                this.fetchDmRoomList();
				            })
				            .catch(error => {
				                console.error("채팅방 이름 변경 중 오류가 발생했습니다.", error);
				            });
				    }
				},
		        //날짜 계산 함수
				dateCount(date) {
		        	const curTime = new Date();
		        	const postTime = new Date(date);
		        	const duration = Math.floor((curTime - postTime) / (1000 * 60));
		        	
		        	if(duration < 1){
		        		return "방금 전";
		        	}
		        	else if(duration < 60){
		        		return duration + "분 전";
		        	}
		        	else if(duration < 1440) {
		        		const hours = Math.floor(duration / 60);
		        		return hours + "시간 전"
		        	} 
		        	else {
		        		const days = Math.floor(duration / 1440);
		        		return days + "일 전";
		        	}
				},
				//읽지 않은 메세지 수 조회 및 수정
				async unreadDmCount() {
					const countUrl = "${pageContext.request.contextPath}/rest/unreadMessageCount";
					const updateUrl = "${pageContext.request.contextPath}/rest/changeUnreadDm";
					this.unreadMessage=[];
				    try {
				    	//조회
						const roomNoArray = this.dmRoomList.map(room => room.roomNo);
						for (const roomNo of roomNoArray) {
							const data = {
								roomNo: roomNo,
								memberNo: this.memberNo
							};
							const resp = await axios.get(countUrl, { params: data });
							//수정
							const unreadMessage = resp.data[0];
							this.unreadMessage.push(unreadMessage); //vue에 반환
							const updateData = {
									roomNo: roomNo,
									memberNo: this.memberNo,
									unreadMessage: unreadMessage
							};
							await axios.put(updateUrl, updateData);
						}
				    } catch (error) {
				        console.error("읽지 않은 메세지 수를 가져오지 못했습니다.", error);
				    }
				},
				//읽지 않은 메세지 수 수정
				async updateUnreadDm(roomNo) {
					const updateUrl = "${pageContext.request.contextPath}/rest/changeUnreadDm";
				    try {
						const data = {
							roomNo: roomNo,
							memberNo: this.memberNo,
							unreadMessage: 0
						};
						await axios.put(updateUrl, data);
						this.fetchDmRoomList();
				    } catch (error) {
				        console.error("읽지 않은 메세지 수 수정 오류", error);
				    }
				},
				//변경된 채팅방 이름 삭제
				async deleteRoomRename() {
				    const deleteUrl = `${pageContext.request.contextPath}/rest/deleteRoomRename`;
				    try {
				        await axios.delete(deleteUrl, {params:{roomNo:this.roomNo}});
				    } catch (error) {
				        console.error("읽지 않은 메세지 수 수정 오류", error);
				    }
				},
				//좋아요 눌렀을 때
				async dmLike(messageNo, index){
					const data = { type:8, messageNo:messageNo, memberNo:memberNo, room:this.roomNo };
                    this.socket.send(JSON.stringify(data));
                    if(this.memberLike[index]==0) this.memberLike[index]=1;
                    else this.memberLike[index]=0;
				},
				//메세지 읽음 표시 카운트 메서드
				setUnreadCountOnMessage(){
            		let joiner = this.userTimeList.length;
            		for(let j=0; j<this.messageList.length; j++){
	            		let count=0;
	            		for(let i=0; i<this.userTimeList.length; i++){
	            			let timeTemp=this.messageList[j].time
	            			if(this.userTimeList[i]>=timeTemp){
	            				count++;
	            			}
	            		}
	            		this.unreadCount[j]= joiner-count;
            		}
					
				},
            },
            watch:{
            	//검색
            	keyword:_.throttle(function(){
        			if(this.keyword=="") {
        				this.searchDmList = [];
        				return;
        			}
        			this.chooseDmSearch();
        		}, 200),
        		//메세지 읽음 표시
        		/* userTimeList:{
        			deep:true,
        			handler:function(){
        			}
        		}, */
            },
            computed:{ 
            	jsonText() {
            		return JSON.stringify({ type: 1, content: this.text });
            	},
            	//채팅방 이름 변경
            	roomNameLen(){
                    return this.roomName.length;
                },
            },
            created(){
            	//웹소켓 연결 코드
            	this.connect();
            	//메시지 불러오기
                this.loadMessage();
            	//로그인한 회원의 채팅방 목록
            	this.fetchDmRoomList();
            },
			mounted(){
				//Bootstrap modal 인스턴스를 초기화하고 저장
				this.createRoomModal = new bootstrap.Modal(this.$refs.memberListModal);
				this.exitModal = new bootstrap.Modal(this.$refs.exitModal);
				this.inviteModal = new bootstrap.Modal(this.$refs.inviteModal);
				this.roomNameModal = new bootstrap.Modal(this.$refs.roomNameModal);
				this.deleteMsgModal = new bootstrap.Modal(this.$refs.deleteMsgModal);
				this.membersInRoomModal = new bootstrap.Modal(this.$refs.membersInRoomModal);
				
				//검색창 초기화
			    $('#memberListModal').on('hidden.bs.modal', () => {
			    	this.keyword = '';
			        this.searchDmList = [];
			    });
			    $('#inviteModal').on('hidden.bs.modal', () => {
			    	this.keyword = '';
			        this.searchDmList = [];
			    });
	        },
        }).mount("#app");
    </script>
    
</body>
</html>