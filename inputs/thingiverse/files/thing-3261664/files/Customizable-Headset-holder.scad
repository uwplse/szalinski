// customizable Headset table holder
// preview[view:south, tilt:bottom]
/* [General Settings] */
//How wide is the full holder?
TotalWidth=25;

// How thick is the table?
TableThickness=19.3;

// Strength of the upper part of your headset
WidthOfHeadband=22;


/* [Additional Settings] */
// how long should the mount reach over the table?
LengthOfHolder=30;

// How thick is each solid part of the holder?
Strength=3; 

// how deep should the groove for the headset be?
GrooveDepth=10;

linear_extrude(height =TotalWidth)
polygon(points=[
    //TopRectangle on Table
    [0,0]
    ,[LengthOfHolder+Strength,0]
    ,[LengthOfHolder+Strength,Strength]
    ,[Strength,Strength] //Front of table
    ,[Strength,Strength+TableThickness]
    //Rectangle under table
    ,[LengthOfHolder+Strength,Strength+TableThickness]
    ,[LengthOfHolder+Strength,2*Strength+TableThickness]
    ,[0,2*Strength+TableThickness]
    // headset part:
    ,[0,GrooveDepth]
    ,[-WidthOfHeadband,GrooveDepth]
    ,[-WidthOfHeadband,0]
    ,[-WidthOfHeadband-Strength,0]
    ,[-WidthOfHeadband-Strength,GrooveDepth+3]
    ,[0,2*Strength+TableThickness]
    ]);
  