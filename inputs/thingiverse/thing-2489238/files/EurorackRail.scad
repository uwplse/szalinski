railHp = 54;//the length of a rail in hp
hp = 5.08;//represents of the width in mm of each unit of hp; defaults to Eurorack standard (5.08)

slidingNutHeight = 5.4; //the height of the nut; defaults to the height of a common m3 square nut (5.4)

slidingNutThickness = 2.4; //The thickness/depth of the nut, back to front; defaults to the size of a common m3 square nut (2.4)

slidingNutMargin = .2;//margin added to the thickness of the nut for fit tolerance

railGapHeight = 3.4;//The gap in the rail through which the nuts are visible

railFrontThickness = 2.25; //The thickness of the part of the rail between the front of the rail and the nuts

railBackThickness = 45;//The thickness of the rail "behind" the nuts; thicker is presumably sturdier and less prone to bending; should be thick enough to accommodate more than 2x bracketNutHeight
railHeight = 11;//The overall height of the rail, "top" to "bottom"; should be considerably greater than the bracket nut height

railMargin = 0;//A little extra length to each side of the rail, as needed

bracketNutHeight = 9.8; //The height of the nut securing the rail to the bracket; defaults to common m6 square nut (9.8)
bracketNutThickness = 4.6;//The thickness of the bracket nut; defaults to a common m6 square nut (4.6)
bracketNutInset = 8; //How "deep" into the rail is the nut inset; longer screws will require a greater value
bracketNutMargin =.35;//A margin around the bracket nut for fit tolerance; This nut ought to fit fairly snugly
bracketScrewHoleDiameter = 6.1; //The diameter of the bracket screw; defaults to typical m6 diameter (6.1)

railDepth = railFrontThickness+slidingNutMargin*2+railBackThickness;
railLength = railHp*hp+railMargin*2;

echo("rail depth: ", railDepth);
echo("rail length: ", railLength);

rail();

module rail()
{
    difference()
    {
        railBase();
        translate([railHeight/2,-1,railLength/2-.5]){
            railDiff();
        }   
        
        translate([railHeight/2,railDepth/2,railLength - (bracketNutInset+((bracketNutThickness+bracketNutMargin*2)/2))]){
     bracketNutDiff();
        }
        

translate([railHeight/2,railDepth/2,(bracketNutInset+((bracketNutThickness+bracketNutMargin*2)/2))]){
    rotate([180,0,0]){
     bracketNutDiff();
    }
        }
    }
}

module railBase()
{
    cube([railHeight,railDepth,railLength]);
}

module bracketNutDiff()
{
    bracketNutNotchDepth = (bracketNutHeight+bracketNutMargin*2) - (railHeight -(bracketNutHeight+bracketNutMargin*2));
    
    bracketScrewRad = bracketScrewHoleDiameter/2;
    
    union(){
    cube([bracketNutHeight+bracketNutMargin*2, bracketNutHeight+bracketNutMargin*2, bracketNutThickness+bracketNutMargin*2], center = true);
        translate([0,0,bracketNutThickness/2-20]){
            cylinder(r=bracketScrewRad, h=bracketNutInset+21, $fn=20);
            }
            translate([-((bracketNutHeight+bracketNutMargin*2)+bracketNutNotchDepth)/2-.5,0,0]){
                cube([bracketNutNotchDepth+1,bracketNutHeight+bracketNutMargin*2, bracketNutThickness+bracketNutMargin*2], center=true);
                }
    }
}

module railDiff()
{
    union()
    {
        cube([railGapHeight,railFrontThickness+2,railLength+2], center=true);
        translate([0,railFrontThickness+1,0]){
        cube([slidingNutHeight+slidingNutMargin*2,slidingNutThickness+slidingNutMargin*2,railLength+2],center=true);
        }
    }
}