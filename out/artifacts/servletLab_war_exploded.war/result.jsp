<%--
  Created by IntelliJ IDEA.
  User: andrei
  Date: 10.12.2019
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<jsp:useBean id="historyBean" scope="application" class="beans.ResultBean"/>
<html>
<head>
    <title>Title</title>

    <link href="styles/main.css" type="text/css" rel="stylesheet">
</head>
<body>
    <jsp:setProperty name="historyBean" property="currentPoint" value="${sessionScope.answer}"/>
      <div id="message">
        <table border="1" cellpadding="5">
          <tr>
            <th>X</th>
            <th>Y</th>
            <th>R</th>
            <th>Result</th>
          </tr>
          <c:forEach items="${historyBean.history}" var="element" varStatus="status">
            <tr>
              <td>${element.x}</td>
              <td>${element.y}</td>
              <td>${element.r}</td>
              <td>${element.result}</td>
            </tr>
          </c:forEach>
        </table>
      </div>

<a href="lab2">back</a>
</body>
</html>
