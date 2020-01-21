<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="constraintsBean" scope="application" class="beans.ConstraintsBean"/>
<jsp:useBean id="historyBean" scope="session" class="beans.ResultBean"/>

<html>
  <head>
    <title>Lab 2</title>

    <link href="styles/main.css" type="text/css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script src="scripts/main.js"></script>
      <script src="scripts/canvas.js"></script>

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
                style="background: url('images/image.png') no-repeat;
                background-size: contain; justify-content: center">Not supported</canvas>
        <div class="blockX">
          X :
          <c:forEach items="${constraintsBean.available_x}" var="x" varStatus="status">
            <label><input type="radio" class="x_value" value="${x}" name="x">${x} </label>
          </c:forEach>
        </div>
        <div class="block">
          <input type="text" name="y" required="required" placeholder="Y: (-3...5)" id="y_value" maxlength="5" width="10px">
          <input type="text" name="r" required="required" oninput="getR()" placeholder="R: (2...5)" id="r_value" maxlength="5">
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

<%--  <script>--%>
<%--      const canvas = document.getElementById("my-canvas");--%>
<%--      const ctx  =canvas.getContext('2d');--%>
<%--      let points = <jsp:getProperty name="historyBean" property="history"/>;--%>

<%--      function getR(){--%>

<%--      }--%>

<%--      window.onload = () => {--%>

<%--          let r = document.getElementById('r_value').value.replace(',','.');--%>
<%--          if (r === ''){--%>
<%--              r = 4;--%>
<%--          }--%>
<%--          localStorage.setItem('r',r);--%>

<%--          ctx.clearRect(0, 0, canvas.width, canvas.height);--%>
<%--          drawFigure(ctx, r);--%>
<%--          axises(ctx);--%>
<%--          rMarks(ctx);--%>
<%--          drawPoints(ctx, points);--%>
<%--      };--%>
<%--      function redraw() {--%>
<%--          let r = document.getElementById("r_value").value.replace(',','.');--%>

<%--          ctx.clearRect(0, 0, canvas.width, canvas.height);--%>
<%--          drawFigure(ctx, r);--%>
<%--          axises(ctx);--%>
<%--          rMarks(ctx);--%>
<%--          drawPoints(ctx, points);--%>
<%--      }--%>

<%--      canvas.onclick = (e) => {--%>

<%--          let rect = canvas.getBoundingClientRect();--%>
<%--          let canx = (e.clientX - rect.left - LINE_WIDTH / 2);--%>
<%--          let cany = (e.clientY - rect.top - LINE_WIDTH / 2);--%>

<%--          r = document.getElementById("r_value").value.replace(',','.');--%>
<%--          sessionStorage.setItem('r',r);--%>

<%--          if (r !== "" && !isNaN(r) && r > 2 && r < 5) {--%>
<%--              let res = fromCanvas({"x": canx, "y": cany, "r": r});--%>
<%--              canvasSend(res.x, res.y, r);--%>
<%--          } else {--%>
<%--              $.growl.notice({message: "Проверьте радиус"});--%>
<%--          }--%>
<%--      }--%>

<%--  </script>--%>

  <script>
      const A = 222;
      const R = 85;

      window.onload = () => {
          $.growl.notice({message: "Для более точных данных рекомендуется использовать форму"});
          document.getElementById('r_value').value = localStorage.getItem('r');
          draw();
      };
      $("#my-canvas").on("click",function (event) {
          let h = document.getElementById("my-canvas").offsetHeight;
          let x_canvas = event.pageX - this.offsetLeft;
          let y_canvas = event.pageY - this.offsetTop;

          let r = document.getElementById("r_value").value.replace(',','.');
          let client_x = getNormalX(x_canvas, h, r);
          let client_y = getNormalY(y_canvas, h, r);

          if(r != "" && !isNaN(r) && r > 2 && r < 5){
              localStorage.setItem('r',r);
              canvasSend(client_x,client_y,r)
          }else{
              $.growl.error({ message: "Проверьте правильность введённых данных!" });
          }
      });

      function getNormalX(x, h, r){
          let x_for_counting = ((x-0.5*h)/(R/r));
          x_for_counting = x_for_counting.toFixed(4);
          return x_for_counting;
      }
      function getNormalY(y, h, r){
          let y_for_counting = -(A/h)*((y-0.5*h)/(R/r));
          y_for_counting = y_for_counting.toFixed(4);
          return y_for_counting;
      }

      function getChartX(x, h, r){
          let x_for_drawing = ((x* (R/r)+0.5 * A));
          x_for_drawing = x_for_drawing.toFixed(4);
          return x_for_drawing;
      }
      function getChartY(y, h, r){
          let y_for_drawing = -((y* (R/r)-0.5 * A));
          y_for_drawing = y_for_drawing.toFixed(4);
          return y_for_drawing;
      }

      let history = <jsp:getProperty name="historyBean" property="history"/>;

      function draw(){
          let r = localStorage.getItem('r');
          let canvas = document.getElementById('my-canvas');
          let context = canvas.getContext('2d');
          context.clearRect(0,0,222,222);

          Array.from(history).forEach( p => {
              let h = document.getElementById("my-canvas").offsetHeight;
              let xClient = getChartX(parseFloat(p.x), h, parseInt(r));
              let yClient = getChartY(parseFloat(p.y), h, parseInt(r));

              let canvas = document.getElementById("my-canvas");
              let context = canvas.getContext("2d");
              context.beginPath();

              if(parseFloat(r) !== parseFloat(p.r)){
                  context.strokeStyle = 'black';
                  context.fillStyle = 'black';
              }else{
                  let result = checkArea(p.x,p.y,p.r);
                  if(result === 'orange'){
                      context.strokeStyle = 'orange';
                      context.fillStyle = 'orange';
                  }else if (result === true) {
                      context.strokeStyle = 'green';
                      context.fillStyle = 'green';
                  } else{
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
      function checkArea(x,y,r) {
          let halfR = r / 2;

          return x >= 0 && y >= 0 && y < halfR - x / 2 ||
              x >= 0 && y <= 0 && x * x + y * y < halfR * halfR ||
              x <= 0 && y >= 0 && x >= -r && y <= halfR;
      }
  </script>
  </body>
</html>
