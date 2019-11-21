// preview[view:south, tilt:top]

/* [Shelves] */

shelf_count = 2;            // [1:1:10]
shelf_depth = 3;            // [0:0.25:12]
shelf_height = 1;           // [0:0.25:12]
shelf_length = 12;          // [0:1:120]
generate_shelf = "no";      // [yes,no]

/* [Bracket] */

bracket_thickness = .25;    // [0.25:0.25:2]
bracket_width = .5;         // [0.25:0.25:6]
step_height = 2;            // [0:0.25:12]
screw_holes = 2;            // [0:1:16]
generate_bracket = "yes";   // [yes,no]

{
    mmPadding = 1;
    mmPerInch = 25.4;
    mmShelfDepth = shelf_depth*mmPerInch;
    mmShelfDepthCut = mmShelfDepth+mmPadding;
    mmShelfHeight = shelf_height*mmPerInch;
    mmShelfHeightCut = mmShelfHeight+mmPadding;
    mmShelfLength = shelf_length*mmPerInch;
    mmStepHeight = max(mmShelfHeightCut, step_height*mmPerInch);
    mmBracketThick = bracket_thickness*mmPerInch;
    mmBracketWidth = bracket_width*mmPerInch;
    mmScrewShaft = 3.75;
    mmScrewHead = 8.5;
    mmScrewHeight = 3.5;
    mmScrewPadding = mmPadding*4+mmScrewHead/2;
    mmScrewRange = mmShelfDepth-mmScrewPadding*2;
    
    {
        bracketHeight = mmBracketThick*2+mmStepHeight*shelf_count;
        bracketBottom = -bracketHeight/2;

        // bracket
        if (generate_bracket == "yes") {
            union() {
                sectionWidth = mmShelfDepthCut+mmBracketThick;
                bracketWidth = sectionWidth*shelf_count+mmBracketThick;
                bracketLeft = -bracketWidth/2;
                
                for (section = [0:shelf_count-1]) {
                    sectionLeft = bracketLeft+section*sectionWidth;
                    sectionStep = (section+1)*mmStepHeight;
                    sectionHeight = mmBracketThick*2+sectionStep;
                    sectionTop = bracketBottom+sectionHeight;
                    supportTop = sectionTop-mmShelfHeightCut-mmBracketThick;
                    
                    translate([sectionLeft,bracketBottom,0]) {
                        // bottom
                        cube([sectionWidth,mmBracketThick,mmBracketWidth]);
                        // left
                        cube([mmBracketThick,sectionHeight,mmBracketWidth]);
                    }
                    translate([sectionLeft,supportTop-mmBracketThick,0]) {
                        // support
                        cube([sectionWidth,mmBracketThick,mmBracketWidth]);
                    }
                    translate([sectionLeft,sectionTop-mmBracketThick,0]) {
                        difference() {
                            // top
                            cube([sectionWidth,mmBracketThick,mmBracketWidth]);
                            
                            // screws
                            screwLeft = mmBracketThick+mmPadding/2+mmScrewPadding;
                            screwFlush = mmBracketThick-mmScrewHeight/2;
                            screwCenter = mmBracketWidth/2;
                            translate([screwLeft,screwFlush,screwCenter]) {
                                for (screw = [0:screw_holes-1]) {
                                    screwOffset = screw_holes == 1
                                        ? mmScrewRange/2
                                        : mmScrewRange/(screw_holes-1)*screw;
                                    translate([screwOffset,0,0]) {
                                        rotate([270,0,0]) {
                                            cylinder(d1=mmScrewShaft,d2=mmScrewHead,h=mmScrewHeight,center=true);
                                            translate([0,0,-mmBracketThick/2+mmScrewHeight/4]) {
                                                cylinder(d=mmScrewShaft,h=mmBracketThick,center=true);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                translate([-bracketLeft-mmBracketThick,bracketBottom,0]) {
                    // right
                    cube([mmBracketThick,bracketHeight,mmBracketWidth]);
                }
            }
        }            
        
        // shelf
        if (generate_shelf == "yes") {
            shelfOffset = generate_bracket == "yes"
                ? bracketBottom-mmShelfDepth/2-mmBracketThick
                : mmShelfDepth/2;
            translate([0,shelfOffset,mmShelfHeight/2]) {
                difference() {
                    // shape
                    cube([mmShelfLength,mmShelfDepth,mmShelfHeight],center=true);
                    translate([0,0,mmBracketThick/2]) {
                        // hollow
                        cube([mmShelfLength,mmShelfDepth-mmBracketThick*2,mmShelfHeight],center=true);
                    }

                    // screws
                    for(side = [-1,1]) {
                        screwSide = (mmShelfLength/2-mmBracketThick)*side;
                        screwBottom = -mmShelfDepth/2+mmScrewPadding;
                        for(screw = [0:screw_holes-1]) {
                            screwPos = screw_holes==1 ? 0 : screwBottom+mmScrewRange/(screw_holes-1)*screw;
                            translate([screwSide,screwPos,0]) {
                                cylinder(d=mmScrewShaft,h=mmShelfHeight,center=true);
                            }
                        }
                    }
                }
            }
        }
    }
}