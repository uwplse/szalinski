/*
** Custamizable Paicley Soap holder 
**
** Created by Wolfgang Thomas
**
*/

$fn=16;

// average soap holder size - will be more than this
size = 105;
// average soap holder height - will be less tan this
holderHeight    = 25;

// XScale value
xScale = 1;
// YScale value
yScale = 0.7;

// offset for inner sprial - should be less than 0.5
innerScale = 0.3;

// Outer line width at bottom (mm)
outerBottomSize = 5;
// Outer line with at top (mm)
outerTopSize = 2;

// inner paisley line size at the bottom in mm
innerBottomSize = 3;
// inner paisley line size at the top in mm
innerTopSize    = 1.5;

// height of the bottom (mm) - there will be not bottom if 0 entered.
bottomHeight    = 1.5;
// size of the drain holes (mm) - there will be no drain holes if 0 entered
drainHoleSize   = 6;

// Cut at top
topCutDepth     =   1;

// number of processing steps - sould be at least 180 for printing
angleSteps = 60;

// start angle usually 0
startAngle = 0;

// end angle usually more than 360
endAngle = 360+60;

/* [Hidden] */

angleDelta = endAngle - startAngle;
angleStep = angleDelta / angleSteps;

decorLineDistance = [13,26];

centerBottomDiameter = outerBottomSize*1.7;
centerTopDiameter = outerTopSize*3;


// main
paisley();


module paisley()
{    
    upperYOffset = (centerBottomDiameter-outerBottomSize)/2;
    circleSteps = angleSteps/4;
    
    innerSize = size * innerScale;
    innerEndR = innerSize;
    // Verbindungskranz aussen innen
    upper = [ cos(endAngle) * xScale * size ,sin(endAngle) * yScale *size-upperYOffset];
    lower = [ cos(endAngle) * xScale * innerEndR ,sin(endAngle) * yScale *innerEndR];

    vDist = upper-lower;
    ax = vDist.x / xScale;
    ay = vDist.y / yScale;

    endR = sqrt(ax*ax + ay*ay)/2;

    vCenter = (upper+lower)/2;

    start = endAngle;
    end = start + 180;
   
    difference()
    {
        union()
        {
            // 
            // center Dot
            //
            cylinder(d1=centerBottomDiameter,d2=centerTopDiameter,h=holderHeight,center=true);
                   
            
            for( n = [0:1:circleSteps-1] )
            {
                angle = start + (end-start) *n / circleSteps;
                angle2 = start + (end-start) *(n+1) / circleSteps;
                        
                si = sin(angle);
                co = cos(angle);
                
                si2 = sin(angle2);
                co2 = cos(angle2);
                        
                dx = vCenter.x + co * endR * xScale;
                dy = vCenter.y + si * endR * yScale;
                
                dx2 = vCenter.x + co2 * endR * xScale;
                dy2 = vCenter.y + si2 * endR * yScale;
                
                hull()
                {
                    translate( [dx,dy])
                    cylinder(d1=outerBottomSize,d2=outerTopSize,h=holderHeight,center=true);
                    translate( [dx2,dy2])
                    cylinder(d1=outerBottomSize,d2=outerTopSize,h=holderHeight,center=true);
                }
                
                // Decorlinie
                for( di = decorLineDistance )
                {
                    dyD = dy - si * di * yScale;
                    dxD = dx - co * di * xScale;
                    
                    dyD2 = dy2 - si2 * di * yScale;
                    dxD2 = dx2 - co2 * di * xScale;
                    
                    hull()
                    {
                        translate([dxD,dyD])
                        cylinder(d1=innerBottomSize,d2=innerTopSize,h=holderHeight,center=true);
                        
                        translate([dxD2,dyD2])
                        cylinder(d1=innerBottomSize,d2=innerTopSize,h=holderHeight,center=true);
                    }
                }
            }
          
            distFactor = sqrt(xScale*xScale + yScale * yScale );
            
            // Inntenkurve
            
            for( n = [0:1: angleSteps-1] )
            {
                angle = startAngle + (endAngle-startAngle) *n / angleSteps;
                angle2 = startAngle + (endAngle-startAngle) *(n+1) / angleSteps;
                
                si = sin(angle);
                co = cos(angle);
                
                si2 = sin(angle2);
                co2 = cos(angle2);
                
                
                f   = (angle - startAngle)/angleDelta;
                f2  = (angle2 - startAngle)/angleDelta;
                
                r       = f * innerSize;
                rUpper  = f * size;
                r2       = f2 * innerSize;
                r2Upper  = f2 * size;
              
                dx = co * r * xScale;
                dy = si * r * yScale;
                
                dx2 = co2 * r2 * xScale;
                dy2 = si2 * r2 * yScale;
                 
                dxUpper = co * rUpper * xScale;
                dyUpper = si * rUpper * yScale-upperYOffset;
                
                dx2Upper = co2 * r2Upper * xScale;
                dy2Upper = si2 * r2Upper * yScale-upperYOffset;
                
                upper = [dxUpper,dyUpper];
                lower = [dx,dy];
                
                upper2 = [dx2Upper,dy2Upper];
                lower2 = [dx2,dy2];
                
              
                {
                    hull()
                    {
                        translate(lower)
                        cylinder(d1=outerBottomSize,d2=outerTopSize,h=holderHeight,center=true);
                        
                        translate(lower2)
                        cylinder(d1=outerBottomSize,d2=outerTopSize,h=holderHeight,center=true);
                    }
                    
                    hull()
                    {
                        translate(upper)
                        cylinder(d1=outerBottomSize,d2=outerTopSize,h=holderHeight,center=true);
                        
                        translate(upper2)
                        cylinder(d1=outerBottomSize,d2=outerTopSize,h=holderHeight,center=true);
                    }
                                        
                    for( di = decorLineDistance )
                    {
                         // Decorlinie
                        dyD2 = dy + si * di * yScale;
                        dxD2 = dx + co * di * xScale;
                        
                        dyD3 = dyUpper - si * di * yScale;
                        dxD3 = dxUpper - co * di * xScale;
                        
                        dyD22 = dy2 + si2 * di * yScale;
                        dxD22 = dx2 + co2 * di * xScale;
                        
                        dyD32 = dy2Upper - si2 * di * yScale;
                        dxD32 = dx2Upper - co2 * di * xScale;
                       
                        dist = sqrt( dxD2*dxD2 + dyD2*dyD2);
                        distUpper = sqrt(dxD3*dxD3 +dyD3*dyD3);
                        
                        if( dist  <= distUpper && dist > di )
                        {
                        
                            hull()
                            {
                                translate([dxD2,dyD2])
                                cylinder(d1=innerBottomSize,d2=innerTopSize,h=holderHeight,center=true);
                                
                                
                                translate([dxD22,dyD22])
                                cylinder(d1=innerBottomSize,d2=innerTopSize,h=holderHeight,center=true);
                            }
                           
                            
                            hull()
                            {
                                translate([dxD3,dyD3])
                                cylinder(d1=innerBottomSize,d2=innerTopSize,h=holderHeight,center=true);
                                
                               
                                translate([dxD32,dyD32])
                                cylinder(d1=innerBottomSize,d2=innerTopSize,h=holderHeight,center=true);
                            }
                        }     
                    }
                 } 
           } 
           
           // Verbindungssteg
           if( bottomHeight == 0 )
           {
                 f1 = (180 - startAngle)/angleDelta;
                 f2 = (360 - startAngle)/angleDelta;
                
                 length       = (f1+f2) * size-outerBottomSize/2-0.5;

                 translate([f1*size/2,0,-holderHeight/2+bottomHeight])
                 rotate([0,90,0])
                    scale([2,1,1])
                 difference()
                 {
                    cylinder(d=drainHoleSize*2 , h = length ,center=true,$fn=32);
                    translate([drainHoleSize/2,0,0])
                    cube([drainHoleSize,drainHoleSize*2,length+1],center=true);
                 }
             
           }
             if( topCutDepth && 0 )
             {
                 f1 = (180 - startAngle)/angleDelta;
                 f2 = (360 - startAngle)/angleDelta;
                
                 length       = (f1+f2) * size;

                 translate([f1*size/2,size*0.05,holderHeight])
                 resize([length*1.3,size*xScale/yScale,holderHeight*2])
                 sphere(d=size*2,center=true,$fn=32);
                
             }
        }
         union()
         {
             if( topCutDepth )
             {
                  f1 = (180 - startAngle)/angleDelta;
                 f2 = (360 - startAngle)/angleDelta;
                
                 length       = (f1+f2) * size;

                 translate([f1*size/2,size*0.05,holderHeight])
                 resize([length*1.3,size*xScale/yScale,holderHeight*2])
                 sphere(d=size*2,center=true,$fn=32);
                
             }
             // Entwässerung in X
             if( drainHoleSize > 0 )
             {
                 // Querbereich
                 translate([0,0,-holderHeight/2+bottomHeight])
                 rotate([0,90,0])
                 cylinder(d=drainHoleSize , h = size*2 ,center=true,$fn=32);
                 
                 for( angle = [0:45:endAngle] )
                 {
                    angle2 = angle + 0.1;
                     
                    // Entwässerung im Kreisbogen bei 90 und 270 Grad
                    si = sin(angle);
                    co = cos(angle);
                     
                    si2 = sin(angle2);
                    co2 = cos(angle2);
              
                    f   = (angle - startAngle)/angleDelta;
                    f2   = (angle2 - startAngle)/angleDelta;

                    r       = f * innerSize;
                    r2      = f2 * innerSize;
                     
                    rUpper  = f * size;
                    rUpper2 = f2 * size;

                    dx = co * r * xScale;
                    dy = si * r * yScale;
                     
                    dx2 = co2 * r2 * xScale;
                    dy2 = si2 * r2 * yScale;
                     
                    dxUpper = co * rUpper * xScale;
                    dyUpper = si * rUpper * yScale-upperYOffset;
                     
                    dxUpper2 = co2 * rUpper2 * xScale;
                    dyUpper2 = si2 * rUpper2 * yScale-upperYOffset;

                    translate([dxUpper,dyUpper,-holderHeight/2+bottomHeight])
                    rotate([0,90,90+atan2(dyUpper-dyUpper2,dxUpper-dxUpper2)])
                    cylinder(d=drainHoleSize, h = outerBottomSize+1 ,center=true,$fn=32);
                     
                    translate([dx,dy,-holderHeight/2+bottomHeight])
                    rotate([0,90,90+atan2(dy-dy2,dx-dx2)])
                    cylinder(d=drainHoleSize, h = outerBottomSize+1 ,center=true,$fn=32);
                    
                    
                     // Deco line drawin
                    for( di = decorLineDistance )
                    {
                          // Decorlinie
                        dyD2 = dy + si * di * yScale;
                        dxD2 = dx + co * di * xScale;
                        
                        dyD3 = dyUpper - si * di * yScale;
                        dxD3 = dxUpper - co * di * xScale;
                                               
                        dist = sqrt( dxD2*dxD2 + dyD2*dyD2);
                        distUpper = sqrt(dxD3*dxD3 +dyD3*dyD3);
                        
                        if( dist  <= distUpper && dist > di )
                        {
                            translate([dxD2,dyD2,-holderHeight/2+bottomHeight])
                            rotate([0,90,angle])
                            cylinder(d=drainHoleSize, h = innerBottomSize+1 ,center=true,$fn=32);                        
                            translate([dxD3,dyD3,-holderHeight/2+bottomHeight])
                            rotate([0,90,angle])
                            cylinder(d=drainHoleSize, h = innerBottomSize+1 ,center=true,$fn=32);
                       }
                    }
                   
                    
                    
                 }
                 
                 
                 // Kreisbogen Drain in der Mitte
                angle = endAngle + 90;
                        
                si = sin(angle);
                co = cos(angle);
                                        
                dx = vCenter.x + co * endR * xScale;
                dy = vCenter.y + si * endR * yScale;
                                
                translate([dx,dy,-holderHeight/2+bottomHeight])
                rotate([0,90,angle])
                cylinder(d=drainHoleSize, h = outerBottomSize+1 ,center=true,$fn=32);
                
                 // Decorlinie
                for( di = decorLineDistance )
                {
                    dyD = dy - si * di * yScale;
                    dxD = dx - co * di * xScale;
                    
                    translate([dxD,dyD,-holderHeight/2+bottomHeight])
                    rotate([0,90,angle])
                    cylinder(d=drainHoleSize, h = outerBottomSize+1 ,center=true,$fn=32);
                   
                
                }
                
         
             }
         }
    }
 
  //
  // Boden erzeugen
  //
  if( bottomHeight > 0 )
  {
    bottomOffset = -holderHeight/2+bottomHeight/2;
    bottomCircleSize = outerBottomSize * 0.9;
    hull()
    {
        for( n = [0:1: angleSteps] )
        {
            angle = startAngle + (endAngle-startAngle) *n / angleSteps;
            
            si = sin(angle);
            co = cos(angle);
                        
            f   = (angle - startAngle)/angleDelta;
            
            rUpper  = f * size;
                                   
            dxUpper = co * rUpper * xScale;
            dyUpper = si * rUpper * yScale-upperYOffset;
            
            upper = [dxUpper,dyUpper,bottomOffset];       
            translate(upper)
            cylinder(d=bottomCircleSize,h=bottomHeight,center=true);              

        }
        for( n = [0:1:circleSteps] )
        {
            angle = start + (end-start) *n / circleSteps;
                    
            si = sin(angle);
            co = cos(angle);
                              
            dx = vCenter.x + co * endR * xScale;
            dy = vCenter.y + si * endR * yScale;
            
            translate( [dx,dy,bottomOffset])
            cylinder(d=bottomCircleSize,h=bottomHeight,center=true);
           
        }
    }
   }
}
    