/*Part*/

//Endpiece or centerpiece?
piece = "end"; //[end: endpiece, center: centerpiece]

//Bearing (round) or nut (6-sided)?
hole = "bearing"; //[bearing, nut]

/*Dimensions*/

//Outer bearing / nut diameter (M3: 6.1; M4: 7.8; M5: 8.7; M6: 11.0 ...)
d_bearing = 12;

//Total width
width = 20;

//Thickness (should be 2*bearing/nut thickness for endpiece, 1*bearing/nut thickness for centerpiece)
thickness = 8;

//Fixing screw lower diameter (thread diameter)
M = 4.5;

//Fixing screw upper diameter (screw head dimeter)
M2 = 8.0;



/*Hidden*/
$fn = 48;

echo($fn);

ra = width /2;
ri = d_bearing /2;
hi = thickness /2;

if(piece == "end")
    if(hole == "bearing")
        holder($fn, false);
    else
        holder(6, false);
else 
    if(hole == "bearing"){
        holder($fn, true);
        rotate([0,0,180])
        holder($fn, true);}
    else{
        holder(6, true);
        rotate([0,0,180])
        holder($fn, true);}


module holder(ffn, piece) {
    rotate([0,-90,0])
difference(){
    union(){
        cylinder(h = hi * 2, r = ra, center = true);
        translate([-ra,0,0]) cube([ra*2,ra*2,hi*2], center = true);
        
        translate([-ra*2 + hi,0,-ra]) {
            difference(){
                union(){
                    cube([hi*2,ra*2,ra*2], center = true);
        translate([hi,0,ra])
        rotate([0,45,0])
        cube([hi*2,ra*2,hi*2], center = true);}
        translate([hi,0,ra+hi])
        cube([hi*4,ra*2,hi*2], center = true);
        }}}
    
    cylinder(h = hi*2.001, r = ri, center = piece, $fn = ffn);
        
    translate([-ra*2 - 0.01,0,-ra*1.2])
    rotate([0,90,0])
    
    {cylinder(h = hi*1.01, r = M/2, center = false);
     translate([0,0,hi]) cylinder(h = hi*1.01, r = M2/2, center = false);   
    }   
    }
}