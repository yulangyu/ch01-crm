package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.workbench.domain.Clue;

import java.util.List;

public interface ClueDao {


    List<User> getUserList();

    int saveClue(Clue clue);

    Clue getClueDetail(String id);

    Clue getById(String clueId);
}
