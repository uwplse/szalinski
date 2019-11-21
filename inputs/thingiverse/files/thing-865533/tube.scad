//*RADIUS* (not diameter!) in mm of the hollow part 
inner_radius=16; 

//*RADIUS* (not diameter!) in mm of the tube
outter_radius=19; 

//tube length in mm
length=35; 

//cap the tube on one side and fill it with this amount in mm
cap_length=0; 

/* [Hidden] */
circle=500;

difference(){
    cylinder(r=outter_radius,h=length,$fn=circle);
    translate([0,0,-1])cylinder(r=inner_radius,h=length+2,$fn=circle);
}

if (cap_length>0){
    cylinder(r=outter_radius,h=cap_length,$fn=circle);
}