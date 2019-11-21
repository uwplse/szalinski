$fn = 24;

baseWidth = 170;
baseHeight =7;
numSliders = 12;
doveAngle = 7.50;

sliderHeight = 0.6*baseHeight;
sliderWidth = 3.4;

topThick = 6;
pegLength = 0.6*topThick;

angleInc = 180/numSliders;

minGap = .04;
minWidth = 0.2;

pegR = sliderWidth/2-sliderHeight*tan(doveAngle);
ringR = 5;

sliderLength = 4.5*pegR*sin(90-90/numSliders)/sin(180/numSliders);

buildBase = true;
buildSliders = true;
buildTop = true;


// seemed useful to have circR available globally
// since it's used for pegs and sliders
sine = sin(30);
cose = cos(30);
circR = sliderHeight/(2*sine);


innerR = 2*pegR/sin(angleInc) * sin(90-angleInc/2)
          + minWidth/(2*tan(angleInc/2));

//
//trying to figure out how to auto-size the length of the sliders so they dont hit and dont fall out...
//
//innerR=2*pegR/sin(angleInc)*sin(90-angleInc/2);
//innerLipR = (circR)/sin(angleInc)*sin(90-angleInc/2);
//sliderLength = (4*innerR+innerLipR)/2.5;

   
module mirrorDup(dupVec){
    union(){
        children();
        mirror(dupVec) children();
    }
}


module onePeg(slot=false, addon = 0)
{
 render() intersection()
 {   
  cylinder(h=pegLength+addon, r=pegR+addon);
  difference()
  {
    union()
    {
        cylinder(h=0.3*pegLength, r=pegR+addon);
        translate([0, 0, 0.3*pegLength]) scale([1,1,1.3]) sphere(pegR+addon);
        translate([0, 0, 0.3*pegLength+1.5*pegR]) scale([1,1,.8]) sphere(pegR+addon);
    }
    
    if(slot) translate([0,0,0.7*pegLength]) cube([pegR/2.5,pegR*2.1,pegLength],center=true);
  }
 }
}

module oneSlider(length = sliderLength, 
                 addOn = 0,
                 roundBottomCorners = true, 
                 pegToo = true)
{
    roundR = roundBottomCorners ? 
                sqrt(pow(pegR*2,2)+pow(length/2,2)) 
                : sqrt(pow(circR,2)+pow(length/2,2));
    roundScale = roundBottomCorners ? 1.2/sqrt(numSliders-1) : 1;
    
    
render() intersection()
{ 
  if(roundBottomCorners)
  scale([roundScale,1,1])
    cylinder(h=sliderHeight, r = roundR);
  
  translate([0, 0, sliderHeight/2])
   difference()
    {
      cube([sliderWidth+addOn, length, sliderHeight], center=true);

      translate([-(0.5+cos(doveAngle))*sliderWidth-addOn, 
                 -(length+2)/2,
                 sin(doveAngle)*sliderWidth-sliderHeight/2]) 
        rotate([0, doveAngle, 0]) 
          cube([sliderWidth, length+2, sliderHeight*2]);
  
      translate([sliderWidth/2+addOn, 
                -(length+2)/2,
                -sliderHeight/2]) 
        rotate([0, -doveAngle, 0]) 
          cube([sliderWidth, length+2, sliderHeight*2]);
    }
}

    if(pegToo)
      translate([0,0,sliderHeight])
        onePeg(slot = true);
 
}

module basePlate()
{
    extraAng = floor(numSliders/2)==numSliders/2 ? 0 : angleInc/2;
    difference()
    {
        //could use any shape of appropriate width for the sliders
        translate([0,0,sliderHeight-baseHeight-minGap]) 
            cylinder(h=baseHeight, r = baseWidth/2);
        
        //subtract grooves for sliders
        rotate([0,0,extraAng])
        for( k = [0:numSliders-1] )
          rotate([0, 0, k*angleInc]) 
            oneSlider(length = baseWidth+2, 
                      addon = minGap,
                      roundBottomCorners = false, 
                      pegToo=false);
        
        //subtract middle cylinder
        cylinder(h=baseHeight+1, r=innerR);
    }
}

module sliders()
{
    for( k = [0:numSliders-1] )
        rotate([0,0,k*angleInc])
            translate([((baseWidth-sliderLength)/2)*cos(angleInc*(k)),0,0])
                rotate([0,0,90]) oneSlider();
}


module roundTopCrank()
{
    
            armLength = baseWidth/2;
    difference()
    {
        union()
        {   // start with outer cylinder
            cylinder(h=topThick, r=(baseWidth-sliderLength)/4+2*pegR);
            
            //add crank arm
            translate([armLength-sliderLength/4,0,topThick/2]) 
            {
                render() intersection()
                {
                    cube([armLength, 5*pegR, topThick],center=true);
                    scale([armLength, 3*pegR, .65*topThick]) sphere(1);
                }
             
            //add outer cylinder for  Finger Ring (for fingering!)
             translate([armLength/2+ringR,0,0])
                cylinder(h=topThick, r = ringR+2*pegR,center=true);
            }
        }
        
        
        //subtract center cylinder
        cylinder(h=2.1*topThick, r=(baseWidth-sliderLength)/4-2*pegR,center=true);
 
 
        //subtract inner cylinder for Finger Ring (for fingering!)
        translate([0.75*baseWidth-sliderLength/4+ringR,0,topThick/2])
           cylinder(h=topThick+2, r = ringR,center=true);
       
        //subtract holes for pegs
        for( k = [0:numSliders-1] )
         translate([(baseWidth-sliderLength)/4*cos(2*k*angleInc),
                    (baseWidth-sliderLength)/4*sin(2*k*angleInc),
                    -minGap]) 
           onePeg(addon=minGap);
    }
}
//oneSlider();
if(buildBase) basePlate();
if(buildSliders) sliders();
if (buildTop) translate([+baseWidth/4-sliderLength/4,0,baseHeight/2+minGap])
roundTopCrank();
