// Written by Remi Vansnickt <>
//Feel free to tip me : https://www.thingiverse.com/Remivans/about
//Thingiverse : https://www.thingiverse.com/thing:3110569/
//Licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license.
/* [Main] */

//( mm ) Width of the Nozzle
PrinterNozzleWidth=0.4; //[0.1:0.05:1]

//( mm ) Spool inner Width    [250gr~90 750gr~100 2.3kg~220]
SpoolInnerWidth=100;    //[50:1:400]

//( mm ) Spool outer Width    [250gr~140 750gr~200 2.3kg~380]
SpoolOuterWidth=200;    //[100:1:500]

//( mm ) Part Height           [250gr~37 750gr~45 2.3kg~90]
PartHeight=45; //[2:0.1:150]

//( degree ) Part Radius Cover ( will be reduice by PartClearance )
PartRadiusCover=90;  //[1:1:360]

/* [Customize] */

//Number section ( if you set radial Section this is the number of receptacles only if PartSection > PartRadialSecion)
PartSection=2;  //[1:1:30]
//(%) % Height of Section
sectionHeight=100;  //[10:1:100]

//Number radial separator ( you may increase Part Section with radial mode ) 
PartRadialSection=1;  //[1:1:5]
//(%) % Height of radial Section
sectionRadialHeight=100;  //[10:1:100]

//(reason) Part asymetric recommand values 0 symetric other asymetric 1/PartSection is a good value
PartAsymetric=0; //[-0.1:0.1:1]

//handle type 
HandleType = 1; // [0:nothing, 1:handle, 2:hole]

//Add a label on Part 
PrintedLabel = 0; // [0:nothing! please, 1:label Positif, 2:label Negatif]

//text to display exemple screw or multiple label exemple ["AB","CD","EF"]
PrintedLabelText = "SCREW"; 

//label-holder 
LabelHolder = 0*1; // [0:nothing, 1:yes! please]

//( mm ) Hole screw diameter
HoleScrew=4.05;  //[2:0.05:6]

// Right-open by default 
MirrorPart=1;  //[1:right,0:left]

/* [Advanced] */

//( mm ) Part's Outer space clearance (this parameter will rediuce Part Radius Cover)
PartClearance=1.5; //[0:0.1:4]

//Wall's number global determine Thickness PrinterNozzleWidth*WallLayerCount 0.4*3=1.2mm
WallLayerCount=3;  //[1:1:10]

//Wall's number section 0.4*3=1.2mm
SectionLayerCount=3;  //[1:1:5]

//Wall's number Hole determine Thickness 0.4*3=1.2mm
HoleLayerCount=3;  //[1:1:5]

//(mm) BottomThickness 2mm
BottomThickness=2;  //[0.3:0.1:3]

//Handle size
HandleSize = 3; // [2:0.5:5]

//( mm ) height of char ( this parameter is limited by PartHeight & area size  )
PrintedLabelSize = 15; // [0:1:100] 

//( % ) Height label %of part height
LabelHolderHeight=50*1; ////[20:0.1:100]

//( % ) Height label %of part width
LabelHolderWidth=60*1; ////[20:0.1:80]

//( mm ) label-Holder's Clearance from part
LabelHolderClearance=0.8*1; ////[0.1:0.05:1.5]

//Wall's number label 0.4*2=0.8mm
LabelLayerCount=2*1;  //[1:1:5]

//( mm ) label-holder size
LabelHolderSize=3*1; ////[1:0.5:5]

//QualityMesh
QualityMesh=100;    //[50:1:200]


//begin

function asymetric(n,sections) = n == 0 ? -90 : ((1+(n-1)*PartAsymetric))*PartRadius/(sections*((1+(sections-1)*PartAsymetric)+1)/2)+asymetric(n-1,sections);



PartRadius=PartRadiusCover-asin((PartClearance)/(SpoolOuterWidth/2));

LabelRadius=LabelHolderWidth*PartRadius/100;
LabelStartRadius=((LabelHolderWidth-100)/2)*PartRadius/100;

wt=WallLayerCount*PrinterNozzleWidth+0.01;
st=SectionLayerCount*PrinterNozzleWidth+0.01;
gt=(HandleSize)*PrinterNozzleWidth+0.01;
ht=(HoleLayerCount)*PrinterNozzleWidth+0.01;
lt=(LabelLayerCount)*PrinterNozzleWidth+0.01;

module LetterBlock(chars, size=10, startAngle=0, angleDisplay=PartRadius) {
	
echo("len(chars)",len(chars));
if (len(chars)!=0)
{
	if (len(chars[0])==1)
		{		
		maxStep = angleDisplay / (len(chars)+1);//+1 for better rendering

		wantedWidth = (PrintedLabelSize/2)/tan(acos(((PrintedLabelSize/2))/(SpoolOuterWidth/2)));
		minimalWidth= (wantedWidth<=(2*PrinterNozzleWidth)) ? 2*PrinterNozzleWidth : wantedWidth;
		LetterWidth= (wantedWidth>=(2*wt)) ? 2*wt-2*PrinterNozzleWidth : minimalWidth;

		
		wantedHeight = (size<=PartHeight) ? size : PartHeight;
		calculatedHeight = (SpoolOuterWidth/2)*sin(maxStep); 
		renderedHeight = (wantedHeight<=calculatedHeight) ? wantedHeight : calculatedHeight;
		
		lettersIndex=len(chars)-1;
		
		step_angle=asin((renderedHeight)/(SpoolOuterWidth/2));

		
			for(i = [0 : lettersIndex]) {
			
			rotate([0,0,90+startAngle+angleDisplay/2+(i-lettersIndex/2) * step_angle])    
					translate([0,-(SpoolOuterWidth/2-LetterWidth/2),PartHeight/2])
						rotate([90,0,0])
							linear_extrude(height=LetterWidth, convexity=5)
						text(chars[i], 
							 size=renderedHeight,
							 font="Bitstream Vera Sans",
							 halign="center",
							 valign="center");
			} 
		}
	else{
		for (i = [0:1:len(chars)-1])
		{
			receptacle=(PartSection >= PartRadialSection)?PartSection:PartRadialSection;
			
			echo("asymetric(i,len(chars))",90+asymetric(i,len(chars)));
			echo("asymetric(i,)",90+asymetric(i+1,len(chars))-asymetric(i,len(chars)));
			if (len(chars) == receptacle){
				
				LetterBlock(chars[i],size,90+asymetric(i,len(chars)),asymetric(i+1,len(chars))-asymetric(i,len(chars)));
			}
			else{
				startAngle = PartRadius*i/(len(chars));
				angleDisplay = PartRadius/(len(chars));
				LetterBlock(chars[i],size,startAngle,angleDisplay);
			}
		}
	}
}
}


module tiroir(){
    

    rotate_extrude (angle=PartRadius,convexity=10,$fn=10*QualityMesh)
        translate([SpoolOuterWidth/2-wt, 0])
            square([wt,PartHeight]);

    rotate_extrude(angle=+PartRadius,convexity=10,$fn=5*QualityMesh)
        translate([SpoolInnerWidth/2, 0])
            square([wt,PartHeight]);
            

    rotate_extrude(angle=PartRadius,convexity=10,$fn=5*QualityMesh)
        translate([SpoolInnerWidth/2, 0])
            square([SpoolOuterWidth/2-SpoolInnerWidth/2,BottomThickness]);

}

module handleG (){
	tetaGrip=MirrorPart*PartRadius-90+(1-MirrorPart)*asin((4*gt)/(SpoolOuterWidth/2));
    rotate([0,0,tetaGrip])
        translate([0, SpoolOuterWidth/2-wt])
            union(){
                cube([4*gt,8*gt,PartHeight]);
                translate([2*gt, 8*gt]) cylinder (h = PartHeight, r=2*gt,  $fn=QualityMesh);
            }
    }
module handleH (){
tetaHole=MirrorPart*PartRadius-90-asin(((MirrorPart*2-1)*(gt*15+2*wt))/(SpoolOuterWidth/2));
     rotate([0,0,tetaHole])
        translate([0, SpoolOuterWidth/2+2*wt,PartHeight])
            rotate([-270,0,0])
                cylinder (h = +10*wt, r=gt*10,  $fn=QualityMesh);
    }
	
module sections (){
	//sections externes
    translate([SpoolInnerWidth/2, 0])
        cube([SpoolOuterWidth/2-SpoolInnerWidth/2,wt,PartHeight]);

    rotate([0,0,PartRadius-90])
        translate([0, SpoolInnerWidth/2])
            cube([wt,SpoolOuterWidth/2-SpoolInnerWidth/2,PartHeight]); 

				reste=(PartSection)%PartRadialSection;
				numberSection=round((PartSection -reste )/PartRadialSection);
				//Parse Radial Sections
				for (j = [ 0 : 1 : PartRadialSection-1 ])
				{
					rotate_extrude(angle=+PartRadius,convexity=10,$fn=5*QualityMesh)
					translate([+SpoolInnerWidth/2+j*(SpoolOuterWidth/2-SpoolInnerWidth/2)/PartRadialSection, 0])
					square([st,sectionRadialHeight*PartHeight/100]);
					
					addSection=(PartRadialSection-j-1)<reste?1:0;
					realSection=numberSection+addSection;
					echo ("radial j",j,"realSection",realSection,"reste",reste,"addSection",addSection);
					//Parse restricted sections
					for (i = [ 1 : 1 : realSection-1 ])
						rotate([0,0,asymetric(i,realSection)+asin((st/2)/(SpoolOuterWidth/2))])
						translate([0, SpoolInnerWidth/2+j*(SpoolOuterWidth/2-SpoolInnerWidth/2)/PartRadialSection,0])
						cube([st,(SpoolOuterWidth/2-SpoolInnerWidth/2)/PartRadialSection,sectionHeight*PartHeight/100]);
					
				}
	}
	
	
    
    
module percageNegatif (){
    rHole=HoleScrew/2+ht;
    teta=(1-MirrorPart)*PartRadius+90-acos((MirrorPart*2-1)*(rHole+wt)/(SpoolOuterWidth/2));
    distancex=SpoolOuterWidth/2-(rHole+wt);
    

        rotate([0,0,teta])
            translate([ distancex,0,-1]) 
                    cylinder (h = PartHeight+2, r=HoleScrew/2,  $fn=QualityMesh);
    }
    
module percagePositif (){
    rHole=HoleScrew/2+ht;
    teta=(1-MirrorPart)*PartRadius+90-acos((MirrorPart*2-1)*(rHole+wt)/(SpoolOuterWidth/2));
    distancex=SpoolOuterWidth/2-(rHole+wt);
    

        rotate([0,0,teta])
            translate([ distancex,0]) 
                union(){
                    cylinder (h = PartHeight, r=rHole,  $fn=QualityMesh/2);
                    translate([0,-MirrorPart*rHole,0]) cube ([rHole,rHole,PartHeight]);
                }
    }
    
module percageAngle (){
    rHole=HoleScrew/2+ht;
    teta=(1-MirrorPart)*PartRadius+90-acos((MirrorPart*2-1)*(rHole+wt)/(SpoolOuterWidth/2));
	tetaCube=-asin((rHole/2+wt)/(SpoolOuterWidth/2));
    distancex=SpoolOuterWidth/2-(rHole+wt);
    
    difference(){
		rotate([0,0,(1-MirrorPart)*(PartRadius+tetaCube)])
            translate([distancex, -wt,-1])
                cube([rHole+2*wt,rHole+2*wt,PartHeight+2]);

             rotate([0,0,teta])
                translate([ distancex,0,-2]) 
                        cylinder (h = PartHeight+4, r=rHole+wt,  $fn=QualityMesh);
    }  
}

module labelPlace(){
    tetaS=asin((lt)/((SpoolOuterWidth)/2));
    tetaB=asin((LabelHolderSize+lt)/((SpoolOuterWidth)/2));
    

        rotate([0,0,-LabelStartRadius])
            rotate_extrude(angle=LabelRadius,convexity=10,$fn=QualityMesh)
                translate([SpoolOuterWidth/2, 0])
                    square([LabelHolderClearance+lt,BottomThickness]);

        rotate([0,0,-LabelStartRadius])
            rotate_extrude(angle=LabelRadius,convexity=10,$fn=QualityMesh*LabelHolderWidth/10)
                translate([SpoolOuterWidth/2+LabelHolderClearance, 0])
                    square([lt,BottomThickness+LabelHolderSize]);
        

        rotate([0,0,-LabelStartRadius])
            rotate_extrude(angle=tetaB,convexity=10,$fn=QualityMesh/2)
                translate([SpoolOuterWidth/2+LabelHolderClearance, 0])
                    square([lt,PartHeight*LabelHolderHeight/100]);

        rotate([0,0,-LabelStartRadius+LabelRadius-asin((LabelHolderSize+lt)/((SpoolOuterWidth+LabelHolderSize+lt)/2))])
            rotate_extrude(angle=tetaB,convexity=10,$fn=QualityMesh/2)
                translate([SpoolOuterWidth/2+LabelHolderClearance, 0])
                    square([lt,PartHeight*LabelHolderHeight/100]);
        

        rotate([0,0,-LabelStartRadius])
            rotate_extrude(angle=tetaS,convexity=10)
                translate([SpoolOuterWidth/2, 0])
                    square([lt+LabelHolderClearance,PartHeight*LabelHolderHeight/100]);

        rotate([0,0,+(LabelRadius)-LabelStartRadius-asin((lt)/(SpoolOuterWidth/2))])
            rotate_extrude(angle=tetaS,convexity=10)
                translate([SpoolOuterWidth/2, 0])
                    square([lt+LabelHolderClearance,PartHeight*LabelHolderHeight/100]);
 }
 

module mask (Start,Part){
if (Part<=180)
    union(){

        rotate([0,0,Start+90])   
            translate([-SpoolOuterWidth,-SpoolOuterWidth/2-2,-2])
                cube ([SpoolOuterWidth,2*SpoolOuterWidth,PartHeight+4]);

        rotate([0,0,Start+90+Part])   
                translate([0,-SpoolOuterWidth/2-2,-2])
                    cube ([SpoolOuterWidth,2*SpoolOuterWidth,PartHeight+4]);
    }
    
 if (Part>180) 
  difference(){
      translate([0,0,-1])   cylinder (h = PartHeight+2, r=SpoolOuterWidth/2+1,$fn=QualityMesh);
      mask(Start+Part,360-Part);
      }   
      
}

//output
module output(){
rotate([0,0,-80])
union(){
    difference(){
        difference(){
                union(){
                    tiroir();
                    sections();
                    percagePositif();
                    if (HandleType==1) handleG();
                    if (PrintedLabel==1) LetterBlock(PrintedLabelText,PrintedLabelSize);
                    if (LabelHolder==1)labelPlace();//no mask for label holder doesn't work online
                  } 
                union(){
                    if (PartRadius<=180) percageAngle();
                    if (HandleType==2) handleH();
                    if (PrintedLabel==2) LetterBlock(PrintedLabelText,PrintedLabelSize); 
                    }
              }
       union(){
           percageNegatif();
           mask(0,PartRadius);// only for online use can be remove for performance
       }
     }
 }
 }
 output();
