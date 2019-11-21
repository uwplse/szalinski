//customizer variables
//roof_width=6;   //[4:12]
//roof_length=20;   //[15:40]
//number of pillars on each side
pillars_per_row=7;
floor_width=12;
floor_length=24;
pillar_height=8;
pillar_width=1.2;
pillar_style=0; //[0:No Base, 1:Base]
avoid_extreme_overhangs=-1; //[1:yes,-1:no]
unit = 1; //[1:millimeters,10:centimeters,25.4:inches]

//this union exists for the sake of units
scale(unit) union()
{

//base
translate([floor_width/-2+6,floor_length/-2+12,0]) union()
{
translate([(-1/(10/12))+floor_width/10,(-1/(22/24))+floor_length/22,0]) scale([floor_width*10/12,floor_length*11/12,1.5]) cube(1);
translate([(-1.5/(11/12))+floor_width/11,(-1.5/(23/24))+floor_length/23,0]) scale([floor_width*11/12,floor_length*11.5/12,1]) cube(1);
translate([-2+floor_width/12,-2+floor_length/24,0]) scale([floor_width,floor_length,0.5]) cube(1);
}
//pillars
translate([2+(pillar_width-1.2),2+(pillar_width-1.2),1]) pillar_row();
translate([8-(pillar_width-1.2),2+(pillar_width-1.2),1]) pillar_row();
//roof
translate([1,1,pillar_height+1.25]) scale([8,20,0.5]) cube(1);
translate([1.5,1,pillar_height+1.75]) scale([7,20,0.5]) cube(1);
translate([2,1,pillar_height+2.25]) scale([6,20,0.5]) cube(1);
}
//modules
module pillar()
{
PTopBot();
 translate([0,0,0]) scale([pillar_width/20,pillar_width/20,pillar_height]) cylinder(r=10,h=1);
 
}
module pillar_row()
{
for(prog=[0:pillars_per_row-1])
{
 translate([0,pilldist*prog,0]) pillar();
}
}
module PTopBot()
{
//top
scale((avoid_extreme_overhangs-1)/-2) union()
 {
 translate([0,0,pillar_height-0.25]) scale([pillar_width/12,pillar_width/12,.075]) sphere(10);
 translate([0,0,pillar_height-0.25]) scale([pillar_width/12,pillar_width/12,0.5]) cylinder(r=10,h=1);
}
scale((avoid_extreme_overhangs+1)/2) union()
 {
translate([0,0,pillar_height-0.25]) scale([pillar_width/12,pillar_width/12,pillar_width/12]) sphere(10);
 translate([0,0,pillar_height-0.25]) scale([pillar_width/12,pillar_width/12,0.5]) cylinder(r=10,h=1);
 }
//bottom
translate([]) scale(pillar_style) union()
 {
scale((avoid_extreme_overhangs-1)/-2) union()
 {
 translate([0,0,1]) scale([pillar_width/12,pillar_width/12,.075]) sphere(10);
 translate([0,0,0.5]) scale([pillar_width/12,pillar_width/12,0.5]) cylinder(r=10,h=1);
 }
scale((avoid_extreme_overhangs+1)/2) union()
 {
 translate([0,0,1]) scale([pillar_width/12,pillar_width/12,pillar_width/12]) sphere(10);
 translate([0,0,0.5]) scale([pillar_width/12,pillar_width/12,0.5]) cylinder(r=10,h=1);
 }
 }
}


pilldist=(18-2*(pillar_width-1.2))/(pillars_per_row-1);
