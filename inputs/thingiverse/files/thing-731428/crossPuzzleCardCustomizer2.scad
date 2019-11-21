use <utils/build_plate.scad>

/* [Card Size] */
// Dimensions of your business card (default is NZ size)
cardHeight = 90;
cardWidth = 55;
// Extra dimensions you can adjust
cardThickness = 2; // How thick the card is
cardWall = 2; // The thickness of the outline of the card
gap = 2; // The size of the gaps between the puzzle pieces
/* [Card Text] */

// There are four lines of text. Make it your own!
cardText1 = "Use these";
cardText2 = "pieces";
cardText3 = "to make";
cardText4 = "a cross";

// Include a long line of text at the bottom (the solution image will shrink)
longLine = "no"; //[yes,no]

longLineText = "I_Rock@me.com";
/* [Extras] */
// Invert text. Text comes out as a hole in the card rather than lumps on top. Helpful if your printer can't handle the thin lines in the text
invertText = "no"; //[yes,no]

// The height of the thin supports
layerHeight = 0.4;

// Doubles the width of the supports
wideSupports = "no"; // [yes,no]


/* [Build plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/* [Cheat] */
// If you are really desperate for the solution I'll give it to you
doYouReallyWantToCheat = "no"; //[no, niet, yes, kao, 不对, nage, nei, nein]

/* [Hidden] */
// All done. Customizer doesn't need to see all this
use <write/Write.scad>

// If you need to cheat!
if (doYouReallyWantToCheat == "yes"){
translate([0,0,cardThickness*3])solution();
}

puzzleBlockSize = (cardWidth -5* gap )*2*sqrt(2)/(sqrt(2)+2);
block = puzzleBlockSize/2;
suppH = layerHeight;
suppW = wideSupports == "yes" ? gap : gap/2; //choose the support size


puzzleWidth = sqrt(8)*block;
cardoffset = puzzleWidth/2+gap-cardHeight/2;


blockDiag = sqrt(block*block/2);

translate([0,0,cardThickness/2]){
puzzle();
translate ([cardoffset*2 + - puzzleWidth/2 - gap,-cardWidth/2,-cardThickness/2]) nameplate();
translate([cardoffset,0,0])cardborder();
translate([0,0,+suppH/2-cardThickness/2])supports();
}
module supports(){
    //the four edge corners
    translate([blockDiag*1.8,blockDiag*1.5+gap*2.99,0])cube([suppW, gap, suppH], center = true);
    translate([blockDiag*1.8,-(blockDiag*1.5+gap*2.99),0])cube([suppW, gap, suppH], center = true);
    translate([-blockDiag*1.8,-(blockDiag*1.5+gap*2.99),0])cube([suppW, gap, suppH], center = true);
    translate([-blockDiag*1.8,blockDiag*1.5+gap*2.99,0])cube([suppW, gap, suppH], center = true);
    //The two middle bits
    translate([0,blockDiag*.5,0])cube([gap, suppW, suppH], center = true);
    translate([0,-blockDiag*.5,0])cube([gap, suppW, suppH], center = true);
    //The four bits connecting the big pieces to the little ones in the middle
    translate([block/2,-(block/2+gap/2),0])cube([suppW, gap, suppH], center = true);
    translate([-block/2,-(block/2+gap/2),0])cube([suppW, gap, suppH], center = true);
    translate([-block/2,(block/2+gap/2),0])cube([suppW, gap, suppH], center = true);
    translate([block/2,(block/2+gap/2),0])cube([suppW, gap, suppH], center = true);
    //The two diagonals between the triangles
    translate([block/2,0,0]){
        translate([block*.4,block*.38,0])rotate([0,0,45])translate([0,-gap/2,0])cube([suppW, gap, suppH], center = true);
        translate([-block*.31,-block*.33,0])rotate([0,0,45])translate([0,-gap/2,0])cube([suppW, gap, suppH], center = true);
    }
    translate([-block/2-gap*2,0,0]){
        translate([block*.4,block*.38,0])rotate([0,0,45])translate([0,-gap/2,0])cube([suppW, gap, suppH], center = true);
        translate([-block*.31,-block*.33,0])rotate([0,0,45])translate([0,-gap/2,0])cube([suppW, gap, suppH], center = true);
    }
}
module nameplate(){
    nameplateH = cardHeight - (puzzleWidth+2*gap);
   	if (invertText == "yes") {
        difference(){
            cube([nameplateH,cardWidth,cardThickness]);
            translate([0,0,cardThickness/2])textAndCross(nameplateH);
        }
	} else {
        cube([nameplateH,cardWidth,cardThickness/2]);	
        textAndCross(nameplateH);
    }
}
module textAndCross(nameplateH){
//Work out sizes of text and cross
    textWidth = 0.685; //Text width (mm) per fontsize per char
    cross1 = longLine=="yes" ? nameplateH/5 : nameplateH/4;
    cross2 = (cardWidth-25)/4;
crossSize = cross1 < cross2 ? cross1 : cross2; //choose the smallest size
    //crossSize = nameplateH/4;
    //crossSize = (cardWidth-25)/4;

// Work out text sizes
    textWidth = 0.75; //mm per char per mm height
    font1 = nameplateH/8; //Vertical spacing
    font2 = (cardWidth-crossSize*4)/textWidth/9; // Horizontal spacing, 9 chars;
    fontH = font1 < font2 ? font1 : font2;
    echo (fontH);

// Leave space for the longline if needed
longLineGap = longLine=="yes" ? fontH*1.5 : 0;
translate([longLineGap,0,0]){
// Draw Cross
        translate([crossSize*2,cardWidth-crossSize*2,0]){
        for (i= [0:4])rotate([0,0,i*90])translate([crossSize/2,-crossSize/2,0])cube  ([crossSize,crossSize,cardThickness]);
            translate([-crossSize/2,-crossSize/2,0])cube([crossSize,crossSize,      cardThickness]);}

// Draw text
            translate([crossSize*3,cardWidth-crossSize*4,0])
                rotate([0,0,-90])write(cardText1, t = 2, h = fontH);
            translate([crossSize*3-fontH*1.5,cardWidth-crossSize*4,0])
                rotate([0,0,-90])write(cardText2, t = 2, h = fontH);
            translate([crossSize*3-fontH*3,cardWidth-crossSize*4,0])
                rotate([0,0,-90])write(cardText3, t = 2, h = fontH);
            translate([crossSize*3-fontH*4.5,cardWidth-crossSize*4,0])
                rotate([0,0,-90])write(cardText4, t = 2, h = fontH);
            if (longLine=="yes"){
                    translate([crossSize*3-fontH*6,cardWidth,0])
                rotate([0,0,-90])write(longLineText, t = 2, h = fontH);
            }  
    }
}
module cardborder(){
//translate([cardoffset,0,0])
    difference(){
cube([cardHeight,cardWidth,cardThickness], center = true);
cube([cardHeight-cardWall,cardWidth-cardWall,cardThickness*2], center = true);
}
}

module puzzle(){
translate([-(block+gap)/2,0,0]){
corner();
translate([block+2*gap,0,0])corner();
translate([block+gap,0,0])rotate([0,0,180])corner();
translate([-gap,0,0])rotate([0,0,180])corner();
}
translate([0,(block*sqrt(2)+block)/2+gap,0])
translate([0,-sqrt(block*block/2),0])rotate([0,0,135])middle();
rotate([0,0,180])translate([0,(block*sqrt(2)+block)/2+gap,0])
translate([0,-sqrt(block*block/2),0])rotate([0,0,135])middle();
}

module corner(){
rotate([0,0,45])
difference(){
rotate([0,0,45])cube([block,block,cardThickness],center = true);
translate([-block,0,-cardThickness])cube([2*block,2*block,2*cardThickness]);
}
}
module middle(){
difference(){
translate([.5*block, -.5*block,0])cube([2*block,2*block,cardThickness], center = true);
union(){
rotate([0,0,45])translate([-3*block,0,-cardThickness])cube([6*block,6*block,2*cardThickness]);
translate([5*block,-4.5*block,0])rotate([0,0,45])translate([-3*block,0,-cardThickness])cube([6*block,6*block,2*cardThickness]);
}
}
}

module solution(){
color("red")translate([block,0,0.01])rotate([0,0,90])corner();
color("red")translate([-block,0,0.01])rotate([0,0,-90])corner();
color("red")translate([0,block,0.01])rotate([0,0,90])corner();
color("red")translate([0,-block,0.01])rotate([0,0,-90])corner();

color("green")translate([0,0,0.02])rotate([0,0,90])middle();
color("yellow")rotate([0,0,270])middle();

}