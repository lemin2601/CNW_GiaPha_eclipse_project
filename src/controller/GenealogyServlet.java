package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Genealogy;
import model.People;
import net.sf.json.JSONObject;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/Genealogy"})
public class GenealogyServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //check login
//        if (request.getSession().getAttribute(UserController.USER_SESSION) == null) {
//            return;
//        }
        response.setContentType("text/html;charset=UTF-8");
        String command = request.getParameter("command");
        if (command.equals("")) {
            return;
        }
        switch (command) {
            case "create_genealogy":    // tạo mới một gia phả
                create(request, response);
                break;
            case "edit_genealogy":  //cập nhật thông tin gia phả
                edit(request, response);
                break;
            case "delete_genealogy":    // xóa một gia phả
                delete(request, response);
                break;
            case "get_list":    // lấy danh sách gia phả của user
                //response.getWriter().print("get list nè");
                getList(request, response);
                break;
            case "get_list_people": //lấy thông tin people trong gia phả
                getListPeopleByName(request, response);
                break;
            case "get_data_view_grid":  // lấy data hiển thị grid gia phả
                getDataViewGrid(request, response);
                break;
        }
        //processRequest(request, response);
    }

    private ArrayList<People> getChildFromIdFather(long id_husband) {
        if (id_husband <= 0) {
            return null;
        }
        ArrayList<People> list = new ArrayList<>();
        People itemRoot = new People(0, "contrai", "last", "alias", new Date(), null, true, "address", 0, "../img/profile.jpg");
        list.add(itemRoot);
        itemRoot = new People(2, "congai", "last", "alias", new Date(), null, true, "address", 2, "../img/profile.jpg");
        list.add(itemRoot);
        return list;
    }

    private ArrayList<People> getHusbandWifeFromIdFather(long id_husband) {
        if (id_husband <= 0) {
            return null;
        }
        ArrayList<People> list = new ArrayList<>();
        People itemRoot = new People(id_husband, ""+id_husband, "last", "alias", new Date(), null, true, "address", 0, "../img/profile.jpg");
        list.add(itemRoot);
        itemRoot = new People(id_husband + 1, "Mẹ", "last", "alias", new Date(), null, true, "address", 2, "../img/profile.jpg");
        list.add(itemRoot);
        return list;
    }

    private JSONObject getJSonFromList(ArrayList<People> list) {
        JSONObject dataJSon = new JSONObject();
        if (list.size() <= 0) {
            return null;
        }
        list.forEach((item) -> {
            JSONObject jObj = new JSONObject();
            jObj.put("id", item.getId());
            jObj.put("firstname", item.getFirstname());
            jObj.put("lastname", item.getLastname());
            dataJSon.put(item.getId(), jObj);
        });
        JSONObject dataResult = new JSONObject();
        dataResult.put("item",dataJSon);
        System.out.println(list.size() +"|"+dataResult.toString());
        return dataResult;
    }

    private JSONObject getJSONDataFamily(int numOfDeep, long id_husband) {
        JSONObject dataJSon = new JSONObject();
        if (numOfDeep <= 0) {
            return dataJSon;
        }
        numOfDeep -= 1;
        //get cha hiện tại và các người vợ
        ArrayList<People> fathers = getHusbandWifeFromIdFather(numOfDeep);
        if(fathers == null) return null;
        
        dataJSon.put("cha", getJSonFromList(fathers));
        //get các con của người hiện tại
        ArrayList<People> childs = getChildFromIdFather(numOfDeep);
        if (childs == null) {
            return null;
        } else {
            JSONObject dataChild = new JSONObject();
            for (int i = 0;i<childs.size();i++) {
                dataChild.put(i, getJSONDataFamily(numOfDeep, childs.get(i).getId()));
            }
            dataJSon.put("con", dataChild);
        }
        return dataJSon;
    }

    private void getDataViewGrid(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = "", id_people = "", deep = "";
        id = request.getParameter("id");
        id_people = request.getParameter("id_people");
        deep = request.getParameter("deep");

        //lấy dữ liệu data base
        JSONObject dataViewGrid = new JSONObject();
        //Lấy Json cho thông tin gia phả
        Genealogy genealogy = new Genealogy(System.currentTimeMillis(), "Trần Tộc", "Đây là gia phả trần tộc");
        JSONObject dataGenealogy = new JSONObject();
        dataGenealogy.put("id", genealogy.getId());
        dataGenealogy.put("name", genealogy.getName());
        dataGenealogy.put("description", genealogy.getDescription());
        dataViewGrid.put("genealogy", dataGenealogy);
        // lay json cho thông tin people
        JSONObject datapeople = getJSONDataFamily(6, 0);
        dataViewGrid.put("people", datapeople);
        response.getWriter().write(dataViewGrid.toString());
    }

    private void getListPeopleByName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = "";
        id = request.getParameter("id");

        ArrayList<People> lists = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            People item = new People();
            item.setId(i);
            item.setFirstname("trần");
            item.setLastname("Thanh" + id);
            lists.add(item);
        }
        JSONObject data = new JSONObject();
        for (People item : lists) {
            JSONObject jObj = new JSONObject();
            jObj.put("id", item.getId());
            jObj.put("firstname", item.getFirstname());
            jObj.put("lastname", item.getLastname());
            data.put(item.getId(), jObj);
        }
        response.getWriter().write(data.toString());
    }

    private void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Genealogy> genealogys = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            genealogys.add(new Genealogy(i, "name" + i, "mo ta" + i));
        }
        JSONObject data = new JSONObject();
        for (Genealogy item : genealogys) {
            JSONObject jObj = new JSONObject();
            jObj.put("id", item.getId());
            jObj.put("name", item.getName());
            data.put(item.getId(), jObj);
        }
        response.getWriter().write(data.toString());
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = "", des = "";
        name = request.getParameter("name");
        des = request.getParameter("description");
        //{response.getWriter().print(name+"|"+des); return;}
        // kiếm tra 
        if (name.equals("")) {
            response.getWriter().print("name");
            return;
        }
        //insert data
        response.getWriter()
                .print("success");
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = "", des = "", id = "";
        name = request.getParameter("name");
        des = request.getParameter("description");
        id = request.getParameter("id");
        //{response.getWriter().print(name+"|"+des+"|"+id); return;}
        // kiếm tra 
        if (name.equals("")) {
            response.getWriter().print("name");
            return;
        }
        //insert data
        if (true) {
            response.getWriter()
                    .print("success");

        } else {
            response.getWriter()
                    .print("failed");
        }

    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.getWriter().print("success");
    }

    public static void main(String[] args) {
//        ArrayList<Genealogy> genealogys = new ArrayList<>();
//        for (int i = 0; i < 10; i++) {
//            genealogys.add(new Genealogy(i, "name" + i, "mo ta" + i));
//        }
//
//        JSONObject data = new JSONObject();
//        for (Genealogy item : genealogys) {
//            JSONObject jObj = new JSONObject();
//            jObj.put("id", item.getId());
//            jObj.put("name", item.getName());
//            data.put(item.getId(), jObj);
//        }
//        System.out.println(data.toString());

//        ArrayList<Genealogy> genealogys = new ArrayList<>();
//        for (int i = 0; i < 10; i++) {
//            genealogys.add(new Genealogy(i, "name" + i, "mo ta" + i));
//        }
//        JSONObject data = new JSONObject();
//        for (Genealogy item : genealogys) {
//            JSONObject jObj = new JSONObject();
//            jObj.put("id", item.getId());
//            jObj.put("name", item.getName());
//            data.put(item.getId(), jObj);
//        }
//        System.out.println(data.toString());
        System.out.println(new GenealogyServlet().getJSONDataFamily(3, 0).toString());
    }
}
