// Thickness of the component
wall = 4;
// Radius of curvature of the outer concave section of the breast shield
outer_cup = 50;
// Radius of curvature of the inner convex section (nipple) of the breast shield
inner_cup = 20;
// Internal radius of the collection tube
tube = 10;
// Angular extent of the breast shield
cup_extent = 50;
// Length of the straight section connecting the breast shield to the collection tube
throat=10;
// Number of segments in circular components. Multiple of 4
segments=96;
// Radius of curvature of the collection tube
curve=50;
// Collection tube overhang (past 45 degree on centre) degrees
overhang=0;
// Height of the threaded portion of the lid
h1=15;
// Height of the upper portion of the lid (old version)
h2=10;
// Z-Scale ratio for upper dome of lid
dome=0.55;

// Internal diameter of the lid excluding thread
thread=62;
// Vertical offset of collection tube relative to lid
offset=2;
// Thread pitch
pitch=3;
// Tolerance (overlap to remove zero thickness structure remnants)
tol=0.01;

// shield
y=sqrt(pow(inner_cup+outer_cup,2)-pow(inner_cup+tube,2));
translate([y+throat+curve/sqrt(2),0,curve+h1-curve/sqrt(2)+offset])
rotate([0,-90,0])
rotate_extrude(convexity=10, $fn=segments) {
  inner_extent=asin((inner_cup+tube)/(inner_cup+outer_cup));
  outer_extent=cup_extent-inner_extent;
  rotate(-inner_extent) {
    rotate(-outer_extent)
      translate([0,outer_cup+wall/2,0])
        circle(d=wall, $fn=segments/4);
    intersection() {
      difference() {
        circle(outer_cup+wall, $fn=segments);
        circle(outer_cup, $fn=segments);
      }
      polygon(points=[[0,0],[0,outer_cup+wall],[(outer_cup+wall)*tan(outer_extent),outer_cup+wall]]); 
    }
    translate([0,inner_cup+outer_cup,0]) {
      intersection() {
        difference() {
          circle(inner_cup, $fn=segments);
          circle(inner_cup-wall, $fn=segments);
        }
        polygon(points=[[0,0],[0,-inner_cup-tube],[-y,-inner_cup-tube]]);
      }
    }
  }
  polygon([[tube,y],[tube+wall,y],[tube+wall,y+throat],[tube,y+throat]]);
}

// spout
translate([curve/sqrt(2),0,h1-curve/sqrt(2)+offset]) {
  intersection() { // weld overlap to prevent internal faces
    translate([-throat/2,0,curve]) rotate([0,90,0])
      linear_extrude(height=throat, convexity=10, $fn=segments)
        difference() {
          circle(r=tube+wall, $fn=segments);
          circle(r=tube, $fn=segments);
        }
        rotate([-90,0,0]) rotate_extrude(convexity=10, $fn=segments)
          translate([curve,0,0])
            difference() {
              circle(tube+wall, $fn=segments);
              circle(tube, $fn=segments);
            }
  }
  difference() {
    rotate([-90,0,0]) difference() {
      rotate_extrude(convexity=10, $fn=segments)
        translate([curve,0,0])
          difference() {
            circle(tube+wall, $fn=segments);
            circle(tube, $fn=segments);
          }
      s=curve+throat+wall;
      translate([0,-s,-s]) cube(2*s);
      rotate(135-overhang) translate([0,-s,-s]) cube(2*s);
    }
    // air hole
    translate([0,0,curve+tube-2])
      rotate([0,-90,0]) cylinder(h=curve, d=4, $fn=segments);
  }
}
    
difference() {
  union() {
    // lid
    translate([0,0,h1+wall]) difference() {
      scale([1,1,dome]) sphere(d=thread, $fn=segments);
      translate([0,0,-thread/2]) cube(thread, center=true);
    }

    rotate_extrude(convexity=10, $fn=segments) {
      translate([thread/2,h1,0]) intersection() {
        circle(wall, $fn=segments);
        square(wall);
      }
      //translate([thread/2-wall,h1+h2,0]) intersection() {
      //  circle(wall, $fn=segments);
      //  square(wall);
      //}
      translate([thread/2,0,0]) square([wall,h1]);
      //translate([thread/2-wall,h1,0]) square([wall,h2]);
      translate([thread/2-wall,h1,0]) square(wall); // this could be a lot neater... TODO: consolidate and simplify redundant positive and negative volumes
      translate([thread/2-2*wall,h1+wall*(1-dome),0]) square([wall*2,wall*dome]);
      
      //translate([0,h1+h2,0]) square([thread/2-wall,wall]);
    }
    
    // overhang support (incomplete, needs to be properly parametrised)
    translate([curve/sqrt(2)+throat,0,h1-curve/sqrt(2)+offset-inner_cup+curve]) {
      rotate([-90,0,0]) difference() {
        rotate_extrude(convexity=10, $fn=segments)
          translate([inner_cup,0,0])
            circle(tube+wall, $fn=segments);
        s=curve+throat+wall;
        translate([0,-s,-s]) cube(2*s);
        rotate(110) // this needs to depend on parameters
          translate([0,-s,-s]) cube(2*s);
      }
    }
    hull() {
      translate([curve/sqrt(2)+throat,0,h1-curve/sqrt(2)+offset-inner_cup+curve]) {
        rotate([0,-69,0]) // this needs to depend on parameters
          rotate([0,-90,0])
            translate([inner_cup,0,0])
              cylinder(h=1,r=tube+wall, $fn=segments);
      }
      cylinder(h=1,d=thread+2*wall, $fn=segments);
    }

  }
  // thread hole
  translate([0,0,-tol]) cylinder(h=h1+tol, d=thread, $fn=segments);
  //translate([0,0,h1-tol]) cylinder(h=h2+tol, d=thread-2*wall, $fn=segments);
  translate([0,0,h1-tol]) cylinder(h=wall*(1-dome)+tol, d=thread-2*wall, $fn=segments);
  translate([0,0,h1+wall*(1-dome)]) scale([1,1,dome]) sphere(d=thread-2*wall, $fn=segments);
  
  // spout hole
  translate([curve/sqrt(2),0,h1-curve/sqrt(2)+offset])
    rotate([-90,0,0]) difference() {
      rotate_extrude(convexity=10, $fn=segments)
        translate([curve,0,0])
      circle(tube+wall/2, $fn=segments);
      s=curve+throat+wall;
      translate([0,-s,-s]) cube(2*s);
      rotate(135) translate([0,-s,-s]) cube(2*s);
    }
  // throat hole
  translate([curve/sqrt(2),0,h1-curve/sqrt(2)+offset])
    translate([-tol,0,curve]) rotate([0,90,0])
      linear_extrude(height=throat+2*tol, convexity=10, $fn=segments)
        circle(r=tube+wall, $fn=segments);

  // internal overhang removal
  intersection() {
    cylinder(h1,d1=thread+wall,d2=thread+wall, $fn=8);
    translate([-wall-thread/2,-thread/8,0]) cube([2*wall,thread/4,h1]);
  }

  // air hole
  translate([3*wall-thread/2,0,h1+wall])
  cylinder(h=thread/2, d=4, $fn=segments);
}

//thread
intersection(){
  difference() {
    cylinder(h=h1, d=thread+1, $fn=segments);
    cylinder(h=h1, d=thread-3, $fn=segments);
    translate([-thread/2-wall,-thread/8,0]) cube([thread+2*wall,thread/4,h1]);
  }
  incline=atan(pitch/(3.14159*thread)); // ie. lead angle
  for (t =[90:360/segments:h1/pitch*360-360])
    rotate([0,0,t])
      translate([0,0,t*pitch/360])
        rotate([incline,0,0])
          intersection() {
            rotate([0,0,360/segments-89.9]) cube([thread,thread,0.4*pitch]);
            cube([thread,thread,0.4*pitch]);
          }
}