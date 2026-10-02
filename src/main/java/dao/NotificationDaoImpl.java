package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.Notification;

public class NotificationDaoImpl implements NotificationDao {

	@Override
	public Long insertNotification(Notification notification) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.notification.insertNotification", notification);
			sqlSession.commit();
			return notification.getNotificationId();
		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public void updateNotificationIdRead(Long notificationId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.notification.updateNotificationIdRead", notificationId);
			sqlSession.commit();

		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Notification	selectNotification(Long notificationId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notification.selectNotification", notificationId);
		}
	}

	@Override
	public List<Notification> selectNotificationListNotConfirm3(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notification.selectNotificationListNotConfirm3", userId);
		}
	}

	@Override
	public List<Notification> selectNotificationList(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notification.selectNotificationList", userId);
		}
	}

	@Override
	public int selectNotificationListNotConfirmCnt(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notification.selectNotificationListNotConfirmCnt", userId);
		}
	}
}
