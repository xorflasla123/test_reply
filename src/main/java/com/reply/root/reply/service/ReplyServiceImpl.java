package com.reply.root.reply.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
