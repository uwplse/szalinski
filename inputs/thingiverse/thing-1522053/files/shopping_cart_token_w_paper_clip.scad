//Diameter of coin in mm
coin_diameter = 28.5;
//Thickness of coin in mm
coin_thickness = 2.0;
//Screw size in mm
screw_diameter = 3.0;
//Screw length in mm
screw_length = 16;
//Length of the neck in mm (affects the size of the paper clip)
neck_length = 5;
//Needed parts
parts = "Both"; //[Coin, Paperclip, Both]

wallthickness = 2*1;
coin_radius = coin_diameter / 2.0;
paperholder_thickness = 1.5*1;

module CreateCoin()
{
    difference()
    {
        union()
        {
            cylinder(h=coin_thickness, r=coin_radius, $fn = 50);
            translate([-screw_length/2, 0, 0 ])
            cube([screw_length, neck_length+coin_radius, coin_thickness]);
            translate([-screw_length/2, neck_length+coin_radius, screw_diameter/2+wallthickness])
            rotate([0,90,0])
            cylinder(h=screw_length, r=screw_diameter/2+wallthickness, $fn = 50);
            translate([-screw_length/2, neck_length+coin_radius-screw_diameter/2-wallthickness, 0])
            cube([screw_length, screw_diameter/2+wallthickness, screw_diameter/2+wallthickness]);
        }
        union()
        {
            translate([-screw_length/2-1, neck_length+coin_radius, screw_diameter/2+wallthickness])
            rotate([0,90,0])
            cylinder(h=screw_length+2, r=screw_diameter/2-0.1, $fn = 50);
            translate([-screw_length/4, neck_length+coin_radius, screw_diameter/2+wallthickness])
            rotate([0,90,0])
            cylinder(h=screw_length/2, r=screw_diameter/2+wallthickness+0.6, $fn = 50);
        }
    }
}

module CreatePaperHolder()
{
    difference()
    {
        union()
        {
            yoffset = coin_radius+(neck_length-(screw_diameter/2+wallthickness)-((screw_diameter/2+wallthickness)-paperholder_thickness))-3;
            
            
            translate([-screw_length/4+0.2, neck_length+coin_radius, screw_diameter/2+wallthickness])
            rotate([0,90,0])
            cylinder(h=screw_length/2-0.4, r=screw_diameter/2+wallthickness, $fn = 50);
            translate([-screw_length/4+0.2, neck_length+coin_radius-(screw_diameter/2+wallthickness), 0])
            cube([screw_length/2-0.4, screw_diameter/2+wallthickness, screw_diameter/2+wallthickness]);
            difference()
            {
                translate([-screw_length/4+0.2, neck_length+coin_radius-(screw_diameter/2+wallthickness)-((screw_diameter/2+wallthickness)-paperholder_thickness), 0])
                cube([screw_length/2-0.4, ((screw_diameter/2+wallthickness)-paperholder_thickness), screw_diameter/2+wallthickness]);
                translate([-screw_length/4, neck_length+coin_radius-(screw_diameter/2+wallthickness)-((screw_diameter/2+wallthickness)-paperholder_thickness), screw_diameter/2+wallthickness])
                rotate([0,90,0])
                cylinder(h=screw_length/2, r=((screw_diameter/2+wallthickness)-paperholder_thickness), $fn=50);
            }
            difference()
            {
                translate([-screw_length/2, neck_length+coin_radius-(screw_diameter/2+wallthickness), 0])
                cube([screw_length, (screw_diameter/2+wallthickness), paperholder_thickness]);
                translate([-screw_length/2-1, neck_length+coin_radius, screw_diameter/2+wallthickness])
                rotate([0,90,0])
                cylinder(h=screw_length+2, r=screw_diameter/2+wallthickness+0.6, $fn = 50);
                
            }
            intersection()
            {
                length = coin_diameter+neck_length-(screw_diameter/2+wallthickness);
                union()
                {
                   translate([-coin_radius, -coin_radius, 0])
                   cube([coin_diameter, length-2, paperholder_thickness]);               translate([-coin_radius+2, -coin_radius+length-2, 0])
                   {
                        cylinder(r=2, h = paperholder_thickness, $fn=50);
                       cube([coin_diameter-4, 2, paperholder_thickness]);
                   }
                   translate([coin_radius-2, -coin_radius+length-2, 0])
                   cylinder(r=2, h = paperholder_thickness, $fn=50);                   
                }
                union()
                {
                    cylinder(r=coin_radius, h=paperholder_thickness, $fn=50);
                    translate([-coin_radius, 0, 0])
                    cube([coin_diameter, coin_radius+neck_length-(screw_diameter/2+wallthickness), paperholder_thickness]);
                    
                }
            }            
        }
        union()
        {
            translate([-screw_length/2-1, neck_length+coin_radius, screw_diameter/2+wallthickness])
            rotate([0,90,0])
            cylinder(h=screw_length+2, r=screw_diameter/2-0.1, $fn = 50);
            length = coin_diameter+neck_length-(screw_diameter/2+wallthickness);
            cutLength = length - 6;
            translate([0, -coin_radius, paperholder_thickness/2])
            {
                translate([-coin_diameter/5, 0, 0])
                rotate([0,60,0])
                cube([1, cutLength*2, 10], center = true);
                translate([coin_diameter/5, 0, 0])
                rotate([0,-60,0])
                cube([1, cutLength*2, 10], center = true);
            }
        }        
    }    
}

if( parts == "Both" || parts == "Coin" )
{
    CreateCoin();
}
if( parts == "Both" || parts == "Paperclip" )
{
    translate([-(coin_diameter+10), 0, 0])
    CreatePaperHolder();
}
//translate([0,0,screw_diameter+wallthickness*2])
//rotate([0,180,0])
//CreatePaperHolder();


