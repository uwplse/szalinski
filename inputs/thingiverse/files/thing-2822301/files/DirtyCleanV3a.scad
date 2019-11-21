printWhat=2; // [0:all (don't use), 1:standard base, 2: dual extruder text]


// [overall dimensions in mm]
len=140;
width=45;
thickness=7;
textDepth=.8;
numberOfVanes=7;

// [Text]
text1="CLEAN";
text2="DIRTY";

// [Magnet]
holeLen=38;
holeWid=17;
holeDep=1.8;


//[hidden]
textSize=width/sqrt(2)*.9;

small=0.01;
diaWid=width/numberOfVanes;
smallWid=diaWid/sqrt(2);
baseThickness=thickness-diaWid/2;


module magnetHole()
{
    cube([holeLen,holeWid,holeDep+small],center=true);
}
//!magnetHole();

module lenticularText(text,side1=false, viewFromBottom=true, extra=0)
{
    rot1=viewFromBottom?(side1?0:180):(side1?180:0);
    rot2=side1?45:-45;
    shift=side1?-diaWid/4:diaWid/4;
    
    intersection()
    {
        union()
        {
            rotate([rot2,0,0]) // rotate it in different dir for each text
            translate([0,-textSize/16,-50]) // center the extrusion
            linear_extrude(height=100) // extrude it big
            rotate([0,0,rot1]) // draw text either regular or upside down
            text(text=text,size=textSize,halign="center",valign="center",
                    font="arial style:bold");
        }
        union()
        {
            translate([0,shift,0]) // shift to make the tops line up instead of the centers
            for (i=[0:numberOfVanes])
            {
                translate([0,diaWid*i-width/2,0]) // this is what is different for each loop
                rotate([rot2,0,0]) //rotate it different direction for each text
                translate([0,side1?extra/2:-extra/2,0]) // force the extra overlap at the top
                cube([len,smallWid-textDepth+extra+small,textDepth+small],center=true);
            }
        }
    }
}
//!lenticularText(text="CLEAN",side1=true,viewFromBottom=false,extra=0);

module textOnly()
{
    union()
    {
        lenticularText(text=text1,side1=true,viewFromBottom=false,extra=0);
        lenticularText(text=text2,side1=false,viewFromBottom=false,extra=0);

        intersection()
        {
            lenticularText(text=text1,side1=true,viewFromBottom=false,extra=textDepth);
            lenticularText(text=text2,side1=false,viewFromBottom=false,extra=textDepth);
        }
        
    }
}
//!textOnly();
module baseOnly()
{
    for (i=[0:numberOfVanes-1])
    {
        translate([0,diaWid*i-width/2,-smallWid/4])
        rotate([45,0,0])
        //translate([0,0,-smallWid])
        cube([len,smallWid,smallWid],center=true);
    }
    translate([0,-diaWid/2,-baseThickness/2-smallWid/4])
    cube([len,width,baseThickness],center=true);
}
//!baseOnly();
module main()
{
    difference()
    {
         baseOnly();
        
        textOnly();
        
        translate([0,0,-baseThickness-smallWid/4-small])
        magnetHole();
    }
}
module dualExtruderText()
{
    textOnly();
}
if (printWhat!=2){
    main();
}
if (printWhat!=1){
    dualExtruderText();
}