


use <write/Write.scad>
use <Write.scad>

// preview[view:south, tilt:top]

/* [global] */
//For name, max 7 characters. 
name = "Name"; 



/* [hidden] */
font = "write/Letters.dxf"; 
h = 40;
w = 25;
r = 2.5; 
$fn=150; 

module logo(){ linear_extrude(height = 3) polygon( [ [0,0],[4.1,0],[10.1,20],[6,20] ] , [ [0,1,2,3] ]);
linear_extrude(height = 3) translate([7.2,0,0]) polygon( [ [0,0],[4.1,0],[10.1,20],[6,20] ] , [ [0,1,2,3] ]);
}

module base() {
translate([r,r,0]) circle(r); 
translate([r,(h-r),0]) circle(r); 
translate([(w-r),r,0]) circle(r);
translate([(w-r),(h-r),0]) circle(r); 
translate([r,0,0]) polygon( [ [0,0],[w-2*r,0],[w-2*r,h],[0,h] ] , [ [0,1,2,3] ]);
translate([0,r,0]) polygon( [ [0,0],[w,0],[w,h-2*r],[0,h-2*r] ] , [ [0,1,2,3] ]);
}


module logo_hole(){
    
    translate([4.2,15,-.5]) logo(); 
    translate([4,36,-1]) cylinder(10,1.8,1.8);
}

//cutting out the logo and the hole
difference(){
   
    linear_extrude(height = 1.5) base(); 
    logo_hole(); 
}

translate([12.5,4,0]) linear_extrude(height = 2.25) {
   text(name, font = font, size = 4.5, halign = "center");
  }
  
  
