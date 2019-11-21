// *************************************************
// Creative Commons Attribution 4.0 International License
// creativecommons.org/licenses/by/4.0/
// Attribution: Sierra Wireless Inc.
// *************************************************

// preview[view:south, tilt:top]

// PUBLIC VARIABLES

/* [Basic] */

// The distance between the top of the board and the bottom outside surface of the enclosure. Stock configurations are 20 for large Hammond enclosure on the fourth rung, 8.5 for the small Hammond enclosure on the bottom rung.
Vertical_Distance = 8.5;

// Distance to offset edges of component holes for adjusting fit.
Component_Fit = 0.25;

// Distance to offset face plate edges for adjusting fit.
Plate_Fit = 0.25;

/* [Advanced] */

// Height of the face plate inside surface. Stock configurations are 53.3 for the large Hammond enclosure, 31 for the small Hammond enclosure.
Face_Plate_Height = 31;

// Width of the face plate inside surface. Minimum is 104 for the small and large Hammond enclosures.
Face_Plate_Width = 104;

VGA_Horizontal_Offset = 0;
VGA_Vertical_Offset = 0;
LED_Horizontal_Offset = 0;
LED_Vertical_Offset = 0;
Button_Horizontal_Offset = 0;
Button_Vertical_Offset = 0;
Audio_Horizontal_Offset = 0;
Audio_Vertical_Offset = 0;
RJ45_Horizontal_Offset = 0;
RJ45_Vertical_Offset = 0;
USB_Horizontal_Offset = 0;
USB_Vertical_Offset = 0;

// Fills in the gap between the face plate and the lid when using a flat instead of a stepped lid (e.g. laser cut acrylic). Set "true" to enable.
Lid_Fill = "true";

// To enable an antenna hole, set offset parameters to 0 for default position, or specify an offset in mm from the default position. Set "false" to disable.
Antenna_1_Horizontal_Offset = "false";
Antenna_1_Vertical_Offset = "false";
Antenna_2_Horizontal_Offset = "false";
Antenna_2_Vertical_Offset = "false";
Antenna_3_Horizontal_Offset = "false";
Antenna_3_Vertical_Offset = "false";

/* [Hidden] */

// Dimensions of the face plate
Wall = 1.5;
PlateZ_inside = 7;
PlateX_inside = Face_Plate_Width < 104
                ? 104 + Plate_Fit
                : Face_Plate_Width + Plate_Fit;

PlateY_inside = Face_Plate_Height < 31
                ? 31 + Plate_Fit
                : Face_Plate_Height + Plate_Fit;

PlateX_outside = (PlateX_inside - Plate_Fit) + Wall*2 ;
PlateY_outside = (PlateY_inside - Plate_Fit) + Wall*2;
PlateZ_outside = 9;

CutHeight = PlateZ_outside + 5;

SMA_dia = 7;
SMA_gap = 7;
SMA_xstart = 18.5;
SMA_ystart = 13;

// Coordinates of the bottom left edge of each component slot measured from outside of enclosure
Pos_VGA = [     6.2 + Wall + VGA_Horizontal_Offset,
                Vertical_Distance + Wall + VGA_Vertical_Offset,
                -1];
Pos_LEDs = [    38.4 + Wall + LED_Horizontal_Offset,
                Vertical_Distance + Wall + Button_Vertical_Offset,
                -1];
Pos_Button = [  42.3 + Wall + Button_Horizontal_Offset,
                Vertical_Distance + Wall + Button_Vertical_Offset,
                -1];
Pos_Audio = [   51 + Wall + Audio_Horizontal_Offset,
                Vertical_Distance + Wall + Audio_Vertical_Offset,
                -1];
                
                
Pos_USBv = [    59.5 + Wall + USB_Horizontal_Offset,
                Vertical_Distance + Wall + USB_Vertical_Offset,
                -1];                
Pos_RJ45 = [    79 + Wall + RJ45_Horizontal_Offset,
                Vertical_Distance + Wall + RJ45_Vertical_Offset,
                -1];
                


Pos_Ant1 = [   SMA_xstart + Wall + Antenna_1_Horizontal_Offset,
                Vertical_Distance + Wall + SMA_ystart + Antenna_1_Vertical_Offset,
                -1];
Pos_Ant2 = [    SMA_xstart + Wall + (SMA_dia*1) + (SMA_gap) + Antenna_2_Horizontal_Offset,
                Vertical_Distance + Wall + SMA_ystart + Antenna_2_Vertical_Offset,
                -1];
Pos_Ant3 = [    SMA_xstart + Wall + (SMA_dia*2) + (SMA_gap*2) + Antenna_3_Horizontal_Offset,
                Vertical_Distance + Wall + SMA_ystart + Antenna_3_Vertical_Offset,
                -1];            
            

// MAIN

difference(){
    MainPlate();
    ScrewHoles();

    translate(0,Vertical_Distance,0){
        Position(Pos_VGA) VGA();
        //Position(Pos_LEDs) LEDs();
        Position(Pos_Button) Button();
        Position(Pos_Audio) Audio();
        Position(Pos_USBv) USB_horizontal();
        Position(Pos_RJ45) RJ45();
    }
    
    if (Antenna_1_Horizontal_Offset != "false"){
        Position(Pos_Ant1) SMA(SMA_dia);}
    if (Antenna_2_Horizontal_Offset != "false"){
        Position(Pos_Ant2) SMA(SMA_dia);}
    if (Antenna_3_Horizontal_Offset != "false"){
        Position(Pos_Ant3) SMA(SMA_dia);}
}


// HELPER MODULES

module Position(pos){
    for (i = [0 : $children-1])
        translate([ pos[0]-(Component_Fit/2),
                    pos[1]-(Component_Fit/2),
                    pos[2]])
        children(i);
       
}

// GEOMETRY

module MainPlate(){
    fillet_in_r = 4;
    fillet_out_r = fillet_in_r + Wall;
    
    
    difference(){
                
        cube([  PlateX_outside,
                PlateY_outside,
                PlateZ_outside]);
        
        translate([Wall - (Plate_Fit/2),Wall - (Plate_Fit/2),-1])
        difference(){   
            cube([  PlateX_inside,
                    PlateY_inside,
                    PlateZ_inside+1]);
            fillets(fillet_in_r,
                    PlateX_inside,
                    PlateY_inside,
                    CutHeight);
            if(Lid_Fill == "true") LidFill();
            }
        
        fillets(fillet_out_r,
                PlateX_outside,
                PlateY_outside,
                CutHeight);       

    }
}

module ScrewHoles(){
    Dia1 = 3;
    Dia2 = 6;
    BevelDepth = 2.2;
    Offset = 5.85;

    for (x = [Offset,PlateX_outside-Offset]){
    for (y = [Offset,PlateY_outside-Offset]){
    translate([x,y,0]){
        cylinder(   d=Dia1,
                    h=PlateZ_outside,
                    center=false,
                    $fn=90);
        translate([0,0,PlateZ_outside-BevelDepth+0.1])
        cylinder(   d1=Dia1,
                    d2=Dia2,
                    h=BevelDepth,
                    center=false,
                    $fn=90);
        }
    }}    
}

module VGA(){
    Offset = [0,-1,0];
    translate(Offset){
        cube([  31 + Component_Fit,
                12.6 + Component_Fit,
                CutHeight]);
        }
}

module LEDs(){
    Offset = [0,-2,0];
    translate(Offset){
        cube([  6 + Component_Fit,
                3.75 + Component_Fit,
                CutHeight]);
    }    
}

module Button(){
    Offset = [0,2.5,0];
    translate(Offset){
        translate([2.5,2.5,0])
        cylinder(   d=5 + Component_Fit,
                    h=CutHeight,
                    center=false,
                    $fn=90);
    } 
}

module Audio(){
    Offset = [0,-0.4,0];
    translate(Offset){
        cube([  7 + Component_Fit,
                7 + Component_Fit,
                CutHeight]);
    }
}

module RJ45(){
    Offset = [0,0,0];
    translate(Offset){
        cube([  17 + Component_Fit,
                15 + Component_Fit,
                CutHeight]);
    }
}

module USB_horizontal(){
    Offset = [0,0.5,0];
    translate(Offset){
        cube([  16.2 + Component_Fit,
                8.8 + Component_Fit,
                CutHeight]);
    }
}

module USB_vertical(){
    Offset = [0,-0.5,0];
    translate(Offset){
        cube([  8.8 + Component_Fit,
                16.2 + Component_Fit,
                CutHeight]);
    }
}

module SMA(dia){
    translate([dia/2,dia/2,0]){
        cylinder(   d=dia + Component_Fit,
                    h=CutHeight,
                    center=false,
                    $fn=90);
    }
}

module LidFill(){
    RailWidth = 7.9;
    Width = PlateX_inside - (RailWidth*2) - Component_Fit;
    Height = 2.9 + Wall - Component_Fit;
    Offset = [  PlateX_outside/2 - Width/2 - Wall,
                PlateY_inside - Height + Wall,
                0];
    translate(Offset){
        cube([Width,Height,PlateZ_outside]);
    }
}

module fillet(r, h) {
	translate([r / 2, r / 2, h/2-0.1])
	difference() {
		cube([r + 0.01, r + 0.01, h], center = true);
		translate([r/2, r/2, 0])
		cylinder(r = r, h = h + 1, center = true,$fn=90);
	}
}

module fillets(r,x,y,z){
    fillet(r,z);
    
    translate([0,y,0])
    rotate([0,0,270])
    fillet(r,z);

    translate([x,0,0])
    rotate([0,0,90])
    fillet(r,z);
    
    translate([x,y,0])
    rotate([0,0,180])
    fillet(r,z);
}