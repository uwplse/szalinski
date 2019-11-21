// v 0.2

$fn = 50;

input_external_radius = 31;
input_internal_radius =  29;
input_width = 20;


output_external_radius = 34;
output_internal_radius =  32;
output_width = 10;

adapt_width = 4;

echo (str("Total width = ", output_width + input_width + adapt_width, " mm"));
union(){
    difference(){
        cylinder(input_width, d1=input_external_radius, d2=input_external_radius);
        cylinder(input_width, d1=input_internal_radius, d2=input_internal_radius);
    }

    translate([0,0, -adapt_width])
    difference(){
        cylinder(adapt_width, d2=input_external_radius, d1=output_external_radius);
        cylinder(adapt_width, d2=input_internal_radius, d1=output_internal_radius);
    }

    translate([0,0, -output_width -adapt_width])
    difference(){
        cylinder(output_width, d1=output_external_radius, d2=output_external_radius);
        cylinder(output_width, d1=output_internal_radius, d2=output_internal_radius);
    }
}