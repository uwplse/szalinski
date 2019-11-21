/* xbee quad relay enclosure - Author Jim Dodgen 2019
 parts:
 relay module:
 "Deek-Robot" relay shield v1.3 (sold by many ???)
 
 terminal strips:
 for 2 or 4 relays NTE 25-B100-6 (amazon has this as a "add on")
 for single relay NTE 25-B100-3
 
 fuse:
 generic 5x20 fuse (amazon 10 pack)
*/


relays_used = 4; // only 1,2,or 4
switched_vout = 0;  // if you want a hole for a phono jack 
make_tabs = 1;  // 1 for mounting tabs
lid_title = "Jed's";

lid = 1; // 1 makes lid
enclosure = 1; // 1 makes enclosure

// all below reserved //
interior_width  = (relays_used < 4) ? 75:85;//57.5;  // 70

// all vectors are indexed by relay_used 
interior_length = (relays_used == 1)? ((switched_vout == 1)? 115:100):135;  //81.5;  //100

interior_height = (relays_used < 4) ? 35:45; //30; //testing use 45;

wall_thickness = 2;
walls = wall_thickness*2;
outer_width = interior_width+walls;
outer_length = interior_length+walls;


corner_lid_mount_size = 8;
mid_mount = corner_lid_mount_size/2;


post_width = 51;
post_length = 75;
post_height =  10;
post_radius = 3;
M3_screw_hole = 2.9; 
M3_clearence_hole = 3.4; 
post_start_width = wall_thickness+post_radius+1;
post_start_length = wall_thickness+post_radius+corner_lid_mount_size+2;

pcb_thickness = 1.5;
v9vdc = "9VDC";
switched9v = "switched 9V";
9v_wide = 9.5;
9v_high = 11.5;
9v_start = post_start_length+2.5;
phono_jack_hole_diameter = 6;
fuse_hole_diameter = 12.5;
fuse_offset = 9;
fuse_anti_rotate_width = 0; //10; // make 0 to not use
fuse_anti_rotate_single_side = 1;  // makes a D shaped cut out width needs to be set to 2* offset from center of hole
terminal_connections =  (relays_used > 1)?6:3;    

term_strip_spacing = 9.5;
term_strip_length=((terminal_connections+1)*term_strip_spacing)+term_strip_spacing;
term_strip_width=16.5;
term_strip_holes_apart = (term_strip_spacing*(terminal_connections+1));
term_strip_cutout_height = 7;
term_strip_cutout_width = term_strip_length-(term_strip_spacing*2); //+3;
term_strip_post_height = 3;

term_strip_offset_back = (relays_used == 1)? 
    (outer_length/2)-(term_strip_holes_apart/2)+5:
    (outer_length/2)-(term_strip_holes_apart/2);

term_strip_top = (relays_used < 4) ? (interior_height/5*3)+3
    :interior_height/1.4;

term_strip_bottom = (interior_height/4)+2;  // only used for 4 relays

lid_recess = 2;
lid_recess_width = 10;
lid_thickness = wall_thickness;
// all vectors are indexed by relay_used 
lid_letter_large = [0,7,10,0,10];
lid_letter_medium= [0,4,6,0,6];
lid_letter_small = [0,5,5,0,5];
part_desc = [0,"Relay","Dual Relay",0,"Quad Relay"];

tab_size = 20;
tab_holes = 4;

echo("term_strip_length", term_strip_length, "term_strip_holes_apart", term_strip_holes_apart);
$fn=40;
//term_strip_cut(0,"1","2");

difference() {  
if (enclosure == 1) make_enclosure();
 //translate ([-2,-40,0]) cube([outer_width,200,70]); 
 //translate ([0,20,0]) cube([outer_width,200,70]); 
}
if (lid == 1) 
    if (enclosure == 1) 
        translate([outer_width+5,0,0]) make_lid(); // move it out of the way
    else
        make_lid();
//translate([0,0,interior_height]) make_all_lid_holes();   

module make_enclosure() {
    difference() {    
        outer_enclosure();         
        inner_enclosure();
        // for testing 
        //translate ([10,0,wall_thickness]) cube([100,150,30]);
        //translate ([0,30,wall_thickness]) cube([100,150,30]);
        //translate ([0,0,0]) cube([100,150,30]);
        //translate ([60,0,0]) cube([100,150,30]);
        // end testing
        9v_cutout();        
        
        if (relays_used == 4) {
            term_strip_cut(term_strip_top,"1","2");           
            term_strip_cut(term_strip_bottom,"3","4");
        } else {
            term_strip_cut(term_strip_top,"1","2");
        }
            
        fillet(0,wall_thickness, interior_height);
        translate([outer_width-wall_thickness,0,0])
            fillet(90,wall_thickness, interior_height);
        translate([outer_width-wall_thickness,
            outer_length-wall_thickness,0])
            fillet(180,wall_thickness, interior_height);
        translate([0,
            outer_length-wall_thickness,0])
            fillet(-90,wall_thickness, interior_height);
       
    }
    // make corner lid mounts
    corner_lid_mount(180);
    translate([outer_width-(wall_thickness*2),0,0])
        corner_lid_mount(-90);
    translate([outer_width-(wall_thickness*2),
        outer_length-(wall_thickness*2),0])
        corner_lid_mount(0);
    translate([0,
        outer_length-(wall_thickness*2),0])
        corner_lid_mount(90);
    
    // make pcb mounint posts
    make_posts(post_height);
    // make terminal strip posts
    
    term_strip_posts(term_strip_top);
    if (relays_used == 4)        
        term_strip_posts(term_strip_bottom);
    
    // optional mounting tabs
    if (make_tabs == 1) {
        //translate([0,0,0]) mounting_tab(0);
        translate([wall_thickness,-tab_size+0.1,0]) mounting_tab(0);
        translate([outer_width-wall_thickness, outer_length+tab_size-0.1,0])
            mounting_tab(180);
    }    
}


module make_lid() {
    difference() { 
        union() {
            make_lid_top();
            make_lid_recess();
        }
        make_all_lid_holes();              
    }
    
}
module make_lid_hole(width, length) {
        translate([width,length,0]) {
            total_thickness = lid_thickness+lid_recess;
            //translate([M3_clearence_hole/2,M3_clearence_hole/2,0])
            cylinder(h=total_thickness, d=M3_clearence_hole);  
        }  
}
module make_all_lid_holes(){
        make_lid_hole(wall_thickness+mid_mount, 
            wall_thickness+mid_mount);
        make_lid_hole(outer_width-mid_mount-(wall_thickness), 
            wall_thickness+mid_mount); 
        make_lid_hole(outer_width-(wall_thickness)-mid_mount, 
            outer_length-(wall_thickness+mid_mount));
        make_lid_hole(wall_thickness+mid_mount, 
            outer_length-(wall_thickness+mid_mount)); 
}   

module make_lid_top() {
    difference() {
        cube([outer_width, outer_length, lid_thickness]); // top
        fillet(0,wall_thickness, lid_thickness);
        translate([outer_width-wall_thickness,0,0])
            fillet(90,wall_thickness, lid_thickness);
        translate([outer_width-wall_thickness,
            outer_length-wall_thickness,0])
            fillet(180,wall_thickness, lid_thickness);
        translate([0,
            outer_length-wall_thickness,0])
            fillet(-90,wall_thickness, lid_thickness);        

        if (relays_used > 1) {
            center_text("Each Terminal block", lid_letter_small[relays_used],
            "Liberation Mono:style=Bold", (outer_width/6)*2,outer_length);
            center_text("|NO|COM|NC|NO|COM|NC|", lid_letter_small[relays_used],
            "Liberation Mono:style=Bold", (outer_width/6),
            outer_length);
            } else {
            center_text("|NO|COM|NC|", lid_letter_small[relays_used],
                "Liberation Mono:style=Bold", (outer_width/6),
                outer_length);
            }
        center_text(lid_title,lid_letter_large[relays_used],
           "Liberation Mono:style=Bold Italic", outer_width+(outer_width/4),
            outer_length);
        
        center_text(part_desc[relays_used],lid_letter_medium[relays_used],
           "Liberation Mono:style=Bold", outer_width, outer_length
           );
    }
}

//center_text("AlertAway.com", size, font, width, lth);

module center_text(text, size, font, width, lth) {
    //rotate([0,180,-90])
    translate([width/2, lth/2, (0.6)]) 
    rotate([0,180,-90])
    linear_extrude(0.6) 
    text(text, size=size, font=font, halign="center", valign="center");
}

module make_lid_recess() {
    translate([wall_thickness, wall_thickness,lid_thickness]) {
        difference() {    
        cube([interior_width-0.1, interior_length-0.1, lid_recess]); // recess
        translate([lid_recess_width, lid_recess_width,0]) 
            cube([interior_width-(lid_recess_width*2), 
                interior_length-(lid_recess_width*2), lid_recess]); // recess
        }
    }
}
module 9v_cutout() { 
    translate([0,9v_start,wall_thickness+post_height+pcb_thickness]) 
        cube([wall_thickness,9v_wide,9v_high]); 
     rotate([180,-90,0]) 
        center_text(v9vdc, lid_letter_small[1],
                "Liberation Mono:style=Bold", 
                (wall_thickness+post_height+pcb_thickness),-9v_start-(9v_wide*3));    
}

module inner_enclosure() {
    translate([wall_thickness,wall_thickness,wall_thickness]) 
        cube([interior_width, interior_length, interior_height]); // real
    //cube([interior_width+10, interior_length+10, interior_height]); // test
}

module outer_enclosure() { 
    
    cube([outer_width, outer_length, interior_height]); // real
    //cube([interior_width+walls, interior_length+walls, interior_height-10]); // testing
}


module post(height,radius,screw_hole) {
    
    difference() {
        cylinder(h=height, r=radius);
        if (screw_hole > 0)
            cylinder(h=height, d=screw_hole, $fn=15); 
        // fn=15 makes it self threading
    }
}

module corner_lid_mount(rot) {
    height=interior_height-lid_recess;
    translate([wall_thickness,wall_thickness,0]) 
    rotate([0,0,rot])  
    translate([-(corner_lid_mount_size),
        -(corner_lid_mount_size),0]) 
    difference() { 
        cube([corner_lid_mount_size,
            corner_lid_mount_size,height]);
        translate([corner_lid_mount_size/2,
            corner_lid_mount_size/2,0])
            cylinder(h=height, d=M3_screw_hole, $fn=15);                  
        fillet(0,corner_lid_mount_size/2, height);
    }                   
}

module make_posts(height) {
    
    translate([post_start_width,post_start_length,wall_thickness]) 
        post(height,post_radius*1.3,0); // no screw needed here
    translate([post_start_width,post_start_length+post_length,wall_thickness]) 
        post(height,post_radius,M3_screw_hole);
    translate([post_start_width+post_width,post_start_length+post_length,wall_thickness])
        post(height,post_radius,M3_screw_hole);
    translate([post_start_width+post_width,post_start_length,wall_thickness]) 
        post(height,post_radius,M3_screw_hole);
}

nbr_offset_left = fuse_offset+(fuse_hole_diameter)+3;
nbr_offset_right = fuse_offset+(fuse_hole_diameter-1);
nbr_size=6; 
far_left = -(fuse_hole_diameter/2)-nbr_offset_left;
far_right = (relays_used > 1 || switched_vout == 1) ?
        term_strip_holes_apart+(fuse_hole_diameter/2)+nbr_offset_right
        :
        (fuse_hole_diameter/2)+fuse_offset;
cut_lth = -far_left + far_right;
//term_strip_cut(0,"5","6");
module term_strip_cut(zloc,nbr1,nbr2) {
    translate([outer_width,term_strip_offset_back,zloc])
    //translate([(outer_width/2)+(cut_lth/2),term_strip_offset_back,zloc])     
    rotate([0,-90,0]) {
        echo ("length of back cutout", -far_left + far_right);
        //translate([0,-far_left,0]) {
            raw_term_cutout(nbr1,nbr2);                                   
    //} 
    }  
}
//raw_term_cutout("7","8");

module raw_term_cutout(nbr1,nbr2) {
    cylinder(h=wall_thickness, d=M3_screw_hole, $fn=15); //screw hole in case        
    translate([0,term_strip_holes_apart,0]) 
        cylinder(h=wall_thickness, d=M3_screw_hole, $fn=15); // screw hole in case
    cutout_loc = (term_strip_holes_apart/2)-(term_strip_cutout_width/2);
    translate([-term_strip_cutout_height/2,cutout_loc,0])
        cube([term_strip_cutout_height,term_strip_cutout_width,wall_thickness]); 
        
    translate([0,-(fuse_hole_diameter/2)-fuse_offset,0])
                fuse_hole();
        
    translate([-(nbr_size/2),far_left,
                (wall_thickness/2)])                      
                rotate([0,180,-90])
                linear_extrude(1) text(nbr1,size=nbr_size);                       
    
    if (switched_vout == 1) {
       translate([0,term_strip_holes_apart+(fuse_hole_diameter/2)+fuse_offset,0])
            fuse_hole();
       translate([-15,term_strip_holes_apart+(fuse_hole_diameter/2)+fuse_offset,0])
            phono_jack();
        translate([-(nbr_size/2)-8,far_right-22,
                (wall_thickness/2)])            
            rotate([0,180,-90])
                linear_extrude(1) text(switched9v, size=3);
    }
    else if (relays_used > 1) {        
        translate([0,term_strip_holes_apart+(fuse_hole_diameter/2)+fuse_offset,0])
            fuse_hole();
            
        translate([0,-(fuse_hole_diameter/2)-fuse_offset,0])
            fuse_hole();
            
        translate([-(nbr_size/2),far_right,
                (wall_thickness/2)])            
        rotate([0,180,-90])
            linear_extrude(1) text(nbr2,size=nbr_size);
        } 

}

module phono_jack() {
    cylinder(h=wall_thickness, d=phono_jack_hole_diameter);    
}

module fuse_hole() {
    intersection() {
        union() {        
            cylinder(h=wall_thickness, d=fuse_hole_diameter);
            notch=1;
            translate([-(notch/2),(fuse_hole_diameter/2)-0.1,0]) 
            cube([notch,notch,wall_thickness]);
            translate([-(notch/2),-(fuse_hole_diameter/2)-notch+0.1,0]) 
            cube([notch,notch,wall_thickness]);
        }
        if (fuse_anti_rotate_width > 0) {
            translate([0,0,wall_thickness/2])
                cube([fuse_hole_diameter,fuse_anti_rotate_width,wall_thickness], 
                    center=true);
            if (fuse_anti_rotate_single_side == 1)
               translate([0,fuse_hole_diameter/2,wall_thickness/2]) 
                    cube([fuse_hole_diameter,fuse_anti_rotate_width,wall_thickness],
                        center=true); 
        }
    }
}

//term_strip_posts(0);
module term_strip_posts(zloc) {
    translate([outer_width,term_strip_offset_back,zloc])
    rotate([0,-90,0]) {
        translate([0,0,wall_thickness]) 
            term_post(); // screw post
        translate([0,term_strip_holes_apart,wall_thickness]) 
            term_post(); // screw post
    }
}

module term_post(height) {
    
    difference() {
        cylinder(h=term_strip_post_height, r1=post_radius,r2=post_radius/1);
        cylinder(h=term_strip_post_height, d=M3_screw_hole, $fn=15);
    }
}

module fillet(rot, r, h) {
    translate([r / 2, r / 2, h/2])
    rotate([0,0,rot]) difference() {
        cube([r + 0.01, r + 0.01, h], center = true);
        translate([r/2, r/2, 0])
            cylinder(r = r, h = h + 1, center = true);
    }
}

// mounting_tab(0);
module mounting_tab(rot) {
    tab_thickness = wall_thickness*1.5;
    width = outer_width-(wall_thickness*2);
    hole_from_end = (width/3)/2;
    half_tab_size = tab_size/2;
    rotate([0,0,rot]) {
        difference() {
            cube([width,tab_size,tab_thickness]);
            fillet(0,half_tab_size, tab_thickness);
            translate([width-(tab_size/2),0,0]) 
                fillet(90,half_tab_size, tab_thickness);
            translate([hole_from_end,half_tab_size,tab_thickness/2]) 
                cylinder(d = tab_holes, h = tab_thickness, center = true);
            translate([width-hole_from_end,half_tab_size,tab_thickness/2]) 
                cylinder(d = tab_holes, h = tab_thickness, center = true);
        }
        translate([width,tab_size,tab_thickness*2])
            rotate([180,90,0])
                fillet(90,tab_thickness, width);
    }
}

