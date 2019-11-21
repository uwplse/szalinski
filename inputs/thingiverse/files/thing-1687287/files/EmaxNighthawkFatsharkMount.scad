$fn=100*1;
//desired angle
angle=25;  // [0:35]
//verical offset of camera
voff=3; //[-4:5,]
//Thickness of angled prortion
setback=10.5; //[-8:20]

tw=8.5*1;
tc=8.5*1;
th=2*1;


difference(){
    union(){
        //Main plate
        cube([40,35,th],center=true);
        //Tabs
        translate([tc,0,0])
         cube([8,39,th],center=true);
        mirror([1, 0, 0])
         translate([tc,0,0])
          cube([8,39,th],center=true);     
        //Angle
        rotate([angle,0,0])
         translate([0,voff,0])
         cube([24,24,12-(11-setback)],center=true);
    }
    
    //cam hole
    rotate([angle,0,0])
     translate([0,voff,0])
      cylinder(h=50,r=9,center=true);
    
    //clean up the front
    translate([-25,-25,-50])
     cube([50,50,50]);
}
