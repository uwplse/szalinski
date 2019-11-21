Flashlight_Diameter = 48;
Flashlight_Border = 2;
Pocket_Depth = 5;
Baseplate_Thickness = 8;
Backplate_Height = 18;
Backplate_Thickness = 5;
Screw_Hole_Diameter = 3.2;
Screw_Head_Diameter = 8;
Screw_Border = 2;
n = 360;

difference()
{
    cube([Flashlight_Diameter+Flashlight_Border,Flashlight_Diameter+Flashlight_Border,Baseplate_Thickness], false);
    translate([(Flashlight_Diameter+Flashlight_Border)/2,(Flashlight_Diameter+Flashlight_Border)/2, Baseplate_Thickness-Pocket_Depth])
        cylinder(h = Pocket_Depth, d = Flashlight_Diameter, $fn = n);
}

difference()
{
    //Rückwand
    translate([-Backplate_Thickness,0,0])
        cube([Backplate_Thickness,Flashlight_Diameter+Flashlight_Border,Backplate_Height], false);
    
    //Bohrungen
    translate([-(Backplate_Thickness+1),Screw_Head_Diameter/2 + Screw_Border, (Backplate_Height-Baseplate_Thickness)/2 + Baseplate_Thickness])
        rotate([0,90,0])
            cylinder(h = Backplate_Thickness+1, d = Screw_Hole_Diameter, $fn = n);
    
    translate([-(Backplate_Thickness+1),Flashlight_Diameter+Flashlight_Border-Screw_Border-Screw_Head_Diameter/2, (Backplate_Height-Baseplate_Thickness)/2 + Baseplate_Thickness])
        rotate([0,90,0])
            cylinder(h = Backplate_Thickness+1, d = Screw_Hole_Diameter, $fn = n);
    
    //Senkungen
    translate([-(Screw_Head_Diameter-Screw_Hole_Diameter)/2,Screw_Head_Diameter/2 + Screw_Border, (Backplate_Height-Baseplate_Thickness)/2 + Baseplate_Thickness])
        rotate([0,90,0])
            cylinder(h = (Screw_Head_Diameter-Screw_Hole_Diameter)/2, d1 = Screw_Hole_Diameter, d2 = Screw_Head_Diameter, $fn = n);
    
    translate([-(Screw_Head_Diameter-Screw_Hole_Diameter)/2,Flashlight_Diameter+Flashlight_Border-Screw_Border-Screw_Head_Diameter/2, (Backplate_Height-Baseplate_Thickness)/2 + Baseplate_Thickness])
        rotate([0,90,0])
            cylinder(h = (Screw_Head_Diameter-Screw_Hole_Diameter)/2, d1 = Screw_Hole_Diameter, d2 = Screw_Head_Diameter, $fn = n);
            
    //Kerbe
    translate([-Backplate_Thickness-6.5,(Flashlight_Diameter+Flashlight_Border)/2,Backplate_Height/2])
        rotate([0,0,45])
            cube([10,10,Backplate_Height], true);
}