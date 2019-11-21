include <threads.scad>
 
  
  
flatBaseWidth = 100;//mm
flatBaseHeight = 4;//mm
flatBaseDepth = 50;
    
angleHeight = flatBaseHeight;
angleWidth = flatBaseWidth;
angleDepth = 40;

angleOfCut = 75;//This is the angle that matters

knifeWidth = 17.5;
knifeHeight = 38.7*2.4;
knifeDepth = 2;

knifeAngle = 45;

screwSlotSize = 2.5;//for 2.5mm bolt
screwSlotDepth = flatBaseHeight*2;
screwSlotLength = 58;

knifeShiftX = -10;


nutDepth = 1.85;//measured from nut

nutRelief = 5;//size of nut
nutInset = 0-(flatBaseHeight-nutDepth) - nutDepth/2;//space behind main face where the nut slides

//holes for offset 6/30 nuts- will need to tap

supportForScrewSize = 15;
supportForScrewSizeHeight = 10;
holeDiameter=.11*25.4;

zOffsetForHoles = 5;

 difference()
{
    union()
    {
        //base
        cube([flatBaseWidth, flatBaseDepth, flatBaseHeight], center=true);
        
        difference()
        {
        //angle support
            translate([0, -flatBaseDepth/2+angleDepth*sin(90-angleOfCut)/2, angleDepth*sin(angleOfCut)/2-angleHeight*sin(angleOfCut)/2])
            rotate([angleOfCut, 0, 0])
            cube([angleWidth, angleDepth, angleHeight], center=true);
            
            
        }
         //vertical support
        rotate([0, 0, 0])
        translate([0, -(flatBaseDepth/2-cos(angleOfCut)*angleDepth), angleDepth*sin(angleOfCut)/2])
        cube([flatBaseWidth, flatBaseHeight, angleDepth*sin(angleOfCut)], center=true);
     
        //cubes
        for (side = [-1 : 2 : 1])
        {    
            //threads for offset screws
            difference()
            {
            
            //support cube
                translate([xOffsetForHoles * side, flatBaseDepth/2-supportForScrewSize/2, zOffsetForHoles])
            
                cube([supportForScrewSize, supportForScrewSize, supportForScrewSizeHeight], center = true);
            
                //hole for threads
                xOffsetForHoles = flatBaseWidth/6*2;
                
                translate([xOffsetForHoles * side, flatBaseDepth/2, zOffsetForHoles])
                rotate([90, 0, 0])
                cylinder(h = supportForScrewSize, r1 = holeDiameter/2, r2 = holeDiameter/2, center = false, $fn = 60);
                //english_thread (diameter=.164, threads_per_inch=32, length=supportForScrewSize/25.4, center = false);
                             
                
            }
        }
        
        
    }
    
    //cuts
    union(){
        
        translate([0, 0, -flatBaseHeight])
        cube([flatBaseWidth, flatBaseDepth, flatBaseHeight], center=true);
    
    
        //holder for knife
        translate([knifeShiftX, -flatBaseDepth/2-flatBaseHeight/2 + knifeDepth/2, 0])
        rotate([90+angleOfCut, 0, 0])
        rotate([0, -knifeAngle, 0])
        cube([knifeWidth, knifeDepth, knifeHeight], center=true);
        union()
            {
                // slot for bolt
                translate([knifeShiftX, -flatBaseDepth/2-flatBaseHeight/2 + knifeDepth, 0])
                rotate([90+angleOfCut, 0, 0])
                rotate([0, -knifeAngle, 0])
                cube([screwSlotSize, screwSlotDepth, screwSlotLength], center=true);
                
                //holder for nut
                translate([knifeShiftX, -flatBaseDepth/2-flatBaseHeight/2 + knifeDepth, 0])
                rotate([90+angleOfCut, 0, 0])
                rotate([0, -knifeAngle, 0])
                translate([0, nutInset, 0])//move it back

                cube([nutRelief, nutDepth, screwSlotLength], center=true);
                
                
 
                   
            }        
    }
}


