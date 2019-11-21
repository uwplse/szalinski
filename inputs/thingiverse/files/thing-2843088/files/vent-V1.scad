//Flair Vent cover 4X10 size
//N Waterton 28th March 2018 V 1.5

//designed for customizer
//preview[view:south east, tilt:top diagonal]
//$vpt=0;
//$vpr=0;
$vpd=600+0;
//Note, the vents in the battery area are blocked, so they are purely decorative (in green on the rendering).
/* [Size/Version Text] */
vent_size_text = "4x10";
vent_version_text = "V1.5";
vent_version = [vent_size_text,vent_version_text];
/* [Basic Values - Not Reccomended to Change] */
wall_thickness = 2; //Vent perimiter thickness
lid_thickness = 2; //lid top thickness
//distance between plate and bottom of vent cover
internal_height = 4;
//Resolution of the fillets
resolution = 32; 
//Don't change the above unless you know what you are doing!
//These dimensions are for the OUTSIDE of the vent. 
//external height, does not affect the internal clearances. includes 0.5 to cover the vent plate.
height = 6.5;
//external
width = 130;
//external
length = 306;
radius = 10+0; //of corners
//vent (air flow) area x size
ventWidth = 232;
//vent (air flow) area y size
ventHeight = 92;
//vertical offset of screw positions
screw_position = 53; 
//offset of airflow section from center
ventOffset = -3.5; //vent area is offset from centre because of the light strip, so vent type 2 and 3 are offset by this amount.
//width, length, height (I would not mess with this)
joining_tab = [13,15,2];   //width,length,thickness of joining tabs
/* [Things To Adjust] */
//These you can play with
//center reinforcement height (from front) - 0 for none. set to internalprotrusion+lid_thickness if you want it flush. if more than 15 the ends will be trimmed to prevent hitting internal louvres. This is offset for ventstyle 2 or it looks weird.
//center reinforcement height (from front) - 0 for none. if you increase above 18, the bar will just get thicker - not longer
center_bar_height = 25; //[0:50]
//louvre Starting Angle (0 is vertical)
louvreAngle = 20; //[0:45]
//set to 0 for same angle on all louvres
louvreAngleIncrement = 3;
//set to 0 for same angle on all louvres
sidelouvreAngleIncrement = 4;
//this is the minnimum "width" of the louvre (depends on angle). 2mm is Min, 4mm is Max
louvreWidth = 2; //[2:Min, 3:Med, 4:Max, 5:Silly]
//this is the "length" of the louvres, cut off at internalprotrusion (below), you can make shallow angle louvres shorter by reducing this.
louvreHeight = 30; //[10:50]
//internal protrusion (of louvres) usually set to same as internal_height + lid_thickness.
internalprotrusion = 6; //[6:15]
//number of horizontal louvres (only with one way and three way vents)
louvreCount = 9; //[6:10]
//number of vertical louvres per side (only with two way and three way vents)
sidelouvreCount = 6;  //[5:10]
//First Louvre
printfirstlouvre = 0; //[0:Print, 1:Do Not Print]
//last Louvre
printlastlouvre = 1;  //[0:Print, 1:Do Not Print]
horizlouvresize = ventWidth/2; //width of central part of 3 section vent (only with ventStyle 3)
v_reinforcebars = ventWidth/6; //vertical bars every x position (only with ventStyle 1)

/*======================= /
* Select vent style here *
* =======================*/
/* [Vent Style Selections] */
//Select vent style (empty, one way, two way, three way) 
ventStyle = 1; //[0:Empty, 1:one way, 2:two way, 3:three way]
//print as multiple pieces (ie one or two pieces for smaller printers)
pieces = 0;   //[0:one piece, 1:left side, 2:right side]
//rotate vent section 180 degrees (horizontal louvres go opposite way)
rotate_vent = false; //rotate vents 180 degrees
//only on two piece prints
joiningtabs = true; //set to false if you don't want tabs in a 2 piece print. Note you WILL need supports if this is enabled (and you print in 2 pieces).
print_text = true; //disables version/size text (may be too fine for some printing services)
magnet_recess = true; //include recesses for magnets






module triangle(tan_angle, a_len, depth)
{
    linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[0,a_len],[tan(tan_angle) * a_len,0]], paths=[[0,1,2]]);
    }
}

module eq_triangle(a_len, a_height, depth)
{
    linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[0,a_len],[a_height,a_len/2]], paths=[[0,1,2]]);
    }
}

module version_text() {
    text_height = 2;
    magnet_offset = (magnet_recess)?9:0;
    translate([-22,length/2-19-magnet_offset,lid_thickness+internal_height-text_height])
    linear_extrude(height=text_height)
    text(vent_version[0], font = "Liberation Sans:style=Bold", size = 5, halign = "center");
    translate([22,length/2-19-magnet_offset,lid_thickness+internal_height-text_height])
    linear_extrude(height=text_height)
    text(vent_version[1], font = "Liberation Sans:style=Bold", size = 5, halign = "center");
}

module rounded_rect(x, y, radius, height){
    if (radius > 0){
        hull(){
            translate([-x/2 + radius, y/2 - radius, 0])
            cylinder(h = height, r = radius, center = true, $fn=$fn);
            
            translate([x/2 - radius, y/2 - radius, 0])
            cylinder(h = height, r = radius, center = true, $fn=$fn);
            
            translate([-x/2 + radius, -y/2 + radius, 0])
            cylinder(h = height, r = radius, center = true, $fn=$fn);
            
            translate([x/2 - radius, -y/2 + radius, 0])
            cylinder(h = height, r = radius, center = true, $fn=$fn);
        }
    }else{
        cube([x, y, height], center = true);
    }
}

module bottom(){  //actually the top, but it's on the bottom when printing
    translate([0,0,height/2])
        difference(){
            rounded_rect(width, length, radius, height, $fn=resolution);
            translate([0,0, lid_thickness])
            rounded_rect(width - wall_thickness * 2, length - wall_thickness * 2, radius, height, $fn=resolution);
        }
}

module lights(){
    translate([0,117,0])
    rounded_rect(ventHeight, 5, 2.5, height, $fn=resolution);
}

module battery_area(){
    battery_size = [ventHeight+4,50,40];
    translate([0,(ventWidth-battery_size[1])/2,lid_thickness+internal_height+battery_size[2]/2])
    cube(battery_size, center = true);
}

module screw_holes(){
    translate([screw_position,0,0])
    cylinder(h=lid_thickness, r1=3.5, r2=2.0, center=false);
    translate([-screw_position,0,0])
    cylinder(h=lid_thickness, r1=3.5, r2=2.0, center=false);
}

module screw_boss(posn) {
    translate([posn,0,lid_thickness])
    difference() {
        cylinder(h=internal_height, r1=5.0, r2=5.0, center=false);
        cylinder(h=internal_height, r1=3.0, r2=3.0, center=false);
    }
}

module joining_tabs() {
    tab = joining_tab[0]; //width of tab
    difference() {
        translate([width/2-wall_thickness-tab/2,0,lid_thickness+joining_tab[2]/2])
        cube([tab,joining_tab[1]*2,joining_tab[2]],center=true);
        translate([screw_position,0,lid_thickness])
        //allow 0.25 clearance for holes
        cylinder(h=height-lid_thickness, r1=5.25, r2=5.25, center=false);
    }
    difference() {
        translate([-(width/2-wall_thickness-tab/2),0,lid_thickness+joining_tab[2]/2])
        cube([tab,joining_tab[1]*2,joining_tab[2]],center=true);
        translate([-screw_position,0,lid_thickness])
        //allow 0.25 clearance for holes
        cylinder(h=height-lid_thickness, r1=5.25, r2=5.25, center=false);
    }
}

module joining_hooks() {
    tab = 12; //width of hook
    tab_length = joining_tab[1]; //length of tab
    clearance = 1.0; //clearance from end of tab
    translate([width/2-wall_thickness-tab/2-1,-tab_length-clearance,lid_thickness])
    hook(tab);
    
    translate([-(width/2-wall_thickness-tab/2-1),-tab_length-clearance,lid_thickness])
    hook(tab);
}

module hook(tab) {
    hook_size = [tab,2,internal_height];
    lip_size = 1.5; //size of hook overhang
    clearance = 0.5; //clearance above tab thickness
    translate([0,0,hook_size[2]/2])
    cube(hook_size,center=true);
    translate([hook_size[0]/2,hook_size[1]/2,joining_tab[2]+clearance])
    rotate([-90,-90,90])
    triangle(45, lip_size, hook_size[0]);
}

module center_bar(posn=0) {
    tab = louvreWidth*2;   //width of center bar
    intersection() {
        union(){
            triminternalprojection();
            trimlouvres();
        }
        if(ventStyle == 2) {
            translate([(ventHeight)/2,posn-tab/2+ventOffset,0])
            rotate([-90,-90,90])
            eq_triangle(tab, center_bar_height, ventHeight);
        }
        else {
            translate([(ventHeight)/2,posn-tab/2,0])
            rotate([-90,-90,90])
            eq_triangle(tab, center_bar_height, ventHeight);
        }
    }
}

module vents(){
    translate([0,ventOffset,0])
    cube([ventHeight,ventWidth, height], center = true);
}

module empty_vent(){
    difference(){
        bottom();
        screw_holes();
        lights();
        vents();
    }
    screw_boss(screw_position);
    screw_boss(-screw_position);
    endreinforcement(length/2);
    endreinforcement(-length/2);
    sidereinforcement(ventHeight/2);
    sidereinforcement(-ventHeight/2);
}

module reinforcement(){
    if (ventStyle == 1) { //vertical bars
        for(n = [-ventWidth/2+ventOffset: v_reinforcebars: ventWidth/2+ventOffset]) {
            center_bar(round(n)!=round(ventOffset) ? n : rotate_vent==true ? ventOffset*2 : 0); //some wierdness with math rounding
        }
    }
    else if(ventStyle == 2) { //horizontal bar
        translate([0,ventOffset,internalprotrusion/2])
        cube([4,ventWidth, internalprotrusion], center = true);   
    }
}

module sidereinforcement(posn) {
    //note, slightly outside vent area
    side_reinforce = [3,ventWidth+2, internal_height]; //size of side reinforcements
    if(posn <0) {
        translate([posn-side_reinforce[0]/2,ventOffset,lid_thickness+side_reinforce[2]/2])
        cube(side_reinforce, center = true);
    }
    else {
        translate([posn+side_reinforce[0]/2,ventOffset,lid_thickness+side_reinforce[2]/2])
        cube(side_reinforce, center = true);
    }
}

module endreinforcement(posn) {
    edge_gap = 5; //distance from the edge of the plate
    reinforcement_size = [ventHeight-15, 25, internal_height];
    difference() {
        if(posn > 0)
            translate([0,posn-reinforcement_size[1]/2-edge_gap,reinforcement_size[2]/2+lid_thickness])
            cube(reinforcement_size, center = true);
        else
            translate([0,posn+reinforcement_size[1]/2+edge_gap,reinforcement_size[2]/2+lid_thickness])
            cube(reinforcement_size, center = true);
        if(print_text)
            version_text();
        mounting_screw(length/2-15);
        mounting_screw(-length/2+15);
        if(magnet_recess)
            magnet_insets();
    }
}
//magnet_insets();
module magnet_insets() {
    magnet_size=[7,2]; //radius,thickness of magnet
    translate([-20,length/2-15,lid_thickness+internal_height-magnet_size[1]])
    cylinder(h=internal_height, r1=magnet_size[0], r2=magnet_size[0], center=false);
    translate([20,length/2-15,lid_thickness+internal_height-magnet_size[1]])
    cylinder(h=internal_height, r1=magnet_size[0], r2=magnet_size[0], center=false);
    translate([-20,-length/2+15,lid_thickness+internal_height-magnet_size[1]])
    cylinder(h=internal_height, r1=magnet_size[0], r2=magnet_size[0], center=false);
    translate([20,-length/2+15,lid_thickness+internal_height-magnet_size[1]])
    cylinder(h=internal_height, r1=magnet_size[0], r2=magnet_size[0], center=false); 
}

module mounting_screw(posn) {
    translate([0,posn,lid_thickness+(height-lid_thickness)/2])
    rounded_rect(10, 22, 5, height-lid_thickness);
}

module trimlouvres() {
    translate([0,ventOffset,internalprotrusion/2])
    cube([ventHeight,ventWidth,internalprotrusion],true);
}

module triminternalprojection() {
    max_protrusion = 15;
    translate([0,ventOffset,max_protrusion/2])
    cube([ventHeight-4,ventWidth,max_protrusion],true);
}

module trimlouvreends(posn, direction) {
    translate([direction*ventHeight/2,posn+ventOffset-direction/cos(louvreAngle),internalprotrusion+lid_thickness])
    rotate([90,180, direction*-90])
    triangle(louvreAngle, internalprotrusion+lid_thickness, ventHeight);
}

module louvre(lWidth) {
    intersection() {
        trimlouvres();
        for(n = [printfirstlouvre : louvreCount-printlastlouvre]) {
            translate([-(ventHeight/2)+(ventHeight*n/louvreCount),ventOffset,0])
            rotate([0,180-(louvreAngle+(n*louvreAngleIncrement)), 0])
            cube([louvreWidth,lWidth,louvreHeight],true);
        }
        if(lWidth < ventWidth) { //ventStyle 3
            difference() {
                trimlouvres();
                trimlouvreends(-lWidth/2, 1);
                trimlouvreends(lWidth/2, -1);
            }
        }
    }         
}

module sidelouvre(lWidth,posn,start,louvredirection) {
    intersection() {
        trimlouvres();
        for(n = [start : sidelouvreCount-printlastlouvre]) {
            translate([0,ventOffset-(posn+(lWidth*-louvredirection*n/sidelouvreCount)),0])
            rotate([0,180-louvredirection*(louvreAngle+n*sidelouvreAngleIncrement), 90])
            cube([louvreWidth,ventHeight,louvreHeight],true);
        }
    }
    //fill in tiny gap at end of louvre
    if(ventOffset-(posn+(lWidth*-louvredirection)) < (ventWidth/2)*louvredirection)
        rotate(90,0,0)
        translate([ventOffset-(posn+(lWidth-louvreWidth/2)*-louvredirection),0,lid_thickness/2])
        cube([louvreWidth,ventHeight,lid_thickness],true);
}

module sidelouvres(lWidth, posn, start) {
    sidelouvre(lWidth, +posn, start, -1);
    sidelouvre(lWidth, -posn, start, 1);
    reinforcement();
}

module louvreblock(){
    if(ventStyle == 1) {
        louvre(ventWidth);
        reinforcement();
    }
    else if (ventStyle == 2)
        sidelouvres(ventWidth/2,0 ,1);
    else if(ventStyle == 3) {
        sidelouvres((ventWidth-horizlouvresize)/2,horizlouvresize/2 ,0);
        louvre(horizlouvresize);
    }
}

module vent() {
    if(ventStyle == 0)
        empty_vent();
    else {
        difference() {
            union() {
                empty_vent();
                if(rotate_vent) {
                    rotate([0,0,180])
                    translate([0,-ventOffset*2,0])
                    louvreblock();
                }
                else
                    louvreblock();
                center_bar();
            }
            battery_area();
        }
    }
}

if(pieces == 1) {   //left (has joining tabs)
    if(joiningtabs)
        joining_tabs();
    intersection() {
        translate([0,length/4,max(height, internalprotrusion, center_bar_height)/2])
        cube([width,length/2,max(height, internalprotrusion, center_bar_height)],center=true);
        vent();  
    }
}
else if(pieces == 2) {  //right
    intersection() {
        translate([0,-length/4,max(height, internalprotrusion, center_bar_height)/2])
        cube([width,length/2,max(height, internalprotrusion, center_bar_height)],center=true);
        vent();

    }
    if(joiningtabs)
        joining_hooks();
}
else
    vent();