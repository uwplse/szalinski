//Bearing adapter

//outer diameter of adapter (inner diameter of bearing)
outer_diameter = 7.975;

//inner diameter of adapter
inner_diameter = 5.15;

//bearing width
bearing_width = 7;


/*[Hidden]*/

difference() {
    cylinder (d=outer_diameter,h=bearing_width,center=true,$fn=50);
    cylinder (d=inner_diameter,h=bearing_width+1,center=true,$fn=50);
}