//Changelog:
//V1.1 Added centerlines where missing on the sides. 8/14/17

$fa=6*1;
$fs=0.5*1;

// Stile Width (in inches)
x_in=1.5625;

// Bottom Hole (in inches)
y_in=2.89; //2.875

// Plate Thickness (in inches)
z_in=0.5;

// Lip Thickness (in inches)
lip_in=0.1875;

// Hole Diameter (in inches)
d_in=0.1975; //0.1975 fits 3/16" drill bit well

// Center to Center in inches
CTC_in=3.02;

// Width of center rail
a_in=0.625;

mm_per_inch=25.4*1;
x_mm = x_in*mm_per_inch; 
y_mm = y_in*mm_per_inch; 
z_mm = z_in*mm_per_inch; 
lip_mm = lip_in*mm_per_inch; 
d_mm = d_in*mm_per_inch; 
CTC_mm = CTC_in*mm_per_inch; 
a_mm = a_in*mm_per_inch;
//total_height=(CTC+1+z_in)*mm_per_inch;
difference()
{
    union() {
    
    // build center rail
    linear_extrude(z_mm) 
    translate([(x_mm/2)-(a_mm/2),0,0])   
    square([a_mm, (lip_mm+y_mm+CTC_mm+15)]);    
    
    // build crossbeams
    linear_extrude(z_mm) 
    translate([0,lip_mm,0])   
    square([x_mm, a_mm]);
        
    linear_extrude(z_mm) 
    translate([0,lip_mm+y_mm+CTC_mm+15-a_mm,0])   
    square([x_mm, a_mm]);
        
    linear_extrude(z_mm) 
    translate([0,((lip_mm+y_mm+CTC_mm+15)/2)-(a_mm/2),0])   
    square([x_mm, a_mm]);    
        
    // build main plate
    //linear_extrude(z_mm) 
    //square([x_mm, (lip_mm+y_mm+CTC_mm+15)]);

    // build lip
    //translate([0,0,z_mm]) 
    linear_extrude((0.75*mm_per_inch)+z_mm) 
    square([x_mm, (lip_mm)]);
    }

    // Drill bottom hole
    translate ([(x_mm/2), (lip_mm+y_mm), 0])
    cylinder(h=z_mm*4, d=d_mm, center=true);


    // Drill top hole
    translate ([(x_mm/2), (lip_mm+y_mm+CTC_mm), 0])
    cylinder(h=z_mm*4, d=d_mm, center=true);
    
    // Draw Centerline Mark #1
    translate ([0, lip_mm+y_mm+(CTC_mm/2)-(0.5/2), z_mm-0.5])
    linear_extrude(0.5)
    square([x_mm, 0.5]);

    // Draw Centerline Mark #2
    translate ([(x_mm/2)-(0.5/2), lip_mm, z_mm-0.5])
    linear_extrude(0.5)
    square([0.5,(y_mm+CTC_mm+15)]);
    
    // Draw Centerline Mark #3
    translate ([(x_mm/2)-(0.5/2), 0, (0.75*mm_per_inch)+z_mm-0.5])
    linear_extrude(0.5)
    square([0.5,(lip_mm)]);
    
    // Draw Centerline Mark #4
    translate ([(x_mm/2)-(0.5/2), lip_mm-0.5, z_mm])
    linear_extrude((0.75*mm_per_inch))
    square([0.5,0.5]);
    
    // Draw Centerline Mark #5
    translate ([(x_mm/2)-(0.5/2), 0, 0])
    linear_extrude(z_mm+(0.75*mm_per_inch))
    square([0.5,0.5]);
    
    // Draw Centerline Mark #6
    translate ([(x_mm/2)-(0.5/2), lip_mm+y_mm+CTC_mm+15-0.5, 0])
    linear_extrude(z_mm)
    square([0.5,0.5]);
    
    // Draw Centerline Mark #7 Horizontal Left Side
    translate ([(x_mm/2)-(a_mm/2), lip_mm+y_mm+(CTC_mm/2)-(0.5/2), 0])
    linear_extrude(z_mm)
    square([0.5,0.5]);
    
    // Draw Centerline Mark #8 Horizontal Right Side
    translate ([(x_mm/2)+(a_mm/2)-0.5, lip_mm+y_mm+(CTC_mm/2)-(0.5/2), 0])
    linear_extrude(z_mm)
    square([0.5,0.5]);
}