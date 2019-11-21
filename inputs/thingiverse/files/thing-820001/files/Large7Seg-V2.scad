/* [Basic Parameters] */

// Character Height.  (Full height of the printed block, not the height of the individual segments.)
character_height = 150;  // 150 is about as big as you can print on a Flashforge clone

// Wall Thickness.  Default = 1.6mm.
wall_thickness = 1.6;

// Which part do you want to preview?
part = "MaskedDigit"; // [MaskedDigit:Single Digit Diffused Lenses and Case,DigitCase:Single Digit Case Only,DigitLens:Single Digit Diffused Lenses,MaskedSeparator:Separator With Decimal and Colon Holes (Case and Lenses),SeparatorCase:Separator with Decimal and Colon Holes (Case only),SeparatorLens:Separator with Decimal and Colon Holes (Lens only),Slant:A 'end slant' that can be used as a spacer]

// Segment Width:  In mm  (how wide are the individual segments)
segment_width = 17;
// make sure to leave room for your LEDs!

// How thick (from the surface) should the case be?
character_thickness = 22.5;

// How thick should a lens be?
lens_thickness = 0.5;
// more than three layers will block most of your LED light - unless you are printing in a clear material.

/* [Tweaks for advanced users] */

// What is the hole size you need for mounting?
mount_hole_size = 3.5;

// What type of digits?
digit_type = 7; // [7:7 Segment,8:7 Segment and Dot,9:7 Segment and Colon,10:7 Segment-Colon-Dot,11:7 Segment-Colon-Dot-Dot]
// Don't Work atm:  14:Alphanumeric,15:Alphanumeric and Dot,16:Alphanumeric and Colon,17:Alphanumeric-Colon-Dot,18:Alphanumeric-Colon-Dot-Dot

// Slant the digits by how many degrees?
slant = 10; // [0:25]

// How far should the characters be spaced?
spacing = 1;  // [1:Super Close Together,1.5:Close Together,2:Loose,2.5:Far Apart

// How much room do you need for wires?
wire_height = 2;

// How long should the 'End slant' be on the short edge?
end_slant_length = 25; // [15:250]

/* [Hidden] */
neg_slant = -slant;
segment_height = (character_height - wall_thickness*2 - segment_width)/cos(neg_slant)/2;


/* 
 * Example Code
 */
//slants();
//example6();

main();

module main(){
    if (part == "MaskedDigit"){
        example6();
        linear_extrude(lens_thickness){
            segments_7(segment_height, segment_width, neg_slant, wall_thickness);
            translate([segment_height/2+segment_width*1.5+wall_thickness,0,0])
            dotter(segment_height, segment_width, neg_slant, wall_thickness, spacing, digit_type);
        }
        
    } else if (part == "DigitCase"){
        example6();
    } else if (part == "DigitLens"){
        linear_extrude(lens_thickness){
            segments_7(segment_height, segment_width, neg_slant, wall_thickness);
            translate([segment_height/2+segment_width*1.5+wall_thickness,0,0])
            dotter(segment_height, segment_width, neg_slant, wall_thickness, spacing, digit_type);
        }
    } else if (part == "MaskedSeparator"){
        example7();
        linear_extrude(lens_thickness){
            dotdot(segment_height, segment_width, neg_slant, spacing);
            colon(segment_height, segment_width, neg_slant, spacing);
        }
    } else if (part == "SeparatorCase"){
        example7();
    } else if (part == "SeparatorLens"){
        linear_extrude(lens_thickness){
            dotdot(segment_height, segment_width, neg_slant, spacing);
            colon(segment_height, segment_width, neg_slant, spacing);
        }
    } else if (part == "Slant"){
        slants();
    } else {    
        example6();
    }
}

module example6(){
    difference(){
        example4();
        translate([0,0,wall_thickness])
        linear_extrude(character_thickness*2)
        offset(-wall_thickness)
        projection(cut=true)
        translate([0,0,-character_thickness/2])
        example4();
        for(x = [-1,1]){
            translate([x*segment_height/3*2*sin(neg_slant),x*segment_height/3*2,0])
            cylinder(h = mount_hole_size*2.5/2, d1 = mount_hole_size*2.5, r2 = 0,$fs=0.5);
        }
    }
    segment_height = (character_height - wall_thickness*2 - segment_width)/cos(neg_slant)/2;
    for(x = [-1,1]){
        translate([x*segment_height/3*2*sin(neg_slant),x*segment_height/3*2,0])
        difference(){
            cylinder(h = (mount_hole_size*2.5+wall_thickness*2)/2, d1 = mount_hole_size*2.5+wall_thickness*2, r2 = 0,$fs=0.5);
            cylinder(h = mount_hole_size*2.5/2, d1 = mount_hole_size*2.5, r2 = 0,$fs=0.5);
            linear_extrude(character_thickness+2)
            circle(d = mount_hole_size, $fs=0.5, center=true);
        }
    }
    //anchor(segment_height, segment_width, neg_slant, wall_thickness, spacing, digit_type);

}
module example7(){
    difference(){
        union(){
            difference(){
                example5();
                translate([0,0,wall_thickness])
                linear_extrude(character_thickness*2)
                offset(-wall_thickness)
                projection(cut=true)
                translate([0,0,-character_thickness/2])
                example5();
                
                for(x = [-1,1]){
                    translate([x*(segment_width/2-wall_thickness*2),x*(segment_width/2+mount_hole_size+wall_thickness),0])
                    cylinder(h = mount_hole_size*2.6, d1 = mount_hole_size*2.6, r2 = 0);
                }
                
            }
            
            
            for(x = [-1,1]){
                translate([x*(segment_width/2-wall_thickness*2),x*(segment_width/2+mount_hole_size+wall_thickness),0])
                difference(){
                    cylinder(h = mount_hole_size*2.5+wall_thickness*2, d1 = mount_hole_size*2.5+wall_thickness*2, r2 = 0);
                    cylinder(h = mount_hole_size*2.5, d1 = mount_hole_size*2.5, r2 = 0);
                    linear_extrude(character_thickness+2)
                    circle(d = mount_hole_size, $fs=1, center=true);
                }
            }
            
        }
    }
}
 
 
module example1(){
    for (neg_slant = [0,25]){
        segment_height = (character_height - wall_thickness*2 - segment_width)/cos(neg_slant)/2;
        translate([neg_slant*8,0,0])
        difference(){
            linear_extrude(20)
            case(segment_height, segment_width, neg_slant, wall_thickness,    spacing, digit_type);
            translate([0,0,-5])
            linear_extrude(30){
                segments_7(segment_height, segment_width, neg_slant, wall_thickness);
                
            }
            translate([segment_height/2+segment_width*1.5+wall_thickness,0,-5])
            linear_extrude(30){
                colon(segment_height, segment_width, neg_slant, spacing);
                dotdot(segment_height, segment_width, neg_slant, spacing);
            }
        }
    }
}

module example3(){
    heightpiece1 = 22;
    targetheight = 25;
    riserheight = targetheight-heightpiece1;
    segment_height = (character_height - wall_thickness*2 - segment_width)/cos(neg_slant)/2;
    difference(){
        union(){
            linear_extrude(riserheight+2){
            case(segment_height, segment_width, neg_slant, 
                    wall_thickness, spacing, digit_type);
            }
        }
        translate([0,0,-2])
        linear_extrude(targetheight){
            offset(-1.2)
            segments_7(segment_height, segment_width, neg_slant, wall_thickness/2);
        }
        translate([0,0,-3])
        linear_extrude(targetheight)
        for(x = [-1,1]){
            translate([x*segment_height/3*2*sin(neg_slant),x*segment_height/3*2,0])
            circle(d = mount_hole_size*1.5, $fs=1, center=true);
            translate([x*(segment_height/2+segment_width/2-mount_hole_size/2),0,0])
            circle(d = mount_hole_size*1.5, $fs=1, center =true);
            translate([x*segment_height/5*2*sin(neg_slant),x*segment_height/5*2,0])
            circle(d = mount_hole_size*1.5, $fs=1, center=true);
        }
        translate([0,0,1])
        linear_extrude(targetheight){
            for(x = [-1,1]){
                translate([x*segment_height*2/3,0,0])
                square([segment_width*2,segment_width],center=true);
            }
            //offset(-1.2)
            segments_7(segment_height, segment_width, neg_slant, 0);
        }
        translate([0,0,riserheight])
        linear_extrude(10){
            offset(wall_thickness*1.2)
            segments_7(segment_height, segment_width, neg_slant, 0);
        }
        translate([0,0,riserheight])
        linear_extrude(10){
            for(x = [-1,1]){
                translate([x*(segment_height/2+segment_width/2),0,0])
                rotate(-neg_slant)
                square([segment_width*1.5,segment_height*2.5],center=true);
            }
        }
    }
    
}

module example4(){
    wire_height = 2;
    difference(){
        single(character_height, segment_width, neg_slant, wall_thickness,              spacing,digit_type, character_thickness);
        translate([0,0,character_thickness-wire_height])
        linear_extrude(wire_height*2)
        segments_7(segment_height, segment_width, neg_slant, 0);
        translate([0,0,character_thickness-wire_height])
        linear_extrude(wire_height*2)
        square([segment_height*4, segment_width], center=true);
        if (digit_type % 7 > 0){
            translate([segment_height/2 + segment_width*1.5 + wall_thickness,0,character_thickness-wire_height])
            linear_extrude(wire_height*2)
            rotate(90-neg_slant)
            square([segment_height*2, segment_width*.7], center=true);
        }
    }

}

module example5(){
    wire_height = 2;
    difference(){
        dots(character_height, segment_width, neg_slant, wall_thickness,              spacing,digit_type, character_thickness);
        translate([0,0,character_thickness-wire_height])
        linear_extrude(wire_height*2)
        square([segment_height, segment_width], center=true);
        translate([0,0,character_thickness-wire_height])
        linear_extrude(wire_height*2)
        rotate(90-neg_slant)
        square([segment_height*2, segment_width*.7], center=true);
    }
    
}

module single(character_height = 100, segment_width = 10, neg_slant=10, wall_thickness=1.6,spacing = 1, digit_type=7, character_thickness = 5){
    difference(){
        linear_extrude(character_thickness)
        case(segment_height, segment_width, neg_slant, wall_thickness, spacing, digit_type);
        translate([0,0,-5])
        linear_extrude(character_thickness+10){
            if(floor(digit_type/7)==1){    
                segments_7(segment_height, segment_width, neg_slant, wall_thickness);
            } else {
                segments_14(segment_height, segment_width, neg_slant, wall_thickness);
            }
            
            for(x = [-1,1]){
                translate([x*segment_height/3*2*sin(neg_slant),x*segment_height/3*2,0])
                circle(d = mount_hole_size, $fs=0.5, center=true);
                //translate([x*(segment_height/2+segment_width/2-mount_hole_size/2),0,0])
                //circle(d = mount_hole_size, $fs=1, center =true);
            }
        }
        translate([segment_height/2+segment_width*1.5+wall_thickness,0,-5])
        linear_extrude(character_thickness+10){
            dotter(segment_height, segment_width, neg_slant, wall_thickness, spacing, digit_type);
        }
    }
}

module dotter(segment_height = 100, segment_width = 10, neg_slant=10, wall_thickness=10, spacing = 1, digit_type = 7){
    if(digit_type%7==1){
        dot(segment_height,segment_width, neg_slant, spacing);
    }
    if(digit_type%7==2){
        colon(segment_height, segment_width, neg_slant, spacing);
    }
    if(digit_type%7==3){
        dot(segment_height,segment_width, neg_slant, spacing);
        colon(segment_height, segment_width, neg_slant, spacing);
    }
    if(digit_type%7==4){
        dotdot(segment_height,segment_width, neg_slant, spacing);
        colon(segment_height, segment_width, neg_slant, spacing);
    }
}

module dotscase(segment_height = 100, segment_width = 10, neg_slant=10, wall_thickness=1.6,spacing = 1, digit_type=7, character_thickness=10){
    corner_x = (segment_height + (segment_width/2 + wall_thickness)/cos(neg_slant)) * sin(neg_slant) ;
    corner_y = segment_height * cos(neg_slant) + segment_width/2  + wall_thickness;
    linear_extrude(character_thickness){
        difference(){
            polygon([[ - spacing * segment_width*1.5/2-wall_thickness + corner_x, corner_y], 
                [segment_width*spacing*1.5/2+wall_thickness + corner_x, corner_y],
                [segment_width*spacing*1.5/2+wall_thickness - corner_x, -corner_y],
                [- spacing * segment_width*1.5/2-wall_thickness - corner_x, -corner_y]]);
            colon(segment_height, segment_width, neg_slant, spacing);
            dotdot(segment_height, segment_width, neg_slant, spacing);
            
            for(x = [-1,1]){
                translate([x*(segment_width/2-wall_thickness*2),x*(segment_width/2+mount_hole_size+wall_thickness),0])
                circle(d = mount_hole_size,center=true, $fs = .5 );
            }
        }
    }
}

module dotscase2(segment_height = 100, segment_width = 10, neg_slant=10, wall_thickness=1.6,spacing = 1, digit_type=7, character_thickness=10){
    segment_height = (character_height - wall_thickness*2 - segment_width)/cos(neg_slant)/2;
    corner_x = (segment_height + (segment_width/2 + wall_thickness)/cos(neg_slant)) * sin(neg_slant) ;
    corner_y = segment_height * cos(neg_slant) + segment_width/2  + wall_thickness;
    linear_extrude(character_thickness){
        difference(){
            polygon([[ - spacing * segment_width*1.5/2-wall_thickness + corner_x, corner_y], 
                [segment_width*spacing*1.5/2+wall_thickness + corner_x, corner_y],
                [segment_width*spacing*1.5/2+wall_thickness - corner_x, -corner_y],
                [- spacing * segment_width*1.5/2-wall_thickness - corner_x, -corner_y]]);
            
        }
    }
}

module dots(character_height = 100, segment_width = 10, neg_slant=10, wall_thickness=1.6,spacing = 1, digit_type=7, character_thickness = 5){
    dotscase(segment_height, segment_width, neg_slant, wall_thickness, spacing, digit_type, character_thickness);
}

module slants(){
    xspace = sin(neg_slant)*character_height;
    extra = end_slant_length;
    
    
    for(x = [0]){
        rotate(x){
            difference(){
                union(){
                    difference(){
                        linear_extrude(character_thickness)
                        polygon([[-xspace,-character_height/2],[-xspace+extra,-character_height/2],[-xspace+extra,character_height/2],[-0,character_height/2]]);
                        translate([0,0,wall_thickness/2])
                        linear_extrude(character_thickness+2)
                        offset(-wall_thickness)
                        polygon([[-xspace,-character_height/2],[-xspace+extra,-character_height/2],[-xspace+extra,character_height/2],[-0,character_height/2]]);
                        translate([0,0,character_thickness])
                        cube([character_height, segment_width, 4], center=true);
                    }
                    for (y = [-1,1]){
                        difference(){
                            union(){
                                translate([-xspace+extra/2, y*(character_height/2-wall_thickness*2-mount_hole_size*2),0])
                                union(){
                                    cylinder(d=mount_hole_size+wall_thickness*2, h=character_thickness, $fs = .5);
                                    cylinder(d1=mount_hole_size*3+wall_thickness*2, d2=0, h=mount_hole_size*1.5, $fs=.5);
                                }
                                translate([-xspace+extra/2, y*(character_height/2-wall_thickness-mount_hole_size),character_thickness/2])
                                cube([mount_hole_size+wall_thickness*2,mount_hole_size+wall_thickness*4, character_thickness],center=true);
                            }
                            
                            
                        }
                        
                    }
                }
                for (y = [-1,1]){
                    translate([-xspace+extra/2, y*(character_height/2-wall_thickness*2-mount_hole_size*2),0])
                    union(){
                        cylinder(d=mount_hole_size, h=character_thickness*2, center=true, $fs = .5);
                        cylinder(d1=mount_hole_size*3, d2=0, h=mount_hole_size*1.5, $fs=.5);
                    }
                }
            }
        }
    }
    
    
}

module segments_7(segment_height = 100, segment_width = 10, neg_slant=10, wall_thickness=1.6){
    segment_shift_x = segment_height/2 * sin(neg_slant);
    segment_shift_y = segment_height/2 * cos(neg_slant);    
    difference(){
        union(){
            for (x = [1, -1]){
                for (y = [1,-1]){
                    // draw the basic segments
                    translate([x * segment_height/2 + y * segment_shift_x, y * segment_shift_y,0])
                    rotate([0,0,-neg_slant])
                    square([segment_width, segment_height],center=true);
                    // round the corners
                    translate([x * segment_height/2 + y * segment_shift_x * 2, y * cos(neg_slant) * segment_height, 0])
                    circle(r = segment_width/2, $fs=.5);
                }
            }
            for (y = [-1:1:1]){
                translate([y * segment_shift_x*2 , y * cos(neg_slant) * segment_height,0])
                square([segment_height, segment_width], center= true);
            }
        } // end union for segments
        for (y = [-1,1]){ // split the segments
            for (r = [-1,1]){
                translate([y * segment_shift_x, y * segment_shift_y])
                rotate([0,0,r * 45-neg_slant/2])
                square([segment_height*3, wall_thickness],center=true);
            }
        }
        // remove the left overs on the x axis
        for( r = [0,180]){
            rotate([0,0,r]){
                translate([segment_height/2 ,0,0])
                rotate([0,0, (-45-neg_slant/2)])
                square([segment_width*2,segment_width*2]);
            }
        }
    }
}

module segments_14(segment_height = 100, segment_width = 10, neg_slant=10, wall_thickness=1.6){
    segment_shift_x = segment_height/2 * sin(neg_slant);
    segment_shift_y = segment_height/2 * cos(neg_slant);
    difference(){
        union(){
            segments_7(segment_height, segment_width, neg_slant);
            for (y = [1,-1]){
                // draw the basic segments
                translate([y * segment_shift_x, y * segment_shift_y,0])
                rotate([0,0,-neg_slant])
                square([segment_width, segment_height],center=true);
            }
        } // union
        for (r = [-1,1]){
            translate([y * segment_shift_x, segment_shift_y])
            rotate([0,0,r * 45-neg_slant/2])
            square([segment_width*3, wall_thickness],center=true);
        }
        for (y = [-1,1]){
            translate([y * segment_shift_x*2 , y * cos(neg_slant) * segment_height - y * (segment_width/2+wall_thickness/2),0])
            square([segment_width*2, wall_thickness], center= true);
        }
    }
    difference(){
        union(){
            theta1 = atan2(cos(neg_slant) * segment_height,segment_height/2 + segment_shift_x * 2);
            rotate([0,0,theta1])
            square([(segment_shift_y*2/sin(theta1))*2, segment_width], center = true);
            theta2 = atan2(cos(neg_slant) * -segment_height, segment_height/2 - segment_shift_x*2);
            rotate([0,0,theta2])
            square([(segment_shift_y*2/sin(abs(theta2)))*2, segment_width], center = true);
        } // diagonal segments
        offset(wall_thickness)union(){
            segments_7(segment_height, segment_width, neg_slant);  // basic outline
            for (y = [1,-1]){ // vertical middle segments
                translate([y * segment_shift_x, y * segment_shift_y,0])
                rotate([0,0,-neg_slant])
                square([segment_width, segment_height],center=true);
            }
        }
    }
}

module dot(segment_height = 100, segment_width = 10, neg_slant=10, spacing=1){
    dot_shift_x = -(segment_height-segment_width/3) * sin(neg_slant);
    dot_shift_y = cos(neg_slant) * -segment_height + segment_width/3;
    if (neg_slant < 0){
        translate([-dot_shift_x, -dot_shift_y, 0])
        circle(r = segment_width/1.5, $fs=.5);
    } else {
        translate([dot_shift_x, dot_shift_y, 0])
        circle(r = segment_width/1.5, $fs=.5);
    }
}

module dotdot(segment_height = 100, segment_width = 10, neg_slant=10, spacing=1){
    dot_shift_x = (segment_height-segment_width/3) * sin(neg_slant);
    for( y = [-1,1]){
        translate([y * dot_shift_x, cos(neg_slant) * y * segment_height - y * segment_width/3, 0])
        circle(r = segment_width/1.5, $fs=.5, center=true);
    }
}

module colon(segment_height = 100, segment_width = 10, neg_slant=10, spacing=1){
    dot_shift_x = segment_height/2 * sin(neg_slant);
    for( y = [-1, 1]){
        translate([y * dot_shift_x, 0.5 * cos(neg_slant) * y * segment_height, 0])
        circle(r = segment_width/1.5, $fs=.5);
    }
}

module case(segment_height = 100, segment_width = 10, neg_slant=10, wall_thickness=1.6, spacing = 1, digit_type=7){
    corner_x = (segment_height + (segment_width/2 + wall_thickness)/cos(neg_slant)) * sin(neg_slant) ;
    corner_y = segment_height * cos(neg_slant) + segment_width/2  + wall_thickness;
    if (digit_type % 7 == 0){
        // no dots to deal with
        polygon([[-segment_height/2 - spacing * segment_width + corner_x, corner_y], 
            [segment_height/2 + spacing * segment_width + corner_x, corner_y],
            [segment_height/2 + spacing * segment_width- corner_x, -corner_y],
            [-segment_height/2 - spacing * segment_width - corner_x, -corner_y]]);
    } else {
        // have to account for dots
        polygon([[-segment_height/2 - spacing * segment_width + corner_x, corner_y], 
            [segment_height/2 + segment_width*(spacing+.5) + spacing * segment_width + corner_x, corner_y],
            [segment_height/2 + segment_width*(spacing+.5) + spacing * segment_width- corner_x, -corner_y],
            [-segment_height/2 - spacing * segment_width - corner_x, -corner_y]]);

    }
}

module anchor(segment_height = 100, segment_width = 10, neg_slant=10, wall_thickness=1.6, spacing = 1, digit_type=7){
    corner_x = (segment_height + (segment_width/2 + wall_thickness)/cos(neg_slant)) * sin(neg_slant) ;
    corner_y = segment_height * cos(neg_slant) + segment_width/2  + wall_thickness;
    if (digit_type % 7 == 0){
        // no dots to deal with
        translate([-segment_height/2 - spacing * segment_width + corner_x, corner_y,0])
        cylinder(d = 20,h = 1);
        
        translate([segment_height/2 + spacing * segment_width + corner_x, corner_y,0])
        cylinder(d = 20, h =1);
        
        
        translate([segment_height/2 + spacing * segment_width- corner_x, -corner_y,0])
        cylinder(d = 20, h = 1);
        
        translate([-segment_height/2 - spacing * segment_width - corner_x, -corner_y,0])
        cylinder(d = 20, h=1);
    } else {
        // have to account for dots
        translate([-segment_height/2 - spacing * segment_width + corner_x, corner_y,0])
        cylinder(d = 20, h = 1);
        translate([segment_height/2 + segment_width*(spacing+.5) + spacing * segment_width + corner_x, corner_y,0])
        cylinder(d = 20, h = 1);
        translate([segment_height/2 + segment_width*(spacing+.5) + spacing * segment_width- corner_x, -corner_y,0])
        cylinder(d = 20, h = 1);
        translate([-segment_height/2 - spacing * segment_width - corner_x, -corner_y,0])
        cylinder(d = 20, h = 1);

    }
}
