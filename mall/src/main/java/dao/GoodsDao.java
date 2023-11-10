package dao;
import java.util.ArrayList;
import vo.Goods;
import vo.Nostice;
import vo.Question;

import java.sql.*;
public class GoodsDao {
	//db접근용 데이터
	final String url;
	final String dbuser;
	final String dbpw;
	
	//생성자
	public GoodsDao() throws ClassNotFoundException {
		this.url = "jdbc:mariadb://192.168.200.36:3306/mall";
		this.dbuser = "user";
		this.dbpw = "java1234";
		Class.forName("org.mariadb.jdbc.Driver");
	}
	public ArrayList<Goods> selectArrayList(String goodsTitle, int goodsPrice) throws Exception {
		
	ArrayList<Goods> list = new ArrayList<>();
	
	//DB연결
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	//상품명,가격,솔드아웃여부,메모 쿼리문
	String sql = "SELECT goods_no goodsNo, goods_title goodsTitle, goods_Price goodsPrice, soldout, goods_memo goodsMemo, soldout FROM goods";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	list = new ArrayList<>();
	while(rs.next()) {
	Goods g = new Goods();
	g.setGoodsNo(rs.getInt("goodsNo"));
	g.setGoodsTitle(rs.getString("goodsTitle"));
	g.setGoodsPrice(rs.getInt("goodsPrice"));
	g.setGoodsMemo(rs.getString("goodsMemo"));
	g.setSoldout(rs.getString("soldout"));
	list.add(g);
	
	//DB자원반납
	stmt.close();
	conn.close();
	
	}
	return list; 
  }	
	//controller : insertGoodsAction.jsp
	public int insertGoods(Goods goods) throws Exception{
		int row = 0;
		// model code
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// 상품추가를 위한 INSERT QUERY
		String sql = "INSERT INTO goods (goods_title,goods_price,soldout,goods_memo,createdate,updatedate) VALUES (?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,goods.getGoodsTitle());
		stmt.setInt(2,goods.getGoodsPrice());
		stmt.setString(3,goods.getSoldout());
		stmt.setString(4,goods.getGoodsMemo());
		row = stmt.executeUpdate();
		
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	//controller : deleteGoodsAction.jsp
	public int deleteGoods(int goodsNo) throws Exception {
		int row = 0;
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// goods 삭제를 위한 DELETE QUERY
		String sql ="DELETE FROM goods WHERE goods_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		System.out.println(stmt + "<- stmt delectTest()");
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	//controller : updateGoodsForm.jsp
	public Goods goodsOne(int goodsNo) throws Exception{
		Goods g = new Goods();
		// model code
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// goods 정보를 출력하기 위한 SELECT QUERY
		String sql = "SELECT goods_no goodsNo, goods_title goodsTitle, goods_Price goodsPrice, soldout, goods_memo goodsMemo, soldout,createdate,updatedate FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			g.setGoodsNo(rs.getInt("goodsNo"));
			g.setGoodsTitle(rs.getString("goodsTitle"));
			g.setGoodsPrice(rs.getInt("goodsPrice"));
			g.setSoldout(rs.getString("soldout"));
			g.setGoodsMemo(rs.getString("goodsMemo"));
			g.setCreatedate(rs.getString("createdate"));;
			g.setUpdatedate(rs.getString("updatedate"));
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return g;
	}
	//controller : updateGoodsForm.jsp
	public Goods goodsNoOne(String goodsTitle) throws Exception{
		Goods g = new Goods();
		// model code
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// goods 정보를 출력하기 위한 SELECT QUERY
		String sql = "SELECT goods_no goodsNo, goods_title goodsTitle, goods_Price goodsPrice, soldout, goods_memo goodsMemo, soldout,createdate,updatedate FROM goods WHERE goods_title = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, goodsTitle);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			g.setGoodsNo(rs.getInt("goodsNo"));
			g.setGoodsTitle(rs.getString("goodsTitle"));
			g.setGoodsPrice(rs.getInt("goodsPrice"));
			g.setSoldout(rs.getString("soldout"));
			g.setGoodsMemo(rs.getString("goodsMemo"));
			g.setCreatedate(rs.getString("createdate"));;
			g.setUpdatedate(rs.getString("updatedate"));
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return g;
	}
	//controller : updateGoodsAction.jsp
	public int updateGoods(Goods goods)throws Exception {
		int row = 0;
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		// 상품 수정을 위한 UPDATE QUERY
		String sql = "UPDATE goods SET goods_title = ?, goods_price = ?, soldout = ?, goods_memo = ?, updatedate = NOW() WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,goods.getGoodsTitle());
		stmt.setInt(2,goods.getGoodsPrice());
		stmt.setString(3,goods.getSoldout());
		stmt.setString(4,goods.getGoodsMemo());
		stmt.setInt(5,goods.getGoodsNo());
		row = stmt.executeUpdate();
		//DB자원반납
		stmt.close();
		conn.close();
		//end model code
		return row;
	}
	//controller : goodsMangementList.jsp
	public ArrayList<Goods> selectGoodsList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Goods> list = new ArrayList<>();
		
		// model code
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT goods_no goodsNo, goods_title goodsTitle, goods_Price goodsPrice, soldout, goods_memo goodsMemo,createdate,updatedate FROM goods order by goods_no DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Goods g = new Goods();
			g.setGoodsNo(rs.getInt("goodsNo"));
			g.setGoodsTitle(rs.getString("goodsTitle"));
			g.setGoodsPrice(rs.getInt("goodsPrice"));
			g.setGoodsMemo(rs.getString("goodsMemo"));
			g.setSoldout(rs.getString("soldout"));
			g.setCreatedate(rs.getString("createdate"));
			g.setUpdatedate(rs.getString("updatedate"));
			list.add(g);
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return list;
	}
	//controller : goodsMangementList.jsp
	public int goodsCNT() throws Exception{
		int row = 0;
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT COUNT(*) FROM goods";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("COUNT(*)");
		}
		return row;
	}	
	public ArrayList<Goods> searchGoodsList(String searchTitle) throws Exception{
		ArrayList<Goods> list = new ArrayList<>();
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "SELECT goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice, soldout, goods_memo goodsMemo,createdate,updatedate FROM goods WHERE goods_title LIKE (?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,"%"+searchTitle+"%");
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Goods g = new Goods();
			g.setGoodsNo(rs.getInt("goodsNo"));
			g.setGoodsTitle(rs.getString("goodsTitle"));
			g.setGoodsPrice(rs.getInt("goodsPrice"));
			g.setSoldout(rs.getString("soldout"));
			g.setGoodsMemo(rs.getString("goodsMemo"));
			g.setCreatedate(rs.getString("createdate"));
			g.setUpdatedate(rs.getString("updatedate"));
			list.add(g);
		}
		//DB자원반납
		rs.close();
		stmt.close();
		conn.close();
		//end model code
		return list;
	}
}