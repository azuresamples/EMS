<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="js/ems.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css"
	type="text/css">
<link rel="stylesheet" href="css/compleated_ems.css" type="text/css">
<style type="text/css">
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/i18n/jquery-ui-i18n.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>

<!--
<script type="text/javascript" src="jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="jquery/jquery-3.3.1.min.js"></script>
-->
<link rel="stylesheet" href="jquery-ui-1.12.1.custom/jquery-ui.css">
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


<title>検索-機器管理システム</title>
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

		<div class="row">
			<form method="POST" action="Login">
				<div class="form-button">
					<button type="submit">管理者用ログイン</button>
				</div>
			</form>
		</div>
	</div>
	<c:if test="${login_user != NULL}">
			管理者ログインチュッ
		</c:if>
		<c:choose>
			<c:when test="${result == 'success' && action == '削除'}">
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
		%>

		<form method="POST" action="Search">
			<div class="container-fluid div_search text-nowrap">
				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right" style="margin-top: 7px">シリアルナンバー</div>
					</div>
					<div class="col-sm-4">
						<input type="text" name="serial_no" value="${serial_no}" size="35"
							maxlength="50" class="form-control" />
					</div>
				</div>
				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right" style="margin-top: 7px">カテゴリー</div>
					</div>
					<div class="col-sm-4">
						<select class="form-control" name="category_name">
							<option value="">--------------</option>
							<c:forEach var="cl" items="${requestScope['category_list'] }">
								<option value="${cl}"
									<c:if test="${category_name == cl}">selected</c:if>>
									<c:out value="${cl}" /></option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right" style="margin-top: 7px">メーカー</div>
					</div>
					<div class="col-sm-4">
						<input type="text" name="manufacturer" value="${manufacturer}"
							size="35" maxlength="50" class="form-control" />
					</div>
				</div>
				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right" style="margin-top: 7px">機種名</div>
					</div>
					<div class="col-sm-4">
						<input type="text" name="name" value="${name}" size="35"
							maxlength="50" class="form-control" />
					</div>

				</div>
				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right">ステータス</div>
					</div>
					<div class="col-sm-4">
						<select class="form-control" name="status">
							<option value="3" <c:if test="${status == 3}">selected</c:if>>--------------</option>
							<option value="0" <c:if test="${status == 0}">selected</c:if>>貸出可</option>
							<option value="2" <c:if test="${status == 2}">selected</c:if>>貸出中</option>
							<option value="1" <c:if test="${status == 1}">selected</c:if>>承認待ち</option>
						</select>
					</div>
					<div class="col-sm-4 form-button">
						<div>機器の新規登録はこちらから</div>
					</div>
				</div>
				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right" style="margin-top: 7px">利用者</div>
					</div>
					<div class="col-sm-4">
						<input type="text" name="user" size="35" value="${user}"
							maxlength="50" class="form-control" />
					</div>
					<div class="col-sm-4">
						<button class="new-button form-button" type="button"
							onclick="location.href='http://localhost:8080/EMS/resi_Servlet'">新規登録</button>
					</div>
				</div>

				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right" style="margin-top: 7px">使用開始日</div>
					</div>
					<div class="col-sm-4">
						<input class=" calendar form-control" name="start_date"
							type="text" value="${start_date}">
					</div>

				</div>



				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right" style="margin-top: 7px">返却予定日</div>
					</div>
					<div class="col-sm-4">
						<input class="calendar form-control" name="return_date"
							type="text" value="${return_date}">
					</div>

				</div>
				<div class="row padding_width">
					<div class="col-sm-2">
						<div align="right">利用形態</div>
					</div>
					<div class="col-sm-1" style="padding-left: 25px;">
						<label><input type="radio" name="use_form" value="0"
							<c:if test="${use_form == 0}">checked="checked"</c:if> />指定なし </label>
					</div>
					<div class="col-sm-1" style="padding-left: 40px;">
						<label><input type="radio" name="use_form" value="1"
							<c:if test="${use_form == 1}">checked="checked"</c:if> />一時利用 </label>
					</div>
					<div class="col-sm-1" style="padding-left: 55px;">
						<label><input type="radio" name="use_form" value="2"
							<c:if test="${use_form == 2}">checked="checked"</c:if> />恒久利用</label>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-4">
						<button class="button02 form-button" type="submit" name="service"
							value="search">検索</button>
					</div>
					<div class="col-sm-4">
						<input type="hidden" value="<c:out value="${csv_data}"/>" id="csv" />
						<p>
							<a class="a" href=# id="download-link" onclick="csvDownload();">CSV出力</a>
						</p>
					</div>
				</div>
			</div>
		</form>
		<br>


		<table class="table table-bordered table-condensed table-hover">

			<thead>
				<tr>
					<th bgcolor="#f5f5f5">シリアルナンバー</th>
					<th bgcolor="#f5f5f5">カテゴリー</th>
					<th bgcolor="#f5f5f5">メーカー</th>
					<th bgcolor="#f5f5f5">機種名</th>
					<th bgcolor="#f5f5f5">ステータス</th>
					<th bgcolor="#f5f5f5">利用者</th>
					<th bgcolor="#f5f5f5">使用開始日</th>
					<th bgcolor="#f5f5f5">返却予定日</th>
					<th bgcolor="#f5f5f5">利用形態</th>
				</tr>
			</thead>

			<c:forEach var="el" items="${requestScope['equipment_list'] }">
				<tr>

					<td><c:out value="${el.serial_no}" /></td>
					<td><c:out value="${el.category_name}" /></td>
					<td><c:out value="${el.manufacturer}" /></td>

					<td><form method="get" action="Detail" name="detail">
							<input type="hidden" name="serial_no" value="${el.serial_no}">
							<input class="link_button" type="submit"
								value="<c:out value="${el.name}" />">
						</form></td>
					<td><c:choose>
							<c:when test="${el.status == 0}">貸出可</c:when>
							<c:when test="${el.status == 1}">承認待ち</c:when>
							<c:otherwise>貸出中</c:otherwise>
						</c:choose></td>
					<td><c:out value="${el.user}" /></td>
					<td><c:out value="${el.start_date}" /></td>
					<td><c:out value="${el.return_date}" /></td>
					<td><c:choose>
							<c:when test="${el.use_form ==1}">一時利用</c:when>
							<c:when test="${el.use_form ==2}">恒久利用</c:when>
							<c:otherwise>
								&emsp;
							</c:otherwise>
						</c:choose></td>
				</tr>
			</c:forEach>

		</table>

		<nav>
			<ul class="pagination">


				<c:if test="${now_page > 1}">

					<c:if test="${checker == null}">
						<li><a href="Search?page=${now_page -1}"> <span>«</span>
						</a></li>
					</c:if>
					<c:if test="${checker != null}">
						<li><a
							href="Search?page=${now_page -1}&
					checker=${checker}&
					serial_no=${serial_no}&
					category_name=${category_name}&
					manufacturer=${manufacturer}&
					name=${name}&
					status=${status}&
					user=${user}&
					start_date=${start_date}&
					return_date=${return_date}&
					use_form=${use_form}">
								<span>«</span>
						</a></li>
					</c:if>
				</c:if>
				<c:choose>
					<c:when test="${now_page > 3  && now_page < page_number -2 }">
						<c:forEach var="cnt" begin="${now_page - 2}" end="${now_page + 2}">
							<li <c:if test="${now_page == cnt}">class="active"</c:if>><c:if
									test="${checker == null}">
									<a href="Search?page=${cnt}"> <c:out value="${cnt}" /></a>
								</c:if> <c:if test="${checker != null}">
									<a
										href="Search?page=${cnt}&
					checker=${checker}&
					serial_no=${serial_no}&
					category_name=${category_name}&
					manufacturer=${manufacturer}&
					name=${name}&
					status=${status}&
					user=${user}&
					start_date=${start_date}&
					return_date=${return_date}&
					use_form=${use_form}">
										<c:out value="${cnt}" />
									</a>
								</c:if></li>
						</c:forEach>
					</c:when>
					<c:when test="${now_page > 3 && now_page >= page_number -2 }">
						<c:forEach var="cnt" begin="${now_page - 2}" end="${page_number}">
							<li <c:if test="${now_page == cnt}">class="active"</c:if>><c:if
									test="${checker == null}">
									<a href="Search?page=${cnt}"> <c:out value="${cnt}" /></a>
								</c:if> <c:if test="${checker != null}">
									<a
										href="Search?page=${cnt}&
					checker=${checker}&
					serial_no=${serial_no}&
					category_name=${category_name}&
					manufacturer=${manufacturer}&
					name=${name}&
					status=${status}&
					user=${user}&
					start_date=${start_date}&
					return_date=${return_date}&
					use_form=${use_form}">
										<c:out value="${cnt}" />
									</a>
								</c:if></li>
						</c:forEach>
					</c:when>
					<c:when test="${page_number < 5 }">
						<c:forEach var="cnt" begin="1" end="${page_number}">
							<li <c:if test="${now_page == cnt}">class="active"</c:if>><c:if
									test="${checker == null}">
									<a href="Search?page=${cnt}"> <c:out value="${cnt}" /></a>
								</c:if> <c:if test="${checker != null}">
									<a
										href="Search?page=${cnt}&
					checker=${checker}&
					serial_no=${serial_no}&
					category_name=${category_name}&
					manufacturer=${manufacturer}&
					name=${name}&
					status=${status}&
					user=${user}&
					start_date=${start_date}&
					return_date=${return_date}&
					use_form=${use_form}">
										<c:out value="${cnt}" />
									</a>
								</c:if></li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach var="cnt" begin="1" end="5">
							<li <c:if test="${now_page == cnt}">class="active"</c:if>><c:if
									test="${checker == null}">
									<a href="Search?page=${cnt}"> <c:out value="${cnt}" /></a>
								</c:if> <c:if test="${checker != null}">
									<a
										href="Search?page=${cnt}&
					checker=${checker}&
					serial_no=${serial_no}&
					category_name=${category_name}&
					manufacturer=${manufacturer}&
					name=${name}&
					status=${status}&
					user=${user}&
					start_date=${start_date}&
					return_date=${return_date}&
					use_form=${use_form}">
										<c:out value="${cnt}" />
									</a>
								</c:if></li>
						</c:forEach>
					</c:otherwise>
				</c:choose>


				<c:if test="${now_page < page_number}">
					<c:if test="${checker == null}">
						<li><a href="Search?page=${now_page +1}"> <span>»</span>
						</a></li>
					</c:if>
					<c:if test="${checker != null}">
						<li><a
							href="Search?page=${now_page +1}&
					checker=${checker}&
					serial_no=${serial_no}&
					category_name=${category_name}&
					manufacturer=${manufacturer}&
					name=${name}&
					status=${status}&
					user=${user}&
					start_date=${start_date}&
					return_date=${return_date}&
					use_form=${use_form}">
								<span>»</span>
						</a></li>
					</c:if>

				</c:if>
			</ul>
		</nav>
	</div>
</body>
</html>