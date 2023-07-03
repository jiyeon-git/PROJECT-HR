<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <link rel="stylesheet" href="/assets/css/view_jy.css">
  
  <title>근로정보</title>
</head>
<body id="body-pd">


<div class="main">

  <div class="main_title">
    <h2>조직 관리</h2>
    <button><a href="/views/admin/group/groupModal.jsp">조직 추가하기</a></button>
  </div>

  <table class="table table-hover">
    <thead>
    <tr>
      <th></th>
      <th><input type="text" placeholder="검색.."></th>
      <th><input type="text" placeholder="검색.."></th>

    </tr>
    <tr>
      <th style="width:30px"><input type='checkbox' id="chkAll" onclick="allCheckboxes('chk[]', this.checked)"></th>
      <th>조직명</th>
      <th>메모</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th><input type='checkbox' name = 'chk[]' onclick="isAllCheck(this.name, 'chkAll');"></th>
      <td>인사</td>
      <td></td>

    </tr>
    <tr>
      <th><input type='checkbox' name = 'chk[]' onclick="isAllCheck(this.name, 'chkAll');"></th>
      <td>개발</td>
      <td></td>

    </tr>
    </tbody>
  </table>
</div>
<script src="/assets/js/selectAll.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" />
</body>
</html>