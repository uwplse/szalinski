width=25;
depth=25;
height=90;
wall_depth=1;

translate([-width*1.5,-depth/2,0]){
 union(){
  difference(){
   //Build the general tube
   difference() {
    cube([width,depth,height]);
    translate([wall_depth, wall_depth,wall_depth]){
     cube([width-2*wall_depth, depth-2*wall_depth, height]);
    }
   }

   //The opening at the bottom:
   translate([width/2,-1,width-1]){
    rotate([-90,0,0]){
     union() {
      cylinder(h=wall_depth+2, r=width/2-wall_depth);
      translate([-1*(width/2-wall_depth),0,0]){
       cube([width-wall_depth*2, width-wall_depth*2, wall_depth+2]);
      }
     }
    }
   }
  }

  //Output Ramp:
  translate([0,1,0]){
   rotate([45,0,0]){
    color("blue") cube([width, floor(sqrt((depth*depth)*2))-1.5, 1]);
   }
  }

 //Cover rails
  translate([0,width-wall_depth*2,depth-wall_depth]){
   cylinder(h=height-depth+wall_depth, r=wall_depth/2,$fn=10);
  }
  translate([width,width-wall_depth*2,depth-wall_depth]){
   cylinder(h=height-depth+wall_depth, r=wall_depth/2,$fn=10);
  }  

  translate([0,width,wall_depth*3]){
   rotate([90,0,0]){
    cylinder(h=wall_depth*3, r=wall_depth/2, $fn=10);
   }
  }
  translate([width,width,wall_depth*3]){
   rotate([90,0,0]){
    cylinder(h=wall_depth*3, r=wall_depth/2, $fn=10);
   }
  }
 }
}
//cover
translate([width*1.5,-1*wall_depth-depth/2,height+wall_depth*2]){
 color("red")
 rotate([0,180,0])
 difference(){
  translate([-2*wall_depth,wall_depth,0]){
   cube([width+wall_depth*4,depth+wall_depth*2,height+wall_depth*2]);
  }
  translate([0,0,-1]){
   cube([width,depth+wall_depth,height+1]);
  }
 
  //cover Slides
  translate([0,wall_depth*3,0]){
   cylinder(h=height, r=wall_depth/2,$fn=10);
  }
  translate([width,wall_depth*3,0]){
   cylinder(h=height, r=wall_depth/2,$fn=10);
  }

  translate([0,wall_depth*4,wall_depth*3]){
   rotate([90,0,0]){
    cylinder(h=wall_depth*4, r=wall_depth/2, $fn=10);
   }
  }
  translate([width,wall_depth*4,wall_depth*3]){
   rotate([90,0,0]){
    cylinder(h=wall_depth*4, r=wall_depth/2, $fn=10);
   }
  }
 }
}