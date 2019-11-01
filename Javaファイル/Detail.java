package com.ems;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.beans.Account;
import com.ems.service.GetEquipmentInfo;
import com.ems.service.Repository;

/**
 * Servlet implementation class Detail
 */
@WebServlet("/Detail")
public class Detail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Detail() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		System.out.println("Detail.java doGet");
		try {
			Connection con = new Repository().getConnection();
			HttpSession session = request.getSession();
			GetEquipmentInfo gei = new GetEquipmentInfo(con);
			Account user = new Account();

			user = (Account) session.getAttribute("user");

			request.setAttribute("user", user);
			request.setAttribute("equipment_list", gei.findOne(request));
			request.getRequestDispatcher("detail.jsp").forward(request, response);

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("Detail.java doPost");
		request.setCharacterEncoding("utf-8");

		try {

			// データベースとのコネクションを生成
			Connection con = new Repository().getConnection();
			HttpSession session = request.getSession();
			GetEquipmentInfo gei = new GetEquipmentInfo(con);

			String service = request.getParameter("service");

			// 借りるボタンから
			if (service == null) {
				request.getRequestDispatcher("borrow.jsp").forward(request, response);
			}

			// 申請ボタンから
			if (service.equals("application")) {
				ArrayList<String> error_message = gei.check_2(request);

				if(error_message.size() != 0) {
					session.setAttribute("error_message", error_message);
					request.getRequestDispatcher("borrow.jsp").forward(request, response);
				}else {
					session.setAttribute("result", gei.borrow(request));
					session.setAttribute("action", "申請");
					gei.actionHistory(request);
					request.setAttribute("equipment_list", gei.findOne(request));
					request.getRequestDispatcher("detail.jsp").forward(request, response);
				}
			}

			// 削除ボタンから
			if (service.equals("delete")) {

				session.setAttribute("result", gei.delete(request));
				session.setAttribute("action", "削除");
				gei.actionHistory(request);
				response.sendRedirect("Search");
			}

			// 承認ボタンから
			if (service.equals("approval")) {

				session.setAttribute("result", gei.approval(request));
				session.setAttribute("action", "承認");
				gei.actionHistory(request);
				request.setAttribute("equipment_list", gei.findOne(request));
				request.getRequestDispatcher("detail.jsp").forward(request, response);
			}

			// 否認ボタンから
			if (service.equals("denial")) {

				session.setAttribute("result", gei.denial(request));
				session.setAttribute("action", "否認");
				gei.actionHistory(request);
				request.setAttribute("equipment_list", gei.findOne(request));
				request.getRequestDispatcher("detail.jsp").forward(request, response);
			}

			// 返却ボタンから
			if (service.equals("ret")) {

				session.setAttribute("result", gei.ret(request));
				session.setAttribute("action", "返却");
				gei.actionHistory(request);
				request.setAttribute("equipment_list", gei.findOne(request));
				request.getRequestDispatcher("detail.jsp").forward(request, response);
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
