<%--
  Created by IntelliJ IDEA.
  User: 番茄桑
  Date: 2015/8/20
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
    <title>财务结算-出账核对</title>
    <script src="${ctx}/js/common/form.js" type="text/javascript"></script>
    <script src="${ctx}/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="${ctx}/js/api/comm.js" type="text/javascript"></script>
    <link href="${ctx}/css/finance/finance.css" rel="stylesheet">
    <script src="${ctx}/js/finance/out_detail.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ctx = '${ctx}';
    </script>
</head>
<body>
<div class="container-right">
    <form id="mainForm" action="${ctx}/finance/out/detail" method="post">
        <input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo}"/>
        <input type="hidden" name="innId" value="${innId}"/>
        <input type="hidden" name="channelId" value="${channelId}"/>
        <input type="hidden" name="settlementTime" value="${settlementTime}"/>
        <input type="hidden" name="channelOrderNo" value="${channelOrderNo}"/>
        <input type="hidden" name="auditStatus" value="${auditStatus}"/>
        <input type="hidden" name="priceStrategy" value="${priceStrategy}"/>
        <input type="hidden" name="isArrival" value="${isArrival}"/>
    </form>
    <div class="header">
        <%@ include file="../navigation.jsp" %>
        <div style="left: 550px;top: 12px" class="header-button-box duizhang kc">
            <div class="search-box">
                <input type="text" id="channelOrderNo" maxlength="20" class="search" placeholder="模糊搜索订单号" value="${channelOrderNo}"/>
                <input type="button" id="search_submit" class="search-button">
            </div>
            账期 : <em style="color: red;font-size: 16px;font-weight: bold;">${settlementTime}</em>
        </div>
        <div class="header-button-box">
            <a class="green-button-return add" href="${ctx}/finance/out/channel/detail?settlementTime=${settlementTime}&innId=${innId}">返回</a>
            
            

            <a class="red-button-add add" href="javascript:exportOut()">导出Excel</a>

            <form id="exportForm" action="${ctx}/finance/export/out" method="post">
                <input type="hidden" name="exportSettlementTime" value="${settlementTime}"/>
                <input type="hidden" name="exportInnId" value="${innId}"/>
            </form>
        </div>
    </div>

    <div class="header-sub-tab">
        <a href="${ctx}/finance/out/list?settlementTime=${settlementTime}&status=normal"
           <c:if test="${status=='normal'}">class="active" </c:if>>正常账单</a>
        <a href="${ctx}/finance/out/special/list?settlementTime=${settlementTime}&status=special"
           <c:if test="${status=='special'}">class="active" </c:if> >特殊结算</a>
        <a href="${ctx}/finance/out/delay/list?settlementTime=${settlementTime}&status=delay"
           <c:if test="${status=='delay'}">class="active" </c:if> >延期结算</a>
        <a href="${ctx}/finance/out/arrears?settlementTime=${settlementTime}&arrearsStatus=1&status=arrears"
           <c:if test="${status=='arrears'}">class="active" </c:if>>挂账</a>
    </div>
    <table class="kz-table" cellpadding="8">
        <thead>
        <tr>

            <th>
                价格模式
            </th>
            <th>分销商订单号</th>
            <th>OMS订单号</th>
            <th>预订人</th>
            <th>手机号码</th>
            <th>房型</th>
            <th>入住-退房日期</th>
            <th>
                客栈订单金额
            </th>
            <th>
               番茄总调价
            </th>
            <th>分销商订单金额</th>
            <th>分销商<br/>结算金额</th>
            <th>番茄<br/>收入金额</th>
            <th>客栈<br/>结算金额</th>
            <th>产生周期</th>
        </tr>
        </thead>
        <c:forEach items="${page.result}" var="order">
            <tr>

                <td>${order.innerOrderMode}</td>
                <td>${order.channelOrderNo}</td>
                <td>${order.orderNo}</td>
                <td>${order.userName}</td>
                <td>${order.contact}</td>
                <td>${order.channelRoomTypeName}</td>
                <td>${order.checkDate}</td>
                <td>${order.innAmount}</td>
                <td>${order.extraPrice}</td>
                <td>${order.totalAmount}</td>
                <td>${order.channelSettlementAmount}</td>
                <td>${order.fqSettlementAmount}</td>
                <td>${order.innSettlementAmount}</td>
                <td>${order.produceTime}</td>
            </tr>
        </c:forEach>
    </table>
    <p>
        <c:if test="${not empty innOrderCount and innOrderCount.orders !=0}">
            截止您所选时间段内，共有<em style="color:red;">${innOrderCount.orders}</em>个订单，客栈订单总金额为<em style="color:red;">${innOrderCount.ia}</em>，分销商订单总金额为<em style="color:red;">${innOrderCount.ta}</em>，分销商结算金额为<em style="color:red;">${innOrderCount.channels}</em>，番茄收入金额为<em
            style="color:red;">${innOrderCount.fqs}</em>，客栈结算金额为<em style="color:red;">${innOrderCount.inns}</em>；
        </c:if>
    </p>
    <c:if test="${not empty page}">
        <tags:pagination page="${page}" paginationSize="15"/>
    </c:if>
</div>
</body>
</html>