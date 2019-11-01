<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登録内容確認-機器管理システム</title>
<link
	href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css"
	type="text/css">
<link rel="stylesheet" href="css/compleated_ems.css" type="text/css">
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
		<jsp:include page="include/header.jsp" />
		<div id="legend">
		<c:if test="${login_user != NULL}">
			管理者ログインチュッ
		</c:if>
			<legend>登録内容確認</legend>
		</div>
		<div style="margin-left: 20px;">
			<p>
				以下の内容で登録します。<br> 内容を確認し、登録ボタンを押してください。
			</p>

			<div style="margin-top: 10px;">
				<table class="table table-striped table-condensed"
					style="margin-bottom: 0px;">
					<c:forEach var="equipo" items="${requestScope['equipo'] }">
						<tr>
							<th>シリアルNo.</th>
							<td><c:out value="${equipo.serial_no}" /></td>
						</tr>
						<tr>
							<th>カテゴリ</th>
							<td><c:out value="${equipo.category_name}" /></td>
						</tr>
						<tr>
							<th>メーカー</th>
							<td>${param['manufacturer']}</td>
						</tr>
						<tr>
							<th>機種名</th>
							<td><c:out value="${equipo.name}" /></td>
						</tr>
						<tr>
							<th>購入日</th>
							<td>${param['purchase_date']}</td>
						</tr>
						<tr>
							<th>スペック</th>
							<td>${param['spec']}</td>
						</tr>
						<tr>
							<th>備考</th>
							<td>${param['remarks']}</td>
						</tr>
					</c:forEach>
				</table>
				<hr class="hr_table">
			</div>

		</div>
		<br>


		<form method="POST" action="resi_Servlet">
			<c:forEach var="equipo" items="${requestScope['equipo'] }">
				<input type="hidden" name="serial_no" value="${equipo.serial_no}">
				<input type="hidden" name="category_name"
					value="${equipo.category_name}">
				<input type="hidden" name="manufacturer"
					value="${param['manufacturer']}">
				<input type="hidden" name="name" value="${equipo.name}">
				<input type="hidden" name="purchase_date"
					value="${param['purchase_date']}">
				<input type="hidden" name="spec" value="${param['spec']}">
				<input type="hidden" name="remarks" value="${param['remarks']}">
				<div class="form-button">
					<button class="button02" type="submit" name="service"
						value="resist">登録</button>
					<button class="button_back" type="button" onClick="history.back()">キャンセル</button>
				</div>
			</c:forEach>
		</form>

	</div>
</body>
</html>