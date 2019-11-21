//This is Coin Hider Parametric v1. You can use this print to hide a coin as a prank or to keep your coins in mint condition.

//Pause printing to insert coin, or print two or more coins far apart and insert the coins when it's printing the external perimeter of the other coin(s).

di=22.31;   //enter coin diameter
he=2.19;    //enter coin height
ml=0.15;    //enter margin under/above coin. Tip: At least your layer thickness.
me=0.30;    //enter margin around coin. Tip: At least your extrude size.
tp=2.00;    //enter thickness of perimeter
ts=1.00;    //enter thickness of top/bottom
fr=20;      //enter number of fragments

translate([0,0,(he+2*ml+2*ts)/2])
    difference()
        {
            cylinder (h=he+2*ml+2*ts,d1=di+2*me+2*tp,d2=di+2*me+2*tp,$fn=fr,center=true);
            cylinder(h=he+2*ml,d1=di+2*me,d2=di+2*me,$fn=fr,center=true);
        };
    

te=str("Z+", (ts+ml+he), " !");
linear_extrude(height = ts+he, center = false, convexity = 10, twist = 0)
        translate([0,di/2+2*me+2*tp,0.5])
        text(te,size=10,halign="center",valign="baseline");
    
echo(te);