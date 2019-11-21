//small end inner diameter in mm
small_end_inner=50; 

//small end outer diameter in mm
small_end_outer=53; 


//small end length in mm
small_end_len=20; 

//large end inner diameter in mm
large_end_inner=56; 


//large end outer diameter in mm
large_end_outer=59; 

//large end length in mm
large_end_len=20; 


//center section length in mm
center_end_len=20; 

union() {
difference(){
cylinder(h=small_end_len, r=small_end_outer/2, center=false,$fn=100);
cylinder(h=small_end_len, r=small_end_inner/2, center=false,$fn=100);
}



translate([0,0,small_end_len]) difference(){
cylinder(h=center_end_len, r1=small_end_outer/2, r2=large_end_outer/2,center=false,$fn=100);
cylinder(h=center_end_len, r=small_end_inner/2, center=false,$fn=100);
}


translate([0,0,small_end_len+center_end_len]) difference(){
cylinder(h=large_end_len, r=large_end_outer/2, center=false,$fn=100);
cylinder(h=large_end_len, r=large_end_inner/2, center=false,$fn=100);
}


} //union


