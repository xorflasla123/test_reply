package com.reply.root.reply.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.reply.root.mybatis.reply.ReplyMapper;
import com.reply.root.reply.dto.ReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired ReplyMapper mapper;

	@Override
	public void addReply(Map<String, Object> map) {
		ReplyDTO dto = new ReplyDTO();
		int num = 0;
		
		dto.setContent((String)map.get("content"));
		dto.setLayer(num);
		mapper.addReply(dto);
	}

	@Override
	public List<ReplyDTO> getRepList() {
		return mapper.getRepList();
	}

	@Override
	public void removeReply(Object map) {
//		ObjectMapper mapp = new ObjectMapper();
//		
//		mapp.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
//		//파라미터Map에서 DTO에 들어있지 않는 변수가 있어도 무시함.
//		
//		ReplyDTO dto = mapp.convertValue(map.get("ReplyDTO"), ReplyDTO.class);
		mapper.removeReply(map);
	}

	@Override
	public Map<String, Object> insertData(Map<String, Object> params) throws Exception {
		
		return null;
	}
}
