<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/ems.js"></script>
<link rel="stylesheet" href="bootstrap/css/bootstrap.css"
	type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link
	href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/compleated_ems.css" type="text/css">

<title>貸出詳細-機器管理システム</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/i18n/jquery-ui-i18n.min.js"></script>
<link rel="stylesheet"
	href="jquery-ui-1.12.1.custom/jquery-ui.css">
<script>
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional["ja"]);
		$('.calendar').datepicker({

			changeYear : true, //表示年の指定が可能
			changeMonth : true, //表示月の指定が可能
			dateFormat : 'yy-mm-dd' //年-月-日(曜日)

		});
	});
</script>
<link rel="stylesheet" href="jquiery-ui-1.12.1.custom" type="text/css">

</head>
<body>
	<table border=1 cols="80">
		<tr>
			<td colspan=2 nowrap><b>セッションのオブジェクト一覧</b></td>
		</tr>
		<tr>
			<td><b>name</b></td>
			<td><b>中身</b></td>
		</tr>
		<%
			for (java.util.Enumeration ite = session.getAttributeNames(); ite.hasMoreElements();) {
				String name = (String) ite.nextElement();
		%>
		<tr>
			<td><%=name%></td>
			<td><%=session.getAttribute(name)%></td>
		</tr>
		<%
			}
		%>
	</table>
	<div class="container">
	<div class="row">
		<jsp:include page="include/header.jsp" />
		</div>
		<c:if test="${login_user != NULL}">
			管理者ログインチュッ
		</c:if>
		<c:if test="${error_message != NULL}">
			<c:forEach var="error_message" items="${error_message}">
				<div class="alert alert-danger" role="alert">
					<strong><c:out value="${error_message}" /></strong>
				</div>
			</c:forEach>
		</c:if>
		<%
			session.setAttribute("error_message", "");
		%>
		<div class="span12">
			<form class="form-horizontal" action='Detail' method="POST"
				name="borrow">
				<fieldset>
					<div id="legend">
						<legend>貸出詳細</legend>
					</div>

					<table class="table table-striped">
						<tr>
							<th>シリアルNo</th>
							<td>${param['serial_no']}</td>
						</tr>
						<tr>
							<th>カテゴリー</th>
							<td>${param['category_name']}</td>
						</tr>
						<tr>
							<th>メーカー</th>
							<td>${param['manufacturer']}</td>
						</tr>
						<tr>
							<th>機種名</th>
							<td>${param['name']}</td>
						</tr>
						<tr>
							<th>ステータス</th>
							<td><c:choose>
									<c:when test="${param['status'] == 0}">貸出可</c:when>
									<c:when test="${param['status'] == 1}">承認待ち</c:when>
									<c:when test="${param['status'] == 2}">貸出中</c:when>
								</c:choose></td>
						</tr>
						<tr>
							<th>備考</th>
							<td>${param['remarks']}</td>
						</tr>

					</table>

					<input type="hidden" name="serial_no" value="${param['serial_no']}" />
					<input type="hidden" name="category"
						value="${param['category_name']}" /> <input type="hidden"
						name="manufacturer" value="${param['manufacturer']}" /> <input
						type="hidden" name="name" value="${param['name']}" /> <input
						type="hidden" name="status" value="${param['status']}" /> <input
						type="hidden" name="remarks" value="${param['remarks']}" />

					<hr>

					<!-- div class="row top_7px bottom_10px">
						<label class="text_color_red">※すべての項目を入力してください。</label>
						</div -->

					<div class="row pad_5px">
						<div class="col-sm-2" align="right">
							<label class="input_form_label">使用目的</label>
						</div>
						<div class="col-sm-10">
							<input type="text" name="intended_use" maxlength="20"
								style="height: 26px" required>
						</div>
					</div>

					<div class="row pad_5px">
						<div class="col-sm-2 top_7px" align="right">
							<label class="input_form_label">利用形態</label>
						</div>
						<div class="col-sm-2">
							<div class="radio">
								<input type="radio" name="use_form" value="1" id="inq1"
									onclick="radioCheck(1);" checked> <label for="inq1">一時利用</label>
								<input type="radio" name="use_form" value="2" id="inq2"
									onclick="radioCheck(2);"> <label for="inq2">恒久利用</label>
							</div>
						</div>
					</div>

					<div class="row pad_5px">
						<div class="col-sm-2 top_7px" align="right">
							<label class="input_form_label">使用開始予定日</label>
						</div>
						<div class="col-sm-10 top_7px">
							<input class="calendar" type="text" name="start_date"
								style="height: 26px;" max="9999-12-31" required>
						</div>
					</div>
					<div class="row pad_5px" id="return">
						<div class="col-sm-2 top_7px" align="right">
							<label class="input_form_label">返却予定日</label>
						</div>
						<div class="col-sm-10 top_7px">
							<input class="calendar" id="target" type="text"
								name="return_date" style="height: 26px;" max="9999-12-31"
								value="" required>
						</div>
					</div>
					<hr>
					<div class="row">
						<div class="form-button">
							<button type="submit" class="button02" value="application"
								name="service">確定</button>
							<button type="button" class="button_back"
								onclick="history.back()">戻る</button>
						</div>
					</div>
					<hr>
				</fieldset>
			</form>
		</div>
	</div>

</body>
</html>
