$fn =50;


//cup volume im ml
volume =500;
//width scale
width = 1;
//height scale
height = 2;
//height of the decoration to the actual cup
decoHeight = 0.3;
//wall thickness
wall = 5;





volume2 = volume * 1000 ;
cut = 1 * 1;
r1 = width ;
h1 = height * 3;
h2 = h1 * (2/3);
r2 = (r1 * h2) /h1;
scale = pow( (3*volume2)
 /(PI* (r1*r1*h1 - r2*r2*h2) ),1/3 );
rInner= scale *r1 ;
hInnerTotal = scale *h1 ;
hInnerCut = scale * h2 ;
hInnerVol = hInnerTotal - hInnerCut;


//calculating outter
rOuter = rInner + wall;
hOuter = (hInnerTotal*rOuter)/rInner;

//calculating cut
hCut = hInnerTotal + cut;
rCut = (rInner * hCut) /hInnerTotal;

//rInnerCut = (rInner * hInnerCut) /hInnerTotal;

//decuration inner



rDecoBorder = rInner + (wall/2);
hDecoBorder = (hInnerTotal*rOuter)/rInner;

hDecoLow = hDecoBorder-wall;
rDecoLow = (rDecoBorder * hDecoLow)/hDecoBorder;

hDecoHigh = hDecoLow + (hInnerVol *decoHeight)+wall;
rDecoHigh = (rDecoLow * hDecoHigh)/hDecoLow;


hDecoHighCut = hDecoHigh + cut;
rDecoHighCut = (rDecoHigh * hDecoHighCut)/hDecoHigh;
 
hDecoLowCut = hDecoLow -wall  - cut;
rDecoLowCut = (rDecoLow * hDecoLowCut)/hDecoLow;

hcantHighCut = hDecoHigh +cut;
rcantHighCut = (rDecoHigh * hcantHighCut)/hDecoHigh;

hcantLowCut = hDecoLow -wall-cut;
rcantLowCut = (rDecoLow * hcantLowCut)/hDecoLow;


module lastCut()
{
translate([0,0,-wall *2])
difference()
	{
		cylinder(r=rDecoLow + wall,r2=rDecoHigh + wall*2, h= hDecoHigh - hDecoLow +wall );
translate([0,0, -cut])
		cylinder(r=rcantLowCut +wall ,r2=rcantHighCut +wall, h= hcantHighCut - hcantLowCut );
	}
}
module decoration()
{

	translate([0,0,-wall])
difference()
{
	union()
	{
		cylinder(r=rDecoLow + wall,r2=rDecoHigh + wall, h= hDecoHigh - hDecoLow );
		translate([0,0,-wall])
			cylinder(r=rDecoLow ,r2=rDecoLow + wall + cut, h= wall + cut);	
	}	
	translate([0,0,-cut-wall])
		cylinder(r=rDecoLowCut,r2=rDecoHighCut, h= hDecoHighCut - hDecoLowCut );	
	
	differance()
	{
		cylinder(r=rDecoLow + wall*5,r2=rDecoHigh + wall*2, h= hDecoHigh - hDecoLow );
		cylinder(r=rDecoLow + wall,r2=rDecoHigh + wall, h= hDecoHigh - hDecoLow );
	}
}
}



module innerCup()
{
	difference()
	{
		translate([0,0,cut])
		rotate([180,0,0])
			cylinder(r=rCut,r2=0, h= hCut);	

	translate([0,0,-(hInnerTotal-hInnerCut)])
	rotate([180,0,0])
			cylinder(r=rInner,r2=0, h= hInnerTotal);
	}
}


module outerCup()
{
	difference()
	{
		rotate([180,0,0])
			cylinder(r=rOuter,r2=0, h= hOuter);	

	translate([0,0,-(hInnerVol+wall)])
	rotate([180,0,0])
			cylinder(r=rOuter,r2=0, h= hOuter);
	}
}
module cup()
{
difference()
{
	outerCup();
	innerCup();
}
}
union()
{

cup();
difference()
{
decoration();
lastCut();
}
}