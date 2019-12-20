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
</head>
<body>
<canvas id="canvas" style="background-color: white; border-style: solid;">Not supported</canvas>

<script>
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
