<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="constraintsBean" scope="application" class="beans.ConstraintsBean"/>
<jsp:useBean id="historyBean" scope="session" class="beans.ResultBean"/>
<%--
  Created by IntelliJ IDEA.
  User: andrei
  Date: 03.12.2019
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
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
        <canvas id="canvas" style="background-color: white; border-style: solid;">Not supported</canvas>
        <div class="blockX">
          X :
          <c:forEach items="${constraintsBean.available_x}" var="x" varStatus="status">
            <label><input type="radio" class="x_value" value="${x}" name="x">${x} </label>
          </c:forEach>
        </div>
        <div class="block">
          <input type="text" name="y" required="required" placeholder="Y: (-3...5)" id="y_value" maxlength="5" width="10px">
          <input type="text" name="r" required="required" placeholder="R: (2...5)" id="r_value" maxlength="5">
        </div>

        <div id="submit_block">
          <input type="button" value="Проверить" id="execute" onclick="send()">
        </div>

        <div id="result-message">
            <table border="1" cellpadding="5" width="350" id="result-table">
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

    </div>
  </div>
  <script>
      let hist_array = <jsp:getProperty name="historyBean" property="history"/>;
      let size =150;

      let canvas = document.getElementById('canvas');
      let context = canvas.getContext('2d');

      canvas.width = size;
      canvas.height = size;

      context.beginPath();
      context.moveTo(size/2,size);
      context.lineTo(size/2,0);
      context.moveTo(0,size/2);
      context.lineTo(size,size/2);
      context.stroke();
      context.closePath();

      context.fillStyle = 'red';
      canvas.addEventListener('mousedown', function (e) {
          context.beginPath();
          context.arc(e.clientX,e.clientY,5,0,Math.PI*2);
          context.fill();
      });
  </script>
  </body>
</html>
