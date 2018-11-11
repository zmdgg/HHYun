package main.java.com.hhy.service;

import java.util.Map;

public interface FileAndFolderService {
	public Map<String, Object> showRecycle(String userID);

	/**
	 * 判读复制或者移动的文件是否复制或移动到其子目录下。
	 * 
	 * @param cateids
	 * @param aimcateid
	 * @return
	 */
	boolean judgeCateID(String cat_uid, String[] cateids, String aimcateid);

	/**
	 * 判读同级目录下是否有相同名字的文件夹
	 * 
	 * @param cateids
	 * @param aimcateid
	 * @return
	 */
	boolean judgeCateName(String cat_uid, String[] cateids, String aimcateid, int flag);

	/**
	 * 移动文件夹
	 * 
	 * @param cat_id
	 * @param cat_reid
	 */
	boolean updateCatereid(String cat_id, String cat_reid);

	/**
	 * 判断目标文件夹下有无名字相同的文件
	 */
	boolean judgeFileName(String file_uid, String[] fileids, String aimcatid, int flag);

	/**
	 * 移动文件
	 * 
	 * @param netFile_id
	 * @param cat_id
	 * @return
	 */
	boolean moveFile(String netFile_id, String cat_id);

	// 这里仅仅数据库改变，不会有文件读写，与ShareService区分
	void preservationcate(String id, String[] cidlist, String cate_reid);

	void preservation(String id, String[] fid, String file_cateid);
}
