text1 = "OUT"; // always use eight entries
text2 = "OF";
text3 = "OFFICE";
text4 = "";
text5 = "IN";
text6 = "A";
text7 = "MEETING";
text8 = "";
font_size1 = 5; // [1:6]
font_size2 = 5; // [1:6]
font_size3 = 5; // [1:6]
font_size4 = 5; // [1:6]
font_size5 = 5; // [1:6]
font_size6 = 5; // [1:6]
font_size7 = 5; // [1:6]
font_size8 = 5; // [1:6]

part = "both"; // [text:Text Only,sign:Sign Only,both:Both]
print_part();

/* [hidden] */
$fn = 100; // upgrade resolution
font_style1 = "Liberation Sans:style=Bold";
font_style2 = "Liberation Sans:style=Bold";
font_style3 = "Liberation Sans:style=Bold";
font_style4 = "Liberation Sans:style=Bold";
font_style5 = "Liberation Sans:style=Bold";
font_style6 = "Liberation Sans:style=Bold";
font_style7 = "Liberation Sans:style=Bold";
font_style8 = "Liberation Sans:style=Bold";

module print_part()
{
    // text part
    if (part != "sign")
    {
        color("White")
        {
            // male side
            difference()
            {
                translate([34,20,5]) cube([48.5,34,3],center=true);
                translate([34,20,5]) cube([46.5,32,5],center=true);
            }
            translate([16,20,5]) raisedTextMale();

            // female side
            rotate([0,0,180]) translate([15,-40,0])
            {
                difference()
                {
                    translate([34,20,5]) cube([48.5,34,3],center=true);
                    translate([34,20,5]) cube([46.5,32,5],center=true);
                }
                translate([16,20,5]) raisedTextFemale();
            }
        }
    }

    // sign part
    if (part != "text")
    {
        signMale();
        rotate([0,0,180]) translate([15,-40,0]) signFemale();
    }
}

module roundedBox(xdim, ydim, zdim, rdim)
{
    hull()
    {
        translate([rdim,rdim,0]) cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,rdim,0]) cylinder(h=zdim,r=rdim);
        translate([rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim);
    }
}

module raisedTextMale()
{
    rotate([0,0,90]) linear_extrude(height=2)
    {
        text(text=text1, font=font_style1, halign="center", valign="center", size=font_size1);
        translate([0,-12,0]) text(text=text2, font=font_style2, halign="center", valign="center", size=font_size2);
        translate([0,-24,0]) text(text=text3, font=font_style3, halign="center", valign="center", size=font_size3);
        translate([0,-36,0]) text(text=text4, font=font_style4, halign="center", valign="center", size=font_size4);
    }
}

module raisedTextFemale()
{
    rotate([0,0,90]) linear_extrude(height=2)
    {
        text(text=text5, font=font_style5, halign="center", valign="center", size=font_size5);
        translate([0,-12,0]) text(text=text6, font=font_style6, halign="center", valign="center", size=font_size6);
        translate([0,-24,0]) text(text=text7, font=font_style7, halign="center", valign="center", size=font_size7);
        translate([0,-36,0]) text(text=text8, font=font_style8, halign="center", valign="center", size=font_size8);
    }
}


module signFemale()
{
    // box
    difference()
    {
        roundedBox(80,40,5,3);
        translate([68,-2,0]) rotate([0,23,0]) cube([15,44,10]);
        translate([3,10,-1]) cube([4,19,7]);
        translate([62,10,-1]) cube([9,20,7]);
        translate([48,15,-1]) cube([4,10,4]);
    }
    translate([48,15,0]) cube([2,5.5,1]);

    // notch
    rotate([0,0,180])
    {
        translate([7,-9.5,2.5]) rotate([90,0,0]) cylinder(h=21,r=1);
        translate([7,-25,0]) cube([8,10,5]);
        translate([7,-15,2.5]) rotate([90,0,0]) cylinder(h=10,r=2.5);
    }
}

module signMale()
{
    // box
    difference()
    {
        roundedBox(80,40,5,3);
        translate([68,-2,0]) rotate([0,23,0]) cube([15,44,10]);
        translate([3,10,-1]) cube([4,19,7]);
        translate([62,10,-1]) cube([9,20,7]);
        translate([10,17,-1]) cube([38,6,4]);
        translate([48,23,0]) rotate([90,0,0]) cylinder(h=6,r=3);
        translate([48,25,1.2]) rotate([90,0,0]) cylinder(h=10,r=0.7);
    }

    // arm
    difference()
    {
        translate([11,18,0]) cube([37,4,2.6]);
        translate([13,17.5,1]) cube([3,5,1.7]);
    }
    translate([48,22,1.3]) rotate([90,0,0]) cylinder(h=4,r=1.3);
    translate([48,24,1.3]) rotate([90,0,0]) cylinder(h=8,r=0.5);

    // notch
    difference()
    {
        union()
        {
            translate([-15,7,0]) cube([7,26,5]);
            translate([-8,33,2.5]) rotate([90,0,0]) cylinder(h=26,r=2.5);
        }

        translate([-15,14,-1]) cube([12,12,7]);
        translate([-8,31,2.5]) rotate([90,0,0]) cylinder(h=22,r=1.5);
    }
}
