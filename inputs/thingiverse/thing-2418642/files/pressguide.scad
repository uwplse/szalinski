//CUSTOMIZER VARIABLES
//bit radius mm
bit_radius=4; 
//rod radius mm
rod_radius=13; 
//CUSTOMIZER VARIABLES END

difference(){
    cylinder(h=25,$fn=50,r=rod_radius+2,center=true);
    union(){
        translate([0,0,6.5])cylinder(h=13, $fn=50, r=rod_radius, center=true);
        translate([0,0,-6.5])cylinder(h=14, $fn=50, r=bit_radius, center=true);
    }
}