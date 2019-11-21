//The body height in mm.
Body_height = 8;
//The body diamter in mm.
Body_diameter = 30;
//Thickness of the magnet in mm.
Magnet_thickness = 2;
//Diamter of the magnet in mm.
Magnet_diameter = 20;
//Magnet height
Height_tolerance = 0.1;
//Magnet diameter
Diameter_tolerance = 0.2;
//Model resolution
Resolution = 100;

difference(){
    //Main body
    cylinder(h=Body_height, d=Body_diameter, $fn = Resolution);
        translate([0,0,Body_height-Magnet_thickness-Height_tolerance]) 
            //Hollow out
            cylinder(h=Magnet_thickness+1, d=Magnet_diameter+(Diameter_tolerance*2), $fn = Resolution);    
    
}