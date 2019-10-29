// i got the original code from : https://www.thingiverse.com/thing:1680427/#files 



Thickness = 0.6; // Thickness of the tube walls (your nozzle size)

InnerDiameter = 22.1; // Inner diameter of tube
OuterDiameter = InnerDiameter+(Thickness*2); // Outer diameter of tube
Height = 90; // Height of the lower section


module tube(od, id, h) {
    difference() {
        cylinder(r=od/2, h=h,$fn=50);
        cylinder(r=id/2, h=h,$fn=50);
    }
}

tube(OuterDiameter, InnerDiameter, Height);

