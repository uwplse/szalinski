use <Write.scad>

wig = 0.01/1; // Number to ensure overlaps.

//Number of facets in a circle. More = smoother.
$fn=180; // [15,20,30,45,60,100]

//Diameter of the bottom of the bowl.
cone_bot = 200;

//Diameter of the top of the bowl.
cone_top = 170;

//Height of the bowl.
cone_h = 60;

//Interior diameter of the bowl.
bowl_d = 157;

//Wall thickness of the cone portion of the bowl.
wall_t = 2;

//Words on the bowl.
words = "Snack Bowl";


delta = (cone_bot-cone_top)/2;
avg_r = (cone_top+cone_bot)/4;
angle = atan(delta/cone_h);

module bowl(TEXT) {
  difference() {
    union() {
      cylinder(r1=cone_bot/2,r2=cone_top/2,h=cone_h,center=false);
      intersection() {
        writecylinder(text=TEXT,where=[0,0,0],radius=avg_r,height=cone_h,h=0.4*cone_h,t=delta);
        cylinder(r1=cone_bot/2+wall_t,r2=cone_top/2+wall_t,h=cone_h,center=false);  
      }
    }
    difference() {
      translate([0,0,-wall_t/sin(angle)]) cylinder(r1=cone_bot/2, r2=cone_top/2, h=cone_h,center=false);
      translate([0,0,cone_h-wall_t/sin(angle)]) scale([1,1,2*(cone_h-wall_t)/bowl_d]) sphere(bowl_d/2);
    }
    translate([0,0,cone_h]) scale([1,1,2*(cone_h-wall_t)/bowl_d]) sphere(bowl_d/2);
  }
}

bowl(words);
