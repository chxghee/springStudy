package kr.bit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.repository.BoardRepository;


@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardRepository boardRepository;
	
	@Override
	public List<Board> getList() {
		List<Board> list=boardRepository.findAll();
		return list;
	}

	@Override
	public void register(Board vo) {
		boardRepository.save(vo);
	}

	@Override
	public Board get(Long idx) {


		Optional<Board> vo =  boardRepository.findById(idx);
		
		
		return vo.get();	// optional 이기 때문에 get으로 값 빼기 
	}

	@Override
	public void delete(Long idx) {
		boardRepository.deleteById(idx);
		
	}

	@Override
	public void update(Board vo) {
		
		boardRepository.save(vo);	// save가 인덱스값이 vo에 없으면  insert / 있으면  update

		
	}

}
