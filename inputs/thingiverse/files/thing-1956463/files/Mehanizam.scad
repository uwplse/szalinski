/*Customizer Variables*/
//main gear radius
showMainGearRadius=15; //[10:150]
//safeGearRadius gear radius
safeGearRadius=12; //[10:150]
//gears gearsHeight
gearsHeight=2; //[0.5:0.5:100]
//locking lockingNochRadiuss radius
lockingNochRadius=1; //[0.2:0.2:10]

//movers radius
liftshowMainGearRadius=20; //[10:200]
//movers distanceBetweenGearsr radius
holdershowMainGearRadius=4; //[1:10]

//tolerance
tolerance=0.2;//[0.1:0.1:10]

//radius to radiusToTrimFromMover from movers radius
radiusToTrimFromMover=5; //[0.5:0.5:10]

//screwHoleRadius hole radius
screwHoleRadius=0.5; //[0.5:0.5:50]

//distanceBetweenGears between gears
distanceBetweenGears=1; //[0.5:0.1:50]

showMainGear=1; //[0:No,1:Yes]
showMoverGear=1; //[0:No,1:Yes] 

$fn=100;

/*[Hidden]*/
chanellen=(safeGearRadius+showMainGearRadius)/2+distanceBetweenGears;



if(showMainGear)
translate([0,-liftshowMainGearRadius-distanceBetweenGears,0]) rotate([0,0,0]) render() main();
if(showMoverGear)
rotate([0,0,45]) render() mover();

module mover()
{
difference()
{    
union()
    {
intersection() 
{
driver();
translate([0,0,gearsHeight])cylinder(r=liftshowMainGearRadius-radiusToTrimFromMover,gearsHeight);
}
cylinder(r=holdershowMainGearRadius,h=gearsHeight);
}
cylinder(r=screwHoleRadius,h=10*gearsHeight);
}
}

module driver()
{
   

difference()
{
translate([0,0,gearsHeight]) cylinder(r=liftshowMainGearRadius,h=gearsHeight);

translate([0,liftshowMainGearRadius+distanceBetweenGears/2,gearsHeight])cylinder(r=safeGearRadius,h=gearsHeight);
translate([0,-liftshowMainGearRadius-distanceBetweenGears/2,gearsHeight])cylinder(r=safeGearRadius,h=gearsHeight);
translate([-liftshowMainGearRadius-distanceBetweenGears/2,0,gearsHeight])cylinder(r=safeGearRadius,h=gearsHeight);
translate([liftshowMainGearRadius+distanceBetweenGears/2,0,gearsHeight])cylinder(r=safeGearRadius,h=gearsHeight);

rotate([0,0,45]) translate([liftshowMainGearRadius-chanellen,-(lockingNochRadius*2+2*tolerance)/2,0])cube([chanellen,lockingNochRadius*2+2*tolerance,2*gearsHeight]);
rotate([0,0,135]) translate([liftshowMainGearRadius-chanellen,-(lockingNochRadius*2+2*tolerance)/2,0])cube([chanellen,lockingNochRadius*2+2*tolerance,2*gearsHeight]);
rotate([0,0,225]) translate([liftshowMainGearRadius-chanellen,-(lockingNochRadius*2+2*tolerance)/2,0])cube([chanellen,lockingNochRadius*2+2*tolerance,2*gearsHeight]);
rotate([0,0,315]) translate([liftshowMainGearRadius-chanellen,-(lockingNochRadius*2+2*tolerance)/2,0])cube([chanellen,lockingNochRadius*2+2*tolerance,2*gearsHeight]);
    
}


    
}


module main()
{
    difference(){
        
union()
 {   
cylinder(r=showMainGearRadius,h=gearsHeight-tolerance);
difference()
{
cylinder(r=safeGearRadius,h=2*gearsHeight);
translate([0,liftshowMainGearRadius,gearsHeight-tolerance])cylinder(r=liftshowMainGearRadius-radiusToTrimFromMover,h=gearsHeight+1);
}
translate([0,(safeGearRadius+showMainGearRadius)/2,0]) cylinder(r=lockingNochRadius,h=2*gearsHeight);
}
cylinder(r=screwHoleRadius,h=10*gearsHeight);
}

}
    
    
