package main.java.com.hhy.pojo;

import java.io.Serializable;
import java.util.Date;

public class Share implements Serializable {
    private String id;

    private String userID;

    private String magID;

    private String pwd;

    private Date shareDate;

    private Integer remainTime;

    private static final long serialVersionUID = 1L;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID == null ? null : userID.trim();
    }

    public String getMagID() {
        return magID;
    }

    public void setMagID(String magID) {
        this.magID = magID == null ? null : magID.trim();
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd == null ? null : pwd.trim();
    }

    public Date getShareDate() {
        return shareDate;
    }

    public void setShareDate(Date shareDate) {
        this.shareDate = shareDate;
    }

    public Integer getRemainTime() {
        return remainTime;
    }

    public void setRemainTime(Integer remainTime) {
        this.remainTime = remainTime;
    }
}