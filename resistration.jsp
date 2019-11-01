<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新規登録-機器管理システム</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/ems.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>

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
		<c:if test="${login_user != NULL}">
			管理者ログインチュッ
		</c:if>
		<div class="form-horizontal">
			<div id="legend">
				<legend>新規登録</legend>
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
			<c:if test="${error_message != NULL}">
				<c:forEach var="error_message" items="${error_message}">
					<div class="alert alert-danger" role="alert">
						<strong><c:out value="${error_message}" /></strong>
					</div>
				</c:forEach>
			</c:if>
			<%
				session.setAttribute("result", "init");
				session.setAttribute("error_message", "");
				session.removeAttribute("error_message");
			%>
			<jsp:include page="include/search.jsp" />
			<br>
			<p style="margin-left: 15px;">登録したい機器の詳細を以下に入力してください。
				「*」がついている項目は入力必須です。</p>
			<fieldset>
				<form method="POST" action="resi_Servlet">
					<div class="form-group">
						<label class="col-xs-2 control-label">シリアルNo. *</label>
						<div class="col-xs-6">
							<input type="textarea" class="form-control" maxlength="20"
								name="serial_no" value="<c:out value="${addto.serial_no}"/>" placeholder="Serianl No." required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">カテゴリー *</label>
						<div class="col-xs-6">
							<input type="textarea" class="form-control"
								name="category_name" maxlength="20"
								value="<c:out value="${addto.category_name}"/>"
								placeholder="例) サーバー" required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">メーカー *</label>
						<div class="col-xs-6">
							<input type="textarea" maxlength='20' class="form-control"
								name="manufacturer"
								value="<c:out value="${addto.manufacturer}"/>"
								placeholder="例) Fujitsu" required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">機種名 *</label>
						<div class="col-xs-6">
							<input type="textarea" maxlength='20' class="form-control"
								name="name" value="<c:out value="${addto.name}"/>"
								placeholder="例) F-Server1" required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">購入日 *</label>
						<div class="col-xs-6">
							<input class="calendar" type="text" name="purchase_date" class="form-control" style="padding-top: 15px; padding-bottom: 15px;"
								 max="9999-12-31" required>
						</div>
					</div>

					<div class="form-group">
						<label class="col-xs-2 control-label" for="InputTextarea">スペック
							*</label>
						<div class="col-xs-6">
							<textarea class="form-control textarea" maxlength='300' rows="5"
								name="spec"
								placeholder="例) CPU:Intel , Core i3-7100 , メモリ:512GB" required><c:out
									value="${addto.spec}" /></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label" for="InputTextarea">備考</label>
						<div class="col-xs-6">
							<textarea class="form-control textarea" maxlength='500' rows="2"
								name="remarks" placeholder="※任意項目"></textarea>
						</div>
					</div>
					<div class="form-button">
						<button class="button02" type="submit" name="service"
							value="check">確認画面へ</button>
						<button class="button_back" type="button"
							onclick="location.href='http://localhost:8080/EMS/Search'">検索画面へ</button>
					</div>
				</form>
			</fieldset>
		</div>
	</div>
	<%--
	<script>
		$(function() {
			$('.alert').fadeIn('show');
			setTimeout(function() {
				$('.alert').fadeOut('show');
			}, 1500);
		});
	</script>
--%>
</body>
</html>