
<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 14.      김도현      최초작성
* 2023. 11. 15.		 김도현	   담당자 및 품목 모달창 추가
* Copyright (c) 2023 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<script>

	$(document).ready(function() {
		// 불량재고 조회 페이지에 들어갔을 때
		// 불량관리 버튼이 열려있도록 collapse 클래스에 show 클래스 추가
		$('#quote').addClass('show');
	});
</script>        
        
<style>
.iText{
	border:none;
	background: transparent;
}
</style>

<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
					<br/>
				<h3 class="mb-0">견적서 입력</h3>
			</div>
			<div class="col-auto ms-auto">
				<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2"
					role="tablist"></div>
			</div>
		</div>
	</div>
	<br/>	<br/>
	<div class="card-body pt-0 ">
		<div class="tab-content">
			<div class="tab-pane preview-tab-pane active" role="tabpanel" aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
				id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">
				<c:url value="/quote" var="quoteUrl" />
				<form action="${quoteUrl}" id="quoteForm2" method="post">
				<div class="table-responsive scrollbar">
					<table class="table table-bordered table fs--1 mb-0" id="dataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>일자</th>
								<td colspan="5">
									<input type="date" id="quoteDate" name="qteDate" placeholder="일자" style="width: 170px;"/>
									<span id="quoteDateError" class="error"></span>
								</td>
							</tr>
							
							<tr>
								<th>담당자</th>
								<td colspan="5">
									<input type="text" id="findEmpNm" class="findEmpNm" name="empNm" placeholder="담당자" style="width: 170px;" />
									<span id="findEmpNmError" class="error"></span>
									<input type="hidden" id="findEmpCd" class="findEmpCd" name="empCd"  />
									
								</td>
							</tr>
							
							<tr>
								<th>거래처명</th>
								<td colspan="5">
									<input type="text" id="findComNm" name="comNm" placeholder="거래처명" style="width: 170px;" />
									<span id="findComNmError" class="error"></span>
									<input type="hidden" id="findComCd" class="comCd"  name="comCd"  />
									
								</td>
							</tr>
							
						</thead>
							
						<tbody>
							<tr>
								<th>품목코드</th>
								<th>품목명</th>
								<th>수량</th>
								<th>단가</th>
							</tr>
							
							
							<tr class="new-row-template">
								<td><!-- 품목코드 -->
									<input type="text" id="findItemCd" name="quoteItem[0].itemCd" class="iText clsItemCd" />
									<span id="quoteItem.itemCd" class="error"></span> 
								</td>
								<td><!-- 품목명 -->
									<input type="text" id="findItemNm" name="quoteItem[0].item.itemNm" class="iText clsItemNm" />
									<span id="quoteItem.item.itemNm" class="error"></span> 
								</td>
								<td><!-- 수량 -->
									<input type="number" id="qty" name="quoteItem[0].qteQty" class="iText clsQteQty" style="width: 120px" />
									<span id="quoteItem.qteQty" class="error"></span>
								</td>
								<td><!-- 단가 -->
									<input type="number" id="uprc" name="quoteItem[0].qteUprc" class="iText clsQteUprc" style="width: 120px" />
									<span id="quoteItem.qteUprc" class="error"></span>
								</td>
								<td><!-- [기능] -->
									<button class="btn btn-outline-danger rounded-capsule mb-1" type="button" onclick="deleteRow(this)">삭제</button>
								</td>
							</tr>
						
						</tbody>
					</table>
				</div>
				<br>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="submit" id="insertBtn2" style="margin-left:5px; float:right">저장</button>
				    <button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="addRowBtn" style="float:right">행 추가</button>
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
</div>



<!-- 담당자 검색 모달 -->
<div class="modal fade" id="findEmpModal" tabindex="-1"aria-labelledby="findEmpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findEmpModalLabel">담당자 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered table fs--1 mb-0" id="findEmpDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>사원코드</th>
								<th>담당자명</th>
								<th>부서</th>
								<th>연락처</th>
							</tr>
						</thead>
						<tbody class="list">
						
						</tbody>
							
					</table>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 거래처명 검색 모달 -->
<div class="modal fade" id="findComModal" tabindex="-1"aria-labelledby="findComModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findComModalLabel">거래처명 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered table fs--1 mb-0" id="findComDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>거래처코드</th>
								<th>거래처명</th>
							</tr>
						</thead>
						<tbody class="list">
						
						</tbody>
							
					</table>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

 <!-- 품목정보 검색 모달1 품목코드 눌럿을 때 --> 
<!-- <div class="modal fade" id="findItemModal1" tabindex="-1"aria-labelledby="findItemModalLabel1" aria-hidden="true"> -->
<!-- 	<div class="modal-dialog modal-lg"> -->
<!-- 		<div class="modal-content"> -->
 			<!-- 모달 내용 --> 
<!-- 			<div class="modal-header"> -->
<!-- 				<h5 class="modal-title" id="findItemModalLabel1">품목 검색</h5> -->
<!-- 				<button type="button" class="btn-close" data-bs-dismiss="modal" -->
<!-- 					aria-label="Close"></button> -->
<!-- 			</div> -->
<!-- 			<div class="modal-body"> -->
<!-- 				모달 내용이 들어갈 자리 -->
<!-- 				<table class="table table-bordered table-striped fs--1 mb-0" id="findItemDataTable1"> -->
<!-- 						<thead class="bg-200 text-900"> -->
<!-- 							<tr> -->
<!-- 								<th >품목코드</th> -->
<!-- 								<th >품목명</th> -->
								
<!-- 							</tr> -->
<!-- 						</thead> -->
<!-- 						<tbody class="list"> -->
						
<!-- 						</tbody> -->
<!-- 					</table> -->
<!-- 			</div> -->
<!-- 			<div class="modal-footer"> -->
<!-- 				<button type="button" class="btn btn-secondary" -->
<!-- 					data-bs-dismiss="modal">닫기</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

<!-- 품목정보 검색 모달2 품목명 눌럿을때 -->
<div class="modal fade" id="findItemModal2" tabindex="-1"aria-labelledby="findItemModalLabel2" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findItemModalLabel2">품목 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<div id="searchUI"  class="row g-3 d-flex justify-content-center" style="float: right;margin-top: 5px;">
			<div class="col-auto">
					<select name="searchType" class="form-select">
						<option value="">전체</option>
						<option value="itemCd">품목코드</option>
						<option value="itemNm">품목명</option>
					</select>
				</div>
				<div class="col-auto">
					<input type="text" name="searchWord" placeholder="검색" class="form-control"/>
				</div>
				<div class="col-auto">
					<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
				</div>
			</div>
				<table class="table table-bordered table fs--1 mb-0" id="findItemDataTable2">
						<thead class="bg-200 text-900">
							<tr>
								<th >품목코드</th>
								<th >품목명</th>
								<th >재고수량</th>
							</tr>
						</thead>
						<tbody class="itemList">
						
						</tbody>
						<tfoot class="pagingHtml">
							<tr><td colspan="2"><span id="pagingArea"></span></td></tr>
						</tfoot>
					</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<form action="<c:url value='/quote/listView'/>" id="searchForm" class="border">
	<input type="hidden" name="searchType" id="searchType" readonly="readonly" placeholder="searchNm"/>
	<input type="hidden" name="searchWord" id="searchWord" readonly="readonly" placeholder="searchData"/>
	<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
</form>
<script src="/resources/js/quote/quote.js"></script>
<script>
function fn_paging(page) {
	searchForm.page.value = page;
	searchForm.requestSubmit();
	searchForm.page.value = "";
}
</script>

<script>
function showSuccessAlert() {
	  Swal.fire({
    title: '견적서 등록 완료!',
    text: '견적서 등록이 성공적으로 완료되었습니다.',
    icon: 'success',
    confirmButtonText: '확인'
	  }).then((result) => {
	        if (result.isConfirmed) {
	           
	            window.location.href = '/quote/list'; 
	        }
  });
}

document.getElementById('quoteForm2').addEventListener('submit', function (event) {
  event.preventDefault();
  
  
  $.ajax({
      url: this.action,
      method: this.method,
      data: new FormData(this),
      processData: false,
      contentType: false,
      success: function (response) {
          
          showSuccessAlert();
      },
      error: function (error) {
          console.error(error);
          
      }
  });
});
</script>

<script>
    $(document).ready(function () {
        // 행 추가 버튼 클릭 시 동작
        $("#addRowBtn").on("click", function () {
            // 템플릿 행 복제
            var newRow = $(".new-row-template").clone();
            newRow.removeClass("new-row-template");
            newRow.css("display", "table-row");
            
            // 새로운 행을 테이블에 추가
            $("#dataTable tbody").append(newRow);
            
            
            //품목코드, 품목명, 수량, 단가. name값 정리
            //품목코드
            $(".clsItemCd").each(function(idx){
            	$(this).attr("name","quoteItem["+idx+"].itemCd");
            });
            $(".clsItemCd").last().val("");
            //품목명
            $(".clsItemNm").each(function(idx){
            	$(this).attr("name","quoteItem["+idx+"].item.itemNm");
            });
            $(".clsItemNm").last().val("");
            //수량
            $(".clsQteQty").each(function(idx){
            	$(this).attr("name","quoteItem["+idx+"].qteQty");
            });
            $(".clsQteQty").last().val("");
            //단가
            $(".clsQteUprc").each(function(idx){
            	$(this).attr("name","quoteItem["+idx+"].qteUprc");
            });
            $(".clsQteUprc").last().val("");
        });
    });
    
    // 행 삭제
    function deleteRow(button) {
        const row = button.parentNode.parentNode;

        // 첫 번째 행인지 확인
        if (!row.classList.contains('new-row-template')) {
            row.parentNode.removeChild(row);
        } else {
            // 첫 번째 행이면 행을 제거하는 대신 입력 값을 지웁니다.
            const inputs = row.querySelectorAll('input');
            inputs.forEach(input => {
                if (input.type !== 'button') {
                    input.value = '';
                }
            });
        }
    }
</script>
