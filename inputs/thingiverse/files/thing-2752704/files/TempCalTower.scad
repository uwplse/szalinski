//Printer and Filament Maker
machine = "Printrbot / Hatchbox";
//Starting Temperature
BottomTemperature = 220;
// Tower height (mm)
TowerHeight = 110;
// Length of tower base (mm)
TowerSide = 20;
// Height change for temperature change (mm)
HeightIncrement = 10;
// Amount to decrease temperature
TemperatureIncrement = 4;
// Amount for lettering to stick out (mm)
EmbossHeight = 0.5;
// Indent for overhang testing (mm)
Indent = 2;

// Make the base cube, with cutouts for testing bridging.

difference()
{
    cube([TowerSide, TowerSide, TowerHeight]);
    for(currentHeight=[0:HeightIncrement:TowerHeight-HeightIncrement])
    {
        translate([TowerSide-Indent,TowerSide/8,currentHeight])
        cube([Indent,3*TowerSide/4,HeightIncrement/2]);
    }
}

// Emboss printer type and filament vendor, or whatever
// other info you think is relevant.  For example,
// Type A machines need 20C higher temps, and Makerbot
// filament needs 20C higher than regular PLA.

translate([0,TowerSide/4,0])
rotate([0,-90,0])
linear_extrude(EmbossHeight)
text(str(machine), font = "Liberation Sans", size = TowerSide/3);

// Make markings for temperatures.  Lines are centered on
// the temperature change point.

for(currentHeight=[0:HeightIncrement:TowerHeight-HeightIncrement])
{
    currentTemp = BottomTemperature-currentHeight/HeightIncrement*TemperatureIncrement;
    translate([0,0,currentHeight])
    rotate([90,0,0]) 
    linear_extrude(EmbossHeight)
    text(str(currentTemp), font = "Liberation Sans", size = 5);
    if(currentHeight != 0)
    {
        translate([7*TowerSide/8,0,currentHeight])
        cube([TowerSide/4,1,1],center=true);
    }
}