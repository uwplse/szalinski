/*
** Custamizable Spiral Soap holder 
**
** Created by Wolfgang Thomas
**
*/
// should be 36 or upper for generating a STL
$fn         =   12;
// should be 360 or upper generating an STL
angleSteps  =   360;
// $fn         =   36; // should be 36 or upper for generating a STL
// angleSteps  =   360;   // should be 360 or upper generating an STL

// the average height (mm) (will be less than this)
holderHeight = 17;

// radius for calculation - will be X and Y scaled
// average size of the spiral (mm)
maxRadius = 60;

// scaling to get an elliptic spriral
xScale = 1.0;       // [0.7,1.0]
yScale = 0.7;       // [0.7,1.0]

// thickness of the spiral at the bottom (mm)
bottomThickness = 3;
// thickness at top of spiral (mm) (should be less or equal bottom) 
// will be more than this because of cut
topThickness = 0.8;

// height of the bottom (mm) - if 0 there will be no bottom and drain holes will be generated
bottomHeight = 1.2;

cutDepthFactor = 0.2;
cutOffset = 9;

/* [Hidden] */

startAngle  = 0;
endAngle    =  360*3 + 180; // three rotation and end at the oppisite from start point

minRadius = 5;

angleDelta = endAngle/angleSteps;
radiusDelta = maxRadius - minRadius;

difference()
{
    union()
    {
        // Spiral generation
        for( angle1 = [0:angleDelta:endAngle-angleDelta])
        {
            angle2 = angle1+angleDelta;
            s1 = sin(angle1);
            c1 = cos(angle1);
            
            r1 = minRadius + radiusDelta * angle1 / endAngle;
            
            s2 = sin(angle2);
            c2 = cos(angle2);
            
            r2 = minRadius + radiusDelta * angle2 / endAngle;
            
            hull()
            {
                translate([c1 * r1 * xScale, s1 * r1 * yScale, 0 ])    
                cylinder( d1=bottomThickness, d2=topThickness,h= holderHeight,center = true);
                translate([c2 * r2 * xScale, s2 * r2 * yScale, 0 ])    
                cylinder( d1=bottomThickness, d2=topThickness,h= holderHeight,center = true);
            }
        }
        
         if(bottomHeight == 0.0 )
         {
           // spiral connection
            hull()
            {
                a1 = endAngle;
                c1 = cos(a1);
                r1 = minRadius + radiusDelta * a1 / endAngle;
                translate([c1 * r1 * xScale+0.5,0,-holderHeight/2])
                scale([1,1,2])
                sphere(r=bottomThickness/2);
         
                a2 = endAngle - 180;
                c2 = cos(a2);
                r2 = minRadius + radiusDelta * a2 / endAngle;
                
                translate([c2 * r2 * xScale-0.5,0,-holderHeight/2])
                scale([1,1,2])
                sphere(r=bottomThickness/2);
            }
        }
        
        //
        // bottom
        //
        if(bottomHeight > 0.0 )
        {
            hull()
            {
                for( angle1 = [endAngle:-angleDelta:endAngle-360])
                {
                    s1 = sin(angle1);
                    c1 = cos(angle1);
                    
                    r1 = minRadius + radiusDelta * angle1 / endAngle;
                   
                    translate([ c1 * r1 * xScale, 
                                s1 * r1 * yScale, 
                                -holderHeight/2 + bottomHeight/2 ])    
                    cylinder( d=bottomThickness-0.2,,h= bottomHeight,center = true);

                }
            }
        }
       
    }
    union()
    {
        // Top soap center cut
        cutSphereSize = maxRadius + 10;
        
        translate([0,0,holderHeight+1-cutSphereSize*cutDepthFactor+ cutOffset])
        scale([xScale,yScale,cutDepthFactor])
        sphere(r=cutSphereSize,$fn=36);
        
       
        
        if(bottomHeight == 0.0 )
        {
            // buttom cut
            translate( [0,0,-(maxRadius/2+holderHeight/2)])
            cube([  maxRadius*2*xScale+bottomThickness+1,
                    maxRadius*2*yScale+bottomThickness+1,
                    maxRadius],center = true);
                 // drain center cut
            hull()
            {
            a1 = endAngle-90;
            s1 = sin(a1);
            r1 = minRadius + radiusDelta * a1 / endAngle;
            translate([0,s1 * r1 * yScale+5,-holderHeight/2])
            scale([1,1,0.7])
            sphere(r=bottomThickness/2);
     
            a2 = endAngle-90 - 180;
            s2 = sin(a2);
            r2 = minRadius + radiusDelta * a2 / endAngle;
            
            translate([0,s2 * r2 * xScale-5,-holderHeight/2])
            scale([1,1,0.7])
            sphere(r=bottomThickness/2);
            }
            
            for( angle1 = [0:180:endAngle])
            {
                angle2 = angle1+360;
                
                s1 = sin(angle1);
                c1 = cos(angle1);
                
                r1 = minRadius + radiusDelta * angle1 / endAngle;
                
                s2 = sin(angle2);
                c2 = cos(angle2);
                
                r2 = minRadius + radiusDelta * angle2 / endAngle;
               
                v1 = c1 * r1 * xScale;
                v2 = c2 * r2 * xScale;
                
                translate([(v1+v2)/2, 0, -holderHeight/2 ]) 
                rotate([90,0,0])
                cylinder(r=bottomThickness*0.7/2,h=bottomThickness,center=true);
                
            }
        }
        
    }
}