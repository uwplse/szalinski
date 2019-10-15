$fn = 20;
height = 50; //the total height of the object.
width = 50; //the width of the clip.
thickness = 3; //clip thickness.
binder_thickness = 2.8; //measured width of your own binder.
pencil_diameter = 7.3; //measured width of your own pencils.
clip_number = 3;

top_arc_diameter = (2*thickness)+binder_thickness;
inset = 5;
clip_gap = pencil_diameter-1;


//Entire Object
union(){

 //Clip - gap inside clip for binder - inner arch
 difference(){
  
  //Main binder clip structure + top arch
  union(){
   
   //Main binder clip structure 
   cube([width, (thickness*2)+binder_thickness, height-(top_arc_diameter/2)]);
   
   //Top arch of binder clip
   rotate([90, 90, 90]){
    translate([-height+(top_arc_diameter/2), top_arc_diameter/2, 0]){
     cylinder(width, top_arc_diameter/2, top_arc_diameter/2);
    }
   }
  }

  //Rounding out the inside of the binder clip
  rotate([90, 90, 90]){
   translate([-height+(top_arc_diameter/2), top_arc_diameter/2, 0]){
    cylinder(width, binder_thickness/2, binder_thickness/2);
   }
  }

  //The gap inside the binder clip
  translate([-0.5, (10-4)/2, 0]){
   cube([width+1, binder_thickness, height-top_arc_diameter/2]);
  }
 }

 //Pencil clip(s)
 for (i = [0 : clip_number-1]){
  translate([(((width+pencil_diameter+thickness)/clip_number)*i),0,0]){
   difference(){
    translate([inset, -pencil_diameter/2, 0]){
     cylinder(20, (pencil_diameter/2)+(thickness/2), (pencil_diameter/2)+(thickness/2));
    }
    translate([inset, -pencil_diameter/2, 0]){
     cylinder(20, (pencil_diameter/2), (pencil_diameter/2));
    }
    translate([inset-clip_gap/2, -(pencil_diameter+thickness), 0]){
     cube([clip_gap, 5, 20]);
    }
   }
  }
 }
}