// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Author: Jetty, 10th December, 2015
// Parametric AA Battery Box With Contacts
//

// preview[view:north, tilt:top diagonal]

// Customizer parameters
part                            = "holder";        // [holder:Holder, cover:Cover, all:All Parts]
cells                           = 4;            // [1:50]
mounting_lugs                   = "topbottom";  // [topbottom, sides, none]
mounting_lug_screw_diameter     = 3;            // [1:0.1:9]
mounting_lug_thickness          = 4;            // [0.5:0.1:10]
center_channel_width            = 3.0;          // [0.2:0.1:7.0]
other_channel_width             = 2.5;          // [0.2:0.1:5.0]
coverRetainerClearance          = 0.1;          // [0.0:0.05:0.3]
nozzle_diameter                 = 0.4;          // [0.05:0.05:0.7]



/* [Hidden] */
// DO NOT CHANGE THESE
AACellLength                    = 50.5;     // 49.2 - 50.5mm nominal
AACellDiameter                  = 14.5;     // 13.5 - 14.5mm nominal
bottomThickness                 = 3;
endThickness                    = 2;
sideThickness                   = 0.5;
endSideThickness                = 2.0;
negContactLength                = 4.5;        // This is the length when the spring is compressed
posContactLength                = 1.55;
cellBarrelLength                = AACellLength + negContactLength + posContactLength;
singleCellHolderDimensions      = [AACellDiameter + sideThickness * 2, cellBarrelLength + endThickness * 2, AACellDiameter / 2 + bottomThickness];
textSize                        = 8;
textDepth                       = 1.20;
textOffsetPosTop                = [0, AACellLength / 2 - 5, bottomThickness];
textOffsetPosBottom             = [textOffsetPosTop[0], -textOffsetPosTop[1], textOffsetPosTop[2]];
contactDimensions               = [10.8, nozzle_diameter + 0.1, 13.2];
contactRetainerThickness        = 0.82;
contactClearance                = 8.8;
contactThickness                = 1.23;
contactRetainerDimensions       = [ singleCellHolderDimensions[0],
                                    contactDimensions[2],
                                    endThickness + contactDimensions[1] + contactRetainerThickness];
contactRetainerCornerRadius     = 3.0;
contactLugDimensions            = [3.2, contactDimensions[1], 8.7];
mountLugInset                   = 12;
mountLugThickness               = 4;
mountingLugScaling              = 1.25;    
undersideChannellingThickness   = bottomThickness - 1;
lugVoidLength                   = (contactLugDimensions[2] - (bottomThickness - undersideChannellingThickness)) + 1;
lugVoidWidth                    = contactLugDimensions[0] + 1;
coverThickness                  = 0.27 * 3;
coverDifferenceDimensions       = [(singleCellHolderDimensions[0] * cells + endSideThickness * 2) * 2,
                                   singleCellHolderDimensions[1] * 2,
                                   (contactRetainerDimensions[1] + bottomThickness) * 2];
holderCoverSpacing              = 3;
coverRetainerDiameter           = 3;
coverRetainerOffset             = [ other_channel_width / 2 + coverRetainerDiameter / 2 + 1.25,
                                    singleCellHolderDimensions[1] / 2 - (coverRetainerDiameter / 2 + 1),
                                    0];
coverRetainerHeight             = undersideChannellingThickness;
coverRetainerVerticalClearance  = 0.5;



$fn = 80;
manifoldCorrection = 0.02;



if  ( part == "holder" )
{
    holder();
}

if  ( part == "cover" )
{
    translate( [0, 0, coverThickness] )
        cover();
}

if  ( part == "all" )
{
    all();
}



module coverRetainer()
{
    translate( [0, 0, coverRetainerHeight / 2] )
        cylinder( r=coverRetainerDiameter / 2, h=coverRetainerHeight - coverRetainerVerticalClearance, center = true );
}



module coverRetainerVoid()
{
    translate( [0, 0, coverRetainerHeight / 2 + manifoldCorrection] )
        cylinder( r=(coverRetainerDiameter + coverRetainerClearance) / 2, h=coverRetainerHeight + manifoldCorrection * 2, center = true );
}



module all()
{
    rotate( [0, 0, 90] )
    {
        lugsTranslateY = ( mounting_lugs == "topbottom" ) ? 
                                (-( (mounting_lug_screw_diameter * mountingLugScaling * mountingLugScaling) * 2 + 
                                    (mounting_lug_screw_diameter * mountingLugScaling) * 2))
                                                          : 0;
        
        translate( [0, singleCellHolderDimensions[1] / 2 -(lugsTranslateY - holderCoverSpacing)/ 2, 0] )
        {
            holder();
            translate( [0, -singleCellHolderDimensions[1], coverThickness] )
                translate( [0, lugsTranslateY, 0] )
                    translate( [0, -holderCoverSpacing, 0] )
                        cover();
        }
    }
}



module holder()
{
    difference()
    {
        multipleCells(cells, mounting_lugs);

        translate( [0, 0, -coverDifferenceDimensions[2] / 2 + manifoldCorrection] )
            cube( coverDifferenceDimensions, center = true );
    }
}



module cover()
{
    difference()
    {
        multipleCells(cells, mounting_lugs);
        
        translate( [0, 0, coverDifferenceDimensions[2] / 2 - manifoldCorrection] )
            cube( coverDifferenceDimensions, center = true );
        

    }

    // Cover retainers            
    translate( [0, 0, -manifoldCorrection] )
        multipleCellsRetainersOnly(cells);
}



module coverPlateBlock()
{
    translate( [0, 0, - coverThickness / 2] )
        cube( [singleCellHolderDimensions[0] * cells + endSideThickness * 2, singleCellHolderDimensions[1], coverThickness], center = true );
}


module lugVoid()
{
    translate( [0, -(lugVoidLength - lugVoidWidth / 2) + manifoldCorrection, 0] )
    {
        cylinder( r=lugVoidWidth / 2, h=undersideChannellingThickness, center = true );
        translate( [0, (lugVoidLength - lugVoidWidth / 2) / 2, 0] )
            cube( [lugVoidWidth, lugVoidLength - lugVoidWidth / 2, undersideChannellingThickness], center = true );
    }
}



module horizontalChannel(width)
{
    cube( [singleCellHolderDimensions[0] + manifoldCorrection * 2, width, undersideChannellingThickness], center = true );
}



module verticalChannel(width)
{
    cube( [width, singleCellHolderDimensions[1] - (endThickness + contactDimensions[1]) * 2, undersideChannellingThickness], center = true );
}



module undersideTabsAndChanneling()
{
    translate( [0, 0, undersideChannellingThickness / 2 - manifoldCorrection] )
    {
        translate( [0, singleCellHolderDimensions[1] / 2 - endThickness - contactDimensions[1], 0] )
        {
            lugVoid();
            
            // Lug Void Side Channel
            translate( [0, -(lugVoidLength - (other_channel_width / 2 + lugVoidWidth / 4)), 0] )
                horizontalChannel(other_channel_width);
        }

        translate( [0, -(singleCellHolderDimensions[1] / 2 - endThickness - contactDimensions[1]), 0] )
        {
            rotate( [180, 0, 0] )
                    lugVoid();
            
            // Lug Void Side Channel
            translate( [0, (lugVoidLength - (other_channel_width / 2 + lugVoidWidth / 4)) , 0] )
                horizontalChannel(other_channel_width);
        }
        
        // Center Channel
        horizontalChannel(center_channel_width);
        
        // Vertical Channel
        verticalChannel(other_channel_width);
    }
}



module mountingLug()
{
    translate( [-mounting_lug_screw_diameter * mountingLugScaling * mountingLugScaling, 0, - coverThickness] )
        difference()
        {
            union()
            {
                cylinder( r=mounting_lug_screw_diameter * mountingLugScaling, h=mounting_lug_thickness + coverThickness );
                translate( [0, -mounting_lug_screw_diameter * mountingLugScaling, 0] )
                    cube( [ mounting_lug_screw_diameter * mountingLugScaling * mountingLugScaling,
                            mounting_lug_screw_diameter * mountingLugScaling * 2,
                            mounting_lug_thickness + coverThickness] );

            }
            translate( [0, 0, -manifoldCorrection] )
                cylinder( r=mounting_lug_screw_diameter / 2, h=mounting_lug_thickness + coverThickness + manifoldCorrection * 2 );
        }
}


module multipleCells(cellCount, mounting_lugs)
{
    if ( mounting_lugs == "sides" )
    {
        translate( [- ((cellCount * singleCellHolderDimensions[0]) + endSideThickness * 2) / 2, 0, 0] )
        {
            translate( [0, singleCellHolderDimensions[1] / 2 - (mountLugInset + mounting_lug_screw_diameter), 0] )
                mountingLug();
            translate( [0, -(singleCellHolderDimensions[1] / 2 - (mountLugInset + mounting_lug_screw_diameter)), 0] )
                mountingLug();
        }

        translate( [((cellCount * singleCellHolderDimensions[0]) + endSideThickness * 2) / 2, 0, 0] )
        {
            translate( [0, singleCellHolderDimensions[1] / 2 - (mountLugInset + mounting_lug_screw_diameter), 0] )
                rotate( [0, 0, 180] )
                    mountingLug();
            translate( [0, -(singleCellHolderDimensions[1] / 2 - (mountLugInset + mounting_lug_screw_diameter)), 0] )
                rotate( [0, 0, 180] )
                    mountingLug();
        }
    }
        
    translate( [- ((cellCount * singleCellHolderDimensions[0]) + endSideThickness * 2) / 2, 0, 0] )
        translate( [endSideThickness, 0, 0,] )
            for ( c = [0:cellCount-1] )
            {
                // Adds thin side bar on the left
                translate( [0, -singleCellHolderDimensions[1] / 2, 0] )
                {
                    if ( c == 0 )
                    {
                        translate( [-endSideThickness, 0, 0] )
                            sideBar();
                    }
                    
                    // Adds thin side bar on the right
                    if ( c == (cellCount - 1) )
                    {
                         translate( [singleCellHolderDimensions[0] + c * singleCellHolderDimensions[0], 0, 0] )
                            sideBar();
                    }
                }
                
                translate( [singleCellHolderDimensions[0] / 2 + c * singleCellHolderDimensions[0], 0, 0] )
                    singleCell( (cellCount == 1 ) ? "both" : ((c == 0) ? "left" : ((c == cellCount-1) ? "right" : "none")), c);
                
                if ( mounting_lugs == "topbottom" && ( c == 0 || c == (cellCount - 1)) )
                {
                    translate( [singleCellHolderDimensions[0] / 2 + c * singleCellHolderDimensions[0], -singleCellHolderDimensions[1] / 2, 0] )
                        rotate( [0, 0, 90] )
                            mountingLug();
                    translate( [singleCellHolderDimensions[0] / 2 + c * singleCellHolderDimensions[0], singleCellHolderDimensions[1] / 2, 0] )
                        rotate( [0, 0, -90] )
                            mountingLug();
                }
            }
            
    // Cover plate
    coverPlateBlock();
}



module multipleCellsRetainersOnly(cellCount)
{
    translate( [- ((cellCount * singleCellHolderDimensions[0]) + endSideThickness * 2) / 2, 0, 0] )
        translate( [endSideThickness, 0, 0,] )
            for ( c = [0:cellCount-1] )
            {
                translate( [singleCellHolderDimensions[0] / 2 + c * singleCellHolderDimensions[0], 0, 0] )
                    singleCellRetainersOnly();                
            }
}



module sideBar()
{
    difference()
    {
        cube( [ endSideThickness,
                singleCellHolderDimensions[1],
                contactRetainerDimensions[1] + bottomThickness - contactRetainerCornerRadius] );

        // The cylinder cutout for fingers - Commented out for structural reasons
        //translate( [sideThickness/2, singleCellHolderDimensions[1] / 2, AACellDiameter / 2 + bottomThickness + 5] )
        //    rotate( [0, 90, 0] )
        //        cylinder( r=AACellDiameter / 2, h = sideThickness + manifoldCorrection * 2, center = true );

        // Center Channel
        translate( [0, singleCellHolderDimensions[1] / 2, undersideChannellingThickness / 2 - manifoldCorrection] )
            horizontalChannel(center_channel_width);
    }
}



module singleCell(corners, index)
{
    difference()
    {
        union()
        {
            // The retainer blocks
            translate( [0, 0, -manifoldCorrection] )
            {
                translate( [0, (singleCellHolderDimensions[1] - contactRetainerDimensions[2]) / 2, 0] )
                    retainerBlock(contactRetainerDimensions, contactRetainerCornerRadius, corners);
                translate( [0, - (singleCellHolderDimensions[1] - contactRetainerDimensions[2]) / 2, 0] )
                    retainerBlock(contactRetainerDimensions, contactRetainerCornerRadius, corners);
            }
        
            difference()
            {
                // The box for the cell
                translate( [0, 0, singleCellHolderDimensions[2] / 2] )
                    cube( singleCellHolderDimensions, center = true );
                
                // The cylinder cutout for the box
                translate( [0, 0, AACellDiameter / 2 + bottomThickness] )
                    rotate( [-90, 0, 0] )
                        cylinder( r=AACellDiameter / 2, h = cellBarrelLength, center = true );

                // The cylinder cutout for fingers
                translate( [0, 0, AACellDiameter / 2 + bottomThickness] )
                    rotate( [0, 90, 0] )
                        cylinder( r=AACellDiameter / 2, h = singleCellHolderDimensions[0] + manifoldCorrection * 2, center = true );
                
                // The positive mark text
                translate( ( index % 2 == 0 ) ? textOffsetPosTop : textOffsetPosBottom )
                    linear_extrude( height=textDepth, center=true)
                        text("+", font="Helvetica:Bold", valign="center", halign="center", size=textSize);
            }  
        }
        
        // The contact voids
        translate( [0, 0, bottomThickness] )
        {
            translate( [0, -(singleCellHolderDimensions[1] / 2 - endThickness), 0] )
                contact();

            translate( [0, singleCellHolderDimensions[1] / 2 - endThickness, 0] )
                rotate( [0, 0, 180] )
                    contact();
        }
        
        // Underside tabs and channelling
        undersideTabsAndChanneling();
        
        // Cover retainer voids
        translate( coverRetainerOffset )
            coverRetainerVoid();
        translate( - coverRetainerOffset )
            coverRetainerVoid();
        translate( [-coverRetainerOffset[0], coverRetainerOffset[1], coverRetainerOffset[2]] )
            coverRetainerVoid();
        translate( [coverRetainerOffset[0], -coverRetainerOffset[1], coverRetainerOffset[2]] )
            coverRetainerVoid();
    }
}



module singleCellRetainersOnly()
{
    // Cover retainers
    translate( coverRetainerOffset )
        coverRetainer();
    translate( - coverRetainerOffset )
        coverRetainer();
    translate( [-coverRetainerOffset[0], coverRetainerOffset[1], coverRetainerOffset[2]] )
        coverRetainer();
    translate( [coverRetainerOffset[0], -coverRetainerOffset[1], coverRetainerOffset[2]] )
        coverRetainer();
}



// Creates a retainer block, if corners="left", rounded corner is on the left
// if corners="right", rounded corner is on the right
// if corners="none", there are no rounded corners, it's rectangular

module retainerBlock(dimensions, radius, corners)
{
    translate( [0, 0, dimensions[1] / 2 + bottomThickness] )
        rotate( [90, 0, 0] )
            hull()
            {
                // Top Left corner
                translate( [-dimensions[0] / 2 + radius - endSideThickness, dimensions[1] / 2 - radius, 0] )
                {
                    if ( corners == "left" || corners == "both" )    cylinder( r=radius, h = dimensions[2], center = true );
                    else                                             cube( [radius * 2, radius * 2, dimensions[2]], center = true );
                }
                
                // Top Right corner
                translate( [dimensions[0] / 2 - radius + endSideThickness, dimensions[1] / 2 - radius, 0] )
                {
                    if ( corners == "right" || corners == "both" )   cylinder( r=radius, h = dimensions[2], center = true );
                    else                                             cube( [radius * 2, radius * 2, dimensions[2]], center = true );
                }
                
                // Bottom Corners
                translate( [0, -(dimensions[1] / 2 - radius), 0] )
                {
                    // Bottom left corner
                    translate( [-(dimensions[0] / 2 - radius) - (( corners == "left" || corners == "both" ) ? sideThickness : 0), 0, 0] )
                        cube( [radius * 2, radius * 2, dimensions[2]], center = true );

                    // Bottom right corner
                    translate( [dimensions[0] / 2 - radius + (( corners == "right" || corners == "both" ) ? sideThickness : 0), 0, 0] )
                        cube( [radius * 2, radius * 2, dimensions[2]], center = true );
                }            
        }
}

    

module contact()
{
    translate( [0, contactDimensions[1] / 2, 0] )
    {
        // Main plate
        translate( [0, 0, contactDimensions[2] / 2] )
            cube( contactDimensions, center = true );
        
        // Solder Lug
        translate( [0, 0, -(contactLugDimensions[2] / 2 - manifoldCorrection)] )
        {
            cube( contactLugDimensions, center = true);
            //translate( [0, (contactLugDimensions[2] - 1) / 2, contactLugDimensions[2] / 2 - 2 + contactLugDimensions[1] / 4 ] )
              //  % cube( [contactLugDimensions[0], contactLugDimensions[2] - 1, contactLugDimensions[1]], center = true );
        }

        // Contact and opening
        translate( [0, contactThickness / 2, contactDimensions[2] / 2] )
            rotate( [90, 0, 0] )
            {
                // Contact
                cylinder( r=contactClearance / 2, h=contactThickness, center=true );
                
                // Contact opening
                translate( [0, contactRetainerDimensions[1] / 4, 0] )
                    cube( [contactClearance, contactRetainerDimensions[1] / 2, contactThickness], center = true );
            }
    }
}
