package main.java.com.hhy.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;

import javax.imageio.stream.FileCacheImageOutputStream;

public class FileUtils {
	//ÎÄ¼þ¸´ÖÆ
	public static void fileChannelCopy(File src,File dst) throws IOException {
		FileChannel inChannel =new FileInputStream(src).getChannel();
		FileChannel outChannel=new FileOutputStream(dst).getChannel();
		
		inChannel.transferTo(0, inChannel.size(), outChannel);
		
		inChannel.close();
		outChannel.close();
	}
}
