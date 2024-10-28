package com.controller;


import com.utils.TreeNode;

import java.util.ArrayList;
import java.util.List;

public class TreeNodeBuilder {

    public static List<TreeNode> builder(List<TreeNode> nodes, Integer topPid){
        List<TreeNode> treeNodes = new ArrayList<>();
        for (TreeNode n1 : nodes) {
            if (n1.getPid() == topPid){
                treeNodes.add(n1);
            }
            for (TreeNode n2 : nodes){
                if (n2.getPid() == n1.getId()){
                    n1.getChild().add(n2);
                }
            }
        }
        return treeNodes;
    }
}

