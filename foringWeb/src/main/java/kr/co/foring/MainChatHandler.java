package kr.co.foring;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


@RequestMapping("/mc")
public class MainChatHandler extends TextWebSocketHandler {
		// 세션 리스트
		private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
		
		private static Logger logger = LoggerFactory.getLogger(MainChatHandler.class);
		
		//클라이언트가 연결 되었을 때 실행
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception{
			logger.info("#ChattingHandler, afterConnectionEstablished");
			sessionList.add(session);
			
			logger.info("웹소켓 연결됨....................");
		}
		
		//클라이언트가 웹 소켓 서버로 메세지를 전송했을때 실행
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
			logger.info("#ChattingHandler, handleMessage");
			logger.info("message : " + message);
			logger.info("message.getPayload() : " + message.getPayload());
			logger.info("message.getPayload() : " + message.getPayload().toString());
			
//			JSONObject obj = jsonToObjectParser(message.getPayload());
//			logger.info("obj : " + obj);
			
			for(WebSocketSession s : sessionList) {
//				s.sendMessage(new TextMessage("message :" + message.getPayload()));
				s.sendMessage(new TextMessage(message.getPayload()));
			}
			logger.info("메세지 전송........................");
		}
		
		//클라이언트가 연결을 끊었을 때 실행
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
			logger.info("#ChattingHandler, afterConnectionClosed");

			sessionList.remove(session);
			
			logger.info("웹소켓 연결 끊김.....................");
		}
		
//		private static JSONObject jsonToObjectParser(String jsonStr) {
//			JSONParser parser = new JSONParser();
//			JSONObject obj = null;
//			try {
//				obj = (JSONObject) parser.parse(jsonStr);
//			} catch (ParseException e) {
//				e.printStackTrace();
//			}
//			return obj;
//		}
}
