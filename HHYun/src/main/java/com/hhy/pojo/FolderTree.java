package main.java.com.hhy.pojo;

import java.util.List;


public class FolderTree {
	private String folderID;
	private String folderName;
	private List<FolderTree> list;
	
	public FolderTree() {
		super();
	}
	public String getFolderID() {
		return folderID;
	}
	public void setFolderID(String folderID) {
		this.folderID = folderID;
	}
	public String getFolderName() {
		return folderName;
	}
	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}
	public List<FolderTree> getList() {
		return list;
	}
	public void setList(List<FolderTree> list) {
		this.list = list;
	}
	
}
