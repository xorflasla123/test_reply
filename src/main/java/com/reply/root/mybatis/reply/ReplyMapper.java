package com.reply.root.mybatis.reply;

import java.util.List;

import com.reply.root.reply.dto.ReplyDTO;

public interface ReplyMapper {
	public void addReply(ReplyDTO dto);
	public List<ReplyDTO> getRepList();
}
