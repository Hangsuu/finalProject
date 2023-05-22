<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.selected{
	border:1px solid black
}
</style>
<div class="container-fluid mt-4" id="app">
	<div class="row">
	<!-- 좌측 사이드 메뉴바 -->
		<div class="col-md-4">
			<div class="row setting-menu" @click="changePage(0)" :class="{'selected':page==0}">
				<div class="col">
					<h2>개인정보 변경</h2>
				</div>
			</div>
			<div class="row setting-menu" @click="changePage(1)" :class="{'selected':page==1}">
				<div class="col">
					<h2>프로필 편집</h2>
				</div>
			</div>
			<div class="row setting-menu" @click="changePage(2)" :class="{'selected':page==2}">
				<div class="col">
					<h2>푸시 알림</h2>
				</div>
			</div>
			<div class="row setting-menu" @click="changePage(3)" :class="{'selected':page==3}">
				<div class="col">
					<h2>내가 볼 수 있는 내용</h2>
				</div>
			</div>
			<div class="row setting-menu" @click="changePage(4)" :class="{'selected':page==4}">
				<div class="col">
					<h2>공개 범위</h2>
				</div>
			</div>
			<div class="row setting-menu" @click="changePage(5)" :class="{'selected':page==5}">
				<div class="col">
					<h2>소통 방법</h2>
				</div>
			</div>
		</div>
	<!------------------------------------------- 개인정보 변경 ------------------------------------------->
		<div class="col-md-8" v-show="page==0">
			<div class="row">
				<div class="col">
					<h1>개인정보 변경</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<span>연락처 정보</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input class="form-control" v-model="member.memberEmail">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<span>생일</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input class="form-control" v-model="member.memberBirth">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<span>주소</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="button" @click="findAddress()" value="우편번호 찾기" /><br />
				</div>
				<div class="col">
					<input class="form-control" v-model="member.memberPost" readonly>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input class="form-control" v-model="member.memberBasicAddr" readonly>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input class="form-control" v-model="member.memberDetailAddr">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3 @click="showPasswordCheckModal">비밀번호 변경</h3>
				</div>
			</div>
		</div>
	<!------------------------------------------- 프로필 편집 ------------------------------------------->
		<div class="col-md-8" v-show="page==1">
			<div class="row">
				<div class="col">
					<h1>프로필 편집</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					<img :src="profileUrl" width="100" height="100">
				</div>
				<div class="col-9">
					<div class="row">
						<div class="col">
							<span>{{member.memberName}}</span>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<span @click="openFileInput">프로필 사진 변경</span>
							<input ref="fileInput" type="file" @change="handleFileUpload" accept="image/*" style="display: none;">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					<span>소개</span>
				</div>
				<div class="col-9">
					<input type="text" class="form-control" v-model="member.memberMsg">
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					<span>성별</span>
				</div>
				<div class="col-9">
					<select class="form-control" v-model="member.memberGender">
						<option :value="0" :selected="member.memberGender==0">남성</option>
						<option :value="1" :selected="member.memberGender==1">여성</option>
					</select>
				</div>
			</div>
		</div>
	<!------------------------------------------- 푸시 알림 ------------------------------------------->
		<div class="col-md-8" v-show="page==2">
			<div class="row">
				<div class="col">
					<h1>푸시 알림</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>좋아요 알림</h2>
				</div>
				<div class="col">
					<span>받음</span>
					<input type="radio" :value="1" v-model.number="setting.settingLikeAlert" v-bind:checked="setting.settingLikeAlert==1">
				</div>
				<div class="col">
					<span>안받음</span>
					<input type="radio" :value="0" v-model.number="setting.settingLikeAlert" v-bind:checked="setting.settingLikeAlert==0">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>댓글 알림</h2>
				</div>
				<div class="col">
					<span>받음</span>
					<input type="radio" :value="1" v-model.number="setting.settingReplyAlert" v-bind:checked="setting.settingReplyAlert==1">
				</div>
				<div class="col">
					<span>안받음</span>
					<input type="radio" :value="0" v-model.number="setting.settingReplyAlert" v-bind:checked="setting.settingReplyAlert==0">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>팔로우 알림</h2>
				</div>
				<div class="col">
					<span>받음</span>
					<input type="radio" :value="1" v-model.number="setting.settingFollowAlert" v-bind:checked="setting.settingFollowAlert==1">
				</div>
				<div class="col">
					<span>안받음</span>
					<input type="radio" :value="0" v-model.number="setting.settingFollowAlert" v-bind:checked="setting.settingFollowAlert==0">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>댓글에 좋아요 알림</h2>
				</div>
				<div class="col">
					<span>받음</span>
					<input type="radio" :value="1" v-model.number="setting.settingReplyLikeAlert" v-bind:checked="setting.settingReplyLikeAlert==1">
				</div>
				<div class="col">
					<span>안받음</span>
					<input type="radio" :value="0" v-model.number="setting.settingReplyLikeAlert" v-bind:checked="setting.settingReplyLikeAlert==0">
				</div>
			</div>
		</div>
	<!------------------------------------------- 내가볼수있는내용 ------------------------------------------->
		<div class="col-md-8" v-show="page==3">
			<div class="row">
				<div class="col">
					<h1>내가 볼 수 있는 내용</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>좋아요 수 및 조회수 숨기기</h3>
				</div>
				<div class="col">
					<input type="checkbox" @change="watchLike" v-model="setting.isWatchLike">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>다른 게시물에서~</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>반경 설정</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<!-- <input type="text" v-model.number="setting.settingDistance"> -->
 					<input type="range" v-model="setting.settingDistance" min="5" max="300" step="1">
 				</div>
				<div class="col">
					<span>{{setting.settingDistance}}km 이내 게시물을 탐색합니다</span>
				</div>
 				<div class="col">
					<button class="btn btn-primary" @click="settingMap">미리보기</button>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div id="map" style="width:100%;height:350px;" ref="map"></div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<span>{{currentAddr}}</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>동영상 자동재생</h2>
				</div>
				<div class="col">
					<span>자동재생</span>
					<input type="radio" :value="1" v-model.number="setting.settingVideoAuto" v-bind:checked="setting.settingVideoAuto==1">
				</div>
				<div class="col">
					<span>수동재생</span>
					<input type="radio" :value="0" v-model.number="setting.settingVideoAuto" v-bind:checked="setting.settingVideoAuto==0">
				</div>
			</div>
		</div>
	<!------------------------------------------- 내 콘텐츠를 볼수 있는 사람 ------------------------------------------->
		<div class="col-md-8" v-show="page==4">
			<div class="row">
				<div class="col">
					<h1>내 콘텐츠를 볼 수 있는 사람</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>계정 공개 범위</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" :value="0" v-model.number="setting.settingHide" v-bind:checked="setting.settingHide==0">
					<span>전체 공개</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" :value="1" v-model.number="setting.settingHide" v-bind:checked="setting.settingHide==1"><span>친구추천 불가</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" :value="2" v-model.number="setting.settingHide" v-bind:checked="setting.settingHide==2"><span>친구에게만 공개</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" :value="3" v-model.number="setting.settingHide" v-bind:checked="setting.settingHide==3"><span>비공개 계정</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col">
					<h3>차단된 계정</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<span @click="showBlockModal">차단한 계정 확인하고 관리하기</span>
				</div>
			</div>
		</div>
	<!------------------------------------------- 다른 사람이 나와 소통할 수 있는 방법 ------------------------------------------->
		<div class="col-md-8" v-show="page==5">
			<div class="row">
				<div class="col">
					<h1>다른 사람이 나와 소통할 수 있는 방법</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>댓글관리</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>댓글을 허용할 사람 선택</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" :value="0" v-model.number="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==0">
					<span>모든 사람</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" :value="1" v-model.number="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==1"> 
					<span>내가 팔로우 하는 사람</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" :value="2" v-model.number="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==2"> 
					<span>내 팔로워</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" :value="3" v-model.number="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==3"> 
					<span>내가 팔로우 하는 사람 및 내 팔로워</span>
				</div>
			</div>
		</div>
	</div>

<!-- ---------------------------------비밀번호 확인 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="passwordModal" data-bs-backdrop="static" ref="passwordCheckModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호 변경</h5>
					<button type="button" class="btn-close" @click="hidePasswordCheckModal" aria-label="Close">
					<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row">
						<div class="col">
							<span>비밀번호 확인</span>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<input class="form-control rounded" placeholder="비밀번호 입력" type="password" v-model="password">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" @click="clickCheckPassword">확인</button>
					<button type="button" class="btn btn-secondary" @click="hidePasswordCheckModal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- ---------------------------------비밀번호 변경 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="changePasswordModal" data-bs-backdrop="static" ref="passwordChangeModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호 변경</h5>
					<button type="button" class="btn-close" @click="hidePasswordChangeModal" aria-label="Close">
					<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row">
						<div class="col">
							<span>바꿀 비밀번호 입력</span>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<input class="form-control rounded" placeholder="비밀번호 입력" type="password" v-model="newPassword">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<input class="form-control rounded" placeholder="비밀번호 확인" type="password" v-model="newPasswordCheck">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" @click="changePassword" :disabled="!isValid">변경</button>
					<button type="button" class="btn btn-secondary" @click="hidePasswordChangeModal">취소</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ---------------------------------차단 관리 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="blockModal" data-bs-backdrop="static" ref="blockModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">차단유저 관리</h5>
					<button type="button" class="btn-close" @click="hideBlockModal" aria-label="Close">
					<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row">
						<div class="col">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" @click="hideBlockModal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<!-- 우편번호 찾기 CDN -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 카카오맵 CDN -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e45b9604d6c5aa25785459639db6e025&libraries=services"></script>
<script>
	Vue.createApp({
		data() {
			return {
				passwordCheckModal:null,
				passwordChangeModal:null,
				blockModal:null,
				page:"",
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
				setting:{
					memberNo:"",
					settingHide:"",
					settingDistance:"",
					settingLikeAlert:"",
					settingReplyAlert:"",
					settingFollowAlert:"",
					settingVideoAuto:"",
					settingReplyLikeAlert:"",
					settingMessage:"",
					settingAllowReply:"",
					settingWatchLike:"",
					isWatchLike:this.settingWatchLike==1,
				},
				password:"",
				newPassword:"",
				newPasswordCheck:"",
				mapContainer:null,
				options:null,
				map:null,
				circle:null,
				changeValid:true,
				currentAddr:"",
				geocoder:null,
				blockList:[],
			};
		},
		computed: {
			//계산영역
			profileUrl(){
				if(this.member.attachmentNo>0){
					return contextPath+"/rest/attachment/download/"+this.member.attachmentNo;
				}
				else{
					return "https://via.placeholder.com/100x100?text=profile";
				}
			},
			isValid(){
				return this.newPassword.length>0 && this.newPassword==this.newPasswordCheck;
			},
			mapLevel(){
				if(this.setting.settingDistance<=5) return 8;
				else if(this.setting.settingDistance<=10) return 9;
				else if(this.setting.settingDistance<=20) return 10;
				else if(this.setting.settingDistance<=40) return 11;
				else if(this.setting.settingDistance<=80) return 12;
				else if(this.setting.settingDistance<=150) return 13;
				else return 14;
			}
		},
		methods: {
			//쿼리값 page로 반환
			initializePageFromQuery() {
				const queryParams = new URLSearchParams(window.location.search);
				const page = queryParams.get('page');
				this.page = page
			},
			//쿼리 업데이트를 위한 page 데이터 변경 및 쿼리 변경 메서드
			changePage(page){
				this.page=page;
				const queryParams = new URLSearchParams(window.location.search);
				queryParams.set('page', this.page);
				const newURL = `?`+queryParams.toString();
				//쿼리 히스토리 저장
				window.history.pushState({ query: queryParams.toString() }, '', newURL);
			},
			
			//watchLike 체크에 따른 값 변화
			watchLike(){
				if(this.setting.isWatchLike){
					this.setting.settingWatchLike=0;
				}
				else{
					this.setting.settingWatchLike=1;
				}
			},
			
			//세팅 데이터 불러오기
			async loadSetting(){
				const resp = await axios.get(contextPath+"/rest/member/setting/"+memberNo);
				Object.assign(this.setting, resp.data);
			},
			//멤버 정보 불러오기
			async loadMember(){
				const resp = await axios.get(contextPath+"/rest/member/"+memberNo);
				Object.assign(this.member, resp.data);
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
				this.member.attachmentNo = resp.data;
			},
			//비동기 회원 데이터 수정
			async saveMember(){
				const resp = await axios.put(contextPath+"/rest/member/", this.member);
			},
			//비동기 세팅 데이터 수정
			async saveSetting(){
				const resp = await axios.put(contextPath+"/rest/member/setting/", this.setting);
			},
			/*------------------------비밀번호 변경------------------------*/
			//비밀번호 변경 모달창 열기
			showPasswordCheckModal(){
				if(this.passwordCheckModal==null) return;
				this.passwordCheckModal.show();
			},
			hidePasswordCheckModal(){
				if(this.passwordCheckModal==null) return;
				this.passwordCheckModal.hide();
				this.password="";
			},
 			showPasswordChangeModal(){
				if(this.passwordChangeModal==null) return;
				this.passwordChangeModal.show();
			},
			hidePasswordChangeModal(){
				if(this.passwordChangeModal==null) return;
				this.passwordChangeModal.hide();
				this.newPassword="";
				this.newPasswordCheck="";
			},
			//비밀번호 확인
			clickCheckPassword(){
				this.checkPassword();
				if(this.passwordCheck){
					this.hidePasswordCheckModal;
				}
			},
			//비밀번호 확인 통신
			async checkPassword(){
				let sendPassword = {memberPassword:this.password}
				const resp = await axios.post(contextPath+"/rest/member/setting/password", sendPassword);
				if(resp.data){
					this.hidePasswordCheckModal();
					this.showPasswordChangeModal();
				}
				else{
					alert("비밀번호를 다시 입력하세요");
					this.password="";
				}
			},
			//비밀번호 변경 통신
			async changePassword(){
				let sendNewPassword = {memberPassword:this.newPassword}
				const resp = await axios.put(contextPath+"/rest/member/setting/password", sendNewPassword)
				this.hidePasswordChangeModal();
			},
			
			/*------------------------우편번호 찾기------------------------*/
			findAddress(){
				new daum.Postcode({
					oncomplete: (data)=> {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
						
						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						let addr = ""; // 주소 변수
						let extraAddr = ""; // 참고항목 변수
						
						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === "R") {
							// 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else {
							// 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}
						
						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						this.member.memberPost = data.zonecode;
						this.member.memberBasicAddr = addr;
					},
				}).open();
			},
			

			
			/*------------------------GPS 찾기------------------------*/
			getGps(){
				if (navigator.geolocation) {
					navigator.geolocation.getCurrentPosition(this.showGps, this.showError);
				} 
				else {
				// 브라우저가 Geolocation을 지원하지 않는 경우 처리할 로직
					console.log("Geolocation is not supported by this browser.");
				}
			},
			showGps(position){
				// 위치 정보 가져오기 성공 시 처리할 로직
				this.member.memberLat = position.coords.latitude;
				this.member.memberLon = position.coords.longitude;
			},
			showError(error) {
				// 위치 정보 가져오기 실패 시 처리할 로직
				switch (error.code) {
					case error.PERMISSION_DENIED:
						console.log("User denied the request for Geolocation.");
						break;
					case error.POSITION_UNAVAILABLE:
						console.log("Location information is unavailable.");
						break;
					case error.TIMEOUT:
						console.log("The request to get user location timed out.");
						break;
					case error.UNKNOWN_ERROR:
						console.log("An unknown error occurred.");
						break;
				}
			},
			/*------------------------카카오맵 표시------------------------*/
			settingMap(){
				this.mapContainer = this.$refs.map;
				const memberLat = this.member.memberLat;
				const memberLon = this.member.memberLon;
				this.options={
						center: new kakao.maps.LatLng(memberLat, memberLon),
						level:this.mapLevel,
				};
				this.map=new kakao.maps.Map(this.mapContainer, this.options);
				// 지도에 표시할 원을 생성합니다
				let circle = new kakao.maps.Circle({
					center : new kakao.maps.LatLng(memberLat, memberLon),  // 원의 중심좌표 입니다 
				    radius: this.setting.settingDistance*1000, // 미터 단위의 원의 반지름입니다 
				    strokeWeight: 2, // 선의 두께입니다 
				    strokeColor: '#75B8FA', // 선의 색깔입니다
				    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				    strokeStyle: 'solid', // 선의 스타일 입니다
				    fillColor: '#CFE7FF', // 채우기 색깔입니다
				    fillOpacity: 0.7  // 채우기 불투명도 입니다   
				});
				circle.setMap(this.map);
				// 마커가 표시될 위치입니다 
				let markerPosition  = new kakao.maps.LatLng(memberLat, memberLon); 
				// 마커를 생성합니다
				let marker = new kakao.maps.Marker({
				    position: markerPosition
				});
				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(this.map);
				
				this.geocoder = new kakao.maps.services.Geocoder();
				this.searchAddrFromCoords(this.map.getCenter(), this.displayCenterInfo);
			},
			searchAddrFromCoords(coords, callback) {
			    // 좌표로 행정동 주소 정보를 요청합니다
			    this.geocoder.coord2RegionCode(this.member.memberLon, this.member.memberLat, callback);
			    console.log(this.geocoder)
			},
			displayCenterInfo(result, status) {
				console.log(status)
				console.log(result)
			    if (status === kakao.maps.services.Status.OK) {
			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
			            if (result[i].region_type === 'H') {
			                this.currentAddr = result[i].address_name;
			                break;
			            }
			        }
			    }    
			},
			/*------------------------차단계정 관리------------------------*/
 			showBlockModal(){
				if(this.blockModal==null) return;
				this.blockModal.show();
			},
			hideBlockModal(){
				if(this.blockModal==null) return;
				this.blockModal.hide();
			},
			async getBlockList(){
				const resp = await axios.get(contextPath+"/rest/block/");
				this.blockList = [...resp.data];
			}
		},
		created(){
			//세팅데이터 로드
			this.loadMember();
			this.loadSetting();
			this.getBlockList();
		},
		mounted(){
			//모달 선언
			this.passwordCheckModal = new bootstrap.Modal(this.$refs.passwordCheckModal);
			this.passwordChangeModal = new bootstrap.Modal(this.$refs.passwordChangeModal);
			this.blockModal = new bootstrap.Modal(this.$refs.blockModal);

			//쿼리 초기화 및 변화 감지
			this.initializePageFromQuery();
			//뒤로가기, 앞으로가기 누르면 이전 쿼리 반환
			window.addEventListener('popstate', this.initializePageFromQuery);
		},
		watch:{
			//감시영역
 			member:{
				deep:true,
				handler : _.throttle(function(){
					this.saveMember();
				}, 1000)
			},
			setting:{
				deep:true,
				handler(){
					this.saveSetting();
				},
			},
		},
		updated(){
			if(this.page==3 && this.changeValid){
				this.settingMap();
 				if(this.currentAddr.length>0){
					this.changeValid=false;
				}
			};
		},
	}).mount("#app");
	
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>