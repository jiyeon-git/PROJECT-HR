<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<!-- <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet"> -->
<!-- CSS -->

<%--jquery--%>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<!-- fullcalendar 언어 CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<link rel="stylesheet" href="/assets/css/styles.css">
<link rel="stylesheet" href="/assets/css/modal.css">
<!-- datepicker -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
body{
	padding: 0px;
}
.vacation-table {
	margin: 0px auto;
	padding: 8px 0;
	width: 100%;
}
.vacation-table tr {
	margin: 5px;
}
.vacation-table tr td {
	padding: 7px;
	font-size: 15px;
}
.selectBox {
	width: 100px;
    height: 30px;
    border: 1px solid black;
}
.vacation-type {
	width: 150px;
    height: 30px;
    border: 1px solid black;
}
.vacation-date{
	width: 200px;
    height: 30px;
    border: 1px solid black;
}
.vacation-area {
	border: 1px solid black;
	width: 250px;
 	resize: none; 
}



</style>
<title>휴가관리</title>
<style type="text/css">
	
</style>
</head>
<body>
	<%@include file="/views/include/header.jsp"%>

	<section id="body-pd" class="body-pd">

		<div class="main_title">
			<h2>휴가</h2>
			<input type="text" id="datepicker1"> -
       	 	<input type="text" id="datepicker2">
			<nav class="plusinfo">
			<select class="searchtype searchs">
				<option>전체</option>
				<option>사원번호</option>
				<option>직원</option>
				<option>휴가시간</option>
				<option>휴가유형</option>
				<option>유급시간</option>
				<option>차감일수</option>
				<option>사유</option>
			</select>
			<input type="text" class="search searchs">
			<input type="button" class="searchbtn" value="검 색">
			<input type="checkbox" id="popup" onclick="resetForm()"><label class="labelBtn" for="popup">+
				휴가 관리하기</label>
			<div class="modal" style="display: hidden;">
				<div class="modal-content">
					<label for="popup">x</label>
					<h1>휴가관리하기</h1>
					<hr>

					<form method="post" action="/vacationok.do" id="frm">
						<table class="vacation-table">
							<tr class="vacation-tr1">
							<th>직원명</th>
							<td><select class="vacation-type" id="selectBox" name="emp_num">
    						 <c:forEach var="emplist" items="${empList}">
         						<option value="${emplist.emp_num}">${emplist.emp_name}</option>
     						</c:forEach>
							</select></td>
							</tr>
								<tr>
									<th>휴가 시작일</th>
									<td><input type="datetime-local" class="vacation-date" name="vctn_start_date">
								</tr>
								<tr>
									<th>휴가 종료일</th>
									<td><input type="datetime-local" class="vacation-date" name="vctn_end_date">
								</tr>
								<!-- 달력 템플릿						
							<tr>
								<td colspan="2">
									calendar 태그
									<div id='calendar-container'>
										<div id='calendar'></div>
									</div>
								</td>
							</tr> 
							-->
							<tr>
							<th>휴가 유형</th>
							<td><select class="vacation-type" id="selectBox" name="vctn_type_num">
     						<c:forEach var="vctnlist" items="${vctnTypeList}">
         						<option value="${vctnlist.vctn_type_num}">${vctnlist.vctn_name}(${vctnlist.vctn_time}h, ${vctnlist.deduction_day}일)</option>
     						</c:forEach>
							</select></td>
							</tr> 
							<tr>
								<th>사유</th>
								<td><textarea name="vctn_reason" class="vacation-area" cols="70" rows="4"></textarea></td>
							</tr>
							<tr hidden>
								<th>승인여부</th>
								<td><input type="number" name="vctn_approval" value="1"></td>
							</tr>
						</table>
					</form>

					<hr>
					<div class="bottom-btn">
						<div class="right-btn">
							<button class="custom-btn btn-10" form="frm">추가하기</button>
							<button type="button" class="btn_close custom-btn btn-10" onclick="btnClose();">닫기</button>
						</div>
					</div>
				</div>
				<label for="popup"></label>
			</div>
		</div>
</nav>

		<table class="table sec-table table-hover my-table">
			<colgroup>
				<col class="">
			</colgroup>
			<thead>
				<tr>
					<th style="width: 30px"><input type='checkbox' id="chkAll"
						onclick="allCheckboxes('chk[]', this.checked)"></th>
					<th>사원번호</th>
					<th>직원</th>
					<th>휴가시간</th>
					<th>휴가 유형</th>
					<th>유급 시간</th>
					<th>차감일수</th>
					<th>사유</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="vacationList" items="${list}">
				<tr
					data-vctn-num="${vacationList.vctn_num}"
					data-emp-num="${vacationList.emp_num}"
					data-emp-name="${vacationList.emp_name}"
					data-startdate="${vacationList.startdate}"
					data-enddate="${vacationList.enddate}"
					data-vctn-type-num="${vacationList.vctn_type_num}"
					data-vctn-name="${vacationList.vctn_name}"
					data-vctn-time="${vacationList.vctn_time}"
					data-deduction-day="${vacationList.deduction_day}"
					data-vctn-reason="${vacationList.vctn_reason}"
					data-countday="${vacationList.countday}"
					>
				
					<th><input type='checkbox' name='chk[]'
							onclick="isAllCheck(this.name, 'chkAll');"></th>
					<td>${vacationList.emp_num}</td>
					<td>${vacationList.emp_name}</td>
					<td>${vacationList.startdate} ~ ${vacationList.enddate}</td>
					<td>${vacationList.vctn_name}</td>
					<td>
					<c:choose>
						<c:when test="${vacationList.countday > 0 }">
							${ vacationList.vctn_time * (vacationList.countday+1) }					
						</c:when>
						<c:otherwise> 
							${vacationList.vctn_time}
						</c:otherwise>
					</c:choose>
					</td>
					<td>
					<c:choose>
						<c:when test="${vacationList.countday > 0 }">
							${ vacationList.deduction_day * (vacationList.countday+1) }					
						</c:when>
						<c:otherwise>
							${vacationList.deduction_day}
						</c:otherwise>
					</c:choose>
					</td>
					<td>${vacationList.vctn_reason}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="pagination">
			<i class='bx bxs-chevron-left'></i>
			<ol id="pagingNumbers">
			</ol>
			<i class='bx bxs-chevron-right'></i>		
		</div>
	</section>
<dialog>
    
    				<h1>휴가 수정하기</h1>
					<hr>
					

					<form method="get" id="frm2">
						<table class="vacation-table">

						</table>
						<div class="bottom-btn">
						<div class="right-btn">
							<button type="submit" id="updateBtn" class="custom-btn btn-10">수정하기</button>
							<button type="button" id="deleteBtn" class="custom-btn btn-10">삭제하기</button>
            				<button  class="dialogbtn custom-btn btn-10" type="button"  onclick="dialogClose();">닫기</button>
						</div>
					</div>
					</form>
    </dialog>
<script src="/assets/js/main.js"></script>
<script type="text/javascript">
	updateRowsPerPage(18);
	
const dialog = document.querySelector("dialog");
$(document).on("click", ".table tbody tr", function () {
	dialog.showModal();
	console.log(this);
});

function dialogClose(){
	dialog.close();
}

$(document).on("click", ".table tbody tr", function () {
 	$vctnNum = $(this).data("vctn-num")
 	$EmpNum = $(this).data("emp-num")
 	$EmpName = $(this).data("emp-name")
 	$startDate = $(this).data("startdate")
 	$endDate = $(this).data("enddate")
 	$vctnReason = $(this).data("vctn-reason")
	$vcnTypeNum = $(this).data("vctn-type-num")

	let str = `
	<tr hidden>
		<td>휴가일렬번호</td>
		<td><input type="text" name="vctn_num" value="`+$vctnNum+`"></td>
	</tr> 	
	<tr>
    <th>직원명</th>
    	<td>`+$EmpName+`</td>
 	</tr> 
 	<tr>
	<th>휴가 유형</th>
	<td><select class="vacation-type" id="selectBox" name="vctn_type_num">
     <c:forEach var="vctnlist" items="${vctnTypeList}">
         <option value="${vctnlist.vctn_type_num}">${vctnlist.vctn_name}(${vctnlist.vctn_time}h, ${vctnlist.deduction_day}일)</option>
     </c:forEach>
	</select></td>
	</tr> 

	<tr>
		<th>휴가 시작일</th>
		<td><input type="datetime-local" class="vacation-date" name="vctn_start_date" value="`+$startDate+`">
	</tr>
	<tr>
		<th>휴가 종료일</th>
		<td><input type="datetime-local" class="vacation-date" name="vctn_end_date" value="`+$endDate+`">
	</tr>
	<tr>
		<th>사유</th>
		<td><textarea class="vacation-area" name="vctn_reason" cols="30" rows="4">`+$vctnReason+`</textarea></td>
	</tr>
	<tr hidden>
		<th>승인상태</th>
		<td><input type="text" name="vctn_approval" value="1" readonly></td>
	<tr>
		`;

	$('dialog table').html(str)
	$("select[name='vctn_type_num']").val($vcnTypeNum).prop("selected", true);
}) 


function resetForm() {
	  $('#frm')[0].reset();
}

const $form = $('#frm2');
$(document).on('click','#updateBtn',function (){
   $form.attr('action','/vacationUpdate.do')
   $form.attr('method','post')
   $form.submit()
})
$(document).on('click','#deleteBtn',function (){
   $form.attr('action','/vacationDelete.do')
   $form.attr('method','post')
   $form.submit()
})

</script>
<!-- js -->
<script type="text/javascript" src="/assets/js/modal.js"></script>
</body>
</html>