// Number stack blocks
// By RevK

/* [ Global ] */

// Character on the top
bottom="B";
// Character on the top
top="C";
// Name/word on the front side
name="cat";
// Name/word on the other sides
name2="🐈";

/* [ Size ] */

// Width
W=30;

// Height
H=10;

/* [ Tolerance ] */

// Print Tolerance - increase is parts are too tight to stack
T=0.1;

// Bridge height tolerance - increases height under bridge
B=0.2;

/* [ Font ] */

// Font for top
font_number="Chalkboard:style=Bold";

// Font for name on front
font_name="Chalkboard:style=Bold";

// Font for name on sides
font_name2="Noto Emoji:style=Regular";

/* [ Fine tuning ] */

// Block edge radius
R1=1;

// Block edge $fn
F1=30;

// Number edge size
R2=1;

// Number edge $fn
F2=6;

// Number depth
H2=H/2;

// Number size
S2=W/2;

// Name edge size
R3=0.5;

// Name depth
H3=1.2;

// Name size
S3=H/2;

/* [ Hidden ] */

!block(bottom,top,name,name2);

// Some examples.

block("","0","zero","Lewis",S2=15,W=50,font_name2="Chalkboard:style=Bold");
block("","0","zero","🐈",S2=15,W=50,font_name2="Noto Emoji:style=Regular");
block("0","1","one",".",font_name2="");
block("1","2","two",":",font_name2="");
block("2","3","three",":.",font_name2="");
block("3","4","four","::",font_name2="");
block("4","5","five","::.",font_name2="");
block("5","6","six",":::",font_name2="");
block("6","7","seven",":::.",font_name2="");
block("7","8","eight","::::",font_name2="");
block("8","9","nine","::::.",font_name2="");
block("9","10","ten",":::::",font_name2="");

module block(bottom,top,name,name2)
{
    translate([-W/2,-W/2,0])
    {
        difference()
        {
            translate([R1,R1,R1])
            minkowski()
            {
                sphere(R1,$fn=F1);
                cube([W-R1*2,W-R1*2,H-R1*2]);
            }
            if(bottom!="")
            translate([W/2,W/2,-R2])
            {
                
                hull()
                {
                    minkowski()
                    {
                        cylinder(r1=R2+T,r2=0,h=R2+T,$fn=F2);
                        linear_extrude(height=H2+B)
                        text(bottom,font=font_number,size=S2,halign="center",valign="center");
                    }
                }
                hull()
                {
                    minkowski()
                    {
                        cylinder(r1=R2*2+T,r2=R2+T,h=R2+T,$fn=F2);
                        linear_extrude(height=1)
                        text(bottom,font=font_number,size=S2,halign="center",valign="center");
                    }
                }
            }
            if(name!="")
                addword(0,name,font_name,W=W);
            if(name2!="")
                for(a=[90:90:359]) addword(a,name2,font_name2,W=W);
        }
        if(top!="")
        {
            translate([W/2,W/2,H-R2])
            minkowski()
            {
                cylinder(r1=R2,r2=0,h=R2,$fn=F2);
                linear_extrude(height=H2)
                text(top,font=font_number,size=S2,halign="center",valign="center");
            }
        }
    }
}

module addword(a,name,f)
{
    translate([W/2,W/2,H/2])
    rotate([0,0,a])
    translate([S3*0.1,-W/2+R1,0])
    rotate([90,0,0])
    minkowski()
    {
        hull()
        {
            cube([0.01,0.01,1]);
            translate([0,2/3,1])cube([0.01,0.01,0.01]);
        }
        linear_extrude(height=R3)
        text(name,font=f,size=S3,halign="center",valign="center",spacing=1.25);
    }
}