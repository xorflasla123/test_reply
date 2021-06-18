package com.reply.root.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.reply.root.reply.dto.ReplyDTO;
import com.reply.root.reply.service.ReplyService;

@RestController
public class ReplyController {
	@Autowired ReplyService rs;
	@PostMapping(value = "addReply", produces = "application/json; charset=utf-8")
	public void addReply(@RequestBody Map<String, Object> map) {
		rs.addReply(map);
	}
	@PostMapping(value = "addReply2", produces = "application/json; charset=utf-8")
	public void addReply2(@RequestBody Map<String, Object> map) {
		rs.addReply(map);
	}
	
	@PostMapping(value = "removeReply", produces = "application/json; charset=utf-8")
	public void removeReply(@RequestBody Map<String, Object> map) {
		rs.removeReply(map);
	}
	
	@GetMapping(value = "replyData", produces = "application/json; charset=utf-8")
	public List<ReplyDTO> replyData(){
		return rs.getRepList();
	}
	
	
}
