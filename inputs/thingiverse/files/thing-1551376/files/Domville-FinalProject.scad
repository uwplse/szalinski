bridge = 18; // [14:24]
lensheight = 45; // [24:40]
lenswidth = 62; //  [40:62]
thickness = 10; // [3:10]
framewidth = 2*bridge + (lenswidth*1.25);
module glassesframe()
{
// Bridge
    difference() {
        translate([.25*(bridge),0,0])
        cube([(bridge),2*bridge,thickness],center = true);
        translate([bridge,0,0])
        cylinder(h = thickness+1, r = bridge, center = true);
    }
// Right Lens
    difference(){
        translate([bridge/2,framewidth/2,0])
        cube([1.25*(lensheight),1.25*(lenswidth),thickness],center = true);
        translate([bridge/2,framewidth/2,0])
        cube([lensheight,lenswidth,thickness+1], center = true);
    }
// Left Lens
    difference(){
        translate([bridge/2,-(framewidth/2),0])
        cube([1.25*(lensheight),1.25*(lenswidth),thickness],center = true);
        translate([bridge/2,-(framewidth/2),0])
        cube([lensheight,lenswidth,thickness+1], center = true);
    }
// Right Screw Holes  
    difference(){
        translate([.25*bridge-2,(framewidth-bridge),.75*thickness])
        rotate([90,0,90])
        cylinder(h = 2, r = 4, center = true);
        translate([.25*bridge-2,(framewidth-bridge),.75*thickness])
        rotate([90,0,90])
        cylinder(h = 3, r = 2, center = true);
    }
    difference(){
        translate([.25*bridge+2,(framewidth-bridge),.75*thickness])
        rotate([90,0,90])
        cylinder(h = 2, r = 4, center = true);
        translate([.25*bridge+2,(framewidth-bridge),.75*thickness])
        rotate([90,0,90])
        cylinder(h = 3, r = 2, center = true);
    }
//Left Screw Holes
    difference(){
        translate([.25*bridge-2,-(framewidth-bridge),.75*thickness])
        rotate([90,0,90])
        cylinder(h = 2, r = 4, center = true);
        translate([.25*bridge-2,-(framewidth-bridge),.75*thickness])
        rotate([90,0,90])
        cylinder(h = 3, r = 2, center = true);
    }
    difference(){
        translate([.25*bridge+2,-(framewidth-bridge),.75*thickness])
        rotate([90,0,90])
        cylinder(h = 2, r = 4, center = true);
        translate([.25*bridge+2,-(framewidth-bridge),.75*thickness])
        rotate([90,0,90])
        cylinder(h = 3, r = 2, center = true);
    }
//Screw Hole Platforms
    translate([.25*bridge,framewidth-bridge,0])
    cube([lensheight/3,lensheight/3,thickness], center = true);
    translate([.25*bridge,-(framewidth-bridge),0])
    cube([lensheight/3,lensheight/3,thickness], center = true);
}

glassesframe();

templelength = 135; //    [120:150]
module temple()
{
//  Right Arm
      difference(){
          translate([104,lensheight+2,lensheight/6])
          cylinder(h = 2, r = 4, center = true);
          translate([104,lensheight+2,lensheight/6])
          cylinder(h = 3, r = 2, center = true);    
      }
      difference(){
          translate([100,49,0])
          cube([templelength,lensheight/6,lensheight/3]);  
          translate([templelength+60,lensheight,-40])
          rotate([90,0,0])
          cylinder(h=30, r=50, center = true);
            
          }
//  Left Arm
      difference(){
          translate([104,-lensheight+2,lensheight/6])
          cylinder(h = 2, r = 4, center = true);
          translate([104,-lensheight+2,lensheight/6])
          cylinder(h = 3, r = 2, center = true);    
      }
      difference(){
          translate([100,-53,0])
          cube([templelength,lensheight/6,lensheight/3]);  
          translate([templelength+60,-lensheight,-40])
          rotate([90,0,0])
          cylinder(h=30, r=50, center = true);
            
          }
}

  temple();