//filament holder spindle
//Rick Fray, 3/5/2016

/******** USER VARIABLES ************/
/* Outer hub radius */
outer_radius = 35; // [outer_radius must be > than inner_radius]

/* Inner hub radius - the part that fits in filament reel hole */
inner_radius = 16; // [inner_radius must be < than outer_radius. 28 is close for 1KG reel; 16 for Sainsmart .8kg reel] 

/* Spindle bolt hole radius - 1/4" bolt would be 4 mm */
bolt_radius = 4;

/* Outer hub thickness */
outer_thickness = 4; //outer_thickness must be less than inner_thickness

/* Inner hub thickness */
inner_thickness = 8; //inner_thickness must be less than outer_thickness

difference(){
union(){
cylinder(outer_thickness,outer_radius,outer_radius,$fn=40);
cylinder(inner_thickness,inner_radius,inner_radius,$fn=40);
    }
cylinder (inner_thickness,bolt_radius,bolt_radius,$fn=40);
}





