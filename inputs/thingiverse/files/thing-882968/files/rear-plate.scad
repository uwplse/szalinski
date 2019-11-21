// ADD LICENSE INFO HERE


// preview[view:south, tilt:top]

// PUBLIC VARIABLES

/* [Basic] */

// Select a component for slot 1
Slot_1 = "USB Single"; // [MicroD,SMA,RJ45,USB Single,USB Double,None]

// Select a component for slot 2
Slot_2 = "USB Single"; // [MicroD,SMA,RJ45,USB Single,USB Double,None]

// Select a component for slot 3
Slot_3 = "USB Single"; // [MicroD,SMA,RJ45,USB Single,USB Double,None]

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

Power_Horizontal_Offset = 0;
Power_Vertical_Offset = 0;
Slot_1_Horizontal_Offset = 0;
Slot_1_Vertical_Offset = 0;
Slot_2_Horizontal_Offset = 0;
Slot_2_Vertical_Offset = 0;
Slot_3_Horizontal_Offset = 0;
Slot_3_Vertical_Offset = 0;
USB_Horizontal_Offset = 0;
USB_Vertical_Offset = 0;
LED1_Horizontal_Offset = 0;
LED1_Vertical_Offset = 0;
LED2_Horizontal_Offset = 0;
LED2_Vertical_Offset = 0;
LED3_Horizontal_Offset = 0;
LED3_Vertical_Offset = 0;

// Fills in the gap between the face plate and the lid when using a flat instead of a stepped lid (e.g. laser cut acrylic). Set "true" to enable.
Lid_Fill = "true";

/* [Hidden] */

// Dimensions of the face plate
Wall = 1.5;

PlateX_inside = Face_Plate_Width < 104
                ? 104 + Plate_Fit
                : Face_Plate_Width + Plate_Fit;

PlateY_inside = Face_Plate_Height < 31
                ? 31 + Plate_Fit
                : Face_Plate_Height + Plate_Fit;
PlateZ_inside = 7;

PlateX_outside = (PlateX_inside - Plate_Fit) + Wall*2 ;
PlateY_outside = (PlateY_inside - Plate_Fit) + Wall*2;
PlateZ_outside = 9;

CutHeight = PlateZ_outside + 5;

IoTHeight = 5;

// Coordinates of the bottom left edge of each component measured from outside surface of enclosure. In the case of the 3 dynamic components, this is measured to the left edge of the IoT chip and then the mounted component is positioned inside each component module below.

Pos_Power = [5.1 + Wall + Power_Horizontal_Offset,
            Vertical_Distance + Wall + Power_Vertical_Offset,
            -1];
Pos1 = [    18.8 + Wall + Slot_1_Horizontal_Offset,
            Vertical_Distance + Wall + IoTHeight + Slot_1_Vertical_Offset,
            -1];
Pos2 = [    43.5 + Wall + Slot_2_Horizontal_Offset,
            Vertical_Distance + Wall + IoTHeight + Slot_2_Vertical_Offset,
            -1];
Pos3 = [    68.4 + Wall + Slot_3_Horizontal_Offset,
            Vertical_Distance + Wall + IoTHeight + Slot_3_Vertical_Offset,
            -1];
Pos_USB = [ 19.9 + Wall + USB_Horizontal_Offset,
            Vertical_Distance + Wall + USB_Vertical_Offset,
            -1];
Pos_LED1 = [36.25 + Wall + LED1_Horizontal_Offset,
            Vertical_Distance + Wall + LED1_Vertical_Offset,
            -1];
Pos_LED2 = [62.5 + Wall + LED2_Horizontal_Offset,
            Vertical_Distance + Wall + LED2_Vertical_Offset,
            -1];
Pos_LED3 = [87 + Wall + LED3_Horizontal_Offset,
            Vertical_Distance + Wall + LED3_Vertical_Offset,
            -1];


difference(){
    MainPlate();
    ScrewHoles();
    
    Position(Pos_Power) Power();

    translate(0,Vertical_Distance,0){
        if(Slot_1 != "None")Position(Pos1) GetComponent(Slot_1);
        if(Slot_2 != "None")Position(Pos2) GetComponent(Slot_2);
        if(Slot_3 != "None")Position(Pos3) GetComponent(Slot_3);
    }
    
    Position(Pos_USB) StaticUSB(); 
    Position(Pos_LED1) LEDs();
    Position(Pos_LED2) LEDs();
    Position(Pos_LED3) LEDs();
}

// HELPER MODULES

module GetComponent(comp){
    if (comp == "MicroD") MicroD();
    if (comp == "RJ45") RJ45();
	if (comp == "SMA") SMA();
	if (comp == "USB Single") USBSingle();
    if (comp == "USB Double") USBDouble();    
}

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

module Power(){
    Offset = [0,0,0];
    translate(Offset){
        cube([  10.5 + Component_Fit,
                12.5 + Component_Fit,
                CutHeight]);
        
    }
}

module RJ45(){
    Offset = [2.5,0,0];
	translate(Offset){
		cube([  17 + Component_Fit,
                15 + Component_Fit,
                CutHeight]);
	}
}

module MicroD(){
	Offset = [2,0,0];
	translate(Offset){
		cube([  19. + Component_Fit,
                7.8 + Component_Fit,
                CutHeight]);
	}
}

module SMA(){
	Offset = [6,0,0];
	diam = 6.5 + Component_Fit;
	translate(Offset){
		//translate([diam/2,diam/2,0]){
		//	cylinder(d=diam,h=CutHeight,center=false);
		cube([  9.5 + Component_Fit,
                8 + Component_Fit,
                CutHeight]);
        }
}

module USBSingle(){
	Offset = [3.75,-0.5,0];
	translate(Offset){
		cube([  16.2 + Component_Fit,
                8.8 + Component_Fit,
                CutHeight]);
	}
}

module USBDouble(){
	Offset = [2.75,0,0];
	translate(Offset){
		cube([  16.2 + Component_Fit,
                14 + Component_Fit,
                CutHeight]);
	}
}

module StaticUSB(){
    Offset = [0,-6,0];
    translate(Offset){
        cube([  15 + Component_Fit,
                8 + Component_Fit,
                CutHeight]);
    }
}

module LEDs(){
    Offset = [0,-1.5,0];
    translate(Offset){
        cylinder(   r = 1.5 + (Component_Fit/2),
                    h = CutHeight*2,
                    center = true,
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
