//
//clip();

filter_diameter = 58;
reduction_factor = 2;
generate_handle = true;
handle_radius = 6;
// Load a 100x100 pixel image. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
image_file = "file.dat"; // [image_surface:100x100]


filter_cut(filter_diameter/2,reduction_factor);


module filter_cut(radius, reduction_factor)
{
    $fn=58;
    difference(){
        filter(radius-0.6);
        translate([radius-3.4,-2,0])
            cube([2,6,10], center=true);
        translate([radius-0.9,2,0])
            cube([7,2,10], center=true);
        translate([-(radius-3.4),2,0])
            cube([2,6,10], center=true);
        translate([-(radius-0.9),-2,0])
            cube([7,2,10], center=true);//*/
        resize([radius/reduction_factor,radius/reduction_factor,10]) surface(file=image_file, center=true);
    }
    if (generate_handle) 
    {
        translate([radius-8, 0, 0]) handle(handle_radius);    
    }
}

module handle(handle_radius)
{
    rotate([0,90,0]) difference() {
        cylinder(r=handle_radius, h=2);
        translate([0,-handle_radius,0])cube([handle_radius,2*handle_radius,2]);
    }
}

module filter(radius_transformed) 
{
    cylinder(r=radius_transformed,h=2);
    translate([radius_transformed,0,0])
        cylinder(r=0.7,h=2);
    translate([-radius_transformed,0,0])
        cylinder(r=0.7,h=2);
}