

pinDepth = 3;
pinWidth = 8;
tailHeight = 8;

pinWidthFraction = 0.4;
pinHeightFraction = 0.9;

overhangDepth = 1;
overhangWidth = 2;

fitTolerance = 0.4;

cornerTrim = 0.4;

pinOrTail = "both"; // [pin,tail,both]


makeJoint();



module makeJoint()
{
    if( pinOrTail == "pin" )
    {
        DovetailPin( pinDepth, pinWidth, tailHeight, pinWidthFraction, pinHeightFraction, overhangDepth, cornerTrim );
    }
    else if( pinOrTail == "tail" )
    {
        DovetailTail( pinDepth, pinWidth, tailHeight, pinWidthFraction, pinHeightFraction, overhangDepth, overhangWidth, fitTolerance );
    }
    else
    {
        DovetailPin( pinDepth, pinWidth, tailHeight, pinWidthFraction, pinHeightFraction, overhangDepth, cornerTrim );

        DovetailTail( pinDepth, pinWidth, tailHeight, pinWidthFraction, pinHeightFraction, overhangDepth, overhangWidth, fitTolerance );
    }     
}



module DovetailPin( depth,
                    width,
                    height,
                    wedgeWidthFraction,
                    wedgeHeightFraction,
                    overhangDepth,
                    cornerTrim = 0 )
{
    rectangleWidth = width* (1-wedgeWidthFraction);

    //  Compute how much of the corners to trim off to improve fit
    
    angle = atan2((width - rectangleWidth)/2, depth );
    trimmedY = ((( width - rectangleWidth)/2) - cornerTrim ) / tan( angle );
    
    translate([0, depth/2, height*(1-wedgeHeightFraction)])   
    linear_extrude(height*wedgeHeightFraction)
    {
        polygon( points=[[-rectangleWidth/2,-depth/2],
                         [-rectangleWidth/2, -((depth/2) + overhangDepth)],
                         [rectangleWidth/2,  -((depth/2) + overhangDepth)],
                         [rectangleWidth/2,-depth/2],
                         [(width-cornerTrim)/2,trimmedY/2],
                         [(width-cornerTrim)/2,depth/2],
                         [-(width-cornerTrim)/2,depth/2],
                         [-(width-cornerTrim)/2,trimmedY/2]],
                 paths=[[0,1,2,3,4,5,6,7]]);    
    }
}



module DovetailTail( depth,
                     width,
                     height,
                     wedgeWidthFraction,
                     wedgeHeightFraction,
                     overhangDepth,
                     overhangWidth,
                     fitTolerance )
{
    difference()
    {
        translate([ 0, (depth+overhangDepth)/2, (height/2)])
        cube([width+(overhangWidth*2),depth+overhangDepth,height],true);
        
        scale([1+(fitTolerance/width),1+(fitTolerance/(4*depth)),1.0001])
        {
            DovetailPin( depth, width, height, wedgeWidthFraction, wedgeHeightFraction, overhangDepth );
        }
    }
}








