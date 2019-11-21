/// * The idea here is to store any flat packaged sauce packets
/// * 
$fn=100;


PieceToRender=0; //[0:All pieces, 1:Main holder, 2:Lid, 3:Connector lock, 4:Main and Lid printable]


Font=""; //FONTLIST
//mm
FontSize=8;
//mm
FontDepth=.6; //TODO allow embossing too?


/* [Main Dimensions] */
WidthOfPacket=38;
LengthOfPacket=75;
HeightOfHolder=80;

WallThickness=1.2;

Connectable=3; //[0:No, 1:Left side only, 2:Right side only, 3: Both sides]

FrontLabel_Top="Ketchup";
FrontLabel_Mid="";

IncludeRamp=1; //[0:No, 1:Yes]
//Percent of LengthOfPacket
RampPercent=.4;
//mm
RampHeight=10;



/* [Lid Dimensions] */
LidDepth=3;
LidCoversConnector=1; //[0:No, 1:Yes]

LidLabel="Ketchup";
LidLabel_Position=1; //[0:Font, 1:Middle, 2:Back]

LidLabel_LengthWise="";
LidLabel_LengthWise_Position=2; //[0:Bottom, 1:Middle, 2:Top]
LidLabel_LengthWise_Rotation=1; //[0:Left, 1:Right]


SlideTightFit=0.25;


TWEAK=0.001;
TWEAK2=TWEAK*2;


//Defaults, needed for other calculations
ConnectorDepth=2;
ConnectorTopWidth=5;




//Helper vars
TotalWidth=WidthOfPacket+2*WallThickness;
TotalDepth=LengthOfPacket+2*WallThickness;
TotalHeight=HeightOfHolder+WallThickness;


//Render vars
Render_MainHolder = PieceToRender==0 || PieceToRender==1 || PieceToRender==4;
Render_Ramp = IncludeRamp == 1;
Render_Lid = PieceToRender==0 || PieceToRender==2 || PieceToRender==4;
Render_ConnectorLock = PieceToRender==0 || PieceToRender==3;
//RenderOffsets
RO_Lid=PieceToRender==4
        ? [-5, 0, LidDepth+WallThickness]
        : [0,0,PieceToRender==0 ? HeightOfHolder+LidDepth+5 : 0];
RO_Connector=[0,PieceToRender==0 ? TotalDepth+ConnectorDepth+5 : 0,0];

Rotate_Lid=PieceToRender==4 ? [0,180,0] : [0,0,0];

if (Render_MainHolder)
{
    OpenTopBox([WidthOfPacket,LengthOfPacket,HeightOfHolder], WallThickness)
    {
        //Front cutout
        cutoutRadius=10;
        cutoutPercent=-0.3;
        yOffset=cutoutPercent < 0 ? cutoutRadius*cutoutPercent : 0;
        tangentalOffset=cutoutRadius - sqrt(cutoutRadius*cutoutRadius - yOffset*yOffset);
        //echo(tangentalOffset);
        translate([-TWEAK,cutoutRadius*cutoutPercent,cutoutRadius+WallThickness-tangentalOffset]) rotate([0,90,0])
            cylinder(r=cutoutRadius,h=TotalWidth+TWEAK2);
        
        //Labels
        //  Mid
        translate([TotalWidth/2,FontDepth-TWEAK,TotalHeight/2]) rotate([90,0,0])
            linear_extrude(FontDepth)
            text(FrontLabel_Mid, FontSize, font=Font, valign="center", halign="center");
        //  Top
        translate([TotalWidth/2,FontDepth-TWEAK,TotalHeight-FontSize]) rotate([90,0,0])
            linear_extrude(FontDepth)
            text(FrontLabel_Top, FontSize, font=Font, valign="center", halign="center");
    }
    
    //Ramp
    if (Render_Ramp)
    {
        rampLength=RampPercent*LengthOfPacket;
        translate([0,TotalDepth-rampLength-WallThickness,WallThickness]) rotate([0,90,0])
        linear_extrude(TotalWidth)
            polygon([[0,0], [0,rampLength], [-RampHeight,rampLength]]);
    }
    
    //Rounded front edge
    frontEdgeRadius=WallThickness;
    translate([0,frontEdgeRadius,WallThickness]) rotate([0,90,0])
            cylinder(r=frontEdgeRadius,h=TotalWidth);
    
    //Ability to lock two of these together
    if (Connectable == 1 || Connectable == 3)
    {
        //Left side
        translate([0,TotalDepth,0])
            TrapazoidLock(TotalHeight, width=ConnectorTopWidth, depth=ConnectorDepth, left=false);
    }
    if (Connectable == 2 || Connectable == 3)
    {
        //Right side
        translate([TotalWidth,TotalDepth,0])
            TrapazoidLock(TotalHeight, width=ConnectorTopWidth, depth=ConnectorDepth, right=false);
    }
}

if (Render_Lid)
{
    translate(RO_Lid)
    rotate(Rotate_Lid)
    {
        lidDepth=LidCoversConnector==1 ? TotalDepth+ConnectorDepth : TotalDepth;
        
        difference()
        {
            union()
            {
                //lid surface
                translate([0,0,LidDepth])
                    cube([TotalWidth,lidDepth,WallThickness]);
                //lid edge
                //Here i am using a single SlideTightFit for each X and Y lengths... should be tight...
                translate([WallThickness+SlideTightFit/2,WallThickness+SlideTightFit/2,0])
                    cube([WidthOfPacket-SlideTightFit,LengthOfPacket-SlideTightFit,LidDepth+TWEAK]);
            }
            
            union()
            {
                //hollow top
                translate([WallThickness*2,WallThickness*2,-TWEAK])
                    cube([WidthOfPacket-WallThickness*2,LengthOfPacket-WallThickness*2,LidDepth+TWEAK]);
                
                //label logic
                yMovement=
                    (LidLabel_Position==0
                        ? FontSize
                        : (LidLabel_Position==1
                            ? lidDepth/2
                            : (LidLabel_Position==2
                                ? TotalDepth-FontSize
                                : 0)));
                translate([TotalWidth/2, yMovement, LidDepth+WallThickness-FontDepth+TWEAK]) rotate([0,0,0])
                    linear_extrude(FontDepth)
                    text(LidLabel, FontSize, font=Font, valign="center", halign="center");
                //  Lengthwise label
                labelRotation=LidLabel_LengthWise_Rotation==0 ? -90 : 90;
                xMovement=
                    (LidLabel_LengthWise_Position==0
                        ? FontSize
                        : (LidLabel_LengthWise_Position==1
                            ? TotalWidth/2
                            : (LidLabel_LengthWise_Position==2
                                ? TotalWidth-FontSize
                                : 0)));
                xMovement2=LidLabel_LengthWise_Rotation==0 ? xMovement : TotalWidth-xMovement;
                translate([xMovement2, yMovement, LidDepth+WallThickness-FontDepth+TWEAK]) rotate([0,0,labelRotation])
                    linear_extrude(FontDepth)
                    text(LidLabel_LengthWise, FontSize, font=Font, valign="center", halign="center");
            }
        }
    }
}

if (Render_ConnectorLock)
{
    translate(RO_Connector)
    {
        difference()
        {
            translate([-ConnectorTopWidth/2-WallThickness, 0,0])
                cube([ConnectorTopWidth+WallThickness*2,ConnectorDepth+WallThickness,TotalHeight]);
            translate([0,-TWEAK,-TWEAK])
                TrapazoidLock(TotalHeight+TWEAK2, width=ConnectorTopWidth+SlideTightFit*2, depth=ConnectorDepth);
            //NOTE: putting SlideTightFit on both sides, cause sides of box might not be nice enough
        }
    }
}



module OpenTopBox(innerSize, wallThickness)
{
    //translate([wallThickness,wallThickness,wallThickness])
    difference()
    {
        union()
        {
            cube([innerSize[0]+wallThickness*2,innerSize[1]+wallThickness*2,innerSize[2]+wallThickness]);
        }
        union()
        {
            //Inner cutout
            translate([wallThickness,wallThickness,wallThickness+TWEAK])
                cube(innerSize);
            
            //any additional cutouts
            children();
        }
    }
}


module TrapazoidLock(length, width=5, depth=2, angle=60, left=true, right=true)
{
    bottomDifference=depth/tan(angle);
    //echo(bottomDifference);
    echo(BottomTotalWidth=width-2*bottomDifference);
    linear_extrude(length)
        polygon([[left ? -width/2 : 0,depth], [right ? width/2 : 0,depth],
                [right ? width/2-bottomDifference : 0,0], [left ? -width/2+bottomDifference : 0,0]]);
}
