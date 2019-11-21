/* [Bench Dimensions] */
benchWidth=2400;
benchDepth=1000;
// Including worksheet surface
benchHeight=952;
// Height of the lower platform, measured from the bottom, including the platform surface
braceHeight=313;
// Depth of the lower platform
braceDepth=572;

/* [Material Dimensions] */
// Thickness of the sheet used for the worksheet surfacce
topThickness=22;
// Thickness of the sheet used for the platform surface
braceTopThickness=18;

// Width of the beams used
beamWidth=44;
// Height of the beams used
beamHeight=95;

/* [Overhangs] */
// Is a front overhang desired?
frontOverhang=1; // [0,1]       
// Specify the depth of the front overhang. Minimum is 2x beamWidth. Will be rounded up to 2x beamWidth if lower is specified
frontOverhangDepth=0; 

// Is a rear overhang desired?
rearOverhang=1; // [0,1]  
// Specify the depth of the rear overhang. Minimum is 2x beamWidth. Will be rounded up to 2x beamWidth if lower is specified
rearOverhangDepth=150;    

/* [Stud Spacing] */
// Maximum distance between the small studs below the worksheet surface
smallStudSpacing=300;
// Maximum distance between the large studs below the worksheet surface
largeStudSpacing=500;
// Maximum distance between the studs below the platform surface
braceStudSpacing=500;

/* [Hidden] */
frontOverhangDepthReal = max(2*beamWidth,frontOverhangDepth)*frontOverhang;
rearOverhangDepthReal = max(2*beamWidth,rearOverhangDepth)*rearOverhang;
    
frameHeight = benchHeight - topThickness;
frameDepth = benchDepth - rearOverhangDepthReal - frontOverhangDepthReal;

braceStartX = braceHeight - beamHeight - braceTopThickness;   

///// stud orientation
hx=1*1;	// horizontal x
hy=2*1;	// horizontal y
v=3*1;	// vertical
/////


module stud(length=0, orient=v){
    echo(length=length);
	if (orient==hy) {
		cube([beamWidth,length,beamHeight]);
	} else if (orient==hx) {
		cube([length,beamWidth,beamHeight]);
	} else {
		cube([beamWidth,beamHeight,length]);
	}		
}


module leg() {
    echo("LEG");
    translate([beamWidth,0,0]) stud(frameHeight);
    translate([beamWidth,frameDepth-beamHeight,0]) stud(frameHeight);
    
    translate([0,0,braceStartX]) stud(frameDepth,orient=hy);
    
    topBeamYposStart = frontOverhang==0 ? 
        0 : 
        0-frontOverhangDepthReal+2*beamWidth;
    topBeamYposEnd = frontOverhang==0 ? 
        frameDepth : 
        frameDepth+rearOverhangDepthReal-2*beamWidth;
    translate([0,topBeamYposStart,frameHeight-beamHeight]) 
        stud(topBeamYposEnd-topBeamYposStart,orient=hy);
    
    translate([0,0,0]) stud(braceStartX);
    translate([0,frameDepth-beamHeight,0]) stud(braceStartX);
    
    translate([0,0,braceStartX+beamHeight]) stud(frameHeight-braceStartX-2*beamHeight);
    translate([0,frameDepth-beamHeight,braceStartX+beamHeight]) stud(frameHeight-braceStartX-2*beamHeight);
}

module topFrameBraces(xposStart=0, xposEnd=0, yposStart=0, yposEnd=0, studSpacing=0, bracesAtStartAndEnd=0) {
    bracesAreaWidth = xposEnd - xposStart;    
    noOfBraces = ceil(bracesAreaWidth / studSpacing)-1;
    bracesSpacing = bracesAtStartAndEnd == 0 ? 
        (bracesAreaWidth - noOfBraces * beamWidth) / (noOfBraces+1) : 
        (bracesAreaWidth - noOfBraces * beamWidth) / noOfBraces;    
    
    for(brace = [1:noOfBraces])
    {
        translate([xposStart + brace*bracesSpacing +(brace-1)*beamWidth,yposStart,0]) 
            stud(yposEnd-yposStart, orient=hy);
    }
    
    if (bracesAtStartAndEnd == 1) {
        translate([xposStart,yposStart,0]) stud(yposEnd-yposStart, orient=hy);
        translate([xposEnd-beamWidth,yposStart,0]) stud(yposEnd-yposStart, orient=hy);
    }
}

module topFrame() {
    echo("TOPFRAME");
    
    framePositionZ = frameHeight-beamHeight;
    
    // Inner beams
    translate([2*beamWidth,frontOverhangDepthReal + beamHeight,framePositionZ]) 
        stud(benchWidth-4*beamWidth, orient=hx);
    translate([2*beamWidth,frameDepth + frontOverhangDepthReal - beamWidth - beamHeight,framePositionZ]) 
        stud(benchWidth-4*beamWidth, orient=hx);
    
    // Front beam and braces
    if (frontOverhang==0){
        translate([3*beamWidth,0,framePositionZ]) 
            stud(benchWidth-6*beamWidth, orient=hx);
        
        translate([0,0,framePositionZ]) topFrameBraces(
            xposStart=3*beamWidth,
            xposEnd=benchWidth-3*beamWidth,
            yposStart=1*beamWidth,
            yposEnd=1*beamHeight,   
            studSpacing=smallStudSpacing);

    } else if (frontOverhangDepthReal==2*beamWidth) {
        translate([1*beamWidth,1*beamWidth,framePositionZ]) 
            stud(benchWidth-2*beamWidth, orient=hx);
        
        translate([0,0,framePositionZ]) 
            stud(benchWidth, orient=hx);
        
        translate([0,0,framePositionZ]) topFrameBraces(
            xposStart=3*beamWidth,
            xposEnd=benchWidth-3*beamWidth,
            yposStart=2*beamWidth,
            yposEnd=2*beamWidth+1*beamHeight,   
            studSpacing=smallStudSpacing);
        
    } else {
        translate([1*beamWidth,1*beamWidth,framePositionZ]) 
            stud(benchWidth-2*beamWidth, orient=hx);
        
        translate([0,0,framePositionZ]) 
            stud(benchWidth, orient=hx);
        
        translate([0,0,framePositionZ]) topFrameBraces(
            xposStart=3*beamWidth,
            xposEnd=benchWidth-3*beamWidth,
            yposStart=2*beamWidth,
            yposEnd=frontOverhangDepthReal+beamHeight,   
            studSpacing=smallStudSpacing,
            bracesAtStartAndEnd=1);
    }
    
    // Rear beam and braces
    if (rearOverhang==0){
        translate([3*beamWidth,benchDepth-beamWidth,framePositionZ]) 
            stud(benchWidth-6*beamWidth, orient=hx);
        
        translate([0,0,framePositionZ]) topFrameBraces(
            xposStart=3*beamWidth,
            xposEnd=benchWidth-3*beamWidth,
            yposStart=benchDepth-beamHeight,
            yposEnd=benchDepth-beamWidth,
            studSpacing=smallStudSpacing);
        
    } else if (rearOverhangDepthReal==2*beamWidth) {
        translate([1*beamWidth,benchDepth-2*beamWidth,framePositionZ]) 
            stud(benchWidth-2*beamWidth, orient=hx);
        
        translate([0,benchDepth-beamWidth,framePositionZ]) 
            stud(benchWidth, orient=hx);
        
        translate([0,0,framePositionZ]) topFrameBraces(
            xposStart=3*beamWidth,
            xposEnd=benchWidth-3*beamWidth,
            yposStart=benchDepth-beamHeight-2*beamWidth,
            yposEnd=benchDepth-2*beamWidth,   
            studSpacing=smallStudSpacing);
        
    } else {
        translate([1*beamWidth,benchDepth-2*beamWidth,framePositionZ]) 
            stud(benchWidth-2*beamWidth, orient=hx);
        
        translate([0,benchDepth-beamWidth,framePositionZ]) 
            stud(benchWidth, orient=hx);
        
        translate([0,0,framePositionZ]) topFrameBraces(
            xposStart=3*beamWidth,
            xposEnd=benchWidth-3*beamWidth,
            yposStart=benchDepth-rearOverhangDepthReal-beamHeight,
            yposEnd=benchDepth-2*beamWidth,   
            studSpacing=smallStudSpacing,
            bracesAtStartAndEnd=1);
    }
    
    // Inner braces
    translate([0,0,framePositionZ]) topFrameBraces(
        xposStart=2*beamWidth, 
        xposEnd=benchWidth-2*beamWidth, 
        yposStart=frontOverhangDepthReal + beamHeight+beamWidth, 
        yposEnd=frameDepth + frontOverhangDepthReal - beamWidth - beamHeight,
        studSpacing=largeStudSpacing);
    
    // Side braces
    ystart = frontOverhang==0 ? 0 : beamWidth;
    yend   = rearOverhang ==0 ? benchDepth : benchDepth - beamWidth;
    translate([0,ystart,framePositionZ]) stud(yend-ystart, orient=hy);
    translate([benchWidth-beamWidth,ystart,framePositionZ]) stud(yend-ystart, orient=hy);
        
    
}

module braceFrame() {
    echo("BRACEFRAME");
    framePositionZ = braceStartX;
    yposRear = frameDepth-beamHeight+frontOverhangDepthReal-beamWidth;
    yposFront = yposRear - braceDepth + beamWidth;
    
    translate([2*beamWidth,yposFront,framePositionZ])
        stud(benchWidth-4*beamWidth, orient=hx);
    
    translate([2*beamWidth,yposRear,framePositionZ])
        stud(benchWidth-4*beamWidth, orient=hx);
    
    translate([0,0,framePositionZ]) topFrameBraces(
            xposStart=2*beamWidth,
            xposEnd=benchWidth-2*beamWidth,
            yposStart=yposFront+beamWidth,
            yposEnd=yposRear,   
            studSpacing=braceStudSpacing);
}

module topDeck() {
    translate([0,0,benchHeight-topThickness])
        cube([benchWidth, benchDepth, topThickness]);
    
}

module braceDeck() {
    yposRear = frameDepth-beamHeight+frontOverhangDepthReal;
    yposFront = yposRear - braceDepth;
    
    braceDeckWidth = benchWidth-2*beamWidth;
    braceDeckDepth = yposRear-yposFront;
    
    echo(braceDeckWidth=braceDeckWidth);  
    echo(braceDeckDepth=braceDeckDepth);  
    
    translate([beamWidth,yposFront,braceHeight-braceTopThickness])
        cube([braceDeckWidth, braceDeckDepth, braceTopThickness]);
}


module bench() {
    translate([beamWidth,frontOverhangDepthReal,0]) leg();
    translate([benchWidth-beamWidth,frontOverhangDepthReal,0]) mirror([1,0,0]) leg();
    topFrame();
    braceFrame();
    topDeck();
    braceDeck();    
}

bench();
