package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.model.News;
import com.vo.NewsVo;
import com.model.User;
import com.service.NewsService;
import com.utils.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 丹青
 * @date 2019/12/18-16:58
 */
@RequestMapping("/news")
@Controller
public class NewsController {
    @Autowired
    private NewsService newsService;

    @RequestMapping("/newsList")
    public String NewsList(){
        return "newsList";
    }

    @RequestMapping("/addNews")
    @ResponseBody
    public Map addNews(NewsVo newsVo){
        Map map = new HashMap();

        newsVo.setCreatetime(new Date());
        User user =(User) WebUtils.getHttpSession().getAttribute("currentUser");
        newsVo.setOpername(user.getUsername());
        int i = newsService.addNews(newsVo);
        if(i >= 1){
            map.put("message","生成【"+newsVo.getTitle()+"】公告成功");
        }else {
            map.put("message","生成失败");
        }
        return map;
    }

    /**
     * 公告的模糊查询
     * @return
     */
    @RequestMapping("getNews")
    @ResponseBody
    public Map getNews(NewsVo newsVo){
        Map map = new HashMap();
        PageHelper.startPage(newsVo.getPage(),newsVo.getLimit());
        List<News> newsList = newsService.search(newsVo);
        PageInfo pageInfo = new PageInfo(newsList,5);
        map.put("count",pageInfo.getTotal());
        map.put("code",0);
        map.put("msg","");
        map.put("data",newsList);
        return map;
    }

    @RequestMapping("/deleteNews")
    @ResponseBody
    public Map deleteNews(int id){
        Map map = new HashMap();
        int i = newsService.deleteNews(id);
        if (i>0) {
            map.put("message","成功删除编号为【"+id+"】的公告");
        }else{
            map.put("message","删除失败");
        }
        return map;
    }

    @RequestMapping("/deleteBatchNews")
    @ResponseBody
    public Map deleteBatchNews(Integer []ids){
        Map map = new HashMap();
        int count = newsService.deleteBatchNews(ids);
        if(count == ids.length){
            map.put("message","删除这些公告成功");
        }else {
            map.put("message","删除这些公告失败");
        }
        return map;
    }

    @ResponseBody
    @RequestMapping("/editNews")
    public Map editNews(News news){
        Map map = new HashMap();
        int i = newsService.editNews(news);
        if(i>0){
            map.put("message","修改标题为【"+news.getTitle()+"】的公告成功");
        }else {
            map.put("message","修改失败");
        }
        return map;
    }

    @RequestMapping("/loadNewsById")
    @ResponseBody
    public Map loadNewsById (Integer id){
        Map map = new HashMap();
        News news = newsService.loadNewsById(id);
        map.put("news",news);
        return map;
    }
}
