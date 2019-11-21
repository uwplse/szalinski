showconstruction=1;//[1:yes,0:no]
r = 5;
w = 25;
h = 10;
m = 2;
hr = 1;
$fn = 50;
rd = 2;


intersection() {
    color("BlanchedAlmond")
linear_extrude(h*3,center=true, convexity = 10) a();
color("NavajoWhite") 
 rotate([90, 0, 180]) 
    linear_extrude(r*5+ m,center=true,  convexity = 10) b();
}

if (showconstruction==1){
color("red")translate([0,r,0])  
rotate([90, 0, 180]) 
linear_extrude(r*4,center=true, , convexity = 10) b();
color("yellow")translate([0,0,h/2]) linear_extrude(h*3,center=true, convexity = 10) a();
}

module a(){
      offset(-m*0.4 ) {
      offset(m*0.8) offset(-m *0.4) { difference() {
    intersection() {
      translate([-w / 2, 0])
      square([w, r * 2 + m]);
      union() {
        translate([-w / 2, 0])
        square([w, m]);
        hull() {
          translate([0, r])
          circle(r + m);
          translate([0, -r])
          circle(r + m);
        }
      }
    }
    hull() {
      translate([0, r])
      circle(r);
      translate([0, -r])
      circle(r);
    }
  }}}}


module b(){
    difference() {
      offset(rd) {
        offset(-rd) {
          translate([-w / 2, 0])
          square([w, h]);
        }
      }
      translate([(r + m + w / 2) / 2, h / 2])
      circle(hr);
      translate([-(r + m + w / 2) / 2, h / 2])
      circle(hr);
    }
  }

