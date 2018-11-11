package main.java.com.hhy.service;

import java.util.Map;

public interface FileAndFolderService {
	public Map<String, Object> showRecycle(String userID);

	/**
	 * �ж����ƻ����ƶ����ļ��Ƿ��ƻ��ƶ�������Ŀ¼�¡�
	 * 
	 * @param cateids
	 * @param aimcateid
	 * @return
	 */
	boolean judgeCateID(String cat_uid, String[] cateids, String aimcateid);

	/**
	 * �ж�ͬ��Ŀ¼���Ƿ�����ͬ���ֵ��ļ���
	 * 
	 * @param cateids
	 * @param aimcateid
	 * @return
	 */
	boolean judgeCateName(String cat_uid, String[] cateids, String aimcateid, int flag);

	/**
	 * �ƶ��ļ���
	 * 
	 * @param cat_id
	 * @param cat_reid
	 */
	boolean updateCatereid(String cat_id, String cat_reid);

	/**
	 * �ж�Ŀ���ļ���������������ͬ���ļ�
	 */
	boolean judgeFileName(String file_uid, String[] fileids, String aimcatid, int flag);

	/**
	 * �ƶ��ļ�
	 * 
	 * @param netFile_id
	 * @param cat_id
	 * @return
	 */
	boolean moveFile(String netFile_id, String cat_id);

	// ����������ݿ�ı䣬�������ļ���д����ShareService����
	void preservationcate(String id, String[] cidlist, String cate_reid);

	void preservation(String id, String[] fid, String file_cateid);
}
