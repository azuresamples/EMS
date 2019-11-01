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
import javax.servlet.http.HttpSession;

import com.ems.beans.EquipmentInfo;
import com.ems.service.GetEquipmentInfo;
import com.ems.service.Repository;

/**
 * Servlet implementation class resi_Servlet
 */
@WebServlet("/resi_Servlet")
public class resi_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public resi_Servlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			Connection con = new Repository().getConnection();
			GetEquipmentInfo gei = new GetEquipmentInfo(con);

			request.setAttribute("category_name", gei.getCategory());
			request.setAttribute("manufacturer", gei.getManu());
			request.setAttribute("name", gei.getName());
			request.getRequestDispatcher("resistration.jsp").forward(request, response);

			con.close();

		} catch (SQLException e) {
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
		GetEquipmentInfo gei = new GetEquipmentInfo(con);
		HttpSession session = request.getSession();

		try {
			String service = request.getParameter("service");

			//検索ボタン
			if (service.equals("search")) {

				ArrayList<EquipmentInfo> data = gei.b_resistrate_search(request);
				if (data.size() == 0) {
					request.setAttribute("error_message", "指定されたデータは存在しません。");
				}
				request.setAttribute("search", data);
				request.setAttribute("category_name", gei.getCategory());
				request.setAttribute("manufacturer", gei.getManu());
				request.setAttribute("name", gei.getName());
				request.getRequestDispatcher("resistration.jsp").forward(request, response);
			}

			//追加ボタン
			if (service.equals("add")) {

				request.setAttribute("addto", gei.addto(request));
				request.setAttribute("category_name", gei.getCategory());
				request.setAttribute("manufacturer", gei.getManu());
				request.setAttribute("name", gei.getName());
				request.getRequestDispatcher("resistration.jsp").forward(request, response);
			}

			//確認画面へボタン
			if (service.equals("check")) {
				if(gei.check_serial(request) == true) {
					request.setAttribute("error_message", "入力したシリアルNo.は既に登録済みです。");
					request.setAttribute("search", gei.b_resistrate_search(request));
					request.setAttribute("category_name", gei.getCategory());
					request.setAttribute("manufacturer", gei.getManu());
					request.setAttribute("name", gei.getName());
					request.setAttribute("addto", gei.reform(request));
					request.getRequestDispatcher("resistration.jsp").forward(request, response);
				}
				ArrayList<String> error_message = gei.check_1(request);
				System.out.println(error_message);
				System.out.println(error_message.size());
				if (error_message.size() != 0) {
					session.setAttribute("error_message", error_message);
					System.out.println("///////////////////////");
					response.sendRedirect("resi_Servlet");

				} else {
					//					System.out.println("@@@@@@@@@@@@@@@@@@@@@@");
					request.setAttribute("equipo", gei.normalizer(request));
					request.getRequestDispatcher("resi_check.jsp").forward(request, response);
				}

			}

			//登録ボタン
			if (service.equals("resist")) {

				String str = gei.resistrate_search(request);

				if (str.equals("noName")) {
					gei.resistrate_ca(request);
					gei.resistrate_sp(request);
					session.setAttribute("result", gei.resistrate_eq(request));
				} else if (str.equals("cate_ok")) {
					gei.resistrate_sp(request);
					session.setAttribute("result", gei.resistrate_eq(request));
				} else {
					session.setAttribute("result", gei.resistrate_eq(request));
				}
				session.setAttribute("action", "登録");
				gei.actionHistory(request);

				request.setAttribute("search", gei.b_resistrate_search(request));
				request.setAttribute("category_name", gei.getCategory());
				request.setAttribute("manufacturer", gei.getManu());
				request.setAttribute("name", gei.getName());
				response.sendRedirect("resi_Servlet");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
