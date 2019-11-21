pipedia = 13.8;
pvc3_4 = 10.5;//1/2 of 19mm = 9.5
pvclength = 30;//95;// 4 in max = 101.6mm
angle = 67.5;
side =  (2*pvc3_4)*cos(angle);//c cos(t)
ta = 2*(pvc3_4/tan(angle));
x = side/(sqrt(2));
blue = 2*x+side;
rotate([22.5,0,0])
rotate([0,90,0])
translate([0,0,18])
cylinder(h = pvclength, r1=pvc3_4, r2 = pvc3_4, $fn=8);
difference(){
cube([36, 40,blue], center=true);//(2*pvc3_4)-2//ta//side
translate([0,-3,0]){
cube([22, 35, 22], center=true);}; 
}

//translate([0,0,-15])attach();

module myhull(h=8, r=70, mangl=15){
  difference(){
  hull(){
    cylinder(h = h, r1=r, r2 = r, $fn=3);
    rotate([0,0,15]){
       cylinder(h = h, r1 = (r-2), r2 =  (r-2), $fn=3);};
    rotate([0,0,-15]){
      cylinder(h = h, r1 = (r-2), r2 = (r-2), $fn=3);};
    rotate([0,0,-7]){
      cylinder(h = h, r1 = r, r2 = r, $fn=3);};
    rotate([0,0,7]){
      cylinder(h = h, r1 = r, r2 = r, $fn=3);};
      };
    };
};

attachoff = 3.5;

module attach(){
translate([45,0,pipedia+attachoff]){
  rotate([0,90,0]){
    outerdiameter = (pipedia+2);
    supportradius = pipedia+2;//1.9;
    screwzoff = pipedia+2.5;
    difference(){
      union(){
      cylinder(h = 20, r1 = (pipedia+2), r2 = (pipedia+2));
        translate([-1.5,-supportradius,0]){
        cube([17,(2*supportradius),4]);//cube([17,30.8,4]);//, center=true);
        };
        translate([-1.5,-supportradius,16]){
        cube([17,(2*supportradius),4]);//30.8,4]);//, center=true);
        };
        rotate([0,0,90]){
        translate([0,screwzoff,10]){
        cube([10,10,10], center=true);
        };
      };
  };
  rotate([0,0,90]){
      cylinder(h = 20, r1 = pipedia, r2 = pipedia);
     translate([0,25,10]){
     rotate([90,0,0]){
     cylinder(h=25, r1 =screwsize, r2= screwsize);
     };
   };
 };
    };
  };

};
}
