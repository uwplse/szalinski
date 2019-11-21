/* [Part] */
part = "Frame"; //[Frame,Wheel]

/* [Frame] */
//Type of servo motor
servo = "SM-S4303R"; //[SM-S4303R,Parallax]

//Type of mouse
mouse = "Logo Mouse v4+"; //[Logo Mouse v4+,Logo Mouse v1 - v3,Nano Mouse / espMouse]

//Too much and your side sensors will pick up reflection from walls in front of your robot. Too little and proportional control will fail to keep your robot in the center of the cells.
sensorAngle = 10; //[30]

/* [Wheel] */
//You may need to adjust this number based on your 3D printer
servoPostDiameter = 6;

spokes = 3; //[3:10]

/* [Hidden] */

//Frame parameters
markerDiameterOuter = (mouse == "Logo Mouse v4+" || mouse == "Logo Mouse v1 - v3" ? 14.3 : 0);
markerDiameterWide = (mouse == "Logo Mouse v4+" || mouse == "Logo Mouse v1 - v3" ? 13.3 : 0);
markerDiameterNarrow = (mouse == "Logo Mouse v4+" || mouse == "Logo Mouse v1 - v3" ? 11.1 : 0);

redX = (servo == "SM-S4303R" ? 58 + markerDiameterOuter : 54 + markerDiameterOuter);
servoY = (servo == "SM-S4303R" ? 41.3 : 40.5);
servoZ = (servo == "SM-S4303R" ? 20.7 : 20);
servoScrewZ = (servo == "SM-S4303R" ? 10 : 10);
servoScrewY = (servo == "SM-S4303R" ? 50.3 : 50.5);
servoScrewD = (servo == "SM-S4303R" ? 2.2 : 2.8);
servoScrewL = (servo == "SM-S4303R" ? 12.5 : 10);
servoWireCutoutX = (servo == "SM-S4303R" ? 6 : 9);
/*Since the parallax motors do not come with screws to mount them to the frame, I've been using #4 1/2" Thread-Cutting Screws for Soft Plastics (Part# 94629A560) from McMaster. However, the SM-S4303R motors appear to use a #2 screw. The closest thing I could find on McMaster is http://www.mcmaster.com/#93406a079 (still need to test it).*/

servoWireCutoutR = 5;

potentiometerPosX = 10.5; //Distance from side of robot
potentiometerD = 4.5;

breadboardY = 83;

redZ = 3;

greenY = 10;

batteryY = 17.3;
batteryZ = 24.5;

pinkX = 72;
pinkZ = 14;
pinkR = 5;

wheelD = (2+5/8)*25.4;

ballBearingD = (3/8)*25.4;
castorGap = .55;
castorWall = 3;
castorOpening = .95; //Percentage of ball bearing
castorExposed = .23; //Percentage of ball bearing

brownX = 40;
brownY = 3;

silverX = 25;
silverY = 3;

sensorWidth = 5;
sensorDepth = 1.6;
sensorHeight = 6;

sensorDivitD = 4;

//Internal varialbes (used to make the code more readable)
redY = greenY*2+servoY;
pinkY = breadboardY-redY;
ballBearingPosY = redY+batteryY+(castorWall+castorGap+ballBearingD/2);
ballBearingPosZ = redZ+(servoZ/2)+(wheelD/2)-(ballBearingD/2);
bluePosY = redY+batteryY;

//Wheel Parameters
innerDiameter = 2.225*25.4;
outerDiameter = 2.645*25.4;

stretchFactor = 1.03; //Percentage of wheel diameter

screwHoleDiameter = 3.5;

diameterORing = (outerDiameter-innerDiameter)/2;
echo("Diameter of the O-Ring: ",diameterORing,"mm");

zHub = 5.75;
zWheel = diameterORing+2;

spokeWidth = 3;
fillet = 2;

wheelDiameter = (innerDiameter+outerDiameter)/2;

//Frame modules
module servoScrewHole()
{
    rotate([0,-90,0])
        cylinder(d=servoScrewD,h=servoScrewL);
}

module sensorSlot()
{
    translate([0,-sensorDepth-1,0])
        cube([sensorWidth,sensorDepth,pinkZ-1]);
    translate([1,-1.01,0])
        cube([3,1.02,pinkZ-1]);
    translate([0,-1.01,pinkZ-sensorHeight-1])
        rotate([0,45,0])
            cube([sensorWidth/sqrt(2),1.02,sensorWidth/sqrt(2)]);
    translate([0,-1.01,pinkZ-sensorHeight-4])
        cube([sensorWidth,1.02,3]);
}

module halfMouse()
{
    difference()
    {
        union()
        {
            color("red")
                cube([redX/2,redY,redZ]);

            color("green")
            {
                translate([0,0,redZ])
                {
                    cube([redX/2,greenY,servoZ]);
                    translate([0,greenY+servoY,0])
                        cube([redX/2,greenY,servoZ]);
                }
            }


            color("pink")
                hull()
                {
                    translate([0,redY,0])
                        cube([.01,pinkY,pinkZ]);
                    translate([0,redY-.2,0])
                        cube([redX/2,.01,pinkZ]);
                    translate([pinkX/2-(pinkZ-sensorHeight),redY+pinkY-pinkR,0])
                        cylinder(r=pinkR,.01);
                    translate([pinkX/2+(pinkY-2*pinkR)*tan(sensorAngle)-(pinkZ-sensorHeight),redY+pinkR,0])
                        cylinder(r=pinkR,.01);
                    translate([pinkX/2,breadboardY-pinkR,pinkZ-sensorHeight-1])
                        cylinder(r=pinkR,sensorHeight+1);
                    translate([pinkX/2+(pinkY-2*pinkR)*tan(sensorAngle),redY+pinkR,pinkZ-sensorHeight-1])
                        cylinder(r=pinkR,sensorHeight+1);
                }

            color("brown")
                translate([0,breadboardY,pinkZ-sensorHeight-1-brownY])
                    cube([brownX/2,brownY,sensorHeight+1+brownY]);

            color("aqua")
            hull()
            {
                translate([0,redY-3,pinkZ+batteryZ-silverY/2+silverY*sqrt(2)])
                    cube([silverX/2,3,.01]);
                translate([0,servoY+greenY,redZ+servoZ])
                    cube([silverX/2,greenY,.01]);
            }

            color("blue")
            hull()
            {
                translate([0,bluePosY,pinkZ])
                    cube([brownX/2,breadboardY-bluePosY+brownY,.01]);
                translate([0,ballBearingPosY,ballBearingPosZ])
                    difference()
                    {
                        sphere(d = ballBearingD+2*castorGap+2*castorWall);
                        
                        //Remove side of castor (necessary because of mirroring)
                        rotate([0,-90,0])
                            cylinder(d = 50,h = 10);
                    }
                translate([0,bluePosY,pinkZ+batteryZ-silverY/2+silverY*sqrt(2)])
                    cube([silverX/2,3,.01]);
            }

            color("silver")
            {
                translate([0,redY,pinkZ+batteryZ-silverY/2])
                    rotate([45,0,0])
                        cube([silverX/2,silverY,silverY]);
                translate([0,bluePosY,pinkZ+batteryZ-silverY/2])
                    rotate([45,0,0])
                        cube([silverX/2,silverY,silverY]);
            }

            color("Orange")
            {
                translate([0,redY,pinkZ-silverY/sqrt(2)])
                    rotate([45,0,0])
                        cube([redX/2,silverY,silverY]);
                difference()
                {
                    translate([0,bluePosY,pinkZ-silverY/sqrt(2)])
                        rotate([45,0,0])
                            cube([brownX/2,silverY,silverY]);
                    translate([brownX/2,bluePosY-silverY,pinkZ])
                        rotate([0,atan((batteryZ-silverY/2+silverY*sqrt(2))/(brownX/2-silverX/2))-90,0])
                            cube([2,silverY*2,silverY]);
                }
            }
            
            color("Black")
            {
                translate([0,greenY,redZ])
                    cube([markerDiameterOuter/2,redY-greenY,servoZ]);
            }         
        }

        //Remove bottom of castor
        translate([0,ballBearingPosY,ballBearingPosZ+ballBearingD/2-ballBearingD*castorExposed])
            cylinder(d = 50,h = 10);

        //Inside castor
        translate([0,ballBearingPosY,ballBearingPosZ])
            sphere(d = ballBearingD+castorGap*2);

        //Castor slots
        translate([-.01,ballBearingPosY-.5,ballBearingPosZ-ballBearingD/2-1])
            cube([20,1,ballBearingD+2*castorGap+2*castorWall]);

        //Castor opening
        translate([0,ballBearingPosY,ballBearingPosZ])
            cylinder(d = ballBearingD*castorOpening,h = ballBearingD);

        //Screw holes
        translate([redX/2+.01,greenY-(servoScrewY-servoY)/2,redZ+(servoZ-servoScrewZ)/2])
            servoScrewHole();
        translate([redX/2+.01,greenY+servoY+(servoScrewY-servoY)/2,redZ+(servoZ-servoScrewZ)/2])
            servoScrewHole();
        translate([redX/2+.01,greenY-(servoScrewY-servoY)/2,redZ+servoZ-(servoZ-servoScrewZ)/2])
            servoScrewHole();
        translate([redX/2+.01,greenY+servoY+(servoScrewY-servoY)/2,redZ+servoZ-(servoZ-servoScrewZ)/2])
            servoScrewHole();

        //Front sensor slots
        translate([.5,breadboardY+brownY,0])
            sensorSlot();
        translate([-.01,breadboardY+brownY,pinkZ-sensorHeight-1])
            rotate([-135,0,0])
                cube([brownX/2+.02,brownY*sqrt(2),brownY*sqrt(2)]);

        //Divits to help install front sensors
        translate([sensorWidth/2+.5,redY+pinkY,pinkZ+sensorDivitD/2+3])
            rotate([-90,0,0])
                cylinder(d=sensorDivitD,h=10);
                
        //Side sensor slots
        translate([pinkX/2,breadboardY-pinkR,0])
            rotate([0,0,sensorAngle-90])
                translate([(pinkY-2*pinkR)*cos(sensorAngle)/2,pinkR,0])
                {
                    translate([-sensorWidth-.5,0,0])
                        sensorSlot();
                    translate([.5,0,0])
                        sensorSlot();
                }
        
        //Cutout for servo wires & access to Parallax calibration potentiometers
        translate([-.01,-.01,redZ+5])
        {
            translate([markerDiameterOuter/2,0,0])
            {
                cube([servoWireCutoutX,greenY+.02,5.01]);
                translate([0,0,5])
                {
                    cube([servoWireCutoutX+servoWireCutoutR,greenY+.02,11]);
                    translate([servoWireCutoutX,0,0])
                        rotate([-90,0,0])
                            cylinder(r=servoWireCutoutR,h=greenY+.02);
                }
            }
        }

        //Cutout for access to SM-S4303R calibarion potentiometer
        if(servo=="SM-S4303R")
        {
            hull()
            {
                translate([redX/2-potentiometerPosX,-.01,redZ+servoZ/2])
                    rotate([-90,0,0])
                    {
                        cylinder(d=potentiometerD,h=greenY+.02);
                        translate([-2.5,0,0])
                            cylinder(d=potentiometerD,h=greenY+.02);
                    }
            }
        }

        //Marker Hole
        translate([0,greenY+10.4,-.01])
        {
            cylinder(d=markerDiameterWide,h=redZ+servoZ-(markerDiameterWide-markerDiameterNarrow)-3);
            translate([0,0,redZ+servoZ-(markerDiameterWide-markerDiameterNarrow)-3-.01])
                cylinder(d1=markerDiameterWide,d2=markerDiameterNarrow,h=markerDiameterWide-markerDiameterNarrow);
            cylinder(d=markerDiameterNarrow,h=redZ+servoZ+.02);
        }
    }
}

if(part == "Frame")
{
    $fn = 64;

    difference()
    {
        union()
        {
            halfMouse();
            mirror([1,0,0])
                halfMouse();
        }
        
        
        //PCB Mounting Holes
        if(mouse == "Logo Mouse v1 - v3")
        {
            translate([-22.22,40,-.01])
            {
                translate([40.64,20.955,0])
                    cylinder(d=2.8,10);
                translate([1.905,27.94,0])
                    cylinder(d=2.8,10);
                translate([20.32,1.905,0])
                    cylinder(d=2.8,10);
            }
        }
        else if(mouse == "Logo Mouse v4+")
        {
            translate([-27.94,45,-.01])
            {
                translate([24.13,3.175,0])
                    cylinder(d=2.8,10);
                translate([46.99,19.685,0])
                    cylinder(d=2.8,10);
                translate([5.715,29.845,0])
                    cylinder(d=2.8,10);
            }
        }
    }
}

module wheel()
{
    $fn = 128;
    difference()
    {
        linear_extrude(height=zWheel)
        {
            offset(r=-fillet)
            {
                difference()
                {
                    circle(d=wheelDiameter*stretchFactor+fillet*2-diameterORing*tan(22.5));
                    circle(d=innerDiameter*stretchFactor-6-fillet*2);
                }
                circle(d=zHub+6+fillet*2);
                for(i = [0:spokes-1])
                {
                    rotate(i*360/spokes)
                        translate([-(spokeWidth+2*fillet)/2,0])
                            square([spokeWidth+2*fillet,(innerDiameter*stretchFactor)/2]);
                }
            }
        }
        
        translate([0,0,diameterORing/2+1])
            rotate_extrude(twist=360)
                translate([(wheelDiameter*stretchFactor)/2,0,0])
                    rotate([0,0,22.5])
                        circle(d=diameterORing/cos(22.5),$fn=8);

        translate([0,0,2])
            cylinder(d=servoPostDiameter,h=zWheel-2+.01);

        translate([0,0,-.01])
            cylinder(d=screwHoleDiameter,h=2.02);

        translate([0,0,zHub])
            cylinder(d1=innerDiameter*stretchFactor-2-(zWheel-zHub)*2,d2=innerDiameter*stretchFactor-2,h=zWheel-zHub+.01);
    }
}

if(part == "Wheel")
{
    wheel();
}