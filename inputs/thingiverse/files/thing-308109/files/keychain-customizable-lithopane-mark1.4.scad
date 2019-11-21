//keychain-Customizable Lithopane by Mark G. Peeters 
//http://www.thingiverse.com/thing:308109
//version 1.3 
//if you are using openSCAD then you are cool! You can get DAT files for local use using this tool
//http://customizer.makerbot.com/image_surface
// i used the nice code for adjusting layers from here:
//http://www.thingiverse.com/thing:74322

// preview[view:south, tilt:top]
//
//
/* [Image] */

// Load a 100x100 pixel image.(images will be stretched to fit) Simple photos work best. Don't forget to click the Invert Colors checkbox! *** ALSO IF YOU HAVE LETTERS IN YOUR IMAGE make sure to reverse the image before uploading so the letters are not backwards.
image_file = "image-surface.dat"; // [image_surface:100x100]

/* [Adjustments] */

//shape NOTE: ALL units are in millimeters (mm)
shape = 0;//[0:circle, 1:square]
//over all size of the keychain. you picked
tag_size = 40;// [20:70]
// size for keyring 4.5 or 5 is good.
ring_hole=4.5;
// What layer height will you slice this at?  The thinner the better.
layer_height = 0.1;
//Use plastic color opacity to set this. The lower the layer height, the more layers you can use. you picked
number_of_layers = 12; // [5:30]
//Width of boarder lining the keychain (3mm is fine)
boarder_width = 3;//
//boarder thickness lining the keychain (at least 3mm for strength)
boarder_thick = 3;//

/* [Hidden] */

// base (white) will always be 2 layers thick
min_layer_height = layer_height*2;
height = layer_height*number_of_layers;
maxheight = height+min_layer_height;


// Make litho and trim bottom and sides
  difference() { //diff 1
  translate([0, 0, min_layer_height]) scale([(tag_size/100),(tag_size/100),height]) surface(file=image_file, center=true, convexity=5); //litosurface moved up min_layer_height
  translate([0,0,-(maxheight)]) linear_extrude(height=maxheight) square(tag_size, center=true);//cutting bottom off surface

if (shape==0) {//you picked circle shape------------------------------------
difference() {  //diff make tube to trim lith
                translate([0, 0, -7]) cylinder(maxheight+15,r= tag_size); //outside
                translate([0, 0, -9]) cylinder(maxheight+18,r= (tag_size/2)); //inside
               } //end diff make tube
translate([0, tag_size/2+boarder_width, -1])cylinder(maxheight+2,r= ring_hole/2); //ring hole
}//end if you picked circle------------------------------------------

if (shape==1) {//you picked square shape------------------------------------
difference() {  //diff make cube to trim litho
                translate([0, 0, -7]) cube(tag_size+15,center=true); //outside
               translate([0, 0, -9]) cube(tag_size,center=true); //inside
               } //end diff make tube
translate([tag_size/2, tag_size/2, -1])cylinder(maxheight+2,r= ring_hole/2); //ring hole
}//end if you picked square

}//end diff 1

//add boarder and loop
if (shape==0) {//you picked circle shape--------------------------
translate([0, tag_size/2+boarder_width, 0]) //move loop
difference(){//make loop
cylinder(boarder_thick,r=boarder_width+ring_hole/2); //ring support
translate([0, 0, -1])cylinder(boarder_thick+2,r= ring_hole/2); //ring hole
}

difference() {  //diff make frame tube
                 cylinder(boarder_thick,r= (tag_size/2)+boarder_width); //outside
                 cylinder(boarder_thick+1,r= (tag_size/2.02)); //inside
translate([0, tag_size/2+boarder_width, -1])cylinder(boarder_thick+2,r= ring_hole/2); //ring hole
                } //end diff make frame tube

}//end if you picked circle------------------------------------------

if (shape==1) {//you picked square shape------------------------------------
translate([tag_size/2, tag_size/2, 0]) //move loop
difference(){//make loop
cylinder(boarder_thick,r=boarder_width+ring_hole/2); //ring support
translate([0, 0, -1])cylinder(boarder_thick+2,r= ring_hole/2); //ring hole
}

difference() {  //diff make frame tube
                 translate([0,0,boarder_thick/2]) cube([tag_size+boarder_width*2,tag_size+boarder_width*2,boarder_thick],center=true); //outside
                 translate([0,0,boarder_thick/2]) cube([tag_size-1,tag_size-1,boarder_thick+1],center=true); //inside
translate([tag_size/2, tag_size/2, -1])cylinder(boarder_thick+2,r= ring_hole/2); //ring hole                
                        } //end diff make frame tube
}//end if you picked square------------------------------------------------





