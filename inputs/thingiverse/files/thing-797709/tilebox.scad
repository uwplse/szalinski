

// Token width
tokenwidth = 45;
// Token height
tokenheight= 45;
// Token stack depth
tokenstack = 36;
// Number of stacks to create
numstack = 2;
// Create a mirrored line of stacks
doublerev = "yes"; // [yes:yes,no:no]
// Rotation of the stacks
rotation = 10; // [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40]
// Wall size
wallsize = 1.6;
// Wobble (added to width, height and depth)
wobble = 1.5;
// Size of the holes cutout
fingersize = 24;
// Text you want to add
text = "";
// The font you want to use
font = "Slabo 27px"; // [Slabo 27px,Oswald,Indie Flower,Yanone Kaffeesatz,Titillium Web,Arvo,Lobster,Fjalla One,Bree Serif,Muli,Pacifico,Anton,Maven Pro,Monda,Lobster Two,Bangers,Sigmar One,Courgette,Fugaz One,Patrick Hand,Viga,Fredoka One,Damion,Audiowide,Black Ops One,Montserrat Alternates,Jockey One,Lily Script One]
// Size of the text
textsize = 18;
// Print the box or lid
print = "lid"; // [box:Box,lid:Lid]


$fn = 100;

basex = (tokenwidth+wobble)*numstack+wallsize*numstack+wallsize;
basey = cos(rotation)*(tokenstack+wobble+wallsize*2)+cos(rotation-90)*(tokenheight+wobble);
topy = cos(rotation)*(tokenstack+wobble+wallsize*2);
    
module inline(){
    difference(){
        union(){
             translate([-wallsize,-sin(rotation)*(tokenheight+wobble),-2]) cube([basex, basey, sin(rotation)*(tokenstack+wobble+wallsize*2)+2]);
            translate([-wallsize,0,0]) rotate([rotation,0,0]) cube([basex, tokenstack+wobble+wallsize*2, tokenheight+wobble]);
            translate([-wallsize,-sin(rotation)*(tokenheight+wobble),0]) cube([basex, tokenstack+wobble+wallsize*2, cos(rotation)*(tokenheight+wobble)]);
        }
        for(i = [0:numstack-1]) {
            translate([i*(wallsize+tokenwidth+wobble),wallsize,0]) rotate([rotation,0,0]) cube([tokenwidth+wobble, tokenstack+wobble, tokenheight+wobble+2]);
            hull(){
                rotate([90+rotation,0,0]) translate([(tokenwidth+wobble)/2+(i*(tokenwidth+wobble+wallsize)),tokenheight/2,-tokenstack-wobble-(2.15*wallsize)]) cylinder(d=fingersize,h=wallsize*2);
                rotate([90+rotation,0,0]) translate([(tokenwidth+wobble)/2+(i*(tokenwidth+wobble+wallsize)),tokenheight+wobble,-tokenstack-wobble-(2.15*wallsize)]) cylinder(d=fingersize,h=wallsize*2);
            }
        }
    }
}

module cover(){
    difference(){
        union(){
             //translate([-wallsize,-sin(rotation)*(tokenheight+wobble),-2]) cube([basex, basey, sin(rotation)*(tokenstack+wobble+wallsize*2)+2]);
           difference(){
               translate([-wallsize,-sin(rotation)*(tokenheight+wobble),cos(rotation)*(tokenheight+wobble)]) cube([basex, topy, sin(rotation)*(tokenstack+wobble+wallsize*2)+2]);
            translate([-wallsize-0.1,-0.1,wobble/10]) rotate([rotation,0,0]) cube([basex+0.2, tokenstack+wobble+wallsize*2+0.2, tokenheight+wobble]);
           }
            //translate([-wallsize,-sin(rotation)*(tokenheight+wobble),0]) cube([basex, tokenstack+wobble+wallsize*2, cos(rotation)*(tokenheight+wobble)]);
           
        for(i = [0:numstack-1]) {
            //translate([i*(wallsize+tokenwidth+wobble),wallsize,0]) rotate([rotation,0,0]) cube([tokenwidth+wobble, tokenstack+wobble, tokenheight+wobble+2]);
            difference(){
            hull(){
                rotate([90+rotation,0,0]) translate([(tokenwidth+wobble)/2+(i*(tokenwidth+wobble+wallsize)),tokenheight,-tokenstack-wobble-(2.15*wallsize)]) cylinder(d=fingersize-0.8,h=wallsize-0.2);
                rotate([90+rotation,0,0]) translate([(tokenwidth+wobble)/2+(i*(tokenwidth+wobble+wallsize)),tokenheight+wobble*10,-tokenstack-wobble-(2.15*wallsize)]) cylinder(d=fingersize-0.8,h=wallsize-0.2);
            }
           translate([-wallsize,-sin(rotation)*(tokenheight+wobble),cos(rotation)*(tokenheight+wobble)+sin(rotation)*(tokenstack+wobble+wallsize*2)+2]) cube([basex, topy*1.1, tokenheight+wobble]);
        }
        }
        }

    }
}

if(print == "box"){
if(doublerev == "yes") {
    union(){
        translate([0,0,0]) inline();
    rotate([0,0,90]) translate([-sin(rotation)*(tokenheight+wobble)*2+0.1,0,0]) mirror([1,1,0]){ inline(); };
}
    echo(str("Dimensions are : ", basex, " mm * ", basey*2, "mm"));
} else {
    translate([0,0,0]) inline();
    echo(str("Dimensions are : ", basex, " mm * ", basey, "mm"));
}
}

if(print == "lid"){
if(doublerev == "yes") {
    rotate([-90,0,180]) difference(){
    union(){
        translate([0,0,0]) cover();
    rotate([0,0,90]) translate([-sin(rotation)*(tokenheight+wobble)*2+0.1,0,0]) mirror([1,1,0]){ cover(); };
}
translate([basex/2-wallsize,-sin(rotation)*(tokenheight+wobble),cos(rotation)*(tokenheight+wobble)+sin(rotation)*(tokenstack+wobble+wallsize*2)+1.1]) rotate([0,0,180]) linear_extrude(height = 50, center = false, convexity = 10) text(text,size=textsize,font=font,valign="center",halign="center");
translate([0,-sin(rotation)*(tokenheight+wobble),cos(rotation)*(tokenheight+wobble)-wallsize]) cube([basex-wallsize*2, topy-wallsize, sin(rotation)*(tokenstack+wobble+wallsize*2)+1.7]);

rotate([0,0,90]) translate([-sin(rotation)*(tokenheight+wobble)*2+0.1,0,0]) mirror([1,1,0]) translate([0,-sin(rotation)*(tokenheight+wobble),cos(rotation)*(tokenheight+wobble)-wallsize]) cube([basex-wallsize*2, topy-wallsize, sin(rotation)*(tokenstack+wobble+wallsize*2)+1.7]);
}
    //echo(str("Dimensions are : ", basex, " mm * ", basey*2, "mm"));
} else {
    rotate([-90,0,180]) difference(){
    translate([0,0,0]) cover();
        translate([basex/2-wallsize,-sin(rotation)*(tokenheight+wobble)+topy/2,cos(rotation)*(tokenheight+wobble)+sin(rotation)*(tokenstack+wobble+wallsize*2)+1.1]) rotate([0,0,180]) linear_extrude(height = 50, center = false, convexity = 10) text(text,size=textsize,font=font,valign="center",halign="center");
        translate([0,-sin(rotation)*(tokenheight+wobble)+wallsize,cos(rotation)*(tokenheight+wobble)-wallsize]) cube([basex-wallsize*2, topy-wallsize*2, sin(rotation)*(tokenstack+wobble+wallsize*2)+1.7]);
    }
    //echo(str("Dimensions are : ", basex, " mm * ", basey, "mm"));
}
}




