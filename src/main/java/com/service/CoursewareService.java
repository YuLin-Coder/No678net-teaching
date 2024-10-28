package com.service;

import com.model.Courseware;

import java.util.List;

/**
 * @author 丹青
 * @date 2020/7/29-21:19
 */
public interface CoursewareService {
    List<Courseware> search(int number);

    int addCourseware(Courseware courseware);

    int edit(Courseware courseware);

    int del(int id);

    List<Courseware> searchForM();

    int editForM(Courseware courseware);
}
