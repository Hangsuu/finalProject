<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>


<style>
   .div-center {
      display: inline-block;
      text-align: center;
   }

   .img {
      
      width: 45px;
      height: 45px;
      
   }
   
   .img.img-circle {
      border-radius: 50%;
   }
   
.note-editor .note-editing-area .note-editable {
    width: 100% !important;
    height: 200px !important;
    resize: none !important;
}
  
  .left {
     text-align: left;
     vertical-align: middle;
  }
  
  .right{
     text-align: right;
     vertical-align: middle;
  }
  
  .input-upload{
     padding: 10px 30px;
     background-color:#eb6864;
     border-radius: 4px;
     color: white;
     cursor: pointer;
   }
   
   .input-uploadPlus{
      padding: 10px 30px;
     background-color:white;
     border-radius: 4px;
     color: #eb6864;
     cursor: pointer;
     
   }
   
   .form-switch{
      padding: 0em;
   }
   
   .ppp{
      position: relative;
   }
   
   .xxx{
      position: absolute;
      top: 100px;
      right: 80px;
      z-index: 999;
   }
   
   .file-preview-container {
     display: flex;
     justify-content: center;
     align-items: center;
     height: 470px;
     margin: 0 auto;
   }
  
   .file-preview-wrapper {
     position: relative;
     display: flex;
     justify-content: center;
     align-items: center;
     width: 200px;
     height: 250px;
     overflow: hidden;
     margin: 0 10px;
   }
   
   .file-preview-wrapper > img {
     width: 100%;
     height: 100%;
     object-fit: cover;
   }
        
  .file-preview-wrapper-upload {
    margin: 10px;
    padding-top: 20px;
    background-color: white;
    width: 150px;
    border: 1px soild #eb6864;
    
   }
        
        
  .image-box {
    margin-top: 30px;
    padding-bottom: 30px;
    text-align: center;
   }
    
    .nickname{
       font-weight: bold;
       font-size: large;
       margin-left: 20px;
    }
    
    .hidefile{
       display:none;
    }
    
   .modal {
     display: none;
     position: fixed;
     z-index: 1;
     left: 0;
     top: 0;
     width: 100%;
     height: 100%;
     overflow: auto;
     background-color: rgba(0, 0, 0, 0.5);
     box-shadow: 4px 4px 4px -6px rgba(0, 0, 0, 0.5), 0 4px 5px rgba(0, 0, 0, 0.2);
   }
   
   .modal-content {
     background-color: #fefefe;
     margin: 15% auto;
     padding: 20px;
     border: 1px solid #888;
     width: 100%;
     max-width: 100%;
   }    
   
   .preview-image,
   .preview-video {
     width: 100%;
     height: 100%;
     object-fit: cover;
     display: block;
     object-fit: cover;
   }
   
   #summernote {
        border: none !important;
        resize: none !important;
        box-shadow: none !important;
    }
    
    .note-resizebar {
        display: none !important;
    }
    
    .note-statusbar {
       display: none !important;
    }
   
</style>


<script type="text/javascript">

$(function(){

   $(document).ready(function() {

        $('#modalForm').css('display', 'block');

        $('.modal-dialog').on('click', function(event) {
          event.stopPropagation();
        });

        $('.close').on('click', function() {
          $('#modalForm').css('display', 'none');
        });
      });


   $(document).ready(function() {
       $('#summernote').summernote({
           toolbar: false,
           callbacks: {
               onInit: function() {
    
                   var content = $('#summernote').val();
   
                   content = content.replace(/\n/g, '<br>');
   
                   $('#summernote').summernote('code', content);
               },
               onKeyup: function() {
   
                   var content = $('#summernote').summernote('code');
                   var characterCount = content.replace(/<[^>]+>/g, '').length;
                   $('.count').text(characterCount);
               }
           }
       });
   });

      
   
   $(".form-submit").submit(function(e){
   
      if($(".content").val() == ""){
         alert("문구를 입력하세요.");
         e.preventDefault();
      }
      
      if($("#upload2").val() == ""){
         $("#upload2").attr("disabled", true);
      }
      else{
         $("#upload2").attr("disabled", false);
      }
      
      
      if ($(".content").val() == "" || $("#tagName").val() != "") {

          $("#tagName").attr("disabled", false);

          tagBoardDto.tagName = $("#tagName").val();
        } else {
          $("#tagName").attr("disabled", true);
        }
      
      if($(".content").val() == "" || $("#memberTag").val() != ""){
         $("#memberTag").attr("disabled", false);
      }
      else{
         $("#memberTag").attr("disabled", true);
      }
      
   });
   
   //멀티 페이지
   let index = 0;
   move(index);
   
   $(".btn-next").click(function(){
      
      if($("#upload").val() == "" && $("#upload2").val() == ""){
            alert("사진을 선택하세요.");
            $(".btn-next").attr("disabled", false);
      }
      else{
         index++;
         move(index);
      }   
      
   });
   
   $(".btn-prev").click(function(){
      index--;
      move(index);
   });
   
   function move(index){
      $(".page").hide();
      $(".page").eq(index).show();
   }
   
});


</script>

<!------------------------------------------------------------------------------------->

<div id="modalForm" class="modal">


<div id="app" class="vue-container">

<form action="insert" method="post" enctype="multipart/form-data" class="form-submit">
<!-- gps 데이터 첨부 영역 -->
<input type="hidden" name="boardLon" v-model="gpsLon">
<input type="hidden" name="boardLat" v-model="gpsLat">
   <div class="container-fluid" style="width: 1200px">
   
      <div class="row mt-3"></div>
      
      <!-- 1. 사진 첨부 영역 -->
      <div class="page">
      <div class="row w-70 mt-5" style="float: none; margin: 0 auto;">
        <div class="col">
      
        <div class="card border-primary mb-3" style="height: 600px;">
          <div class="card-header">
            <div class="row">
              <div class="col-md-4">
                <button type="button" class="btn btn-secondary cancel" style="float:left;" @click="cancelPost">취소</button>
              	<button type="button" class="btn btn-secondary again" style="float:left; margin-left:10px;" @click="uploadAgainButton">다시 올리기</button>
              </div>
              <div class="col-md-4">
                <h4 class="text-primary text-center" style="margin-top: 1%;">새 게시물 만들기</h4>
              </div>
              <div class="col-md-4">
                <button type="button" class="btn btn-secondary btn-next" style="float:right;">다음</button>
              </div>
            </div>
          </div>
            
            
            <div>
               
               <!-- 1-1. 사진 첨부전, 업로드 버튼 영역 -->
               <div :class="{'hidefile':files.length > 0}">
                  <div class="card-body text-center" style="margin-top: 12%; height: 400px;">
                    <h1 class="card-title" ><i class="fa-regular fa-images"></i></h1>
                    <p class="card-text fs-5">사진을 선택하세요.</p>
                    <label for="upload" class="input-upload">업로드</label>
                    <input type="file" name="boardAttachment" accept="image/*, video/*" id="upload" ref="files" @change="imageUpload" style="display:none;" multiple>
                    <p style="margin-top: 20px;">* 이미지는 최대 5개까지 선택 가능합니다.</p>
                    <p style="margin-top: 20px;">* 이미지는 개당 최대 5MB를 넘을 수 없습니다.</p>
                  </div>
               </div>
               
               <!-- 1-2. 사진 첨부했을 때, 미리보기 영역 -->
               <div :class="{'hidefile': files.length==0}">
                 <div class="file-preview-container">
                   <div v-for="(file, index) in files" :key="index" class="file-preview-wrapper">
                     <template v-if="file.file.type.startsWith('image/')">
                       <img :src="file.preview" class="preview-image" />
                     </template>
                     <template v-else-if="file.file.type.startsWith('video/')">
                       <video :src="file.preview" class="preview-video" controls></video>
                     </template>
                   </div>
                   <div class="file-preview-wrapper-upload">
                     <div class="image-box" v-show="files.length==1">
                       <label for="upload2" class="input-uploadPlus">
                         <i class="fa-solid fa-plus fa-3x"></i>
                       </label>
                       <input type="file" name="boardAttachment" accept="image/*, video/*" id="upload2" ref="files2" @change="imageAddUpload(2)" style="display:none;"multiple/>
                     </div>
                     <div class="image-box" v-show="files.length==2">
                       <label for="upload3" class="input-uploadPlus">
                         <i class="fa-solid fa-plus fa-3x"></i>
                       </label>
                       <input type="file" name="boardAttachment" accept="image/*, video/*" id="upload3" ref="files3" @change="imageAddUpload(3)" style="display:none;"multiple/>
                     </div>
                     <div class="image-box" v-show="files.length==3">
                       <label for="upload4" class="input-uploadPlus">
                         <i class="fa-solid fa-plus fa-3x"></i>
                       </label>
                       <input type="file" name="boardAttachment" accept="image/*, video/*" id="upload4" ref="files4" @change="imageAddUpload(4)" style="display:none;"multiple/>
                     </div>
                     <div class="image-box" v-show="files.length==4">
                       <label for="upload5" class="input-uploadPlus">
                         <i class="fa-solid fa-plus fa-3x"></i>
                       </label>
                       <input type="file" name="boardAttachment" accept="image/*, video/*" id="upload5" ref="files5" @change="imageAddUpload(5)" style="display:none;"multiple/>
                     </div>
                   </div>
                 </div>
               </div>

            </div>
            
          </div>
      
        </div>
      </div>
      </div>
      
      
      <!-- 2. 게시물 등록 영역 -->
      <div class="page">
      <div v-show="files.length > 0" class="row w-70 mt-5" style="float: none; margin: 0 auto;">
        <div class="col">
      
          <div class="card border-primary mb-3" style="height: 600px;">
            <div class="card-header">
              <div class="row">
                <div class="col-md-2">
                  <button type="button" class="btn btn-secondary btn-prev" style="float:left;">이전</button>
                </div>
                <div class="col-md-8">
                  <h4 class="text-primary text-center" style="margin-top: 1%;">새 게시물 만들기</h4>
                </div>
                <div class="col-md-2">
                  <button type="submit" class="btn btn-primary" style="float:right;">공유하기</button>
                </div>
              </div>
            </div>
            
            <div class="card-body text-center">
            
               <div class="row">
                  <div class="col-md-7">
                     
               <div id="carouselExampleIndicators" class="carousel slide" data-bs-interval="false">
                 <div class="carousel-indicators">
                   <button v-for="(file, index) in files" :key="index" type="button" data-bs-target="#carouselExampleIndicators" :data-bs-slide-to="index" :class="{'active':index==0}" :aria-current="index==0" :aria-label="'Slide'+(index+1)"></button>
                 </div>
                 
                 <div class="carousel-inner">
                   <div v-for="(file, index) in files" :key="index" class="carousel-item" :class="{'active':index==0}">
                     <template v-if="file.file.type.startsWith('image/')">
                       <img :src="file.preview" class="d-block w-100" style="max-height: 480px; object-fit: contain;" />
                     </template>
                     <template v-else-if="file.file.type.startsWith('video/')">
                       <video class="d-block w-100" style="max-height: 480px;" controls>
                         <source :src="file.preview" type="video/mp4">
                       </video>
                     </template>
                   </div>
                 </div>
                 
                 <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                   <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                   <span class="visually-hidden">Previous</span>
                 </button>
                 <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                   <span class="carousel-control-next-icon" aria-hidden="true"></span>
                   <span class="visually-hidden">Next</span>
                 </button>
               </div>

                     
                  </div>
                  
                  <div class="col-md-5">
                      <div class="row">
                         <div class="col-md-10 left bottom">
                            <span class="nickname">${memberNick}</span>
                         </div>
                      </div>
                      
                      <div class="row mb-2"></div>
                      
                   <div class="row">
                      <div id="summernoteContainer">
                          <textarea id="summernote" class="form-control content" rows="6" name="boardContent" placeholder="문구를 입력하세요" required ></textarea>
                      </div>
                      <div class="right">
                          <span class="length">
                              <span class="count">0</span>
                              /
                              <span class="total">1000</span>
                          </span>
                      </div>
                  </div>

                      
                      <div class="row mt-3">
                         <input type="text" name="tagName" class="form-control" placeholder="#해시태그" id="tagName" autocomplete="off" value="${tag}">
                      </div>
                      
                      <div class="row mt-3">
                         {{currentAddr}}
                      </div>
                      
                      
                      <div class="row mt-3 form-check form-switch" style="display: flex;">
                         
                              <div class="col-md-9 left" style="margin-left: 0px;">
                                 <label class="fs-5" for="replyCheck">댓글 기능 해제</label>
                              </div>
                              <div class="col-md-3">
                                 <input type="checkbox" name="boardReplyValid" v-model="isReplyValidChecked" :value="isReplyValidChecked?1:0" class="form-check-input fs-5" style="margin-left: 0;">
                              </div>
                           
                      </div>
                      
                      <div class="row mt-2 form-check form-switch" style="display: flex;">
                         
                              <div class="col-md-9 left" style="margin-left: 0px;">
                                 <label class="fs-5" for="replyCheck">좋아요 수 숨김</label>
                              </div>
                              <div class="col-md-3">
                                 <input type="checkbox" name="boardLikeValid"  v-model="isLikeValidChecked" :value="isLikeValidChecked?1:0" class="form-check-input fs-5" style="margin-left: 0;">
                              </div>
                           
                      </div>
                      
                      <div class="row mt-1">
                           <p class="left" style="font-size: small;">게시물 상단의 메뉴에서 이 설정을 변경할 수 있습니다.</p>
                      </div>
                      
                      </div>
                
                     </div>
               </div>
              
            </div>
            
          </div>
      
        </div>
       </div>
      </div>
      
      <div class="row mb-5"></div>
   

</form>

</div>

</div>






<!------------------------------------------------------------------------------------->


<script src="https://unpkg.com/vue@3.2.36"></script>
<!-- 카카오맵 CDN -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e45b9604d6c5aa25785459639db6e025&libraries=services"></script>
<script>
  //div[id=app]을 제어할 수 있는 Vue instance를 생성
  const app = Vue.createApp({
    //data 영역 : 화면을 구현하는데 필요한 데이터를 작성해둔다.
    el: ".vue-container",
    data(){
      return {
         files : [],
         filesPreview: [],
         uploadImageIndex: 0,
         isReplyValidChecked:false,
         isLikeValidChecked:false,
         gpsLat:memberGpsLat,
         gpsLon:memberGpsLon,
         //주소 알아오는 코드
         geocoder:null,
         currentAddr:"",

      }
    },

    //methods : 애플리케이션 내에서 언제든 호출 가능한 코드 집합이 필요한 경우 작성한다.
     methods: {
        
        cancelPost(event) {
             event.stopPropagation();
             const text = confirm("게시물을 삭제하시겠어요?\n지금 나가면 수정 내용이 저장되지 않습니다.");

             if (text) {
               window.history.back();
             }
           },
        
        videoUpload() {
            for (let i = 0; i < this.$refs.files.files.length; i++) {
              const file = this.$refs.files.files[i];
              const preview = URL.createObjectURL(file);
              const number = this.files.length + i;

              this.files = [
                ...this.files,
                {
                  file,
                  preview,
                  number
                }
              ];
            }
            this.uploadImageIndex = this.files.length;
          },

        
          imageUpload() {
               for (let i = 0; i < this.$refs.files.files.length; i++) {
                 const file = this.$refs.files.files[i];
                 const fileSizeInMB = file.size / (1024 * 1024); // mb로 계산

                 if (fileSizeInMB > 5) {
                   alert('첨부파일 용량은 5MB를 넘을 수 없습니다.'); 
                   return; // 업로드 중지
                 }

                 const preview = URL.createObjectURL(file);
                 const number = this.files.length + i;

                 this.files = [
                   ...this.files,
                   {
                     file,
                     preview,
                     number
                   }
                 ];
               }
               this.uploadImageIndex = this.files.length;
             },

             imageAddUpload(index) {
               let num = -1;
               let files;
               if(index==2) files = this.$refs.files2.files;
               else if(index==3) files = this.$refs.files3.files;
               else if(index==4) files = this.$refs.files4.files;
               else if(index==5) files = this.$refs.files5.files;
               for (let i = 0; i < files.length; i++) {
                 const file = files[i];
                 const fileSizeInMB = file.size / (1024 * 1024); // mb로 계산

                 if (fileSizeInMB > 5) {
                      alert('첨부파일 용량은 5MB를 넘을 수 없습니다.'); 
                   return; // 업로드 중지
                 }

                 this.files = [
                   ...this.files,
                   {
                     file: file,
                     preview: URL.createObjectURL(file),
                     number: i + this.uploadImageIndex
                   }
                 ];
                 num = i;
               }
               this.uploadImageIndex = this.uploadImageIndex + num + 1;
             },

            uploadAgainButton(e) {
            	 this.files = [];
             },

       //주소 알아오는 메소드
       searchAddrFromCoords(callback) {
          // 좌표로 행정동 주소 정보를 요청합니다
          this.geocoder = new kakao.maps.services.Geocoder();
          this.geocoder.coord2RegionCode(memberGpsLon, memberGpsLat, callback);
      },
      displayCenterInfo(result, status) {
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
    },
    created(){
      this.searchAddrFromCoords(this.displayCenterInfo);
    },
  });
  app.mount("#app");
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>