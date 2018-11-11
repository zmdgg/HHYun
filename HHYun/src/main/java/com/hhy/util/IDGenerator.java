package main.java.com.hhy.util;

import java.util.UUID;

//����������
public class IDGenerator {
	//�������ID
	public static String genPrimaryKey(){
		return UUID.randomUUID().toString();
	}
	//���ָ�����ȵ�����ַ���
	public static String getUUID(int number) {
		if (number < 1) {
			return null;
		}
		String s = genPrimaryKey().substring(0, number);
		return s;
	}
}
