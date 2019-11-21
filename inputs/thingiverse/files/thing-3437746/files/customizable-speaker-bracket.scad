//////vars

$fn=50;
//bracket_width=10.5;
bracket_depth=7;
//bracket_radius=72.5;
bracket_innerdiameter=139.7;
bracket_outerdiameter=165.1;
bracket_inradius=bracket_innerdiameter/2;
bracket_outradius=bracket_outerdiameter/2;
bracket_width=bracket_outradius-bracket_inradius;
hole1_radius=3;
hole2_radius=1.2;
num_hole1=3;
hole2_offset_degree=45;
num_hole2=4;
hole1_countersinkheight=3.8;
hole1_countersinkradius=6;
speaker_hole1_placement=78;
speaker_hole2_placement=78;

//////render


speaker_bracket ();

//////modules
module speaker_bracket_ring () {
    rotate_extrude (convexity = 10, $fn=200) {
    translate([bracket_inradius,0,0])
    square([bracket_width,bracket_depth]);}
}

module hole1_shell (){
    cylinder (h=bracket_depth,r1=hole1_countersinkradius*1.25,r2=hole1_countersinkradius*1.25);
}

module hole2_shell (){
    cylinder (h=bracket_depth,r1=hole2_radius*1.25,r2=hole2_radius*1.25);
}

module speaker_bracket_shell () {
    union(){
        speaker_bracket_ring();
        for(i=[360/num_hole1:360/num_hole1:360]){
translate([sin(i)*speaker_hole1_placement,cos(i)*speaker_hole1_placement,0]) {hole1_shell ();}
}
for(i=[360/num_hole2:360/num_hole2:360]){
translate([sin(i)*speaker_hole2_placement,cos(i)*speaker_hole2_placement,0]) {hole2_shell ();}
}
        }
    }        

module hole1 () {
    cylinder(h=bracket_depth, r1=hole1_radius, r2=hole1_radius);
    translate([0,0,bracket_depth-hole1_countersinkheight])
    cylinder(h=hole1_countersinkheight,r1=hole1_countersinkradius,r2=hole1_countersinkradius);
    }


module hole2 () {
    cylinder(h=bracket_depth, r1=hole2_radius, r2=hole2_radius);
}

module speaker_bracket () {
difference(){
speaker_bracket_shell ();    
for(i=[360/num_hole1:360/num_hole1:360]){
translate([sin(i)*speaker_hole1_placement,cos(i)*speaker_hole1_placement,0]) {hole1 ();}

}

for(i=[hole2_offset_degree:360/num_hole2:360]){
translate([sin(i)*speaker_hole2_placement,cos(i)*speaker_hole2_placement,0]) {hole2 ();}
}
}
}
