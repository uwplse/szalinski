//Changelog:


$fa=6*1;
$fs=0.5*1;

// Stile Width (in mm)
x_mm=39.6875;

// Bottom Hole (in mm)
y_mm=73.406; 

// Plate Thickness (in mm)
z_mm=12.7;

// Lip Thickness (in mm)
lip_mm=4.7625;

// Hole Diameter (in mm)
d_mm=5.0165; 

// Center to Center in mm
CTC_mm=76.708;

// Width of center rail (in mm)
a_mm=15.875;

mm_per_inch=25.4*1;
  

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