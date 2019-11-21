// Rails for Optimus Control Box 3D printer assembly (delta configuration)

/**********************/
/*    Parameters      */
/**********************/

Test_Mode = false;  // use Test_Mode true to print a short rail for testing

Length = Test_Mode ? 20 : 138.5; // this length should fit the optimus control box
Width = 20; // the outer width of the rail
Width_Inner = 16; // the inner width of the rail
Height_Base = 5;
Height_Rail_Base = 3;
Height_Rail_Upper = 2.5;
Distance = 30; // distance between parts

Hole_Tolerance = 0.3; // 0.3 should work fine for the holes to fit the screws
Slide_Tolerance = 0.5; // try slide tolerance values between 0.1 and 0.8, depending on your printer settings and material used
Bevel_Distance = 2; // a larger value means a lower angle

/**********************/
/*     Variables      */
/**********************/

Rail_Length = Length;
Rail_Base_Width = Width_Inner;
Rail_Base_Height = Height_Rail_Base;
Rail_Base_Bevel_Distance = Bevel_Distance;
Rail_Upper_Width = 8;
Rail_Upper_Height = Height_Rail_Upper;
Rail_Height = Rail_Base_Height + Rail_Upper_Height;

Slide_Move = 0;
Slide_Length = Length;
Slide_Width = Width;
Slide_Base_Height = Height_Base;
Slide_Space_Height = Rail_Base_Height + Slide_Tolerance;
Slide_Space_Wall_Width = (Width - Rail_Base_Width - Slide_Tolerance) / 2;
Slide_Space_Width = Slide_Width - 2 * Slide_Space_Wall_Width;
Slide_Overhang_Height = 1;
Slide_Overhang_Bevel_Distance = Bevel_Distance; //distance between base and bottom corner of the bevel
Slide_Overhang_Width = (Slide_Width - Rail_Upper_Width)/ 2 - Slide_Tolerance;
Slide_Height = Slide_Base_Height + Slide_Space_Height + Slide_Overhang_Height;
Slide_Stop_Thickness = 2;

Hole_Diameter = 4 + Hole_Tolerance;
Hole_Distance = 100;
Hole_Start_Distance = 15;
Hole_Buffer = 5;
Hole_Lowering_Diameter = 7 + Hole_Tolerance;
Hole_Lowering_Height = 4 + Hole_Tolerance;

/**********************/
/*    Code Start      */
/**********************/

Slide();
Rail();

/**********************/
/*       SLIDE        */
/**********************/

module Slide() {
    color("red") {
        translate([Slide_Move, 0, 0])
            union() {
                translate([0, 0, Slide_Base_Height / 2])
                    rotate([90,0,0])
                        SlideBase();
                translate([0, 0, Slide_Base_Height + Slide_Space_Height / 2])
                    rotate([90,0,0])
                        SlideSpacePart();
                translate([0, 0, Slide_Base_Height + Slide_Space_Height + Slide_Overhang_Height / 2])
                    rotate([90,0,0])
                        SlideOverhangPart();
                translate([0, -Slide_Length, Slide_Height / 2])
                    rotate([90,0,0])
                        SlideStop();
            }
    }
}

module SlideBase() {
    difference() {
        SlideBaseBlock();
        SlideBaseHoles();
    }
}

module SlideBaseBlock() {
    linear_extrude(height = Slide_Length)
        square([Slide_Width, Slide_Base_Height], center = true);
}

module SlideBaseHoles() {
    union() {
        translate([0, Slide_Base_Height / 2, 0]) {
            translate([0, 0, Hole_Start_Distance])
                Hole(Slide_Base_Height);
            translate([0, -Hole_Lowering_Height / 2, Hole_Start_Distance])
                #HoleLowering();
            translate([0, 0, Hole_Start_Distance + Hole_Distance])
                Hole(Slide_Base_Height);
            translate([0, -Hole_Lowering_Height / 2, Hole_Start_Distance + Hole_Distance])
                HoleLowering();
        }
    }
}

module SlideSpacePart() {
    union() {
        translate([-(Slide_Width - Slide_Space_Wall_Width) / 2, 0, 0])
            SlideSpaceWall();
        translate([(Slide_Width - Slide_Space_Wall_Width) / 2, 0, 0])
            SlideSpaceWall();
    }
}

module SlideSpaceWall() {
    linear_extrude(height = Slide_Length)
        square([Slide_Space_Wall_Width, Slide_Space_Height], center = true);
}

module SlideOverhangPart() {
    union() {
        translate([-(Slide_Width - Slide_Overhang_Width) / 2, 0, 0])
            SlideOverhang();
        translate([-Slide_Width / 2 +  Slide_Space_Wall_Width, 0, 0])
            SlideOverhangBevel();
        translate([Slide_Width / 2 -  Slide_Space_Wall_Width, 0, 0])
            mirror([1,0,0])
                SlideOverhangBevel();
        translate([(Slide_Width - Slide_Overhang_Width) / 2, 0, 0])
            SlideOverhang();
    }
}

module SlideOverhang() {
    linear_extrude(height = Slide_Length)
        square([Slide_Overhang_Width, Slide_Overhang_Height], center = true);
}

module SlideOverhangBevel() {
    linear_extrude(height = Slide_Length)
        polygon(points = [
            [0, -Slide_Overhang_Height / 2], // upper left
            [Slide_Overhang_Width - Slide_Space_Wall_Width, -Slide_Overhang_Height / 2], // upper right
            [0, -Slide_Overhang_Height / 2 - Slide_Space_Height + Slide_Overhang_Bevel_Distance] // lower left
        ], paths = [ 
            [0, 1, 2]
        ]);
}

module SlideStop() {
    linear_extrude(height = Slide_Stop_Thickness)
        square([Slide_Width, Slide_Height], center = true);
}


/**********************/
/*        RAIL        */
/**********************/

module Rail() {
    translate([Distance, 0, 0])
        rotate([90,0,0])
            difference() {
                RailBody();
                RailHoles();
            }
}

module RailBody() {
    union() {
        translate([0, Rail_Base_Height / 2, 0])
            RailBase();
        translate([0, Rail_Base_Height / 2 + Rail_Upper_Height, 0])
            RailUpperPart();
    }
}

module RailBase() {
    difference() {
        translate([0, 0, 0])
            RailBaseBlock();
        translate([-Rail_Base_Width / 2, Rail_Base_Height / 2, 0])
            RailBaseBevel();
        translate([Rail_Base_Width / 2, Rail_Base_Height / 2, 0])
            mirror([1,0,0])
                RailBaseBevel();
    }
}

module RailBaseBlock() {
    linear_extrude(height = Rail_Length)
        square([Rail_Base_Width, Rail_Base_Height], center = true);
}

module RailBaseBevel() {
    linear_extrude(height = Slide_Length)
        polygon(points = [
            [0, 0], // upper left
            [Slide_Overhang_Width - Slide_Space_Wall_Width, 0], // upper right
            [0, -Slide_Space_Height + Slide_Overhang_Bevel_Distance] // lower left
        ], paths = [ 
            [0, 1, 2]
        ]);
}

module RailUpperPart() {
    translate([0, 0, 0])
        linear_extrude(height = Rail_Length)
            square([Rail_Upper_Width, Rail_Upper_Height], center = true);
}

module RailHoles() {
    union() {
        translate([0, 0, 0]) {
            translate([0, 0, Hole_Start_Distance])
                Hole(Slide_Base_Height);
            translate([0, Hole_Lowering_Height / 2, Hole_Start_Distance])
                #HoleLowering();
            translate([0, 0, Hole_Start_Distance + Hole_Distance])
                Hole(Slide_Base_Height);
            translate([0, Hole_Lowering_Height / 2, Hole_Start_Distance + Hole_Distance])
                HoleLowering();
        }
    }
}

/**********************/
/*       Holes        */
/**********************/

module Hole(height) {
    rotate([90, 0, 0]) {
        cylinder(h=height+Hole_Buffer*2, d=Hole_Diameter, center=true, $fn=24);
    }
}

module HoleLowering() {
    rotate([90, 0, 0]) {
        cylinder(h=Hole_Lowering_Height, d=Hole_Lowering_Diameter, center=true, $fn=24);
    }
}