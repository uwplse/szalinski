HookHeight = 196.85;
HookWidth = 38.1;
HookShell =  5;
HookThickness = 88.9;
HookGrip = 38.1;
HangerDiameter = 31.75;
HangerLength = 76.2;

//HookHeight
cube([HookWidth, HookShell ,HookHeight]);

//Creating the J Part of the hook
translate([0,HookShell,HookHeight-HookShell])
{
    cube([HookWidth,HookThickness,HookShell]);
    translate([0,HookThickness,0-HookGrip])
    {
        cube([HookWidth, HookShell, HookGrip+HookShell]);
    }
}
//Creating the nub for coats etc
rotate([90,0,0])
{
    translate([HookWidth/2,HangerDiameter/2+6.35])
    {
        cylinder(h=HangerLength,d=HangerDiameter);
        translate([0,0,HangerLength])
        {
            cylinder(10,d=HangerDiameter+6);
        }
    }
}
