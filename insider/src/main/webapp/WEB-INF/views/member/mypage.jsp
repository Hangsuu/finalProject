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
</style>






		<div id="app" class="container-fluid">
			    <div class="row">
            <div class="col-4 text-center">
                <img style="border-radius: 70%;" src="${pageContext.request.contextPath}/static/image/user.jpg"
 				width = "150" height="150">
            </div>
            <div class="col-4" style=" width:40%; margin-left:70px;">
            	
            	<div class="col-7" style="display:flex;">
            		<div class="col-6" style="width:60%;">
           		 <a href="#" class="btn btn-default" @click="showModal">${memberDto.memberNick}</a>    
    
     		</div>
     			<c:choose>
     			<c:when test="${isOwner}"> <!-- 본인 프로필 이라면 -->
     				<div class="col-7">
            		<a class="btn btn-secondary" href="setting">프로필 편집</a>
            		</div>
            	
            	<div class="col-5" style="width:40%;">
            	<button class="btn btn-secondary" @click="showModal2" style="background-color: white; border:none;"><i class="fa-sharp fa-solid fa-gear" style="font-size:24px;"></i></button>
 				</div>
     			</c:when>
     			
     			<c:otherwise> <!-- 본인 프로필이 아니라면 -->
     					<div class="col-5">
            	<button class="btn btn-primary">팔로우</button>
            	</div>
            	
            	<div class="col-5"  style=" width:70%;">
            	<button class="btn btn-secondary">메시지 보내기</button>
            	</div>
            	
            	<div class="col-5" style=" width:30%;">
            	<button class="btn btn-secondary"><i class="fa-solid fa-user-plus"></i></button>
            	</div
            	>
            	<div class="col-5" style="width:40%;">
            	<button class="btn btn-secondary" @click="showModal2"><i class="fa-solid fa-ellipsis"></i></button>
 				</div>
     			</c:otherwise>
     			</c:choose>
     			
            
 				</div>
	            <div class="row mt-4" style="width:130%;">
	            	<div class="col-7" style="display:flex; margin-left:10px;">
	            		<div class="col-6">
	            			<span>게시물 
	            				<span style="font-weight: bold;">${totalPostCount}</span>
	            			</span>
	            		</div>
	            		<div class="col-6">
	            			<span>팔로워
	            			<span style="font-weight: bold;">612만</span>
	            			 </span>
	            		</div>
	            		<div class="col-6">
	            			<span>팔로우
	            			<span style="font-weight: bold;">234</span>
	            			 </span>
	            		</div>
	            	</div>	
	            </div>
	            <div class="row mt-4">
	            	<span style="font-size:12px;">
	            	<h5>${memberDto.memberName}</h5>
	            	Aespa fashion 에스파 패션	          
					팬 페이지
					for aespa 💙
					#aespastyles_ (member)
					est june 2020 ✨ | twitter:
					twitter.com/aespastyles?s=21
					</span>
	            </div>
            	
            </div>
            </div>
            <hr>
            	<div class="position-absolute mt-5 start-50 translate-middle-x media-width" style="display: flex; flex-direction: column; width: 770px;">
		<div style="margin-bottom:10px;display: flex;flex-direction: row; width: 100%;">     
		    <div class="media-height" style="margin-right: 10px; position:relative;">
		        <img src="${pageContext.request.contextPath}/static/image/m.jpg" style="width:100%; height:250px;">
		        <i  class="fa-solid fa-note-sticky fa-lg" style="color:white;position:absolute;right:0;top:20px;"></i>
		        <div class="imgHover" style="cursor:pointer;position:absolute;background-color:#22222221;left:0;right:0;top:0;bottom:0;opacity:0;color:white;" >
                   	<i class="fa-solid fa-heart fa-lg" style="position:absolute;top:50%;left:25%;">1</i>
                    <i class="fa-regular fa-comment fa-lg" style="position:absolute;top:50%;left:50%;">2</i>
                </div>
                </div>
                
                <div class="media-height" style="margin-right: 10px; position:relative;">
		        <img src="${pageContext.request.contextPath}/static/image/m.jpg" style="width:100%; height:250px;">
		        <i  class="fa-solid fa-note-sticky fa-lg" style="color:white;position:absolute;right:0;top:20px;"></i>
		        <div class="imgHover" style="cursor:pointer;position:absolute;background-color:#22222221;left:0;right:0;top:0;bottom:0;opacity:0;color:white;" >
                   	<i class="fa-solid fa-heart fa-lg" style="position:absolute;top:50%;left:25%;"></i>
                    <i class="fa-regular fa-comment fa-lg" style="position:absolute;top:50%;left:50%;"></i>
                </div>
                </div>
                
                <div class="media-height" style="margin-right: 10px; position:relative;">
		        <img src="${pageContext.request.contextPath}/static/image/m.jpg" style="width:100%; height:250px;">
		        <i  class="fa-solid fa-note-sticky fa-lg" style="color:white;position:absolute;right:0;top:20px;"></i>
		        <div class="imgHover" style="cursor:pointer;position:absolute;background-color:#22222221;left:0;right:0;top:0;bottom:0;opacity:0;color:white;" >
                   	<i class="fa-solid fa-heart fa-lg" style="position:absolute;top:50%;left:25%;"></i>
                    <i class="fa-regular fa-comment fa-lg" style="position:absolute;top:50%;left:50%;"></i>
                </div>
                </div>
               
                </div>
       
		</div>        
                   <div class="modal" tabindex="-1" role="dialog" id="modal03"
                            data-bs-backdrop="static"
                            ref="modal03" @click.self="hideModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center;">
                        <h5 class="modal-title" style="text-align:center;">
                        	 <img style="border-radius: 70%;" src="${pageContext.request.contextPath}/static/image/user.jpg"
 							width = "150" height="150">
 							<div class="nickname">
 							${memberDto.memberNick}
 							</div>	
 						<div class="content" style="text-align:left;">
 							<div class="content">
 							<p style="font-size: 12px; color:gray;">신뢰할 수 있는 커뮤니티를 유지하기 위해 Insider 계정에 대한 정보가 표시됩니다</p>
 							</div>
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
 							<p style="font-size:12px; color:gray;">한국</p>
 						</div>	
                        </h5>
                    </div>
                   
                 
                        <button type="button" class="btn"
                                data-bs-dismiss="modal">닫기</button>
                   
                </div>      
            </div>
        </div>
        
        
		    <div class="modal" tabindex="-1" role="dialog" id="addtionModal"
                            data-bs-backdrop="static"
                            ref="addtionModal" @click.self="hideModal2">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center;">
                  		<a href="#" class="btn btn-default block" style="color:red;"  @click="blockModalShow">차단</a>
                    </div>
                     
                       <div class="modal-header" style="display:flex; justify-content: center;">
                        <a href="#" class="btn report" style="color:red;">신고</a>
                    </div>
                        <div class="modal-header" style="display:flex; justify-content: center;">
                       	<a @click="accountView">이 계정 정보</a>
                    </div>
                   
                 
                        <button type="button" class="btn"
                                data-bs-dismiss="modal">취소</button>
                   
                </div>      
            </div>
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="blockModal"
                            data-bs-backdrop="static"
                            ref="blockModal" @click.self="blockModalHide">
            <div class="modal-dialog" role="document" style="width:30%;">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center; flex-direction: column;">
                  	<h5 class="modal-title" style="text-align:center;">
                  		${memberDto.memberNick}님을 차단하시겠어요?
                  	</h5>
                  	<div class="content" style="font-size:12px; text-align:center;">
                  		상대방은 Insider에서 회원님의 프로필, 게시물 및 스토리를 찾을 수 없게 됩니다. Insider은 회원님이 차단한 사실을 상대방에게 알리지 않습니다.                  	
                  	</div>
                    </div>
                     <div class="modal-header" style="display:flex; justify-content: center;" >
                  		 <button type="button" class="btn" data-bs-dismiss="modal" style="color:red;">취소</button>
                    </div>
                   
                    <div class="modal-header" style="display:flex; justify-content: center;">
                       	<a @click="blockResultModalShow">차단</a>
                    </div>
                   
                </div>      
            </div>
        </div>
        
         <div class="modal" tabindex="-1" role="dialog" id="blockResultModal"
                            data-bs-backdrop="static"
                            ref="blockResultModal" @click.self="blockResultModalHide">
            <div class="modal-dialog" role="document" style="width:30%;">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center; flex-direction: column;">
                  	<h5 class="modal-title" style="text-align:center;">
                  		${memberDto.memberNick}님을 차단했습니다.
                  	</h5>
                  	<div class="content" style="font-size:12px; text-align:center;">
                  		<p style="font-size:12px; color:gray;">상대방의 프로필에서 언제든지 차단을 해제할 수 있습니다.</p>                 	
                  	</div>
                  	</div>
                  	<div class="model-header" style="text-align:center;">
                     <button type="button" class="btn" data-bs-dismiss="modal" style="color:red;">닫기</button>   
                     </div>
                     
            </div>
        </div>
      
        </div>
        
		
		
		</div> <!-- vue 끝 -->
		
		


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/vue@next"></script>
      <script>
	Vue.createApp({
		data() {
			return {
				//추가 메뉴 모달 및 신고 모달
				modal : null,
				addtionModal : null,
				reportMenuModal:null,
				blockModal : null,
				blockResultModal : null,
				reportContentList:[],
				reportBoardNo:"",
			};
		},
		computed: {
			
		},
		methods: {
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
              
              accountView(){
            	  this.addtionModal.hide();
            	  this.modal.show();
              },
            
			
		},
		created(){
			//데이터 불러오는 영역
		},
		watch:{
			//감시영역
		},
		mounted(){
			
            this.modal = new bootstrap.Modal(this.$refs.modal03);
            this.addtionModal = new bootstrap.Modal(this.$refs.addtionModal);
            this.blockModal = new bootstrap.Modal(this.$refs.blockModal);
            this.blockResultModal = new bootstrap.Modal(this.$refs.blockResultModal);
		},
	}).mount("#app");
</script>
<%@ include file="../template/footer.jsp" %>
