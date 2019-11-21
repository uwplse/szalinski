
//solder station part radius
holder_r = 14;
// solder station part height
holder_h = 4;

// top part radius
holder_top_r = 18;
// top part height
holder_top_h = 5;


// bearing radius
bearing_r = 11;
// bearing part height
bearing_h = 7;
// bearing part inner radius
bearing_inner_r = 6;

//solder station part thickness
adapter_t = 5;

//clearance
cl=0.1;

$fn=100;

difference (){
    union(){
        cylinder(r=holder_r, h=holder_h, center=true);
       
        translate([0, 0, holder_h/2+holder_top_h/2-cl])
        cylinder(r=holder_top_r, h=holder_top_h, center=true);
    }
    union(){
        translate([0, 0, bearing_h/2+2])
        cylinder(r=bearing_r+cl, h=bearing_h, center=true);

        translate([0, 0, -2])
        cylinder(r=holder_r-adapter_t/2, h=holder_h+cl, center=true);

        cylinder(r=bearing_inner_r, h=100, center=true);
    }
}