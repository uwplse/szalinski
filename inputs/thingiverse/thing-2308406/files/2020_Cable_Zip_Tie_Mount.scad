// base height
$bh=5;
// base width
$bw=20;
// metric bolt size
$bolt=5;
// 0=none, 1=align, 2=90 degrees. 
$tabs=0;

// DO NOT EDIT
$fn=50;

module makeTabs () {
    translate([$bw/2 - 6,-3, -2 - $bh/2]) cube([6,6,2]);
    translate([-$bw/2,-3, -2 - $bh/2]) cube([6,6,2]);
}


module createMeniscus(h,radius) // This module creates the shape that needs to be substracted from a cube to make its corners rounded.
difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
   translate([radius/2+0.1,radius/2+0.1,0]){
      cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
   }

   cylinder(h=h+0.2,r=radius,center=true);
}


module roundCornersCube(x,y,z,r)  // Now we just substract the shape we have created in the four corners
difference(){
   cube([x,y,z], center=true);

translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
      rotate(0){  
         createMeniscus(z,r); // And substract the meniscus
      }
   }
   translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
      rotate(90){
         createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
      }
   }
      translate([-x/2+r,-y/2+r]){ // ... 
      rotate(180){
         createMeniscus(z,r);
      }
   }
      translate([x/2-r,-y/2+r]){
      rotate(270){
         createMeniscus(z,r);
      }
   }
}




// MAIN BODY
difference() {
    
    // Base + cylinder
    union() {
        roundCornersCube ($bw,$bw,$bh,$bw/4);
        translate ([$bw*0.425,0,$bw*0.425 + ($bh / 2) - 3.5]) 
            rotate (a=[0,-90,0]) 
            cylinder(h=$bw*0.85,r=$bw*0.425);
    }
    // Hollow out cylinder
    translate ([$bw*0.426,0,$bw*0.425 + ($bh / 2) - 3.5])
        rotate (a=[0,-90,0])
        cylinder(h=$bw*0.852,r=$bw*0.275);

    // bolt head
    translate([0,0,($bolt/2) - 2])
        cylinder(h=$bw,r=$bolt*0.9);
    
    // bolt hole
    translate([0,0,-$bh])
        cylinder(h=$bw,r=$bolt*0.55);
    
    // zip tie hole
    translate([-$bw/8,-$bw/2,$bh/2])
        cube([$bw/4,$bw,2.5]);

    // cut top half of cylinder
    translate([0,0,$bw*0.85])
        cube([$bw,$bw,$bw], center=true);
}


// Add alignment tabs
if ( $tabs == 1 ) {
    makeTabs();
} else if ( $tabs == 2 ) {
    rotate(a=[0,0,90]) makeTabs();
}

