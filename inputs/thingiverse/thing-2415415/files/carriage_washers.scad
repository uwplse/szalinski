/*// carriage M3 washers for levelling the TronXY P802MA
// Print 50 of these (some will be bad) at 0.2 layer height with first layer at 0.2mm if you have good enough alignment, or change h below to match.
// These are very small, let your bed cool before removing.*/
difference(){
translate([0,0,0])
    rotate(a=[0,0,90])cylinder(r=2,h=0.2,$fn=100); /*outer diameter - change r for radius of outside diameter - change h for z axis height of washers.*/
translate([0,0,-1])
    rotate(a=[0,0,90])cylinder(r=1.5,h=4,$fn=100); /*hole for the bolt - change r for radius of inside diameter*/
}