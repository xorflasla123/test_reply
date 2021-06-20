create table board_comment_test1(
  comment_content VARCHAR2(100) not null,
  comment_id NUMBER not null PRIMARY KEY,
  comment_layer NUMBER not null,
  comment_date date default sysdate
);

create sequence reply_seq;