package com.csranger.cms.mapper;

import com.csranger.cms.model.Userlogin;
import com.csranger.cms.model.UserloginExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserloginMapper {
    long countByExample(UserloginExample example);

    int deleteByExample(UserloginExample example);

    int deleteByPrimaryKey(Integer userId);

    int insert(Userlogin record);

    int insertSelective(Userlogin record);

    List<Userlogin> selectByExample(UserloginExample example);

    Userlogin selectByPrimaryKey(Integer userId);

    int updateByExampleSelective(@Param("record") Userlogin record, @Param("example") UserloginExample example);

    int updateByExample(@Param("record") Userlogin record, @Param("example") UserloginExample example);

    int updateByPrimaryKeySelective(Userlogin record);

    int updateByPrimaryKey(Userlogin record);
}