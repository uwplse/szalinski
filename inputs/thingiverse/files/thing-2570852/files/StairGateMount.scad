//Build "buffer" or "spacer" to go between child-proof-gate bracket and tapered cylindrical Newel (stair post).  Accommodate the cylinder, and the taper, resulting in a straight and level factory bracket. 

//Bracket is assumed to be straight sided, and have a top and bottom end 'half circle' who's diameter matches the width. Of course, this can be changed if you know openScad
//Bracket is assumed to have two screw holes. 

//Adjust the following numbers to your situation

//Measured Height ('tallness') of Factory Supplied Bracket in mm
Height = 84.5;  
//Measured Width of Factory Supplied Bracket in mm
Width = 30.5;   
//Overall depth in MM, prior to carving tapered cylinder of Newel out of the back. May need some experimentation. 
Depth = 12;   

//Diameter of screw holes in mm.  Measured to match screw holes in factory supplied bracket   
Screwhole=2;    

//Distance of 'top' screw hole from bottom edge of bracket (i.e. Zero Z)
S1=76;          
//Distance of 'bottom' screw hole from bottom edge of bracket (i.e. Zero Z)
S2=16;
          
//Diameter of Newel at (or near) top    of eventual installation position.  Measure with calipers if at all possible. 
NewelTop=48.5;  
//Diameter of Newel at (or near) bottom of eventual installation position.  Measure with calipers if at all possible.
NewelBot=52;    


//Start of code

difference() {
difference() {
union(){
//Basic Object, without rounded ends
translate([0,0,Width/2]) 
    cube([Depth,Width,Height-Width]);  

//Bottom End, Half Cylinder 
translate([0,Width/2,Width/2]) 
    rotate([0,90,0])
    cylinder(h = Depth, r = Width/2, $fn=360);  

//Top End, Half Cylinder
translate([0,Width/2,Height-Width/2]) 
    rotate([0,90,0])
    cylinder(h = Depth, r = Width/2, $fn=360);
} // End of union to build object

//Upper Screw Hole
translate([0,Width/2,S1]) 
    rotate([0,90,0])
        cylinder(h=Depth, r=Screwhole, $fn=260);  

//Lower Screw Hole
translate([0,Width/2,S2]) 
    rotate([0,90,0])
        cylinder(h=Depth, r=Screwhole, $fn=360);  
}  // End of difference for screw holes

//Make sloped cylinder to represent newel, and calculate the height of the chord at the top (narrow) end, so that it will exactly tangent. 
NewelTopR=NewelTop / 2;
NewelBotR=NewelBot / 2;
R=NewelTopR;
H=R-sqrt((R*R) - ((Width*Width)/4));
echo(H);
translate([-NewelTopR+H,Width/2,0]) 
cylinder(h=Height,r1=NewelBotR, r2=NewelTopR, $fn=720);

} //End of difference for Newel 