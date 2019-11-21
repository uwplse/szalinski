/* [Global Settings] */

// Output Type
part = "bot";               // [top, bot]
// Number of swatches to box will hold
swatches = 30;              // [10:100]
// Text to print on top cover (Line 1)
text1 = "FILAMENT";
// Text to print on top cover (Line 2)
text2 = "SWATCHES";


/* [Case Dimensions] */

// Width (mm) of case walls
case_w = 3;                 // [2:5]
// Height (mm) of case floor/ceiling
case_h = 2;                 // [2:5]
// Height (mm) of case overlap
case_o = 3;                 // [2:5]
// Length (mm) of snap-in teeth
case_t = 20;                // [10:40]


/* [Slot Dimensions] */

// Length (mm) of slot separators
slot_l = 3;					// [1:10]
// Width (mm) of slot separators
slot_w = 1;					// [1:3]
// Height (mm) of slot separators
slot_h = 20;				// [10:30]


/* [Swatch Dimensions] */

// Length (mm) of each swatch
swatch_x = 80;
// Width (mm) of each swatch
swatch_y = 2.3;
// Height (mm) of each swatch
swatch_z = 30;


/* [Hidden] */

slot_x = swatch_x + 0.4;   	// length of slots
slot_y = swatch_y + 0.2;   	// width of slots
slot_z = swatch_z;          // height of slots

inner_x = slot_x;
inner_y = (swatches * (slot_y + slot_w)) + slot_w;

case_w2 = case_w / 2;
case_x = inner_x + (case_w * 2);
case_y = inner_y + (case_w * 2);
case_z = swatch_z + (case_h * 2);

print_part();

module print_part()
{
    if (slot_h > (swatch_z - case_o))
    {
        echo("Slot height would exceed the height of the case");
    }
    
	if (part == "top")
    {
		CaseTop();
	}
    else if (part == "bot")
    {
		CaseBot();
	}
    else
    {
		CaseTop();
		CaseBot();
    }
}

module CaseTop()
{
    translate([0, 0, slot_h + case_h])
    {
        translate([0, case_y])
        mirror([0, 1, 0])
            TopWallX();
            TopWallX();
        
        translate([case_x, 0])
        mirror([1, 0, 0])
            TopWallY();
            TopWallY();
        
        difference()
        {
            color("orange")
            translate([case_w, case_w, slot_z - slot_h])
                cube([inner_x, inner_y, case_h]);
            
            translate([0, 0, slot_z - slot_h + case_h - 0.5])
            linear_extrude(height = 0.5)
            {
                translate([case_x / 2, (case_y / 2) + 5])
                text(
                    text = text1,
                    size = 7,
                    font = "Impact",
                    halign = "center",
                    valign = "center"
                );
                
                translate([case_x / 2, (case_y / 2) - 5])
                text(
                    text = text2,
                    size = 7,
                    font = "Impact",
                    halign = "center",
                    valign = "center"
                );
            }
        }
    }
}

module CaseBot()
{
    translate([0, case_y])
    mirror([0, 1, 0])
        BotWallX();
        BotWallX();

    translate([case_x, 0])
    mirror([1, 0, 0])
        BotWallY();
        BotWallY();

    translate([case_w, case_w])
    {
        color("red")
            cube([inner_x, inner_y, case_h]);
        
        translate([0, 0])
            Swatches();
        translate([inner_x - slot_l, 0])
            Swatches();
    }
}





/* ------- */
// Top Box //
/* ------- */

module TopWallX()
{
    color("orange")
    translate([0, 0, case_o])
    resize([0, 0, slot_z - slot_h - case_o + case_h])
        WallX();
    
    color("orange")
    {
        difference()
        {
            resize([0, 0, case_o])
                WallX();
            
            translate([case_w, case_w2 - 0.2])
                cube([inner_x, case_w2 + 0.2, case_o]);
        
            translate([case_w2 - 0.2, case_w2 - 0.2])
            resize([case_w2 + 0.4, case_w2 + 0.4, case_o])
                Corner();
        
            translate([inner_x + case_w + case_w2 + 0.2, case_w2 - 0.2])
            mirror([1, 0, 0])
            resize([case_w2 + 0.4, case_w2 + 0.4, case_o])
                Corner();
        }
    }
    
    color("orange")
    translate([(case_x - case_t) / 2, case_w2 - 0.4, case_o / 2])
    rotate([0, 90, 0])
        cylinder(h = case_t, d = 1, $fn = 360);
}

module TopWallY()
{
    color("orange")
    translate([0, 0, case_o])
    resize([0, 0, slot_z - slot_h - case_o + case_h])
        WallY();
    
    color("orange")
    translate([0, case_w])
        cube([case_w2 - 0.2, inner_y, case_o]);
}





/* ---------- */
// Bottom Box //
/* ---------- */

module BotWallX()
{
    color("red")
    resize([0, 0, slot_h + case_h])
        WallX();
    
    color("red")
    translate([case_w2, case_w2, slot_h + case_h])
    {
        resize([case_w2, case_w2, case_o])
            Corner();
        
        translate([inner_x + case_w, 0])
        mirror([1, 0, 0])
        resize([case_w2, case_w2, case_o])
            Corner();
        
        translate([case_w2, 0])
        difference()
        {
            cube([inner_x, case_w2, case_o]);
            translate([((inner_x - case_t) / 2) - 0.2, 0, case_o / 2])
            rotate([0, 90, 0])
                cylinder(h = case_t + 0.4, d = 1, $fn = 360);
        }
    }
}

module BotWallY()
{
    color("red")
    resize([0, 0, slot_h + case_h])
        WallY();
    
    color("red")
    translate([case_w2, case_w, slot_h + case_h])
        cube([case_w2, inner_y, case_o]);
    
}

module Swatches()
{
    for (i = [0 : slot_y + slot_w : inner_y])
    {
        color("green")
        translate([0, i, case_h])
            cube([slot_l, slot_w, slot_h]);
    }
}





/* --------- */
// Universal //
/* --------- */

module WallX()
{
    translate([case_w, 0])
        cube([inner_x, case_w, 1]);
    
    translate([case_x, 0])
    mirror([1, 0, 0])
        Corner();
        Corner();
}

module WallY()
{
    translate([0, case_w])
        cube([case_w, inner_y, 1]);
}
module Corner()
{
    translate([case_w, case_w])
    difference()
    {
        cylinder(h = 1, r = case_w, $fn = 360);
        
        translate([-case_w, 0])
            cube([10, case_w, 1]);
        translate([0, -case_w])
            cube([case_w, case_w, 1]);
    }
}
