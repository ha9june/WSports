package service.member;

import javax.servlet.http.Part;

import dto.User;

public interface MemberService {
	User mypageEdit (User user) throws Exception;
	User profileEdit (User user, String uploadPath, Part profileImage, boolean deleteImg) throws Exception;
}
