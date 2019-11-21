//Diameter of the hook for hanging the towel
hook_diameter=50; //[20:100]
//Diameter of the hole for the towel
hole_diameter=60; //[20:100]
//Horizontal thickness of the towel hook
hook_thickness=5; 
//Vertical thickness of the towel hook
hook_height=3; 
//Thickness of the flaps for holding the towel. Determines how tight the towel is held
flaps_thickness=.5;// [.5:.5mm, .75:.75mm, 1: 1mm]
//The resolution of the towel hook
resolution=75; //[50:100]
//ignore variable values
$fn=resolution;


hook();
translate([(hole_diameter+10),(hook_diameter-hole_diameter)/-2,0])towel_holder();

module towel_holder(){
difference(){
cylinder(hook_height,(hole_diameter+(hook_thickness*2))/2,(hole_diameter+(hook_thickness*2))/2);
translate([0,0,0])cylinder(hook_height+2,(hole_diameter)/2,(hole_diameter)/2);
}
difference(){
cylinder(flaps_thickness,(hole_diameter)/2,(hole_diameter)/2);
for ( i = [0 : 5] )
{
    rotate( i * 360 / 6, [0, 0, 1])
    translate([0, (hole_diameter-(1/6*hole_diameter))/2, 0])
	hull(){
	translate([0,0,-1])cylinder(hook_height+1,(hole_diameter/6)/4,(hole_diameter/6)/4);
	translate([0,(hole_diameter)/-4,-1])cylinder(hook_height+1,(hole_diameter/6)/4,(hole_diameter/6)/4);
}
}
translate([0,0,-1])cylinder(hook_height+1, (hole_diameter)/6,(hole_diameter)/6);

}
rotate([0,0,360/12]){
for ( i = [0 : 5] )
{
    rotate( i * 360 / 6, [0, 0, 1])
    translate([0, (hole_diameter)/6, 0])
	cylinder(flaps_thickness,(hole_diameter/22.22222222222222),(hole_diameter/22.22222222222222));
}
}
}

module hook(){
difference(){
hull(){
cylinder(hook_height,(hook_diameter+(hook_thickness*2))/2,(hook_diameter+(hook_thickness*2))/2);
translate([(hole_diameter+5)*1.5,0,0])cylinder(hook_height,(hook_diameter+(hook_thickness*2))/2,(hook_diameter+(hook_thickness*2))/2);
}
hull(){
translate([0,0,-1])cylinder(hook_height+2,(hook_diameter)/2,(hook_diameter)/2);
translate([(hole_diameter+5)*1.5,0,-1])cylinder(hook_height+2,(hook_diameter)/2,(hook_diameter)/2);
}
translate([((hook_diameter*2-hole_diameter)/1.5)+(hole_diameter+10)*1.5,0,(hook_height/2)-1])cube([(hook_diameter*2+(hook_thickness*5)),(hook_diameter*2+(hook_thickness*2)),hook_height+3], center = true);
translate([5,0,-1])cube([(hole_diameter+5)*1.5,(hook_diameter+hook_thickness),hook_height+2]);
}
}
