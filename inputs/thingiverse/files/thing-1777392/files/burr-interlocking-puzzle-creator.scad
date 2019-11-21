/* [Global] */

// Length is given in standard units.
stick_length = 6; // [5:18]

// The unit size is in mm. Piece size will be length*2*2 units.
unit_size = 8; // [4:Very small,6:Small,8:Normal,10:Large,12:Very large]

// To allow for small printing errors
gap_size = 0.2; // [0.1:Small,0.2:Normal,0.3:Large,0.4:Extra large]

// The edges can be slightly rounded.
rounding_radius = 1.6; //[0:No rounding,0.8:Small,1.6:Normal,2.4:Large]

// Some variations for the stick.
base_model = 0; // [0:Rectangular,1:Rounded,2:Carved,3:Pointed]

// Choose a complete puzzle...
chosen_set = 2; // [0:None (use next),1:Diabolical Structure,2:Chinese Cross,3:Six Way Set,4:Yamato Block,5:Love's Dozen,6:Piston Burr,7:Computer's Choice Unique 10,8:Baffling Burr Puzzle,9:Hoffmann Burr,10:Philippe Dubois,11:Tenyo Brother,12:Double Cross,13:Artifactory 5/4]

// ...or choose a certain piece...
chosen_piece = 0; // [0:None (use next),1:The key (1),2:Local mail (18),3:Out of town mail (35),4:The side tray (52),5:The half tray (103),6:The three quarters tray (120),7:The tray (256),8:The mailbox (86),9:The toaster (154),10:The opener (188),11:The barbells (871),12:The tongue (928),13:The Y (1024),14:The notched half tray L (359),15:The notched half tray R (615),16:The wall L (792),17:The wall R (911),18:The offset L (824),19:The offset R (975),20:The fingered club L (856),21:The fingered club R (943),22:The club L (888),23:The club R (1007),24:The finger L (960),25:The finger R (992)]

// ...or enter manually the piece number (1-1024)
piece_number = 975;


/* [Hidden] */


// the length of the stick in units e
length = stick_length;

// e is the unit width/height/depth of the pieces
// each piece has dimensions [length*e,2*e,2*e]
e = unit_size;

// d is the gap between the cutting plane and the integer position n*e (to make assembling easier and to allow for small printing errors)
d = gap_size;

// r is the rounding radius (which can be zero for no rounding)
r = rounding_radius;

// choose base 0, 1, 2 or 3 to select a base piece
base = base_model;




/**********************************************************
 *** MAIN CALL                                          ***
 **********************************************************/
 
// choose either burr_piece(n) to create one piece number n
// (see below) or burr_set(set) to create a pre-defined set

if(chosen_set>0) {
    burr_set(complete_set[chosen_set-1]);
} else {
    if(chosen_piece>0) {
        burr_piece(notchable25set[chosen_piece-1]);
    } else {
        burr_piece(piece_number);
    };
};

// SEE ROB'S PUZZLE PAGE FOR A LOT OF BACKGROUND INFORMATION
// http://www.robspuzzlepage.com/interlocking.htm





/**********************************************************
 *** PREDEFINED BURR SETS                               ***
 **********************************************************/

// named pieces
the_key = 1;
local_mail = 18;
out_of_town_mail = 35;
the_side_tray = 52;
the_half_tray = 103;
the_three_quarters_tray = 120;
the_tray = 256;
the_mailbox = 86;
the_toaster = 154;
the_opener = 188;
the_barbells = 871;
the_tongue = 928;
the_y = 1024;
the_notched_half_tray_L = 359;
the_notched_half_tray_R = 615;
the_wall_L = 792;
the_wall_R = 911;
the_offset_L = 824;
the_offset_R = 975;
the_fingered_club_L = 856;
the_fingered_club_R = 943;
the_club_L = 888;
the_club_R = 1007;
the_finger_L = 960;
the_finger_R = 992;

// common six-piece burr designs
diabolical_structure = [1,256,256,256,928,928];
chinese_cross = [1,256,824,975,928,1024];
six_way_set = [52,792,911,824,975,1024];
yamato_block = [1,188,824,975,1024,1024];

// other six-piece burr designs
love_s_dozen = [88,512,704,960,992,1008];
piston_burr = [88,512,768,922,1008,1008];
computer_s_choice_unique_10 = [624,702,768,883,1015,1024];
baffling_burr_puzzle = [52,615,792,960,992,975];
hoffmann_burr = [1,188,256,960,975,1024];
philippe_dubois = [120,160,256,512,880,960];
tenyo_brother = [463,564,760,909,927,1016];
double_cross = [1,154,256,256,1024,1024];
artifactory_5_4 = [412,480,512,704,704,960];

complete_set = [diabolical_structure,chinese_cross,six_way_set,yamato_block,love_s_dozen,piston_burr,computer_s_choice_unique_10,baffling_burr_puzzle,hoffmann_burr,philippe_dubois,tenyo_brother,double_cross,artifactory_5_4];


// set containing all 25 notchable pieces
notchable25set = [
    1,18,35,52,103,
    120,256,86,154,188,
    871,928,1024,359,615,
    792,911,824,975,856,
    943,888,1007,960,992];

// set containing all 25 notchable pieces including doublets or triplets needed to build all 314 solid burrs
notchable42set = [
    1,18,18,35,52,52,
    103,120,256,256,256,86,
    154,188,188,871,871,928,
    928,1024,1024,1024,359,615,
    792,792,911,911,824,824,
    975,975,856,943,888,888,
    1007,1007,960,960,992,992];


/**********************************************************
 *** HOW A BURR PIECE IS DEFINED                        ***
 **********************************************************/

/*

    +----+----+----+----+----+----+
   /    / 16 / 32 / 64 / 128/    /|
  +    +----+----+----+----+    + |
 /    /  1 /  2 /  4 /  8 /    /  +
+----+----+----+----+----+----+   |
|    |    |    |    |    |    |   |
|    |    |    |    |    |    |   +
+    +----+----+----+----+    +  / 
|         |    |    |         | +  
|         | 256| 512|         |/   
+----+----+----+----+----+----+    

A Burr piece is made of a standard 6x2x2 cube from which
sections are removed. The number n to the module
burr_piece(n) is a 12 bits binary number. If a bit is
set (one) the corresponding 1x1x1 cube is removed from
the base piece. 1024 and 2048 are hidden behind 256 and
512.

*/


/**********************************************************
 *** CODE                                               ***
 **********************************************************/

eps=0.001;

module base() {
    if(base==0) {
        translate([r,r,r])
            cube([length*e-2*r,2*e-2*r,2*e-2*r]);
    };
    if(base==1) {
        union() {
            translate([r,r,e])
                cube([length*e-2*r,2*e-2*r,e-r]);
            translate([e,r,r])
                cube([(length-2)*e,2*e-2*r,e-r+eps]);
            translate([e,r,e]) rotate([-90,0,0])
                cylinder(r=e-r,h=2*e-2*r,$fn=24);
            translate([(length-1)*e,r,e]) rotate([-90,0,0])
                cylinder(r=e-r,h=2*e-2*r,$fn=24);
        };
    };
    if(base==2) {
        difference() {
            translate([r,r,r])
                cube([length*e-2*r,2*e-2*r,2*e-2*r]);
            translate([-eps,-3/4*e+r,e/2])
                cube([length*e+2*eps,e,e]);
            translate([-eps,7/4*e-r,e/2])
                cube([length*e+2*eps,e,e]);
            translate([-eps,e/2,-3/4*e+r])
                cube([length*e+2*eps,e,e]);
        };
    };
    if(base==3) {
        union() {
            translate([e,r,r])
                cube([(length-2)*e,2*e-2*r,2*e-2*r]);
            translate([e+eps,e,2*e-r]) rotate([0,-90,0])
                linear_extrude(height=e-r,scale=0)
                    polygon([[-2*e+2*r,-e+r],[0,-e+r],[0,e-r],[-2*e+2*r,e-r]]);
            translate([(length-1)*e-eps,e,2*e-r]) rotate([0,-90,0])
                scale([1,1,-1]) linear_extrude(height=e-r,scale=0)
                    polygon([[-2*e+2*r,-e+r],[0,-e+r],[0,e-r],[-2*e+2*r,e-r]]);
        };
    };
};
module cut() {
    translate([1,1,1]*(-r-d)) cube(e+2*r+2*d);
};
module cut_cube(n) {
    difference() {
        base();
        for(i=[0:3]) { // poor man's AND function
            if(floor(n/pow(2,i+1))!=floor(n/pow(2,i))/2)
                translate([length/2+i-2,0,1]*e) cut();
            if(floor(n/pow(2,i+5))!=floor(n/pow(2,i+4))/2)
                translate([length/2+i-2,1,1]*e) cut();
        };
        for(i=[0:1]) {
            if(floor(n/pow(2,i+9))!=floor(n/pow(2,i+8))/2)
                translate([length/2+i-1,0,0]*e) cut();
            if(floor(n/pow(2,i+11))!=floor(n/pow(2,i+10))/2)
                translate([length/2+i-1,1,0]*e) cut();
        };
    };
};    

module burr_piece(n) {
    if(r>0) {
        minkowski() {
            cut_cube(n-1);
            sphere(r,$fn=12);
        };
    } else {
        cut_cube(n-1);
    };
};

module burr_set(set) {
    n=ceil(sqrt(len(set)*3/(length+1)));
    for(i=[0:len(set)-1])
        translate([(i-n*floor(i/n))*(length+1),floor(i/n)*3,0]*e)
            burr_piece(set[i]);
};
