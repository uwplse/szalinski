/*[Box generator]*/

// Outer X Length (Internal=XLEN-2*Thickness):
XLEN = 80;
// Outer Y Length (Internal=YLEN-2*Thickness):
YLEN = 40;
// Outer Height (Internal=H-2*Thickness):
H = 12;
// Wall thickness (Typ. 2):
TH = 2;
// X Compartments
XCOMPS=3;
// Y Compartments
YCOMPS=2;
// Notches
NOTCH=1; // [0:No, 1:Yes]
// Tolerance (Typ. 0.1)
TOLERANCE=0.1;
// Custom text in the lid (or blank):
TEXT="MyBOX";
// Text size:
TEXTSIZE=10;
// Engrave
ENGRAVE=0; // [0:No, 1:Yes]
// Multi-BOX
BOXES=3;
// Only render 1 Lid
RENDERLID=1; // [0:No, 1:Yes]
// Only render the box
RENDERBOX=1; // [0:No, 1:Yes]
// Stackable
STACKABLE=0; // [0:No, 1:Yes]

/* [Hidden] */
// Box
module Box()
{
    union()
    {
        difference()
        {
        translate([0,0,H/2]) cube([XLEN,YLEN,H],center=true);
        translate([0,0,TH])
            linear_extrude(height = H, scale=1)
                    square([XLEN-TH*2,YLEN-TH*2],center=true);
        translate([-TH*2,0,H-TH])
            linear_extrude(height = H, scale=1)
                    square([XLEN-TH*2,YLEN-2*TH],center=true);
        translate([0,YLEN/2-TH*1.6,H-TH])
            difference()
            {
            translate([])    
            rotate([-60,0,0])    
            translate([-TH,0,0]) 
            cube([XLEN,2*TH,2*TH],center=true);    
            translate([0,0,-TH]) cube([XLEN+TH*3,YLEN,2*TH],center=true);
            }
        translate([0,-(YLEN/2-TH*1.6),H-TH])
            difference()
            {
            translate([])    
            rotate([60,0,0])    
            translate([-TH,0,0]) 
            cube([XLEN,2*TH,2*TH],center=true);    
            translate([0,0,-TH]) cube([XLEN+TH*3,YLEN,2*TH],center=true);
            }
        }
        
        if(XCOMPS>1)
        {
            translate([-XLEN/2,-YLEN/2,0])                
            for(i=[1:XCOMPS-1])
                {
                translate([i*(XLEN-TH)/XCOMPS,0,0])
                    cube([TH,YLEN,H-TH],center=false);
                }
        }
        if (YCOMPS>1)
        {
            translate([-XLEN/2,-YLEN/2,0])
            for(j=[1:YCOMPS-1])
                {
                translate([0,j*(YLEN-TH)/YCOMPS,0])
                    cube([XLEN,TH,H-TH],center=false);
                }
        }
    }
}

// Lid
module Lid()
{
    translate([0,YLEN,-(H-TH)])
    union()
    {
        difference()
        {
            union()
            {
            translate([-TH/2,0,H-(TH/2)])
                cube([XLEN-TH,
                        YLEN-(TH+TOLERANCE)*2,TH],center=true);
            translate([0,YLEN/2-TH*1.6-TOLERANCE,H-TH])
                difference()
                {
                translate([])    
                rotate([-60,0,0])    
                translate([-TH/2,0,0]) 
                cube([XLEN-TH,2*TH,2*TH],center=true);    
                translate([0,0,-TH]) cube([XLEN+TH*3,YLEN,2*TH],center=true);
                }
            translate([0,-(YLEN/2-TH*1.6)+TOLERANCE,H-TH])
                difference()
                {
                translate([])    
                rotate([60,0,0])    
                translate([-TH/2,0,0]) 
                cube([XLEN-TH,2*TH,2*TH],center=true);    
                translate([0,0,-TH]) cube([XLEN+TH*3,YLEN,2*TH],center=true);
                }    
            }
            translate([0,0,H+TH]) cube([XLEN*2,YLEN*2,TH*2],center=true);
            if(NOTCH && !STACKABLE)
            {
                translate([XLEN/2-TH*3,YLEN/4,H+TH/2])
                rotate([90,0,0]) 
                    cylinder(r=TH,h=YLEN/2,center=false,$fn=20);
            }
            if(ENGRAVE && !STACKABLE)
            {
            translate([-XLEN/2+2*TH,-TEXTSIZE/2,H-TH/2])
            linear_extrude(height = TH, convexity = 10)
                text(TEXT, font = "Arial:style=Black",size=TEXTSIZE);
            }
        }
        if(ENGRAVE==0 && !STACKABLE)
        {
        translate([-XLEN/2+TEXTSIZE/2,-TEXTSIZE/2,H-TH/2])
        linear_extrude(height = TH, convexity = 10)
            text(TEXT, font = "Arial:style=Black",size=TEXTSIZE);
        }
        // WOW!! You can include here your own stl to put up it ontop the lids!!!
        //scale(v = [1, 1, 1])
        //translate([0,12,10]) import ("MiniBox.stl", convexity = 2);
    }
}
    
module RenderBoxes()
{
    difference()
    {
        union()
        {
            for(k=[1:BOXES])
            {
                translate([0,-(YLEN*(k-1)),0]) Box();
            }
        }
        // Round corners
        union()
        {
        difference()
            {
            translate([XLEN/2-TH/2,YLEN/2-TH/2,0])
                cube([TH,TH,H],center=false);
            translate([XLEN/2-TH/2,YLEN/2-TH/2,0])
                cylinder(h=H,r=TH/2,center=false,$fn=20);
            }
        difference()
            {
            translate([-XLEN/2-TH/2,YLEN/2-TH/2,0])
                cube([TH,TH,H],center=false);
            translate([-XLEN/2+TH/2,YLEN/2-TH/2,0])
                cylinder(h=H,r=TH/2,center=false,$fn=20);
            }
        #difference()
            {
            translate([XLEN/2-TH/2,-YLEN/2-TH/2-(YLEN*(BOXES-1)),0])
                cube([TH,TH,H],center=false);
            translate([XLEN/2-TH/2,-YLEN/2+TH/2-(YLEN*(BOXES-1)),0])
                cylinder(h=H,r=TH/2,center=false,$fn=20);
            }
        #difference()
            {
            translate([-XLEN/2-TH/2,-YLEN/2-TH/2-(YLEN*(BOXES-1)),0])
                cube([TH,TH,H],center=false);
            translate([-XLEN/2+TH/2,-YLEN/2+TH/2-(YLEN*(BOXES-1)),0])
                cylinder(h=H,r=TH/2,center=false,$fn=20);
            }
        }
    }
}

// Box
if(RENDERBOX)
{
    if(STACKABLE)
        {
            union()
            {
            RenderBoxes();
            for(k=[1:BOXES])
                {
                translate([0,-YLEN*k,-TH]) Lid();
                }
            }
        }
        else
        {
        RenderBoxes();
        }
}
//Lids
if(RENDERLID)
{
for(k=[1:BOXES])
    {
    translate([-XLEN,-YLEN*k,0]) Lid();
    }
}