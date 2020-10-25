const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");

// fillRect
ctx.fillStyle = "green";
ctx.fillRect(10, 10, 150, 100);

// fillText
ctx.fillStyle = "purple";
ctx.font = "30px Arial";
ctx.fillText("Hello World", 400, 50);

// strokeText
ctx.lineWidth = 1;
ctx.strokeStyle = "orange";
ctx.strokeText("Hello World", 400, 100);

function drawSmile() {
  var canvas = document.getElementById("canvas");
  if (canvas.getContext) {
    var ctx = canvas.getContext("2d");

    ctx.beginPath();
    ctx.arc(75, 175, 50, 0, Math.PI * 2, true); // 绘制
    ctx.moveTo(110, 175);
    ctx.arc(75, 175, 35, 0, Math.PI, false); // 口(顺时针)
    ctx.moveTo(65, 165);
    ctx.arc(60, 165, 5, 0, Math.PI * 2, true); // 左眼
    ctx.moveTo(95, 165);
    ctx.arc(90, 165, 5, 0, Math.PI * 2, true); // 右眼
    ctx.stroke();
  }
}

function drawBeizer() {
  var canvas = document.getElementById("canvas");
  if (canvas.getContext) {
    var ctx = canvas.getContext("2d");
    ctx.beginPath();
    ctx.moveTo(75, 25);
    ctx.quadraticCurveTo(25, 25, 25, 62);
    ctx.quadraticCurveTo(25, 100, 50, 100);
    ctx.quadraticCurveTo(50, 120, 30, 125);
    ctx.quadraticCurveTo(60, 120, 65, 100);
    ctx.quadraticCurveTo(125, 100, 125, 62);
    ctx.quadraticCurveTo(125, 25, 75, 25);
    ctx.stroke();
  }
}

function drawPattern() {
  var canvas = document.getElementById("canvas");
  if (canvas.getContext) {
    var ctx = canvas.getContext("2d");

    var img = new Image();
    // img.src = "./img/pattern.png";
    img.src =
      "data:image/gif;base64,R0lGODlhCwALAIAAAAAA3pn/ZiH5BAEAAAEALAAAAAALAAsAAAIUhA+hkcuO4lmNVindo7qyrIXiGBYAOw==";
    //onload确认图片装载完毕
    img.onload = function () {
      var ptrn = ctx.createPattern(img, "repeat");
      ctx.fillStyle = ptrn;
      ctx.fillRect(180, 20, 200, 250);
    };
  }
}

drawSmile();
drawBeizer();
drawPattern();
