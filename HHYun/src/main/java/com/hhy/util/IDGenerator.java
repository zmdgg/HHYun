package main.java.com.hhy.util;

import java.util.UUID;

//主键生成器
public class IDGenerator {
	//随机生成ID
	public static String genPrimaryKey(){
		return UUID.randomUUID().toString();
	}
	//获得指定长度的随机字符串
	public static String getUUID(int number) {
		if (number < 1) {
			return null;
		}
		String s = genPrimaryKey().substring(0, number);
		return s;
	}
}
