//Body height in mm.
Body_height = 8;
//Body diameter in mm.
Body_diameter = 30;
//Thickness of the magnet in mm.
Magnet_thickness = 2;
//Diamter of the magnet in mm.
Magnet_diameter = 10;
//Magnet height
Height_tolerance = 0.1;
//Magnet diameter
Diameter_tolerance = 0.2;
//Model resolution
Resolution = 70;

difference(){
    //Main body
    cylinder(h=Body_height, d=Body_diameter, $fn = Resolution);
        //Up 1,5 mm
        translate([0,0,1.5])
            //Hollow out
            cylinder(h=Body_height, d=Body_diameter-3, $fn = Resolution);    
    
}
difference(){
    //Inner cylinder
    cylinder(h=Body_height, d=Magnet_diameter+3+(Diameter_tolerance*2), $fn = Resolution);
        //Position    
        translate([0,0,Body_height-(Magnet_thickness+Height_tolerance)])        //Hollow out
            cylinder(h=Magnet_thickness+1,d=Magnet_diameter+(Diameter_tolerance*2), $fn = Resolution);
}