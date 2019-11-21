/* [The knobby bit at the end of the handle] */

Handle_End_Length = 0.4;
Radius_of_Handle_End = 1;
Amount_of_Handle_End_Taper=0.25;

/* [Handle] */
Handle_Radius=0.5;
Handle_Length= 11;

/* [Tapered part] */

Taper_Length= 13;

/* [Barrel] */

Barrel_Length= 9;
Barrel_Radius= 1;


/* [Hidden] */
$fn=150;

l_handleod = Handle_End_Length ;
r_handleod = Radius_of_Handle_End;

l_handletaper=Amount_of_Handle_End_Taper;

r_handle=Handle_Radius;
l_handle= Handle_Length;
l_taper= Taper_Length;
l_barrel= Barrel_Length;
r_barrel= Barrel_Radius;


rotate([0,90,0]){
union() { 
//handle end grip thing
cylinder(r=r_handleod, h=l_handleod);
resize([r_handleod*2,r_handleod*2,l_handleod]){
	sphere(r=r_handleod);
}

translate([0,0,l_handleod]) resize([r_handleod*2,r_handleod*2,l_handleod]){
	sphere(r=r_handleod);
}


// handle
translate([0,0,l_handleod]) cylinder(r=r_handle, h=l_handle);


// taper
translate([0,0,l_handleod+l_handle]) cylinder(r=r_handle, r2=r_barrel ,h=l_taper);

// barrel

translate([0,0,l_handleod+l_handle+l_taper]) cylinder(r=r_barrel ,h=l_barrel);


}
}