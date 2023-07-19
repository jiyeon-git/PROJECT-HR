<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet"> -->
    <!-- CSS -->
    <link rel="stylesheet" href="/assets/css/styles.css">
    <link rel="stylesheet" href="/assets/css/modal.css">
    <%--jquery--%>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- datepicker -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <title>요청내역</title>

</head>
<body>
  
	<script defer>
<!--
	$(document).on('blur', '.dp', function(){
		let datepicker1 = document.querySelector('#datepicker1');
		let datepicker2 = document.querySelector('#datepicker2');
		console.log(datepicker1.value);
		console.log(datepicker2.value);
		$.ajax({
			type:"post",
			data: {
				"datepicker1" : datepicker1.value,
				"datepicker2" : datepicker2.value,
			},
			url:"/searchByDateReq.do",
			dataType:"json",
			success : sucFuncJson,
			error : errFunc
		});
		function sucFuncJson(data) {
			console.log(data);
		    $('#mainTable tbody').html(htmlStr(data));
			if (data) {
				if(data.result == true){
					alert("검색 성공");
				}
			} else {
				alert("검색 실패");
			}
		}
		function errFunc(e) {	
			console.log(e)
			alert("실패" + e.status)
		}
		
	})
	-->
	$(document).on('click','.searchbtn',function(){
		let searchType = document.querySelector(".searchtype");
		let searchWord = document.querySelector(".search");
		$.ajax({
			type: "post",
			data: {
				"searchType" : searchType.value,
				"searchWord" : searchWord.value,
			},
			url: "/searchTotalReq.do",
			dataType: "json",
			success : sucFuncJson,
			error : errFunc
		})
		function sucFuncJson(data) {
			console.log(data);
		    $('#mainTable tbody').html(htmlStr(data));
			if (data) {
				if(data.result == true){
					alert("검색 성공");
				}
			} else {
				alert("검색 실패");
			}
		}
		function errFunc(e) {	
			console.log(e)
			alert("실패" + e.status)
		}
	})
	
	function htmlStr(data){

			let html='';
			data.forEach(value => {
                const schedule = moment(value.schedule, 'MMM DD, YYYY, h:mm:ss A').format('YYYY-MM-DD');
                const application_date = moment(value.application_date, 'MMM DD, YYYY, h:mm:ss A').format('YYYY-MM-DD');
               

                html += `
               <tr 
                    data-rqst-hstry-num="`+value.rqst_hstry_num+`"
                    data-emp-num="`+value.emp_num+`"
                    data-request-type="`+value.request_type+`"
                    data-dept="`+value.dept+`"
                    data-emp-name="`+value.emp_name+`"
                    data-go-work="`+goWork+`"
                    data-leave-work="`+leaveWork+`"
                    data-work-name="`+value.work_name+`"
                    data-remarks="`+value.remarks+`"
                    >

                    <th><input type='checkbox' name='chk[]'
                        onclick="isAllCheck(this.name, 'chkAll');"></th>
                    <td>`+value.emp_num+`</td>
                    <td>`+value.emp_name+`</td>
                    <td>`+goWork+`</td>
                    <td>`+leaveWork+`</td>
                    <td>`+value.work_name+`</td>
                    <td
                        style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">`+value.remarks+`</td>
                    
                </tr>
                `;
            })

            return html;
		} 
	
<%@include file="/views/include/header.jsp" %>
<section id="body-pd" class="body-pd">
    <div class="main_title">
        <h2>요청 내역</h2>
        <input type="text" id="datepicker1"> -
        <input type="text" id="datepicker2">
        <nav class="plusinfo">
            <select class="searchs searchtype">
                <option>전체</option>
                <option>부서</option>
                <option>사원번호</option>                
                <option>요청 보낸 사람</option>
                <option>요청종류</option>
                <option>상태</option>

            </select>
            <input type="text" class="searchs search">
            <input type="button" class="searchbtn" value="검 색">
        </nav>
    </div>
    <table class="table sec-table table-hover my-table" id="mainTable"
		style="table-layout: fixed;">
        <thead>
        <tr>
            <th>요청내역번호</th>
            <th>사원번호</th>
            <th>요청 종류</th>
            <th>부서</th>
            <th>요청 보낸 사람</th>
            <th>요청사항</th>
            <th>요청 사유</th>
            <th>상태</th>
            <th>승인권자 노트</th>
            <th>신청일자</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="requestList" items="${list}">
            <tr>
                <td>${requestList.rqst_hstry_num}</td>
                <td>${requestList.emp_num}</td>
                <td>
                        ${requestList.request_type == 'A' ? '출퇴근 요청' :
                        requestList.request_type == 'W' ? '근무일정 요청' :
                        requestList.request_type == 'V' ? '휴가 요청' :''}
                </td>
                <td>${requestList.dept}</td>
                <td>${requestList.emp_name}</td>
                <td>
                    <c:if test="${requestList.request_type == 'V'}">
                        <fmt:formatDate value="${requestList.start_date}" pattern="yy-MM-dd"/>&nbsp;~&nbsp;<fmt:formatDate
                            value="${requestList.end_date}"
                            pattern="yy-MM-dd"/>/${requestList.special_note!=null?requestList.special_note:""}
                    </c:if>
                    <c:if test="${requestList.request_type != 'V'}">
                        <fmt:formatDate value="${requestList.start_date}" pattern="yy-MM-dd HH:mm"/>&nbsp;~&nbsp;<fmt:formatDate
                            value="${requestList.end_date}"
                            pattern="yy-MM-dd HH:mm"/>${requestList.special_note!=null?"/"+requestList.special_note:""}
                    </c:if>

                </td>
                <td>${requestList.request_reason}</td>
                <td>${requestList.state == 0 ? '대기' : (requestList.state == 1 ? '승인' : (requestList.state == 2 ? '거절' : (requestList.state == 3 ? '취소' : '알 수 없음')))}</td>
                <td>${requestList.approver_note}</td>
                <td>${requestList.application_date}</td>
                <td>
                    <c:if test="${requestList.state == 0}">
                        <button type="button" onclick="approvalBtn(this, true)" data-rqst-num="${requestList.rqst_hstry_num}" class="approve">승인</button>
                        &nbsp;
                        <button type="button" onclick="approvalBtn(this, false)" data-rqst-num="${requestList.rqst_hstry_num}" class="reject">거절</button>
                    </c:if>

                </td>
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

<script src="/assets/js/main.js"></script>
<script type="text/javascript">
	updateRowsPerPage(18);
	
function approvalBtn(btn,approval){
    const rqstNum = $(btn).data("rqst-num");
    const remarks = prompt(approval?"승인 사유를 적어주세요":"거절 사유를 적어주세요")
    if(remarks == null) return
    $.ajax({
        url : "/approvalok.do?approval="+approval,
        type : "get",
        data : {"rqstNum":rqstNum, "remarks":remarks},
        dataType : "json",
        success : sucFuncJson,
        error : errFunc
    });

    function sucFuncJson(){
        alert("승인되었습니다.");
        window.location.reload();
    }
    function errFunc(error){
        console.log(error)
    }
}

</script>
<!-- js -->
<script type="text/javascript" src="/assets/js/modal.js"></script>
</body>
</html>