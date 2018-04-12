var canvas = document.getElementById("map");
var c = canvas.getContext("2d");
var i, j, token, token2;
var tokens = [];
var numTokens = 5;
var mouse = {
  x: 0,
  y: 0,
  down: false
};

initializeTokens();

function initializeTokens(){
  tokens = [];
  for(i = 0; i < numTokens; i++){
      img = new Image();
      img.src="/images/monsters/skeletons.jpg";
      //document.body.appendChild(img);
      //pattern = c.createPattern(img, 'repeat');
      token = {
          x: Math.random() * canvas.width,
          y: Math.random() * canvas.height,
          img: img
      };
      tokens.push(token);
  }
}

function drawTokens(){
  for(i = 0; i < numTokens; i++){
    token = tokens[i];
    //c.beginPath();
    //c.arc(token.x, token.y, 20, 0, 2 * Math.PI);
    //c.fillStyle = token.img;
    //c.fill();
    c.drawImage(token.img, token.x, token.y, 30,30);
  }
}
function drawMap(){
    img = new Image();
    img.src = '/images/maps/dungeon.jpg';
    c.beginPath();
    c.drawImage(img, 0, 0);
}


function init() {
    drawMap();
    drawTokens();
}
init();
