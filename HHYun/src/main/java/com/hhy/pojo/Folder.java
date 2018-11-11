package main.java.com.hhy.pojo;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Folder implements Serializable {
    private String id;

    private String folderName;

    private String userID;

    private Date updateDate;

    private String superFolderID;

    private Integer isDelete;

    private static final long serialVersionUID = 1L;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getFolderName() {
        return folderName;
    }

    public void setFolderName(String folderName) {
        this.folderName = folderName == null ? null : folderName.trim();
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID == null ? null : userID.trim();
    }
/*
    public Date getUpdateDate() {
        return updateDate;
    }
*/
    public String getUpdateDate() {
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
        String temp = formatter.format(updateDate);
        return temp;
    }
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getSuperFolderID() {
        return superFolderID;
    }

    public void setSuperFolderID(String superFolderID) {
        this.superFolderID = superFolderID == null ? null : superFolderID.trim();
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }
}