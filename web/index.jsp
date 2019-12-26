<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<html>
  <head>
    <title>Lab 2</title>

<%--    <link href="styles/main.css" type="text/css" rel="stylesheet">--%>
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
        <canvas id="my-canvas" height="222" width="222"
                style="background: url('images/image.png') no-repeat;background-size: contain;">Not supported</canvas>
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
      const A = 222;
      const R = 80;

      window.onload = () => {
          $.growl.notice({message: "Для более точных данных рекомендуется использовать форму"});
          redraw();
      };
      document.ready = () => {
          $("#my-canvas").on("click",function (event) {
              let h = document.getElementById("my-canvas").offsetHeight;
              let x_canvas = event.pageX - this.offsetLeft;
              let y_canvas = event.pageY - this.offsetTop;

              let r = document.getElementById("r_value").value;
              let client_x = normalizeX(x_canvas, h, r);
              let client_y = normalizeY(y_canvas, h, r);

              if(r != "" && !isNaN(r) && r > 2 && r < 5){
                  localStorage.setItem('r',r);
                  canvasSend(client_x,client_y,r)
              }else{
                  $.growl.error({ message: "Проверьте правильность введённых данных!" });
              }
          });
      };

      function normalizeX(x, a, r){
          let x_server = ((x-0.5*a)/(R/r));
          x_server = x_server.toFixed(4);
          return x_server;
      }
      function normalizeY(y, a, r){
          let y_server = -(A/a)*((y-0.5*a)/(R/r));
          y_server = y_server.toFixed(4);
          return y_server;
      }

      function chartX(x, a, r){
          let x_client = ((x* (R/r)+0.5 * A));
          x_client = x_client.toFixed(4);
//console.log("x_client: " + x_client);
          return x_client;
      }
      function chartY(y, a, r){
          let y_client = -((y* (R/r)-0.5 * A));
          y_client = y_client.toFixed(4);
//console.log("y_client: " + y_client);
          return y_client;
      }

      let history = <jsp:getProperty name="historyBean" property="history"/>;

      function redraw(){
          let r = localStorage.getItem('r');
          let canvas = document.getElementById('my-canvas');
          let context = canvas.getContext('2d');
          context.clearRect(0,0,222,222);
          Array.from(history).forEach( p => {
              let h = document.getElementById("my-canvas").offsetHeight;
              let xClient = chartX(parseFloat(p.x), h, parseInt(r));
              let yClient = chartY(parseFloat(p.y), h, parseInt(r));

              let canvas = document.getElementById("my-canvas");
              let context = canvas.getContext("2d");
              context.beginPath();

              if(parseInt(r) != parseInt(p.r)){
                  context.strokeStyle = 'black';
                  context.fillStyle = 'black';
              }else{
                  if(p.result === 'Входит'){
                      context.strokeStyle = 'green';
                      context.fillStyle = 'green';
                  }else{
                      context.strokeStyle = 'red';
                      context.fillStyle = 'red';
                  }
              }


              context.arc(xClient, yClient, 1.5, 0, 2 * Math.PI);
              context.closePath();
              context.fill();
              context.stroke();
          });
      }
  </script>
  </body>
</html>
