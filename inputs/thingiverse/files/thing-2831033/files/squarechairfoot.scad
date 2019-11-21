//Front part of leg width
legX=25;
//Side oart if leg width
legY=25;
//Foot height
legZ=20;
//Round Bottom diameter
bottomD=28;
//Bottom thickness
bottomthick=6;
//Side Thickness
SideThick=2;

difference(){
FootShape(legX,legY,legZ,bottomD,bottomthick) ;
translate([0,-0,-bottomthick])
FootShape((legX-SideThick),(legY-SideThick),legZ,bottomD,bottomthick) ;
}

module FootShape(legX,legY,legZ,bottomD,bottomthick){
    adjustmentxy=16;
    hull(){
    linear_extrude(height = legZ, twist = 0, slices = 50) {
       difference() {
         offset(r = 9) {
          square([legX-adjustmentxy,legY-adjustmentxy], center = true);
         }
         offset(r = 8) {
           square([legX-adjustmentxy,legY-adjustmentxy], center = true);
         }
       }
     }
     translate([0,-0,18])
     //cylinder(d=bottomD,h=bottomthick);
     OvalCylinder(legX,legY,bottomthick);
     }
    }

 module OvalCylinder(x,y,z){
     translate([0,(-(x-y)/2),0])
//     echo(x,y,x-y)
  //   echo(y)
//     echo(x-y)
     linear_extrude(height = z,  twist = 0, slices = 50) {
    hull() {
        translate([0,x-y,0]) circle(d=x);
        circle(d=x);
    }
     }
 } 