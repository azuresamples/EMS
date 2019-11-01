<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC>
<html>
<head>
<script type="text/javascript" src="js/ems.js"></script>
<link rel="stylesheet" href="bootstrap/css/bootstrap.css"
	type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/ems.js"></script>
<script
	src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!--
<script type="text/javascript" src="jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="jquery/jquery-3.3.1.min.js"></script>
 -->
<link rel="stylesheet" href="css/compleated_ems.css" type="text/css">
<title>機器詳細-機器管理システム</title>
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
		<div class="span12">
			<form class="form-horizontal" action='Detail' method="POST">
				<fieldset>
					<div id="legend">
						<legend>機器詳細</legend>
					</div>
					<c:choose>
						<c:when test="${result == 'success'}">
							<div class="alert alert-success" role="alert">
								<strong><c:out value="${action}" /> が完了しました。</strong>
							</div>
						</c:when>
						<c:when test="${result == 'false'}">
							<div class="alert alert-danger" role="alert">
								<strong><c:out value="${action}" /> が失敗しました。</strong>
							</div>
						</c:when>
					</c:choose>
					<table class="table table-striped">
						<tr>
							<th>シリアルNo</th>
							<td>${equipment_list.serial_no}</td>
						</tr>
						<tr>
							<th>カテゴリー</th>
							<td>${equipment_list.category_name}</td>
						</tr>
						<tr>
							<th>メーカー</th>
							<td>${equipment_list.manufacturer}</td>
						</tr>
						<tr>
							<th>機種名</th>
							<td>${equipment_list.name}</td>
						</tr>
						<tr>
							<th>ステータス</th>
							<td><c:choose>
									<c:when test="${equipment_list.status == 0}">貸出可</c:when>
									<c:when test="${equipment_list.status == 1}">承認待ち</c:when>
									<c:when test="${equipment_list.status == 2}">貸出中</c:when>
								</c:choose></td>
						</tr>
						<c:if test="${equipment_list.user !=null }">
							<tr>
								<th>利用者</th>
								<td>${equipment_list.user}</td>
							</tr>
							<tr>
								<th>使用開始予定日</th>
								<td>${equipment_list.start_date}</td>
							</tr>
							<tr>
								<th>返却予定日</th>
								<td>${equipment_list.return_date}</td>
							</tr>
							<tr>
								<th>使用目的</th>
								<td>${equipment_list.intended_use}</td>
							</tr>
							<tr>
								<th>利用形態</th>
								<td><c:choose>
										<c:when test="${equipment_list.use_form == 1}">一時利用</c:when>
										<c:when test="${equipment_list.use_form == 2}">恒久利用</c:when>
									</c:choose></td>
							</tr>
						</c:if>

						<tr>
							<th>備考</th>
							<td>${equipment_list.remarks}</td>
						</tr>

					</table>
					<input type="hidden" name="serial_no"
						value="${equipment_list.serial_no}" /> <input type="hidden"
						name="category_name" value="${equipment_list.category_name}" /> <input
						type="hidden" name="manufacturer"
						value="${equipment_list.manufacturer}" /> <input type="hidden"
						name="name" value="${equipment_list.name}" /> <input
						type="hidden" name="status" value="${equipment_list.status}" /> <input
						type="hidden" name="remarks" value="${equipment_list.remarks}" />
					<hr>
					<div class="row ">
						<div class="form-button">
							<c:if test="${result == 'init'}">
								<c:if test="${equipment_list.status == 0}">
									<!-- 貸出可の場合表示 -->
									<button type="submit" class="button02">貸し出す</button>
								</c:if>
								<c:if
									test="${equipment_list.user_id == login_user.account_id && equipment_list.status == 2}">
									<!-- 借りているのがログインユーザで貸出中の場合表示 -->
									<button type="submit" class="button02" name="service"
										value="ret" onclick="return ExecutionCheck();">返却</button>
								</c:if>
								<c:if
									test="${equipment_list.status == 1 && login_user.authority == 1}">
									<!-- 承認待ちでログインユーザが管理者の場合表示 -->
									<button type="submit" class="button02" name="service"
										value="approval" onclick="return ExecutionCheck();">承認</button>
									<button type="submit" class="button02" name="service"
										value="denial" onclick="return ExecutionCheck();">否認</button>
								</c:if>
								<c:if
									test="${equipment_list.status == 0 && login_user.authority == 1}">
									<!-- 貸出可でログインユーザが管理者の場合表示 -->
									<button type="submit" class="button02" name="service"
										value="delete" onclick="return ExecutionCheck();">削除</button>
								</c:if>
							</c:if>

							<button class="button_back" type="button"
								onclick="location.href='http://localhost:8080/EMS/Search'">検索画面へ</button>

						</div>
					</div>
					<hr>
				</fieldset>
			</form>
		</div>
	</div>
	</div>
</body>
</html>
