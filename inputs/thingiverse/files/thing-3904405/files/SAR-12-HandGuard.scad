$fn = 250;

outer_d = 51;
inner_d = 44;
hight   = 225;
body();

module body()
{
    difference()
    {
        union()
        {
            cylinder(d=outer_d, h=hight);
            translate([0,outer_d/2+4,112.4]) rail(22);
            //rotate([0,0,90]) translate([0,outer_d/2+4,127.4]) rail(20);
            rotate([0,0,180]) translate([0,outer_d/2+4,112.4]) rail(22);
            
            //rotate([0,0,270]) translate([0,outer_d/2+4,137.4]) rail(18);
        }
        
        cylinder(d=inner_d, h=hight);
        
        translate([0,0,6])rotate([0,90,0]) cylinder(d=5.5, h=outer_d);
        translate([0,0,19])rotate([0,90,0]) cylinder(d=5.5, h=outer_d);
    }
}

module rail(sections) 
{
	translate(v = [0, 0, -5 * sections - 2.5])
        difference() 
        {
		linear_extrude(height = (10.0076 * (0.5 + sections)))
               railprofile();
            translate([0,-0.6,0])
		union() {
			for (s = [1:sections]) {
				translate(v = [0, 0, s * 10.0076 - 10.0076/2.0])
                           #linear_extrude(height = 5.334)
                             cutprofile();
			}
		}
	  }
}

module railprofile() 
{
    extra_height = 1.4;
	polygon(points=[[-10.6,0],[-8.4,2.2],[8.4,2.2],[10.6,0],[7.8,-2.8],[7.8,-3.8-extra_height],[-7.8,-3.8-extra_height],[-7.8,-2.8]], paths=[[0,1,2,3,4,5,6,7,0]]);
}

module cutprofile() 
{
	polygon(points=[[-12, -0.8], [-12, 3], [12, 3], [12, -0.8]], paths=[[0,1,2,3,0]]);
}