HOLE = 6;
MARGIN = 10;
D = 50;
H = 15;
WALL = 5;
N = 5;

$fn = 90;

union() {
    difference() {
      cylinder(h=H, d1=D+MARGIN, d2=0.8*D);
      cylinder(h=H, d=0.8*D-WALL);
    }

    difference() {
      union() {
          cylinder(h=H, d2=HOLE+3.5*WALL, d1=HOLE+1.5*WALL);
          
          for(i=[0:N-1]) {
              rotate(a=360/N*i, v=[0,0,1]) 
              translate([-2*WALL/2, 0, 0]) 
              cube([2*WALL, 0.75*D/2, H]);
          }
      }
      cylinder(h=H, d=HOLE, $fn=90);
    }
}