width=22.7;
length=33.7;
thickness=4;
end_rad=35;
no_teeth=20;
tooth_depth=1;
hole_depth=25;

b=width;
l=length;
gods=thickness;
angle=asin((l/2+gods)/end_rad);

points=[for (a=[angle:-2*angle/no_teeth:-angle]) for (b=[0:1]) (end_rad+tooth_depth*b)*[cos(a-(b*angle/no_teeth)),sin(a-(b*angle/no_teeth))]];
    
polypoints=concat([[end_rad*cos(angle),-end_rad*sin(angle)],[end_rad*cos(angle)-gods-hole_depth,-end_rad*sin(angle)],[end_rad*cos(angle)-gods-hole_depth,end_rad*sin(angle)]], points);

rotate([0,-90,0]) difference() {
linear_extrude(b+2*gods,convexity=10) translate([-end_rad*cos(angle)+gods+hole_depth,0,0]) polygon(polypoints);
translate([0,-l/2,gods]) cube([hole_depth,l,b]);
}
