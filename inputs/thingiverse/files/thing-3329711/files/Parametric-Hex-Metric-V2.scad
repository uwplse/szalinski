// Creates a holder for metric hex keys. Based on https://www.thingiverse.com/thing:2818898 by Leitnin

$fn=256;   //set facet resolution, higher will take stupid time to render. 32 or 64 is enough, 256 is plenty


//Below you can customize your holder in various ways

wrenchSize = [10,8,6,5,4,3,2.5,2,1.5];  //put in your wrench sizes, in mm




//Text Location and orientation. (You can have both side and top) only put 1 or 0 here
numbersOnTop = 1;
numbersOnSide = 1;
flipSideText=0; // flips the text on the outside edge
angledGroove=1; // if the main groove has a big chamfer on top (to print without supports).

//coefficients for quadratic spacing equations for spreading out the holes.  My tip: Increase B until the large holes are far enough apart to print, then decrease A until the last hole is in a good spot.  If necessary, then you can shrink the font-size
A = -1.4;
B = 50;
//Text labels
fontSize = 3.5;
textOffset = 1; //For labels on top, spacing betwen top of text and edge of hole.

//The hole size is calculated per the following linear relationship.  wrenchSize*x+y.  The x=1.15 is a constant and comes from the flat-flat distance to the corner to corner distance (1/cos(30)=1.1547), and the Y gives some extra slack, since the point is that the o-ring not the plastic holds the wrench.  Adjust y if needed.
x=1.154; //constant
y=0.3; //Extra hole size to give some space and compensate for print shrinkage etc.

//These are the base dimensions.  If you change these, you'll need to find something that works with the o-ring you select
diameterOuter=51;
diameterInner=42.835;
chamfer=1.5;    //size of all chamfers
hMiddle=3.8;    //Height of middle part
hBigChamfer=2;  //Big slope in the middle
hTop=3;         //height of top part
hBottom=5;      //Height of bottom part
centerHoleDiam = 15;    //Center hole for material saving and hanging the tool. Can't be too big if you have the numbers on top.


//------ Functions we will need later
//This is used to place the outer edge of each hole 3mm from the outer edge of the holder.
offset=diameterOuter/2-3;
// Calculate the real size of the hole (including some slack) for each wrench
function holeSize(nomSize) = wrenchSize[nomSize] * x + y;
//Calculate the radius of each hole from the center
function holePos(pos) = offset-(holeSize(pos)/2);

//------- Build the actual geometry.    
intersection()
{
    sphere(diameterOuter/2);
        
    difference()
    {
        union()
        {
            //Center Section
            cylinder(hMiddle,d=diameterInner,center =true);
            
            //Chamfer from inner to outer diameter
            if(angledGroove==1) //we have a chamfer
            {
                translate([0,0,hMiddle/2])cylinder(hBigChamfer,d1=diameterInner, d2=diameterOuter, center=false);
            }
            if(angledGroove==0) // No chamfer, just a straight section
            {
                translate([0,0,hMiddle/2])cylinder(hBigChamfer,d=diameterOuter, center=false);
            }
            //Upper Section
            translate([0,0,hMiddle/2+hBigChamfer])cylinder(3,d1=diameterOuter, d2=diameterOuter, center=false);
            
            //Lower Section
            translate([0,0,(hBottom/2+hMiddle/2)*-1])cylinder(hBottom,d=diameterOuter,center =true);
        }
        
        //Holes for wrenches
        for (i = [0:1:len(wrenchSize)-1])
        {
            //Cylindrical hole
            rotate([0,0,(A*i*i + B*i)])translate([holePos(i),0,0])cylinder(16,d=holeSize(i),center=true);
                    
            //Chamfers top
            rotate([0,0,(A*i*i + B*i)])translate([holePos(i),0,6.5])cylinder(2,d1=holeSize(i)-chamfer, d2=holeSize(i)+chamfer,center=true);
                    
            //Chamfers bottom
            rotate([0,0,(A*i*i + B*i)])translate([holePos(i),0,-6.5])cylinder(2,d1=holeSize(i)+chamfer, d2=holeSize(i)-chamfer,center=true);
        }
        
        //Wrench size labels
        if(numbersOnTop ==1)
        {
            font1 = "Liberation Sans:style=Bold"; // here you can select other font type
            translate([0,0,6.5])linear_extrude(height = 1)
            {
                for (i= [0:1:len(wrenchSize)-1])
                    {
                        rotate([0,0,(A+0.02)*i*i + B*i])translate([(holePos(i)-holeSize(i)/2-fontSize-textOffset),0,0])rotate([0,0,-90])text(str(wrenchSize[i]), font = font1, halign="center", size = fontSize, direction = "ltr", spacing = 1);
                    }
            }
        }
        if(numbersOnSide ==1)
        {    
            font1 = "Liberation Sans:style=Bold"; // here you can select other font type
   
            for (i = [0:1:len(wrenchSize)-1])
            {
                if(flipSideText==1)
                {
                    orientation=180;                

                    rotate([0,0,(A*i*i + B*i)])
                 
                    translate([(diameterOuter/2)-1,0,-2.65])rotate([90,orientation,90])linear_extrude(height = 2)
                    {
                        text(str(wrenchSize[i]), font = font1, halign="center",  size = fontSize, direction = "ltr", spacing = 1);
                    }
                }
                else
                {
                    orientation=0;
                    rotate([0,0,(A*i*i + B*i)])
                    translate([(diameterOuter/2)-1,0,-6])rotate([90,orientation,90])linear_extrude(height = 2)
                    {
                        text(str(wrenchSize[i]), font = font1, halign="center",  size = fontSize, direction = "ltr", spacing = 1);
                    }
               }
            }
        }
  //Hole in the middle including its chamfers
        union(){
                cylinder(20,d=centerHoleDiam,center=true);
                translate([0,0,6.5]) cylinder(h=chamfer,d1=centerHoleDiam,d2=centerHoleDiam+chamfer,center=true);
                translate([0,0,-6.5]) cylinder(h=chamfer,d1=centerHoleDiam+chamfer,d2=centerHoleDiam,center=true);
        }
    }
}


//Improvement from the original:
//Added center hole and its chamfers
//Refactored some of the code to remove a few magic numbers and used variables and functions instead to improve customizability