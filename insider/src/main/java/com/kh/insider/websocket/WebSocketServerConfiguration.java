package com.kh.insider.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocket
public class WebSocketServerConfiguration implements WebSocketConfigurer {

	@Autowired
	private ChannelWebSocketServer channelWebSocketServer;
	@Autowired
	private AdminReportWebSocketServer adminReportWebSocketServer;
	
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
		registry.addHandler(channelWebSocketServer, "/ws/channel")
				.addInterceptors(new HttpSessionHandshakeInterceptor())
				.withSockJS();
		
		
		//관리자 서버 웹소켓
		registry.addHandler(adminReportWebSocketServer, "/ws/admin/report")
				.addInterceptors(new HttpSessionHandshakeInterceptor())
				.withSockJS();
		
	}

}
