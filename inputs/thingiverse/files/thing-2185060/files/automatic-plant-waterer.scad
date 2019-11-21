//Watering For soda bottle
//Ari Diacou
//March 2017
/*/////////////////////// Instructions ////////////////////////////
This automatic waterer uses bottle with a screw on cap. The cap is glued into the base, and then a hole is popped in the cap (with a drill or nail) the base is nailed into the ground near one of your plants. The bottle is filled with water, and then screwed in upside down into the cap. 
1. Take measurements of the cap height, cap diameter, and landscaping nail diameter. Puch those into Customizer/OpenSCAD file.
2. Render/Export.
3. Print with supports. You should only need them for the overhang for the cap.
4. Remove supports.
5. With a nail or drill bit, make a hole in the cap of your bottle.
6. Place glue (anything waterproof: Wood Glue, silicone caulk, Goop, superglue gel, PVC pipe cement, avoid: white/PVA/school glue, gorilla glue, might work: tacky glue, contact cement) on sides of cap, base overhang (not in the funnel), and on sides of the cap recess in the base.
7. Place cap into the base, swirl around so you have an even distribution of glue in the gap between the cap and the base. Wipe away excess glue with a damp paper towel/napkin/tissue.
8. Turn upside down onto some Saran wrap or aluminum foil, wipe away excess glue with a damp paper towel/napkin/tissue, and allow the glue to cure per manufacturers instructions.
9. Remove the base from your drying sheet.
10. Place the base, cone side down, near the plant you want to water. It should be close enough to the plant, that the water will go to the roots, but far enough away that you can (un)screw the bottle from the base without interfering with the plant as it grows.
11. Fit the landscaping nails into the holes in the nacelles, and happer them into the ground, making sure the base is level.
12. Fill the bottle with water.
13. Turn the bottle over and screw it into the base.

FAQ/Troubleshooting:
1. How does it work? As the soil dries out, water from the bottle will displace air in the soil, and water the soil. When the soil is saturated, there will be no air to bubble up the bottle and displace water in the bottle. If the seal between the bottle and the cap is air tight, this should keep the soil at a constant moisture.
2. It's not working, no water is coming out. Either you forgot to tap a hole in the cap, or glue clogged the funnel. Drill a hole from the cap to the tip.
3. It's not working, there is a small wet patch, but the plant isn't getting it. Your plant could be too far away (>12”), the hole in your cap could be too small, or your soil has too much clay in it.
4. Water spills out the top of the base. The seal between the cap and the bottle is not good enough. Try screwing it down a bit more, maybe there is some dirt at the bottom of the cap, that prevents a good seal. Maybe your cap has cracked or deformed.
5. I don't drink liquor or soda, because I am a wino. How can I get this to work? I cant help you if you drink boxed wine (although BotaBox is better than Franzia). For wine bottles, maybe try to increase the “cap_height” to somehting like 3 inches. Measure the width of the bottle at this distance down the neck, add 2-4 mm to this. Set this number to the “cap diameter”. Print the base per steps 1-4. Coat the top of the bottle and the neck with Silicone caulk to create a waterproof O-ring. Allow to dry seperately from the base. Once dry, using a very sharp utility knife, cut away excess silicone so that the bottle makes a perfect flat seal with the base. The water will leak out if the bottle gets tilted, allowing air into the base.
6. It's august, my cap is leaking, and it looks all deformed, what happened? You were probably using PLA, not ABS. PLA deforms at a relatively low temperature.

*///////////////////////// Parameters //////////////////////////////
// preview[view:east, tilt:bottom]

//Measure the diameter of the cap of the bottle you will be using
real_cap_diameter=25;
//Measure the height of the cap you will be using
cap_height=15;
//Measure the ones you bought
diameter_of_landscaping_nails=8;
//How wide do you want this to be?
wingspan=100;
//The width of the wings that attach the "nacelles" to the central hub
wing_width=5;
//The thickness of the hub and the nacelles
wall_thickness=3;
//is the number of landscaping spikes that will secure the base
number_of_wings=3;
//The hole for the cap is this much bigger than the cap, to allow for glue volume
tolerance_for_glue=3;
//The hole in the tip that allows the water to flow into the soil
drip_hole_diameter=4;

///////////////////// Derived Parameters //////////////////////////
ep=0.05+0;
cap_diameter=real_cap_diameter+tolerance_for_glue;
base_height=cap_height+wall_thickness;
nacelle_width=diameter_of_landscaping_nails+2*wall_thickness;
hub_diameter=cap_diameter+2*wall_thickness;
wing_length=wingspan/2-nacelle_width/2;
tip_depth=base_height*2.5;
////////////////////////// Main() /////////////////////////////////
difference(){
    union(){
        tip();
        linear_extrude(base_height)
            base();
        }
    hollow();
    }
    
//////////////////////// Functions ////////////////////////////////
module base(){
    circle(d=hub_diameter);
    for(i=[0:number_of_wings-1])
        rotate([0,0,i*360/number_of_wings]) wing();
    }
    
module hollow(){
    translate([0,0,-ep])
        cylinder(d=cap_diameter,h=cap_height);
    translate([0,0,cap_height-2*ep]) 
        cylinder(d1=cap_diameter-2*wall_thickness,d2=0,h=tip_depth-2*wall_thickness);
    cylinder(d=drip_hole_diameter,h=1.01*(tip_depth+base_height),$fn=40);
    }
    
module tip(){
    translate([0,0,base_height-ep]) 
        cylinder(d1=hub_diameter,d2=0,h=tip_depth);
    }    

module wing(){
        difference(){
            union(){
                translate([0,-wing_width/2]) 
                    square([wing_length,wing_width]);
                translate([wing_length,0]) 
                    circle(d=nacelle_width);
                }
            translate([wing_length,0]) circle(d=diameter_of_landscaping_nails);
            }
    }