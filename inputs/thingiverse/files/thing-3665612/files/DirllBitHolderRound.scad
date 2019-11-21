$fn=72;

BaseRadius=59;
BaseHeight=12;
BitsHoleBottomBaseHeight=4;

BitsNumber=20;
SmallestBitDiameter=0.5;	//Biggest size bit. To this will get subtracted the BitDiameterStepIncrease
BitDiameterStepIncrease=0.5;
BitsRadialPosition=45;
BitsInclinationX=0;
BitsInclinationY=0;
BitsHeightBase=5;

Tolerance=0.5;	//Bits holes increase of diameter

EnableText=1; 
TextSize=6;
TextRadialPositionOffset=12;

CenterHoleDiameter=4;

Section=0;   //Cross section
SectionOffsetX=50;
SectionOffsetZ=0;
SectionRotation=-90;

ShowBits=1;

	difference()
	{
		union()
		{
			color([0.1,0.4,0.4])
				cylinder(r=BaseRadius,h=BaseHeight);
		}

		for(a=[0:1:BitsNumber-1])
			rotate([0,0,(360/BitsNumber)*a])
			{
				translate([BitsRadialPosition,0,BitsHoleBottomBaseHeight])
					rotate([BitsInclinationX,BitsInclinationY,0])
						cylinder(d=(SmallestBitDiameter+(BitDiameterStepIncrease*a))+Tolerance,h=BitsNumber*BitsHeightBase+a*10);
				if(EnableText==1)
					color("Black")
						translate([BitsRadialPosition+TextRadialPositionOffset,0,BaseHeight-0.5])
							rotate([0,0,90])
								linear_extrude(3)
									text(text=str(SmallestBitDiameter+(BitDiameterStepIncrease*a)),size=TextSize,halign="center");
			}
		
		translate([0,0,-1])
			cylinder(d=CenterHoleDiameter,h=BaseHeight*2);
		translate([0,0,BaseHeight/2])
			cylinder(d=CenterHoleDiameter*2,h=BaseHeight*2);
		
		if(Section==1)	
			rotate([0,0,SectionRotation])
				translate([SectionOffsetX,0,SectionOffsetZ])
					cube([100,100,100],center=true);
	}

if(ShowBits==1)
	color("silver")
		for(a=[0:1:BitsNumber-1])
			rotate([0,0,(360/BitsNumber)*a])
				translate([BitsRadialPosition,0,BitsHoleBottomBaseHeight])
					rotate([BitsInclinationX,BitsInclinationY,0])
						cylinder(d=(SmallestBitDiameter+(BitDiameterStepIncrease*a)),h=BitsNumber*BitsHeightBase+a*10);
