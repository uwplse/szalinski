$fa=6*1;
$fs=0.5*1;

// Stile Width (in inches)
x_in=3.0;

// Bottom Hole (in inches)
y_in=3.0;

// Thickness (in inches)
z_in=0.5;

// Hole Diameter (in inches)
d_in=0.165;

// Center to Center in inches
CTC_in=3.77;

mm_per_inch=25.4*1;
x_mm = x_in*mm_per_inch; 
y_mm = y_in*mm_per_inch; 
z_mm = z_in*mm_per_inch; 
d_mm = d_in*mm_per_inch; 
CTC_mm = CTC_in*mm_per_inch; 
//total_height=(CTC+1+z_in)*mm_per_inch;
difference()
{
    union() {
    // build main plate
    linear_extrude(z_mm) 
    square([x_mm, (z_mm+y_mm+CTC_mm+15)]);


    translate([0,0,-0.75*mm_per_inch]) 
    linear_extrude(0.75*mm_per_inch) square([x_mm, (z_mm)]);
    }

    // Drill bottom hole
    translate ([(x_mm/2), (z_mm+y_mm), 0])
    cylinder(h=z_mm*4, d=d_mm, center=true);


    // Drill top hole
    translate ([(x_mm/2), (z_mm+y_mm+CTC_mm), 0])
    cylinder(h=z_mm*4, d=d_mm, center=true);
}