package org.lanqiao.wuliu.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import org.lanqiao.wuliu.bean.Goods;
import org.lanqiao.wuliu.bean.Logistics;
import org.lanqiao.wuliu.util.DBUtils;

public class TrafficDaoImpl extends BaseDaoImpl {

	/**
	 * 获取车流列表
	 * 
	 * @param currentPage
	 * @param rowsPerPage
	 * @return
	 */
	public List<Logistics> trafficReach(int currentPage, int rowsPerPage, String searchLogSendDate,
			String searchLogContractNum, String searchLogCarLicence) {
		List<Logistics> list = new LinkedList<Logistics>();

		StringBuilder sql = new StringBuilder("SELECT * FROM logistics WHERE 1 = 1 ");
		List<Object> params = new LinkedList<Object>();

		if (!searchLogSendDate.equals("")) {
			sql.append("AND logSendDate = ? ");
			params.add(searchLogSendDate);
		}
		if (!searchLogContractNum.equals("")) {
			sql.append("AND logContractNum like ? ");
			params.add("%" + searchLogContractNum + "%");
		}
		if (!searchLogCarLicence.equals("")) {
			sql.append("AND logCarLicence like ? ");
			params.add("%" + searchLogCarLicence + "%");
		}

		sql.append("ORDER BY logSendDate DESC LIMIT ?, ?");
		params.add(DBUtils.getOffset(currentPage, rowsPerPage));
		params.add(rowsPerPage);

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();
			preparedStatement = connection.prepareStatement(sql.toString());
			setParameter(preparedStatement, sql.toString(), params.toArray());
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				Logistics logistics = new Logistics();
				logistics.setLogId(resultSet.getInt(1));
				logistics.setLogContractNum(resultSet.getString(2));
				logistics.setLogSendDate(resultSet.getDate(3));
				logistics.setLogSiteStart(resultSet.getString(4));
				logistics.setLogSiteEnd(resultSet.getString(5));
				logistics.setLogCarLicence(resultSet.getString(6));
				logistics.setLogCarDriver(resultSet.getString(7));
				logistics.setLogCarPhone(resultSet.getString(8));
				logistics.setLogCarPay(resultSet.getDouble(9));
				logistics.setLogUnloadPay(resultSet.getDouble(10));
				logistics.setLogPartner(resultSet.getString(11));
				logistics.setLogType(resultSet.getInt(12));
				list.add(logistics);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return list;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closePreparedStatement(preparedStatement);
			DBUtils.closeResultSet(resultSet);
		}
		return list;
	}

	public int trafficSave(Logistics traffic) {
		int count = 0;
		String sql = "INSERT INTO logistics(logContractNum, logSendDate, logSiteStart, logSiteEnd, logCarLicence, logCarDriver, logCarPhone, logCarPay, logUnloadPay, logPartner, logType) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		Object[] params = new Object[] { traffic.getLogContractNum(), traffic.getLogSendDate(),
				traffic.getLogSiteStart(), traffic.getLogSiteEnd(), traffic.getLogCarLicence(),
				traffic.getLogCarDriver(), traffic.getLogCarPhone(), traffic.getLogCarPay(), traffic.getLogUnloadPay(),
				traffic.getLogPartner(), traffic.getLogType() };
		if (traffic.getLogId() != 0) {
			sql = "UPDATE logistics set logContractNum=?,logSendDate=?,logSiteStart=?,logSiteEnd=?,logCarLicence=?,logCarDriver=?,logCarPhone=?,logCarPay=?,logUnloadPay=?,logPartner=?,logType=? WHERE logId=?";
			params = new Object[] { traffic.getLogContractNum(), traffic.getLogSendDate(), traffic.getLogSiteStart(),
					traffic.getLogSiteEnd(), traffic.getLogCarLicence(), traffic.getLogCarDriver(),
					traffic.getLogCarPhone(), traffic.getLogCarPay(), traffic.getLogUnloadPay(),
					traffic.getLogPartner(), traffic.getLogType(), traffic.getLogId() };
		}
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			setParameter(preparedStatement, sql, params);
			count = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			return 0;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closePreparedStatement(preparedStatement);
			DBUtils.closeResultSet(resultSet);
		}
		return count;
	}

	public int trafficDelete(int logId) {
		int count = 0;
		String sql = "DELETE FROM logistics WHERE logId = ?";

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			setParameter(preparedStatement, sql, new Object[] { logId });
			count = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			return 0;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closePreparedStatement(preparedStatement);
			DBUtils.closeResultSet(resultSet);
		}
		return count;
	}

	/**
	 * 获取可用的发车列表
	 * 
	 * @return
	 */
	public List<Object[]> availableDepart() {
		List<Object[]> list = new LinkedList<Object[]>();
		String sql = "SELECT logId, logContractNum, logSendDate, logSiteStart, logSiteEnd, logCarLicence, logCarDriver FROM logistics WHERE logType = 0 AND logSendDate >= CURRENT_DATE ORDER BY logSendDate";

		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				Object[] objects = new Object[7];
				objects[0] = resultSet.getInt(1);
				objects[1] = resultSet.getString(2);
				objects[2] = resultSet.getDate(3);
				objects[3] = resultSet.getString(4);
				objects[4] = resultSet.getString(5);
				objects[5] = resultSet.getString(6);
				objects[6] = resultSet.getString(7);
				list.add(objects);
			}
		} catch (SQLException e) {
			return null;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closeStatement(statement);
			DBUtils.closeResultSet(resultSet);
		}
		return list;
	}

	/**
	 * 获取车流总数
	 * 
	 * @return
	 */
	public int trafficCount(String searchLogSendDate, String searchLogContractNum, String searchLogCarLicence) {
		int count = 0;
		StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM logistics WHERE 1 = 1 ");
		List<Object> params = new LinkedList<Object>();

		if (!searchLogSendDate.equals("")) {
			sql.append("AND logSendDate = ? ");
			params.add(searchLogSendDate);
		}
		if (!searchLogContractNum.equals("")) {
			sql.append("AND logContractNum like ? ");
			params.add("%" + searchLogContractNum + "%");
		}
		if (!searchLogCarLicence.equals("")) {
			sql.append("AND logCarLicence like ? ");
			params.add("%" + searchLogCarLicence + "%");
		}

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();
			preparedStatement = connection.prepareStatement(sql.toString());
			setParameter(preparedStatement, sql.toString(), params.toArray());
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				count = resultSet.getInt(1);
			}
		} catch (SQLException e) {
			return 0;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closePreparedStatement(preparedStatement);
			DBUtils.closeResultSet(resultSet);
		}
		return count;
	}

	/**
	 * 获取特定车流中货品总数
	 * 
	 * @param logId
	 * @return
	 */
	public int goodsCount(int logId) {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM goods WHERE logId = ?";

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			setParameter(preparedStatement, sql, new Object[] { logId });
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				count = resultSet.getInt(1);
			}
		} catch (SQLException e) {
			return 0;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closePreparedStatement(preparedStatement);
			DBUtils.closeResultSet(resultSet);
		}
		return count;
	}

	public int importArrival(Logistics traffic, List<Goods> list) {
		int count = 0;
		String logSql = "INSERT INTO logistics(logContractNum, logSendDate, logSiteStart, logSiteEnd, logCarLicence, logCarDriver, logCarPhone, logCarPay, logUnloadPay, logPartner, logType) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		Object[] logParams = new Object[] { traffic.getLogContractNum(), traffic.getLogSendDate(),
				traffic.getLogSiteStart(), traffic.getLogSiteEnd(), traffic.getLogCarLicence(),
				traffic.getLogCarDriver(), traffic.getLogCarPhone(), traffic.getLogCarPay(), traffic.getLogUnloadPay(),
				traffic.getLogPartner(), traffic.getLogType() };
		String idSql = "SELECT LAST_INSERT_ID()";

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Statement statement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();
			preparedStatement = connection.prepareStatement(logSql);
			setParameter(preparedStatement, logSql, logParams);
			int logCount = preparedStatement.executeUpdate();
			if (logCount != 1) {
				return 0;
			}

			statement = connection.createStatement();
			resultSet = statement.executeQuery(idSql);
			resultSet.next();
			int logId = resultSet.getInt(1);

			for (Goods goods : list) {
				String sql = "INSERT INTO goods(goBank,goName,goPack,goNum,goWeight,goVolume,goSendMan,"
						+ "goSendPhone,goSendAddress,goForMan,goForPhone,goForAddress,goGetWay,goPayWay,"
						+ "goPay,goInsurancePay,goReplacePay,goCommission,goDamagePay,goTransitPay,"
						+ "goSiteEnd,goRemark,goType,logId) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				Object[] params = new Object[] { goods.getGoBank(), goods.getGoName(), goods.getGoPack(),
						goods.getGoNum(), goods.getGoWeight(), goods.getGoVolume(), goods.getGoSendMan(),
						goods.getGoSendPhone(), goods.getGoSendAddress(), goods.getGoForMan(), goods.getGoForPhone(),
						goods.getGoForAddress(), goods.getGoGetWay(), goods.getGoPayWay(), goods.getGoPay(),
						goods.getGoInsurancePay(), goods.getGoReplacePay(), goods.getGoCommission(),
						goods.getGoDamagePay(), goods.getGoTransitPay(), goods.getGoSiteEnd(), goods.getGoRemark(), 1,
						logId };
				preparedStatement = connection.prepareStatement(sql);
				setParameter(preparedStatement, sql, params);
				count = preparedStatement.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closeStatement(statement);
			DBUtils.closePreparedStatement(preparedStatement);
			DBUtils.closeResultSet(resultSet);
		}
		return count;
	}

	/**
	 * 保存短信发送状态
	 * 
	 * @param ids
	 */
	public void saveSmsStatus(List<Integer> ids) {
		String sql = "UPDATE goods set goSmsStatus = ? where goId = ?";

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();

			for (int i = 0; i < ids.size(); i++) {
				preparedStatement = connection.prepareStatement(sql);
				setParameter(preparedStatement, sql, new Object[] { 1, ids.get(i) });
				preparedStatement.executeUpdate();
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closePreparedStatement(preparedStatement);
			DBUtils.closeResultSet(resultSet);
		}
	}

	/**
	 * 获取特定车流信息
	 * 
	 * @param logId
	 */
	public Logistics getTraffic(int logId) {
		Logistics traffic = new Logistics();
		String sql = "SELECT * FROM logistics WHERE logId = ?";

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			setParameter(preparedStatement, sql, new Object[] { logId });
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				traffic.setLogId(resultSet.getInt(1));
				traffic.setLogContractNum(resultSet.getString(2));
				traffic.setLogSendDate(resultSet.getDate(3));
				traffic.setLogSiteStart(resultSet.getString(4));
				traffic.setLogSiteEnd(resultSet.getString(5));
				traffic.setLogCarLicence(resultSet.getString(6));
				traffic.setLogCarDriver(resultSet.getString(7));
				traffic.setLogCarPhone(resultSet.getString(8));
				traffic.setLogCarPay(resultSet.getDouble(9));
				traffic.setLogUnloadPay(resultSet.getDouble(10));
				traffic.setLogPartner(resultSet.getString(11));
				traffic.setLogType(resultSet.getInt(12));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return traffic;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closePreparedStatement(preparedStatement);
			DBUtils.closeResultSet(resultSet);
		}
		return traffic;
	}

	/**
	 * 获取特定车流中的货物列表
	 * 
	 * @param logId
	 */
	public List<Goods> getTrafficGoods(int logId) {
		List<Goods> list = new LinkedList<Goods>();
		String sql = "SELECT * FROM goods WHERE logId = ?";

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtils.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			setParameter(preparedStatement, sql, new Object[] { logId });
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				Goods goods = new Goods();
				goods.setGoId(resultSet.getInt(1));
				goods.setGoBank(resultSet.getString(2));
				goods.setGoName(resultSet.getString(3));
				goods.setGoPack(resultSet.getString(4));
				goods.setGoNum(resultSet.getInt(5));
				goods.setGoWeight(resultSet.getDouble(6));
				goods.setGoVolume(resultSet.getDouble(7));
				goods.setGoSendMan(resultSet.getString(8));
				goods.setGoSendPhone(resultSet.getString(9));
				goods.setGoSendAddress(resultSet.getString(10));
				goods.setGoForMan(resultSet.getString(11));
				goods.setGoForPhone(resultSet.getString(12));
				goods.setGoForAddress(resultSet.getString(13));
				goods.setGoGetWay(resultSet.getString(14));
				goods.setGoPayWay(resultSet.getString(15));
				goods.setGoPay(resultSet.getDouble(16));
				goods.setGoInsurancePay(resultSet.getDouble(17));
				goods.setGoReplacePay(resultSet.getDouble(18));
				goods.setGoCommission(resultSet.getDouble(19));
				goods.setGoDamagePay(resultSet.getDouble(20));
				goods.setGoTransitPay(resultSet.getDouble(21));
				goods.setGoSiteEnd(resultSet.getString(22));
				goods.setGoRemark(resultSet.getString(23));
				goods.setGoType(resultSet.getInt(24));
				goods.setGoSmsStatus(resultSet.getInt(26));
				list.add(goods);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return list;
		} finally {
			DBUtils.closeConnection(connection);
			DBUtils.closePreparedStatement(preparedStatement);
			DBUtils.closeResultSet(resultSet);
		}
		return list;
	}
}
