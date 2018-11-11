package main.java.com.hhy.util;

import java.io.File;  
import java.util.ArrayList;  
import java.util.Calendar;  
import java.util.List;  
  
public class ConvertVideo extends Thread {
     private  static String InputPath ;  
     private  static String flvOutputPath;
     private  static String path;
     private  static String imagePath;
     private static String diskFlag = "C";
     public ConvertVideo(String InputPath) {
    	 this.InputPath = InputPath;
    	 this.path = InputPath.substring(0,InputPath.indexOf(".")); 
    	 this.flvOutputPath =path+".mp4"; 
    	 this.imagePath=path+".jpg";
     }
      
        private  boolean checkfile(String path) {  
            File file = new File(path);  
            if (!file.isFile()) {  
                return false;  
            }  
            return true;  
        }  
        
        public boolean process() { 
            // 判断视频的类型
            int type = checkContentType();  
            boolean status = false;  
            //如果是ffmpeg可以转换的类型直接转码，否则先用mencoder转码成AVI
            if (type == 0) {  
                System.out.println("直接将文件转为flv文件");  
                status = processFLV(InputPath);// 直接将文件转为flv文件  
            } else if (type == 1) {  
                String avifilepath = processAVI(type);  
                if (avifilepath == null)  
                    return false;// avi文件没有得到  
                status = processFLV(avifilepath);// 将avi转为flv  
            }  
            return status;  
        }  
      
        private static int checkContentType() {  
            String type = InputPath.substring(InputPath.lastIndexOf(".") + 1, InputPath.length())  
                    .toLowerCase();  
            // ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）  
            if (type.equals("avi")) {  
                return 0;  
            } else if (type.equals("mpg")) {  
                return 0;  
            } else if (type.equals("wmv")) {  
                return 0;  
            } else if (type.equals("3gp")) {  
                return 0;  
            } else if (type.equals("mov")) {  
                return 0;  
            } else if (type.equals("mp4")) {  
                return 0;  
            } else if (type.equals("asf")) {  
                return 0;  
            } else if (type.equals("asx")) {  
                return 0;  
            } else if (type.equals("flv")) {  
                return 0;  
            }  
            // 对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等),  
            // 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.  
            else if (type.equals("wmv9")) {  
                return 1;  
            } else if (type.equals("rm")) {  
                return 1;  
            } else if (type.equals("rmvb")) {  
                return 1;  
            }  
            return 9;  
        }  
           
      
        // 对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等), 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.  
        private static String processAVI(int type) {  
            List<String> commend = new ArrayList<String>();  
            commend.add(ConvertVideo.diskFlag+":\\ffmpeg\\mencoder");  
            commend.add(InputPath);  
            commend.add("-oac");  
            commend.add("lavc");  
            commend.add("-lavcopts");  
            commend.add("acodec=mp3:abitrate=64");  
            commend.add("-ovc");  
            commend.add("xvid");  
            commend.add("-xvidencopts");  
            commend.add("bitrate=600");  
            commend.add("-of");  
            commend.add("avi");  
            commend.add("-o");  
            commend.add(flvOutputPath);  
            try {  
                //调用线程命令启动转码
                ProcessBuilder builder = new ProcessBuilder();  
                builder.command(commend);  
                builder.start();  
                return flvOutputPath;  
            } catch (Exception e) {  
                e.printStackTrace();  
                return null;  
            }  
        }  
      
        // ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）  
        private  boolean processFLV(String oldfilepath) {  
      
            if (!checkfile(InputPath)) {  
                System.out.println(oldfilepath + " is not file");  
                return false;  
            }  
              
            // 文件命名  
            Calendar c = Calendar.getInstance();  
            String savename = String.valueOf(c.getTimeInMillis())+ Math.round(Math.random() * 100000);  
            List<String> commend = new ArrayList<String>();  
            commend.add(this.diskFlag+":\\ffmpeg\\bin\\ffmpeg");  
            commend.add("-i");  
            commend.add(oldfilepath);  
            commend.add("-ab");  
            commend.add("56");  
            commend.add("-ar");  
            commend.add("22050");  
            commend.add("-qscale");  
            commend.add("8");  
            /*
            commend.add("-vcodec");
            commend.add("libx264");
            */
            commend.add("-crf");//指定输出视频的质量，默认为23，数字越小输出视频的质量越高
            commend.add("20");
            commend.add("-r");  
            commend.add("15");  
            commend.add("-s");  
            commend.add("858x480");  
            commend.add(flvOutputPath);  
      
            try {  
                Runtime runtime = Runtime.getRuntime();  
                Process proce = null; 
                //视频截图命令，封面图。  8是代表第5秒的时候截图
                String cmd = "";  
                String cut = this.diskFlag+":\\FFmpeg\\bin\\ffmpeg.exe   -i   "  
                        + oldfilepath  
                        + "   -y   -f   image2   -ss   5   -t   0.001   -s   858x480   "+imagePath;  
                String cutCmd = cmd + cut;  
                proce = runtime.exec(cutCmd);  
                //调用线程命令进行转码
                ProcessBuilder builder = new ProcessBuilder(commend);                 
                 builder.command(commend);  
                builder.start();  
      
                return true;  
            } catch (Exception e) {  
                e.printStackTrace();  
                return false;  
            }  
        }  
        @Override
        public void run() {
        	process();
        }
        /*
        public static void main(String[] args) {  
        	String strpath = "D:/networkdiskFile/QQ.mp4";
        	ConvertVideo convertVideo = new ConvertVideo(strpath);
            if (convertVideo.process()) {        //执行转码任务
                System.out.println("视频转换ok");  
            }  
         
        } 
         */
}
