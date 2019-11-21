////////////////////////////////////////////////
//////////  Parametric bracket  ////////////////
/////////  Strong Blend fillets  ///////////////
/// OpenSCAD File V1.0 by Ken_Applications /////
/////////  OpenSCAD version 2015.03-2 //////////
////////       09 - 12 - 2018              /////
////////////////////////////////////////////////

//Parameters
thick = 5;
center_hole_dia=38.7;
center_hole_height_from_base=55;
width=96;
small_hole_dia=6.3;
small_hole_pitch=47.2;
fillet_rad=12;

//Default values for Nema 23 Stepper motor below///
//thick = 5;
//center_hole_dia=38.7;
//center_hole_height_from_base=55;
//width=96;
//small_hole_dia=6.3;
//small_hole_pitch=47.2;
//fillet_rad=12;








module 2_ext_rad (filet_rad,width,hgt,rot,rot2){
    rotate([rot2,0,rot])
    translate([-width/2+filet_rad,0,0])
linear_extrude(height=hgt)
difference(){
translate([-(filet_rad*2),0,0]) square([width+filet_rad*2,filet_rad*2],false);   
hull(){
circle(r=filet_rad);
translate([width-filet_rad*2,0,0]) circle(r=filet_rad);
}
}
}

///calculations/////
$fn = 100;
hole_pos=small_hole_pitch/2;
adj_height=(width/2)-center_hole_height_from_base;
///////////////////



module plate(){
difference(){
  	cube([thick,width,width+0],true);
    
    translate([0,0,-(thick/2)-adj_height]){
	translate([-(thick/2)-1,0,0]) rotate([0,90,0]) cylinder(d=center_hole_dia,h=thick+2);
    //4 small holes
    translate([-(thick/2)-1,hole_pos,hole_pos]) rotate([0,90,0]) cylinder(d=small_hole_dia,h=thick+2);
    translate([-(thick/2)-1,-hole_pos,hole_pos]) rotate([0,90,0]) cylinder(d=small_hole_dia,h=thick+2);
    translate([-(thick/2)-1,hole_pos,-hole_pos]) rotate([0,90,0]) cylinder(d=small_hole_dia,h=thick+2);
    translate([-(thick/2)-1,-hole_pos,-hole_pos]) rotate([0,90,0]) cylinder(d=small_hole_dia,h=thick+2);
    }
}

}

module plate_minus_big_hole(){
difference(){
  	cube([thick,width,width+thick],true);
    
    translate([0,0,thick]){
	//translate([-(thick/2)-1,0,0]) rotate([0,90,0]) cylinder(d=center_hole_dia,h=thick+2);
    //4 small holes
    translate([-(thick/2)-1,hole_pos,hole_pos]) rotate([0,90,0]) cylinder(d=small_hole_dia,h=thick+2);
    translate([-(thick/2)-1,-hole_pos,hole_pos]) rotate([0,90,0]) cylinder(d=small_hole_dia,h=thick+2);
    translate([-(thick/2)-1,hole_pos,-hole_pos]) rotate([0,90,0]) cylinder(d=small_hole_dia,h=thick+2);
    translate([-(thick/2)-1,-hole_pos,-hole_pos]) rotate([0,90,0]) cylinder(d=small_hole_dia,h=thick+2);
    }
}

}


module fillet_rad (){
difference(){
 translate([thick/2-0.1,width/2,thick]) rotate([0,0,-90]) cube([width,fillet_rad,fillet_rad],false);
 translate([(thick/2)+fillet_rad,width/2+1,fillet_rad+thick]) rotate([90,0,0]) cylinder(r=fillet_rad,h=width+2);
}
}


module bot_fillet (){
translate([width/2,-(width/2)-(thick/2)+thick-0.1,0]) rotate([0,0,90]) fillet_rad ();
translate([width/2,(width/2)-(thick/2)+0.1,0]) rotate([0,0,-90]) fillet_rad ();
}

module side(){
difference(){
translate([0,thick/2,0]) rotate([0,0,-90]) cube([thick,width,width],false);
translate([width+thick/2,thick/2+1,width+thick]) rotate([90,0,0]) cylinder(r=width,h=thick+2);
}
}


module all_no_rads (){
translate([0,0,(width/2)+thick/2]) plate();

difference(){
rotate([0,90,0]) translate([-thick/2,0,width/2]) plate_minus_big_hole();
//slots
translate([width/2+thick,small_hole_pitch/2,0]) cube([small_hole_pitch,small_hole_dia,width+thick],true);
translate([width/2+thick,-small_hole_pitch/2,0]) cube([small_hole_pitch,small_hole_dia,width+thick],true);
}

fillet_rad ();


translate([0,width/2-thick/2,0]) side();
translate([0,-width/2+thick/2,0]) side();

difference(){
bot_fillet ();
translate([width+thick/2,thick/2+width/2,width+thick]) rotate([90,0,0]) cylinder(r=width,h=width+2);
}

difference(){
translate([-thick/2,0,0]) rotate([0,-90,180]) bot_fillet ();
translate([width+thick/2,thick/2+width/2,width+thick]) rotate([90,0,0]) cylinder(r=width+0.1,h=width+2);
}

}

difference(){
all_no_rads ();
translate([-thick,0,width-fillet_rad]) 2_ext_rad(fillet_rad,width,thick*10,90,90);
translate([width-fillet_rad,0,-.1]) 2_ext_rad(fillet_rad,width,thick*10,270,0);
    
}





