package com.ems;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.beans.EquipmentInfo;
import com.ems.service.GetEquipmentInfo;
import com.ems.service.Repository;

/**
 * Servlet implementation class Detail
 */
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Search() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		try {
			Connection con = new Repository().getConnection();
//			HttpSession session = request.getSession();
			System.out.println("checker : " + request.getParameter("checker"));
			System.out.println("cnt : " + request.getParameter("page"));


			if(request.getParameter("checker") != null) {
				System.out.println("POSTにとべーーーーーーーー");
				doPost(request,response);
			}else {


			GetEquipmentInfo gei = new GetEquipmentInfo(con);

//			session.setAttribute("result", false);
			request.setAttribute("csv_data", GetEquipmentInfo.csvData(gei.getCsvDataGet(request)));
			request.setAttribute("equipment_list", gei.findAll(request));//全件取得メソ
			request.setAttribute("category_list", gei.getCategory());//カテゴリ取得メソ
			request.setAttribute("page_number", gei.getallPageNumber(request)); //ページ数取得メソ
			request.setAttribute("now_page", gei.getNowPage(request));//現在のページ取得メソ
			request.getRequestDispatcher("SearchPage.jsp").forward(request, response);

			con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		Connection con = new Repository().getConnection();
		//String service = request.getParameter("service");
		GetEquipmentInfo gei = new GetEquipmentInfo(con);

		try {
			//検索ボタンから
			request.setAttribute("serial_no", request.getParameter("serial_no"));
			request.setAttribute("category_name", request.getParameter("category_name"));
			request.setAttribute("manufacturer", request.getParameter("manufacturer"));
			request.setAttribute("name", request.getParameter("name"));
			request.setAttribute("status", request.getParameter("status"));
			request.setAttribute("user", request.getParameter("user"));
			request.setAttribute("start_date", request.getParameter("start_date"));
			request.setAttribute("return_date", request.getParameter("return_date"));
			request.setAttribute("use_form", request.getParameter("use_form"));

			int checker = 1;
//			System.out.println("POSTに飛んでるよ");
			request.setAttribute("csv_data", GetEquipmentInfo.csvData(gei.getCsvDataPost(request)));
			request.setAttribute("checker", checker);
			request.setAttribute("equipment_list",gei.search(request)); //検索結果取得メソ

			ArrayList<EquipmentInfo> data = gei.search(request);
			System.out.println(data);
			if (data.size() == 0) {
				request.setAttribute("error_message", "指定されたデータは存在しません。");
			}
			

			request.setAttribute("category_list", gei.getCategory());//カテゴリー取得メソ
			request.setAttribute("page_number", gei.getpageNumber(request));//ページ数取得メソ
			request.setAttribute("now_page", gei.getNowPage(request));//現在のページ取得
			request.getRequestDispatcher("SearchPage.jsp").forward(request, response);
			con.close();
		} catch (SQLException e) {
			e.getStackTrace();
		}

	}

}
