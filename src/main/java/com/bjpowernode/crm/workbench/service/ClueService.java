package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.domain.Tran;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface ClueService {
    List<User> getUserList();

    boolean saveClue(Clue clue);

    Clue getClueDetail(String id);


    boolean bund(String clueId, String[] activityId);


    boolean convert(String clueId, Tran t, String createBy);
}
