package main.java.com.hhy.pojo;

import java.io.Serializable;

public class ShareData implements Serializable {
    private String id;

    private String magid;

    private String fileOrFolderID;

    private Integer isFolder;

    private static final long serialVersionUID = 1L;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getMagid() {
        return magid;
    }

    public void setMagid(String magid) {
        this.magid = magid == null ? null : magid.trim();
    }

    public String getFileOrFolderID() {
        return fileOrFolderID;
    }

    public void setFileOrFolderID(String fileOrFolderID) {
        this.fileOrFolderID = fileOrFolderID == null ? null : fileOrFolderID.trim();
    }

    public Integer getIsFolder() {
        return isFolder;
    }

    public void setIsFolder(Integer isFolder) {
        this.isFolder = isFolder;
    }
}