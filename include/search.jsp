<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新規登録-機器管理システム</title>
<link
	href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css"
	type="text/css">
<link rel="stylesheet" href="css/compleated_ems.css" type="text/css">

</head>
<body>
	<div class="container">
		<form method="POST" action="resi_Servlet">
			<div class="container-fluid div_search text-nowrap">
				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right" style="padding-top: 5px; padding-bottom: 5px;">カテゴリー</div>
					</div>
					<div class="col-sm-4">
						: <select name="category_name">
							<option value="">---</option>
							<c:forEach var="category_name"
								items="${requestScope['category_name']}">
								<option value="${category_name}"><c:out
										value="${category_name}"></c:out></option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row padding_width">
					<div class="col-sm-2 hoge">
						<div align="right" style="padding-top: 5px; padding-bottom: 5px;">メーカー</div>
					</div>
					<div class="col-sm-4">
						: <select name="manufacturer">
							<option value="">---</option>
							<c:forEach var="manufacturer"
								items="${requestScope['manufacturer']}">
								<option value="${manufacturer}"><c:out
										value="${manufacturer}"></c:out></option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row padding_width">
					<div class="col-sm-2 hoge">
						<div align="right" style="padding-top: 5px; padding-bottom: 5px;">機種名</div>
					</div>
					<div class="col-sm-4">
						: <select name="name">
							<option value="">---</option>
							<c:forEach var="name" items="${requestScope['name']}">
								<option value="${name}"><c:out value="${name}"></c:out></option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-button">
					<button class="button02" type="submit" name="service"
						value="search">検索</button>
				</div>
			</div>
			<br>
			<table class="table table-bordered table-condensed table-hover">
				<thead>
					<tr>
						<th bgcolor="#f5f5f5">カテゴリー</th>
						<th bgcolor="#f5f5f5">メーカー</th>
						<th bgcolor="#f5f5f5">機種名</th>
						<th bgcolor="#f5f5f5">操作</th>
					</tr>
				</thead>
				<c:forEach var="search" items="${requestScope['search']}">
					<tbody>
						<tr>
							<td><c:out value="${search.category_name}"></c:out></td>
							<td><c:out value="${search.manufacturer}"></c:out></td>
							<td><c:out value="${search.name}"></c:out></td>
							<td><button type="submit" name="service" value="add">追加</button></td>
						</tr>
					</tbody>
					<input type="hidden" name="heyhey" value="${search.name}">
				</c:forEach>
			</table>
		</form>
	</div>
</body>
</html>