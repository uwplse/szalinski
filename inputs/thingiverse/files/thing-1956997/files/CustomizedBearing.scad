/*
Written by Becky Button 11/2/16

This is a customizer script that allows the user to create a fidget toy using coins as counter wieghts. If you do not wish to use coins as counter wieght simply put the diameter of your bearing.
Assumptions:
    -The diameter is not zero
    -Dimensions are in millimeters
*/
/*
Standard coin diamters:
Quarter: 25mm
Dime:
Nickel:
Penny: 20mm

*/
//user variables begin
diameterOfBearing = 28;
diameterOfCoin = 40;
widthOfBearing = 2;
spaceDistance = 1;
//user variables end

halfLengthBase = (diameterOfBearing+spaceDistance*2+diameterOfCoin)*.5;

bearingRadius=.5*diameterOfBearing;
coinRadius=.5*diameterOfCoin;


//big coin
if(diameterOfCoin>diameterOfBearing)
    {
        difference()
        {
    union()
        {
        cube(size=[diameterOfCoin+2, 2*spaceDistance+diameterOfCoin+diameterOfBearing, widthOfBearing], center=true);
            
       translate([0, -halfLengthBase, -widthOfBearing*.5]) color([1,0,0])
        cylinder(h=widthOfBearing, r=coinRadius+1);
                
        translate([0, halfLengthBase, -widthOfBearing*.5]) color([0,1,0]) 
        cylinder(h=widthOfBearing, r=coinRadius+1);
}
translate([0, -halfLengthBase, -widthOfBearing*.5-4])
    cylinder(h=widthOfBearing+8, r=diameterOfCoin*.5);
translate([0, halfLengthBase, -widthOfBearing*.5 -4]) color([0,1,1]) 
cylinder(h=widthOfBearing+8, r=diameterOfCoin*.5);
cylinder(h=widthOfBearing+8, r=diameterOfBearing*.5, center=true);
    }
}
//big bearing
else{
    difference(){
        union(){     
            cube(size=[diameterOfBearing+2, 2*spaceDistance+diameterOfBearing+diameterOfCoin, widthOfBearing], center=true);

            translate([0, -halfLengthBase, -widthOfBearing*.5]) color([1,0,0])
            cylinder(h=widthOfBearing, r=bearingRadius+1);
                    
            translate([0, halfLengthBase, -widthOfBearing*.5]) color([0,1,0]) 
            cylinder(h=widthOfBearing, r=bearingRadius+1);
            }
    translate([0, -halfLengthBase, -widthOfBearing*.5-4])
        cylinder(h=widthOfBearing+8, r=diameterOfCoin*.5);
    translate([0, halfLengthBase, -widthOfBearing*.5 -4]) color([0,1,1]) 
    cylinder(h=widthOfBearing+8, r=diameterOfCoin*.5);
    cylinder(h=widthOfBearing+8, r=diameterOfBearing*.5, center=true);
        }
}

