$fn=100; 
corner_radius=3;    // rounded corners
thickness=4.1;      // thickness of material
width=16;           // with of the entire thing
length=16;          // length of end sections
boring_dia=5.5;     // diameter of holes
border=3.6;         // distance of holes from edge
height=12.1;        // overall height of the object
total_length=62;    // duh... exactly that

// no modifications below this line necessary

gap_length=total_length-2*length;
//Kreisabschnitt: r = (a²+h²)/2h
a=gap_length/2;
h=height-thickness;
radius=(a*a+h*h)/(2*h);

module ende(){  
  difference(){
    union(){
      translate([width/2-corner_radius,corner_radius,thickness/2]){
         cylinder(thickness,corner_radius,corner_radius,true);
      }
      translate([-(width/2-corner_radius),corner_radius,thickness/2]){
        cylinder(thickness,corner_radius,corner_radius,true);
      }
      translate([0,corner_radius,thickness/2])
        cube([width-2*corner_radius,2*corner_radius,thickness],true);
      translate([0,(length+corner_radius)/2,thickness/2]){
        cube([width,length-corner_radius,thickness],true);
      }
    };
    translate([0,border+boring_dia/2,0]) cylinder(thickness+5,boring_dia/2,boring_dia/2,true);
    // translate([0,5,0]) cylinder(thickness+5,2,2,true);
  }
}

module mitte(){
    intersection(){
        translate([-gap_length,-gap_length,0]) cube([total_length,total_length,total_length]);
        translate([0,0,-radius+h]) rotate([90,0,0]) difference(){
            cylinder(width,radius+thickness,radius+thickness,true);
            cylinder(width+5,radius,radius,true);
        }
    }
}

translate([0,length+gap_length/2,0]) rotate([0,0,90]) mitte();
ende();
translate([0,total_length,0]){
    rotate([0,0,180]){
        ende();
    }
}    

