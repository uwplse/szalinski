$fn=64;

heigth_foot = 6;
initial_falcon_length = 200;
printed_falcon_length = 180;
scale_ratio = printed_falcon_length/initial_falcon_length;

pilar_diameter = 10;
Falcon_altitude = 60;

pilar_fork_height = 30;

falcon_x_angle = 10;
falcon_y_angle = -25;

//--------------------------------------------------------------------------------------//

module foot(){

//#translate([0,10,0]) cylinder(d1=75, d2=70, h=heigth_foot);

linear_extrude(height=heigth_foot, center=false, convexity=10, scale=[0.8,0.8])  {
                                        scale([1.1,1.1,0])  import("rebel_symbol.dxf");
                         }

}
   
module fake_falcon(){
translate([0,0,Falcon_altitude+25]) rotate([falcon_x_angle,falcon_y_angle,0]) cube([180,130,50], center=true);         
}
 
module pilar(){
//main pilar
cylinder(d=pilar_diameter, h=Falcon_altitude-pilar_fork_height);

// 3 fork support
translate([0,0,Falcon_altitude-pilar_fork_height]) rotate([0,-10,0]) for (i=[0:3]) rotate([42,0,(i*360/3)-30])  cylinder(d=6, h=pilar_fork_height+20);

//junction sphere
translate([0,0,Falcon_altitude-pilar_fork_height]) sphere(d=10);

}

//----------------------------------------------------------------------------//

foot();
difference(){
	pilar();
	fake_falcon();
};

//#falcon();