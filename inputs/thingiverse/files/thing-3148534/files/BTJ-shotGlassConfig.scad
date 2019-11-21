//shot glass height
//# of ounces
ounces=1;
radius = 15;

module shot() {
difference() {
	cylinder(r1 = radius+2, r2=radius+2, h=((ounces*29573)/(3.14*(radius*radius))), center=false);
	translate([0,0,5]) cylinder(r1 = radius, r2=radius, h=((ounces*29573)/(3.14*(radius*radius))), center=false, $fn=res);
}

}

shot();
