package kr.board.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan(basePackages = {"kr.board.mapper"})				// 매퍼를 등록함 
@PropertySource({"classpath:persistence-mysql.properties"})	// DB연결 @Property속성들을 저장해 넣은 외부 파일참조 설정  

public class RootConfig {

	@Autowired						// 스프링 컨테이너에서 주입 받음 
	private Environment env;		// persistence-mysql.properties에 있는 것들을 참조하기 위해 Environment 클래스가 필요 
	
	
	// hikariConfig / HikariDataSource 객체 생성 
	@Bean		
	public DataSource myDataSource() {
		HikariConfig hikariConfig=new HikariConfig();			// persistence-mysql.properties 내용을 참조 하고 
		hikariConfig.setDriverClassName(env.getProperty("jdbc.driver"));		// getProperty 해서 
		hikariConfig.setJdbcUrl(env.getProperty("jdbc.url"));					// setDriver 로  넣기 
		hikariConfig.setUsername(env.getProperty("jdbc.user"));
		hikariConfig.setPassword(env.getProperty("jdbc.password"));
		
		HikariDataSource myDataSource=new HikariDataSource(hikariConfig);		// 데이터 소스를 만들어 리턴 
		return myDataSource;
	}
	
	// myDataSource를 이용해서 커넥션 풀을 만드는 과정 ( 마이바티스 SqlSessionFactory와 HikariDataSource를 연결하는 부분 )
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception{
	  SqlSessionFactoryBean sessionFactory=new SqlSessionFactoryBean();
	  
	  sessionFactory.setDataSource(myDataSource());		// sessionFactory에 setDataSource으로 데이터 소스받음 
	  return (SqlSessionFactory)sessionFactory.getObject();
	  	// SqlSessionFactory로 다운 캐스팅 getObject 로 sessionFactory를 넘겨준다 
	}
	
}
