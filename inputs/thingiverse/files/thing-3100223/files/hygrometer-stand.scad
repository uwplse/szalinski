/*
** Hygrometer Stand 
**
** Created by Wolfgang Thomas
**
*/

// Print view
printView = 0; // [0,1]

// View Hygrometer 
viewHygrometer = 0; // [0,1]

// Stand angle
standAngle = 70; // [30 : 90]

// Stand width (mm)
width = 55; // [50 : 70]

// Hold offset (mm)
holdOffset =5; // [1 : 20]

// Stand bottom area width (mm 0 = solid )
standBottomWidth = 10.0; // 

// generate a simpler bottom - could be printed without support
simpleBottom = 1;

// Additional Text offset from bottom (mm)
textOffset = 0.5;

// text cut depth - should be a multible of a layer height 
textCutDepth = 1.0;

// circle detail (steps to generate a circle)
stepsPerCycle = 180; // [30:360]

// Some text on front
drawText = "Sample";

// Text font to use ( the default is Arial )
textFont="Arial";

// Height of text (mm)
textHeight = 6;
// Use a bold font
useBoldFont = 1;    // [0,1]

// Use a bold font
useItalicFont = 1;  // [0,1]

// Hygrometer diamter (mm)
diameter = 41.2;

// printing tollerance (mm)
tolerance = 0.3;

// Stand thickness (mm)
thickness =2.4;

// wall to create (mm) 0 = no wall will be created
wallWidth = 1.2;

// Cut width (mm)
cutWidth = 7.0;

// Cut angle
cutAngle = 0.0;

// Cut distance (mm)
cutDistance = 44.28;

// First layer height
//firstLayerHeight = 0.2;
// general layer height
//layerHeight  = 0.2;

printAngle = (180 - standAngle) * printView ;    

/* [Hidden] */
$fn = stepsPerCycle;

//
// view the stand
//
rotate([printAngle,0,0])
difference()
{
    zOffset = sin(standAngle)*(holdOffset+width/2) ;//- thickness;
    xOffset = cos(standAngle) * (holdOffset+width/2);//-0.5;
  
    // Areas to view
    union()
    {
        
        translate([0,xOffset,zOffset])
        rotate([standAngle,0,0])
        {
            hull()
            {
                cylinder(r= width/2 , h = thickness ,center=true);
                translate([0,-width/2,0])
                cube([width,holdOffset*2,thickness],center=true);
            }    
        
            // behind text area
     //       translate([0,-width/2+textOffset,thickness/2-layerHeight+0])
     //       cube([width-10,holdOffset*1.5,layerHeight],center=true);    
        }
        
        // connectiong bottom and front 
        rotate([0,90,0])
        cylinder(r=thickness/2, h=width,center=true);
        
        if( simpleBottom )
        {
             sizeY = holdOffset+width/2;
             translate([0,+sizeY/2,0])

             {
                 cube([width,+sizeY,thickness],center=true);
     
                 translate([0,(+sizeY)/2,0])
                 for( xMul = [1,-1])
                 {
                     translate( [xMul * ( width/2 - standBottomWidth/2 ),0,0] )
                     cylinder( d=standBottomWidth, h=thickness, center = true );
                 }
             }
         }
        else
        {
            translate([0,holdOffset+width/2,0])
            hull()
            {
                cylinder(r= width/2 , h = thickness ,center=true);
                translate([0,-width/2,0])
                cube([width,holdOffset*2,thickness],center=true);
            }
        }
        
        // bottom - front enforcement
        if(1)
        hull()
        translate([0,0,0])
        {
            s = standBottomWidth;//*4/5;
            if( standBottomWidth == 0 )
            {
                 s = 10;
            }    
          
            w = width;
            translate([-w/2,0,0])
            cube([w,s,0.01]);
            
            translate([-w/2,0,0])
            rotate([standAngle,0,0])
            cube([w,s,0.01]);
        }
        
        // walls
        if( wallWidth > 0 )
        {
             wallSize = zOffset;
            difference()
            {
                union()
                {
                    
         //           translate([0,thickness+wallSize/2,wallWidth/2-0.1])
                    {
                        for( xOffset = [-1,1] )
                        translate([xOffset*(width/2-wallWidth/2),0,0])
                        {
                            hull()
                            for( angle = [0,standAngle] )                   
                                 rotate([angle,0,0])
                                translate([0,thickness+wallSize/2,wallWidth/2])
                                {
                                    cube([wallWidth,wallSize,0.1],center=true);                            
                                }
                        }
                    }
                }
                union()
                {
                    beta = standAngle/2;
                    h = tan( beta ) * wallSize;
                    rotate([0,90,0])
                    translate([-h,zOffset,0])
                    cylinder( r = h, h = width+2 ,center = true );
                }
            }
        }
        
        
    }
    // Areas to cut from view
    union()
    {
        // front  cut
        translate([0,xOffset,zOffset])
        rotate([standAngle,0,0])
        {
            cutDiameter = diameter + tolerance;
            cylinder(r=cutDiameter/2 , h = thickness+0.2 ,center=true);
                
            // Cut in upper circle
            rotate([0,0,cutAngle]) 
            cube([cutDistance,cutWidth,thickness+1],center=true);
            if( drawText != "" )
            {
                translate([0,-width/2-holdOffset/2+textOffset,thickness/2-textCutDepth+0.01])
                linear_extrude(height = textCutDepth) {
                     if( useBoldFont )
                     {
                         if( useItalicFont )
                         {

                            styledFont=str(textFont , ":style=Bold Italic");
                            text(drawText,size=textHeight,halign="center",font=styledFont );
                        }
                         else
                         {

                            styledFont=str(textFont , ":style=Bold");
                            text(drawText,size=textHeight,halign="center",font=styledFont );
                       }
                     }
                     else
                     {
                         if( useItalicFont )
                         {

                            styledFont=str(textFont ,":style=Italic");
                            text(drawText,size=textHeight,halign="center",font=styledFont );
                        }
                         else
                         {
                            styledFont=textFont;
                            text(drawText,size=textHeight,halign="center",font=styledFont );

                         }
                    }
                }
            }
       }
       if( simpleBottom )
       {
            if( standBottomWidth > 0 && standBottomWidth < width/2)
            {
                translate([0,holdOffset+width/2,0])
                cylinder(r= width/2-standBottomWidth , h = thickness+1 ,center=true);
            }
      //      translate([0,zOffset,0])
      //      cube([width+1,10,thickness+1],center=true);
      }
       else
       {
       // bottom  cut
       if( standBottomWidth > 0 && standBottomWidth < width/2)
            translate([0,holdOffset+width/2,0])
            hull()
            {
                cylinder(r= width/2-standBottomWidth , h = thickness+1 ,center=true);
                translate([0,-width/2+standBottomWidth,0])
                cube([width-standBottomWidth*2,holdOffset*2,thickness],center=true);
            }
        }
   }
}


//
// view the Hygrometer
//
if( printView == 0 && viewHygrometer)
rotate([printAngle,0,0])
union()
{
    zOffset = sin(standAngle)*(holdOffset+width/2) ;//- thickness;
    xOffset = cos(standAngle) * (holdOffset+width/2);//-0.5;
  
    // Hygrometer to view
    color([0.8,0.8,0.8])
    union()
    {
        bottomWidth = diameter + 4;
        topWidth = bottomWidth -12;
        innerWidth = 25;
        
        translate([0,xOffset,zOffset])
        rotate([standAngle,0,0])
        {
            difference()
            {
                union()
                {
                    h=14;
                    translate([0,0,-h/2+thickness/2])
                    {
                        cylinder (r=diameter/2,h=h,center=true);
                    }
                 
                    translate([0,0,thickness/2])
                    cylinder( r1= bottomWidth/2, r2=topWidth/2,h=1.5);
                     
               }
                union()
                {
                   translate([0,0,1.8])
                   cylinder( r2=topWidth/2,r1=innerWidth/2,h=2,center=true);
                }
            }
            
           
        }
    }
}
