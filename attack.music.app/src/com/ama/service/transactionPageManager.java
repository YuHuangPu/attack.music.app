package com.ama.service;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.tools.ant.util.DateUtils;

import com.ama.common.Keys;
import com.ama.common.box.Element;
import com.ama.common.box.Input;
import com.ama.common.box.Label;
import com.ama.common.box.SearchMenu;
import com.ama.factory.SqlFactory;
import com.ama.language.LanguageView;
import com.ama.view.Views;
import com.opensymphony.xwork2.ActionContext;
import com.util.DatesUtil;
import com.util.SessionUtil;
import com.util.StringsUtil;

import ora.json.JSONArray;
import ora.json.JSONObject;

public class transactionPageManager extends com.ama.common.BaseManager {
    public String execute() throws Exception {
        HttpServletRequest req;
        try {
            this.setConn(com.util.DataBaseUtil.getConnection(Keys.COMPANY_JNDI_NAME, Boolean.TRUE));
            req = (HttpServletRequest)ServletActionContext.getRequest();
            setSearchMenu(req);
            JSONObject accountMap = this.getAccountMap();
            JSONObject goodsMap = this.getGoodsMap();
            JSONObject consumerMap = this.getConsumerMap();
            LanguageView lgView = this.getLgView();

            Timestamp sDate = DatesUtil.StringToTimestamp(StringsUtil.eliminateNull(req.getAttribute("sDate")));
            Timestamp eDate = new Timestamp(DatesUtil
                .todayLastTime(DatesUtil.StringToTimestamp(StringsUtil.eliminateNull(req.getAttribute("eDate"))))
                .getTime());
            String sql = "SELECT * FROM (" + "SELECT gd.SELL_DATE , gd.CONSUMER_ID, gd.STATUS, SUM(gd.PRICE) AS PRICE,"
                + "COUNT(*) AS COUNT, SUM(gd.AMOUNT) AS AMOUNT, SUM(gd.PRICE - (g.cost)*gd.AMOUNT) as GP "
                + "FROM GOODS_DETAIL gd, GOODS g WHERE gd.goods_id = g.id and gd.STATUS != 'N' and gd.sell_date BETWEEN ? and ? "
                + "GROUP BY gd.STATUS, gd.CONSUMER_ID, gd.SELL_DATE ORDER BY gd.SELL_DATE DESC" + ") A";
            Views Query = new Views(sql, this.getConn());
            Query.setPstmt(sDate, eDate);
            JSONArray dgInfoSplitByDayList = Query.getDatalistJSONArray(Boolean.FALSE);
            JSONArray dayKey = new JSONArray();
            JSONObject dayMap = new JSONObject();
            Iterator<Object> itrs = dgInfoSplitByDayList.iterator();
            JSONObject titleText = new JSONObject();
            while (itrs.hasNext()) {
                JSONObject itr = (JSONObject)itrs.next();
                String status = itr.getString("Status").equals("I")
                    ? (lgView.getId("020") + "/" + consumerMap.getString(itr.getString("ConsumerId")))
                    : (lgView.getId("014") + "/" + consumerMap.getString(itr.getString("ConsumerId")));
                String text = String.format(lgView.getId("051"), itr.getInt("Count"), itr.getInt("Amount"),
                    itr.getBigDecimal("Price").intValue(),
                    itr.getBigDecimal("Gp").intValue());
                if(itr.getBigDecimal("Gp").intValue() != 0) {
                    String k = consumerMap.getString(itr.getString("ConsumerId"));
                    int sum = titleText.has(k) ? titleText.getInt(k) + itr.getBigDecimal("Gp").intValue() : itr.getBigDecimal("Gp").intValue();
                    titleText.put( k, sum);
                }
                dayMap.put(itr.getString("SellDate") + " - " + itr.getString("ConsumerId"), new JSONObject()
                    .put("description", itr.put("Status", status).put("text", text)).put("detail", new JSONArray()));
                dayKey.put(itr.getString("SellDate") + " - " + itr.getString("ConsumerId"));
            }
            sql = "SELECT gd.*" + "    , DATE_FORMAT(gd.CREATE_DATE,'%Y-%m-%d') as \"Create_DATE\" "
                + "FROM GOODS_DETAIL gd WHERE  gd.sell_date BETWEEN ? and ?  and gd.STATUS in ('I', 'O')"
                + "ORDER BY gd.CREATE_DATE desc;";
            Views goodsDetail = new Views(sql, this.getConn());
            goodsDetail.setPstmt(sDate, eDate);
            JSONArray dgInfo = goodsDetail.getDatalistJSONArray(Boolean.FALSE);
            itrs = dgInfo.iterator();
            while (itrs.hasNext()) {
                JSONObject itr = (JSONObject)itrs.next();
                itr.put("CreateWho", accountMap.getString(itr.getString("CreateWho")));
                if (itr.getString("Status").equals("I")) {
                    itr.put("StatusText",
                        lgView.getId("020") + " / " + consumerMap.getString(itr.getString("ConsumerId")));
                } else {
                    itr.put("StatusText",
                        lgView.getId("014") + " / " + consumerMap.getString(itr.getString("ConsumerId")));
                }
                itr.put("GoodsName", goodsMap.getString(itr.getString("GoodsId")));
                itr.put("Status", itr.getString("Status").equals("I") ? "Purchase" : "Sell");
                dayMap.getJSONObject(itr.getString("SellDate") + " - " + itr.getString("ConsumerId"))
                    .getJSONArray("detail").put(itr);
            }

            Views maxUpdate = new Views(this.getConn(), Keys.View.GoodsDetailMaxUpdate);
            JSONArray mUpdate = maxUpdate.getDatalistJSONArray(Boolean.FALSE);

            Views vw = new Views(SqlFactory.getFactoryInfo(), this.getConn());
            JSONArray factory = vw.getDatalistJSONArray(Boolean.FALSE);
            itrs = factory.iterator();
            while (itrs.hasNext()) {
                JSONObject itr = (JSONObject)itrs.next();
                itr.put("Value", itr.getString("Id"));
                itr.put("Text", String.format("%s - %s", itr.getString("Id"), itr.getString("Name")));
            }

            JSONArray hasReserveGoods = new JSONArray();
            JSONArray RGs = new JSONArray();
            Views TransactionInfo = new Views(this.getConn(), Keys.View.TransactionInfo);
            RGs = TransactionInfo.getDatalistJSONArray(Boolean.FALSE);
            itrs = RGs.iterator();
            while (itrs.hasNext()) {
                JSONObject itr = (JSONObject)itrs.next();
                itr.put("Value", itr.getString("Id"));
                itr.put("Text", String.format("%s - %s - " + lgView.getId("013") + ":%s", itr.getString("Id"),
                    itr.getString("Name"), itr.getString("Reserve")));
                if (itr.getInt("Reserve") != 0) {
                    hasReserveGoods.put(itr);
                }
            }
            // RGs = new
            // JSONArray().put(RGs.getJSONObject(0)).put(RGs.getJSONObject(0)).put(RGs.getJSONObject(0)).put(RGs.getJSONObject(0));
            Views ConsumerInfo = new Views(this.getConn(), Keys.View.ConsumerInfo);
            JSONArray consumerByDayList = ConsumerInfo.getDatalistJSONArray(Boolean.FALSE);
            JSONArray consumer = new JSONArray();
            itrs = consumerByDayList.iterator();
            while (itrs.hasNext()) {
                JSONObject itr = (JSONObject)itrs.next();
                if (!itr.getString("Status").equals("D")) {
                    itr.put("Value", itr.getString("Id"));
                    itr.put("Text", String.format("%s - %s", itr.getString("Id"), itr.getString("Name")));
                    consumer.put(itr);
                } else {
                    itr.put("Value", itr.getString("Status"));
                    itr.put("Text", String.format("%s - %s", lgView.getId("020"), itr.getString("Name")));
                }
            }

            req.setAttribute("gdInfoKey", dayKey);
            req.setAttribute("gdInfoMap", dayMap);
            req.setAttribute("titleText", titleText);
            req.setAttribute("MaxUpdate", mUpdate.getJSONObject(0).getString("MaxUpdate"));
            

            req.setAttribute("factorys", factory);
            req.setAttribute("RGs", RGs);
            req.setAttribute("RGsStr", RGs.toString().replace("\"", "\\\"").replace("'", "\\'"));
            req.setAttribute("hasReserveGoods", hasReserveGoods);
            req.setAttribute("DayListConsumers", consumerByDayList);
            req.setAttribute("consumers", consumer);
            req.setAttribute("actionName", ActionContext.getContext().getName());

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            com.util.DataBaseUtil.closeConnection(this.getConn());
        }
        return Keys.WEB_SUCCESSFUL;
    }

    private void setSearchMenu(HttpServletRequest req) throws Exception {
        LanguageView lg = (LanguageView)req.getAttribute("lgView");
        Date[] dr = DatesUtil.getDateRangeByMonth(new Date());
        SearchMenu sm = new SearchMenu();
        String sDates = StringsUtil.eliminateNull(req.getParameter("sDate"), DatesUtil.DateFormat.format(dr[0]));
        String eDates = StringsUtil.eliminateNull(req.getParameter("eDate"), DatesUtil.DateFormat.format(dr[1]));
        Element sDate = new Input(new Label(lg.getId("037") + " : "), "form-control form-control-sm", "text", "sDate",
            sDates, DatesUtil.DateFormat.format(dr[0]));
        Element eDate = new Input(new Label("~"), "form-control form-control-sm", "text", "eDate", eDates,
            DatesUtil.DateFormat.format(dr[1]));

        req.setAttribute("sDate", sDates);
        req.setAttribute("eDate", eDates);

        sm.setElements(Arrays.asList(sDate, eDate));
        req.setAttribute("searchMenu", sm);
        return ;
    }
}
