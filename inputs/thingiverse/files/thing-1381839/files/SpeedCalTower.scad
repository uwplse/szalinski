//Printer and Filament Maker
machine = "Felix 3.1 / Atomic PLA";
// Temperature
temperature = "205 C";
//Starting Speed
BottomSpeed = 20;
// Tower height (mm)
TowerHeight = 136;
// Length of tower base (mm)
TowerSide = 20;
// Height change for speed change (mm)
HeightIncrement = 8;
// Amount to increase speed
SpeedIncrement = 5;
// Amount for lettering to stick out (mm)
EmbossHeight = 0.5;
// Indent for overhang testing (mm)
Indent = 3;

// Make the base cube, with cutouts for testing bridging.
overhangSide = min(HeightIncrement,TowerSide/2);

difference()
{
    cube([TowerSide, TowerSide, TowerHeight]);
    for(currentHeight=[0:HeightIncrement:TowerHeight-HeightIncrement])
    {
        translate([TowerSide-Indent,TowerSide/8,currentHeight])
        cube([Indent,3*TowerSide/4,HeightIncrement/2]);
        translate([0,TowerSide,currentHeight])
        {
        difference()
           {
                rotate([45,0,45])
                cube(overhangSide*sqrt(2),center=true);
                translate([0,0,-1.501*overhangSide])
                cube(3*overhangSide,center=true);
            }
        }
    }
}


// Emboss printer type and filament vendor, or whatever
// other info you think is relevant.  For example,
// Type A machines need 20C higher temps, and Makerbot
// filament needs 20C higher than regular PLA.

translate([0,TowerSide/8,0])
rotate([0,-90,0])
linear_extrude(EmbossHeight)
text(str(machine), font = "Liberation Sans", size = TowerSide/3);

// Emboss print temperature, as that will affect performance as well

translate([5*TowerSide/8,TowerSide,0])
rotate([-90,0,0])
rotate([0,0,-90])
linear_extrude(EmbossHeight)
text(str(temperature), font = "Liberation Sans", size = TowerSide/3);


// Make markings for speeds.  Lines are centered on
// the temperature change point.

for(currentHeight=[0:HeightIncrement:TowerHeight-HeightIncrement])
{
    currentSpeed = BottomSpeed+currentHeight/HeightIncrement*SpeedIncrement;
    translate([0,0,currentHeight])
    rotate([90,0,0]) 
    linear_extrude(EmbossHeight)
    text(str(currentSpeed), font = "Liberation Sans", size = 5);
    if(currentHeight != 0)
    {
        translate([7*TowerSide/8,0,currentHeight])
        cube([TowerSide/4,1,1],center=true);
    }
}