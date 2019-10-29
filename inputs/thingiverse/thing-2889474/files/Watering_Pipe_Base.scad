//The overall cylinder is divided into 3 sections:
// The upper section:  The copper pipe inserts into this section.
// The lower section:  This section is slightly narrower so the pipe will not be able to slide down into this section.  The slots will be removed from this section.
// The base:  This is a solid circle that acts as the base.


//Variables
    
/* [Full Length] */
// Outside diameter of entire cylinder
outside_Diameter = 30;
    
/* [Upper Section] */
//Height of the upper section
upperSection_Height = 45;
//Inside diameter of the upper section (Must be < Outside Diameter)
upperSection_InsideDiameter = 23;
    
/* [Lower Section] */
//Height of the lower section
lowerSection_Height = 30;
//Inside diameter of the lower section (Must be < Outside Diameter)
lowerSection_InsideDiameter = 20.5;
//Inner Lip Height (Distance between lip and top of slots.  Must be < height of the lower section)
innerLip_Height = 5;
//Number of slots.  Must be multiple of 2.
numSlots = 6; //[0:2:50]
//Width of the slots
slot_Width = 7;

/* [Base] */
//Height of the base (Will add to the overall height)
base_Height = 3;
    
//Calcs
    total_Height = base_Height + lowerSection_Height + upperSection_Height;
    slot_Height = lowerSection_Height - innerLip_Height;

//Generate object    
    difference () {
        //Outside Cylinder
        cylinder(h = total_Height, d = outside_Diameter, $fn=50);
        //Cutout lower Cylinder
        translate([0, 0, base_Height])  cylinder(h = lowerSection_Height + .01, d = lowerSection_InsideDiameter, $fn=50);
        //Cutout Upper Cylinder
        translate([0, 0, base_Height + lowerSection_Height]) cylinder(h = upperSection_Height + 2, d = upperSection_InsideDiameter, $fn=50);

        //Cutouts in lower section
        rotationDegrees = 360 / numSlots; 
        translate([0, 0, (slot_Height/ 2) + base_Height]) {
            for (i = [1 : numSlots / 2]) {
                rotate(a = rotationDegrees * i) {
                    cube([outside_Diameter, slot_Width, slot_Height], center = true);
                }
            }
        }
    }
/*
3/4 Inch pipe dimensions
    Inside:         0.811 Inches | 20.5994 mm
    Wall Thickness: 0.032 Inches |  0.8128 mm
    Outside:        0.875 Inches |  22.225 mm
*/