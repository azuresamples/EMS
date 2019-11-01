
package com.ems;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.beans.Account;
import com.ems.service.Repository;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("ログインのGETだよ");
		request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("ログインのPOSTだよ");
		request.setCharacterEncoding("UTF-8");

		String account_id = request.getParameter("account_id");
		String password = request.getParameter("password");

		String sql = "SELECT * FROM accounts WHERE account_id = ? AND password=?";

		try {

			Connection con = new Repository().getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, account_id);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();

			if (rs.first()) {
				System.out.println("ログインできている。");

				HttpSession session = request.getSession();

				Account user = new Account();
				user.setAccount_id(rs.getInt("account_id"));
				user.setName(rs.getString("name"));
				user.setPassword(rs.getString("password"));
				user.setAuthority(rs.getInt("authority"));

				session.setAttribute("login_user", user);
				session.setAttribute("result", "init");

				response.sendRedirect("Search");
			} else {

				request.setAttribute("errormessage", "IDかパスワードが間違っています。");
				request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
