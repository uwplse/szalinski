part = "left"; // [left,left-endstop,right,right-endstop,double,left-double-endstop,right-double-endstop,left-slim,left-slim-endstop,right-slim,right-slim-endstop,left-middle,left-middle-endstop,right-middle-endstop]

demo = "no"; // [yes,no]

clamp = "rubber"; // [torus:Torus shaped clamp,rubber:Rubber ring clamp]

// Clearance of the various holes, depends on the printer and slicer
hole_tolerance = .2; // [0:0.05:1]

// Select predefined bushing or use custom
bushing = "140947"; // [custom:Use Custom Bushing Parameters,140947:HC-Cargo 140947 (ID 8.02mm flanged),140916:HC-Cargo 140916 (ID 8.02mm),140250:HC-Cargo 140250 (ID 8.09mm),141091:HC-Cargo 141091 (ID 8.12mm flanged),b0812:SF-1 0812 8mm ID x 10mm OD x 12mm L PTFE-coated self-lubricating bushing,b081517:8x15x17 graphite-filled self-lubricating brass bushing,b081208:8x12x8 graphite-filled self-lubricating brass bushing]

rubber_ring_diameter=1.75;

oiling_block="yes"; // [yes,no]

/* [Custom bushing sizes - Cargo 140947 as example] */

// Inner diameter
custom_bushing_inner_diameter=8.02;
// Outer Diameter
custom_bushing_outer_diameter=11.5;
// Bushing length (including flange)
custom_bushing_length=9.98;
// Flange outer diameter, 0 to disable
custom_bushing_collar_outer_diameter=14.5;
// Flange height, 0 to disable
custom_bushing_collar_height=1.5;

/* [Advanced parameters] */

endstop_sidewall_thickness=4;

//For a torus shaped clamp
bushing_wall_gap=0.6;
bushing_preload=0.05;
//For a torus shaped clamp
bushing_clamp_ring_radius=10;
// Bushing offset from the edge
bushing_y_offset1=0.5;
bushing_y_offset2=1.5;
// Bushing holder thickness
bushing_wall=2.5;

platform_height=4;
// M4
platform_screw_diameter=4;
// Nut wrench size
platform_nut_size=7;
platform_nut_height=3.2;
platform_nut_trap_depth=2;

// Offset of the clamp screw from the bushing
clamp_screw_z_offset=1;
clamp_wall=3;
clamp_slot=4;
clamp_thickness=5;
clamp_nut_trap_depth=2;
clamp_screw_washer_diameter=6;

// M3
clamp_screw_diameter=3;
// Nut wrench size
clamp_nut_size=5.5;
//clamp_nut_height=2.4;

// Oiling block params

// Oiling block wall thickness
oiling_wall=1.5;
// Oiling block height from bottom to the rod
oiling_height=5;
// Hole for oil filling
oiling_hole=3;

// Printing support

supportless_angle=55;
support_wall_thickness=0.7;
bridge_thickness=0.4;

/* [Hidden] */

support_structures="yes"; // [yes,no]

// Orientation of the clamping screw cap
orientation = inarray(split(part,"-"),"left")?"left":"right";

// Position
position = inarray(split(part,"-"),"middle")?"middle":"side";

slim=inarray(split(part,"-"),"slim")?true:false;

// Number of bushings in the block
num_bushings = (inarray(split(part,"-"),"double")&&!slim)?2:1;

endstop_sidewall=inarray(split(part,"-"),"endstop")?true:false;


// SC8UU sizes - http://3dprinter.my/reprap/wp-content/uploads/2015/07/SCS8uu-spec.jpg
sc_width=34;
sc_length=30;
sc_height=22;
sc_holes=[24,18];
sc_center=11;
sc_G=18;
sc_T=6;
sc_I=7;
// Measured
sc_ww1=30;
// Measured
sc_ww2=14;
// Measured
sc_hh2=1;

bushings = [
    // [name, [ID, OD, length, flange OD, flange height]]
    // Custom bushing sizes
    [ "custom", [custom_bushing_inner_diameter,custom_bushing_outer_diameter,
        custom_bushing_length,custom_bushing_collar_outer_diameter,
        custom_bushing_collar_height]],
    // Cargo 140947, https://hc-cargo.com/com-en/catalog/p/140947--bushing
    [ "140947", [8.02,11.5,9.98,14.5,1.5]],
    // Cargo 140916, https://hc-cargo.com/com-en/catalog/p/140916--bushing
    [ "140916", [8.02,11.51,11.43,0,0]],
    // Cargo 140250, https://hc-cargo.com/com-en/catalog/p/140250--bushing
    [ "140250", [8.09,11.12,10,0,0]],
    // HC-Cargo 141091
    [ "141091", [8.12,11.55,9,14.1,1.5]],
    // SF-1 0812 8mm ID x 10mm 0D x 12mm L PTFE-coated self-lubricating bushing
    [ "b0812", [8,10,12,0,0]],
    // 8x15x17 graphite-filled self-lubricating brass bushing, not tested
    // https://www.aliexpress.com/wholesale?SearchText=8x15x17+graphite
    [ "b081517", [8,15,17,0,0]],
    // 8x12x8 graphite-filled self-lubricating brass bushing, not tested
    // https://www.aliexpress.com/wholesale?SearchText=081208+graphite
    [ "b081208", [8,12,8,0,0]],
];

bushing_sizes=get_bushing(bushing);
bushing_inner_diameter=bushing_sizes[0];
bushing_outer_diameter=bushing_sizes[1];
bushing_length=bushing_sizes[2];
bushing_collar_outer_diameter=bushing_sizes[3];
bushing_collar_height=bushing_sizes[4];

$fn=64;

// Calculated parameters

actual_bushing_wall=clamp=="rubber"
    ?max(1+rubber_ring_diameter/2,bushing_wall)
    :bushing_wall;

actual_bushing_wall_gap=clamp=="rubber"
    ?rubber_ring_diameter/2-bushing_preload+hole_tolerance
    :bushing_wall_gap;

actual_block_height=sc_center+bushing_outer_diameter/2+clamp_screw_z_offset+clamp_screw_diameter/2+hole_tolerance+clamp_nut_size/sqrt(3)+1;

actual_oiling_block=(oiling_block=="yes"&&!slim)?true:false;

actual_bushing_y_offset2=(slim||position=="middle")?bushing_y_offset1:bushing_y_offset2;

// Split function by Nathanaël Jourdane from https://www.thingiverse.com/thing:1237203
function split(str, sep=" ", i=0, word="", v=[]) =
	i == len(str) ? concat(v, word) :
	str[i] == sep ? split(str, sep, i+1, "", concat(v, word)) :
	split(str, sep, i+1, str(word, str[i]), v);

// Find member in an array
function inarray(v, tok, ii=0) =
    ii == len(v)
        ?false
        :v[ii] == tok
            ?true
            :inarray(v,tok,ii+1);

// Fake associative array, see http://forum.openscad.org/feedback-let-echo-and-assert-in-expressions-tp19111p19311.html
function get_bushing(name, /**/ i=0) =
    i == len(bushings) ?
        undef
        : bushings[i][0] == name ?
            bushings[i][1]
            : get_bushing(name, i+1);

module reflect(v)
{
    children();
    mirror(v)
        children();
}

//bushing_shape(wall_offset=0,orientation="middle");
module bushing_shape(wall_offset=0,orientation="bottom")
{
//    translate([0,sc_length/2-bushing_y_offset1-actual_bushing_y_offset2-bushing_length-(wall_offset>0?0:.001)])
//        square([bushing_outer_diameter/2+actual_bushing_wall_gap+wall_offset,bushing_y_offset1+actual_bushing_y_offset2+bushing_length+(wall_offset>0?0:.002)]);
    
    difference() {
        // Bushing
        square([bushing_outer_diameter/2+actual_bushing_wall_gap+wall_offset,
            bushing_y_offset1+bushing_length+actual_bushing_y_offset2]);

        if (clamp=="torus") {
            // Torus shaped clamp
            translate([bushing_outer_diameter/2+hole_tolerance-bushing_preload+bushing_clamp_ring_radius+wall_offset,bushing_y_offset1+bushing_length/2]) {
                intersection() {
                    circle(r=bushing_clamp_ring_radius);
                    square([2*bushing_clamp_ring_radius,bushing_length],center=true);
                }
            }
        }
    }

    // Collar
    if (bushing_collar_outer_diameter && bushing_collar_height) {
        square([bushing_collar_outer_diameter/2+actual_bushing_wall_gap+wall_offset,
            bushing_y_offset1+bushing_collar_height]);

        // For supportless printing
        w1=bushing_collar_outer_diameter/2+actual_bushing_wall_gap+wall_offset;
        w2=bushing_outer_diameter/2-bushing_preload;
        h1=bushing_y_offset1+bushing_collar_height;
        polygon([[w1,h1],
            [w2,h1+(w1-w2)*tan(supportless_angle)],
            [w2,h1]]);
    }

    if (clamp=="rubber") {
        if (wall_offset==0) {
            // Rubber ring clamp
            translate([bushing_outer_diameter/2+actual_bushing_wall_gap,bushing_y_offset1+bushing_length/2]) {
                circle(d=rubber_ring_diameter);

                // For supportless printing
                if (orientation=="bottom") {
                    translate([sin(supportless_angle)*(rubber_ring_diameter/2),cos(supportless_angle)*(rubber_ring_diameter/2)])
                        rotate(180-supportless_angle)
                            square(rubber_ring_diameter);
                } else {
                    translate([sin(supportless_angle)*(rubber_ring_diameter/2),-cos(supportless_angle)*(rubber_ring_diameter/2)])
                        rotate(90+supportless_angle)
                            square(rubber_ring_diameter);
                }
            }
        }
    }
    
    // Protrusions for bushing insertion
    //protrusion=actual_oiling_block?1:sc_length+2;
    protrusion=1;
    if (wall_offset==0) {
        translate([0,-protrusion])
            square([max(bushing_collar_outer_diameter,bushing_outer_diameter)/2+actual_bushing_wall_gap,protrusion]);
        translate([0,bushing_y_offset1+bushing_length+actual_bushing_y_offset2])
            square([bushing_outer_diameter/2+actual_bushing_wall_gap,protrusion]);
    }
}

//clamp_shape(wall_offset=0);
module clamp_shape(wall_offset=0)
{
    if (position=="middle") {
        translate([0,-bushing_length/2-bushing_y_offset1])
            bushing_shape(wall_offset=wall_offset,orientation="bottom");

*        if (support_structures=="yes") {
            // Printing support
            ll=sc_length/2-bushing_y_offset1-bushing_length/2;
            ww=max(bushing_outer_diameter,bushing_collar_outer_diameter)/2+actual_bushing_wall_gap+wall_offset;
            a2=(wall_offset==0?1:-1)*min((bushing_wall-support_wall_thickness)/2,ll/tan(supportless_angle));
    
            translate([0,-bushing_y_offset1-bushing_length/2])
                polygon([
                    [0,-ll-(wall_offset?0:1)],
                    [ww+a2,-ll-(wall_offset?0:1)],
                    [ww+a2,-abs(a2)*tan(supportless_angle)],
                    [ww,.001],
                    [0,.001]
                ]);
        }
    } else {
        translate([0,-sc_length/2])
            bushing_shape(wall_offset=wall_offset,orientation="bottom");

        if (num_bushings==2) {
            translate([0,sc_length/2])
                mirror([0,1])
                    bushing_shape(wall_offset=wall_offset,orientation="top");
    
            if (support_structures=="yes") {
                // Printing support
                ll=sc_length-2*(bushing_y_offset1+bushing_length+actual_bushing_y_offset2);
                ww=bushing_outer_diameter/2+actual_bushing_wall_gap+wall_offset;
                a2=(wall_offset==0?1:-1)*min((bushing_wall-support_wall_thickness)/2,ll/tan(supportless_angle));
        
                polygon([
                    [0,-ll/2-.001],
                    [ww+a2,-ll/2-.001],
                    [ww+a2,ll/2-abs(a2)*tan(supportless_angle)],
                    [ww,ll/2+.001],
                    [0,ll/2+.001]
                ]);
            }
        }
    }
}

module clamp_body(wall_offset=0)
{
    translate([0,0,sc_center]) {
        rotate([-90,0,0]) {
            rotate_extrude() {
                clamp_shape(wall_offset);

*                if (wall_offset < actual_bushing_wall && num_bushings > 1) {
                    // Thinner walls between two bushings, only as a printing support
                    // XXX: simplify
                    thin=1;
                    thw_l=sc_length/2-(bushing_y_offset1+actual_bushing_y_offset2)-bushing_length;
                    thw_side=bushing_outer_diameter/2+actual_bushing_wall_gap;
                    thw_top=thw_side+min(actual_bushing_wall-thin,thw_l*tan(90-supportless_angle));
                    thw_delta=thw_top-thw_side;
                    polygon([[0,-thw_l],[thw_side,-thw_l],[thw_top,-thw_l+thw_delta*tan(supportless_angle)],[thw_top,thw_l-thw_delta*tan(supportless_angle)],[thw_side,thw_l],[0,thw_l]]);
                }
            }
        }
    }
}

module clamp_screw_hole()
{
    rotate([0,90,0]) {
        cylinder(d=clamp_screw_diameter+2*hole_tolerance,h=sc_width,center=true);
        translate([0,0,clamp_slot/2+clamp_thickness-clamp_nut_trap_depth])
            cylinder(d=2*clamp_nut_size/sqrt(3)+2*hole_tolerance,h=bushing_outer_diameter,$fn=6);
        translate([0,0,-clamp_slot/2-clamp_thickness+clamp_nut_trap_depth-bushing_outer_diameter])
            cylinder(d=clamp_screw_washer_diameter+2*hole_tolerance,h=bushing_outer_diameter);
    }
}

module platform_screw_hole()
{
    translate([0,0,-1])
        cylinder(d=platform_screw_diameter+2*hole_tolerance,h=platform_height+2);
    translate([0,0,platform_height-platform_nut_trap_depth])
        cylinder(d=2*platform_nut_size/sqrt(3)+2*hole_tolerance,h=platform_nut_height+0.5,$fn=6);
}

module endstop_sidewall()
{
    clamp_offset=1;
    translate([0,-sc_length/2+endstop_sidewall_thickness]) {
        rotate([90,0,0]) {
            linear_extrude(height=endstop_sidewall_thickness) {
                difference() {
                    reflect([1,0,0])
                        polygon([[0,0],[0,sc_G],[sc_ww1/2,sc_G],
                            [sc_ww1/2,sc_I],[sc_width/2,sc_T],
                            [sc_width/2,0]]);

                    translate([0,sc_center])
                        circle(d=max(bushing_outer_diameter,bushing_collar_outer_diameter)+2*actual_bushing_wall_gap+2*actual_bushing_wall-(position=="middle"?actual_bushing_wall-support_wall_thickness:0)+2*clamp_offset);
                    translate([0,sc_center+clamp_ledge_height/2+clamp_offset])
                        square([2*clamp_thickness+clamp_slot+2*clamp_offset-(position=="middle"?clamp_thickness-support_wall_thickness:0),clamp_ledge_height+2*clamp_offset],center=true);
                }
            }
        }
    }
}

clamp_ledge_height=actual_block_height-sc_center;
clamp_ledge_length=(num_bushings>1?sc_length:position=="middle"?(/*support_structures=="yes"?sc_length/2:*/bushing_y_offset1+bushing_length/2)+bushing_length/2+actual_bushing_y_offset2:bushing_y_offset1+actual_bushing_y_offset2+bushing_length);
clamp_ledge_y_pos=(position=="middle"/*&&support_structures!="yes"*/)?-bushing_length/2-bushing_y_offset1:-sc_length/2;

//clamp_ledge_shape();
module clamp_ledge_shape(protrude=false,)
{
    difference() {
        translate([0,clamp_ledge_y_pos-(protrude?1:0)])
            square([clamp_thickness/2,clamp_ledge_length+(protrude?2:0)]);

        if (num_bushings>1) {
            ll=sc_length-2*(bushing_y_offset1+bushing_length+actual_bushing_y_offset2);
            ww=clamp_thickness/2;
            a2=min((clamp_thickness-support_wall_thickness)/2,ll/tan(supportless_angle));

            if (support_structures=="yes") {
                polygon([
                    [ww+.001,-ll/2],
                    [ww-a2,-ll/2],
                    [ww-a2,ll/2-a2*tan(supportless_angle)],
                    [ww+.001,ll/2],
                ]);
            } else {
                translate([ww/2,0])
                    square([ww+2,ll],center=true);
            }
        }

        // Supports
*        if (support_structures=="yes" && position=="middle") {
            ll=sc_length/2-bushing_length/2-bushing_y_offset1;
            ww=clamp_thickness/2;
            a2=min((clamp_thickness-support_wall_thickness)/2,ll/tan(supportless_angle));

            polygon([
                [ww+.001,-sc_length/2-2],
                [ww-a2,-sc_length/2-2],
                [ww-a2,-sc_length/2+ll-a2*tan(supportless_angle)],
                [ww+.001,-sc_length/2+ll],
            ]);
        }
    }
}

//clamp_ledge();
module clamp_ledge()
{
    translate([0,0,sc_center]) {
        linear_extrude(height=clamp_ledge_height) {
            reflect([1,0,0]) {
                translate([clamp_slot/2+clamp_thickness/2,0,0])
                    clamp_ledge_shape(protrude=false);
                difference() {
                    translate([0,clamp_ledge_y_pos])
                        square([clamp_thickness/2+clamp_slot/2,clamp_ledge_length]);

                    if (num_bushings>1 && support_structures!="yes")
                        translate([-1,-sc_length/2+bushing_y_offset1+bushing_length+actual_bushing_y_offset2])
                            square([clamp_thickness/2+clamp_slot/2+1,sc_length-2*(bushing_y_offset1+bushing_length+actual_bushing_y_offset2)]);
                }
            }
        }
    }
}

//clamp_ledge_slot();
module clamp_ledge_slot()
{
    translate([0,0,sc_center-1]) {
        linear_extrude(height=clamp_ledge_height+2) {
            difference() {
                translate([-clamp_thickness/2-clamp_slot/2,clamp_ledge_y_pos-1])
                    square([clamp_thickness+clamp_slot,clamp_ledge_length+2]);

                reflect([1,0,0])
                    translate([-clamp_slot/2-clamp_thickness/2,0,0])
                        clamp_ledge_shape(protrude=true);
            }
        }
    }
}

oiling_length=(num_bushings==1?(position=="middle"?sc_length/2-bushing_length/2-actual_bushing_y_offset2-oiling_wall:sc_length-(bushing_y_offset1+actual_bushing_y_offset2)-bushing_length-oiling_wall):sc_length-4*bushing_y_offset1-2*bushing_length);
oiling_width=min(bushing_outer_diameter+2*actual_bushing_wall_gap,sc_holes[0]-2*platform_nut_size/sqrt(3)-oiling_wall);
oiling_wall_height=sc_center;
oiling_ypos=(num_bushings==1?(position=="middle"?bushing_length/2+actual_bushing_y_offset2:-sc_length/2+(bushing_y_offset1+actual_bushing_y_offset2)+bushing_length):-oiling_length/2);

module oiling_block_cutout()
{
    echo(str("Oiling block size: ",oiling_width," x ",oiling_length," x ",oiling_height));

    translate([-oiling_width/2,oiling_ypos,sc_center-bushing_inner_diameter/2-oiling_height])
        cube([oiling_width,oiling_length,oiling_height+bushing_inner_diameter/2+.001]);
    // Hole for oil filling
    hole_y_pos=min(oiling_ypos+oiling_length/2,sc_holes.y/2-platform_nut_size/sqrt(3)-oiling_hole/2);
    if (hole_y_pos>=oiling_ypos+oiling_hole/2) {
        translate([0,hole_y_pos,max(platform_height,oiling_wall_height-bushing_inner_diameter/2-oiling_height)+oiling_hole/2])
            rotate([0,-90,0])
                cylinder(d=oiling_hole,h=oiling_width+2*oiling_wall+2);
    }
}

module oiling_block()
{
    if (num_bushings==1) {
        difference() {
            translate([-oiling_width/2-oiling_wall,oiling_ypos-oiling_wall,0])
                cube([oiling_width+2*oiling_wall,oiling_length+2*oiling_wall,oiling_wall_height]);
*           translate([-oiling_width/2,oiling_ypos+oiling_length-1,sc_center-bushing_inner_diameter/2-1])
                cube([oiling_width,oiling_wall+2,bushing_inner_diameter/2+2]);
            translate([0,oiling_ypos+oiling_length+bridge_thickness,sc_center])
                rotate([-90,0,0])
                    cylinder(d=bushing_inner_diameter+2,h=oiling_wall+2);
        }
    } else {
        translate([-oiling_width/2-oiling_wall,oiling_ypos-oiling_wall,0])
            cube([oiling_width+2*oiling_wall,oiling_length+2*oiling_wall,oiling_wall_height]);
    }
}

actual_platform_len=slim?max(bushing_y_offset1+bushing_length+actual_bushing_y_offset2,sc_length-sc_holes.y):sc_length;

//part();
module part()
{
    difference() {
        union() {
            // Platform
            translate([-sc_width/2,-sc_length/2,0])
                cube([sc_width,actual_platform_len,platform_height]);
            
            // Bushing walls
            clamp_body(wall_offset=actual_bushing_wall);
            
            // Clamp ledge
            clamp_ledge();

            // Endstop ledge
            if (endstop_sidewall)
                endstop_sidewall();

            // Oiling block walls
            if (actual_oiling_block)
                oiling_block();
        }

        // SC8UU bottom slot
        /*
        translate([0,0,sc_hh2/2-0.5])
            cube([sc_ww2,sc_length+2,sc_hh2+1],center=true);
        */
        // Hole for bushing
        clamp_body(wall_offset=0);

        // Platform screw holes
        reflect([1,0,0])
            reflect([0,1,0])
                translate([sc_holes[0]/2,sc_holes[1]/2,0])
                    platform_screw_hole();

        clamp_ledge_slot();

        // Clamp screw holes
        for (yy=(num_bushings==1?[-1]:[-1,1])) {
            translate([0,yy*(sc_length/2-bushing_y_offset1-bushing_collar_height-(bushing_length-bushing_collar_height)/2)+(position=="middle"?sc_length/2-bushing_y_offset1-bushing_length/2:0),sc_center+bushing_outer_diameter/2+clamp_screw_z_offset+clamp_screw_diameter/2])
                clamp_screw_hole();
        }
        
        // Oiling block
        if (actual_oiling_block)
            oiling_block_cutout();
    }
}

module print()
{
    translate([0,0,sc_length/2])
        rotate([90,0,0])
            mirror([orientation=="left"?0:1,0,0])
                part();
}

module bushing()
{
    difference() {
        union() {
            translate([0,0,bushing_collar_height])
                cylinder(d=bushing_outer_diameter,h=bushing_length-bushing_collar_height);
            cylinder(d=bushing_collar_outer_diameter,h=bushing_collar_height);
        }
        translate([0,0,-1])
            cylinder(d=bushing_inner_diameter,h=bushing_length+2);
    }
}

module demo()
{
    difference() {
        mirror([orientation=="left"?0:1,0,0])
            part();
        translate([0,0,sc_center+.001])
            rotate(180)
                cube(20);
    }
    for (mm=(num_bushings==1?[1]:[0,1])) {
        mirror([0,mm,0]) {
*            translate([0,sc_length/2-bushing_y_offset1,sc_center])
                rotate([90,0,0])
                    color("sienna",0.3)
                        bushing();
            if (clamp=="rubber")
                color("gray")
                    translate([0,sc_length/2-bushing_y_offset1-bushing_length/2,sc_center])
                        rotate([90,0,0])
                            rotate(90+40)
                                rotate_extrude(angle=280)
                                    translate([bushing_outer_diameter/2-bushing_preload+rubber_ring_diameter/2+hole_tolerance,0])
                                        circle(d=rubber_ring_diameter);
        }
    }

}

if (demo=="yes")
    demo();
else if (part == "bushing")
    bushing();
else
    print();
