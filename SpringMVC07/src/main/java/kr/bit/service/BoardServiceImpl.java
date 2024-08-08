package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.entity.Member;
import kr.bit.mapper.BoardMapper;

// 서비스 인터페이스의 구현 -> 클라이언트의 요청을 컨트롤러에서 하기에는 헤비할수있으니 서비스에서 비즈니스 로직을 구현하고 컨트롤러에 리턴
@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<Board> getList() {
		
		List<Board> list = boardMapper.getList();	// 게시물 리스트 가져오기 
		
		return list;
	}

	@Override
	public Member login(Member vo) {
		
		Member mvo = boardMapper.login(vo);
		return mvo;
	}

	@Override
	public void register(Board vo) {

		boardMapper.insertSelectKey(vo);
		
	}

	@Override
	public Board get(int idx) {

		Board mvo = boardMapper.read(idx);
		
		return mvo;
	}

	@Override
	public void modify(Board vo) {

		boardMapper.update(vo);
	}

	@Override
	public void remove(int idx) {

		boardMapper.delete(idx);
	}

	@Override
	public void replyProcess(Board vo) {

		// 1. 원글의 정보 가져오기( 현재 vo의 idx는 부모글의 idx )
		Board parent = boardMapper.read(vo.getIdx());
		
		// 2. 부모글의 boardGroupd의 값을 입력한 답글(vo) 정보에 저장하기 /  BoardSequence는 원글 + 1 / BoardLevel: 원글 + 1
		vo.setBoardGroup(parent.getBoardGroup());
		vo.setBoardSequence(parent.getBoardSequence() + 1);
		vo.setBoardLevel(parent.getBoardLevel() + 1);
		
		
		// 3. 기존에 저장된 같은  boardGroupd을 갖는 글 중 부모글의 BoardSequence보다 큰 값을 갖는 글들은 모두 +1 해서 update 주어야 한다
		boardMapper.replySeqUpdate(parent);
		
		// 4. 새로 만들어진 vo 답글을  저장하기
		boardMapper.replyInsert(vo);
		
		
		
	}

}
