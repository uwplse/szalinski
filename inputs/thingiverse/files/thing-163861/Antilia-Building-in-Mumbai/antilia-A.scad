//Select the way the STL should be rendered
part = "ForPrinting"; // [ForPrinting,UprightForPics]

//Choose a text or an empty string if not text is needed.
Bottom_Front_Text=""; 

//Choose a text or an empty string if not text is needed.
Top_Side_Text="";

//Choose a text or an empty string if not text is needed.
Top_Front_Text="";

//Height of the building in mm
Height=130;

/* [Hidden] */

/*
Antilia Building in Mumbai
Version A, May 2014
Written by MC Geisler (mcgenki at gmail dot com)

Antilia Building in Mumbai, roughly built after a photograph.  
You can change/remove the default text using OpenSCAD.  
Thanks go to Harlan Martin for the write library and to Victor Engmark (l0b0) for the inkscape to openSCAD converter.

Sorry for the use of some German in the openSCAD comments.

Have fun!

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
Under the following terms:
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
    You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 
*/

use <write/Write.scad> 

// ----------------- Waende

fudge = 0.1;

//neu kein buckel
module poly_rect38017(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-77.803585,-410.270195],[-77.803585,-400.145195],[110.602615,-400.145195],[110.602615,-318.832695],[-77.803585,-318.832695],[-77.803585,-308.738945],[-77.803585,-273.645195],[-77.803585,-269.332695],[110.602615,-269.332695],[110.602615,-132.957695],[-130.397335,-132.957695],[-130.397335,-129.176445],[-131.334835,-129.176445],[-131.334835,-89.801445],[-130.397335,-89.801445],[-130.397335,-84.488945],[110.602615,-84.488945],[110.602615,3.917305],[-77.803585,3.917305],[-77.803585,9.698555],[-77.803585,14.011055],[-77.803585,102.386055],[-77.803585,110.729805],[-77.803585,112.511055],[110.602615,112.511055],[110.602615,202.354805],[110.602615,224.636055],[-126.772335,224.636055],[-126.772335,234.729805],[-126.772335,463.761055],[-126.772335,463.792305],[110.602615,463.792305],[115.165215,463.792305],[120.696415,463.792305],[120.696415,213.167305],[120.696415,202.354805],[120.696415,108.198555],[120.696415,102.386055],[-67.678585,102.386055],[-67.678585,14.011055],[120.696415,14.011055],[120.696415,3.917305],[120.696415,-88.770195],[120.696415,-94.582695],[-121.241085,-94.582695],[-121.241085,-122.863945],[120.696415,-122.863945],[120.696415,-132.957695],[120.696415,-274.145195],[120.696415,-279.457695],[-67.678585,-279.457695],[-67.678585,-308.738945],[110.602615,-308.738945],[120.696415,-308.738945],[120.696415,-318.832695],[120.696415,-405.207695],[120.696415,-410.270195],[-77.803585,-410.270195]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-116.678585,234.729805],[110.602615,234.729805],[110.602615,453.667305],[-116.678585,453.667305],[-116.678585,234.729805]]);
    }
  }
}

//alt (buckel hinten)
module poly_rect3801(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-77.792605,-410.268375],[-77.792605,-400.143375],[110.613645,-400.143375],[110.613645,-318.830875],[-77.792605,-318.830875],[-77.792605,-308.737125],[-77.792605,-273.643375],[-77.792605,-269.330875],[110.613645,-269.330875],[110.613645,-132.955875],[-130.386355,-132.955875],[-130.386355,-129.174625],[-131.323855,-129.174625],[-131.323855,-89.799625],[-130.386355,-89.799625],[-130.386355,-84.487125],[110.613645,-84.487125],[110.613645,3.919125],[-77.792605,3.919125],[-77.792605,9.700375],[-77.792605,14.012875],[-77.792605,102.387875],[-77.792605,110.731625],[-77.792605,112.512875],[110.613645,112.512875],[110.613645,224.637875],[-126.761355,224.637875],[-126.761355,234.731625],[-126.761355,463.762825],[-126.761355,463.794125],[133.332395,463.794125],[133.332395,453.669125],[133.332395,228.919125],[133.332395,224.637875],[120.707395,224.637875],[120.707395,108.200375],[120.707395,102.387875],[-67.667605,102.387875],[-67.667605,14.012875],[120.707395,14.012875],[120.707395,3.919125],[120.707395,-88.768375],[120.707395,-94.580875],[-121.230105,-94.580875],[-121.230105,-122.862125],[120.707395,-122.862125],[120.707395,-132.955875],[120.707395,-274.143375],[120.707395,-279.455875],[-67.667605,-279.455875],[-67.667605,-308.737125],[110.613645,-308.737125],[120.707395,-308.737125],[120.707395,-318.830875],[120.707395,-405.205875],[120.707395,-410.268375],[-77.792605,-410.268375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-116.667605,234.731625],[123.238645,234.731625],[123.238645,453.669125],[-116.667605,453.669125],[-116.667605,234.731625]]);
    }
  }
}




// ---------------- GEBAEUDE

module poly_rect4597(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-136.370605,-463.660035],[136.370605,-463.660035],[136.370605,463.660035],[-136.370605,463.660035]]);
  }
}

module poly_rect38010761(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[45.684905,44.510795],[112.108794,44.510795],[112.108794,14.052127],[45.684905,14.052127]]);
  }
}

module poly_rect3801076927(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-77.807975,-132.453495],[111.401285,-132.453495],[111.401285,-248.983595],[-77.807975,-248.983595]]);
  }
}

module poly_rect38010769279(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-54.057955,-248.167765],[110.865585,-248.167765],[110.865585,-269.697863],[-54.057955,-269.697863]]);
  }
}

module poly_rect380107692(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-0.307955,-55.667795],[110.687025,-55.667795],[110.687025,-84.340748],[-0.307955,-84.340748]]);
  }
}

module poly_rect380107692795(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-67.986515,-279.571515],[111.579875,-279.571515],[111.579875,-308.601613],[-67.986515,-308.601613]]);
  }
}

module poly_rect38010763(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-6.736515,225.225095],[111.044175,225.225095],[111.044175,111.909285],[-6.736515,111.909285]]);
  }
}

module poly_rect3801076923(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-121.379385,-94.239205],[111.758445,-94.239205],[111.758445,-122.912158],[-121.379385,-122.912158]]);
  }
}

module poly_rect380107634(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-116.915105,453.796515],[123.008445,453.796515],[123.008445,234.409275],[-116.915105,234.409275]]);
  }
}

module poly_rect380107638(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-66.200825,188.796505],[112.294155,188.796505],[112.294155,176.194980],[-66.200825,176.194980]]);
  }
}

module poly_rect380107(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-69.210325,104.332205],[112.133825,104.332205],[112.133825,73.873537],[-69.210325,73.873537]]);
  }
}

module poly_rect3801076(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[4.934265,75.225095],[112.279315,75.225095],[112.279315,44.766427],[4.934265,44.766427]]);
  }
}

module poly_rect38010769(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-28.879365,4.153675],[112.115615,4.153675],[112.115615,-55.947849],[-28.879365,-55.947849]]);
  }
}

module poly_rect3801076927954(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[24.334895,-318.703485],[110.686999,-318.703485],[110.686999,-399.876443],[24.334895,-399.876443]]);
  }
}





// ---------------- Saeulen
saeulenfaktor=2;

module cylYbig(x1,y1,x2,y2,x3,y3)
{
//	 linear_extrude(height=50)
//		polygon([[x1,y1],[x2,y2],[x3,y3]]);
rr=abs(x1-x3)/2;
hh = abs(y1-y2);
echo("r=",rr," h=",hh);
	translate([(x1+x3)/2,(y1+y2)/2])
		rotate([90,0,0])
			cylinder(r=rr*saeulenfaktor, h=hh , center = true); 
	//cylinder(r = 5, h = 66, center = true); 
}


module poly_rect4597(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-136.370605,-463.660035],[136.370605,-463.660035],[136.370605,463.660035],[-136.370605,463.660035]]);
  }
}



module poly_rect38019248(h)
{
//  scale([25.4/90, -25.4/90, 1]) 
  scale([25.4/90, -25.4/90, 25.4/90]) 
	union()
  {
//    linear_extrude(height=h)
//      polygon([[-33.789795,9.845265],[-33.789795,75.860524],[-23.688270,75.860524],[-23.688270,9.845265]]);
      cylYbig(-33.789795,9.845265,-33.789795,75.860524,-23.688270,75.860524);
  }
}





module cylrot(x1,y1,x2,y2,x3,y3)
{
//	 linear_extrude(height=50)
//		polygon([[x1,y1],[x2,y2],[x3,y3]]);
rr=5;
hh = abs(y1-y2);
echo("r=",rr," h=",hh);
	translate([(x1+x3)/2-50,(y1+y2)/2-25,0])
		rotate([90,0,0])
			cylinder(r=rr*saeulenfaktor, h=hh , center = true); 
	//cylinder(r = 5, h = 66, center = true); 
}
module poly_rect38019223(h)
{
//  scale([25.4/90, -25.4/90, 1]) 
  scale([25.4/90, -25.4/90, -25.4/90]) 
	union()
  {
//    linear_extrude(height=h)
//      polygon([[-73.432652,108.475767],[-32.718367,226.158544],[-22.616842,226.158544],[-63.331127,108.475767]]);
//  		rotate([27,0,0])
	translate([0,2,0])
  		rotate([0,0,-19])
			cylrot(-73.432652,99.475767,-32.718367,226.158544,-22.616842,226.158544);
	}
}

module poly_rect380192483(h)
{
  scale([25.4/90, -25.4/90,  1]) 
	union()
  {
    linear_extrude(height=h)
      polygon([[-33.075505,109.845265],[-33.075505,226.574815],[-22.973980,226.574815],[-22.973980,109.845265]]);
	}
  
}

module poly_rect380192483_2(h)
{
  scale([25.4/90, -25.4/90,  -25.4/90]) union()
  {
	translate([50,77,-10])
  		//rotate([0,0,+19])
			cylrot(-33.075505,88.845265,-33.075505,226.574815,-22.973980,226.574815);
  }
}
module poly_rect380192483_3(h)
{
  scale([25.4/90, -25.4/90,  -25.4/90]) union()
  {
	translate([50,25,-0])
  		//rotate([0,0,+19])
			cylrot(-33.075505,88.845265,-33.075505,226.574815,-22.973980,226.574815);
  }
}
module poly_rect380192232(h)
{
  scale([25.4/90, -25.4/90, -25.4/90]) union()
  {
//    linear_extrude(height=h)
//      polygon([[19.525955,108.475767],[-21.188331,226.158544],[-31.289856,226.158544],[9.424430,108.475767]]);
	translate([90,53,0])
  		rotate([0,0,+19])
			cylrot(19.525955,108.475767,-21.188331,226.158544,-31.289856,226.158544);
  }
}

module poly_rect3801922321(h)
{
  scale([25.4/90, -25.4/90, -25.4/90]) union()
  {
//    linear_extrude(height=h)
//      polygon([[5.495935,108.475767],[46.210221,226.158544],[56.311746,226.158544],[15.597460,108.475767]]);
	translate([4,35,0])
  		rotate([0,0,-19])
			cylrot(5.495935,98.475767,46.210221,226.158544,56.311746,226.158544);
  }
}

module poly_rect3801922326(h)
{
  scale([25.4/90, -25.4/90, -25.4/90]) union()
  {
    linear_extrude(height=h)
      polygon([[98.454605,108.475767],[57.740319,226.158544],[47.638794,226.158544],[88.353080,108.475767]]);
	translate([100,31,0])
  		rotate([0,0,+19])
			cylrot(98.454605,100.475767,57.740319,226.158544,47.638794,226.158544);
  }
}





module poly_rect38019245(h)
{
  scale([25.4/90, -25.4/90, -25.4/90]) 
	union()
  {
 //   linear_extrude(height=h)
//      polygon([[8.710205,9.130975],[8.710205,45.146234],[18.811730,45.146234],[18.811730,9.130975]]);
		cylYbig(8.710205,9.130975,8.710205,45.146234,18.811730,45.146234);
  }
}

module poly_rect380192488(h)
{
  scale([25.4/90, -25.4/90, -25.4/90]) 
	union()
  {
//    linear_extrude(height=h)
//      polygon([[-70.575515,-84.797585],[-70.575515,4.431961],[-60.473990,4.431961],[-60.473990,-84.797585]]);
  cylYbig(-70.575515,-84.797585,-70.575515,4.431961,-60.473990,4.431961);
	}
}

module poly_rect3801924883(h)
{
  scale([25.4/90, -25.4/90, -25.4/90]) union()
  {
//    linear_extrude(height=h)
//      polygon([[-67.718375,-401.047585],[-67.718375,-318.603753],[-57.616850,-318.603753],[-57.616850,-401.047585]]);
cylYbig(-67.718375,-401.047585,-67.718375,-318.603753,-57.616850,-318.603753);
  }
}

module poly_rect38019248831(h)
{
  scale([25.4/90, -25.4/90, -25.4/90]) union()
  {
//    linear_extrude(height=h)
//      polygon([[-30.575535,-400.511875],[-30.575535,-318.068043],[-20.474010,-318.068043],[-20.474010,-400.511875]]);
cylYbig(-30.575535,-400.511875,-30.575535,-318.068043,-20.474010,-318.068043);
  }
}

module poly_rect38019248832(h)
{
  scale([25.4/90, -25.4/90, -25.4/90]) union()
  {
//    linear_extrude(height=h)
//      polygon([[9.067345,-400.511875],[9.067345,-318.068043],[19.168870,-318.068043],[19.168870,-400.511875]]);
cylYbig(9.067345,-400.511875,9.067345,-318.06804,19.168870,-318.068043);
  }
}




// ---------------- 
// ---------------- 

module antilia()
{

BreiteWaende=70;
BreiteGebaeude=BreiteWaende*.9;
AbstandWaende=(BreiteWaende-BreiteGebaeude)/2;

BreiteSaeulen=0;

//Saeulen
module saeulengerade()
{
	poly_rect3801924883(BreiteSaeulen);
	poly_rect38019248831(BreiteSaeulen);
	poly_rect38019248832(BreiteSaeulen);

	poly_rect380192488(BreiteSaeulen);

	poly_rect38019248(BreiteSaeulen);
	poly_rect38019245(BreiteSaeulen);
}
module saeulenschraeg()
{
	poly_rect38019223(BreiteSaeulen);
	poly_rect380192232(BreiteSaeulen);
	poly_rect3801922321(BreiteSaeulen);
	poly_rect3801922326(BreiteSaeulen);

}
module saeulegeradeschraeg()
{
	//poly_rect380192483(BreiteSaeulen);
	poly_rect380192483_2(BreiteSaeulen);
}

for (i=[1,3,5])
{
	translate([0,0,BreiteWaende/6*i-BreiteSaeulen/2])
		saeulengerade();
}

for (i=[1,6,11])
{
	translate([0,0,BreiteWaende/12*i-BreiteSaeulen/2])
	{
		saeulenschraeg();
	}
}
winkel=19;
for (i=[6,11])
{
	translate([0,8,BreiteWaende/12*i-BreiteSaeulen/2-7])
	{
		rotate([winkel,0,0])
			poly_rect380192483_2();
	}
}
for (i=[1,6])
{
	translate([0,-6,BreiteWaende/12*i-BreiteSaeulen/2+9])
	{
		rotate([-winkel,0,0])
			poly_rect380192483_3();
	}
}

//Gebaeude
Topwidth=BreiteGebaeude/2;
Width2nd=BreiteGebaeude*.8;
Width3rd=BreiteGebaeude*.75;
WidthZwischen=BreiteGebaeude/5;

translate([0,0,AbstandWaende])
{//poly_rect4597(BreiteGebaeude);

	poly_rect3801076927954(BreiteGebaeude);
	translate ([-20,0,Topwidth/2]) 
			poly_rect3801076927954(Topwidth);

//to close gaps
translate([0,1,0])
{
	poly_rect3801076927954(BreiteGebaeude);
	translate ([-20,0,Topwidth/2]) 
			poly_rect3801076927954(Topwidth);
}
//to close gaps
translate([0,-1,0])
{
	poly_rect3801076927954(BreiteGebaeude);
	translate ([-20,0,Topwidth/2]) 
			poly_rect3801076927954(Topwidth);
}

	poly_rect380107692795(BreiteGebaeude);
//to close gaps
	translate ([0,1,0]) poly_rect380107692795(BreiteGebaeude);
	translate ([0,-1,0]) poly_rect380107692795(BreiteGebaeude);

	translate ([0,0,-(Width2nd-BreiteGebaeude)/2]) 
		poly_rect38010769279(Width2nd);
   poly_rect3801076927(BreiteGebaeude); 
//to close gaps
	translate ([0,-1,0]) poly_rect3801076927(BreiteGebaeude); 

	poly_rect3801076923(BreiteGebaeude);
//to close gaps
	translate ([0,-1,0]) poly_rect3801076923(BreiteGebaeude);
//to close gaps
	translate ([0,1,0]) poly_rect3801076923(BreiteGebaeude);

	translate ([0,0,-(Width2nd-BreiteGebaeude)/2]) 
		poly_rect380107692(Width2nd);
//to close gaps
	translate ([0,1,0])translate ([0,0,-(Width2nd-BreiteGebaeude)/2]) poly_rect380107692(Width2nd);
	translate ([0,-1,0])translate ([0,0,-(Width2nd-BreiteGebaeude)/2]) poly_rect380107692(Width2nd);
	poly_rect38010769(BreiteGebaeude);
//to close gaps
	translate ([0,-1,0])poly_rect38010769(BreiteGebaeude);

	translate ([0,0,-(Width2nd-BreiteGebaeude)/2]) 
		poly_rect38010761(Width2nd); 
//to close gaps
	translate ([0,-2,0])translate ([0,0,-(Width2nd-BreiteGebaeude)/2]) poly_rect38010761(Width2nd); 
	translate ([0,1,0])translate ([0,0,-(Width2nd-BreiteGebaeude)/2]) poly_rect38010761(Width2nd); 
	poly_rect3801076(BreiteGebaeude);
//to close gaps
	translate ([0,-1,0]) poly_rect3801076(BreiteGebaeude);
	poly_rect380107(BreiteGebaeude);
//to close gaps
	translate ([0,-1,0]) poly_rect380107(BreiteGebaeude);

	translate ([0,0,-(Width3rd-BreiteGebaeude)/2]) 
		poly_rect38010763(Width3rd);	
	
	translate ([0,0,WidthZwischen]) 
		poly_rect380107638(WidthZwischen); //zwischenschicht
	translate ([0,0,3*WidthZwischen]) 
		poly_rect380107638(WidthZwischen); //zwischenschicht

	translate ([-1,0,0]) 
	poly_rect380107634(BreiteGebaeude); //basis
}


//Waende
//alt:
//poly_rect3801(BreiteWaende);
//neu:
poly_rect38017(BreiteWaende);
}

module antilia_with_text()
{
	//rotate([0,90,90])
	difference()
	{
		//translate([0,0,30]) cube(200,center=true);
		union()
		{
			antilia();
		}
	#	writecube(Bottom_Front_Text,[-10,-100,38],0,face="left", t=60,h=24,space=1.5, rotate=-90, font="orbitron.dxf");
	#	writecube(Top_Side_Text,[5,54,4],0,face="bottom", t=10,h=15,space=1.5, rotate=180, font="orbitron.dxf");
	#	writecube(Top_Front_Text,[-20,54,38],0,face="left", t=10,h=18,space=1.5, rotate=-90, font="orbitron.dxf");
	}
}

//-------------------------
scalefactor=Height/246.68;

if (part == "ForPrinting")
{
	scale(scalefactor)
		rotate([0,90,0])
			antilia_with_text();
}

if (part == "UprightForPics")
{
	scale(scalefactor)
		rotate([90,0,90])
			antilia_with_text();
}
