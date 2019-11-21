/*[Ring Specs]*/

//Use standard American ring sizes. If you need help, go to http://findmyringsize.com/ |
ring_size = 12; //[3:.5:16]
//The thickness of the Power Ring's band. |
ring_thickness = 2.5; //[1:.5:5]
//How far the Power Ring extends on your finger. This is a multiplier, so it will not relate directly to mm. |
ring_length_modifier = .5; //[.1:.1:1]
//The radius of your Power Ring's emblem. |
emblem_radius = 10; //[4:1:15]
//How far inset your Power Ring's emblem is.|
emblem_depth = 3; //[1:1:5]

/*[Personality Test]*/

//What kind of pet would you most like to have?
Question_1 = 0; //[0:Please select an answer...,1011:Cat,1110000:Dog,110000100:Rat]

//If you were a musician, what kind of music would you make?
Question_2 = 0; //[0:Please select an answer...,1010000:Pop,100000010:Electronica,1001:Punk Rock,10100100:Metal]

//Which American president would you most like to meet?
Question_3 = 0; //[0:Please select an answer...,1100000:Bill Clinton,10000011:Richard Nixon,1100:George W. Bush,100010000:Barack Obama]

//Which gift would you most like to receive?
Question_4 = 0; //[0:Please select an answer...,101000:Baseball Bat & Glove,100010000:Science Book,101000010:Flowers,10000101:BB Gun]

//If you were an athlete, what kind of athelete would you be?
Question_5 = 0; //[0:Please select an answer...,10001:Hockey Player,100001010:Bodybuilder,1100000:Beach Volleyballer,10000100:MMA Fighter]

//What is your dream job?
Question_6 = 0; //[0:Please select an answer...,1011000:Teacher,100100000:Doctor,1010:CEO,10000101:Soldier]

//What is your favorite flower?
Question_7 = 0; //[0:Please select an answer...,10000001:Marigold,100000000:Lily-Of-The-Valley,1000010:Primrose, 1100:Snapdragon,110000:Carmellia]

//What is your ideal vacation?
Question_8 = 0; //[0:Please select an answer...,101100000:A romantic getaway with a loved one,111:Staying home alone watching reality TV,10011000:SPACE!]

//You've just won an award, who do you dedicate it to?
Question_9 = 0; //[0:Please select an answer...,100100000:Your parents,1010000:Your spouse,1010:Your business partner,10000101:The Dark Lord Satan]

//If you had a child, what would you name him/her after?
Question_10 = 0; //[0:Please select an answer...,110100000:A deceased family member,1100:A fairy tale,10001:A popular brand,1000010:Yourself]

/*[Hidden]*/
//preview[view:south, tilt:top diagonal]

//PERSONALITY TEST KEY:
//000000001 Red - Rage
//000000010 Orange - Avarice
//000000100 Yellow - Fear
//000001000 Green - Willpower
//000010000 Blue - Hope
//000100000 Indigo - Compassion
//001000000 Violet - Love
//010000000 Black - Death
//100000000 White - Life

answer_total = Question_1 + Question_2 + Question_3 + Question_4 + Question_5 + Question_6 + Question_7 + Question_8 + Question_9 + Question_10;
    
function affiliation_finder(answer_total,types) = [for(j = [1:types])[get_numeral_pos(j,answer_total), j]];
function get_numeral_pos(pos,number) = floor((number % pow(10,pos))/pow(10,pos-1));

function quicksort(arr) = !(len(arr)>0) ? [] : let(
    pivot   = arr[floor(len(arr)/2)],
    lesser  = [ for (y = arr) if (y[0]  < pivot[0]) y ],
    equal   = [ for (y = arr) if (y[0] == pivot[0]) y ],
    greater = [ for (y = arr) if (y[0]  > pivot[0]) y ]
) concat(
    quicksort(greater), equal, quicksort(lesser)
);

echo(affiliation_finder(answer_total,9));

echo(quicksort(affiliation_finder(answer_total,9)));

echo(quicksort(affiliation_finder(answer_total,9))[0]);
    
echo(quicksort(affiliation_finder(answer_total,9))[0][1]);

//Which Power Ring would you wear?
affiliation = "Green Lantern Corps - Will"; //[Red Lantern Corps - Rage,Orange Lantern Corps - Avarice,Sinestro Corps (Yellow) - Fear,Green Lantern Corps - Will,Blue Lantern Corps - Hope,Indigo Tribe - Compassion,Star Sapphires (Violet) - Love,Black Lantern Corps - Death,White Lantern Corps - Life,Blank]

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
preview_tab = "result";
logo_border = 1;
rings_spacing = -55;
e = .001; //epsilon
$fn = 50;


if(preview_tab == "result"){
    if(quicksort(affiliation_finder(answer_total,9))[0][0] == 0){
        Lantern_Corps_Ring(affiliation = "MakerBot");
    }
    if(quicksort(affiliation_finder(answer_total,9))[0][1] == 1 && quicksort(affiliation_finder(answer_total,9))[0][0] != 0){
        Lantern_Corps_Ring(affiliation = "Red Lantern Corps - Rage");
    }
    if(quicksort(affiliation_finder(answer_total,9))[0][1] == 2){
        Lantern_Corps_Ring(affiliation = "Orange Lantern Corps - Avarice");
    }
    if(quicksort(affiliation_finder(answer_total,9))[0][1] == 3){
        Lantern_Corps_Ring(affiliation = "Sinestro Corps (Yellow) - Fear");
    }
    if(quicksort(affiliation_finder(answer_total,9))[0][1] == 4){
        Lantern_Corps_Ring(affiliation = "Green Lantern Corps - Will");
    }
    if(quicksort(affiliation_finder(answer_total,9))[0][1] == 5){
        Lantern_Corps_Ring(affiliation = "Blue Lantern Corps - Hope");
    }
    if(quicksort(affiliation_finder(answer_total,9))[0][1] == 6){
        Lantern_Corps_Ring(affiliation = "Indigo Tribe - Compassion");
    }
    if(quicksort(affiliation_finder(answer_total,9))[0][1] == 7){
        Lantern_Corps_Ring(affiliation = "Star Sapphires (Violet) - Love");
    }
    if(quicksort(affiliation_finder(answer_total,9))[0][1] == 8){
        Lantern_Corps_Ring(affiliation = "Black Lantern Corps - Death");
    }
    if(quicksort(affiliation_finder(answer_total,9))[0][1] == 9){
        Lantern_Corps_Ring(affiliation = "White Lantern Corps - Life");
    }
}else{
    rotate([0,0,360/9 * 1]){
        translate([0,rings_spacing,0]){
            Lantern_Corps_Ring(affiliation = "Red Lantern Corps - Rage");
        }
    }
    rotate([0,0,360/9 * 2]){
        translate([0,rings_spacing,0]){
            Lantern_Corps_Ring(affiliation = "Orange Lantern Corps - Avarice");
        }
    }
    rotate([0,0,360/9 * 3]){
        translate([0,rings_spacing,0]){
            Lantern_Corps_Ring(affiliation = "Sinestro Corps (Yellow) - Fear");
        }
    }
    rotate([0,0,360/9 * 4]){
        translate([0,rings_spacing,0]){
            Lantern_Corps_Ring(affiliation = "Green Lantern Corps - Will");
        }
    }
    rotate([0,0,360/9 * 5]){
        translate([0,rings_spacing,0]){
            Lantern_Corps_Ring(affiliation = "Blue Lantern Corps - Hope");
        }
    }
    rotate([0,0,360/9 * 6]){
        translate([0,rings_spacing,0]){
            Lantern_Corps_Ring(affiliation = "Indigo Tribe - Compassion");
        }
    }
    rotate([0,0,360/9 * 7]){
        translate([0,rings_spacing,0]){
            Lantern_Corps_Ring(affiliation = "Star Sapphires (Violet) - Love");
        }
    }
    rotate([0,0,360/9 * 8]){
        translate([0,rings_spacing,0]){
            Lantern_Corps_Ring(affiliation = "Black Lantern Corps - Death");
        }
    }
    rotate([0,0,360/9 * 9]){
        translate([0,rings_spacing,0]){
            Lantern_Corps_Ring(affiliation = "White Lantern Corps - Life");
        }
    }
}

////Logo Border Guide
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
    if(affiliation == "MakerBot"){
        color("black"){
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
                if(affiliation == "MakerBot"){
                    color("white"){
                        M_Logo();
                    }
                }
            }
        }
        translate([0,-ring_radius(ring_size) - ring_thickness - emblem_depth/2 - e,0]){
            rotate([90,0,0]){
                difference(){
                    cylinder(r = emblem_radius * 3, h = emblem_depth * 2, center = true);
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
module M_Logo(){
    scale([emblem_scale(emblem_radius),emblem_scale(emblem_radius),1]){
        linear_extrude(height = emblem_depth, center = true){
            scale([.23,.23,.23]){
                translate([-1.25*(60/5.5),1.5*(60/5.5),-1/2]){
                    translate([0,(60/5.5) * 0.2,0]){
                        difference(){
                            circle(r=(60/5.5), $fn=20);
                            translate([0,-1*(60/5.5),0]){
                                square([(60/5.5),(60/5.5)]);
                            }
                        }
                    }
                    translate([2.5*(60/5.5),(60/5.5) * 0.2,0]){
                        difference(){
                            circle(r=(60/5.5), $fn=20);
                            translate([-1*(60/5.5),-1*(60/5.5),0]){
                                square([(60/5.5),(60/5.5)]);
                            }
                        }
                    }
                    translate([-1*(60/5.5),0,0]){
                        translate([0,-3.5*(60/5.5),0]){
                            square([(60/5.5),3.75*(60/5.5)]);
                        }
                        translate([(60/5.5)/2,-3.5*(60/5.5),0]){
                            circle(r=(60/5.5)/2, $fn=20);
                        }
                    }
                    translate([0.75*(60/5.5),0,0]){
                        translate([0,-3.5*(60/5.5),0]){
                            square([(60/5.5),3.75*(60/5.5)]);
                        }
                        translate([(60/5.5)/2,-3.5*(60/5.5),0]){
                            circle(r=(60/5.5)/2, $fn=20);
                        }
                    }
                    translate([2.5*(60/5.5),0,0]){
                        translate([0,-3.5*(60/5.5),0]){
                            square([(60/5.5),3.75*(60/5.5)]);
                        }
                        translate([(60/5.5)/2,-3.5*(60/5.5),0]){
                            circle(r=(60/5.5)/2, $fn=20);
                        }
                    }
                    translate([0,(60/5.5) * 0.2,0]){
                        square([2.5*(60/5.5),(60/5.5)]);
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