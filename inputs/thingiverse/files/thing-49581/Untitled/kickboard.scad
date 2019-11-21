length=17.5; //[8:35]
width=15; //[5:30]
thickness=1; //[1:4]
difference()
{
union()
{
scale(0.1) cylinder(r=width*5,h=thickness*10);
translate([width/-2,0,0]) scale([width,length-(width/2),thickness]) cube(1);
translate([(width/-2)+1.25,length-(width/2),0]) scale([width-2.5,1.25,thickness]) cube(1);
translate([(width/-2)+1.25,length-(width/2),0]) scale(0.1) cylinder(r=12.5,h=thickness*10);
translate([(width/2)-1.25,length-(width/2),0]) scale(0.1) cylinder(r=12.5,h=thickness*10);
}
}