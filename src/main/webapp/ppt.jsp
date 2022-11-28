<%@page import="net.sf.jasperreports.export.SimpleOutputStreamExporterOutput"%>
<%@page import="net.sf.jasperreports.export.SimpleExporterInput"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="javax.management.remote.JMXServerErrorException"%>
<%@page import="java.io.File"%>
<%@page import="net.sf.jasperreports.engine.export.ooxml.JRPptxExporter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import= "net.sf.jasperreports.engine.DefaultJasperReportsContext" %>
<%@page import= "net.sf.jasperreports.*" %>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/css/bootstrap.css">
</head>
<body>

<%
//String templatePath = "D:\\workspace\\BBS_test_backup\\src\\main\\webapp\\WEB-INF\\reports\\sample_bbs.jrxml";
	String templatePath = "D:\\workspace\\sample\\sample_bbs.jrxml";
	//String templatePath2 = "D:\\workspace\\sample\\sample_bbs.jasper";
	//String templatePath = "D:\\workspace\\BBS_test_backup\\src\\main\\webapp\\WEB-INF\\reports\\sample_bbs.jrxml";
	// 출력할 PDF 파일 경로
	//String destPath = "C:\\1.pptx";
	

	Connection conn = null;
	
	try {
	 // (1)템플레이트 XML 컴파일 (여기가 안됨!) => 이게 결국 .jasper를 불러오기 위함!! (jrxml을 컴파일 한 것이 jasper)
	 //JasperReport jasperReport = JasperCompileManager.compileReport(templatePath);
	 JasperReport jasperReport = JasperCompileManager.compileReport(templatePath);
	
	 // (2)파라메타 생성	  
	 Map<String,Object> paramMap = new HashMap<String,Object>();
	
	 paramMap.put("deadLine","2022-11-14");	  
	
	 // (3)데이타소스 생성
	 Class.forName("org.mariadb.jdbc.Driver");
	 conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bbs", "root","7471350");
	
	 // (4)데이타의 동적 바인드
	 JasperPrint print = JasperFillManager.fillReport(jasperReport, paramMap, conn);
	
	 // (5) Ppt로 출력
	 //JasperExportManager.exportReportToPdfFile(print, destPath);	
	
	 JRPptxExporter pptxExporter = new JRPptxExporter();
	 pptxExporter.setExporterInput(new SimpleExporterInput(print));
	 pptxExporter.setExporterOutput(new SimpleOutputStreamExporterOutput(new File("C:\\1.pptx")));
	 pptxExporter.exportReport();
     
	} catch (Exception ex) {
	     ex.printStackTrace();
	
	}
%>

</body>
</html>