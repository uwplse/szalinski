//Title: Cabochon Stencil Templates
//Author: Alex English - ProtoParadigm
//Date: 8/16/16
//License: Creative Commons - Share Alike - Attribution

//Notes: These are common, standardized sizes/shapes for cabochons. It has been set up to make use of Customizer on Thingiverse.

//Enable or disable the text at the top of the stencil
text_on = 0; //[0:Disable,1:Enable]

//The text to print on the stencil, if enabled
text = "Your Text Here";

//Round or Oval
type = "round"; //[round:Round,oval:Oval]

module ellipse(a,b)
{
    scale([1,min(a,b)/max(a,b)]) circle(d=max(a,b), $fa=3, $fs=0.25);
}

module ovals()
{
    linear_extrude(height=1.5)
    {
        difference()
        {
            y = text_on ? 83 : 65;
            square([114,y]);
            translate([15, 48]) ellipse(10,14);
            translate([44, 48]) ellipse(12,16);
            translate([72, 48]) ellipse(8,22);
            translate([100, 48]) ellipse(13,18);
            translate([23, 18]) ellipse(30,40); 
            translate([91, 18]) ellipse(18,25); 
            translate([61, 18]) ellipse(22,30); 
        }
    }
    color("blue")
    {
        if(text_on) { translate([57, 70, 0]) linear_extrude(height=2.5) text(text, halign="center"); }

        translate([15, 56, 1.5]) linear_extrude(height=0.5) text("10/14", size=7, halign="center");
        translate([44, 56, 1.5]) linear_extrude(height=0.5) text("12/16", size=7, halign="center");
        translate([72, 56, 1.5]) linear_extrude(height=0.5) text("8/22", size=7, halign="center");
        translate([100, 56, 1.5]) linear_extrude(height=0.5) text("13/18", size=7, halign="center");
        translate([23, 34, 1.5]) linear_extrude(height=0.5) text("30/40", size=7, halign="center");
        translate([91, 34, 1.5]) linear_extrude(height=0.5) text("18/25", size=7, halign="center");
        translate([61, 34, 1.5]) linear_extrude(height=0.5) text("22/30", size=7, halign="center");
    }
}

module circles()
{
    $fa=3;
    $fs=0.25;
    
    linear_extrude(height=1.5)
    {
        difference()
        {
            y = text_on ? 85 : 70;
            square([120, y]);
            //translate([112, 39]) circle(d=8);
            //translate([113, 28]) circle(d=9);
            translate([18, 54]) circle(d=10);
            translate([32, 54]) circle(d=11);
            translate([48, 45]) circle(d=12);
            translate([66, 48]) circle(d=14);
            translate([86, 38]) circle(d=15);
            translate([107.5, 38]) circle(d=16);
            translate([107.5, 18]) circle(d=18);
            translate([86, 19]) circle(d=20);
            translate([58.5, 24]) circle(d=30);
            translate([22, 28]) circle(d=38);
        }
    }
    color("blue")
    {
        if(text_on) { translate([60, 72, 0]) linear_extrude(height=2.5) text(text, halign="center"); }
        translate([22, 8, 1.5]) rotate([0, 0, 180]) linear_extrude(height=0.5) text("38", size=7, halign="center");
        translate([58.5, 8, 1.5]) rotate([0, 0, 180]) linear_extrude(height=0.5) text("30", size=7, halign="center");
        translate([86, 8, 1.5]) rotate([0, 0, 180]) linear_extrude(height=0.5) text("20", size=7, halign="center");
        translate([107.5, 8, 1.5]) rotate([0, 0, 180]) linear_extrude(height=0.5) text("18", size=7, halign="center");
        translate([107.5, 47, 1.5]) linear_extrude(height=0.5) text("16", size=7, halign="center");
        translate([86, 47, 1.5]) linear_extrude(height=0.5) text("15", size=7, halign="center");
        translate([66, 56, 1.5]) linear_extrude(height=0.5) text("14", size=7, halign="center");
        translate([48, 52, 1.5]) linear_extrude(height=0.5) text("12", size=7, halign="center");
        translate([32, 61, 1.5]) linear_extrude(height=0.5) text("11", size=7, halign="center");
        translate([18, 61, 1.5]) linear_extrude(height=0.5) text("10", size=7, halign="center");
    }
}

if(type == "round") { circles(); }
else { ovals(); }