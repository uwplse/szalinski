// preview[view:south, tilt:top]

/* [Filament Information] */
// Color/Name of the Filament for Line 1
Filament_Color_Line_1 = "MIDNIGHT";
// Color/Name of the Filament for Line 2
Filament_Color_Line_2 = "BLACK";
// Name of the Filament Manufacturer
Manufacturer = "NINJAFLEX";
// Type of Filament
Filament_Type = "FLEX"; // [PLA,PLA+,PETG,ABS,NYLON,FLEX,TPU]
//Diameter of Filament
Filament_Size = "1.75"; // [1.75,3.0]
// Text Spacing between each field
Text_Spacing = 5; // Freeform Text Box

/* [Plaque Dimensions] */
// Width of the Plaque
Plaque_Width = 46; // [46:80]
// Height of the Plaque
Plaque_Height = 26; // [26:40]
// Thickness of the Plaque
Plaque_Thickness = 2; // [1:10]
// Color Text Size
Color_Text_Size = 4.5; // [3,3.5,4,4.5,5,5.5,6]
// Mfg Text Size
Mfg_Text_Size = 4; // [3,3.5,4,4.5,5,5.5,6]
// Filament Type Text Size
Type_Text_Size = 4; // [3,3.5,4,4.5,5,5.5,6]
// Filament Size Text Size
Size_Text_Size = 4; // [3,3.5,4,4.5,5,5.5,6]
// Depth of Text going into Plaque
Text_Depth = 0.4; // [0.4,0.6,0.8,1]

/* [Misc Settings] */
// Add Hole to Plaque?
Add_Hole = "no"; // [yes,no]
// Hole Diameter
Hole_Diameter = 4; // [3:8]
// Distance Text is from Edge, this also effects fillet radius. Keep in mind this will not make text wrap or keep it from going off the edge.
Border = 3; // [0:5]
// If you want multi-color files, you can choose to download the STL for the text
Second_Color = "no"; // [yes,no]

/* [Hidden] */
/***************************************/
/* Removed as an option to show Titles */
/* Show Titles for MFG, TYPE and SIZE? */
Show_Titles = "no"; // [yes:no]        */
/***************************************/
BorderOther = 14 + (Mfg_Text_Size * 1.1);
row1 = Plaque_Height / 3 - Border;
row2 = row1 - Text_Spacing;
row3 = row2 - Text_Spacing ;
row4 = row3 - Text_Spacing;
_Label_Text_Depth = Plaque_Thickness / 2 - Text_Depth;
textFont = "Helvetica:style=Bold";
textSpacing = 1.1;
mfgText = "MFG:";
typeText = "TYPE:";
sizeText = "SIZE:";
filletRight = Plaque_Width / 2 - Border;
filletLeft = -(Plaque_Width / 2) + Border;
filletUpper = (Plaque_Height / 2) - Border;
filletLower = -(Plaque_Height / 2) + Border;
filletHeight = -(Plaque_Thickness) + Plaque_Thickness / 2;

// Basic Text Creation
module _textColor1(label) {
    translate ([0, 0, _Label_Text_Depth])
    linear_extrude (height = Text_Depth)
    text(label, size = Color_Text_Size, spacing = textSpacing,valign = "baseline", halign = "center", font = textFont);
}

module _textColor2(label) {
    translate ([0, 0, _Label_Text_Depth])
    linear_extrude (height = Text_Depth)
    text(label, size = Color_Text_Size, spacing = textSpacing,valign = "baseline", halign = "center", font = textFont);
}

module _mfgText(label) {
    union(){
        if (Show_Titles == "yes") {
            translate ([-(Plaque_Width) / 2 + Border, 0,_Label_Text_Depth])
            linear_extrude (height = Text_Depth)
            text(label, size = Mfg_Text_Size, spacing = textSpacing, valign = "baseline", halign = "left", font = textFont);
            translate ([-(Plaque_Width) / 2 + BorderOther, 0,_Label_Text_Depth])
            linear_extrude (height = Text_Depth)
            text(Manufacturer, size = Mfg_Text_Size, spacing = textSpacing, valign = "baseline", halign = "left", font = textFont);
        }
        else if (Show_Titles == "no") {
            translate ([0, 0,_Label_Text_Depth])
            linear_extrude (height = Text_Depth)
            text(Manufacturer, size = Mfg_Text_Size, spacing = textSpacing, valign = "baseline", halign = "center", font = textFont);
        }

    }
}

module _typeText(label) {
    union(){
        if (Show_Titles == "yes") {
            translate ([-(Plaque_Width) / 2 + Border, 0,_Label_Text_Depth])
            linear_extrude (height = Text_Depth)
            text(label, size = Type_Text_Size, spacing = textSpacing, valign = "baseline", halign = "left", font = textFont);
            translate ([-(Plaque_Width) / 2 + BorderOther, 0,_Label_Text_Depth])
            linear_extrude (height = Text_Depth)
            text(Filament_Type, size = Type_Text_Size, spacing = textSpacing, valign = "baseline", halign = "left", font = textFont);
        }
        else if (Show_Titles == "no") {
            translate ([-(len(Filament_Type)), 0,_Label_Text_Depth])
            linear_extrude (height = Text_Depth)
            text(Filament_Type, size = Type_Text_Size, spacing = textSpacing, valign = "baseline", halign = "right", font = textFont);
        }
    }
}

module _sizeText(label) {
    union(){
        if (Show_Titles == "yes") {
            translate ([-(Plaque_Width) / 2 + Border, 0,_Label_Text_Depth])
            linear_extrude (height = Text_Depth)
            text(label, size = Size_Text_Size, spacing = textSpacing, valign = "baseline", halign = "left", font = textFont);
            translate ([-(Plaque_Width) / 2 + BorderOther, 0,_Label_Text_Depth])
            linear_extrude (height = Text_Depth)
            text(Filament_Size, size = Size_Text_Size, spacing = textSpacing, valign = "baseline", halign = "left", font = textFont);
        }
        else if (Show_Titles == "no") {
            translate ([len(Filament_Size), 0,_Label_Text_Depth])
            linear_extrude (height = Text_Depth)
            text(Filament_Size, size = Size_Text_Size, spacing = textSpacing, valign = "baseline", halign = "left", font = textFont);
        }
    }
}

module _textCreation() {
        union(){
            translate ([0, row1, 0]) _textColor1(Filament_Color_Line_1);
            translate ([0, row2, 0]) _textColor2(Filament_Color_Line_2);
            translate ([0, row3, 0]) _mfgText(mfgText);
            translate ([0, row4, 0]) _typeText(typeText);
            translate ([0, row4, 0]) _sizeText(sizeText);
    }
}

module _addHole() {
    translate ([(Plaque_Width / 2) - (Hole_Diameter + Border),-((Plaque_Height / 2) - (Hole_Diameter + Border)), -(Plaque_Thickness / 2)]) cylinder (r=Hole_Diameter, Plaque_Thickness, $fn=360);
}

// Plaque Creation
module _plaque() {
    intersection(){
        translate([0,0,0]) cube ([Plaque_Width, Plaque_Height, Plaque_Thickness], true);
        union(){
            translate([filletRight, filletUpper, filletHeight]) cylinder(h=Plaque_Thickness, r=Border, $fn=360);
            translate([filletRight, filletLower, filletHeight]) cylinder(h=Plaque_Thickness, r=Border, $fn=360);
            translate([filletLeft, filletUpper, filletHeight]) cylinder(h=Plaque_Thickness, r=Border, $fn=360);
            translate([filletLeft, filletLower, filletHeight]) cylinder(h=Plaque_Thickness, r=Border, $fn=360);
            translate([0,0,0]) cube ([Plaque_Width - (Border * 2), Plaque_Height, Plaque_Thickness], true);
            translate([0,0,0]) cube ([Plaque_Width, Plaque_Height - (Border * 2), Plaque_Thickness], true);
        }
    }
}

if (Second_Color == "yes") {_textCreation();}
    else if (Second_Color == "no") {
        difference(){
            _plaque();
            _textCreation();
            if (Add_Hole == "yes") _addHole();
        }
    }