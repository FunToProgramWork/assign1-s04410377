PImage bg, groundhog, life1, life2, life3, robot, soil, soldier;
int speedX;//soldier speed
int robotXAxis, robotYAxis;//robot appear position
int soldierXAxis, soldierYAxis;//soldier appear position
int laserStartX, laserStartY, laserEndX, laserRange, laserReStartX;//laser start position,end position,shooting range,restart position

void setup() {
  size(640, 480, P2D);
  //load image
  bg = loadImage("bg.jpg");
  groundhog = loadImage("groundhog.png");
  life1 = loadImage("life.png");
  life2 = loadImage("life.png");
  life3 = loadImage("life.png");
  robot = loadImage("robot.png");
  soil = loadImage("soil.png");
  soldier = loadImage("soldier.png");

  //soldier moving speed
  speedX = floor(random(4, 8));

  //X,Y random axis for robot and soldier
  robotYAxis = floor(random(2, 6))*80;
  soldierXAxis = floor(random(640));
  soldierYAxis = floor(random(2, 6))*80;

  laserStartX = floor(random(160, 561));
  robotXAxis = laserStartX-25;
  laserStartY = robotYAxis+37;
  laserEndX = laserStartX-1;
  laserRange = 35;

  laserReStartX = laserStartX;
}

void draw() {
  //set image location and size
  background(bg);
  image(soil, 0, 160, 640, 320);
  image(groundhog, width/2-40, 80, 80, 80);
  image(life1, 10, 10, 50, 51);
  image(life2, 80, 10, 50, 51);
  image(life3, 150, 10, 50, 51);

  //avoid robot and soldier are on the same place
  if (robotYAxis != soldierYAxis) {
    //soldier moving
    soldierXAxis += speedX;
    //when soldier go over canvas, back to left side
    if (soldierXAxis > width) {
      soldierXAxis = -100;
    }

    //draw grass
    noStroke();
    fill(124, 204, 25);
    rect(0, 145, 640, 15);

    //draw sun
    fill(253, 184, 19);
    stroke(255, 255, 0);
    strokeWeight(5);
    ellipse(590, 50, 120, 120);

    //draw laser
    if (laserStartY != robotYAxis+37) {
      robotYAxis = floor(random(2, 6))*80;
      laserStartY = robotYAxis+37;
    } //laser and robot are on the same Y-axis

    laserEndX -=2;
    strokeWeight(10);
    stroke(255, 0, 0);
    line(laserStartX, laserStartY, laserEndX, laserStartY);

    if (laserEndX <= robotXAxis-125) {
      laserEndX = laserReStartX-1;
      laserStartX = laserReStartX;
    }

    if (laserStartX-laserEndX == laserRange) {
      laserStartX-=2;
    } //Start moving left after End is go over the Range

    //characters
    image(robot, robotXAxis, robotYAxis);
    image(soldier, soldierXAxis, soldierYAxis);
  } else { 
    robotYAxis = floor(random(2, 6))*80; //avoid robot and soldier are on the same aisle
    soldierYAxis = floor(random(2, 6))*80;
  }
}
