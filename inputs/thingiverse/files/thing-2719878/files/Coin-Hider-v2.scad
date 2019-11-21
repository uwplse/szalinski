//This is Coin Hider Parametric v1. You can use this print to hide a coin as a prank or to keep your coins in mint condition.

//Pause printing to insert coin, or print two or more coins far apart and insert the coins when it's printing the external perimeter of the other coin(s).

di=25.80;   //enter coin diameter
he=2.28;    //enter coin height
ml=0.15;    //enter printer layer thickness
mf=0.25;    //enter printer 1st layer thickness
me=0.30;    //enter printer extrude size
lm=2;       //enter layer margin (nom=2)
pm=2;       //enter perimeter margin (nom=2)
tp=2.00;    //enter thickness of perimeter
ts=1.00;    //enter thickness of top/bottom
fr=20;      //enter number of fragments

//Coin capsule
translate([0,0,(mf+round((ts-mf)/ml+0.5)*ml+(lm+round(he/ml+0.5))*ml+round(ts/ml+0.5)*ml)/2])
    difference()
        {
            cylinder (
                h=mf+round((ts-mf)/ml+0.5)*ml
                    +(lm+round(he/ml+0.5))*ml
                    +round(ts/ml+0.5)*ml,
                d=(pm+round(di/me+0.5))*me
                    +2*round(tp/me+0.5)*me,
                $fn=fr,center=true);
            cylinder(
                h=(lm+round(he/ml+0.5))*ml,
                d=(pm+round(di/me+0.5))*me,
                $fn=fr,center=true);
            //Breakplate, if you really want to, just remove comment markers bofore cube
            //cube([1.1*((pm+round(di/me+0.5))*me+2*round(tp/me+0.5)*me),ml,(1.1*(mf+round((ts-mf)/ml+0.5)*ml+(lm+round(he/ml+0.5))*ml+round(ts/ml+0.5)*ml))],true);
        };

//Text for height of coin insertion with 
te=str("Z+", (mf+round((ts-mf)/ml+0.5)*ml+(lm+round(he/ml+0.5))*ml-ml), "!");
linear_extrude(height = (mf+round((ts-mf)/ml+0.5)*ml+(lm+round(he/ml+0.5))*ml-ml), center = false, convexity = 10, twist = 0)
        translate([0,di/2+2*me+2*tp,0.5])
        text(te,size=10,halign="center",valign="baseline");
    
echo(str("Insert coin @ ",te));