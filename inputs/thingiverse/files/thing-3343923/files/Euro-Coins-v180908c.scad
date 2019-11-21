h=0.20; //layer height
e=0.50; //extruder diameter
$fn=360;

//1 eurocent
d1=16.25;
h1=1.67-h;
t1="1";

difference()
{
    cylinder(h=h1,d=d1);
    rotate([0,180,180])
    translate([0,0,-2*h+0.01])
    linear_extrude(height=2*h+0.01)
    text(t1, size=d1*0.8, halign ="center", valign ="center");
};

translate([0,0,h1])
linear_extrude(height=2*h)
{
    text(t1, size=d1*0.8, halign ="center", valign ="center");
    difference()
    {
        circle(d=d1);
        circle(d=d1-2*e);
    };
};

//2 eurocent
d2=18.75;
h2=1.67;
t2="2";
translate([d1/2+5+d2/2,0,0])
{
    difference()
    {
        cylinder(h=h2,d=d2);
        rotate([0,180,180])
        translate([0,0,-2*h+0.01])
        linear_extrude(height=2*h+0.01)
        text(t2, size=d2*0.8, halign ="center",valign ="center");
    };

    translate([0,0,h2])
    linear_extrude(height=2*h)
    {
        text(t2, size=d2*0.8, halign ="center", valign ="center");
        difference()
        {
            circle(d=d2);
            circle(d=d2-2*e);
        };
    };
};

//5 eurocent
d5=21.25;
h5=1.67;
t5="5";

translate([d1/2+5+d2+5+d5/2,0,0])
{
    difference()
    {
        cylinder(h=h5,d=d5);
        rotate([0,180,180])
        translate([0,0,-2*h+0.01])
        linear_extrude(height=2*h+0.01)
        text(t5, size=d5*0.8, halign ="center",valign ="center");
    };

    translate([0,0,h5])
    linear_extrude(height=2*h)
    {
        text(t5, size=d5*0.8, halign ="center", valign ="center");
        difference()
        {
            circle(d=d5);
            circle(d=d5-2*e);
        };
    };
};

//10 eurocent
d10=19.75;
h10=1.93-h;
t10="10";

translate([d1/2+5+d2+5+d5+5+d10/2,0,0])
{
    difference()
    {
        cylinder(h=h10,d=d10);
        rotate([0,180,180])
        translate([0,0,-2*h+0.01])
        linear_extrude(height=2*h+0.01)
        text(t10, size=d10*0.6, halign ="center",valign ="center");
    };

    translate([0,0,h10])
    linear_extrude(height=2*h)
    {
        text(t10, size=d10*0.6, halign ="center", valign ="center");
        difference()
        {
            circle(d=d10);
            circle(d=d10-2*e);
        };
    };
};

//20 eurocent
d20=22.25;
h20=2.14;
t20="20";
translate([d1/2+5+d2+5+d5+5+d10+5+d20/2,0,0])
{
    difference()
    {
        cylinder(h=h20,d=d20);
        rotate([0,180,180])
        translate([0,0,-2*h+0.01])
        linear_extrude(height=2*h+0.01)
        text(t20, size=d20*0.6, halign ="center",valign ="center");
    };

    translate([0,0,h20])
    linear_extrude(height=2*h)
    {
        text(t20, size=d20*0.6, halign ="center", valign ="center");
        difference()
        {
            circle(d=d20);
            circle(d=d20-2*e);
        };
    };
};

//50 eurocent
d50=24.25;
h50=2.38;
t50="50";

translate([7+d500/2+5+d200+5+d100+5+d50/2,d20/2+5+d50/2,0])
{
    difference()
    {
        cylinder(h=h50,d=d50);
        rotate([0,180,180])
        translate([0,0,-2*h+0.01])
        linear_extrude(height=2*h+0.01)
        text(t50, size=d50*0.6, halign ="center",valign ="center");
    };

    translate([0,0,h50])
    linear_extrude(height=2*h)
    {
        text(t50, size=d50*0.6, halign ="center", valign ="center");
        difference()
        {
            circle(d=d50);
            circle(d=d50-2*e);
        };
    };
};

//100 eurocent
d100=23.25;
h100=2.33-h;
t100="\u20AC1";

translate([7+d500/2+5+d200+5+d100/2,d5/2+5+d100/2,0])
{
    difference()
    {
        cylinder(h=h100,d=d100);
        rotate([0,180,180])
        translate([0,0,-2*h+0.01])
        linear_extrude(height=2*h+0.01)
        text(t100, size=d100*0.55, halign ="center",valign ="center");
    };

    translate([0,0,h100])
    linear_extrude(height=2*h)
    {
        text(t100, size=d100*0.55, halign ="center", valign ="center");
        difference()
        {
            circle(d=d100);
            circle(d=d100-2*e);
        };
    };
};

//200 eurocent
d200=25.75;
h200=2.20;
t200="\u20AC2";

translate([7+d500/2+5+d200/2,d5/2+5+d200/2,0])
{
    difference()
    {
        cylinder(h=h200,d=d200);
        rotate([0,180,180])
        translate([0,0,-2*h+0.01])
        linear_extrude(height=2*h+0.01)
        text(t200, size=d200*0.55, halign ="center",valign ="center");
    };

    translate([0,0,h200])
    linear_extrude(height=2*h)
    {
        text(t200, size=d200*0.55, halign ="center", valign ="center");
        difference()
        {
            circle(d=d200);
            circle(d=d200-2*e);
        };
    };
};

//500 eurocent
d500=27.50;
h500=2.50;
t500="\u20AC5";

translate([7,d1/2+5+d500/2,0])
{
    difference()
    {
        cylinder(h=h500,d=d500);
        rotate([0,180,180])
        translate([0,0,-2*h+0.01])
        linear_extrude(height=2*h+0.01)
        text(t500, size=d500*0.55, halign ="center",valign ="center");
    };

    translate([0,0,h500])
    linear_extrude(height=2*h)
    {
        text(t500, size=d500*0.55, halign ="center", valign ="center");
        difference()
        {
            circle(d=d500);
            circle(d=d500-2*e);
        };
    };
};