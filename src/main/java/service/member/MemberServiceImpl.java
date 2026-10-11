package service.member;

import java.io.File;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Part;

import dao.UserDao;
import dao.UserDaoImpl;
import dto.User;

public class MemberServiceImpl implements MemberService {
	private UserDao userDao;
	
	public MemberServiceImpl() {
		userDao = new UserDaoImpl();
	}

	@Override
	public User mypageEdit(User user) throws Exception {
		userDao.updateMypage(user);
		User updateUser = userDao.selectLoginId(user.getLoginId());
		return updateUser;
	}

	@Override
	public User profileEdit(User user, String uploadPath, Part profileImage, boolean deleteImg) throws Exception {
		String oldImage = userDao.selectLoginId(user.getLoginId()).getProfileImage();
		
		String fileName = (profileImage != null) ? profileImage.getSubmittedFileName() : null;
		boolean hasNewFile = fileName != null && !fileName.isEmpty();
		
		if(hasNewFile) {
			String original = Paths.get(fileName).getFileName().toString();
			fileName = user.getLoginId() + "_" + original;
			
			File uploadDir = new File(uploadPath);
			if(!uploadDir.exists()) uploadDir.mkdir();
			profileImage.write(uploadPath+File.separator+fileName);
			user.setProfileImage(fileName);
		} else if (deleteImg) {
			user.setProfileImage("");
		}
		userDao.updateProfile(user);
		
		boolean sameName = hasNewFile && fileName.equals(oldImage);
		if((hasNewFile || deleteImg) && oldImage != null && !oldImage.isEmpty() && !sameName) {
			new File(uploadPath, oldImage).delete();
		}
		return userDao.selectLoginId(user.getLoginId());
	}
	
	// 공개프로필
	@Override
	public Map<String, Object> publicProfile(Long userId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		return userDao.publicProfile(param);
	}
	
	// 공개프로필 팀
	@Override
	public List<Map<String, Object>> publicProfileTeams(Long userId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		return userDao.publicProfileTeams(param);
	}
}
