package com.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import com.mapper.MenuMapper;
import com.model.Menu;
import com.model.MenuExample;
import com.vo.MenuVo;
import com.service.MenuService;
import com.utils.DataGridView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    /**
     * 查询所有菜单返回
     * @param menuVo
     * @return
     */
    @Override
    public List<Menu> queryAllMenuForList(MenuVo menuVo) {
        return menuMapper.selectByExample(null);
    }

    /**
     * @param menuVo
     * @param userId
     * @return
     */
    @Override
    public List<Menu> queryMenuByUserIdForList(MenuVo menuVo, Integer userId) {
        return menuMapper.queryMenuByUid(menuVo.getAvailable(),userId);
    }

    /**
     * 查询所有菜单列表
     * @param menuVo
     * @return
     */
    @Override
    public DataGridView queryAllMenu(MenuVo menuVo) {
        Page<Object> page = PageHelper.startPage(menuVo.getPage(),menuVo.getLimit());
        List<Menu> data = this.menuMapper.selectByExample(null);
        return new DataGridView(page.getTotal(),data);
    }

    /**
     * 添加菜单
     * @param menuVo
     */
    @Override
    public void addMenu(MenuVo menuVo) {
        this.menuMapper.insertSelective(menuVo);
    }

    /**
     * 更新菜单
     * @param menuVo
     */
    @Override
    public void updateMenu(MenuVo menuVo) {
        this.menuMapper.updateByPrimaryKeySelective(menuVo);
    }

    /**
     * 根据pid查询菜单数量
     * @param pid
     * @return
     */
    @Override
    public Integer queryMenuByPid(Integer pid) {
        MenuExample menuExample = new MenuExample();
        MenuExample.Criteria criteria = menuExample.createCriteria();
        criteria.andPidEqualTo(pid);
        List<Menu> menus = menuMapper.selectByExample(menuExample);
        int count = 0;
        for (Menu menu : menus) {
            count += 1;
        }
        return count;
    }

    /**
     * 删除菜单
     * @param menuVo
     */
    @Override
    public void deleteMenu(MenuVo menuVo) {
        //删除菜单表的数据
        this.menuMapper.deleteByPrimaryKey(menuVo.getId());
        //根据菜单id删除sys_role_menu里面的数据
        //this.menuMapper.deleteRoleMenuByMid(menuVo.getId());

    }
}
