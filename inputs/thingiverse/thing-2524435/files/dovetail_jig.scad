// this drives overall part length
cutCount = 5; // [3:10]
// this is a trade between durability/strength and tracing ease 
jigThickness = 6; // [3:10]
// this also drives the overall part length  
dovetailSpacing = 40; // [0:5:100]
// not really a ratio.  just experiment 
spacingToWidthMultiplier = 0.35;  
// also not a ratio
spacingToFenceHeightMultiplier = 0.4;  
// affects angle of dovetail edges - bigger number is more open
dovetailOpeningFactor = 4;  // [2:10]
// how far the solid side of the jig hangs over the edge of the wood
guideOverhang = 20;  // [0:5:100]
// This is just an "extra" factor to help with 3D object difference operations
cutOverlap = 0.2;  

jigLength = dovetailSpacing * (cutCount); 
dovetailWidth = dovetailSpacing * spacingToWidthMultiplier;
fenceHeight = dovetailSpacing * spacingToFenceHeightMultiplier;

union()
{
  cube([jigLength, jigThickness+guideOverhang, jigThickness]);
  difference()
  {
    cube([jigLength, jigThickness, jigThickness + fenceHeight]);
    union()
    {
      for(i = [0:1:cutCount])
      {
        // everything is shifted over by 1/2 spacing, then moved over one more slot per loop
        translate([(dovetailSpacing / 2) + dovetailSpacing * i, jigThickness + cutOverlap, jigThickness + ((dovetailWidth * dovetailOpeningFactor) / 2) + cutOverlap])
        {
          rotate([90, 0, 0])
          {
            // turn upright to aligh with the "fence"
            scale([1, dovetailOpeningFactor, 1])
            {
              // elongate triangle to cut out
              rotate([0, 0, 90])
              {
                // orient triangle sides with base flat on x-axis
                // "cylinder" with 3 faces is a triangle shaped "bar"
                cylinder(d = (dovetailWidth * 2), h = (jigThickness + (cutOverlap * 2)), $fn = 3);
              }
            } 
          }
        }
      }
    }
  }
}