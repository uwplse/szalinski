
$fs=0.5;
$fa=6;

NAME = "Charlotte";
OUTER = 96;
N = 10;
DIA = 15;
WALL = 3;
BORDER_DIA = 15;
FONTNAME = "Pacifico";
FONTSTYLE = "Regular";

FONT_SIZE = 12;
FONT_THICKNESS = 5;
GRID_THICKNESS = 3;

M3_HEAD_BOTTOM = 4.5;
M3_HEAD_DIA = 6.5;
M3_HOLE_DIA = 3.8;

MAKE_M3_TEST = "no"; // [yes,no]



FONT = str(FONTNAME,":style=",FONTSTYLE);
echo("FONT:",FONT);


module hexagon(l)  {
	circle(d=l, $fn=6);
}


module hexagon_border(inner, outer)
{
  difference()
  {
    hexagon(outer);
    hexagon(inner);
    
  }
}


module honeycomb(x, y, dia, wall)
{
  innerDia = dia-(2*wall);
  midDia = dia - wall;
  
  outerHeight = 2 * ((dia/4)/tan(30));
  innerHeight = 2* ((innerDia/4)/tan(30));
  midHeight = 2* ((midDia/4)/tan(30));
  
  outerEdge = outerHeight/2 / cos(30);
  innerEdge = innerHeight/2 / cos(30);
  midEdge = midHeight/2 / cos(30);
  
  minWall = wall * cos(30);
  
  xStep = midDia + midEdge;
  yStep = outerHeight-minWall;
  
  for (yOffset = [0:yStep:y+yStep], xOffset = [0:xStep:x+xStep]) {
			translate([xOffset, yOffset]) {
				hexagon_border(innerDia, dia);
			}
			translate([xOffset +midDia - midEdge/2 , yOffset + outerHeight/2 - wall/2]) {
				color("blue") hexagon_border(innerDia,dia);
			}
		}
  
}

module ball(inner, outer)
{
  
  difference()
  {
    sphere(d=outer);
    sphere(d=inner);
  }
}


module honeycombBall(n, dia, wall)
{

  d = dia;
  w = wall;
  dMid = d -w;
  outerHeight = 2 * ((dia/4)/tan(30));

  outer = dMid + ( (n-1) * (dMid - dMid/4)) + w;

  echo("OUTER:",outer);

  intersection()
  {
    linear_extrude(height = outer, center = true, convexity = 10, twist = 0, $fn = 100)
      translate([d/2,outerHeight/2,0])
        honeycomb(outer,outer,d,w);
    translate([outer/2, outer/2, 0])
      ball(outer-w, outer);
  }

}

module honeycombCircle(n, dia, wall)
{
  d = dia;
  w = wall;
  dMid = d -w;
  
  outerHeight = 2 * ((dia/4)/tan(30));

  outer = dMid + ( (n-1) * (dMid - dMid/4)) + w;

  echo("OUTER:",outer);

  translate([-outer/2, -outer/2,0])
  {
    intersection()
    {
      translate([d/2,outerHeight/2,0])
          honeycomb(outer,outer,d,w);
      translate([outer/2, outer/2, 0])
         circle(d=outer);
    }
  }  
}

function sinr(x) = sin(180 * x / PI);
function cosr(x) = cos(180 * x / PI);

module 2dflower(n, dia, fDia)
{
  r = dia/2;
  
  delta = (2*PI)/n;
  
  for (step = [0:n-1]) {
    translate([r * cosr(step*delta), r * sinr(step*delta), 0])
      circle(d=fDia); 
  }
  
}

module 3dflower(n, dia, fDia)
{
  r = dia/2;
  
  delta = (2*PI)/n;
  
  for (step = [0:n-1]) {
    translate([r * cosr(step*delta), r * sinr(step*delta), 0])
      sphere(d=fDia); 
  }
  
}



module m5hole()
{
  cylinder(h=100, d=5.8, center=true);
  translate([0,0,3])
    cylinder(h=100, d=8.6, center=false);
}



module m3hole()
{
  cylinder(h=2*BORDER_DIA, d=M3_HOLE_DIA, center=true);
  translate([0,0,M3_HEAD_BOTTOM])
    cylinder(h=2*BORDER_DIA, d=M3_HEAD_DIA, center=false);
}

module m3Test()
{
  difference() {
    difference(){
      sphere(d=BORDER_DIA);
      m3hole();
    }
    translate([0,0,-BORDER_DIA/2])
      cube([2*BORDER_DIA,2*BORDER_DIA,BORDER_DIA], center=true); 
  } 
}



module speakerGrid()
{
  color("Magenta")
  difference()
  {
    union() {
      
      { 
        difference() {
          union() {   
            linear_extrude(FONT_THICKNESS)
                text(text=NAME, font=FONT,/*font="Purisa, Bold",*/ size=FONT_SIZE, halign="center", valign="center");
            linear_extrude(GRID_THICKNESS) {
              honeycombCircle(N, DIA, WALL);
            }

        
            3dflower(32, OUTER, BORDER_DIA);
          }
          union(){
            for (angle=[45, 135, 225, 315]){
              translate([OUTER/2 * cos(angle), OUTER/2 * sin(angle), 0])
                m3hole(); 
            }
            
          }
        }
  
        
      }
    }
    translate([0, 0, -OUTER/2])
      cube([2*OUTER, 2*OUTER, OUTER], center = true);
    
  }
}

if (MAKE_M3_TEST == "yes") {
  m3Test();
} else {
  speakerGrid();
}