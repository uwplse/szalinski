pipedia = 13.8;
attachoff = 3.5;
screwsize = 2.3;
pvc3_4 = 10.5;
pvc3_4off = pvc3_4 + 1;

endcap();

module endcap(){
  rotate([0,0,0]){
    outerdiameter = (pipedia+4);
    supportradius = pipedia+2;//1.9;
    screwzoff = pipedia+2.5;
    difference(){
      union(){
      cylinder(h = 20, r1 = outerdiameter, r2 = outerdiameter);
        translate([-1.5,-supportradius,0]){
        //cube([17,(2*supportradius),4]);//cube([17,30.8,4]);//, center=true);
        };
        translate([-1.5,-supportradius,16]){
        //cube([17,(2*supportradius),4]);//30.8,4]);//, center=true);
        };
        rotate([0,0,90]){
        translate([0,screwzoff,5]){
        cube([10,10,10], center=true);
        };
      };
  };
  rotate([0,0,0]){
     translate([0,0,-5]){
      cylinder(h = 20, r1 = pipedia, r2 = pipedia);
     };
     cylinder(h = 20, r1 = pvc3_4off, r2 = pvc3_4off);
     translate([0,0,5]){
     rotate([0,-90,0]){
     cylinder(h=25, r1 =screwsize, r2= screwsize);
     };
   };
 };
    };
  };
}