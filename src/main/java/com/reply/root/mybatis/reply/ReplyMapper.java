package com.reply.root.mybatis.reply;

import java.util.List;
import java.util.Map;

import com.reply.root.reply.dto.ReplyDTO;

public interface ReplyMapper {
	public void addReply(ReplyDTO dto); //댓글 등록(시퀀스=id)
	public void addReply2(ReplyDTO dto); //대댓글 등록(댓글id=id)
	
	public List<ReplyDTO> getRepList();
	
	public void removeReply(Object map); //대댓글만 삭제
	public void removeAllRep(Map<String, Object> map); //댓글 + 연관된 대댓글 전부
}
