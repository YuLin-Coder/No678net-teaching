package com.controller;


import com.model.Menu;
import com.vo.MenuVo;
import com.model.User;
import com.service.MenuService;
import com.utils.SysConstast;
import com.utils.TreeNode;
import com.utils.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 菜单管理控制器
 */
@RestController
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping("/loadIndexleftMenuJson")
    public Map loadIndexLeftMenuJson(MenuVo menuVo){
        Map map = new HashMap();
        Map map1 = new HashMap();
        Map map2 = new HashMap();
        //得到当前登陆的用户对象
        User user =(User) WebUtils.getHttpSession().getAttribute("currentUser");
        //System.out.println(user.getUsername());
        List<Menu> list = null;
        menuVo.setAvailable(SysConstast.AVAILABLE_TRUE);//只查询可用的
        if(user.getRole()==SysConstast.USER_TYPE_SUPER){//是超级管理员
            list = this.menuService.queryAllMenuForList(null);
        }else {
            list = this.menuService.queryMenuByUserIdForList(menuVo,user.getId());
        }

        List<TreeNode> nodes = new ArrayList<>();

        //把list里面的数据放到nodes中
        for (Menu menu: list) {
            Integer id = menu.getId();
            Integer pid = menu.getPid();
            String title = menu.getTitle();
            String icon = menu.getIcon();
            String href = menu.getHref();
            Boolean spread = menu.getSpread()==SysConstast.SPREAD_TRUE?true:false;
            String target = menu.getTarget();
            nodes.add(new TreeNode(id,pid,title,icon,href,spread,target));
        }
        List<TreeNode> list1 = TreeNodeBuilder.builder(nodes, 1);
        map.put("title","常规管理");
        map.put("icon","fa fa-address-book");
        map.put("child",list1);
        map1.put("currency",map);
        map2.put("menuInfo",map1);
        return map2;
    }

//    /**"currency": {
//      "title": "常规管理",
//      "icon": "fa fa-address-book",
//      "child": [
//     * 加载菜单左边的菜单树
//     * @param menuVo
//     * @return
//     */
//    @RequestMapping("loadMenuManagerLeftTreeJson")
//    public DataGridView loadMenuManagerLeftTreeJson(MenuVo menuVo){
//        menuVo.setAvailable(SysConstast.AVAILABLE_TRUE);//只查询可用的
//        List<Menu> list = this.menuService.queryAllMenuForList(menuVo);
//        List<TreeNode> nodes = new ArrayList<>();
//        //把list里面的数据放到nodes
//        for (Menu menu : list){
//            Integer id = menu.getId();
//            Integer pid = menu.getPid();
//            String title = menu.getTitle();
//            String icon = menu.getIcon();
//            String href = menu.getHref();
//            Boolean spread = menu.getSpread()==SysConstast.SPREAD_TRUE?true:false;
//            String target = menu.getTarget();
//            nodes.add(new TreeNode(id,pid,title,icon,href,spread,target));
//        }
//        return new DataGridView(nodes);
//    }
//
//    /**
//     * 加载菜单列表返回DataGridView
//     * @param menuVo
//     * @return
//     */
//    @RequestMapping("loadAllMenu")
//    public DataGridView loadAllMenu(MenuVo menuVo){
//        return this.menuService.queryAllMenu(menuVo);
//    }
//
//    /**
//     * 添加菜单
//     * @param menuVo
//     * @return
//     */
//    @RequestMapping("addMenu")
//    public ResultObj addMenu(MenuVo menuVo){
//        try{
//            System.out.println(menuVo);
//            this.menuService.addMenu(menuVo);
//            return ResultObj.ADD_SUCCESS;
//        }catch (Exception e){
//            e.printStackTrace();
//            return ResultObj.ADD_ERROR;
//        }
//    }
//
//    /**
//     * 修改菜单
//     * @param menuVo
//     * @return
//     */
//    @RequestMapping("updateMenu")
//    public ResultObj updateMenu(MenuVo menuVo){
//        try{
//            this.menuService.updateMenu(menuVo);
//            return ResultObj.UPDATE_SUCCESS;
//        }catch (Exception e){
//            e.printStackTrace();
//            return ResultObj.UPDATE_ERROR;
//        }
//    }
//
//    /**
//     * 根据id判断当前菜单有没有子节点
//     * 有 返回code>=0
//     * 没有 返回code<0
//     * @param menuVo
//     * @return
//     */
//    @RequestMapping("checkMenuHasChildren")
//    public ResultObj checkMenuHasChildren(MenuVo menuVo){
//        //根据pid查询菜单数量
//        Integer count = this.menuService.queryMenuByPid(menuVo.getId());
//        System.out.println(count);
//        if (count>0){
//            return ResultObj.STATUS_TRUE;
//        }else{
//            return ResultObj.STATUS_FALSE;
//        }
//    }
//
//    /**
//     * 删除菜单
//     * @param menuVo
//     * @return
//     */
//    @RequestMapping("deleteMenu")
//    public ResultObj deleteMenu(MenuVo menuVo){
//        try{
//            this.menuService.deleteMenu(menuVo);
//            return ResultObj.DELETE_SUCCESS;
//        }catch (Exception e){
//            e.printStackTrace();
//            return ResultObj.DELETE_ERROR;
//        }
//    }

}
