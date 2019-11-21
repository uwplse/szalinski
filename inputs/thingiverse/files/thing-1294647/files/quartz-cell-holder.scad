/* [HOUSING_PARAMETERS] */

//windows

window_height = 200;
window_width = 130;
window_width_repaired = window_width - 0.001;
    
//frames

frame_thickness = 50;
frame_height = window_height + 2 * frame_thickness;
frame_width = window_width + 2 * frame_thickness;
frame_width_repaired = frame_width + 0.001;

// [0:frame_thickness]
chamfer = 5;
bevel_width = frame_thickness - chamfer;
// [0:frame_thickness]
bevel_height = 25;

//screws

// [basement_height = screwhead_height + screwstem_height]
screwhead_height = 45;
// [basement_height = screwhead_height + screwstem_height]
screwstem_height = 25;
screwhead_radius = 40;
screwstem_radius = 20;

make = "INEXTREMIS";

/* [Hidden] */

//basement
basement_height = screwhead_height + screwstem_height;
basement_width = frame_width;

//complete block
block_height = basement_height + frame_height;
block_width = frame_width;
echo("BLOCK SIZE (L x W x H) = ", block_width, block_width, block_height);

//origin
ox = 0; //origin's_x
oy = 0; //origin's_y
oz = 0; //origin's_z

block_center = [ox, oy, oz + block_height/2];
frame_center = [ox, oy, oz + basement_height + frame_height/2];
window_center = frame_center;
basement_center = [ox, oy, oz + basement_height/2];


// Main geometry
difference() {
    translate(block_center)
    block(block_width, block_width, block_height);
    translate(frame_center)
    windowHoles();
    translate(basement_center)
        basementHole(screwhead_height, screwhead_radius, screwstem_height, screwstem_radius);

    //VERTICAL GRAFFITI
    //translate(basement_center + [0, frame_width/2 - 3 , 0])
    //    rotate([90, 0, 180])
    //    letterBlock(make, size = 20);

    //BASE GRAFFITI
    translate([-frame_width/4, 0, 10])
        rotate([180, 0, 90])
        letterBlock(make, size = 20 );
}

module letterBlock(word, size) {
            // convexity is needed for correct preview
            // since characters can be highly concave
            linear_extrude(height=size, convexity=4)
                text(word, 
                     size=size,
//                   font="Bitstream Vera Sans:style=Bold",
//                   font="Liberation Sans:style=Bold",
                     font="SF Fedora Outline:style=Bold",
//                   font="TeXGyreChorus:style=Bold",
                     halign="center",
                     valign="center");
}

module prism_z(w, h, l) {
	translate([0, 0, -l/2]) rotate(a = [0, 0, 0]) 
	linear_extrude(height = l) polygon(points = [
		[0, 0],
		[w, 0],
		[0, h]
	], paths=[[0,1,2]]);
}

module wHoleA() rotate([0, 0, 0]) windowHole(frame_width_repaired, window_width, window_height);

module wHoleB() rotate([0, 0, 90]) windowHole(frame_width_repaired, window_width, window_height);

module wHoleC() mainRoom(window_width, window_width, frame_height);

module windowHoles() {
    union() {
        wHoleA();
        wHoleB();
        wHoleC();
        hFrames();
        vFrames();
        cones();
    }
}

module block(l, w, h) {
	cube([l, w, h], center = true);	//main room
}

module mainRoom(l, w, h) {
	color("white") cube([l, w, h], center = true);	//main room
}

module basementHole(head_height, head_radius, stem_height, stem_radius) {
    color("silver") {
        union(){
            translate([0, 0, stem_height/2]) 
            cylinder(h = head_height, r1 = head_radius, r2 =  head_radius,  center = true); 
            translate([0, 0, -head_height/2]) 
            cylinder(h = stem_height, r1 = stem_radius, r2 =  stem_radius,  center = true); 
        }
    }
}

module windowHole(l, w, h) {
    cube([l, w, h],  center = true); 
}

module pyramid(h, r) {
    cylinder(h = h, r1 = 0, r2 = r);
}

module hFrames(){
   //TOP FRAMES
    color("red") translate([-frame_width_repaired/2, 0, window_height/2]) rotate (a = [90, 0, 0])
    prism_z(bevel_width, bevel_height, window_width_repaired);
    color("yellow") translate([frame_width_repaired/2, 0,  window_height/2]) rotate (a = [90, 0, 180])
    prism_z(bevel_width, bevel_height, window_width_repaired);
    color("blue") translate([0,  -frame_width_repaired/2, window_height/2]) rotate (a = [90, 0, 90])
    prism_z(bevel_width, bevel_height, window_width_repaired);
    color("green") translate([0, frame_width_repaired/2, window_height/2]) rotate (a = [90, 0, -90])
    prism_z(bevel_width, bevel_height, window_width_repaired);
    
    //BOTTOM FRAMES
    color("red") translate([-frame_width_repaired/2, 0, -window_height/2]) rotate (a = [90, 180, 180])
    prism_z(bevel_width, bevel_height, window_width_repaired);
    color("yellow") translate([frame_width_repaired/2, 0, -window_height/2]) rotate (a = [90, 180, 0])
    prism_z(bevel_width, bevel_height, window_width_repaired);
    color("blue") translate([0, -frame_width_repaired/2, -window_height/2]) rotate (a = [90, 180, -90])
    prism_z(bevel_width, bevel_height, window_width_repaired);
    color("green") translate([0, frame_width_repaired/2, -window_height/2]) rotate (a = [90, 180, 90])
    prism_z(bevel_width, bevel_height, window_width_repaired);
}   
    
module vFrames() {
    color("red") translate([- frame_width_repaired/2, + window_width_repaired/2, 0]) rotate (a = [0, 0, 0])
    prism_z(bevel_width, bevel_height, window_height);
    color("red") translate([- frame_width_repaired/2, - window_width_repaired/2, 0]) rotate (a = [180, 0, 0])
    prism_z(bevel_width, bevel_height, window_height);
    color("yellow") translate([+ frame_width_repaired/2, - window_width_repaired/2, 0]) rotate (a = [0, 0, 180])
    prism_z(bevel_width, bevel_height, window_height);
    color("yellow") translate([frame_width_repaired/2, window_width_repaired/2, 0]) rotate (a = [180, 0, 180])
    prism_z(bevel_width, bevel_height, window_height);
    
    color("blue") translate([ - window_width_repaired/2, - frame_width_repaired/2, 0]) rotate (a = [0, 0, 90])
    prism_z(bevel_width, bevel_height, window_height);
    color("blue") translate([ + window_width_repaired/2,  - frame_width_repaired/2, 0]) rotate (a = [180, 0, 90])
    prism_z(bevel_width, bevel_height, window_height);
    color("green") translate([+ window_width_repaired/2, + frame_width_repaired/2, 0]) rotate (a = [0, 0, -90])
    prism_z(bevel_width, bevel_height, window_height);
    color("green") translate([ - window_width_repaired/2, + frame_width_repaired/2, 0]) rotate (a = [180, 0, -90])
    prism_z(bevel_width, bevel_height, window_height);
}     

module cone() {
    pyramid (frame_thickness - chamfer, bevel_height);
}

module cones() {
    //TOP cones
    color("yellow") translate ([window_width/2 + chamfer, window_width/2, window_height/2]) rotate ([0, 90, 0])
    cone();
    color("yellow") translate ([window_width/2 + chamfer, -window_width/2, window_height/2]) rotate ([0, 90, 0])
    cone();
    color("red") translate ([-(window_width/2 + chamfer), -window_width/2, window_height/2]) rotate ([0, -90, 0])
    cone();
    color("red") translate ([-(window_width/2 + chamfer), window_width/2, window_height/2]) rotate ([0, -90, 0])
    cone();

    color("blue") translate ([window_width/2, -(window_width/2 + chamfer), window_height/2]) rotate ([90, 0, 0])
    cone();
    color("blue") translate ([-window_width/2, -(window_width/2 + chamfer), window_height/2]) rotate ([90, 0, 0])
    cone();
    color("green") translate ([-window_width/2, window_width/2 + chamfer, window_height/2]) rotate ([-90, 0, 0])
    cone();
    color("green") translate ([window_width/2, window_width/2 + chamfer, window_height/2]) rotate ([-90, 0, 0])
    cone();
        
    //bottom cones
    color("yellow") translate ([window_width/2 + chamfer, -window_width/2, -window_height/2]) rotate ([0, 90, 0])
    cone();
    color("yellow") translate ([window_width/2 + chamfer, window_width/2, -window_height/2]) rotate ([0, 90, 0])
    cone();
    color("red") translate ([-(window_width/2 + chamfer), window_width/2, -window_height/2]) rotate ([0, -90, 0])
    cone();
    color("red") translate ([-(window_width/2 + chamfer), -window_width/2, -window_height/2]) rotate ([0, -90, 0])
    cone();

    color("blue") translate ([window_width/2, -(window_width/2 + chamfer), -window_height/2]) rotate ([90, 0, 0])
    cone();
    color("blue") translate ([-window_width/2, -(window_width/2 + chamfer), -window_height/2]) rotate ([90, 0, 0])
    cone();
    color("green") translate ([-window_width/2, window_width/2 + chamfer, -window_height/2]) rotate ([-90, 0, 0])
    cone();
    color("green") translate ([window_width/2, window_width/2 + chamfer, -window_height/2]) rotate ([-90, 0, 0])
    cone();
}
