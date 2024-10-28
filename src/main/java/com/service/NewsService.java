package com.service;

import com.model.News;
import com.vo.NewsVo;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/18-17:00
 */
public interface NewsService {
    int addNews(NewsVo newsVo);

    List<News> search(NewsVo newsVo);

    int deleteNews(int id);

    int deleteBatchNews(Integer[] ids);

    int editNews(News news);

    News loadNewsById(Integer id);
}
