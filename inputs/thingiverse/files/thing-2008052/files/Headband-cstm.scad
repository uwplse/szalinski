

BaseWidth=152*1;
BaseLength=190*1;


//Measure your head in mm with a sewing tape measure
HeadCircumference_mm = 540; //[450:750]
//13mm is a average size
BandHeight_mm=13;//[3:20]
//3mm thick is still flexible
BandThickness_mm=3;//[1:8]
//Determines number of sides / facets... more is smoother
$fn=128;

CircPercent = HeadCircumference_mm/540;
CalcLength = BaseLength*CircPercent/2;
CalcWidth = CalcLength*0.799;
echo(CalcLength);
echo(CalcWidth);

//Define an Oval (shape of band)
module oval(w,h, height, center = false) {
 scale([1, h/w, 1]) cylinder(h=height, r=w, center=center); 
};
//Create the Band, with hole in back for rear ornament

    difference() {oval (CalcLength+BandThickness_mm,CalcWidth+BandThickness_mm,BandHeight_mm,center=false,center=false);
translate ([0,0,-1]) oval (CalcLength,CalcWidth,BandHeight_mm+2,center=false);}

