/*[Global]*/

//Which Power Ring would you wear?
affiliation = "Green Lantern Corps - Will"; //[Red Lantern Corps - Rage,Orange Lantern Corps - Avarice,Sinestro Corps (Yellow) - Fear,Green Lantern Corps - Will,Blue Lantern Corps - Hope,Indigo Tribe - Compassion,Star Sapphires (Violet) - Love,Black Lantern Corps - Death,White Lantern Corps - Life,Blank]
//Use standard American ring sizes. If you need help, go to http://findmyringsize.com/ |
ring_size = 16; //[3:.5:16]
//The thickness of the Power Ring's band. |
ring_thickness = 2.5; //[1:1:5]
//How far the Power Ring extends on your finger. This is a multiplier, so it will not relate directly to mm. |
ring_length_modifier = .5; //[.1:.1:1]
//The radius of your Power Ring's emblem. |
emblem_radius = 10; //[4:1:15]
//How far inset your Power Ring's emblem is.|
emblem_depth = 3; //[1:1:5]

/*[Hidden]*/
//preview[view:south, tilt:side]

function ring_radius(ring_size) = lookup(ring_size,[
    [3,(14.0/2)],
    [4,(14.8/2)],
    [5,(15.6/2)],
    [6,(16.45/2)],
    [7,(17.3/2)],
    [8,(18.2/2)],
    [9,(19.0/2)],
    [10,(19.8/2)],
    [11,(20.6/2)],
    [12,(21.4/2)],
    [13,(22.2/2)],
    [14,(23.0/2)],
    [15,(23.8/2)],
    [16,(24.6/2)]
]);
function emblem_scale(emblem_radius) = lookup(emblem_radius,[
    [4,.336],
    [5,.448],
    [6,.565],
    [7,.675],
    [8,.785],
    [9,.895],
    [10,1.005],
    [11,1.125],
    [12,1.235],
    [13,1.345],
    [14,1.456],
    [15,1.567],
]);

logo_border = 1;
e = .001; //epsilon
$fn = 50;

Lantern_Corps_Ring();


//Logo Border Guide
//difference(){
//    circle(r = emblem_radius);
//    circle(r = emblem_radius - logo_border);
//}


module Lantern_Corps_Ring(){
    if(affiliation == "Red Lantern Corps - Rage"){
        color("darkred"){
            BlankRing();
        }
    }
    if(affiliation == "Orange Lantern Corps - Avarice"){
        color("darkorange"){
            BlankRing();
        }
    }
    if(affiliation == "Sinestro Corps (Yellow) - Fear"){
        color("gold"){
            BlankRing();
        }
    }
    if(affiliation == "Green Lantern Corps - Will"){
        color("forestgreen"){
            BlankRing();
        }
    }
    if(affiliation == "Blue Lantern Corps - Hope"){
        color("darkblue"){
            BlankRing();
        }
    }
    if(affiliation == "Indigo Tribe - Compassion"){
        color("darkslateblue"){
            BlankRing();
        }
    }
    if(affiliation == "Star Sapphires (Violet) - Love"){
        color("darkviolet"){
            BlankRing();
        }
    }
    if(affiliation == "Black Lantern Corps - Death"){
        color("dimgray"){
            BlankRing();
        }
    }
    if(affiliation == "White Lantern Corps - Life"){
        color("gainsboro"){
            BlankRing();
        }
    }
    difference(){
        translate([0,-ring_radius(ring_size) - ring_thickness - emblem_depth/2 - e,0]){
            rotate([90,0,0]){
                if(affiliation == "Red Lantern Corps - Rage"){
                    color("red"){
                        RL_Logo();
                    }
                }
                if(affiliation == "Orange Lantern Corps - Avarice"){
                    color("orange"){
                        OL_Logo();
                    }
                }
                if(affiliation == "Sinestro Corps (Yellow) - Fear"){
                    color("yellow"){
                        YL_Logo();
                    }
                }
                if(affiliation == "Green Lantern Corps - Will"){
                    color("lime"){
                        GL_Logo();
                    }
                }
                if(affiliation == "Blue Lantern Corps - Hope"){
                    color("blue"){
                        BL_Logo();
                    }
                }
                if(affiliation == "Indigo Tribe - Compassion"){
                    color("mediumslateblue"){
                        IL_Logo();
                    }
                }
                if(affiliation == "Star Sapphires (Violet) - Love"){
                    color("violet"){
                        VL_Logo();
                    }
                }
                if(affiliation == "Black Lantern Corps - Death"){
                    color("black"){
                        KL_Logo();
                    }
                }
                if(affiliation == "White Lantern Corps - Life"){
                    color("white"){
                        WL_Logo();
                    }
                }
            }
        }
        translate([0,-ring_radius(ring_size) - ring_thickness - emblem_depth/2 - e,0]){
            rotate([90,0,0]){
                difference(){
                    cylinder(r = emblem_radius * 2, h = emblem_depth * 2, center = true);
                    cylinder(r = emblem_radius - logo_border + e, h = emblem_depth * 2, center = true);
                }
            }
        }
    }
}
module RL_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            //Inner Circle
            translate([0,-2.5,0]){
                difference(){
                    circle(r = (10 * .55));
                    circle(r = (10 * .55) - 1);
                }
            }
            //Right Bottom Line
            translate([5,-2.5,0]){
                square([1,11], center = true);
            }
            //Left Bottom Line
            translate([-5,-2.5,0]){
                square([1,11], center = true);
            }
            //Right Angled Line
            translate([5.433,3.616,0]){
                rotate([0,0,-30]){
                    square([1,2], center = true);
                }
            }
            //Left Angled Line
            translate([-5.433,3.616,0]){
                rotate([0,0,30]){
                    square([1,2], center = true);
                }
            }
            //Right Top Line
            translate([5.8659,6.232,0]){
                square([1,4], center = true);
            }
            //Left Top Line
            translate([-5.8659,6.232,0]){
                square([1,4], center = true);
            }
        }
    }
}
module OL_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            //Inner Circle
            difference(){
                circle(r = (10 * .55));
                circle(r = (10 * .55) - 1);
            }
            //Top Left Line
            rotate([0,0,150]){
                translate([(10 * .55) + 1.5,0,0]){
                    square([4,1], center = true);
                }
            }
            //Top Right Line
            rotate([0,0,30]){
                translate([(10 * .55) + 1.5,0,0]){
                    square([4,1], center = true);
                }
            }           
            //Bottom Left Line
            rotate([0,0,-130]){
                translate([(10 * .55) + 1.5,0,0]){
                    square([4,1], center = true);
                }
            }
            //Bottom Right Line
            rotate([0,0,-50]){
                translate([(10 * .55) + 1.5,0,0]){
                    square([4,1], center = true);
                }
            }
            translate([0,10,0]){
                rotate([0,0,-90]){
                    difference(){
                        circle($fn = 3, r = 10);
                        translate([-2,0,0]){
                            circle($fn = 3, r = 10);
                        }
                    }
                }
            }
        }
    }
}
module YL_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            //Inner Circle
            difference(){
                circle(r = (10 * .55));
                circle(r = (10 * .55) - 1);
            }
            difference(){
                //Outer Circle
                difference(){
                    circle(r = (10 * .55) + 2.5);
                    circle(r = (10 * .55) + 1.5);
                }
                union(){
                    //Bottom Middle Cutout
                    rotate([0,0,-90]){
                        translate([(10 * .55) + .75,0,0]){
                            square([3.5,3.5], center = true);
                        }
                    }
                    //Top Right Cutout
                    rotate([0,0,45]){
                        translate([(10 * .55) + .75,0,0]){
                            scale([1,.5,1]){
                                rotate([0,0,180]){
                                    circle($fn = 3, r = 3.5, center = true);
                                }
                            }
                        }
                    }
                    //Top Left Cutout
                    rotate([0,0,135]){
                        translate([(10 * .55) + .75,0,0]){
                            scale([1,.5,1]){
                                rotate([0,0,180]){
                                    circle($fn = 3, r = 3.5, center = true);
                                }
                            }
                        }
                    }
                }
            }
            //Top Left Outer Line
            rotate([0,0,145]){
                translate([(10 * .55) + 3,0,0]){
                    square([3,1], center = true);
                }
            }
            //Top Right Outer Line
            rotate([0,0,35]){
                translate([(10 * .55) + 3,0,0]){
                    square([3,1], center = true);
                }
            }
            //Top Left Inner Line
            rotate([0,0,105]){
                translate([(10 * .55) + .75,0,0]){
                    square([3.5,1], center = true);
                }
            }
            //Top Right Inner Line
            rotate([0,0,75]){
                translate([(10 * .55) + .75,0,0]){
                    square([3.5,1], center = true);
                }
            }
            //Bottom Left Line
            rotate([0,0,-105]){
                translate([(10 * .55) + .75,0,0]){
                    square([3.5,1], center = true);
                }
            }
            //Bottom Right Line
            rotate([0,0,-75]){
                translate([(10 * .55) + .75,0,0]){
                    square([3.5,1], center = true);
                }
            }
        }
    }
}
module GL_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            difference(){
                circle(r = (10 * .55));
                circle(r = (10 * .55) - 2);
            }
            difference(){
                union(){
                    translate([0,10 - 2 * 2.2,0]){
                        square([10 + 2,2], center = true);
                    }
                    translate([0,-10 + 2 * 2.2,0]){
                        square([10 + 2,2], center = true);
                    }
                }
                union(){
                    translate([(10 + 2)/2 + .8,(10 * .55),0]){
                        rotate([0,0,110]){
                            circle($fn = 3, r = 2);
                        }
                    }
                    translate([-(10 + 2)/2 - .8,(10 * .55),0]){
                        rotate([0,0,70]){
                            circle($fn = 3, r = 2);
                        }
                    }
                    translate([(10 + 2)/2 + .8,-(10 * .55),0]){
                        rotate([0,0,130]){
                            circle($fn = 3, r = 2);
                        }
                    }
                    translate([-(10 + 2)/2 - .8,-(10 * .55),0]){
                        rotate([0,0,50]){
                            circle($fn = 3, r = 2);
                        }
                    }
                }
            }
        }
    }
}
module BL_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            //Inner Circle
            difference(){
                circle(r = (10 * .55));
                circle(r = (10 * .55) - 1);
            }
            difference(){
                //Outer Circle
                difference(){
                    circle(r = (10 * .55) + 2.5);
                    circle(r = (10 * .55) + 1.5);
                }
                union(){
                    //Top Right Cutout
                    rotate([0,0,65]){
                        translate([(10 * .55) + .75,0,0]){
                            scale([1,.3,1]){
                                rotate([0,0,180]){
                                    circle($fn = 3, r = 4, center = true);
                                }
                            }
                        }
                    }
                    //Top Left Cutout
                    rotate([0,0,115]){
                        translate([(10 * .55) + .75,0,0]){
                            scale([1,.3,1]){
                                rotate([0,0,180]){
                                    circle($fn = 3, r = 4, center = true);
                                }
                            }
                        }
                    }
                    //Bottom Right Cutout
                    rotate([0,0,-65]){
                        translate([(10 * .55) + .75,0,0]){
                            scale([1,.3,1]){
                                rotate([0,0,180]){
                                    circle($fn = 3, r = 4, center = true);
                                }
                            }
                        }
                    }
                    //Bottom Left Cutout
                    rotate([0,0,-115]){
                        translate([(10 * .55) + .75,0,0]){
                            scale([1,.3,1]){
                                rotate([0,0,180]){
                                    circle($fn = 3, r = 4, center = true);
                                }
                            }
                        }
                    }
                }
            }
            //Top Middle Line
            rotate([0,0,90]){
                translate([(10 * .55) + .75,0,0]){
                    square([3.5,1], center = true);
                }
            }
            //Top Right Line
            rotate([0,0,120]){
                translate([(10 * .55) + .75,0,0]){
                    square([3.5,1], center = true);
                }
            }
            //Top Right Line
            rotate([0,0,60]){
                translate([(10 * .55) + .75,0,0]){
                    square([3.5,1], center = true);
                }
            }
            //Bottom Middle Line
            rotate([0,0,-90]){
                translate([(10 * .55) + .75,0,0]){
                    square([3.5,1], center = true);
                }
            }            
            //Bottom Left Line
            rotate([0,0,-120]){
                translate([(10 * .55) + 1.5,0,0]){
                    square([2,1], center = true);
                }
            }
            //Bottom Right Line
            rotate([0,0,-60]){
                translate([(10 * .55) + 1.5,0,0]){
                    square([2,1], center = true);
                }
            }
        }
    }
}
module IL_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            //Inner Circle
            difference(){
                circle(r = (10 * .55));
                circle(r = (10 * .55) - 1);
            }
            //Top Triangle
            rotate([0,0,90]){
                translate([(10 * .54),0,0]){
                    scale([.65,1.10,1]){
                        difference(){
                            circle($fn = 3, r = (10 * .55));
                            translate([-2,0,0]){
                                circle($fn = 3, r = (10 * .55));
                            }
                        }
                    }
                }
            }
            //Bottom Triangle
            rotate([0,0,-90]){
                translate([(10 * .54),0,0]){
                    scale([.65,1.10,1]){
                        difference(){
                            circle($fn = 3, r = (10 * .55));
                            translate([-2,0,0]){
                                circle($fn = 3, r = (10 * .55));
                            }
                        }
                    }
                }
            }
        }
    }
}
module VL_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            difference(){
                union(){
                    //Large Right Point
                    translate([4,0,0]){
                        scale([1,.5,1]){
                            circle($fn = 3, r = 4.9);
                        }
                    }
                    //Large Bottom Point
                    rotate([0,0,-90]){
                        translate([4,0,0]){
                            scale([1,.5,1]){
                                circle($fn = 3, r = 4.9);
                            }
                        }
                    }
                    //Large Left Point
                    rotate([0,0,180]){
                        translate([4,0,0]){
                            scale([1,.5,1]){
                                circle($fn = 3, r = 4.9);
                            }
                        }
                    }
                    //Large Top Point
                    rotate([0,0,90]){
                        translate([4,0,0]){
                            scale([1,.5,1]){
                                circle($fn = 3, r = 4.9);
                            }
                        }
                    }
                    rotate([0,0,45]){
                        //Small Top-Right Point
                        translate([2.5,0,0]){
                            scale([1,.5,1]){
                                circle($fn = 3, r = 5);
                            }
                        }
                        //Small Bottom-Right Point
                        rotate([0,0,-90]){
                            translate([2.5,0,0]){
                                scale([1,.5,1]){
                                    circle($fn = 3, r = 5);
                                }
                            }
                        }
                        //Small Bottom-Left Point
                        rotate([0,0,180]){
                            translate([2.5,0,0]){
                                scale([1,.5,1]){
                                    circle($fn = 3, r = 5);
                                }
                            }
                        }
                        //Small Top-Left Point
                        rotate([0,0,90]){
                            translate([2.5,0,0]){
                                scale([1,.5,1]){
                                    circle($fn = 3, r = 5);
                                }
                            }
                        }
                    }
                }
                //Inner Circle
                scale([.45,.75,1]){
                    circle(r = (10 * .55) - 1);
                }
            }
        }
    }
}
module KL_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            //Triangle
            rotate([0,0,-90]){
                translate([2.5,0,0]){
                    scale([.65,1,1]){
                        difference(){
                            circle($fn = 3, r = 10);
                            translate([.3,0,0]){
                                circle($fn = 3, r = 7);
                            }
                        }
                    }
                }
            }
            intersection(){
                //Lines Over Triangle
                union(){
                    translate([0,5.5,0]){
                        square([2,8], center = true);
                    }
                    translate([3,5.5,0]){
                        square([2,8], center = true);
                    }
                    translate([6,5.5,0]){
                        square([2,8], center = true);
                    }
                    translate([-3,5.5,0]){
                        square([2,8], center = true);
                    }
                    translate([-6,5.5,0]){
                        square([2,8], center = true);
                    }
                }
                circle(r = 8.75);
            }
        }
    }
}
module WL_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            //Triangle
            rotate([0,0,-90]){
                translate([4.4,0,0]){
                    scale([.65,.65,1]){
                        difference(){
                            circle($fn = 3, r = 10);
                            circle($fn = 3, r = 7);
                        }
                    }
                }
            }
            //Circle Over Triangle
            translate([0,-6,0]){
                difference(){
                    circle(r = 10);
                    circle(r = 9.5);
                }
            }
            //Points Aiming At Triangle
            translate([0,9.85,0]){
                rotate([0,0,-90]){
                    scale([1,.15,1]){
                        circle($fn = 3, r = 10);
                    }
                }
            }
            rotate([0,0,15]){
                translate([-1.5,10.2,0]){
                    rotate([0,0,-90]){
                        scale([1,.15,1]){
                            circle($fn = 3, r = 10);
                        }
                    }
                }
            }
            rotate([0,0,30]){
                translate([-3,11.5,0]){
                    rotate([0,0,-90]){
                        scale([1,.15,1]){
                            circle($fn = 3, r = 10);
                        }
                    }
                }
            }
            rotate([0,0,45]){
                translate([-4.5,13.5,0]){
                    rotate([0,0,-90]){
                        scale([1,.15,1]){
                            circle($fn = 3, r = 10);
                        }
                    }
                }
            }
            rotate([0,0,-15]){
                translate([1.5,10.2,0]){
                    rotate([0,0,-90]){
                        scale([1,.15,1]){
                            circle($fn = 3, r = 10);
                        }
                    }
                }
            }
            rotate([0,0,-30]){
                translate([3,11.5,0]){
                    rotate([0,0,-90]){
                        scale([1,.15,1]){
                            circle($fn = 3, r = 10);
                        }
                    }
                }
            }
            rotate([0,0,-45]){
                translate([4.5,13.5,0]){
                    rotate([0,0,-90]){
                        scale([1,.15,1]){
                            circle($fn = 3, r = 10);
                        }
                    }
                }
            }
        }
    }
}
module BlankRing(){
    difference(){
        difference(){
            hull(){
                scale([1,1,ring_length_modifier]){
                    sphere(r = ring_radius(ring_size) + ring_thickness);
                }
                translate([0,-ring_radius(ring_size) - ring_thickness - emblem_depth,0]){
                    difference(){
                        sphere(r = emblem_radius, center = true);
                        translate([0,-emblem_radius/2 + e,0]){
                            cube([emblem_radius * 2,emblem_radius,emblem_radius * 2], center = true);
                        }
                    }
                }
            }
            InnerDiameter(emblem_radius * 10);
        }
        translate([0,-ring_radius(ring_size) - ring_thickness - emblem_depth/2,0]){
            rotate([90,0,0]){
                cylinder(r = emblem_radius - logo_border, h = emblem_depth, center = true);
            }
        }
        translate([-ring_radius(ring_size) + ring_thickness/2,0,0]){
            rotate([90,0,90]){
                linear_extrude(height = ring_thickness, center = true){
                    if(ring_size == 3){
                        text("3", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 4){
                        text("4", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 5){
                        text("5", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 6){
                        text("6", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 7){
                        text("7", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 8){
                        text("8", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 9){
                        text("9", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 10){
                        text("10", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 11){
                        text("11", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 12){
                        text("12", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 13){
                        text("13", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 14){
                        text("14", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 15){
                        text("15", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                    if(ring_size == 16){
                        text("16", size = ring_length_modifier * 10, font = "Century Gothic:style=Bold", halign = "center", valign = "center");
                    }
                }
            }
        }
    }
}
module InnerDiameter(
    id_height = 1
){   
    linear_extrude(height = id_height, center = true){
        circle(r = ring_radius(ring_size));
    }
}