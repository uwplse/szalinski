//Bearing cap for fidget spinners

/* [Bearing Dimensions] */
bearing_thickness=7; // 
bearing_outer_diameter=22; // 
bearing_inner_diameter=8; // 
/* [Cap Parameters] */
plate_thickness=1.3; // 
air_gap=0.5; // 
oversize_for_clamping=0.4; // 
oversize_main_plate=0; // 
/* [Hidden] */
phase=min(plate_thickness/2,1); 

$fn = 100;
cylinder(phase,d1=bearing_outer_diameter+oversize_main_plate-phase*2,d2=bearing_outer_diameter+oversize_main_plate,center=false);
translate([0,0,phase]){
cylinder(plate_thickness-phase,d=bearing_outer_diameter+oversize_main_plate,center=false);   //main plate
}
translate([0,0,plate_thickness]){
cylinder(air_gap,d=bearing_inner_diameter+(bearing_outer_diameter-bearing_inner_diameter)/2,center=false);
}
translate([0,0,plate_thickness+air_gap]){
cylinder(min(bearing_thickness/2-0.7,5),d=bearing_inner_diameter+oversize_for_clamping,center=false);
}

echo(version=version());

