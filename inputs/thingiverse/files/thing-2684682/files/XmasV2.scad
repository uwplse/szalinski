printWhat=2; // [0:all (don't use), 1:standard base, 2: dual extruder text]


// [overall dimensions in mm]
len=140;
width=44;
thickness=6;
textDepth=.8;
numberOfVanes=7;
holeDia=3;

branchHeight=18;
branchStartWidth=22;

// [Text]
text1="PEACE";
text2="STAR";

text3="XMAS";
text4="NOEL";

// [Magnet]
//holeLen=38;
//holeWid=17;
//holeDep=1.8;


//[hidden]
textSize=width/sqrt(2)*.8;

small=0.01;
diaWid=width/numberOfVanes;
smallWid=diaWid/sqrt(2);
baseThickness=thickness-diaWid/2;

module parallelogram(width1,width2,height)
{
    polygon([[-width1/2,0],[width1/2,0],[width2/2,height],[-width2/2,height]]);
}

module branch(width1,width2,height)
{
    polygon([[-width1/2,0],[width1/2,0],[width2/2,height],[0,height*2],[-width2/2,height]]);
}
module xmasTree()
{
    translate([0,branchHeight])
    branch(small,branchStartWidth+10-2,-branchHeight);
    
    for (i=[0:5])
    {
        translate([0,-branchHeight*i])
        branch(branchStartWidth+2*i,branchStartWidth+10+2*i,-branchHeight);
    }
    translate([0,-branchHeight*6])
    parallelogram(branchStartWidth+2*6,branchStartWidth+10+2*6,-branchHeight);
    
}
//!xmasTree();
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
            translate([0,0.4*textSize,-50]) // center the extrusion
            linear_extrude(height=100) // extrude it big
            rotate([0,0,rot1+90]) // draw text either regular or upside down
            text(text=text,size=textSize,halign="center",valign="center",
                    font="arial style:bold",direction="ttb",spacing=0.8);
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

module textOnly(text1,text2)
{
    intersection()
    {
        union()
        {
            lenticularText(text=text1,side1=true,viewFromBottom=true,extra=0);
            lenticularText(text=text2,side1=false,viewFromBottom=false,extra=0);

            intersection()
            {
                lenticularText(text=text1,side1=true,viewFromBottom=true,extra=textDepth);
                lenticularText(text=text2,side1=false,viewFromBottom=false,extra=textDepth);
            }
            
        }
        translate([-len/2+15,-diaWid/2,-baseThickness*2])
        rotate([0,0,90])
        linear_extrude(height=40)
        xmasTree();
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
module main(text1,text2)
{
    intersection()
    {
        difference()
        {
             baseOnly();
            
            textOnly(text1,text2);
        }    
        translate([-len/2+15,-diaWid/2,-baseThickness*2])
        rotate([0,0,90])
        linear_extrude(height=40)
        xmasTree();
    }
}
//!main(text1,text2);
if (printWhat!=2){
    difference()
    {
        union()
        {
            main(text1,text2);
            
            translate([0,-1*diaWid,-2*baseThickness])
            rotate([180,0,0])
            main(text3,text4);
        }
        translate([-len/2+5,-diaWid/2,0])
        cylinder(d=holeDia, h=baseThickness*7,center=true);
    }
}
if (printWhat!=1){
    textOnly(text1,text2);
    
    translate([0,-1*diaWid,-2*baseThickness])
    rotate([180,0,0])
    textOnly(text3,text4);
}