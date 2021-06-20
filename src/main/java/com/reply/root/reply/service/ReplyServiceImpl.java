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
		
		if(map.get("group_id")==null) {
			dto.setContent((String)map.get("content"));
			dto.setLayer(0);
			mapper.addReply(dto);
		}else {
			dto.setContent((String)map.get("content"));
			dto.setLayer(1);
			dto.setId(Integer.parseInt((String)(map.get("group_id"))));
			mapper.addReply2(dto);
		}
		
	}

	@Override
	public List<ReplyDTO> getRepList() {
		return mapper.getRepList();
	}

	@Override
	public void removeReply(Map<String, Object> map) {
		//System.out.println(map.get("layer"));
		
		if((int)map.get("layer") == 1) { //layer 1 == 자식 댓글(대댓글)
			mapper.removeReply(map);
		} else if((int)map.get("layer") == 0){ //layer 0 == 부모 댓글
			mapper.removeAllRep(map);
		}
	}
}
