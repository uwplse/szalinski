/*Side Mounted Tool Holder for screwdrivers, tweezers
*Creator: Blake English
*Date: Nov 11, 2011
*Notes: My first open SCAD program
*1.2mm is a nice thickness for my !UP printer
*Dimentions in MM
*/

globalThickness=1.2;
shelfLength=120;  //this is the side to side dimention of the entire tool holder (side-side)
shelfWidth=20;  //this is the depth of the tool holder (front-back)
shelfThickness=globalThickness; //this is the thickness (top-bottom) of the plate that is the shelf
backingheight=30; //this is the (up-down) hight of the back plate that mounts to a surface (with double sided tape, glue or screws)
backingThickness=globalThickness; //this is the thickness (back-front) of the back plate

backHoleSize=4;

numberOfHoles=8;  //how many holes do you want?
holeDiameter=8;  //if you use fixed hole size, all the holes will be this big

//for progresssive hole size  (the holes are scaled in a linear fashion from the largest to the smallest)
holeLargestDia=5;  
holeSmallestDia=2.5;

//for gussets 
gussetThickness=globalThickness;  //this is the thickness of the optional triangular gussets on either side of the shelf
triangleGussetWidth=20;  //this is the A,B dimention of the triangle

///////////////////////////////////////////////////////////////
//choice vars: 1= use, 0 = don't use.
progressiveHoleSize=0;  //do you want the holes to get progressivly bigger (1) or be of fixed size(0)?
triangularGussets=1;  //do you want to use the gussets(1) or not (0)?
useToolGuides=1;   //do you want to use the tool guides (1) to keep top-heavy screwdrivers from falling over or not (0)?
///////////////////////////////////////////////////////////

//for guides
guideThickness = globalThickness;  //thickness of the guides
guideWidth = shelfWidth*0.5;  //this is an artifact left over from a previous version but is still used to govern how wide (fwd-back) vertical supports on the guides are.
guideHeight = backingheight*0.8;  //this is how tall the guides are, ie: how far they extend down.
guideCrossSupportHeight = 7;  //this how tall the cross support is (it is width guideThickness)



//helper vars
holeSpacing = shelfLength/numberOfHoles;



module gusset()  //this will define my triangular support gusset shape
{
	//b = 100;
	//h = 100;
	//w = 4;
	rotate([0,90,0])
	linear_extrude(height = gussetThickness, center = true, convexity = 10, twist = 0)
	polygon(points=[[0,0],[-triangleGussetWidth,0],[0,-triangleGussetWidth]], paths=[[0,1,2]]);
}
//gusset();

module toolGuidePositive(){
	translate([0,shelfWidth-guideWidth,0])
	cube([guideThickness, guideWidth, guideHeight]);
}

//toolGuidePositive();

module toolGuideNegitive(){
	translate([-guideThickness,shelfWidth-guideWidth,0])
	cube([guideThickness, guideWidth, guideHeight]);
}

//toolGuideNegitive();



module shelfWithHoles()
{
holeRadius=0;

translate([-shelfLength/2,0,0]) //center it 	
difference(){
	union(){  //L-shaped peice
		//draw the shelf first
		translate([0,0,0]) //center it 	
		cube([shelfLength,shelfWidth,shelfThickness]);

		//draw the backing
		translate([0,shelfWidth,0]) //center it 
		difference(){
			cube([shelfLength,backingThickness,backingheight]);
			for(hl = [1:numberOfHoles-1] ){
				translate([(shelfLength/(numberOfHoles)* hl), backingThickness+1,backingheight/2]) rotate([90,0,0])cylinder(h=backingThickness+2, r=backHoleSize/2 , $fn=60);
			}
		}
		
		if(useToolGuides==1)
		{
			translate([0,shelfWidth/2-guideThickness/2,0]) //center it 
			cube([shelfLength,guideThickness,guideCrossSupportHeight]);

			if(progressiveHoleSize==1)
			{
				for( i = [0:numberOfHoles-1])
				{

					translate([holeSpacing/2+holeSpacing*i,shelfWidth/2,0])
				
					cylinder(h=guideHeight, r=(holeSmallestDia+((holeLargestDia-holeSmallestDia)/numberOfHoles)*i)/2+guideThickness, $fn=60); 
					translate([holeSpacing/2+holeSpacing*i-guideThickness/2,0,0])
					toolGuidePositive();
				}
	
			}else{
				for( i = [0:numberOfHoles-1])
				{
					translate([holeSpacing/2+holeSpacing*i,shelfWidth/2,0])
				
					cylinder(h=guideHeight, r=holeDiameter/2+guideThickness, $fn=60); 
					translate([holeSpacing/2+holeSpacing*i-guideThickness/2,0,0])
					toolGuidePositive();
				}
		
			}
		}
		

	}


	if(progressiveHoleSize==1)
	{
		for( i = [0:numberOfHoles-1])
		{
			translate([holeSpacing/2+holeSpacing*i,shelfWidth/2,0])
			cylinder(h=guideHeight, r=(holeSmallestDia+((holeLargestDia-holeSmallestDia)/numberOfHoles)*i)/2, $fn=60); 
		}

	}else{
		for( i = [0:numberOfHoles-1])
		{
			translate([holeSpacing/2+holeSpacing*i,shelfWidth/2,0])
			cylinder(h=guideHeight, r=holeDiameter/2, $fn=60);
			
		}
		
	}
}  //this semicolon will close the translate loop?  ..iguess not


}



if(triangularGussets==1)
{
	union(){
	translate([-shelfLength/2+gussetThickness/2,shelfWidth+backingThickness,0])
	gusset();


	translate([shelfLength/2-gussetThickness/2,shelfWidth+backingThickness,0])
	gusset();

	shelfWithHoles();

	}
}








