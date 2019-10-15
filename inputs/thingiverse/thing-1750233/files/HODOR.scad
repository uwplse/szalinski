/*[Global]*/

//---length = 0;

/*[Dimensions]*/

//Select a value larger than the width of your door, at least on 10 millimeters
platform_length = 50; //[10:100]

//height of pring platform. it should be highter then distance from floor to door on few mm
height = 15; // [10:40]
//thickness of door holder base
height_base = 8.5; // [2.5:30]
//width of door holder
width = 10; // [10:40]

/*[Other settings (better to do not change them:)]*/

//thickness of spring, for me 2.5 is good
thickness = 2; // [1.5:3.5]
//Radius of holder springs. ~10mm is fine
r_spring = 8; //[5:15]
//Divider of spring radius, it is actualy works with values from 2.1 to 2.9. I prefer to use r_divider = 2.4
r_divider = 2.4;
//Do you wanna add ribs?
is_reinforced = 1; // [0:no,1:yes]

/*[Hidden]*/
length = platform_length + 4 * r_spring;


// ------------------



draw_part();

module draw_part() {
    cube([length, width, height_base]);  // BASE
    /* SUPPORTS */
    translate([0, 0, height_base]) 
    cube([thickness, width, height - height_base + r_spring - thickness]);
    if (is_reinforced == 1) { translate([thickness, width/2, height_base]) cylinder(h=height  - height_base + r_spring, r=thickness/2); }
    
    translate([length-thickness, 0, height_base]) 
    cube([thickness, width, height - height_base + r_spring - thickness]);
    if (is_reinforced == 1) { translate([length-thickness, width/2, height_base]) cylinder(h=height - height_base + r_spring, r=thickness/2); }
    /* -SUPPORTS- */
    
    /* SPRINGS */
    translate([0,0,height+r_spring-thickness])  draw_spring();
    translate([length,0,height+r_spring-thickness]) mirror([1,0,0]) { draw_spring(); }
    /* -SPRINGS- */
    
    /* PLATFORM */
    translate ([-r_spring/r_divider*4+r_spring*3+thickness,0,height-thickness]) 
    cube([length-2*(-r_spring/r_divider*4+r_spring*3+thickness),width,thickness]);
    translate([length/2, width/2, height-thickness]) 
    
    if (is_reinforced == 1) { rotate([0, 90, 0]) cylinder(h=length-2*(-r_spring/r_divider*4+r_spring*3+thickness), r=thickness/2,center = true); }
    /* PLATFORM */
    

}

module draw_spring() {
   translate([r_spring, 0, 0]) {
       difference() {
           rotate([-90, 0, 0]) cylinder(h=width, r=r_spring);
           rotate([-90, 0, 0]) cylinder(h=width+2, r=r_spring-thickness);
           translate([-r_spring, -1, -r_spring])
           cube([r_spring*2,width+2,r_spring]);
       } 
   }
   translate([-r_spring/r_divider+r_spring*2, 0, 0]) {
       difference() {
           rotate([-90, 0, 0]) cylinder(h=width, r=r_spring/r_divider);
           rotate([-90, 0, 0]) cylinder(h=width+2, r=r_spring/r_divider-thickness);
           translate([-r_spring/r_divider, -1, 0])
           cube([r_spring,width+2,r_spring/r_divider]);
           
       }
    }
    
    translate([-r_spring/r_divider*3+r_spring*2+thickness, 0, 0]) {
        //rotate([-90, 0, 0]) cylinder(h=width+2, r=0.5);
        difference() {
           rotate([-90, 0, 0]) cylinder(h=width, r=r_spring/r_divider);
           rotate([-90, 0, 0]) cylinder(h=width+2, r=r_spring/r_divider-thickness);
           translate([-r_spring/r_divider, -1, -r_spring])
           cube([r_spring,width+2,r_spring]);
           
       }
    }
    
 //   translate([r_spring/r_divider*3+thickness*1.4, 0, height+r_spring]) {
    translate([-r_spring/r_divider*4+r_spring*3+thickness, 0, 0]) {
       //rotate([-90, 0, 0]) cylinder(h=width+2, r=0.5);
       difference() {
           rotate([-90, 0, 0]) cylinder(h=width, r=r_spring);
           rotate([-90, 0, 0]) cylinder(h=width+2, r=r_spring-thickness);
           translate([-r_spring, -1, 0])
           cube([r_spring*2,width+2,r_spring]);
           translate([0, -1, -r_spring])
           cube([r_spring,width+2,r_spring]);
           
       }
    }
}
