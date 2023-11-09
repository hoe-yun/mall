package dao;
import vo.*;
import java.util.ArrayList;

import javax.servlet.ServletRequest;

import org.eclipse.jdt.internal.compiler.ast.ReturnStatement;

import vo.ProductCart;

import java.io.Console;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProductCartDao {
	public ArrayList<ProductCart> selectArrayList(int customerNo, String goodsTitle, int goodsPrice, int goodsNo, int quantity, int cartNo) throws Exception {
		
	ArrayList<ProductCart> list = new ArrayList<>();
	
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://192.168.200.36:3306/mall";
	String dbuser = "user";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	//상품명,가격,솔드아웃여부,메모 쿼리문
	String sql = "SELECT g.goods_title goodsTitle, g.goods_price goodsPrice, c.customer_no customerNo, c.cart_no cartNo, g.goods_memo goodsMemo, g.goods_no goodsNo, c.quantity FROM cart c inner join goods g on c.goods_no = g.goods_no WHERE c.customer_no= ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, customerNo);
	ResultSet rs = stmt.executeQuery();
	
	//ResultSet로 가져온 데이터를 새로운 ProductCart ArrayList에 담기
	list = new ArrayList<>();
	while(rs.next()) {
	ProductCart c = new ProductCart();
	c.setCustomerNo(rs.getInt("customerNo"));
	c.setGoodsNo(rs.getInt("goodsNo"));
	c.setQuantity(rs.getInt("quantity"));
	c.setCartNo(rs.getInt("cartNo"));
	c.setGoodsTitle(rs.getString("goodsTitle"));
	c.setGoodsPrice(rs.getInt("goodsPrice"));
	c.setGoodsMemo(rs.getString("goodsMemo"));
	list.add(c);
	
	//DB자원반납
	rs.close();
	stmt.close();
	conn.close();
	
	}
	return list; 
  }	
	public ProductCart selectProductDetail(String goodsTitle, int goodsPrice, int goodsNo) throws Exception {
		
		
		//DB연결
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://192.168.200.36:3306/mall";
		String dbuser = "user";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		//상품 번호 별 상품명,가격,솔드아웃여부,메모 쿼리문
		
		String sql = "SELECT goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice, goods_memo goodsMemo, soldout FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = stmt.executeQuery();
		
		//DB에서 셀렉한 데이터를 새로운 객체에 저장
		ProductCart c = new ProductCart();
		while(rs.next()) {
		
		c.setGoodsNo(rs.getInt("goodsNo"));
		c.setGoodsTitle(rs.getString("goodsTitle"));
		c.setGoodsPrice(rs.getInt("goodsPrice"));
		c.setGoodsMemo(rs.getString("goodsMemo"));
		c.setSoldout(rs.getString("soldout"));
		
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		
		}
		return c; 
	  }	
	// controller
	public int selectCart(int goodsNo) throws Exception{
		int row =0;
		// model code
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.200.36:3306/mall";
			String dbuser = "user";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			//넘겨받은 goodsNo로 상품명,가격,수량,고객번호를 찾는 쿼리
			String sql ="SELECT goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice FROM goods ";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				Goods g = new Goods();
				g.setGoodsNo(rs.getInt("goodsNo"));
				g.setGoodsTitle(rs.getString("goodsTitle"));
				g.setGoodsPrice(rs.getInt("goodsPrice"));
		
			}
			//DB자원반납
			rs.close();
			stmt.close();
			conn.close();
			return row;
	}
	// controller : insertCartAction.jsp
		public int insertCart(int customerNo, int goodsNo, int quantity) throws Exception{
			
			// model code
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.200.36:3306/mall";
			String dbuser = "user";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			//cart상품 insert 쿼리
			String sql ="INSERT INTO cart(goods_no, customer_no, quantity, createdate, updatedate) VALUES(?,?,?,NOW(),NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo); 
			stmt.setInt(2, customerNo);
			stmt.setInt(3, quantity);
			int row = stmt.executeUpdate();
				if(row == 1 ) {
					System.out.println("입력성공");
				}else {
					System.out.println("입력실패");
				}
			//DB자원 반납
			stmt.close();
			conn.close();
			return row;
		}
		public int deleteCart(int cartNo) throws Exception {
			// model code
						Class.forName("org.mariadb.jdbc.Driver");
						String url = "jdbc:mariadb://192.168.200.36:3306/mall";
						String dbuser = "user";
						String dbpw = "java1234";
						Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			//cart페이지에서 상품 삭제 쿼리문
			String sql ="DELETE FROM cart WHERE cart_no=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cartNo);
			int row = stmt.executeUpdate();
			if(row == 1 ) {
				System.out.println("삭제성공");
			}else {
				System.out.println("삭제실패");
			}
			//DB자원 반납
			stmt.close();
			conn.close();
			return row;
		}
	
}