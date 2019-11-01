<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/sample.css" type="text/css">
<link
	href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/compleated_ems.css" type="text/css">
<script
	src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<!-- script src="//code.jquery.com/jquery-1.11.1.min.js"></script -->
<script type="text/javascript" src="jquery/jquery-3.3.1.min.js"></script>
<title>管理者ログイン-機器管理システム</title>
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
		<h3>保守部材管理システム</h3>
		<div class="row">
			<div class="span12">
				<form class="form-horizontal" action='Login' method="POST">
					<fieldset>
						<div>
							<h4>管理者ログイン</h4>

							<c:if test="${not empty errormessage }">
								<div class="error_message">
									<div>
										<c:out value="${errormessage}" />
									</div>
								</div>
							</c:if>
							<c:if test="${not empty hoge }">
								<div class="error_message " style="width: 350px;">
									<c:out value="${hoge}" />
								</div>
							</c:if>
							<%
								Object hoge = session.getAttribute("hoge");

								if (hoge != null) {
									session.invalidate();
								}
							%>


						</div>
						<div class="control-group">
							<label class="control-label" for="account_id">ID</label>
							<div class="controls">
								<input type="text" id="username" name="account_id"
									class="input-xlarge">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="password">パスワード</label>
							<div class="controls">
								<input type="password" id="password" name="password"
									class="input-xlarge">
							</div>
						</div>
						<div class="control-group">
							<!-- Button -->
							<div class="controls">
								<button class="btn btn-success">Login</button>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>




</body>
</html>
