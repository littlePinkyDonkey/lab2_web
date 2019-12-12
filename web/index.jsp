<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="constraintsBean" scope="application" class="beans.ConstraintsBean"/>
<%--
  Created by IntelliJ IDEA.
  User: andrei
  Date: 03.12.2019
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Lab 2</title>

    <link href="styles/main.css" type="text/css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script src="scripts/main.js"></script>

    <script src="jquery.growl/javascripts/jquery.growl.js" type="text/javascript"></script>
    <link href="jquery.growl/stylesheets/jquery.growl.css" rel="stylesheet" type="text/css" />
  </head>
  <body>

  <div id="main_page">
    <div id="header">
      Студент: Теплых Андрей | Группа P3211 | Вариант 12803
    </div>
    <div class="inner">

        <div id="canvas_block"></div>

        <div class="blockX">
          X :
          <c:forEach items="${constraintsBean.available_x}" var="x" varStatus="status">
            <label><input type="radio" class="x_value" value="${x}" name="x">${x} </label>
          </c:forEach>
        </div>
        <div class="block">
          <input type="text" name="y" required="required" placeholder="Y: (-3...5)" id="y_value" maxlength="5" width="10px">
          <input type="text" name="r" required="required" placeholder="R: (2...5)" id="r_value" maxlength="5" oninput="resetDisable()">
        </div>

        <div id="submit_block">
          <input type="button" value="Проверить" id="execute" onclick="send()">
        </div>

    </div>
  </div>
  </body>
</html>
