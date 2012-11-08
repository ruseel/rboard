rBoard
======

Rails에서 사용가능한 Engine 형태의 소규모 board 시스템을 목표로 한다. 

다양한 gem을 사용해서 최소한으로 사이트 오픈에 적당한 형태의
관리자만 입력가능 한 공지사항, 익명의 사용자가 개선사항을 입력할 수 있는 게시판을 
Mount해서 사용할 수 있게 만든다. 

authorization, authentication은 railscasts.com의 authorization from scratch를 
사용한다. 

rspec은 사용하지 않고 integration\_test, model\_test를 사용하되
최소한으로 유지하고 이 테스트가 통과하면 서비스에 문제가 없는 수준을 
유지한다. 

jasmine, cucumber 등을 사용하지 않는다. 

ToDo
====

새로운 board 생성하기 
board에 새글 쓰기
1차 답글 쓰기 
2차 답글 쓰기
1-1-1에서 중간 글 삭제하기 

댓글 쓰기 
댓글 쓰기 (댓글에는 depth가 없도록 한다)

board 관리 페이지 
board 삭제하기 

authentication
authorization

Engine형태로 변경하기 


