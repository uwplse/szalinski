$fs = 0.01*1;
$fa=1*1;

//outer diameter of pipe
outer_diameter = 25;
// inner diameter of pipe
inner_diameter = 22;
// length of cylinder
length = 30;
// clearing
clearing = 0.2;

cube(size = outer_diameter, center = true);
part();
rotate([0,90,0]) part();
rotate([0,90,90]) part();



//cube(aussen,aussen,aussen);
module part() {
    cylinder(h=outer_diameter/2+length,r=inner_diameter/2-clearing);
}