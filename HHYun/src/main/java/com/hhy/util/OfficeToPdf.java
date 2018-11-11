package main.java.com.hhy.util;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;
import org.springframework.util.StringUtils;

import java.io.File;
import java.util.regex.Pattern;

  
 
public class OfficeToPdf{  
	private static final Log LOG = LogFactory.getLog(OfficeToPdf.class);
      
	/**
     * 使Office2003-2007全部格式的文档(.doc|.docx|.xls|.xlsx|.ppt|.pptx) 转化为pdf文件<br>
     *
     * @param inputFilePath
     *            源文件路径，如："e:/test.docx"
     * @return
     */
    public static File openOfficeToPDF(String inputFilePath)throws Exception {
        return office2pdf(inputFilePath);
    }

    /**
     * 根据操作系统的名称，获取OpenOffice.org 3的安装目录<br>
     * 如我的OpenOffice.org 3安装在：C:/Program Files (x86)/OpenOffice.org 3<br>
     *
     * @return OpenOffice.org 3的安装目录
     */
    public static String getOfficeHome() {
        String osName = System.getProperty("os.name");
        System.out.println("操作系统名称:" + osName);
        if (Pattern.matches("Linux.*", osName)) {
            return "/opt/openoffice.org3";
        } else if (Pattern.matches("Windows.*", osName)) {
            return "C:\\Program Files (x86)\\OpenOffice 4";
        } else if (Pattern.matches("Mac.*", osName)) {
            return "/Applications/OpenOffice.org.app/Contents/";
        }
        return null;
    }

    /**
     * 连接OpenOffice.org 并且启动OpenOffice.org
     *
     * @return
     */
    public static OfficeManager getOfficeManager()throws Exception {
        DefaultOfficeManagerConfiguration config = new DefaultOfficeManagerConfiguration();
        // 设置OpenOffice.org 3的安装目录
        config.setOfficeHome(getOfficeHome());
        // 启动OpenOffice的服务
        OfficeManager officeManager = config.buildOfficeManager();
        officeManager.start();
        return officeManager;
    }

    /**
     * 转换文件
     *
     * @param inputFile
     * @param outputFilePath_end
     * @param inputFilePath
     * @param converter
     */
    public static File converterFile(File inputFile, String outputFilePath_end, String inputFilePath,
                                     OfficeDocumentConverter converter)throws Exception {
        File outputFile = new File(outputFilePath_end);
        // 假如目标路径不存在,则新建该路径
        if (!outputFile.getParentFile().exists()) {
            outputFile.getParentFile().mkdirs();
        }
        //判断转换文件的编码方式，如果不是UTF-8，则改为UTF-8编码
        converter.convert(inputFile, outputFile);
        System.out.println("文件：" + inputFilePath + "\n转换为\n目标文件：" + outputFile + "\n成功!");
        return outputFile;
    }

    /**
     * 使Office2003-2007全部格式的文档(.doc|.docx|.xls|.xlsx|.ppt|.pptx) 转化为pdf文件<br>
     *
     * @param inputFilePath
     *            源文件路径，如："e:/test.docx"
     * @return
     */
    public static File office2pdf(String inputFilePath) throws Exception {
        OfficeManager officeManager = null;
        try {
            if (StringUtils.isEmpty(inputFilePath)) {
                LOG.info("输入文件地址为空，转换终止!");
                return null;
            }

            File inputFile = new File(inputFilePath);
            // 转换后的文件路径
            String outputFilePath_end = getOutputFilePath(inputFilePath);

            if (!inputFile.exists()) {
                LOG.info("输入文件不存在，转换终止!");
                return null;
            }

            // 获取OpenOffice的安装路劲
            officeManager = getOfficeManager();
            // 连接OpenOffice
            OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);

            return converterFile(inputFile, outputFilePath_end, inputFilePath, converter);
        } catch (Exception e) {
            LOG.error("转化出错!", e);
        } finally {
            // 停止openOffice
            if (officeManager != null) {
                officeManager.stop();
            }
        }
        return null;
    }

    /**
     * 获取输出文件
     *
     * @param inputFilePath
     * @return
     */
    public static String getOutputFilePath(String inputFilePath) {
        String outputFilePath = inputFilePath.replaceAll("." + getPostfix(inputFilePath), ".pdf");
        return outputFilePath;
    }

    /**
     * 获取inputFilePath的后缀名，如："e:/test.pptx"的后缀名为："pptx"<br>
     *
     * @param inputFilePath
     * @return
     */
    public static String getPostfix(String inputFilePath) {
        return inputFilePath.substring(inputFilePath.lastIndexOf(".") + 1);
    }

    
    public static void main(String[] args) {
    	String inputFile="D:\\Javanew闈㈣瘯瀹濆吀2012鐗�.doc";
    	String pdfFilePath="D:\\Javanew闈㈣瘯瀹濆吀2012鐗�.pdf";
		//OfficeToPdf.getOffice2PdfUtil().office2Pdf(inputFile, pdfFilePath);
	}
}  