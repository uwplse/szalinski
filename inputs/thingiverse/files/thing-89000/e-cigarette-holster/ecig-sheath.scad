//Length of the clip
clip_length = 50;
//inner length of sheath, length of accu from knob downwards
inner_length = 90;
//inner Diameter, Diameter of accu + some tolerance
inner_dia = 15;
// which part should be rendered?
part = "plate"; //[assy:Assembly,sheath:Sheath only,clip:Clip only,plate:Both parts for printing]

module print_part()
{
if(part=="assy"){
assembly();
}else if(part=="sheath"){
sheath();
}else if(part=="clip"){
clip();
}else if(part=="plate"){
plate();
}
}
module sheath()
{
difference()
{
hull()
{
translate([0,0,-inner_length/2+37.5])
cylinder(r=inner_dia/2+1.5,h=inner_length+16,center=true);
translate([0,inner_dia/2-3,38])
cube([inner_dia+3,10,15],center=true);
}
translate([0,0,-inner_length/2+46.5])
cylinder(r=inner_dia/2,h=inner_length+31,center=true);

translate([4,inner_dia/2,38])
rotate([90,0,0])
cylinder(r=2,h=7,center=true,$fn=16);

translate([4,inner_dia/2-1,38])
rotate([90,0,0])
cylinder(r=3.5,h=4,center=true,$fn=6);

translate([-4,inner_dia/2,38])
rotate([90,0,0])
cylinder(r=2,h=7,center=true,$fn=16);

translate([-4,inner_dia/2-1,38])
rotate([90,0,0])
cylinder(r=3.5,h=4,center=true,$fn=6);

translate([0,0,51])
rotate([37,0,0])
cube([inner_dia*2,inner_dia*3,22],center=true);
}
}

module clip()
{
difference()
{
union()
{
cube([18,15,4],center=false);
translate([0,0,-3])
cube([18,clip_length,3],center=false);
translate([0,clip_length-2,0])
rotate([0,90,0])
cylinder(r=2,h=18,$fn=16);
}
translate([5,7.5,0])
cylinder(r=2,h=15,center=true,$fn=16);
translate([13,7.5,0])
cylinder(r=2,h=15,center=true,$fn=16);

translate([5,7.5,-2.5])
cylinder(r=3,h=2,center=true,$fn=16);
translate([13,7.5,-2.5])
cylinder(r=3,h=2,center=true,$fn=16);
}
}
module plate()
{
sheath();
translate([20,-10,-inner_length+32.5])
clip();
}
module assembly()
{
sheath();
translate([9,17,45.5])
rotate([90,180,0])
clip();
}

print_part();
