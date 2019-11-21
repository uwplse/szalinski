//Bottle holder suited for hobby paints, sample glasses, test tubes and other tubular items.
//Reaper MSP/MSP HD/MSP Bones, Vallejo 17ml, and Army Painter bottles are 25mm diameter, 75mm(Reaper/Vallejo) or 77mm(Army) tall.

//I use 25mm, 3mm spacing, for 17ml bottles,
// 36mm, 10mm spacing for Vallejo 60ml bottles. 

// For Screw-cap 2ml test tubes
// 45mm tall with cap, 11mm diameter body, 13mm diameter cap.
// set holder_height to 30mm, bottom_height to 16mm.
// set diameter to 11.5 or 12mm, spacing to 6mm and print off holders.
// change diameter to 14mm and change spacing to 3.5 or 4mm and create the bottom part. 

// Looking into flip-cap tubes, but they will require  different parts to effectively use the area. 
// I have 2ml, and are waiting for 5ml tubes. Yes, they're art-related as I use them to mix small amounts of paint for airbrushing.
//Small test tubes can also be used as a 'travel' kit that you can bring in carry-on luggage when travelling. 

//Select item to generate
generate_item="holder";//[holder, bottom_plate, simple_endcap, hex_endcap, holder_endcap, support_plate]

//Thickness of the plates, not the endcaps.
plate_thickness = 2;

//Thickness of the cylinders in the holder.
cylinder_wall=1.2;

//You may want to add just a bit of clearance... 
bottle_diameter= 26;

holder_height = 30; 
//height of the part sitting under the holder. Ie. goes on top of another holder... 
bottom_height = 50;
//These two together should be slightly more than the height of the bottle.

//Gap between bottles. 
bottle_spacing=3; //[2:20]

//The distance from the outermost bottles to the edge of the tray. 
tray_border=8;

//Inner diameter of tube.
tube_diameter=151;
tube_wall=4.5;

//Width of the strap holding everything together. Can be set to 0 if no strap is to be used. Keep it close to the actual width of the strap.
strap_width=25;

//Creates a bit of clearance between the edge of the trays and the tube.
corner_rounding=1;

//how many bottles in one side of the hexagon? A value of 1 results in a single hole in the holder. 2 gives you 2+3+2 = 7, 3 gives 19, 4 gives 37 holes and so on. 
bottle_columns=3;



//Please, please do NOT mess with this module. It IS broken, but messing about is bound to break it even further, and may end up calling forth an angry Elder God... you have been warned... 
//Actually, it's a bit of code that creates a 'hex grid' of cylinders. Since I needed to do that in several different modules, I hacked together this one. And yes, it is a bit broken. 
module full_hex()
{
//The one in the center...
cylinder(r=bottle_diameter/2, h=holder_height+bottom_height+2);
for (rings = [2: bottle_columns])
   {for(ring_side =[0:60:300])
       rotate([0,0,ring_side])
          translate([(bottle_diameter+bottle_spacing)*(rings-1),0,0])
              for(ring_spot = [1: 1:rings])
              {rotate([0,0,120])
                  translate([(bottle_diameter+bottle_spacing)*(ring_spot-1),0,0])
                     cylinder(r=bottle_diameter/2, h=holder_height+bottom_height+2);
              }
   }
}

module endcap()
{
$fn=200;
 difference()
    {cylinder(r=tube_diameter/2+tube_wall+0.8+5, h=20);
        translate([0,0,10])
           difference()
                {cylinder(r=tube_diameter/2+tube_wall+0.8, h=15);
                 translate([0,0,-1])
                    cylinder(r=tube_diameter/2-0.4,h=20);}


     translate([-tube_diameter/2-tube_wall-1.6,-strap_width/2,-1])
        cube([tube_diameter+tube_wall*2+3.2,strap_width,5]);
     translate([tube_diameter/2+tube_wall+1.5,-strap_width/2,2.5])
        cube([5,strap_width,35]);
     translate([tube_diameter/2+tube_wall-2,-strap_width/2,8])              
        rotate([270,0,0])
            intersection()
                {difference()
                    {cylinder(r=7, h=strap_width, $fn=24);
                    translate([0,0,-1])
                        cylinder(r=4,h=strap_width+2, $fn=24);}
                cube([30,strap_width,30]);
                }
    translate([-tube_diameter/2-tube_wall+2,strap_width/2,8])              
    rotate([270,0,180])
        intersection()
            {difference()
                {cylinder(r=7, h=strap_width, $fn=24);
                translate([0,0,-1])
                    cylinder(r=4,h=strap_width+2, $fn=24);}
            cube([30,strap_width,30]);
            }
     translate([-tube_diameter/2-tube_wall-11.5,-strap_width/2,2.5])
        cube([10,strap_width,35]);
    }   

}

module holder_endcap()
{
$fn=200;
 difference()
    {cylinder(r=tube_diameter/2+tube_wall+0.8+5, h=holder_height+5);
        translate([0,0,holder_height])
           difference()
                {cylinder(r=tube_diameter/2+tube_wall+0.8, h=15);
                 translate([0,0,-1])
                    cylinder(r=tube_diameter/2-0.4,h=20);}
     translate([0,0,5])
        full_hex();

     translate([-tube_diameter/2-tube_wall-1.6,-strap_width/2,-1])
        cube([tube_diameter+tube_wall*2+3.2,strap_width,5]);
     translate([tube_diameter/2+tube_wall+1.5,-strap_width/2,2.5])
        cube([5,strap_width,holder_height+5]);
     translate([tube_diameter/2+tube_wall-2,-strap_width/2,8])              
        rotate([270,0,0])
            intersection()
                {difference()
                    {cylinder(r=7, h=strap_width, $fn=24);
                    translate([0,0,-1])
                        cylinder(r=4,h=strap_width+2, $fn=24);}
                cube([30,strap_width,30]);
                }
    translate([-tube_diameter/2-tube_wall+2,strap_width/2,8])              
    rotate([270,0,180])
        intersection()
            {difference()
                {cylinder(r=7, h=strap_width, $fn=24);
                translate([0,0,-1])
                    cylinder(r=4,h=strap_width+2, $fn=24);}
            cube([30,strap_width,30]);
            }
     translate([-tube_diameter/2-tube_wall-11.5,-strap_width/2,2.5])
        cube([10,strap_width,holder_height+5]);
    }   

}


module hex_endcap()
{
$fn=200;
 difference()
    {rotate([0,0,30])
        cylinder(r=sqrt((tube_diameter/2+tube_wall+0.8+6)*(tube_diameter/2+tube_wall+0.8+6)+((tube_diameter/2+tube_wall+0.8+6)/2)*((tube_diameter/2+tube_wall+0.8+6)/2)), h=20, $fn=6);
        translate([0,0,10])
           difference()
                {cylinder(r=tube_diameter/2+tube_wall+0.8, h=15);
                 translate([0,0,-1])
                    cylinder(r=tube_diameter/2-0.4,h=20);}


     translate([-tube_diameter/2-tube_wall-1.6,-strap_width/2,-1])
        cube([tube_diameter+tube_wall*2+3.2,strap_width,5]);
     translate([tube_diameter/2+tube_wall+2,-strap_width/2,2.5])
        cube([5,strap_width,35]);
     translate([tube_diameter/2+tube_wall-2,-strap_width/2,8])              
        rotate([270,0,0])
            intersection()
                {difference()
                    {cylinder(r=7, h=strap_width, $fn=24);
                    translate([0,0,-1])
                        cylinder(r=4,h=strap_width+2, $fn=24);}
                cube([30,strap_width,30]);
                }
    translate([-tube_diameter/2-tube_wall+2,strap_width/2,8])              
    rotate([270,0,180])
        intersection()
            {difference()
                {cylinder(r=7, h=strap_width, $fn=24);
                translate([0,0,-1])
                    cylinder(r=4,h=strap_width+2, $fn=24);}
            cube([30,strap_width,30]);
            }
     translate([-tube_diameter/2-tube_wall-12,-strap_width/2,2.5])
        cube([10,strap_width,35]);
    }   

}


module top_plate()
{
intersection()
    {difference()
        {union()
            {cylinder(r=bottle_diameter*bottle_columns+bottle_spacing*(bottle_columns-1)+tray_border-bottle_diameter/2, h=plate_thickness, $fn=6);
             translate([0,0,0.001])
                cylinder(r=bottle_diameter/2+1.2, h=holder_height, $fn=100);
                for(dreining = [0: 60: 300])
    {rotate([0,0,dreining])
        translate([bottle_diameter*(bottle_columns-1)+bottle_spacing*(bottle_columns-1),0,0.001])
            cylinder(r=bottle_diameter/2+1.2, h=holder_height, $fn=100);
        }


            }
        translate([0,0,-1])
           full_hex();
        }
    cylinder(r=tube_diameter/2-corner_rounding, h=holder_height+plate_thickness+2);        
    }
}

module bottom_plate()
{
intersection()
    {difference()
        {cylinder(r=bottle_diameter*bottle_columns+bottle_spacing*(bottle_columns-1)+tray_border-bottle_diameter/2, h=plate_thickness, $fn=6);
        }
    cylinder(r=tube_diameter/2-corner_rounding, h=5);        
    }
    
//This small block makes the center column. Can be commented out if you want to remove that column...
difference()
    {translate ([0,0,0.01])
        cylinder(r=bottle_diameter/2+1.2, h=bottom_height+plate_thickness, $fn=100);
     translate([0,0,plate_thickness+0.01])
        cylinder(r=bottle_diameter/2, h=bottom_height+plate_thickness+2, $fn=100);
    }
  
    
//This one makes the columns at each corner... It may not be a good idea to mess about too much with this block...
for(dreining = [0: 60: 300])
    {rotate([0,0,dreining])
        translate([bottle_diameter*(bottle_columns-1)+bottle_spacing*(bottle_columns-1),0,0.01])
        difference()
            {cylinder(r=bottle_diameter/2+1.2, h=bottom_height+plate_thickness, $fn=100);
            translate([0,0,plate_thickness-0.01])
                cylinder(r=bottle_diameter/2, h=bottom_height+plate_thickness+2, $fn=100);
            }
        }
}

module support_plate()
{
    
intersection()
    {difference()
        {cylinder(r=bottle_diameter*bottle_columns+bottle_spacing*(bottle_columns-1)+tray_border-bottle_diameter/2, h=plate_thickness, $fn=6);
        translate([0,0,-1])
           full_hex();
        translate([0,0,-1])
            cylinder(r=bottle_diameter/2+cylinder_wall, h=plate_thickness+2);
        }
    cylinder(r=tube_diameter/2-corner_rounding, h=5);     
    }

}



if (generate_item == "holder") top_plate();
else if (generate_item == "bottom_plate") bottom_plate();
else if (generate_item == "support_plate") support_plate();
else if (generate_item == "simple_endcap") endcap();
else if (generate_item == "holder_endcap") holder_endcap();
else if (generate_item == "hex_endcap") hex_endcap();