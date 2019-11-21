// Thickness of the back / bottom of the case
$caseback=0.9;
// Thickness of the case walls
$caseedge=1.2;

// Thickness of the text cutout. Will be all the way through if larger than the case back thickness.
$textthickness = 0.4;
// First line of text
$text1="";
// Size of the first line of text
$text1size=20;
// Font for the first line of text
$text1font="Microsoft New Tai Lue";
// Space between the two lines of text
$textlinespace=3;
// Second line of text
$text2 ="";
// Size of the second line of text
$text2size=20;
// Font for the second line of text
$text2font="Microsoft New Tai Lue";
// Vertical offset of the text
$textvoffset=10;
// Rotation of the text around the Z axis
$textrotation=0;

// dont show any more variables in the customiser
module stopcustomiser(){}

// the overall bounding box of the phone was measured with calipers
// the outside width of the iphone
$width=66.99;
// the outside height of the iphone
$height=137.94;
// the total depth of the iphone, including screen
$depth=6.92;
// the phone has a vertical corner profile of a semi-circle
$vradius=($depth/2);
// and about this radius of horizontal corner profile
$hradius=10.25;
// the width of the screen
$screenwidth=64.55;
// the height of the screen
$screenheight=135.22;
// the depth of the screen
$screendepth=0.8;

// how much the buttons protrude from the case
$buttondepth=1;
// the radius of the button rounded end
$buttonradius=1;

// the length of the power button
$powerbuttonlength=9;
// how far the bottom of the powerbutton is from the centre
$powerbuttonfromcentre=30;

// the length of the volume buttons cluster
$volclusterlength=32;
// how far the bottom of the volume cluster is from the centre
$volclusterfromcentre=18;

// how long the bottom cutouts are for speaker holes
$bottomcutoutlength=12;
// the radius of the bottom cutouts rounded ends
$bottomcutoutradius=0.6;
// how far the bottom cutouts are from the centre
$bottomcutoutfromcentre=12;

// how long the power socket hole is
$powerlength=3;
// the radius of the power socket hole
$powerradius=1;

// how far the camera notch is from the centre
$camerapositionw=13;
// how far the camera notch is from the top
$camerapositionh=7.5;
// the radius of the camera notch rounded ends
$cameraradius=4;
// the length of the camera notch
$camerastretch=9.7;

// calculate the case size
$casewidth = $width + $caseedge*2;
$caseheight = $height + $caseedge*2;
$casedepth = $depth + $caseback;


// configure the accuracy of the rendering 
$fs=$preview ? 2 : 0.6;
$fa=$preview ? 6 : 6;

// the overall outside bounding box of the main phone body
module bbox() {
    cube([$width, $height, $depth], center=true);
}
// sanity check
if ($preview) translate([0,0,-60]) bbox();


// a rounded box with specified outer dimensions, and with specified vertical and horizontal semicircular chamfers
module roundedbox(width, height, depth, vradius, hradius) {
    // a rounded corner with different horizontal and vertical diameters
    module corner() {
        // create a vradius circle and extrude it around hradius
        rotate_extrude(convexity=1)
            translate([hradius-vradius, 0, 0]) circle(r=vradius);
    };

    // position the centre of each corner so that we get the total dimensions after hulling
    innerWidth = width / 2 - hradius;
    innerHeight = height / 2 -hradius;

    // the total hull encompassing the four corners
    hull() {
        translate([+innerWidth, +innerHeight, 0]) corner();
        translate([-innerWidth, +innerHeight, 0]) corner();
        translate([+innerWidth, -innerHeight, 0]) corner();
        translate([-innerWidth, -innerHeight, 0]) corner();
    };
}


// the overall outside shape of the phone body
module iphone6sbody() {
    roundedbox($width, $height, $depth, $vradius, $hradius);
};
// sanity check
if ($preview) translate([0,0,-50]) iphone6sbody();


// the phone body with notch around screen
module iphone6s() {
    // get phone metal body only by subtracting the screen volume
    color("silver") intersection() {
        iphone6sbody();
        translate([0,0,-$screendepth]) cube([$width, $height, $depth], center=true);
    };
    // get screen notched area only by subtracting the other part and resizing it to screen dimensions
    color("black") resize([$screenwidth,$screenheight,$screendepth]) intersection() {
        iphone6sbody();
        translate([0,0,($depth/2)-$screendepth]) cube([$width, $height, $screendepth], center=true);
    };
}
// sanity check
if ($preview) translate([0,0,-40]) iphone6s();


// the buttons / camera / power socket / speaker holes
module buttons(
    width = $width, height = $height, depth = $depth,
    buttonradius = $buttonradius, buttondepth = $buttondepth,
    powerbuttonfromcentre = $powerbuttonfromcentre, powerbuttonlength = $powerbuttonlength, powerbuttonvshift = 0,
    volclusterfromcentre = $volclusterfromcentre, volclusterlength = $volclusterlength, volclustervshift = 0,
    bottomcutoutradius = $bottomcutoutradius, bottomcutoutfromcentre = $bottomcutoutfromcentre, bottomcutoutlength = $bottomcutoutlength,
    powerradius = $powerradius, powerlength = $powerlength, powervshift = 0,
    cameraradius = $cameraradius, camerapositionw = $camerapositionw, camerapositionh = $camerapositionh, camerastretch = $camerastretch
) {

    // power button
    color("silver") translate([width/2, powerbuttonfromcentre, 0]) hull(){
        rotate([0, 90, 0]){
            translate([powerbuttonvshift, 0, 0]) cylinder(r=buttonradius, h=buttondepth, center=true);
            translate([powerbuttonvshift, powerbuttonlength, 0]) cylinder(r=buttonradius, h=buttondepth, center=true);
        }
    }

    // volume cluster
    color("silver") translate([-width/2, volclusterfromcentre, 0]) hull(){
        rotate([0, 90, 0]){
            translate([volclustervshift, 0, 0]) cylinder(r=buttonradius, h=buttondepth, center=true);
            translate([volclustervshift, volclusterlength, 0]) cylinder(r=buttonradius, h=buttondepth, center=true);
        }
    }

    // bottom long cutout left
    color("black") hull(){
        rotate([90, 90, 0]){
            translate([0, -bottomcutoutfromcentre, height/2]) cylinder(r=bottomcutoutradius, h=buttondepth, center=true);
            translate([0, -bottomcutoutlength-bottomcutoutfromcentre, height/2]) cylinder(r=bottomcutoutradius, h=buttondepth, center=true);
        }
    }

    // bottom long cutout right
    color("black") hull(){
        rotate([90, 90, 0]){
            translate([0, bottomcutoutfromcentre, height/2]) cylinder(r=bottomcutoutradius, h=buttondepth, center=true);
            translate([0, bottomcutoutlength+bottomcutoutfromcentre, height/2]) cylinder(r=bottomcutoutradius, h=buttondepth, center=true);
        }
    }

    // power cutout
    color("black") hull(){
        rotate([90, 90, 0]){
            translate([powervshift, -powerlength, height/2]) cylinder(r=powerradius, h=buttondepth, center=true);
            translate([powervshift, powerlength, height/2]) cylinder(r=powerradius, h=buttondepth, center=true);
        }
    }

    // camera cutout
    color("silver") translate([width/2-camerapositionw, height/2-camerapositionh, -depth/2]) hull(){
        cylinder(r=cameraradius, h=buttondepth, center=true);
        translate([-camerastretch,0, 0]) cylinder(r=cameraradius, h=buttondepth, center=true);
    }
}
// sanity check
if ($preview) translate([0,0,-30]) { iphone6s(); buttons(); }


// the case made up of a phone shape with a phone and buttons subtracted from it
module case() {
    difference() {
        roundedbox($casewidth, $caseheight, $casedepth, $casedepth/2, $hradius+$caseedge);

        translate([0,0,($casedepth-$depth)/2]) {

            // subtract the phone
            iphone6s();

            // make a hole for the screen
            translate([0,0,-13]) {
                resize([$screenwidth,$screenheight,5]) intersection() {
                    iphone6sbody();
                    translate([0,0,($depth/2)-$screendepth]) cube([$width, $height, $screendepth], center=true);
                }
            };
            buttons(
                buttondepth = 10, buttonradius = 2,
                powerbuttonlength = $powerbuttonlength, powerbuttonvshift = 1,
                volclusterlength = $volclusterlength, volclustervshift = 1,
                powerradius = 2.9, powervshift = 0.5,
                bottomcutoutradius = 0.8
            );
        }
    }
}
// sanity check
if ($preview) translate([0,0,-20]) { case(); }


// a text message printed in 2d then extruded vertically
module message() {
    translate([0, -$textvoffset, -$casedepth/2 + $textthickness]) rotate ([0, 180,-$textrotation]) 
    linear_extrude($textthickness) union() {
        text($text1, halign="center", size=$text1size, font=$text1font);
        translate([0, -$textlinespace-$text2size, 0]) text($text2, halign="center", size=$text2size, font=$text2font );
    }
}
// sanity check
if ($preview) translate([0,0,-10]) { message(); }


// output the completed case
difference() {
    case();
    message();
}
