<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../template/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
   .media-height{
           width: 250px; 
           height:250px; 
           overflow: hidden;
        }
        .imgHover:hover{
         opacity:1!important;
      }
      .nomal{
         text-decoration: none;
         color:black;
      }
      .hide{
      	display:none;
      }
   	.profile-container {
  position: relative;
  display: inline-block;
}

.profile-preview {
  position: fixed;
  margin-left :30px;
  top: 200px;
  left: 270px;
  width: 400px;
  height: 420px;
  background-color: white;
  border: 1px solid gray;
  padding: 10px;
}

.profile-container:hover .profile-preview {
  display: block; 
}
.modalNickName{
	text-decoration: none;
	color:black;
	font-weight: bold;
}
.modalName{
	color:gray;
}

 .carousel-inner img {
        width: 470px;
        height: 480px;
        background-color: white;
    }

  .card-scroll{
        	overflow-y: auto;
        	-ms-overflow-style: none;
		}        
    .card-scroll::-webkit-scrollbar {
		    display: none;
	} 
    
    
	.moreText{
			display:inline-block!important;
	}
	.moreContent{
		height: auto!important;
	    overflow: auto!important;
	    width: auto!important;
	    white-space: normal!important;
	    text-overflow: inherit!important;
	}
	
	 .fullscreen{
            position:fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: 5555;
            
            background-color: rgba(0, 0, 0, 0.2);
/*             display: none; */
      }

     .fullscreen > .fullscreen-container{
         position: absolute;
         left: 50%;
         top: 50%;
         
         width: 1200px;
         height: 700px;
         
         transform: translate(-50%, -50%);
     }
     
        .like {
	color:red;
	cursor: pointer;
	}
	
	.fa-heart {
	cursor: pointer;
	}
	
	.isFollow {
	display: none;
	}
		p .card-text {
  		margin: 0 0 4px;
	}
	
.nav-tabs .nav-link {
  color: #333;
  font-size: 17px;
  padding: 14px 20px;
  border: none;
  background-color: transparent;
  position: relative;
}

.nav-tabs .nav-link.active {
  color: #000;
  border: none;
  background-color: transparent;
  font-weight: bold;
}

.nav-tabs .nav-link:before {
  content: "";
  position: absolute;
  bottom: 0; /* 변경: 선의 위치를 하단에 표시 */
  left: 0;
  width: 100%;
  height: 2px;
  background-color: #ccc;
  visibility: hidden;
  transition: all 0.3s ease-in-out;
}

.nav-tabs .nav-link.active:before,
.nav-tabs .nav-link:hover:before {
  visibility: visible;
  background-color: #c0c0c0;
}

/* 게시물 네모박스 */
.box {
	position: relative;
	width: 32.3%;;
	font-size:1.2em;
}
.box::after {
	display: block;
	content: "";
	padding-bottom: 100%;
}
.content-in-list,.content-box {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
}
.pages {
	position: absolute;
	top: 0;
	right: 0;
	z-index: 1;
	margin-top:0.5em;
	margin-right:0.5em;
	color:white;
}
.like-comment{
	position: absolute;
	z-index: 10;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color:white;
	cursor:default;
	display:none;
	min-width:100px;
	text-align:center;
}
.box:hover .content-box{
	background-color:rgba(34, 34, 34, 0.13);
	z-index:5;
}
.box:hover .like-comment{
	display:block;
}
.image-margin{
	margin-left:260px;
	margin-top:30px;
}
.truncate{
display: inline-block;
  max-width: 150px; /* Adjust the max-width value as needed */
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.truncate2{
display: inline-block;
  max-width: 100px; /* Adjust the max-width value as needed */
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}





</style>

      <div id="app" class="container-fluid" style="width:1300px;">
            <div class="row">
            
                <!-- 본인 여부에 따른 프로필 변경  -->
            <div class="col-4 text-center">
               <c:choose>
               <c:when test="${isOwner}">
                <img :src="profileUrl" width = "150" height="150" @click="openFileInput" class="image-margin rounded-circle">
             		<input ref="fileInput" type="file" @change="handleFileUpload" accept="image/*" style="display: none;">
                </c:when>       
                <c:otherwise> 
                  <img width="150" height="150" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+attachmentNo" class="image-margin rounded-circle" v-if="attachmentNo > 0">
                  <img src="${pageContext.request.contextPath}/static/image/user.jpg"  width="150" height="150" class="image-margin rounded-circle" v-else>
                </c:otherwise>
                </c:choose>           
            </div>
            <div class="col-4" style=" width:40%; margin-left:70px;">   
               <div class="col-7" style="display:flex;">
                  <div class="col-6" style="width:60%;">
                  <a href="#" class="btn btn-default" @click="showModal" style="font-size:20px;">
                  <span class="truncate">${memberDto.memberNick}</span></a>    
           </div>
              <c:choose>
              <c:when test="${isOwner}"> <!-- 본인 프로필 이라면 -->
                 <div class="col-5">
                  <a class="btn btn-secondary" href="${pageContext.request.contextPath}/member/setting?page=1">프로필 편집</a>
                  </div>
                  <div class="col-5" style=" width:20%;">
               <button class="btn btn-secondary" @click="recommend">
               		<i :class="iconClass"></i>
               </button>
               </div>
               <div class="col-5">
               <button class="btn btn-secondary" @click="myOptionModalShow" style="background-color: white; border:none;"><i class="fa-sharp fa-solid fa-gear" style="font-size:24px;"></i></button>
             </div>
              </c:when>
              <c:otherwise> <!-- 본인 프로필이 아니라면 -->
               <div class="col-5" style="width:30%;">
		             <button class="btn btn-primary" @click="follow(${memberDto.memberNo})" v-if="followCheckIf(${memberDto.memberNo})">팔로우</button>
					 <button class="btn btn-secondary" @click="unFollow(${memberDto.memberNo})" v-else>팔로잉</button>
               </div>
               <div class="col-5"  style=" width:50%;">
               		<button class="btn btn-secondary" @click="moveToDmPage(${memberDto.memberNo})" style="cursor: pointer;">메시지 보내기</button>
               </div>
               
               <div class="col-5" style="width:40%;">
               <button class="btn btn-secondary" @click="showModal2"><i class="fa-solid fa-ellipsis"></i></button>
             </div>
              </c:otherwise>
              </c:choose>
              
             </div>
               <div class="row mt-4" style="width:130%;">
                  <div class="col-6" style="display:flex; margin-left:10px;">
                     <div class="col-5">
                        <span>게시물 
                           <span style="font-weight: bold;">${postCounts}</span>
                        </span>
                     </div>
                     <div class="col-5" @click="followerModalShow" style="cursor:pointer;">
                        <span>팔로워
                        <span style="font-weight: bold;">{{totalFollowerCnt}}</span>
                         </span>
                     </div>
                     <div class="col-5" @click="followModalShow" style="cursor:pointer;">
                        <span>팔로우
                        <span style="font-weight: bold;">{{totalFollowCnt}}</span>
                         </span>
                     </div>
                  </div>   
               </div>
      <div class="row mt-4">
		  <p style="margin-left: 15px; font-size: 20px;">${memberDto.memberName}</p>
		  <div style="width: 500px; overflow: hidden; white-space: pre-wrap;">
		    <p style="font-size:12px;">${memberDto.memberMsg}</p>
		  </div>
	</div>




               
            </div>
            </div>
            <!-- 친구 추천 목록 -->
    
            <div  style="display: flex; flex-direction: column; width: 830px; height:280px; background-color: white; border:1px solid gray; margin: 0 auto; margin-top:12px; border:none;" v-if="recommendFriends">
        		<div class="recommend-id" style="display:flex; justify-content: space-between;">
        			<span style="color:gray; font-weight: bold;">추천계정</span>
        			<a class="" style="text-decoration: none; font-weight: bold; cursor:pointer;" @click="recommendFriendsAllListModalShow">모두 보기</a>
        		</div>  
        	<div v-if="recommendFriendsList.length === 0">
        		<div class="text-center">
	        		<i class="fa-sharp fa-solid fa-circle-exclamation"></i> &nbsp;추천을 읽어들일 수 없습니다. <br>
	        		<i class="fa-solid fa-spinner fa-spin" v-show="isLoading"></i>
	        		<div class="text-center">        		
	        			<i class="fa-solid fa-rotate-right fa-xl"  @click="recommendListReloading" v-show="!isLoading"></i>
	        		</div>
        		</div>
        	</div>
        	
			<div class="card-container" style="display:flex; margin-top:20px;" v-else>
			<!-- 이전 페이지로 이동하는 버튼 -->
				<div class="button-container" style="display: flex; justify-content: center; align-items: center;">
					<i class="fa-sharp fa-solid fa-angle-left"  @click="currentPage--" :class="{'hide' : currentPage === 0}" style="height:24px; weight:24px; margin-left:5px; position:absolute; color:gray;"></i>
				</div>

			  <div v-for="(item, itemIndex) in displayedItems" :key="itemIndex" style="display:flex;">
			    <div class="card" style="width: 170px; height: 185px; margin-left: 30px; box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);">
			      <div class="ms-auto" style="margin-right:8px;">
			      	<span @click="deleteRecommendFriend(item.memberNo)">x</span>
			      </div>
			      <div class="profile d-flex justify-content-center align-items-start" style="text-align: center; margin-left:60px;">
					  <img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+item.attachmentNo" width="54" height="54"  v-if="item.attachmentNo > 0" class="rounded-circle">
					  <img src="${pageContext.request.contextPath}/static/image/user.jpg" width="54" height="54" class="rounded-circle" v-else>
				  </div>
			      <div class="recommend-nickname d-flex justify-content-center align-items-start" style="margin-top:10px;">
			        <span class="truncate2">{{ item.memberNick }}</span>
			      </div>
			      <div class="recommend-name d-flex justify-content-center align-items-start">
			        <span style="margin-top:5px;" class="truncate2">{{ item.memberName }}</span>
			      </div>
			      <div class="recommend-name d-flex justify-content-center align-items-start">
			      <!-- 다음 페이지로 이동하는 버튼 -->
			        <button class="btn btn-primary" style="width: 65%;" @click="follow(item.memberNo)" v-show="followCheckIf(item.memberNo)" :class="{'hide' : item.followFollower == ${memberNo}}">팔로우</button>
			        <button class="btn btn-secondary" style="width: 65%;" @click="unFollow(item.memberNo)" v-show="!followCheckIf(item.memberNo)" :class="{'hide' : item.followFollower == ${memberNo}}">팔로잉</button>
			      </div>
			    </div>
			  </div>
		<div class="button-container" style="display: flex; justify-content: center; align-items: center;">
  			<i class="fa-sharp fa-solid fa-angle-right" @click="currentPage++"  :class="{'hide':currentPage === paginatedRecommendFriends.length - 1}" 
  			style="height: 24px; weight: 24px; margin-left:50px; position:absolute; color:gray;"></i>
		</div>
			</div>



            </div>
            
            
     <!-- 게시물 시작 -->
     <!-- 비공개 계정 -->
<div class="position-absolute mt-5 start-50 translate-middle-x media-width" style="display: flex; flex-direction: column; width: 770px; height: 700px;" v-if="(settingHide === 3 && !isOwner) && settingHide === 2 && followCheckIf(${memberDto.memberNo}) && !isOwner">
 	   <div style="display: flex;flex-direction: column; justify-content: center; align-items: center;">    
   <img src="${pageContext.request.contextPath}/static/image/lock.png" width="200" height="200">
   <h4 class="mt-5 text-center">비공개 계정입니다 사진 및 동영상을 보려면 팔로우하세요.</h4>
   </div>
</div>



<!-- 공개 계정 -->
<!-- 게시물이 없는 경우 || 본인 프로필이 아닐 때 -->
<div class="position-absolute mt-5 start-50 translate-middle-x media-width" style="display: flex; flex-direction: column; width: 770px; height:700px;" v-else> 
    <div class="mt-5" style="display: flex;flex-direction: column; justify-content: center; align-items: center;" v-if="myBoardList.length == 0 && !isOwner">    
   <i class="fa-solid fa-camera fa-2xl" style="font-size:100px;"></i>
   <h2 class="mt-5">게시물 없음</h2>
   </div>
   
	<!-- 게시물이 없는 경우 || 본인 프로필일 때
   <div class="mt-5" style="display: flex;flex-direction: column; justify-content: center; align-items: center;" v-if="myBoardList.length == 0 && isOwner" @click="boardInsert">    
   <i class="fa-solid fa-camera fa-2xl" style="font-size:100px;"></i>
   <h2 class="mt-5">사진 공유</h2>
   <p>사진을 공유하면 회원님의 프로필에 표시됩니다.</p>
  
   </div> -->
   <div class="mypage-tab" v-if="isOwner">
    <ul class="nav nav-tabs" style="width: 100%;">
    <li class="nav-item col-6">
       <a class="nav-link" :class="{'active': actTab === 'boardTab'}" @click="changeTab2('boardTab')" style="font-size:17px; padding:14px 0; cursor:pointer;">
       <i class="fa-solid fa-chess-board"></i>
       게시물
       </a>
    </li>
    <li class="nav-item col-6">
      <a class="nav-link" :class="{'active': actTab === 'bookmarkTab'}" @click="changeTab2('bookmarkTab')" style="font-size:17px; padding:14px 0; cursor:pointer;">
      <i class="fa-solid fa-bookmark"></i>
      저장됨
      </a>
      </li>
  </ul>
  </div>
  <div class="mypage-tab" v-else>
  <ul class="nav nav-tabs" style="width: 100%;">
    <li class="nav-item col-6">
       <a class="nav-link" :class="{'active': actTab === 'boardTab'}" @click="changeTab2('boardTab')" style="font-size:17px; padding:14px 0;">
       <i class="fa-solid fa-chess-board"></i>
       게시물
       </a>
    </li>
    </ul>
  </div>
   
  
	<!-- 게시물 목록 -->
    <div style="margin-bottom:10px;display: flex; width: 110%;" v-if="actTab == 'boardTab'"> 
    <!-- 게시물이 없는 경우 || 본인 프로필일 때 -->
   <div class="mt-5" style="display: flex;flex-direction: column; justify-content: center; align-items: center; margin-left:200px;" v-if="myBoardList.length == 0 && isOwner" @click="boardInsert">    
   <i class="fa-solid fa-camera fa-2xl" style="font-size:100px;"></i>
   <h2 class="mt-5">사진 공유</h2>
   <p style="min-width:400px; margin-left:40px;">사진을 공유하면 회원님의 프로필에 표시됩니다.</p>
   </div>
   
   
    	 <div class="row d-flex justify-content-start w-100">
	    	<div class="box m-1" v-for="(board,index) in myBoardList" :key="index" @click="detailViewOn(index)">
	    		<video class="content-in-list" :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" v-if="board.boardAttachmentList.length>0 && board.boardAttachmentList[0].video"
						style="object-fit:cover" :autoplay="MemberSetting.videoAuto" muted controls :loop="MemberSetting.videoAuto"></video>
				<img class='content-in-list' v-if="board.boardAttachmentList.length>0 && !board.boardAttachmentList[0].video"
						 :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" >
			<!-- 쉐도우용 더미 -->
				<div class="content-box" ></div>
			<!-- 사진 여러장일 때 -->
    		 	<i class="fa-regular fa-copy pages" v-if="board.boardAttachmentList.length>1"></i>
    		<!-- 좋아요, 댓글 개수 -->
				<div class="like-comment">
					<span v-if="(MemberSetting.watchLike && board.boardWithNickDto.boardLikeValid==0)||board.boardWithNickDto.memberNo==${sessionScope.memberNo}"><i class="fa-solid fa-heart"></i> {{board.boardWithNickDto.boardLike}}</span> 
					<span v-if="board.boardWithNickDto.boardReplyValid==0" class="ms-3"><i class="fa-solid fa-comment"></i> {{board.boardWithNickDto.boardReply}}</span>
				</div>
    		</div>
     
    	</div>
    </div>
    <!-- 북마크 게시물 목록 -->
    <div style="margin-bottom:10px; width: 110%;" v-else-if="actTab == 'bookmarkTab'"> 
    	<div class="d">
    		<span style="color:gray; font-size: 12px;">저장한 내용은 회원님만 볼 수 있습니다.</span>
    	</div>	
    	<div v-if="bookmarkMyPostList.length === 0" style="display:flex; flex-direction: column; align-items: center; margin-top:30px;">
		  <img src="${pageContext.request.contextPath}/static/image/bookmark-circle.PNG" width="62" height="62" style="margin-bottom: 10px;">
		  <h2>저장</h2>
		 	<div style="max-width:400px;">
		 		<span class="text-center">다시 보고 싶은 사진과 동영상을 저장하세요. 콘텐츠를 저장해도 다른 사람에게 알림이 전송되지 않으며, 저장된 콘텐츠는 회원님만 볼 수 있습니다.</span>
		 	</div>
		</div>

    	 <div class="row d-flex justify-content-start w-100">
	    	<div class="box m-1" v-for="(bookmark,index) in bookmarkMyPostList" :key="bookmark.boardNo" @click="detailViewOn2(index)">
	    		<video class="content-in-list" :src="'${pageContext.request.contextPath}'+bookmark.boardAttachmentList[0].imageURL" v-if="bookmark.boardAttachmentList.length>0 && bookmark.boardAttachmentList[0].video"
						style="object-fit:cover" :autoplay="MemberSetting.videoAuto" muted controls :loop="MemberSetting.videoAuto"></video>
				<img class='content-in-list' v-if="bookmark.boardAttachmentList.length>0 && !bookmark.boardAttachmentList[0].video"
						 :src="'${pageContext.request.contextPath}'+bookmark.boardAttachmentList[0].imageURL" >
			<!-- 쉐도우용 더미 -->
				<div class="content-box" ></div>
			<!-- 사진 여러장일 때 -->
    		 	<i class="fa-regular fa-copy pages" v-if="bookmark.boardAttachmentList.length>1"></i>
    		<!-- 좋아요, 댓글 개수 -->
				<div class="like-comment">
					<span v-if="(MemberSetting.watchLike && bookmark.boardWithNickDto.boardLikeValid==0)||bookmark.boardWithNickDto.memberNo==${sessionScope.memberNo}"><i class="fa-solid fa-heart"></i> {{bookmark.boardWithNickDto.boardLike}}</span> 
					<span v-if="bookmark.boardWithNickDto.boardReplyValid==0" class="ms-3"><i class="fa-solid fa-comment"></i> {{bookmark.boardWithNickDto.boardReply}}</span>
				</div>
    		</div>
    	</div>
    </div>
    
</div>
<!-- 게시물 영역 끝 --> 

<!-- ---------------------------------게시물 상세보기 모달(게시물)-------------------------- -->

<div v-if="detailView" class="container-fluid fullscreen" @click="closeDetail">
<div class="p-4 mt-2 ms-4 d-flex justify-content-end">
		<h2 class="btn btn-default" @click="closeDetail()" style="font-size: 30px; color:#FFFFFF;">X</h2>
	</div>
	<div class="row fullscreen-container" @click.stop>
		<div class="col-7 offset-1" style="padding-right: 0;padding-left: 0;">
			<div :id="'detailCarousel'+ detailIndex" class="carousel slide">
                <div class="carousel-indicators">
                  <button  v-if="myBoardList[detailIndex].boardAttachmentList.length > 1" v-for="(attach, index2) in myBoardList[detailIndex].boardAttachmentList" :key="index2" type="button" :data-bs-target="'#detailCarousel'+ detailIndex" :data-bs-slide-to="index2" :class="{'active':index2==0}" :aria-current="index2==0?true:false" :aria-label="'Slide '+(index2+1)"></button>
                </div>
               
                <div class="carousel-inner">
                  <div v-for="(attach, index2) in myBoardList[detailIndex].boardAttachmentList" :key="index2" class="carousel-item" :class="{'active':index2==0}">
                  	<video  style="width:700px; height:700px; object-fit:cover" class="d-block" :src="'${pageContext.request.contextPath}'+attach.imageURL" v-if="attach.video"
							:autoplay="MemberSetting.videoAuto" muted controls :loop="MemberSetting.videoAuto"></video> 
                   	<img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+attach.attachmentNo" class="d-block" @dblclick="likePost(board.boardWithNickDto.boardNo,detailIndex)" style="width:700px; height:700px;" v-else> 
                  </div>
                </div>
               
                <button v-if="myBoardList[detailIndex].boardAttachmentList.length > 1" class="carousel-control-prev" type="button" :data-bs-target="'#detailCarousel' + detailIndex" data-bs-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Previous</span>
                </button>
                <button v-if="myBoardList[detailIndex].boardAttachmentList.length > 1"  class="carousel-control-next" type="button" :data-bs-target="'#detailCarousel' + detailIndex" data-bs-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Next</span>
                </button> 
                
           </div>
		</div>
           
         <div class="col-4" style="padding-left: 0;">
        	<div class="card bg-light" style="border-radius:0; height: 700px">
           		<div class="card-header">
       				<div class="row">
           				<div class='col-10'>
			           		<img class="profile rounded-circle" :src="profileUrl">
		           			<a class="btn btn-default" style="padding: 0 0 0 0; margin-left: 0.5em;" :href="'${pageContext.request.contextPath}/member/'+myBoardList[detailIndex].boardWithNickDto.memberNick"><b>{{myBoardList[detailIndex].boardWithNickDto.memberNick}}</b></a>
           				</div>
           				<div class="col d-flex justify-content-center align-items-center">
           					<i class="fa-solid fa-ellipsis modal-click-btn-neutral" style="display:flex; flex-direction: row-reverse; font-size:1.2em" @click="showAdditionalMenuModal(myBoardList[detailIndex].boardWithNickDto.boardNo, myBoardList[detailIndex].boardWithNickDto.memberNo, 'board')"></i>
           				</div>
           			</div>
           		</div>
				
				<div class="card-body card-scroll" ref="scrollContainer"  style="height:490px; padding-top: 0px; padding-left:0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<p class="card-text" style="margin-left: 0.5em;">{{myBoardList[detailIndex].boardWithNickDto.boardContent}}<br>
					<br v-if="myBoardList[detailIndex].boardTagList.length > 0">
                    <a @click="moveToTagPage(tag.tagName)" v-for="(tag, index3) in myBoardList[detailIndex].boardTagList" :key="index3" style="margin-right: 0.5em; color: blue; cursor: pointer;">\#{{tag.tagName}}</a>
					</p>
					
					
					<div v-if="replyList.length > 0" v-for="(reply,index) in replyList" :key="index" class="card-text" :class="{'childReply':reply.replyParent!=0}" style="position: relative;">
						<a :href="'${pageContext.request.contextPath}/member/'+ replyList[index].memberNick" style="color:black;text-decoration:none; position:relative;">
							<img class="rounded-circle" v-if="replyList[index].attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+ replyList[index].attachmentNo" width="45" height="45" style="border-radius: 70%;position:absolute; margin-top:9px; margin-left: 4px">
							<img class="rounded-circle" v-else src="${pageContext.request.contextPath}/static/image/user.jpg" style="border-radius: 70%;position:absolute; margin-top:9px; margin-left: 4px">
							
						<p style="padding-left: 3.5em; margin-bottom: 1px; font-size: 0.9em; margin-left: 3.5px; font-weight: bold;">{{replyList[index].memberNick}}</p>
												
						</a>
						<p style="padding-left:3.5em;margin-bottom:1px;font-size:0.9em; margin-left: 3.5px;">{{replyList[index].replyContent}}</p>
						<div class="row" style="height: 25px">
							<div class="col-10">
								<p style="padding-left:4.0em;margin-bottom:3px;font-size:0.8em; color:gray;">{{dateCount(replyList[index].replyTimeAuto)}} &nbsp; 좋아요 {{replyLikeCount[index]}}개 &nbsp;
									<a style="cursor: pointer;" v-if="reply.replyParent==0" @click="reReply(replyList[index].replyNo)">답글 달기</a>  
									<i :class="{'fa-heart': true, 'like':isReplyLiked[index],'ms-2':true, 'fa-solid': isReplyLiked[index], 'fa-regular': !isReplyLiked[index]}" @click="likeReply(reply.replyNo,index)" style="font-size: 0.9em;"></i>
									
								</p>
							</div>
						<!-- 댓글 신고창 -->
							<div class="col-2 p-0 d-flex justify-content-center">
								<p class="d-flex align-items-center"><i class="fa-solid fa-ellipsis modal-click-btn-neutral" style="display:flex; flex-direction: row-reverse;" @click="showAdditionalMenuModal(reply.replyNo, reply.replyMemberNo, 'reply',index,detailIndex)"></i></p>
							</div>
						</div>
					</div>
					
					<div v-else class="card-text" style="position: relative;">
						<b style="margin-left: 0.5em;">첫 댓글을 작성해보세요</b>
					</div>
					
					
				</div>
				<hr style="margin-top: 0; margin-bottom: 0;">
				
				<div class="card-body"  style="height:110px; padding-top: 0px; padding-left: 0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<div class="d-flex row">
						<div class="col-10">
							<span class="card-text" style="margin: 0 4px 4px 0; padding-left: 0.25em;">
								<i :class="{'fa-heart': true, 'like':isLiked[detailIndex],'ms-2':true, 'fa-solid': isLiked[detailIndex], 'fa-regular': !isLiked[detailIndex]}" @click="likePost(myBoardList[detailIndex].boardWithNickDto.boardNo,detailIndex)" style="font-size: 27px;"></i>
							</span>
							<span class="card-text" style="margin: 0 0 4px 0; padding-left: 0.5em;">
								<i class="fa-regular fa-message mb-1" @click="moveToDmPage(${memberDto.memberNo})" style="font-size: 25px; cursor: pointer;"></i>
							</span>
						</div>
						
						<div class="col-1 p-0 flex-grow-1">
							<span class="ms-4">
								<i class="fa-regular fa-bookmark"  @click="bookmarkInsert(myBoardList[detailIndex].boardWithNickDto.boardNo)" v-show="bookmarkChecked(myBoardList[detailIndex].boardWithNickDto.boardNo)" style="font-size:25px;"></i>
                           		<i class="fa-solid fa-bookmark" @click="bookmarkInsert(myBoardList[detailIndex].boardWithNickDto.boardNo)" v-show="!bookmarkChecked(myBoardList[detailIndex].boardWithNickDto.boardNo)" style="font-size:25px;"></i>
	                         </span>
                      </div>
					</div>
					<p class="card-text" style="margin: 0 0 4px 0; cursor: pointer;"  @click="showLikeListModal(myBoardList[detailIndex].boardWithNickDto.boardNo)"><b style="margin-left: 0.5em;">좋아요 {{boardLikeCount[detailIndex]}}개</b></p>
					<p class="card-text" style="margin: 0 0 0 0.5em">{{dateCount(myBoardList[detailIndex].boardWithNickDto.boardTimeAuto)}}</p>
					
				</div>
				
				
				
				<div class="input-group">
					<input ref="replyInput" type="text" class="form-control" :placeholder="placeholder" v-model="replyContent" style="border: none;" aria-label="Recipient's username" aria-describedby="button-addon2" @input="replyContent = $event.target.value" @keyup.enter="replyInsert(detailIndex)">
					<button class="btn" type="button" id="button-addon2" style="border-top-right-radius: 0!important;" @click="replyInsert(detailIndex)">작성</button>
				</div>
								        	
        	</div> 
        </div>
	</div>
</div>
<!-- ---------------------------------게시물 상세보기 모달(북마크)-------------------------- -->
<div v-if="detailView2" class="container-fluid fullscreen" @click="closeDetail2">
<div class="p-4 mt-2 ms-4 d-flex justify-content-end">
		<h2 class="btn btn-default" @click="closeDetail2" style="font-size: 30px; color:#FFFFFF;">X</h2>
	</div>
	<div class="row fullscreen-container" @click.stop>
		<div class="col-7 offset-1" style="padding-right: 0;padding-left: 0;">
			<div :id="'detailCarousel'+ detailIndex2" class="carousel slide">
                <div class="carousel-indicators">
                  <button v-if="bookmarkMyPostList[detailIndex2].boardAttachmentList.length > 1" v-for="(attach, index2) in bookmarkMyPostList[detailIndex2].boardAttachmentList" :key="index2" type="button" :data-bs-target="'#detailCarousel'+ detailIndex2" :data-bs-slide-to="index2" :class="{'active':index2==0}" :aria-current="index2==0?true:false" :aria-label="'Slide '+(index2+1)"></button>
                </div>
               
                <div class="carousel-inner">
                  <div  v-for="(attach, index2) in bookmarkMyPostList[detailIndex2].boardAttachmentList" :key="index2" class="carousel-item" :class="{'active':index2==0}">
                  	<video  style="width:700px; height:700px; object-fit:cover" class="d-block" :src="'${pageContext.request.contextPath}'+attach.imageURL" v-if="attach.video"
							:autoplay="MemberSetting.videoAuto" muted controls :loop="MemberSetting.videoAuto" @dblclick="likePost(board.boardWithNickDto.boardNo,detailIndex2)"></video> 
                   	<img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+attach.attachmentNo" class="d-block" @dblclick="likePost(board.boardWithNickDto.boardNo,detailIndex2)" style="width:700px; height:700px;"> 
                  </div>
                </div>
               
                <button v-if="bookmarkMyPostList[detailIndex2].boardAttachmentList.length > 1" class="carousel-control-prev" type="button" :data-bs-target="'#detailCarousel' + detailIndex2" data-bs-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Previous</span>
                </button>
                <button v-if="bookmarkMyPostList[detailIndex2].boardAttachmentList.length > 1"  class="carousel-control-next" type="button" :data-bs-target="'#detailCarousel' + detailIndex2" data-bs-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Next</span>
                </button> 
                
           </div>
		</div>
		<div class="col-4" style="padding-left: 0;">
        	<div class="card bg-light" style="border-radius:0; height: 700px">
           		<div class="card-header">
           		    <div class="row">
           				<div class='col-10'>
			           		<img class="profile" :src="'${pageContext.request.contextPath}'+bookmarkMyPostList[detailIndex2].boardWithNickDto.imageURL">
		           			<a class="btn btn-default" style="padding: 0 0 0 0; margin-left: 0.5em;" :href="'${pageContext.request.contextPath}/member/'+bookmarkMyPostList[detailIndex2].boardWithNickDto.memberNick"><b>{{bookmarkMyPostList[detailIndex2].boardWithNickDto.memberNick}}</b></a>
           				</div>
           				<div class="col d-flex justify-content-center align-items-center">
           					<i class="fa-solid fa-ellipsis modal-click-btn-neutral" style="display:flex; flex-direction: row-reverse; font-size:1.2em" @click="showAdditionalMenuModal(bookmarkMyPostList[detailIndex2].boardWithNickDto.boardNo, bookmarkMyPostList[detailIndex2].boardWithNickDto.memberNo, 'board')"></i>
           				</div>
           			</div>
	           		<!-- <img class="profile" :src="profileUrl(detailIndex)"> -->
           		</div>
				
				<div class="card-body card-scroll" ref="scrollContainer"  style="height:490px; padding-top: 0px; padding-left:0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<p class="card-text" style="margin-left: 0.5em;">{{bookmarkMyPostList[detailIndex2].boardWithNickDto.boardContent}}<br>
					<br v-if="bookmarkMyPostList[detailIndex2].boardTagList.length > 0">
                           <a @click="moveToTagPage(tag.tagName)" v-for="(tag, index3) in bookmarkMyPostList[detailIndex2].boardTagList" :key="index3" style="margin-right: 0.5em; color: blue; cursor: pointer;">\#{{tag.tagName}}</a>
					</p>
					
					
					<div v-if="replyList.length > 0" v-for="(reply,index) in replyList" :key="index" class="card-text" :class="{'childReply':reply.replyParent!=0}" style="position: relative;">
						<a :href="'${pageContext.request.contextPath}/member/'+ replyList[index].memberNick" style="color:black;text-decoration:none; position:relative;">
							<img class="rounded-circle" v-if="replyList[index].attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+ replyList[index].attachmentNo" width="45" height="45" style="border-radius: 70%;position:absolute; margin-top:9px; margin-left: 4px">
							<img class="rounded-circle" v-else src="${pageContext.request.contextPath}/static/image/user.jpg" style="border-radius: 70%;position:absolute; margin-top:9px; margin-left: 4px">
							
						<p style="padding-left: 3.5em; margin-bottom: 1px; font-size: 0.9em; margin-left: 3.5px; font-weight: bold;">{{replyList[index].memberNick}}</p>
												
						</a>
						<p style="padding-left:3.5em;margin-bottom:1px;font-size:0.9em; margin-left: 3.5px;">{{replyList[index].replyContent}}</p>
						<div class="row" style="height: 25px">
							<div class="col-10">
								<p style="padding-left:4.0em;margin-bottom:3px;font-size:0.8em; color:gray;">{{dateCount(replyList[index].replyTimeAuto)}} &nbsp; 좋아요 {{replyLikeCount[index]}}개 &nbsp;
									<a style="cursor: pointer;" v-if="reply.replyParent==0" @click="reReply(replyList[index].replyNo)">답글 달기</a>  
									<i :class="{'fa-heart': true, 'like':isReplyLiked[index],'ms-2':true, 'fa-solid': isReplyLiked[index], 'fa-regular': !isReplyLiked[index]}" @click="likeReply(reply.replyNo,index)" style="font-size: 0.9em;"></i>
									
								</p>
							</div>
						<!-- 댓글 신고창 -->
							<div class="col-2 p-0 d-flex justify-content-center">
								<p class="d-flex align-items-center"><i class="fa-solid fa-ellipsis modal-click-btn-neutral" style="display:flex; flex-direction: row-reverse;" @click="showAdditionalMenuModal(reply.replyNo, reply.replyMemberNo, 'reply',index,detailIndex)"></i></p>
							</div>
						</div>
					</div>
					
					<div v-else class="card-text" style="position: relative;">
						<b style="margin-left: 0.5em;">첫 댓글을 작성해보세요</b>
					</div>
					
					
				</div>
				<hr style="margin-top: 0; margin-bottom: 0;">
				
				<div class="card-body"  style="height:110px; padding-top: 0px; padding-left: 0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<div class="d-flex row">
						<div class="col-10">
							<span class="card-text" style="margin: 0 4px 4px 0; padding-left: 0.25em;">
								<i :class="{'fa-heart': true, 'like':isLiked2[detailIndex2],'ms-2':true, 'fa-solid': isLiked2[detailIndex2], 'fa-regular': !isLiked2[detailIndex2]}" @click="likePost2(bookmarkMyPostList[detailIndex2].boardWithNickDto.boardNo,detailIndex2)" style="font-size: 27px;"></i>
							</span>
							<span class="card-text" style="margin: 0 0 4px 0; padding-left: 0.5em;">
								<i class="fa-regular fa-message mb-1" style="font-size: 25px; "></i>
							</span>
						</div>
						
						<div class="col-1 p-0 flex-grow-1">
							<span class="ms-4">
								<i class="fa-regular fa-bookmark"  @click="bookmarkInsert(bookmarkMyPostList[detailIndex2].boardWithNickDto.boardNo)" v-show="bookmarkChecked(bookmarkMyPostList[detailIndex2].boardWithNickDto.boardNo)" style="font-size:25px;"></i>
	                           	<i class="fa-solid fa-bookmark" @click="bookmarkInsert(bookmarkMyPostList[detailIndex2].boardWithNickDto.boardNo)" v-show="!bookmarkChecked(bookmarkMyPostList[detailIndex2].boardWithNickDto.boardNo)" style="font-size:25px;"></i>
	                         </span>
                      </div>
					</div>
					<p class="card-text" style="margin: 0 0 4px 0; cursor: pointer;" @click="showLikeListModal(bookmarkMyPostList[detailIndex2].boardWithNickDto.boardNo)"><b style="margin-left: 0.5em;">좋아요 {{boardLikeCount2[detailIndex2]}}개</b></p>
					<p class="card-text" style="margin: 0 0 0 0.5em">{{dateCount(bookmarkMyPostList[detailIndex2].boardWithNickDto.boardTimeAuto)}}</p>
					
				</div>
				
				<div class="input-group">
					<input ref="replyInput" type="text" class="form-control" :placeholder="placeholder" v-model="replyContent" style="border: none;" aria-label="Recipient's username" aria-describedby="button-addon2" @input="replyContent = $event.target.value" @keyup.enter="replyInsert2(detailIndex2)">
					<button class="btn" type="button" id="button-addon2" style="border-top-right-radius: 0!important;" @click="replyInsert2(detailIndex2)">작성</button>
				</div>
								        	
        	</div> 
			
		</div>
	</div>
</div>

  
      <!-- Modal 창 영역 -->
<!-- 이 계정 정보 -->
                   <div class="modal" tabindex="-1" role="dialog" id="modal03" data-bs-backdrop="static" ref="modal03" @click.self="hideModal">
            		 <div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
                		<div class="modal-content">
                   		 	<div class="modal-header" style="display:flex; justify-content: center;">
                        		<h5 class="modal-title" style="text-align:center;">
                            <img :src="profileUrl" width = "150" height="150" class="rounded-circle">
                      			<div class="nickname">${memberDto.memberNick}</div>   
                   			<div class="content" style="text-align:left;">
                      				<p style="font-size: 12px; color:gray;">신뢰할 수 있는 커뮤니티를 유지하기 위해 Insider 계정에 대한 정보가 표시됩니다</p>
		                      <div class="date" style="display:flex;">
			                      <i class="fa-solid fa-calendar-days"></i>&nbsp;&nbsp;
			                      <h5>최근 로그인 일자</h5>
		                      </div>
		                      <p style="font-size:12px; color:gray;">
		                      ${memberDto.memberLogin}
		                      </p>
		                      <div class="location" style="display:flex;">
			                      <i class="fa-solid fa-location-dot"></i>&nbsp;&nbsp;
			                      <h5>계정 기본 위치</h5>
		                      </div>
                      <p style="font-size:12px; color:gray;">{{location}}</p>
                   		</div>   
                        	</h5>
                    	</div>   
                        <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
                		</div>      
            		</div>
        		</div>
        
<!--    이 계정 정보 모달     -->
          <div class="modal" tabindex="-1" role="dialog" id="myOptionModal"
                            data-bs-backdrop="static"
                            ref="addtionModal" @click.self="hideModal2">
            <div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
                <div class="modal-content">
	                <div class="modal-body p-0">
						<div class="row p-3">
							<div class="col d-flex justify-content-center align-items-center">
								<h5 class="modal-click-btn-negative" style="margin:0;" @click="blockModalShow">차단</h5>
							</div>
						</div>
						<hr class="m-0">
						<div class="row p-3" >
							<div class="col d-flex justify-content-center align-items-center">
								<h5 style="margin:0; cursor:pointer" @click="showReportMenuModal(${memberDto.memberNo},${memberDto.memberNo},'member')">신고</h5>
							</div>
						</div>
						<hr class="m-0">
						<div class="row p-3" >
							<div class="col d-flex justify-content-center align-items-center">
								<h5 style="margin:0; cursor:pointer" @click="accountView">이 계정 정보</h5>
							</div>
						</div>
						<hr class="m-0">
						<div class="row p-3" >
							<div class="col d-flex justify-content-center align-items-center">
								<h5 class="modal-click-btn-neutral" style="margin:0;" @click="hideModal2">취소</h5>
							</div>
						</div>
					</div>
                     

                   
                   
                </div>      
            </div>
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="blockModal"
                            data-bs-backdrop="static"
                            ref="blockModal" @click.self="blockModalHide">
            <div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%; width:30%">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center; flex-direction: column;">
                    	<div class="row">
                    		<div class="col">
			                    <h5 class="modal-title" style="text-align:center;">
		                        <span style="font-weight: bold;">${memberDto.memberNick}</span>님을 차단하시겠어요?
			                    </h5>
                    		</div>
                    	</div>
                    	<div class="row">
                    		<div class="col" style="max-width:80%; margin: auto; margin-top : 15px;">
		                        상대방은 Insider에서 회원님의 프로필, 게시물 및 스토리를 찾을 수 없게 됩니다. Insider은 회원님이 차단한 사실을 상대방에게 알리지 않습니다.                     
                    		</div>
                    	</div>
	                     <div class="content" style="font-size:12px; text-align:center;">
	                     </div>
                    </div>
                    <div class="modal-header align-items-center" style="display:flex; justify-content: center;">
                          <h6 @click="blockUser" class="modal-click-btn-negative m-0">차단</h6>
                    </div>
                     <div class="modal-header align-items-center" style="display:flex; justify-content: center;" >
                         <h6 class="modal-click-btn-neutral m-0" @click="blockModalHide" >취소</h6>
                    </div>
                   
                   
                </div>      
            </div>
        </div>
        
         <div class="modal" tabindex="-1" role="dialog" id="blockResultModal" style="z-index:9999"
                            data-bs-backdrop="static"
                            ref="blockResultModal" @click.self="blockResultModalHide">
            <div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%; width:30%">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center; flex-direction: column;">
                     <h5 class="modal-title" style="text-align:center;">
                       {{reportBoardData[5]}}님을 차단했습니다.
                     </h5>
                     <div class="content" style="font-size:12px; text-align:center;">
                        <p style="font-size:12px; color:gray;">상대방의 프로필에서 언제든지 차단을 해제할 수 있습니다.</p>                    
                     </div>
                     </div>
                     <div class="model-header" style="text-align:center;">
                     <button type="button" class="btn btn-default" data-bs-dismiss="modal" style="color:red;">닫기</button>   
                     </div>
                     
            </div>
        </div>
      
        </div>
        
<!--   옵션 모달    -->
          <div class="modal" tabindex="-1" role="dialog" id="myOptionModal"
                            data-bs-backdrop="static"
                            ref="myOptionModal" @click.self="myOptionModalHide">
            <div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
                   <div class="modal-content">
	                 <div class="modal-body p-0">
						<div class="row p-3">
							<div class="col d-flex justify-content-start align-items-center">
								<a class="nomal"><h5 style="margin:0; cursor:default">설정 및 개인정보</h5></a>
							</div>
						</div>
						<hr class="m-0">
						<div class="row p-3" >
							<div class="col d-flex justify-content-center align-items-center">
								<a href="${pageContext.request.contextPath}/member/setting?page=2" class="nomal"><h5 style="margin:0;">알림</h5></a>
							</div>
						</div>
						<hr class="m-0">
						<div class="row p-3" >
							<div class="col d-flex justify-content-center align-items-center">
								<a href="${pageContext.request.contextPath}/member/logout" class="nomal"><h5 style="margin:0;">로그아웃</h5></a>
							</div>
						</div>
						<hr class="m-0">
						<div class="row p-3" >
							<div class="col d-flex justify-content-center align-items-center">
								<a class="nomal" @click="deleteMemberModalShow"><h5 class="modal-click-btn-negative" style="margin:0;">회원탈퇴</h5></a>
							</div>
						</div>
						<hr class="m-0">
						<div class="row p-3" >
							<div class="col d-flex justify-content-center align-items-center">
								<a class="nomal" @click="myOptionModalHide"><h5 class="modal-click-btn-neutral" style="margin:0;">취소</h5></a>
							</div>
						</div>
					</div>
                </div>      
            </div>
        </div>
<!--   팔로워 모달    --> 
        
          <div class="modal" tabindex="-1" role="dialog" id="followerModal"
                            data-bs-backdrop="static"
                            ref="followerModal" @click.self="followerModalHide">	
            <div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
                   <div class="modal-content" style="max-width:400px; min-height:400px; max-height:400px; box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);">
                       <div class="modal-header text-center" style="display:flex; justify-content: center; height:50px;">
							<h5 class="modal-title">팔로워</h5>
                       </div>
                       <div class="modal-body" style="overflow-y: scroll; max-height:300px;"  @scroll="handleScroll2" @mouseleave="profileLeave">
                     	<div v-for="item in myFollowerList" :key="item.attachmentNo">
                     	 						
                  <!-- 프로필 미리보기 내용 -->
  					<div class="profile-preview" v-if="selectedItem === item" @mouseleave="profileLeave" style="border-radius:15px; margin-left:550px; margin-top:-40px;">
                  <div style="display: flex; align-items: center;">
						  <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="75" height="75" class="rounded-circle"> 
						  <div style="margin-left:20px;">
						    <a class="modalNickName" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">
						    <span class="truncate">{{ item.memberNick }}</span></a>
						    <p class="modalName">
						    <span class="truncate">{{ item.memberName }}</span></p>
						  </div>
					</div>
                    <hr>
                    <div class="col-7" style="display: flex; margin-left: 45px;">
                    	<div class="col-6">
                    		<span style="color:gray;">게시물</span>
                    			<p style="font-weight: bold; margin-left:20px;">{{postCounts}}</p>
                    		
                    	</div>
                    	<div class="col-6">
                    		<span style="color:gray;">팔로워</span>
                    			<p style="font-weight: bold; margin-left:20px;">{{followerCounts}}</p>                   	
                    	</div>
                    	<div class="col-6">
							<span style="color:gray;">팔로우</span>
								<p style="font-weight: bold; margin-left:20px;">{{followCounts}}</p>
                    	</div>
                    </div>
                    <div class="col-6">
                    	<div style="display:flex;">
                    	<template v-if="hoverPostList2.length === 0">
						  <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 150px; text-align: center;">
							  <div style="width:500px; margin-left:160px;">
							    <i class="fa-solid fa-camera fa-2xl" style="font-size: 40px; margin-bottom:30px;"></i>
							    <h4 style="white-space: nowrap; margin-bottom: 5px;">아직 게시물이 없습니다</h4>
							    <p style="font-size: 12px; margin-top: 0;">{{item.memberNick}}님이 사진과 릴스를 공유하면 여기에 표시됩니다.</p>
							  </div>
							</div>
						</template>
											<!-- 비공개 계정 || 친구에게만 공개 && 팔로우 목록에 있다면 -->
						<template v-else-if="(hoverSettingHide === 3 || (hoverSettingHide === 2 && hoverFollowerCheck == true)) && followCheckIf(item.memberNo)">
						  <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 150px; text-align: center;">
							  <div style="width:500px; margin-left:160px;">
							    <img src="${pageContext.request.contextPath}/static/image/lock.png" width="60" height="60">
   								<h6 style="white-space: nowrap; margin-bottom: 5px;">비공개 계정입니다 <br>
   								사진 및 동영상을 보려면 팔로우하세요.</h6>
							  </div>
							</div>
						</template>
					   
					    <template v-else>
					      <div v-for="(post,index) in hoverPostList2" :key="index">
					        <!-- 게시물 정보 출력 -->
					        	<video  style="width:127px; height:150px; object-fit:cover" class="d-block" :src="'${pageContext.request.contextPath}'+post.boardAttachmentList[0].imageURL"
							:autoplay="MemberSetting.videoAuto" muted controls :loop="MemberSetting.videoAuto" v-if="post.boardAttachmentList[0].video"></video>
					        <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' +post.boardAttachmentList[0].attachmentNo" width="127" height="150" style="margin-right:3px;" v-else>
					      </div>
					    </template>
                    	  
                    	 </div>
                    </div>
                    <div class="col-9" style="display:flex; justify-content: space-between; margin-left:20px; margin-top:15px;">
                  
                  
          
                  	 <button class="float-end btn btn-primary" @click="follow(item.memberNo)" v-if="followCheckIf(item.memberNo)" :class="{'hide' : item.memberNo == ${memberNo}}" style="flex-grow:1;">팔로우</button>
                  	 <button class="btn btn-primary" v-if="!followCheckIf(item.memberNo) && item.memberNo != ${memberNo}" @click="moveToDmPage(item.memberNo)" style="width:50%;cursor:pointer;">메시지 보내기</button>
          			 <button class="float-end btn btn-secondary" @click="myUnFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && ${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}" style="width:50%; margin-left:20px;">팔로잉</button>					  
					 <button class="float-end btn btn-secondary unfollow-button" @click="unFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && !${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}" style="width:50%; margin-left:20px;">팔로잉</button>
                   
                    </div>
          </div><!-- 팔로워 미리보기 끝 -->
						  <div style="display: flex; align-items: center;">
						   <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="60" height="60" @mouseover="profileHover(item)" style="border-radius:50%;" v-if="item.attachmentNo > 0">
          					<img src="${pageContext.request.contextPath}/static/image/user.jpg" width="60" height="60" style="border-radius:50%;" v-else @mouseover="profileHover(item)">
						   		<div style="display: flex; flex-direction: column; justify-content: flex-start; margin-left:20px;">
  						 	<a class="modalNickName truncate" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
  						 	<p class="modalName">{{item.memberName}}</p>
  						 		</div>
  						
						   <button class="float-end btn btn-primary" @click="follow(item.memberNo)" v-if="followCheckIf(item.memberNo)" :class="{'hide' : item.memberNo == ${memberNo}}" style="margin-left:auto;">팔로우</button>
						  <button class="float-end btn btn-secondary" @click="myUnFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && ${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}" style="margin-left:auto;">삭제</button>					  
						  <button class="float-end btn btn-secondary unfollow-button" @click="unFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && !${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}" style="margin-left:auto;">팔로잉</button>
						 
						</div>
						</div>
                     		
                       </div>           
                        <button type="button" class="btn btn-default" data-bs-dismiss="modal" style="color:red;">취소</button>
                </div>      
            </div>
        </div><!-- 팔로워 목록 끝 -->
        
          <div class="modal" tabindex="-1" role="dialog" id="followModal"
                            data-bs-backdrop="static"
                            ref="followModal" @click.self="followModalHide">
             <div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
    <div class="modal-content" style="max-width:400px; min-height:200px; max-height:400px;">	
      <div class="modal-header text-center" style="display:flex; justify-content: center; height:50px;">
        <h5 class="modal-title" >팔로잉</h5>
      </div>
 		<div class="modal-header text-center" style="display:flex; justify-content: center; height:50px;">
  <ul class="nav nav-tabs" style="width: 100%;">
    <li class="nav-item col-6">
       <a class="nav-link" :class="{'active': activeTab === 'peopleTab'}" @click="changeTab('peopleTab')" style="font-size:17px; padding:14px 0;">사람</a>
    </li>
    <li class="nav-item col-6">
      <a class="nav-link" :class="{'active': activeTab === 'hashtagsTab'}" @click="changeTab('hashtagsTab')" style="font-size:17px; padding:14px 0;">해시태그</a>
      </li>
  </ul>
</div>
      <div class="modal-body" style="overflow-y: scroll; max-height:300px;"  @scroll="handleScroll" @mouseleave="profileLeave">
      		<div v-if="activeTab === 'peopleTab'">
      		
        <div v-for="item in myFollowList" :key="item.attachmentNo">
      		 	<div style="display: flex; align-items: center; max-width:400px; over-flow:scroll; max-height:100px;" @scroll="handleScroll" >
          			<img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="60" height="60" @mouseover="profileHover2(item)" v-if="item.attachmentNo > 0 " class="rounded-circle">
          			<img src="${pageContext.request.contextPath}/static/image/user.jpg" width="60" height="60" v-else class="rounded-circle" @mouseover="profileHover2(item)">
						   <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-left:20px;">
						    <a class="modalNickName" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">
						    <span class="truncate">{{ item.memberNick }}</span></a>
          					<p class="modalName">
          					<span class="truncate">{{item.memberName}}</span></p>
						  </div>
          <button class="float-end btn btn-primary" @click="follow(item.followFollower)" v-show="followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}" style="margin-left:auto; ">팔로우</button>
          <button class="float-end btn btn-secondary unfollow-button" @click="unFollow(item.followFollower)" v-show="!followCheckIf(item.followFollower) && !${isOwner}" :class="{'hide' : item.followFollower == ${memberNo}}" style="margin-left:auto;">팔로잉</button>
          <button class="float-end btn btn-secondary unfollow-button" @click="unFollow(item.followFollower)" v-show="!followCheckIf(item.followFollower) && ${isOwner}" :class="{'hide' : item.followFollower == ${memberNo}}" style="margin-left:auto;">삭제</button>
          </div>
            <div class="profile-preview" v-if="selectedItem === item" @mouseleave="profileLeave" style="border-radius:15px; margin-left:550px; margin-top:-40px;">
                  <!-- 프로필 미리보기 내용 -->
                   	<div style="display: flex; align-items: center;">
						  <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="75" height="75" class="rounded-circle"> 
						  <div style="margin-left:20px;">
						    <a class="modalNickName" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
						    <p class="modalName">{{ item.memberName }}</p>
						  </div>
					</div>
                    <hr>
                    <div class="col-7" style="display: flex; margin-left: 45px;">
                    	<div class="col-6">
                    		<span style="color:gray;">게시물</span>
                    		<p style="font-weight: bold; margin-left:20px;">{{postCounts}}</p>
                    	</div>
                    	<div class="col-6">
                    		<span style="color:gray;">팔로워</span>
                    			<p style="font-weight: bold; margin-left:20px;">{{followerCounts}}</p>
                    	</div>
                    	<div class="col-6">
							<span style="color:gray;">팔로우</span>
								<p style="font-weight: bold; margin-left:20px;">{{followCounts}}</p>	
                    	</div>
                    </div>
		                    <div class="col-6">
                    	<div style="display:flex;">
                    	<template v-if="hoverPostList.length === 0">
						  <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 150px; text-align: center;">
							  <div style="width:500px; margin-left:160px;">
							    <i class="fa-solid fa-camera fa-2xl" style="font-size: 40px; margin-bottom:30px;"></i>
							    <h4 style="white-space: nowrap; margin-bottom: 5px;">아직 게시물이 없습니다</h4>
							    <p style="font-size: 12px; margin-top: 0;">{{item.memberNick}}님이 사진과 릴스를 공유하면 여기에 표시됩니다.</p>
							  </div>
							</div>
						</template>
						
						
						<!-- 비공개 계정 || 친구에게만 공개 && 팔로우 목록에 있다면 -->
						<template v-else-if="(hoverSettingHide === 3 || (hoverSettingHide === 2 && hoverFollowerCheck == true)) && followCheckIf(item.followFollower)">
						  <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 150px; text-align: center;">
							  <div style="width:500px; margin-left:160px;">
							    <img src="${pageContext.request.contextPath}/static/image/lock.png" width="60" height="60">
   								<h6 style="white-space: nowrap; margin-bottom: 5px;">비공개 계정입니다 <br>
   								사진 및 동영상을 보려면 팔로우하세요.</h6>
							  </div>
							</div>
						</template>
						
						
					   
					    <template v-else>
					      <div v-for="(post,index) in hoverPostList" :key="index">
					        <!-- 게시물 정보 출력 -->
					        	<video  style="width:127px; height:150px; object-fit:cover" class="d-block" :src="'${pageContext.request.contextPath}'+post.boardAttachmentList[0].imageURL"
							:autoplay="MemberSetting.videoAuto" muted controls :loop="MemberSetting.videoAuto" v-if="post.boardAttachmentList[0].video"></video>
					        <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + post.boardAttachmentList[0].attachmentNo" width="127" height="150" style="margin-right:3px;" v-else>
					      </div>
					    </template>
                    	  
                    	 </div>
                    </div>
                    <div class="col-9" style="display:flex; justify-content: space-between; margin-left:40px; margin-top:15px;">
                  	 <button class="btn btn-primary" @click="follow(item.followFollower)" v-if="followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}" style="flex-grow:1;">팔로우</button>
                  	 <button class="btn btn-primary" v-if="!followCheckIf(item.followFollower) && item.followFollower != ${memberNo}" @click="moveToDmPage(item.followFollower)"style="width:50%;cursor:pointer;">메시지 보내기</button>
          			<button class="btn btn-secondary unfollow-button" @click="unFollow(item.followFollower)" v-if="!followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}" style="width:50%; margin-left:20px;" >팔로잉</button>
                 </div>
                 
          </div> <!-- 팔로우 미리보기 끝 -->
          
			</div>
			<i class="fa-solid fa-spinner fa-spin" v-show="followLoading && !followFinish"></i>
      		</div>
      		<div v-else-if="activeTab === 'hashtagsTab'">
      		  	<!-- 해시태그 목록 표시 -->
      		  		<!-- 해시태그 목록이 없을 때 -->
					<div style="display: flex; align-items: center; max-width:400px; over-flow:scroll; min-height:200px;" @scroll="handleScroll" v-if="hashtagList.length === 0">
						<div class="text-center" style="margin-left:20px;">
						<i class="fa-solid fa-hashtag fa-2xl" style="font-size:62px; margin-bottom:10px;"></i>
						<h2 style="margin-top:10px;">팔로우하는 해시태그</h2>
						<h6 style="font-size:12px;">해시태그를 팔로우하면 여기에 표시됩니다.</h6>
						</div>
					</div>
					<!-- 해시태그 목록이 있을 때 -->
      		  		<div v-for="item in hashtagList" key="item.memberNo" v-else>
					<div  style="display: flex; align-items: center; max-width:400px; over-flow:scroll; max-height:100px;" @scroll="handleScroll">
          			<img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="60" height="60" v-if="item.attachmentNo > 0" class="rounded-circle">
          			<img src="${pageContext.request.contextPath}/static/image/user.jpg" width="60" height="60" class="rounded-circle"  v-else >
						   <div style="display: flex; flex-direction: column; justify-content: flex-start; margin-left:20px;">
						    <a class="modalNickName" :href="'${pageContext.request.contextPath}/tag/' + item.tagName" style="margin-left:5px;">{{'#' + item.tagName }}</a>
          					<p class="modalName" style="margin-left:5px;">게시물 {{item.tagCount}}</p>
						  </div>
							  <button class="float-end btn btn-primary" @click="tagFollow(item.tagName)" style="margin-left:auto;" v-show="tagFollowCheckIf(item.tagName)">팔로우</button>	
							  <button class="float-end btn btn-secondary" @click="tagUnFollow(item.tagName)" style="margin-left:auto;" v-show="!tagFollowCheckIf(item.tagName) && !${isOwner}">팔로잉</button>					  
							  <button class="float-end btn btn-secondary" @click="tagUnFollow(item.tagName)" style="margin-left:auto;" v-show="!tagFollowCheckIf(item.tagName) && ${isOwner}">삭제</button>					  
					</div>
      		  	</div>
      		</div>
      		
 
    
    </div>
		<button type="button" class="btn btn-default" data-bs-dismiss="modal" style="color:red;">취소</button>
  </div>
</div> 
</div>
		<!-- 추천 친구 목록 모달 -->
       <div class="modal" tabindex="-1" role="dialog" id="recommendFriendsAllListModal"
                            data-bs-backdrop="static"
                            ref="recommendFriendsAllListModal" @click.self="recommendFriendsAllListModalHide">
             <div class="modal-dialog" role="document">
    <div class="modal-content" style="max-width:400px; min-height:400px; max-height:400px;">
      <div class="modal-header text-center" style="display:flex; justify-content: center;">
        <h5 class="modal-title" >비슷한 계정</h5>
      </div>
      <div class="modal-body" style="overflow-y: scroll; max-height:300px;"  @scroll="handleScroll">
        <div v-for="item in recommendFriendsList" :key="item.attachmentNo">
     
          	<div style="display: flex; align-items: center; max-width:400px; over-flow:scroll; max-height:100px;" @scroll="handleScroll" >
          			<img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="60" height="60" v-if="item.attachmentNo > 0" class="rounded-circle">
          			<img src="${pageContext.request.contextPath}/static/image/user.jpg" width="60" height="60" v-else class="rounded-circle">
						   <div style="display: flex; flex-direction: column; justify-content: flex-start;">
						    <a class="modalNickName truncate" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
          					<p class="modalName">{{item.memberName}}</p>
						  </div>
						  
          <button class="float-end btn btn-primary" @click="follow(item.memberNo)" v-show="followCheckIf(item.memberNo)" :class="{'hide' : item.followFollower == ${memberNo}}" style="margin-left:auto;">팔로우</button>
          <button class="float-end btn btn-secondary" @click="unFollow(item.memberNo)" v-show="!followCheckIf(item.memberNo)" :class="{'hide' : item.followFollower == ${memberNo}}" style="margin-left:auto;">팔로잉</button>
			</div>
          
        </div>
      </div>
        <button type="button" class="btn btn-default" data-bs-dismiss="modal" style="color:red;">취소</button>
    </div>
  </div>
</div> 

	<!-- 회원탈퇴 모달 -->
       <div class="modal" tabindex="-1" role="dialog" id="deleteMemberModal"
                            data-bs-backdrop="static"
                            ref="deleteMemberModal" @click.self="deleteMemberModalHide">
             <div class="modal-dialog" role="document">
    <div class="modal-content" style="max-width:400px; min-height:200px max-height:400px;">
      <div class="modal-header text-center" style="display:flex; justify-content: center;">
        <h5 class="modal-title" >회원탈퇴</h5>
      </div>
     	<div class="modal-body" style="background-color: #f2f2f2;">
     		<div class="d-flex justify-content-center">
     		<a class="navbar-brand"><img src="${pageContext.request.contextPath}/static/image/insider2.png" width="150" height="60"></a>    	
     		</div>
     		<div class="d-flex justify-content-center" style="margin-top:8px;">
     			<h4>회원탈퇴 전 확인하세요!</h4>    			
     		</div>
     		<div class="d-flex justify-content-center">
     			<p style="font-size:12px; color:gray; font-weight: bold;">탈퇴하시면 회원님이 작성했던 모든 게시물이 삭제됩니다.</p>  			
     		</div>
     		<div class="d-flex justify-content-center">
     			<div style="width:300px; height:70px; border:1px solid black; background-color: white;">
     			   <p style="font-size:11px; margin-top:10px;">- 게시물, 팔로우, 팔로워, 댓글 등 모든 정보가 삭제됩니다. <br>
     			   - 타인 글의 댓글은 삭제되지 않으니 미리 확인하세요.
     			   </p>
     			</div>
     		</div>
     		<div class="d-flex justify-content-center" style="margin-top:9px;">
     			<input type="checkbox" id="agreeCheckbox" v-model="agreeChecked">
				<label for="agreeCheckbox" style="font-size:13px; color:gray; margin-left:6px;">안내사항을 확인하였습니다.</label>
     		</div>
     		<div class="d-flex justify-content-center" style="margin-top:12px;">
     			<button style="width:150px; height:40px; border-radius:25px;" @click="deleteMember" :disabled="!agreeChecked">탈퇴하기</button>
     		</div>
     	</div>
     	<div class="modal-footer text-center">
			<button type="button" class="btn" data-bs-dismiss="modal">취소</button>
 		</div>
     
    </div>
  </div>
</div> 


<!-- 팔로우 모달 목록 끝 -->
<!-- 차단 관련 모달 -->
<!-- ---------------------------------신고 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="reportMenuModal" data-bs-backdrop="static" ref="reportMenuModal" style="z-index:8888">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content" >
				<div class="modal-header">
					<h5 class="modal-title" style="font-weight:bold; text-align:center">신고</h5>
					<button type="button" class="btn-close" @click="hideReportMenuModal" aria-label="Close">
					<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row">
						<div class="col d-flex p-3">
							<h5 style="margin:0;">이 게시물을 신고하는 이유</h5>
						</div>
					</div>
					<div class="row" v-for="(report, index) in reportContentList" :key="report.reportListNo" style="border-top:var(--bs-modal-border-width) solid var(--bs-modal-border-color)">
						<div class="col d-flex p-2 report-content" @click="reportContent(report.reportListContent)" style="cursor:pointer">
							<h5 style="margin:0; margin-left:1em">{{report.reportListContent}}</h5>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" @click="hideReportMenuModal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
<!-- 차단 관련 모달 끝 -->

<!-- 좋아요 목록 모달  -->
<div class="modal" tabindex="-1" role="dialog" id="likeListModal" data-bs-backdrop="static" ref="likeListModal" style="z-index:9999;">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content">
				<div class="modal-header">
        			<h5 class="modal-title col-7" style="font-weight:bold;">좋아요</h5>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="hideLikeListModal"></button>
      			</div>
				<div v-if="likeList.length != 0" class="modal-body p-0">				
					<div class="row p-2 mt-2"  v-for="(like,index) in likeList" :key="index">
						<div  class="col d-flex">
							<a :href="'${pageContext.request.contextPath}/member/'+ like.memberNick">
								<img class="rounded-circle" v-if="like.attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+ like.attachmentNo" width="50" height="50" style="border-radius: 70%;">
								<img class="rounded-circle" v-else src="${pageContext.request.contextPath}/static/image/user.jpg" style="border-radius: 70%; ">
							</a>
							<a :href="'${pageContext.request.contextPath}/member/'+ like.memberNick" style="color:black;text-decoration:none; position:relative;">
								<h6 style="margin: 14px 0 0 10px;">{{like.memberNick}}</h6>
							</a>
						</div>
					</div>
				</div>
				
				<div class="modal-body p-0" v-else>
					<div class="row p-2 mt-2" >
						<div class="col text-center">
							<h2 class="mt-1">아직 좋아요가 없습니다</h2><br>
							<h3>첫 번째 좋아요를 눌러주세요</h3>
						</div>
	 			 	</div>		
				</div>
					
				
				
		</div>
	</div>
	</div>
<!-- ---------------------------------추가 메뉴 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="additionalMenuModal" data-bs-backdrop="static" ref="additionalMenuModal" style="z-index:7777">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content">
				<div class="modal-body p-0">
					<div class="row p-3">
						<div class="col d-flex justify-content-start align-items-start">
							<h5 style="margin:0; cursor:default; padding-left:1em">더보기</h5>
						</div>
					</div>
					<hr class="m-0" v-if="reportBoardData[1] != ${sessionScope.memberNo}">
					<div class="row p-3" v-if="reportBoardData[1] != ${sessionScope.memberNo}" @click="showReportMenuModal">
						<div class="col d-flex justify-content-center align-items-center" style="color:#dc3545; cursor:pointer">
							<h5 style="font-weight:bold; margin:0;">신고</h5>
						</div>
					</div>
					
					<hr class="m-0" v-if="reportBoardData[1] == ${sessionScope.memberNo} && reportBoardData[2] == 'board'">
					<div class="row p-3" v-if="reportBoardData[1] == ${sessionScope.memberNo} && reportBoardData[2] == 'board'" @click="updatePost(reportBoardData[0])">
						<div class="col d-flex justify-content-center align-items-center" style="cursor:pointer">
							<h5 style="margin:0;">수정</h5>
						</div>
					</div>
					
					<hr class="m-0" v-if="reportBoardData[1] == ${sessionScope.memberNo}" >
					<div class="row p-3" v-if="reportBoardData[1] == ${sessionScope.memberNo}" @click="deleteTool">
						<div class="col d-flex justify-content-center align-items-center" style="cursor:pointer">
							<h5 style="margin:0;">삭제</h5>
						</div>
					</div>
					
					
					<!-- 메뉴 구분선 -->
					<hr class="m-0">
					<div class="row p-3" @click="hideAdditionalMenuModal">
						<div class="col d-flex justify-content-center align-items-center" style="cursor:pointer">
							<h5 style="margin:0;">취소</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- ---------------------------------신고 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="reportMenuModal" data-bs-backdrop="static" ref="reportMenuModal" style="z-index:8888">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content" >
				<div class="modal-header">
					<h5 class="modal-title" style="font-weight:bold; text-align:center">신고</h5>
					<button type="button" class="btn-close" @click="hideReportMenuModal" aria-label="Close">
					<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row">
						<div class="col d-flex p-3">
							<h5 style="margin:0;">이 게시물을 신고하는 이유</h5>
						</div>
					</div>
					<div class="row" v-for="(report, index) in reportContentList" :key="report.reportListNo" style="border-top:var(--bs-modal-border-width) solid var(--bs-modal-border-color)">
						<div class="col d-flex p-2 report-content" @click="reportContent(report.reportListContent)" style="cursor:pointer">
							<h5 style="margin:0; margin-left:1em">{{report.reportListContent}}</h5>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" @click="hideReportMenuModal">취소</button>
				</div>
			</div>
		</div>
	</div>
<!-- ---------------------------------신고 후 차단 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="blockModal2" data-bs-backdrop="static" ref="blockModal2" style="z-index:8888">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content">
				<div class="modal-body">
					<div class="row mt-2 mb-2">
						<div class="col d-flex justify-content-center align-items-center">
							<i class="fa-regular fa-circle-check" style="color:#198754; font-size:10em"></i>
						</div>
					</div>
					<div class="row">
						<div class="col d-flex justify-content-center align-items-center">
							<h5 class="modal-title" style="font-weight:bold; text-align:center">알려주셔서 고맙습니다</h5>
						</div>
					</div>
					<div class="row">
						<div class="col d-flex justify-content-center align-items-center">
							<span>회원님의 소중한 의견은 Insider 커뮤니티를</span>
						</div>
					</div>
					<div class="row">
						<div class="col d-flex justify-content-center align-items-center">
							<span> 안전하게 유지하는 데 도움이 됩니다.</span>
						</div>
					</div>
					<div class="row mt-2">
						<div class="col d-flex p-3 justify-content-center" @click="blockUser" style="color:#dc3545; cursor:pointer" v-if="reportBoardData[5]!=null && reportBoardData[5].length>0">
							<h5 style="margin:0;">{{reportBoardData[5]}}님 차단</h5>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" @click="hideBlockModal">닫기</button>
				</div>
			</div>
		</div>
	</div>
        <!-- Modal 창 영역 끝 -->
        
      
      </div> <!-- vue 끝 -->
      
      

<!-- 카카오맵 CDN -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e45b9604d6c5aa25785459639db6e025&libraries=services"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/vue@next"></script>
      <script>
   Vue.createApp({
      data() {
         return {
        	 //▼▼▼▼▼▼▼▼▼▼▼▼▼무한 페이징▼▼▼▼▼▼▼▼▼▼▼▼▼
             percent:0,
             page : 1,
             //안전장치
             loading:false,
             finish:false,
             
        	 //▼▼▼▼▼▼▼▼▼▼▼▼▼팔로우 무한 페이징▼▼▼▼▼▼▼▼▼▼▼▼▼
             followPercent:0,
             followPage : 1,
             //안전장치
             followLoading:false,
             followFinish:false,
             
             //▼▼▼▼▼▼▼▼▼▼▼▼▼팔로워 무한 페이징▼▼▼▼▼▼▼▼▼▼▼▼▼
             followerPercent:0,
             followerPage : 1,
             //안전장치
             followerLoading:false,
             followFerinish:false,
             
             isOwner : false,
             showProfilePreview : false,
            //추가 메뉴 모달 및 신고 모달
            modal : null,
            addtionModal : null,
            reportMenuModal:null,
            blockModal : null,
            blockResultModal : null,
            myOptionModal : null,
            followerModal : null,
            followModal : null,  
            followerHoverModal : null,
            recommendFriendsAllListModal : null,
           	deleteMemberModal : null,
            selectedItem: null,
            followCheckList:[],
            myFollowerList: [],
            myFollowList: [],
            myBoardList : [],
            followCounts: null,
            followerCounts : null,
            postCounts : null,
            hoverPostList : [],
            hoverPostList2 : [],
            reportBoardNo:"",  
            DmMemberNo:"${sessionScope.memberNo}",
            memberNo : "${memberDto.memberNo}",
            memberNick : "${memberDto.memberNick}",
            attachmentNo : "${memberDto.attachmentNo}",
            member:{
               memberNo:"",
               memberName:"",
               memberEmail:"",
               memberLat:"",
               memberLon:"",
               memberPost:"",
               memberBasicAddr:"",
               memberDetailAddr:"",
               memberMsg:"",
               memberTel:"",
               memberGender:"",
               memberBirth:"",
               attachmentNo:"",
            },
            settingHide :null,
            hoverSettingHide : null,
            hoverFollowerCheck : false,
            hoverFollowCheck : false,
            totalFollowCnt: 0,
            totalFollowerCnt: 0,
            
          //상세보기 및 댓글
			detailView:false,
			detailView2:false,
			detailIndex:"",
			detailIndex2:"",
			replyList:[],
			replyList2:[],
			replyParent:0,
			replyContent:"",
			placeholder:"댓글 입력..",
			//게시물 작성자 팔로우 리스트
			followList : [],
			followerList : [],
			
		  
			
			//게시물 좋아요 기능 전용 변수
			boardLikeCount:[], // 좋아요 수를 저장할 변수
			boardLikeCount2:[], // 좋아요 수를 저장할 변수
            isLiked : [], // 로그인 회원이 좋아요 체크 여부
            isLiked2 : [], // 로그인 회원이 좋아요 체크 여부
            likeList : [],
            likeListData : [],
            likeListModal : false,
            
			//게시물 댓글 좋아요 기능 전용 변수
			replyLikeCount : [], // 댓글 좋아요 수 저장 변수
			replyLikeCount2 : [], // 댓글 좋아요 수 저장 변수
			isReplyLiked : [], // 로그인 회원이 댓글 좋아요 체크 여부 
			isReplyLiked2 : [], // 로그인 회원이 댓글 좋아요 체크 여부 
			recommendFriends : false,
			recommendFriendsList : [], // 친구 추천목록 리스트
			currentPage: 0,
			itemsPerPage : 4,
			followBtn : false,
			followerBtn : false,
			activeTab: 'peopleTab', // 초기 선택된 탭은 'peopleTab'입니다.
			hashtagList : [], // 해시태그 리스트
			hashtagFollowCheckList : [], // 해시태그 팔로우 체크 
			isFollowing : false, // 해시태그 팔로잉 여부
			/*----------------------신고----------------------*/
			//추가 메뉴 모달 및 신고 모달
			additionalMenuModal:null,
			reportMenuModal:null,
			blockModal:null,
			blockModal2:null,
			//신고 메뉴 리스트
			reportContentList:[],
			reportBoardData:[],
			/*----------------------신고----------------------*/
			isLoading : false, // 추천 목록 로딩
			actTab : 'boardTab', // 초기 선택된 탭은 'boardTab'입니다.
			// 북마크 
			bookmarkMyPostList : [],
			bookmarkCheck : [],
			agreeChecked : false,
			
			MemberSetting:{
    	        //좋아요 수 보기 여부
	            watchLike:false,
	            //반경설정
	            watchDistance:"",
	            //동영상 자동재생
	            videoAuto:false,
            },
            slideOffset: 0, // 슬라이드 오프셋 값
            location:"",//지역
         };
      },
      computed: {
         profileUrl(){
            if(this.member.attachmentNo>0){
               return contextPath+"/rest/attachment/download/"+this.attachmentNo;
            }
            else{
               return contextPath+"/static/image/user.jpg";
            }
         },
         async getFollowCount() {
             return async (memberNo) => {
               if (!this.followCounts[memberNo]) {
                 const resp = await axios.get("totalFollowCount", {
                   params: {
                	   memberNo: memberNo,
                   },
                 });
                 this.followCounts[memberNo] = resp.data;
               }
               return this.followCounts[memberNo];
             };
           },
           
           paginatedRecommendFriends() {
        	    const totalPages = Math.ceil(this.recommendFriendsList.length / this.itemsPerPage);
        	    const paginatedArray = [];

        	    for (let i = 0; i < totalPages; i++) {
        	      const startIndex = i * this.itemsPerPage;
        	      const endIndex = startIndex + this.itemsPerPage;
        	      const pageItems = this.recommendFriendsList.slice(startIndex, endIndex);
        	      paginatedArray.push(pageItems);
        	    }

        	    return paginatedArray;
        	  },
        	  displayedItems() {
        		    return this.paginatedRecommendFriends[this.currentPage];
        		  },
        	iconClass(){
        			return this.recommendFriends ? "fa-solid fa-user-plus" : "far fa-user";  
        		  },
        	  
         
         
         
      },
      methods: {
    	  changeTab(tab) {
    	      this.activeTab = tab; // 선택된 탭을 변경합니다.
    	    },
    	  changeTab2(tab){
    	    	this.actTab = tab;
    	    },
    	  
           showModal(){
                  if(this.modal == null) return;
                  this.modal.show();
              },
              hideModal(){
                  if(this.modal == null) return;
                  this.modal.hide();
              },
              
             showModal2(){
                  if(this.addtionModal == null) return;
                  this.addtionModal.show();
              },
              hideModal2(){
                  if(this.addtionModal == null) return;
                  this.addtionModal.hide();
              },
              blockModalShow(){
            	  this.reportBoardData[5]="${memberDto.memberNick}";
            	  this.reportBoardData[1]=${memberDto.memberNo};
                  if(this.blockModal == null) return;
                  this.addtionModal.hide();
                   this.blockModal.show();      
              },
              blockModalHide(){
                 if(this.blockModal == null) return;
                  this.blockModal.hide();
              },
              blockResultModalShow(){
                 if(this.blockResultModal == null) return;
                 this.blockModal.hide();
                  this.blockResultModal.show(); 
              },
              blockResultModalHide(){
                 if(this.blockResultModal == null) return;
                  this.blockResultModal.hide(); 
              },
              myOptionModalShow(){
                 if(this.myOptionModal == null) return;
                  this.myOptionModal.show();  
              },
              myOptionModalHide(){
                 if(this.myOptionModal == null) return;
                  this.myOptionModal.hide();  
              },
              followerModalShow(){
            	  if(this.followerModal == null || this.totalFollowerCnt == 0 ) return;
                  this.followerModal.show();    
              },
              followerModalHide(){
                  if(this.followerModal == null) return;
                   this.followerModal.hide();  
                   //
                   //
               },
               followModalShow(){
             	  if(this.followModal == null || this.totalFollowCnt == 0 ) return;
                   this.followModal.show();    
               },
               followModalHide(){
                   if(this.followModal == null) return;
                    this.followModal.hide();  
                },
                followerHoverModalShow(){
                	if(this.followerHoverModal == null) return;
                	this.followerHoverModal.show();
                },
                recommendFriendsAllListModalShow(){
                	if(this.recommendFriendsAllListModal == null) return;
                	this.recommendFriendsAllListModal.show();
                },
                recommendFriendsAllListModalHide(){
                	if(this.recommendFriendsAllListModal == null) return;
                	this.recommendFriendsAllListModal.hide();
                },
                deleteMemberModalShow(){
                	if(this.deleteMemberModal == null) return;
                	this.myOptionModal.hide();
                	this.deleteMemberModal.show();
                },
                deleteMemberModalHide(){
                	if(this.deleteMemberModal == null) return;
                	this.deleteMemberModal.hide();
                },
              
              accountView(){
                 this.addtionModal.hide();
                 this.modal.show();
              },
             //멤버 정보 불러오기
           async loadMember(){
              const resp = await axios.get(contextPath+"/rest/member/"+memberNo);
              Object.assign(this.member, resp.data);
           },
           
           
           //회원 환경 설정 로드
           async loadMemberSetting(){
   			const resp = await axios.get(contextPath+"/rest/member/setting");
   				this.MemberSetting.watchLike=resp.data.watchLike;
               this.MemberSetting.watchDistance=resp.data.settingDistance;
               this.MemberSetting.videoAuto=resp.data.videoAuto;
   		},     
             //프로필 사진 변경 누르면 실행
            openFileInput() {
              this.$refs.fileInput.click();
           },
           //파일이 추가되면 실행
         handleFileUpload(event) {
            const file = event.target.files[0];
            // 파일 업로드 로직 처리
            if (file) {
               let fd = new FormData();
               fd.append("attach", file);
               this.uploadProfile(fd);
            };
         },
         //파일 저장 비동기 처리
         async uploadProfile(formData){
            const resp = await axios.post(contextPath+"/rest/attachment/upload/profile", formData);
            this.attachmentNo = resp.data;
           
         },
    
    
         //팔로우
         async follow(followNo) {
        	 
         	const resp = await axios.post(contextPath+"/rest/follow/"+followNo);
         	await this.followCheck();
         	
         
         	
         	this.totalFollowerCount();    
         	this.totalFollowCount();
         	this.followerListPaging();
         	this.followListPaging();
         	
         	
         	
         },
         
         //팔로워 되있는사람 -> 팔로우 삭제
      async unFollower(memberNo) {
		  try {
		    const response = await axios.post(contextPath+"/rest/follow/unFollow", null, {
		      params: {
		        followFollower: memberNo
		      }
		    });
		
		    if (response.data) {
		      // 언팔로우 성공 처리
		      this.totalFollowerCount();
		      this.totalFollowCount();
		      this.followerListPaging();
		      this.followListPaging();
		      const index = this.followCheckList.findIndex(item => item === memberNo);
		      if (index !== -1) {
		        this.followCheckList.splice(index, 1);
		      }
		      
		    } else {
		      // 언팔로우 실패 처리
		    }
		  } catch (error) {
		    // 요청 실패 처리
		  }
		},
			// 팔로워 되있는 사람 -> 팔로우 삭제 (본인 프로필 일때)
		  async myUnFollower(memberNo) {
			  try {
			    const response = await axios.post(contextPath+"/rest/follow/myUnFollow", null, {
			      params: {
			        memberNo: memberNo
			      }
			    });
			
			    if (response.data) {
			      // 언팔로우 성공 처리
			     
			      
			      // 팔로워 목록에서 해당 멤버를 실시간으로 제거하는 로직 추가
			      const followerIndex = this.myFollowerList.findIndex(item => item.memberNo === memberNo);
			      if (followerIndex !== -1) {
			        this.myFollowerList.splice(followerIndex, 1);
			      }
			      
			    
			      this.totalFollowerCount();
			      this.totalFollowCount();
			      this.followerListPaging();
			      this.followListPaging();
			    } else {
			      // 언팔로우 실패 처리
			    }
			  } catch (error) {
			    // 요청 실패 처리
			  }
			},

		
		
		
	     //팔로우 되있는사람 -> 팔로우 삭제
	 async unFollow(memberNo) {
			  try {
			    const response = await axios.post(contextPath+"/rest/follow/unFollow", null, {
			      params: {
			        followFollower: memberNo
			      }
			    });
			    if (response.data) {
			      // 언팔로우 성공 처리   
			     
			      // followCheckList 업데이트
			      const index = this.followCheckList.indexOf(memberNo);
			      if (index > -1) {
			    	  this.followCheckList.splice(index, 1);
			      }
			      

			      this.totalFollowCount();
			      this.totalFollowerCount();
			      this.followListPaging();
			      await this.$nextTick(); // 다음 UI 업데이트를 기다립니다.
			
			    } else {
			      // 언팔로우 실패 처리
			    }
			  } catch (error) {
			    // 요청 실패 처리
			  }
			},
						
		 
         // 팔로우 v-if 여부체크 함수
        	followCheckIf(memberNo){
         	
        		return !this.followCheckList.includes(memberNo);
         },
          
      	 //팔로우 여부 체크
         async followCheck() {
         	const resp = await axios.post(contextPath+"/rest/follow/check");
    
         	const newData = memberNo;
         	
         	  this.followCheckList = []; // followCheckList 초기화
         	// this.followCheckList = resp.data;
         	this.followCheckList.push(...resp.data);
         	this.followCheckList.push(parseInt(newData));
 
         }, 
         
 
         // 팔로우 총 개수 
         async totalFollowCount() {
        	    const resp = await axios.get(contextPath+"/member/totalFollowCount", {
        	        params: {
        	            memberNo: this.memberNo
        	        }
        	    });
        	    this.totalFollowCnt = resp.data;
        	},
        	
        	        	
        	 // 팔로워 총 개수 
            async totalFollowerCount() {
           	    const resp = await axios.get(contextPath+"/member/totalFollowerCount", {
           	        params: {
           	            memberNo: this.memberNo
           	        }
           	    });
           	    this.totalFollowerCnt = resp.data;           	    
           	},
           	
           	// 호버시 팔로우 총 개수
           	async getTotalFollowCount(memberNo) {
           
           	      const resp = await axios.get(contextPath+"/member/totalFollowCount", {
           	        params: {
           	          memberNo: memberNo
           	        }
           	      });
           	     return resp.data;	   
           	},
           	
         	// 호버시 팔로워 총 개수
           	async getTotalFollowerCount(memberNo) {
           
           	      const resp = await axios.get(contextPath+"/member/totalFollowerCount", {
           	        params: {
           	        	memberNo: memberNo
           	        }
           	      });
           	     return resp.data;	   
           	},
           	
           	// 호버시 게시물 총 개수
           		async getTotalPostCount(memberNo) {
           
           	      const resp = await axios.get(contextPath+"/member/totalPostCount", {
           	        params: {
           	        	memberNo: memberNo
           	        }
           	      });
           	     return resp.data;	   
           	},

           	
        	// 본인 팔로우 목록 불러오기 무한스크롤
        async followListPaging() {
		  if (this.followLoading === true) return; // 로딩중이면
		  if (this.followFinish === true) return; // 다 불러왔으면
		  this.followLoading = true;
		  
		  try {
		    const resp = await axios.get(contextPath+"/rest/member/followListPaging/" + this.followPage, {
		      params: {
		        memberNo: this.memberNo
		      }
		    });
		    
		    
		
		    const newData = resp.data;
		    for (const item of newData) {
		      const existingItem = this.myFollowList.find(followItem => followItem.followFollower === item.followFollower);
		      if (!existingItem) {
		        this.myFollowList.push(item);
		      }
		    }
		    
			 // 로그인 유저 첫줄에 출력
		    const memberNo = ${memberNo};
		    const memberNoIndex = this.myFollowList.findIndex(followerItem => followerItem.followFollower === memberNo);
		    if (memberNoIndex !== -1) {
		      const existingItem = this.myFollowList.splice(memberNoIndex, 1)[0];
		      this.myFollowList.unshift(existingItem);
		    }
		
		    this.followPage++;
		
		    if (resp.data.length < 3) {
		      this.followFinish = true;
		    }
	

		    
		  // this.followCheck();
		  } catch (error) {
		    console.error("Error occurred during followListPaging: ", error);
		  }
		  
		  this.followLoading = false;
		},
		
		
		
		
	   	// 본인 팔로워 목록 불러오기 무한스크롤
       async followerListPaging() {
		  if (this.followerLoading === true) return; // 로딩중이면
		  if (this.followerFinish === true) return; // 다 불러왔으면
		  this.followerLoading = true;
		  
		  try {
		    const resp = await axios.get(contextPath+"/rest/member/followerListPaging/" + this.followerPage, {
		      params: {
		        memberNo: this.memberNo
		      }
		    });
		
		    const newData = resp.data;
		    for (const item of newData) {
		      const existingItem = this.myFollowerList.find(followerItem => followerItem.memberNo === item.memberNo);
		      if (!existingItem) {
		        this.myFollowerList.push(item);
		      }
		    }
		    // 로그인 유저 첫줄에 출력
		    const memberNo = ${memberNo};
		    const memberNoIndex = this.myFollowerList.findIndex(followerItem => followerItem.memberNo === memberNo);
		    if (memberNoIndex !== -1) {
		      const existingItem = this.myFollowerList.splice(memberNoIndex, 1)[0];
		      this.myFollowerList.unshift(existingItem);
		    }
		    
		
		    this.followerPage++;
	
		
		    if (resp.data.length < 3) {
		      this.followerFinish = true;
		    }
		    
		  } catch (error) {
		    console.error("Error occurred during followerListPaging: ", error);
		  }
		  
		  this.followerLoading	 = false;
		},
		
           	
           	
           	// 마이페이지 게시물 목록 불러오기
           	async boardList(){
           	  if(this.loading == true) return; //로딩중이면
              if(this.finish == true) return; //다 불러왔으면
              this.loading = true;
              
           		const resp = await axios.get(contextPath+"/rest/member/page/"+this.page,{
           			params : {           
           				memberNo : this.memberNo
           			
           			},
           		});
           		
           	 for (const board of resp.data) {
             	this.isLiked.push(board.check);
             	this.boardLikeCount.push(board.boardWithNickDto.boardLike);
               }
           		
           	  const newData = resp.data;
  		    
  		    this.myBoardList.push(...resp.data);
           		this.page++;
           		
           		if(resp.data < 5) this.finish = true;
           	
           		
           		this.loading = false;
           		
           	},
           	
           	async boardList2(memberNo) {
           	  const resp = await axios.get(contextPath+"/rest/member/postList",{
           	    params: {
           	      memberNo: memberNo
           	    }
           	  });
				this.hoverPostList = [];
           	  const newPosts = resp.data.slice(0, 3); // 최대 3개의 게시물만 추출

           	  this.hoverPostList.push(...newPosts);
           	},
           	
        	async boardList3(memberNo) {
             	  const resp = await axios.get(contextPath+"/rest/member/postList",{
             	    params: {
             	      memberNo: memberNo
             	    }
             	  });
  				this.hoverPostList2 = [];
             	  const newPosts = resp.data.slice(0, 3); // 최대 3개의 게시물만 추출

             	  this.hoverPostList2.push(...newPosts);
             	  
             	},
           	
           	checkOwnerShip(){ // 본인인지 여부 체크
           		this.isOwner = this.memberNo == ${memberNo};
           	},
           async profileHover(item) {           		
           	  this.selectedItem = item; // 선택한 항목의 정보 저장
           	  // settingHide 불러오기 위해서 선언
           	const resp = await axios.get(contextPath+"/rest/member/setting/"+item.memberNo);
           	  const settingHide = resp.data.settingHide;
           	 
           	  
           	  
           	  Promise.all([
           		 this.getTotalFollowCount(item.memberNo), // 팔로우 수 가져오기
              	 this.getTotalFollowerCount(item.memberNo), // 팔로워 수 가져오기
              	 this.getTotalPostCount(item.memberNo), // 게시물 수 가져오기 
              	 //this.boardList2(item.memberNo), // 게시물 목록 가져오기
              	 this.boardList3(item.memberNo) // 게시물 목록 가져오기
             
           	  ])          	 
           	    .then(([followCounts,followerCounts,postCounts]) => {
           	      this.followCounts = followCounts; // 프로미스가 해결된 값 저장
           	      this.followerCounts = followerCounts; // 프로미스가 해결된 값 저장
           	      this.postCounts = postCounts; // 프로미스가 해결된 값 저장
           	      this.hoverSettingHide = settingHide;
           	      this.hoverFollowerCheck = this.followCheckIf(item.memberNo);
           	      this.hoverFollowCheck = this.followCheckIf(item.followFollower);
           	  	  
           	    })
           	    .catch(error => {
           	      console.error(error);
           	    });
           	},
           	
            async profileHover2(item) {           		
             	  this.selectedItem = item; // 선택한 항목의 정보 저장
             	  
             	  // settingHide 불러오기 위해서 선언
             	const resp = await axios.get(contextPath+"/rest/member/setting/"+item.followFollower);
             	  const settingHide = resp.data.settingHide;
             	 
             	  
             	  Promise.all([
             		 this.getTotalFollowCount(item.followFollower), // 팔로우 수 가져오기
                	 this.getTotalFollowerCount(item.followFollower), // 팔로워 수 가져오기
                	 this.getTotalPostCount(item.followFollower), // 게시물 수 가져오기 
                	 this.boardList2(item.followFollower), // 게시물 목록 가져오기
                	 //this.boardList3(item.memberNo) // 게시물 목록 가져오기
               
             	  ])          	 
             	    .then(([followCounts,followerCounts,postCounts]) => {
             	      this.followCounts = followCounts; // 프로미스가 해결된 값 저장
             	      this.followerCounts = followerCounts; // 프로미스가 해결된 값 저장
             	      this.postCounts = postCounts; // 프로미스가 해결된 값 저장
             	      this.hoverSettingHide = settingHide;
             	      this.hoverFollowerCheck = this.followCheckIf(item.memberNo);
             	      this.hoverFollowCheck = this.followCheckIf(item.followFollower);
             	    })
             	    .catch(error => {
             	      console.error(error);
             	    });
             	},
           	
           	profileLeave(){
           		this.selectedItem = null;
           	},
           	
           	boardInsert(){
           	// /board/insert로 이동
           	    window.location.href = contextPath+'/board/insert';
           	},
           	
           	
           	async handleScroll() {
           		
           	  const modalElement = this.$refs.followModal;
           	  const bodyElement = modalElement.querySelector('.modal-body');
           	  const contentHeight = bodyElement.scrollHeight;
           	  const currentScroll = bodyElement.scrollTop;
           	  const visibleHeight = bodyElement.clientHeight;
           	  const scrollPercentage = (currentScroll / (contentHeight - visibleHeight)) * 100;
           	  this.followPercent = Math.round(scrollPercentage);
           	  
           	 
	
           	  if (this.followPercent >= 80) {

           	    this.followListPaging();
           	  }
           	},
           	
          	async handleScroll2() {
             	  const modalElement = this.$refs.followerModal;
             	  const bodyElement = modalElement.querySelector('.modal-body');
             	  const contentHeight = bodyElement.scrollHeight;
             	  const currentScroll = bodyElement.scrollTop;
             	  const visibleHeight = bodyElement.clientHeight;
             	  const scrollPercentage = (currentScroll / (contentHeight - visibleHeight)) * 100;
             	  this.followerPercent = Math.round(scrollPercentage);
	
             	  if (this.followerPercent >= 80) {
             	    this.followerListPaging();
             	  }
             	},
            async memberSetting(){
             	const resp = await axios.get(contextPath+"/rest/member/setting/" +this.memberNo);
             	this.settingHide = resp.data.settingHide; 
             },
             
             //댓글 조회
             async replyLoad(index) {
             	this.replyList = [];
             	this.isReplyLiked = [];
             	this.replyLikeCount = [];
             	const resp = await axios.get("${pageContext.request.contextPath}/rest/reply/"+ this.myBoardList[index].boardWithNickDto.boardNo);
                 
             	for (const reply of resp.data) {
                 	this.isReplyLiked.push(await this.likeReplyChecked(reply.replyNo));
                 	this.replyLikeCount.push(reply.replyLike);
                   }
             	
             	this.replyList=[...resp.data];
             },
             
             //댓글 조회(북마크)
             async replyLoad2(index) {
             	this.replyList = [];
             	this.isReplyLiked2 = [];
             	this.replyLikeCount2 = [];
             	const resp = await axios.get("${pageContext.request.contextPath}/rest/reply/"+ this.bookmarkMyPostList[index].boardWithNickDto.boardNo);
                 
             	for (const reply of resp.data) {
                 	this.isReplyLiked2.push(await this.likeReplyChecked(reply.replyNo));
                 	this.replyLikeCount2.push(reply.replyLike);
                   }
             	
             	this.replyList=[...resp.data];
             },
             
             
      
           
           //댓글 등록
             async replyInsert(index) {
             	  const boardNo = this.myBoardList[index].boardWithNickDto.boardNo;
             	  const memberNo = this.myBoardList[index].boardWithNickDto.memberNo;
             	  const loginNo = parseInt(this.DmMemberNo);
             	  
             	  //세팅값 불러오기
             	  const response = await axios.get(contextPath+"/rest/member/setting/" + memberNo);
             	  const set = response.data.settingAllowReply;
             	  
             	  const requestData = {
             	    replyOrigin: boardNo,
             	    replyContent: this.replyContent,
             	    replyParent : this.replyParent
             	  };
             	  this.replyContent='';
             	  
             	  //모든 사람 작성 가능한 경우
             	  if(set == 0){
             	    const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
             	    this.replyLoad(index);	            		  
             	  }
             	  //내가 팔로우 하는 사람만 작성 가능한 경우
             	  else if(set == 1){
             		  //게시물 작성자 팔로우 로드
             		  await this.loadFollow(memberNo);
                   	  if(loginNo == memberNo) this.followList.push(loginNo); 
             		  
                   	  if(this.followList.includes(loginNo)){
             			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
                   	      this.replyLoad(index);
             		  }
             		  else{
             			  alert("댓글 사용이 불가능합니다.");
             		  }
             	  }
             	  //팔로워만 댓글 작성 가능한 경우
             	  else if(set == 2){
             		  await this.loadFollower(memberNo);
                   	  if(loginNo == memberNo) this.followerList.push(loginNo); 
             		  if(this.followerList.includes(loginNo)){
             			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
                   	      this.replyLoad(index);
             		  }
             		  else{
             			  alert("댓글 사용이 불가능합니다.");
             		  }
             	  }
             	  else{
             		  //게시물 작성자 팔로우 로드
             		  await this.loadFollow(memberNo);
                   	  if(loginNo == memberNo) this.followList.push(loginNo); 
             		  //게시물 작성자 팔로워 로드
                   	  await this.loadFollower(memberNo);
                   	  if(loginNo == memberNo) this.followerList.push(loginNo); 
             		  
                   	  if(this.followList.includes(loginNo) || this.followerList.includes(loginNo)){
             			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
                   	      this.replyLoad(index);
             		  }
             		  else{
             			  alert("댓글 사용이 불가능합니다.");
             		  }
             	  }
             	   
             },
             
             async replyInsert2(index) {
            	  const boardNo = this.bookmarkMyPostList[index].boardWithNickDto.boardNo;
            	  const memberNo = this.bookmarkMyPostList[index].boardWithNickDto.memberNo;
            	  const loginNo = parseInt(this.DmMemberNo);
            	  
            	  //세팅값 불러오기
            	  const response = await axios.get(contextPath+"/rest/member/setting/" + memberNo);
            	  const set = response.data.settingAllowReply;
            	  
            	  const requestData = {
            	    replyOrigin: boardNo,
            	    replyContent: this.replyContent,
            	    replyParent : this.replyParent
            	  };
            	  this.replyContent='';
            	  
            	  //모든 사람 작성 가능한 경우
            	  if(set == 0){
            	    const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
            	    this.replyLoad2(index);	            		  
            	  }
            	  //내가 팔로우 하는 사람만 작성 가능한 경우
            	  else if(set == 1){
            		  //게시물 작성자 팔로우 로드
            		  await this.loadFollow(memberNo);
                  	  if(loginNo == memberNo) this.followList.push(loginNo); 
                  	  if(this.followList.includes(loginNo)){
            			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
                  	      this.replyLoad2(index);
                  	      this.followList = [];
            		  }
            		  else{
            			  alert("댓글 사용이 불가능합니다.");
            		  }
            	  }
            	  //팔로워만 댓글 작성 가능한 경우
            	  else if(set == 2){
            		  await this.loadFollower(memberNo);
                  	  if(loginNo == memberNo) this.followerList.push(loginNo); 
            		  if(this.followerList.includes(loginNo)){
            			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
                  	      this.replyLoad2(index);
                  	      this.followerList = [];
            		  }
            		  else{
            			  alert("댓글 사용이 불가능합니다.");
            		  }
            	  }
            	  else{
            		  //게시물 작성자 팔로우 로드
            		  await this.loadFollow(memberNo);
                  	  if(loginNo == memberNo) this.followList.push(loginNo); 
            		  //게시물 작성자 팔로워 로드
                  	  await this.loadFollower(memberNo);
                  	  if(loginNo == memberNo) this.followerList.push(loginNo); 
            		  
                  	  if(this.followList.includes(loginNo) || this.followerList.includes(loginNo)){
            			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
                  	      this.replyLoad2(index);
                  	      this.followList = [];
                  	      this.followerList = [];
            		  }
            		  else{
            			  alert("댓글 사용이 불가능합니다.");
            		  }
            	  }
            	   
            },
             
             //댓글 가능 팔로우 체크
             async loadFollow(memberNo) {
             	const resp = await axios.post(contextPath + "/rest/follow/getFollow/" + memberNo);
             	this.followList.push(...resp.data);
             },
             
             //댓글 가능 팔로워 체크
             async loadFollower(memberNo) {
             	const resp = await axios.post(contextPath + "/rest/follow/getFollower/" + memberNo);
             	this.followerList.push(...resp.data);
             },
             
             
          
     
             //댓글 삭제
             async replyDelete(index,index2) {
             	const resp = await axios.delete("${pageContext.request.contextPath}/rest/reply/"+ this.replyList[index].replyNo);
             	this.replyLoad(index2);
             	this.hideAdditionalMenuModal();
             },
             //댓글 삭제(북마크)
             async replyDelete2(index,index2) {
             	const resp = await axios.delete("${pageContext.request.contextPath}/rest/reply/"+ this.replyList[index].replyNo);
             	this.replyLoad2(index2);
             	this.hideAdditionalMenuModal();
             },
             
           
             
             //대댓글
             reReply(replyNo) {
             	if(replyNo==this.replyParent){
             		this.replyParent = 0;
             		this.placeholder = "댓글 입력.."
             	}
             	else{
             		this.replyParent = replyNo;
             		this.placeholder = "답글 입력..";
             		this.$refs.replyInput.focus();
             	}
             },
             
           
             
           	//대댓글 펼치기
             showReReply(replyNo,index){
           		const arrayIndex = [];
           	 	const tmp = index+1;
           	  	if(index!=this.replyList.length){
               	  	while(true){
               		  	if(this.replyList[tmp]==null) break;
               		  	if(this.replyList[tmp].replyParent==replyNo){
     	         			  arrayIndex.push(tmp);
     	         			  tmp++;
     	         		  }
               		  	else if(this.replyList[tmp].replyParent==-1||this.replyList[tmp].replyParent==0) break;
     	         	  }
     	         	  
               	  	if(arrayIndex.length >= 1){
     	             	  for(var i = 0; i<arrayIndex.length; i++){
     	             		  this.replyList[arrayIndex[i]].replyParent = -1;
     	             	  }
     	             	 return;
     	         	  }
     	         	  
     	         	  while(true){
     	         		  if(this.replyList[tmp]==null) break;
     	         		  if(this.replyList[tmp].replyParent==-1){
     	         			  arrayIndex.push(tmp);
     	         			  tmp++;
     	         		  }else if(this.replyList[tmp]==null||this.replyList[tmp].replyParent==0) break;
     	         	  }
     	         	  
     	         	  for(var i = 0; i<arrayIndex.length; i++){
     	         		  this.replyList[arrayIndex[i]].replyParent = replyNo;
     	         	  }
     	     	  }
     	        },
              
              //대댓글 숨기기 보기 상태변경
              replyStatus(index){
     				if(index==this.replyList.length) return;
           	   		if(this.replyList[index+1]!=null&&this.replyList[index+1].replyParent>0){
     		      		   return "답글 보기";
     		      	}
           	   		else if(this.replyList[index+1]!=null&&this.replyList[index+1].replyParent==0){
     		      		   return "";
     		      	   }
           	   		else if(this.replyList[index+1]!=null&&this.replyList[index+1].replyParent<0){
     		      		   return "답글 숨기기";
     		      	   }
           	  
              },
             
             //상세보기 모달창 열기
             detailViewOn(index) {
             	this.detailView = true;
             	this.detailIndex = index;
             	this.replyLoad(index);
             	document.body.style.overflow = "hidden";
             },
             
             //상세보기 모달창 열기(북마크)
             detailViewOn2(index) {
             	this.detailView2 = true;
             	this.detailIndex2 = index;
             	this.replyLoad2(index);
             	document.body.style.overflow = "hidden";
             },
             
            
   
             //상세보기 모달창 닫기
             closeDetail() {
             	this.detailView = false;
             	this.replyList = [];
             	document.body.style.overflow = "unset";
             },
             

             //상세보기 모달창 닫기(북마크)
             closeDetail2() {
             	this.detailView2 = false;
             	this.replyList = [];
             	document.body.style.overflow = "unset";
             },
             
             //로그인한 회원이 좋아요 눌렀는지 확인
             async likeChecked(boardNo) {
             	const resp = await axios.post("${pageContext.request.contextPath}/rest/board/check", {boardNo:boardNo});			
             	return resp.data;
             },
             
             //로그인한 회원이 댓글 좋아요 눌렀는지 확인
             async likeReplyChecked(replyNo) {
             	const resp = await axios.post("${pageContext.request.contextPath}/rest/reply/check", {replyNo:replyNo});
             	return resp.data;
             },
             
             //좋아요
             async likePost(boardNo, index) {
                 const resp = await axios.post("${pageContext.request.contextPath}/rest/board/like", {boardNo:boardNo});
                 if(resp.data.result){
                 	this.isLiked[index] = true;
                 }
                 else {
                 	this.isLiked[index] = false;
                 }
                 
                 this.boardLikeCount[index] = resp.data.count;
             },
             
             //좋아요(북마크)
             async likePost2(boardNo, index) {
                 const resp = await axios.post("${pageContext.request.contextPath}/rest/board/like", {boardNo:boardNo});
                 if(resp.data.result){
                 	this.isLiked2[index] = true;
                 }
                 else {
                 	this.isLiked2[index] = false;
                 }
                 
                 this.boardLikeCount2[index] = resp.data.count;
             },
             
             //좋아요 리스트
             async likeListLoad(boardNo) {
             	const resp = await axios.get("${pageContext.request.contextPath}/rest/board/like/list/" + boardNo);
             	this.likeList = [...resp.data];
             },
             
             //좋아요 모달창 열기
             showLikeListModal(boardNo){
     			if(this.likeListModal==null) return;
     			this.likeListLoad(boardNo);
     			this.likeListModal.show();
     			this.likeListData=[boardNo];
     		},
     		
     		//좋아요 모달창 닫기
     		hideLikeListModal(){
     			if(this.likeListModal==null) return;
     			this.likeList=[];
     			this.likeListModal.hide();
     		},
             
             
             //댓글 좋아요
             async likeReply(replyNo, index) {
             	const resp = await axios.post("${pageContext.request.contextPath}/rest/reply/like", {replyNo:replyNo});
             	
             	if(resp.data.result) {
             		this.isReplyLiked[index] = true;
             	}
             	else {
             		this.isReplyLiked[index] = false;
             	}
             	this.replyLikeCount[index] = resp.data.count;
             },
             
             //댓글 좋아요(북마크)
             async likeReply2(replyNo, index) {
             	const resp = await axios.post("${pageContext.request.contextPath}/rest/reply/like", {replyNo:replyNo});
             	
             	if(resp.data.result) {
             		this.isReplyLiked2[index] = true;
             	}
             	else {
             		this.isReplyLiked2[index] = false;
             	}
             	this.replyLikeCount2[index] = resp.data.count;
             },
             
             
             //게시글 날짜 계산 함수
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
             		//return day + "일 전";
             	}
             		//return Math.floor(time) + "시간 전";
             	
             	
             },
             // 친구 추천 버튼
             recommend(){
            	 this.recommendFriends = !this.recommendFriends;
             },
             
             // 친구 추천목록 조회
             async recommendList(){
            	const resp = await axios.get(contextPath+"/rest/member/recommendFriendsList");
            	this.recommendFriendsList.push(...resp.data);
            	
            	// sessionStorage에 친구 추천목록 저장
            	sessionStorage.setItem("recommendFriendsList",JSON.stringify(this.recommendFriendsList));
             },
             
            deleteRecommendFriend(idToDelete){
            	
            	 // 추천 친구목록 가져오기
            	 const cachedRecommendFriendsList = sessionStorage.getItem("recommendFriendsList");
            	 const recommendFriendsList = JSON.parse(cachedRecommendFriendsList);
            	
            	 
            	 // 삭제할 데이터의 인덱스 찾기
            	 const indexToDelete = recommendFriendsList.findIndex(item => item.memberNo === idToDelete);
            	// 인덱스를 사용하여 데이터 삭제
            	  if (indexToDelete !== -1) {
            	    recommendFriendsList.splice(indexToDelete, 1);
            	    
            	    // 수정된 목록을 다시 sessionStorage에 저장
            	    sessionStorage.setItem("recommendFriendsList", JSON.stringify(recommendFriendsList));
           	    	
           	     this.recommendFriendsList = recommendFriendsList;
            	  }
             },
             
             async hashtTagList() {
           	  try {
           	    const resp = await axios.get(contextPath+"/rest/member/hashtagList", {
           	      params: {
           	        memberNo: this.memberNo,
           	      },
           	    });
           	    
           	    this.hashtagList.push(...resp.data);
           	    this.hashtagFollowCheck();
     	   
           	  } catch (error) {
           	    console.error(error);
           	  }
           	},
           	
           	async tagUnFollow(tagName) {
           		  try {
           		    const resp = await axios.post(contextPath+"/rest/follow/tagUnFollow/" + tagName);
           		    if (resp.data) {

           		      // Remove unfollowed tagName from hashtagList
           		      const index = this.hashtagFollowCheckList.findIndex(item => item.tagName === tagName);
           		      if (index !== -1) {
           		        this.hashtagFollowCheckList.splice(index, 1);
           		      }

           		      this.hashtagFollowCheck();
           		    } else {
           		    }
           		  } catch (error) {
           		    console.error(error);
           		  }
           		},

     			async tagFollow(tagName) {
     			  const resp = await axios.post(contextPath+"/rest/follow/tagFollow/" + tagName);
     			  if (resp.data) {
     				
     			    
     			    this.hashtagFollowCheck();

     			    // Add followed tagName to hashtagList
     			    
     			  } else {
     			  }
     			},
     			
     			// 태그 팔로우 v-if 여부체크 함수
     		tagFollowCheckIf(tagName) {
				  return !this.hashtagFollowCheckList.includes(tagName);
			},
     			
				
			async hashtagFollowCheck() {
				  try {
				    const resp = await axios.post(contextPath+"/rest/follow/hashTagCheck");
				    this.hashtagFollowCheckList = resp.data;
				  } catch (error) {
				    console.error(error);
				  }
				},
				
				async moveToTagPage(tagName){
					const data={searchTagName:tagName, searchDelete:1};
					const resp = await axios.post(contextPath+"/rest/search/", data);
					window.location.href=contextPath+"/tag/"+tagName;
				},
             	
         /*----------------------신고----------------------*/
                //신고 모달 show, hide
        		showReportMenuModal(boardNo, reportMemberNo, reportTable, index, detailIndex){
					if(reportTable!=null && reportTable=='member'){
	    				this.reportBoardData=[boardNo, reportMemberNo, reportTable, index, detailIndex];
					}
        			if(this.reportMenuModal==null) return;
        			this.reportMenuModal.show();
        			this.myOptionModalHide();
        			this.loadReportContent();
        		},
        		hideReportMenuModal(){
        			if(this.reportMenuModal==null) return;
        			this.reportMenuModal.hide();
        		},
        		showBlockModal(){
    				if(this.blockModal2==null) return;
    				this.blockModal2.show();
    				this.reportMenuModal.hide();
    			},
    			hideBlockModal(){
    				if(this.blockModal2==null) return;
    				this.blockModal2.hide();
    			},
        		//신고 목록 불러오기
        		async loadReportContent(){
        			const resp = await axios.get(contextPath+"/rest/reportContent/");
        			this.reportContentList = [...resp.data];
        		},
        		//신고
    			async reportContent(reportContent){
    				const data={
    					reportContent:reportContent,
    					reportTableNo:this.reportBoardData[0],
    					reportTable:this.reportBoardData[2],
    					reportMemberNo:this.reportBoardData[1],
    				}
    				const resp = await axios.post(contextPath+"/rest/report/", data)
    				this.hideReportMenuModal();
    				if(resp.data.length!=0){
    					this.reportBoardData[5] = resp.data.memberNick;
    				}
    				this.showBlockModal();
    			},
        		//차단
        		async blockUser(){
        			const resp = await axios.put(contextPath+"/rest/block/"+this.reportBoardData[1]);
        			if(resp.data){
        				this.hideBlockModal();
        				this.blockModalHide();
        				this.blockResultModalShow();
        			}
        			else{
        				this.blockModalHide();
        			}
        		},
        		showAdditionalMenuModal(boardNo, reportMemberNo, reportTable, index, detailIndex){
    				this.reportBoardData=[boardNo, reportMemberNo, reportTable, index, detailIndex];
    				if(this.additionalMenuModal==null) return;
    				this.additionalMenuModal.show();
    			},
    			hideAdditionalMenuModal(){
    				if(this.additionalMenuModal==null) return;
    				this.additionalMenuModal.hide();
    			},
    			//삭제
    			deleteTool(){
    				if(this.reportBoardData[2] == 'board'){
    					this.deletePost(this.reportBoardData[0]);
    				}
    				else {
    					this.replyDelete(this.reportBoardData[3],this.reportBoardData[4]);
    				}
    			},
    			//게시물 수정
    	        updatePost(boardNo){
    	        	window.location.href = "${pageContext.request.contextPath}/board/edit?boardNo="+ boardNo;
    	        },
    	        
    	        //게시물 삭제
    	        deletePost(boardNo){
    	        	//window.location.href = "${pageContext.request.contextPath}/search";
    	        	const confirmed = confirm("게시물을 삭제하시겠습니까?");
    	        	if(confirmed){
    	        		window.location.href = "${pageContext.request.contextPath}/board/delete?boardNo=" + boardNo;
    	        	}
    	        	else{
    	        		return;
    	        	}
    	        },
      	/*----------------------신고----------------------*/
        		
        		// 추천목록 reload
        		async recommendListReloading(){
        			this.isLoading = true;
        			
        			 await new Promise(resolve => setTimeout(resolve, 1500)); // 1.5초 대기
        			
        			this.recommendList();
        			this.isLoading = false;
        		},
        		async bookmarkMyPost(){
        			const resp = await axios.get(contextPath+"/rest/member/bookmarkMyPost");	
        			
        			for(const board of resp.data){
                    	this.isLiked2.push(board.check);
        				this.boardLikeCount2.push(board.boardWithNickDto.boardLike);
        			}
        			
        			  const newData = resp.data;
        			
        			this.bookmarkMyPostList.push(...resp.data);
        			
        		},
        		//북마크
        		async bookmarkInsert(boardNo) {
        		  const resp = await axios.post(contextPath+"/rest/bookmark/" + boardNo);
        		
        		  if (resp.data === true) {
        		    this.bookmarkCheck.push({ boardNo });
        		  } else {
        		    const index = this.bookmarkCheck.findIndex(item => item.boardNo === boardNo);
        		    if (index !== -1) {
        		      this.bookmarkCheck.splice(index, 1);
        		    }
        		  }
        		},
        		
        		bookmarkChecked(boardNo){
        			  return !this.bookmarkCheck.some(item => item.boardNo === boardNo);
        			},
        		
        		async bookmarkList(){
        			const resp = await axios.get(contextPath+"/rest/bookmark/selectOne");
        			this.bookmarkCheck.push(...resp.data);
        		},
        		
        		
        		
        		/*---------북마크 종료 ----------------- */
      		
        		// 회원탈퇴       	
        		async deleteMember(){
        			const resp = await axios.post(contextPath+"/rest/member/deleteMember");	
        				location.href=contextPath+"/member/login";	
        		},	
        		
            	//주소 알아오는 메소드
            	searchAddrFromCoords(callback) {
        		    // 좌표로 행정동 주소 정보를 요청합니다
        		    this.geocoder = new kakao.maps.services.Geocoder();
        		    this.geocoder.coord2RegionCode(${memberDto.memberLon}, ${memberDto.memberLat}, callback);
        		},
        		displayCenterInfo(result, status) {
        		    if (status === kakao.maps.services.Status.OK) {
        		        for(var i = 0; i < result.length; i++) {
        		            // 행정동의 region_type 값은 'H' 이므로
        		            if (result[i].region_type === 'H') {
        		                this.location = result[i].address_name;
        		                break;
        		            }
        		        }
        		    }
        		},
        		/*----------------------DM으로 이동 및 채팅방 생성 + 차단----------------------*/
        		async moveToDmPage(inviteeNo){
				    try {
				        // 로그인한 회원이 차단한 목록 조회
				        const blockList = await axios.get(contextPath + "/rest/blockList/" + this.DmMemberNo);
				        // 로그인한 회원이 차단당한 목록 조회
				        const blockedList = await axios.get(contextPath + "/rest/blockedList/" + this.DmMemberNo);
				        
				        // 본인이거나 로그인한 회원이 차단한 사람인 경우 메인 채팅방으로 이동
				        if(this.DmMemberNo == inviteeNo || blockList.data.find(blocked => blocked.blockNo == inviteeNo && blocked.memberNo == this.DmMemberNo)) {
				            window.location.href = contextPath + "/dm/channel";
				            return; 
				        }
				
				        // 차단당한 목록에서 초대받은 사람이 로그인한 회원을 차단한 경우
				        if(blockedList.data.find(blocked => blocked.memberNo == inviteeNo && blocked.blockNo == this.DmMemberNo)) {
				            // 두 회원이 참여한 채팅방 번호 조회
				            const checkResp = await axios.post(contextPath + "/rest/findPrivacyRoom/" + this.DmMemberNo + "/" + inviteeNo);
				            let existingRoomNo = checkResp.data;
				            
				            // 기존의 채팅방이 있을 경우 해당 채팅방으로 이동
				            if(existingRoomNo){
				                window.location.href = contextPath + "/dm/channel?room=" + existingRoomNo;
				                return;
				            }
				            // 없다면 메인 채팅방으로 이동
				            else {
				                window.location.href = contextPath + "/dm/channel";
				                return;
				            }
				        }
				        
				
				        // 두 회원이 참여한 채팅방 번호 조회
				        const checkResp = await axios.post(contextPath + "/rest/findPrivacyRoom/" + this.DmMemberNo + "/" + inviteeNo);
				        let existingRoomNo = checkResp.data;
				        
				        // 기존의 일대일 채팅방이 없을 경우, 새 채팅방 생성
				        if (!existingRoomNo) {
				            const dmRoomVO = await axios.post(contextPath + "/rest/createChatRoom");
				            const roomNo = dmRoomVO.data.roomNo;
				            // 채팅 유저 저장
				            const user = {
				                roomNo: roomNo,
				                memberList: [inviteeNo, this.DmMemberNo]
				            };
				            await axios.post(contextPath + "/rest/enterUsers", user);
				            // 생성된 채팅방으로 이동
				        	window.location.href = contextPath + "/dm/channel?room=" + roomNo;
				        }
				        // 기존의 일대일 채팅방이 있을 경우, 기존 채팅방으로 이동
				        else {
				            window.location.href = contextPath + "/dm/channel?room=" + existingRoomNo;
				        }
				    } catch (error) {
				    }
				},
        		/*----------------------DM으로 이동 및 채팅방 생성----------------------*/

        		
      		},
   		
       created() {
    	  // 데이터 불러오는 영역
    	  this.loadMember();
    	  this.totalFollowCount();
    	  this.totalFollowerCount();
    	  this.memberSetting();
    	  this.recommendList();
    	  this.hashtTagList();
    	  this.hashtagFollowCheck();
    	  this.bookmarkMyPost();
    	  this.bookmarkList();
    	  this.loadMemberSetting();
    	  Promise.all([this.followListPaging(), this.followerListPaging(), this.boardList()])
    	    .then(() => {
    	      this.followCheck();
    	    })
    	    .catch((error) => {
    	      console.error("Error occurred during initialization: ", error);
    	    });
    	  this.searchAddrFromCoords(this.displayCenterInfo);
    	},
      watch:{
    	// percent가 변하면 percent의 값을 읽어와서 80% 이상인지 판정
    	percent(){
    		if(this.percent >= 80){
    			
    			this.boardList();
    		}
    	},

      },
      mounted(){   
			this.checkOwnerShip();
            this.modal = new bootstrap.Modal(this.$refs.modal03);
            this.addtionModal = new bootstrap.Modal(this.$refs.addtionModal);
            this.blockModal = new bootstrap.Modal(this.$refs.blockModal);
            this.blockModal2 = new bootstrap.Modal(this.$refs.blockModal2);

            this.blockResultModal = new bootstrap.Modal(this.$refs.blockResultModal);
            this.myOptionModal = new bootstrap.Modal(this.$refs.myOptionModal);
            this.followerModal = new bootstrap.Modal(this.$refs.followerModal);
            this.followModal = new bootstrap.Modal(this.$refs.followModal);
            this.recommendFriendsAllListModal = new bootstrap.Modal(this.$refs.recommendFriendsAllListModal);
            this.deleteMemberModal = new bootstrap.Modal(this.$refs.deleteMemberModal);
            this.likeListModal = new bootstrap.Modal(this.$refs.likeListModal);
            this.additionalMenuModal = new bootstrap.Modal(this.$refs.additionalMenuModal);
            window.addEventListener("scroll", _.throttle(()=>{
            
            const height = document.documentElement.scrollHeight - window.innerHeight;
			const current = window.scrollY;
			const percent = (current / height) * 100;
			

           		this.percent = Math.round(percent);
            },250));
            /* 리포트 모달 */
            this.reportMenuModal = new bootstrap.Modal(this.$refs.reportMenuModal);
      },
      
   }).mount("#app");
</script>
<%@ include file="../template/footer.jsp" %>