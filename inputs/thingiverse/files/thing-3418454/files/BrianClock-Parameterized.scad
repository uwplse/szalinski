// Brian's Clock

// preview[view:south, tilt:top]

/* [Global] */
//Surface Image
surface_image="No"; // [first:Yes, second:No]
//Surface Image File (100x100)
surface_filename="brian_outline.jpg"; // [image_surface:100x100]
//Hour Tick Marks 
hour_ticks="Yes"; // [first:Yes, second:No]
//Minute Tick Marks
min_ticks="Yes"; // [first:Yes, second:No]
//Pick a Tolerance Value for your Printer
tolerance=1.05; // [1:0.05:1.5]

/* [Clock Dimensions] */
//Length (in mm) of Hour Hand
hour_hand=50;  
//Length (in mm) of Minute Hand 
minute_hand=38;
//Length (in mm) of Second Hand
second_hand=55;
//Length (in mm) of the Clock's Hour Tick Marks
hour_tick_length=14;
//Width (in mm) of the Clock's Hour Tick Marks
hour_tick_width=4;
//Height (in mm) of the Clock's Tick Marks
tick_height=5;

/* [Gearbox Dimensions] */
//Height of Gearbox (in mm) on X Dimension
gearbox_height=56;
//Width of Gearbox (in mm) on Y Dimension
gearbox_width=56;
//Depth of Gearbox (in mm) on Z Dimension
gearbox_depth=15;
//Shaft Length (in mm)is the amount of the gearbox's shaft to be concealed by the clock face.
shaft_length=3.5;
//Shaft Diamter (in mm)
shaft_diameter=8;

/* [Backside Bevel Dimensions] */
//Bevel Height (in mm)
bevel_h=4.0; // Heighth of the Bevel (in mm)
//Inner Bevel Percentage
inner_bevel=.82; // [1:1:100] Used to Calculate the Inner Diameter of the Bevel


/* [Hidden] */

longest_arm_length=max(hour_hand, minute_hand, second_hand);  
minute_tick_length=hour_tick_length/2;
minute_tick_width=hour_tick_width/2;
clock_radius=longest_arm_length+(hour_tick_length*1.25);
peg_radius=3;
peg_height=4;
gearbox_x=gearbox_height * tolerance;
gearbox_y=gearbox_width * tolerance;
gearbox_z=gearbox_depth * tolerance;
shaft_d=shaft_diameter * tolerance;
epsilon=0.1;



clock();

module clock(){
    clockface();
    translate([(clock_radius * 2 * tolerance),0,gearbox_z]) clockbottom();
    translate([clock_radius, clock_radius, 0]) peg();
    translate([clock_radius, -clock_radius, 0]) peg();
}

module peg(){
    cylinder(r=peg_radius,h=peg_height);
    }

module clockbottom(){
        rotate([180,0,0]) difference(){
        cylinder(h=gearbox_z,r=clock_radius, center=false);    
        translate([(-gearbox_y/2),(-gearbox_x/2),-epsilon]) cube([gearbox_y,gearbox_x,gearbox_z+(2*epsilon)]);    
        translate([0,0,-epsilon]) bevel();
        translate([((gearbox_x/2)+(4*peg_radius)),0,((gearbox_z-((peg_height*tolerance)*.75))-epsilon)]) cylinder(r=peg_radius*tolerance,h=(((peg_height*tolerance)*.75)+(2*epsilon)));
        translate([((-gearbox_x/2)-(4*peg_radius)),0,((gearbox_z-((peg_height*tolerance)*.75))-epsilon)]) cylinder(r=peg_radius*tolerance,h=(((peg_height*tolerance)*.75)+(2*epsilon)));
    }
}

module clockface(){
    difference(){
        cylinder(h=shaft_length,r=clock_radius, center=false);
        if (surface_image=="Yes") scale([1,1,tick_height]) surface(file=surface_filename);
        rotate([0,0,60]){
            translate([((gearbox_x/2)+(4*peg_radius)),0,-epsilon]) cylinder(r=peg_radius*tolerance,h=(((peg_height*tolerance)*.25)*(2*epsilon)));
            translate([((-gearbox_x/2)-(4*peg_radius)),0,-epsilon]) cylinder(r=peg_radius*tolerance,h=(((peg_height*tolerance)*.25)*(2*epsilon)));
        cylinder(d=8, h=shaft_length);
            }
    }
    translate([0,0,shaft_length]) difference(){
        cylinder(h=tick_height,r=clock_radius, center=false);
        translate([0,0,epsilon]) cylinder(h=tick_height+(2*epsilon),r=clock_radius-tick_height, center=false);
    }
    
    if (hour_ticks=="Yes") for(hours=[0:(360/12):360]) rotate(a=[0,0,hours]) translate([clock_radius-hour_tick_length,-hour_tick_width/2,shaft_length-epsilon]) cube([hour_tick_length,hour_tick_width,tick_height+2*epsilon]);
    if (min_ticks=="Yes") for(minutes=[0:(360/60):360]) rotate(a=[0,0,minutes]) translate([clock_radius-minute_tick_length,-minute_tick_width/2,shaft_length-epsilon]) cube([minute_tick_length,minute_tick_width,tick_height+2*epsilon]);
}

module bevel() {
    difference(){     
        cylinder(h=bevel_h*2-epsilon, r=clock_radius+epsilon);
        hull(){        
            translate([0,0,-epsilon]) cylinder(h=bevel_h+2*epsilon, r=clock_radius*inner_bevel);
            translate([0,0,bevel_h-epsilon]) cylinder(h=bevel_h+2*epsilon, r=clock_radius+2*epsilon);
        }
    }
}