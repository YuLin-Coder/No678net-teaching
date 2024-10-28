package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.model.Courseware;
import com.model.User;
import com.service.CoursewareService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.net.URLEncoder;
import java.util.*;

@Controller
@RequestMapping("/courseware")
public class CoursewareController {

    @Autowired
    CoursewareService coursewareService;

    /**
     * 转到老师备课界面
     * @return
     */
    @RequestMapping("/toCourseware")
    public String toCourseware(){
        return "teacher/courseware";
    }

    /**
     * 管理员管理老师备课课件
     * @return
     */
    @RequestMapping("/coursewareForM")
    public String coursewareForM(){
        return "courseware";
    }

    /**
     * 老师备课查询（用于老师自己）
     * @param limit
     * @param page
     * @return
     */
    @RequestMapping("getCourseware")
    @ResponseBody
    public Map getCourse(int limit, int page,HttpSession session) {
        Map map = new HashMap();
        User user = (User) session.getAttribute("currentUser");
        int number = user.getNumber();
        PageHelper.startPage(page, limit);
        List<Courseware> coursewareList = coursewareService.search(number);
        PageInfo pageInfo = new PageInfo(coursewareList, 5);
        map.put("count", pageInfo.getTotal());
        map.put("code", 0);
        map.put("data", coursewareList);
        return map;
    }

    @RequestMapping("getCoursewareForM")
    @ResponseBody
    public Map getCourseForM(int limit, int page,HttpSession session) {
        Map map = new HashMap();
        User user = (User) session.getAttribute("currentUser");
        PageHelper.startPage(page, limit);
        List<Courseware> coursewareList = coursewareService.searchForM();
        PageInfo pageInfo = new PageInfo(coursewareList, 5);
        map.put("count", pageInfo.getTotal());
        map.put("code", 0);
        map.put("data", coursewareList);
        return map;
    }

    /**
     * 执行文件上传
     */
    @RequestMapping("/fileUpload")
    public String handleFormUpload(@RequestParam("subject") String subject,
                                   @RequestParam("name") String name,
                                   @RequestParam("introduce") String introduce,
                                   @RequestParam("uploadfile") List<MultipartFile> uploadfile,
                                   HttpServletRequest request, HttpSession session) {
        // 判断所上传文件是否存在
        if (!uploadfile.isEmpty() && uploadfile.size() > 0) {
            int i =0 ;
            //循环输出上传的文件
            for (MultipartFile file : uploadfile) {
                // 获取上传文件的原始名称
                String originalFilename = file.getOriginalFilename();
                // 设置上传文件的保存地址目录
                String dirPath =
                        request.getServletContext().getRealPath("/upload/");
                File filePath = new File(dirPath);
                // 如果保存文件的地址不存在，就先创建目录
                if (!filePath.exists()) {
                    filePath.mkdirs();
                }
                // 使用UUID重新命名上传的文件名称(上传人_uuid_原始文件名称)
                String newFilename = name+ "_"+ UUID.randomUUID() +
                        "_"+originalFilename;
                try {
                    // 使用MultipartFile接口的方法完成文件上传到指定位置
                    file.transferTo(new File(dirPath + newFilename));
                } catch (Exception e) {
                    e.printStackTrace();
                    return"error";
                }
                User user = (User) session.getAttribute("currentUser");
                Courseware courseware = new Courseware();
                courseware.setTeacherName(user.getUsername());
                courseware.setNumber(user.getNumber());
                courseware.setName(name);
                courseware.setIntroduce(introduce);
                courseware.setAddress(newFilename);
                courseware.setSubject(subject);
                courseware.setTime(new Date());
                i =  coursewareService.addCourseware(courseware);
            }
            // 跳转到成功页面
            return "teacher/courseware";
        }else{
            return"error";
        }
    }

    /**
     * 下载
     * @param request
     * @param filename
     * @return
     * @throws Exception
     */
    @RequestMapping("/download")
    public ResponseEntity<byte[]> fileDownload(HttpServletRequest request,
                                               String filename) throws Exception{
        // 指定要下载的文件所在路径
        String path = request.getServletContext().getRealPath("/upload/");
        // 创建该文件对象
        File file = new File(path+File.separator+filename);
        // 对文件名编码，防止中文文件乱码
        filename = this.getFilename(request, filename);
        // 设置响应头
        HttpHeaders headers = new HttpHeaders();
        // 通知浏览器以下载的方式打开文件
        headers.setContentDispositionFormData("attachment", filename);
        // 定义以流的形式下载返回文件数据
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        // 使用Sring MVC框架的ResponseEntity对象封装返回下载数据
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.OK);
    }
    /**
     * 根据浏览器的不同进行编码设置，返回编码后的文件名
     */
    public String getFilename(HttpServletRequest request,
                              String filename) throws Exception {
        // IE不同版本User-Agent中出现的关键词
        String[] IEBrowserKeyWords = {"MSIE", "Trident", "Edge"};
        // 获取请求头代理信息
        String userAgent = request.getHeader("User-Agent");
        for (String keyWord : IEBrowserKeyWords) {
            if (userAgent.contains(keyWord)) {
                //IE内核浏览器，统一为UTF-8编码显示
                return URLEncoder.encode(filename, "UTF-8");
            }
        }
        //火狐等其它浏览器统一为ISO-8859-1编码显示
        return new String(filename.getBytes("UTF-8"), "ISO-8859-1");
    }

    /**
     * 修改（用于老师）
     * @param courseware
     * @return
     */
    @RequestMapping("editCourseware")
    @ResponseBody
    public Map getCourse(Courseware courseware) {
        Map map = new HashMap();
        int i = coursewareService.edit(courseware);
        if(i>0){
            map.put("msg","修改成功");
        }else {
            map.put("msg","修改失败");
        }
        return map;
    }

    /**
     * 管理员对教案添加评价
     * @param courseware
     * @param session
     * @return
     */
    @RequestMapping("editCoursewareForM")
    @ResponseBody
    public Map editCoursewareForM(Courseware courseware,HttpSession session) {
        Map map = new HashMap();
       User user = (User) session.getAttribute("currentUser");
        courseware.setOperator(user.getUsername());
        courseware.setEvTime(new Date());
        int i = coursewareService.editForM(courseware);
        if(i>0){
            map.put("msg","添加评论成功");
        }else {
            map.put("msg","修改失败");
        }
        return map;
    }

    /**
     * 删除教案（用于教师）
     * @param id
     * @return
     */
    @RequestMapping("delCourseware")
    @ResponseBody
    public Map delCourseware(Integer id) {
        Map map = new HashMap();
        int i = coursewareService.del(id);
        if(i>0){
            map.put("msg","修改成功");
        }else {
            map.put("msg","修改失败");
        }
        return map;
    }
}
