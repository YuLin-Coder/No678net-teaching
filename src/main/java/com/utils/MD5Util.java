package com.utils;

import com.github.pagehelper.util.StringUtil;

import java.security.MessageDigest;

/**
 * @author 丹青
 * @date 2019/12/11-15:33
 */
public class MD5Util {
    public static String digest16(String inStr) {
        return digest(inStr, 16);
    }

    public static String digest(String inStr) {
        return digest(inStr, 32);
    }

    private static String digest(String inStr, int rang) {
        MessageDigest md5 = null;
        if (StringUtil.isEmpty(inStr)) {
            return "";
        }
        try {
            md5 = MessageDigest.getInstance("MD5"); //取得算法
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
        char[] charArray = inStr.toCharArray();
        byte[] byteArray = new byte[charArray.length];
        for (int i = 0; i < charArray.length; i++) {
            byteArray[i] = (byte) charArray[i];
        }
        byte[] md5Bytes = md5.digest(byteArray); //加密
        StringBuilder hexValue = new StringBuilder();
        for (int i = 0; i < md5Bytes.length; i++) {
            int val = ((int) md5Bytes[i]) & 0xff;
            if (val < 16) hexValue.append("0");
            hexValue.append(Integer.toHexString(val));
        }
        if (rang == 32) {
            return hexValue.toString();
        } else {
            return hexValue.toString().substring(8, 24);//转换为32位字符串
        }
    }

    public static void main(String args[]) {
        String s = new String("123");
        System.out.println(digest(s));
    }
}


