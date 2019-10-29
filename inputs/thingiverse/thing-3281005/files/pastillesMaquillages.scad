// Written by Remi Vansnickt <>
//Feel free to tip me : https://www.thingiverse.com/Remivans/about
//Thingiverse : https://www.thingiverse.com/thing:3281005
//Licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license.
/* [Main] */
//(mm) dimention of your circle pad
partWidth=30;//[10:0.2:50]
//(mm) Height of your pad
partHeight=3;//[1:0.2:5]

//size of playset X
sizeBoxX=1;//[1:1:5]
//size of playset Y
sizeBoxY=1;//[1:0.5:3]

//part clearance
clearance=0.4;//[0.3:0.05:0.6]

//Witch output do you want ?!
output=1;//[0:Feeled box,1:box with mirror,6:square top box,7:rectangle top box,2:circle pad,3:circle pad (small),4:rectangular pad,5:square pad]



numberWall=8*1;//[2:1:10]
PNW=0.4+0.005;
realSizeBoxWidth=sizeBoxX*(2*PNW*numberWall+partWidth)+2*PNW*numberWall;
realSizeBoxHeight=sizeBoxY*(2*PNW*numberWall+partWidth)+2*PNW*numberWall;

	//bottomBox
	if(output==0 || output==1 || output==6 || output==7)boiteHomeMade(partHeight,partWidth,sizeBoxX,sizeBoxY,true);
	if(output==0)feelBox(partHeight,partWidth,sizeBoxX,sizeBoxY);
	//topBox	
	translate([0,realSizeBoxHeight,0])rotate(180,[0,0,1])
	union(){
		if(output==0 || output==1 || output==6 || output==7)boiteHomeMade(partHeight,partWidth,sizeBoxX,sizeBoxY,false);
		//feelTopBox(partHeight,partWidth,sizeBoxX,sizeBoxY);
	}
	//pad output
	if(output==2)color(rands(0,1,3))boxcylinder(partWidth,partHeight);
	if(output==3)color(rands(0,1,3))boxcylinder(partWidth/2,partHeight);
	if(output==4)color(rands(0,1,3))boxSquareRound(partWidth+.5,partWidth/2-3+PNW,partHeight);
	if(output==5)color(rands(0,1,3))boxSquareRound(partWidth,partWidth,partHeight);


module cubeRound(partWidth,partHeight,partZ,rayon){
		hull(){
		translate([+partWidth/2-rayon,partHeight/2-rayon,0])cylinder(r=rayon,h=partZ,$fn=30);
		translate([-partWidth/2+rayon,-partHeight/2+rayon,0])cylinder(r=rayon,h=partZ,$fn=30);	
		translate([-partWidth/2+rayon,+partHeight/2-rayon,0])cylinder(r=rayon,h=partZ,$fn=30);	
		translate([+partWidth/2-rayon,-partHeight/2+rayon,0])cylinder(r=rayon,h=partZ,$fn=30);		
			}
		}
module boxcylinder(partWidth,partZ){
	difference(){
			cylinder(r=partWidth/2,h=partZ,$fn=50);
			//translate([0,0,partZ-PNW])scale([partWidth-PNW,partWidth-PNW,1])
			//random2(partZ);
			translate([0,0,partZ-PNW])cylinder(r=partWidth/2-2*PNW,h=3,$fn=50);
		}
}
module boxSquareRound(partWidth,partHeight,partZ){
	difference(){
		cubeRound(partWidth,partHeight,partZ,1);
		translate([0,0,partZ-PNW])cubeRound(partWidth-4*PNW,partHeight-4*PNW,partZ,1);
    }
}
module random(partZ){
		hull(){
			for(i=[0:10:360])
			{
			randomize=rands(0.3,0.5,1)[0];
			scale([1/2,1/2,1])translate([randomize*cos(i),randomize*sin(i),0])cylinder(r=PNW,h=partZ,$fn=20);
		
			}
		}
		
}//random();
module bottomBox(partWidth,partZ,numberPartWidth,numberPartHeight,margin=0){
	realSizeBoxWidth=numberPartWidth*(2*PNW*numberWall+partWidth)+2*PNW*numberWall-2*margin;
	realSizeBoxHeight=numberPartHeight*(2*PNW*numberWall+partWidth)+2*PNW*numberWall-2*margin;
	rayon=3;
	hull(){
				translate([-realSizeBoxWidth/2+rayon,-realSizeBoxHeight/2+rayon,0])cylinder(r=rayon,h=partZ*2,$fn=50);
				translate([+realSizeBoxWidth/2-+rayon,-realSizeBoxHeight/2+rayon,0])cylinder(r=rayon,h=partZ*2,$fn=50);
				translate([+realSizeBoxWidth/2-+rayon,+realSizeBoxHeight/2-rayon-clearance,0])cylinder(r=rayon,h=partZ*2,$fn=50);
				translate([-realSizeBoxWidth/2+rayon,+realSizeBoxHeight/2-rayon-clearance,0])cylinder(r=rayon,h=partZ*2,$fn=50);
			}
}
module bottomCharniere(partWidth,partZ,numberPartWidth,numberPartHeight){
	translate([0,realSizeBoxHeight/2,2*partZ])
	hull(){
		translate([realSizeBoxWidth/2-partZ,0,0])sphere(r=partZ,$fn=20);
		translate([-realSizeBoxWidth/2+partZ,0,0])sphere(r=partZ,$fn=20);
	}
		
}
module bottomCharniereHole(partWidth,partZ,numberPartWidth,numberPartHeight){
	for(i=[-numberPartWidth/2:1:numberPartWidth/2])
	translate([i*(partWidth+2*PNW*numberWall),realSizeBoxHeight/2,2*partZ])
	union(){
		rotate(90,[0,1,0])
			cylinder(r=partZ+clearance,h=partWidth/2+clearance,$fn=20,center=true);
		translate([partWidth/4+clearance,0,0])
			sphere(r=partZ-clearance,$fn=20);
		translate([-partWidth/4-clearance,0,0])
			sphere(r=partZ-clearance,$fn=20);
	}		
}
module topCharniereHole(partWidth,partZ,numberPartWidth,numberPartHeight){
	for(i=[-numberPartWidth/2:1:numberPartWidth/2])
	translate([i*(partWidth+2*PNW*numberWall),realSizeBoxHeight/2,2*partZ])
	union(){
		translate([partWidth/2,0,0])rotate(90,[0,1,0])cylinder(r=partZ+clearance,h=partWidth/2+clearance,$fn=20,center=true);
		translate([-partWidth/2,0,0])rotate(90,[0,1,0])cylinder(r=partZ+clearance,h=partWidth/2+clearance,$fn=20,center=true);
	}		
}
module topCharniereSphere(partWidth,partZ,numberPartWidth,numberPartHeight){
	for(i=[-numberPartWidth/2:1:numberPartWidth/2])
	translate([i*(partWidth+2*PNW*numberWall),realSizeBoxHeight/2,2*partZ])
	union(){
		if(i!=numberPartWidth/2){
		translate([partWidth/4-clearance/2,0,0])sphere(r=partZ-2*clearance,$fn=20);
		}
		if(i!=-numberPartWidth/2)
		{
		translate([-partWidth/4+clearance/2,0,0])sphere(r=partZ-2*clearance,$fn=20);
		}
	}	
}

module bottomCloseHole(partWidth,partZ,numberPartWidth,numberPartHeight){
		translate([0,-realSizeBoxHeight/2,2*partZ])rotate(90,[1,0,0])cylinder(r=1.25*partZ+clearance,h=2*PNW*partZ+clearance,$fn=2*partWidth,center=true);
		translate([0,-realSizeBoxHeight/2,2*partZ-partZ/4])cylinder(r=partZ/2+clearance,h=PNW*partZ/2,$fn=2*partWidth,center=true);
}
module topClose(partWidth,partZ,numberPartWidth,numberPartHeight){
	union(){
		translate([0,-realSizeBoxHeight/2+PNW*partZ,2*partZ])rotate(90,[1,0,0])
			difference(){
				cylinder(r=1.25*partZ,h=PNW*partZ,$fn=2*partWidth);
				translate([0,3*partZ/2,PNW*partZ])cube([2.5*partZ,2*partZ,3*PNW*partZ],center=true);
			}
		translate([0,-realSizeBoxHeight/2,2*partZ+partZ/4])
			difference(){
				cylinder(r=partZ/2+clearance,h=PNW*partZ/3,$fn=2*partWidth,center=true);
				translate([0,-partZ,0])cube([2*partZ,2*partZ,PNW*partZ],center=true);
			}
		}
}

module feelBox(partZ,partWidth,numberPartWidth,numberPartHeight){
	for (i=[1:1:numberPartWidth]){
		placeElementX=-realSizeBoxWidth/2+partWidth/2+2*PNW*numberWall+(i-1)*(partWidth+2*PNW*numberWall);
		placeElementY=-realSizeBoxHeight/2+partWidth/2+2*PNW*numberWall;
		if(numberPartHeight>=1)
			translate([placeElementX,placeElementY,partZ])
				color(rands(0,1,3))boxcylinder(partWidth,partZ);
		if(numberPartHeight==1.5)
			translate([placeElementX,-placeElementY,partZ])
			union(){
				translate([(partWidth/2+PNW*numberWall)/2,partWidth/4,0])
					color(rands(0,1,3))boxcylinder(partWidth/2,partZ);
				translate([-(partWidth/2+PNW*numberWall)/2,+partWidth/4,0])
					color(rands(0,1,3))boxcylinder(partWidth/2,partZ);
			}
		if(numberPartHeight>=2)
			translate([placeElementX,-placeElementY,partZ])
			union(){
				translate([(partWidth/2+PNW*numberWall)/2,(partWidth/2+PNW*numberWall)/2,0])
					color(rands(0,1,3))boxcylinder(partWidth/2,partZ);
				translate([-(partWidth/2+PNW*numberWall)/2,-(partWidth/2+PNW*numberWall)/2,0])
					color(rands(0,1,3))boxcylinder(partWidth/2,partZ);
				translate([-(partWidth/2+PNW*numberWall)/2,+(partWidth/2+PNW*numberWall)/2,0])
					color(rands(0,1,3))boxcylinder(partWidth/2,partZ);
					
				translate([+(partWidth/2+PNW*numberWall)/2,-(partWidth/2+PNW*numberWall)/2,0])
					color(rands(0,1,3))boxcylinder(partWidth/2,partZ);
			}
		if(numberPartHeight==2.5)
			translate([placeElementX,0,partZ])
			union(){
				translate([0,0,0])
					color(rands(0,1,3))boxSquareRound(partWidth+.5,partWidth/2-3+PNW,partZ);
			}
		if(numberPartHeight>=3)
			translate([placeElementX,0,partZ])
			union(){
				translate([0,+(partWidth/2+PNW*numberWall)/2,0])
					color(rands(0,1,3))boxSquareRound(partWidth+.5,partWidth/2-3+PNW,partZ);
				translate([0,-(partWidth/2+PNW*numberWall)/2,0])
					color(rands(0,1,3))boxSquareRound(partWidth+.5,partWidth/2-3+PNW,partZ);
			}
	}
	
}
module feelTopBox(partZ,partWidth,numberPartWidth,numberPartHeight){
			for (i=[1:1:numberPartWidth]){
				for (j=[1:1:numberPartHeight]){
					placeElementX=-realSizeBoxWidth/2+partWidth/2+2*PNW*numberWall+(i-1)*(partWidth+2*PNW*numberWall);
					placeElementY=-realSizeBoxHeight/2+partWidth/2+2*PNW*numberWall+(j-1)*(partWidth+2*PNW*numberWall);
					translate([placeElementX,0,partZ])
						union(){
							translate([0,+(partWidth/2+PNW*numberWall)/2,0])
								color(rands(0,1,3))boxSquareRound(partWidth+.5,partWidth/2-3+PNW,partZ);
							translate([0,-(partWidth/2+PNW*numberWall)/2,0])
								color(rands(0,1,3))boxSquareRound(partWidth+.5,partWidth/2-3+PNW,partZ);
						}
				}
			}
}

module boiteHomeMade(partZ,partWidth,numberPartWidth,numberPartHeight,bottom=false){
	difference(){
		//box top+bottom
		union(){
			bottomBox(partWidth,partZ,numberPartWidth,numberPartHeight);
			bottomCharniere(partWidth,partZ,numberPartWidth,numberPartHeight);
		}
		//percage bottom
		union(){
			if (bottom==true){
				for (i=[1:1:numberPartWidth]){
					placeElementX=-realSizeBoxWidth/2+partWidth/2+2*PNW*numberWall+(i-1)*(partWidth+2*PNW*numberWall);
					placeElementY=-realSizeBoxHeight/2+partWidth/2+2*PNW*numberWall;
					
					if(numberPartHeight>=1)
						translate([placeElementX,placeElementY,partZ-clearance/2])
							boxcylinder(partWidth+PNW,2*partZ);
					if(numberPartHeight==1.5)
						translate([placeElementX,-placeElementY,partZ-clearance/2])
						union(){
							translate([(partWidth/2+PNW*numberWall)/2,+partWidth/4,0])
								boxcylinder(partWidth/2+PNW,2*partZ);
							translate([-(partWidth/2+PNW*numberWall)/2,+partWidth/4,0])
								boxcylinder(partWidth/2+PNW,2*partZ);
						}
					if(numberPartHeight>=2)
						translate([placeElementX,-placeElementY,partZ-clearance/2])
						union(){
							translate([(partWidth/2+PNW*numberWall)/2,(partWidth/2+PNW*numberWall)/2,0])
								boxcylinder(partWidth/2+PNW,2*partZ);
							translate([-(partWidth/2+PNW*numberWall)/2,+(partWidth/2+PNW*numberWall)/2,0])
								boxcylinder(partWidth/2+PNW,2*partZ);
							translate([-(partWidth/2+PNW*numberWall)/2,-(partWidth/2+PNW*numberWall)/2,0])
								boxcylinder(partWidth/2+PNW,2*partZ);
							translate([+(partWidth/2+PNW*numberWall)/2,-(partWidth/2+PNW*numberWall)/2,0])
								boxcylinder(partWidth/2+PNW,2*partZ);
						}
							
					if(numberPartHeight==2.5)
						translate([placeElementX,0,partZ-clearance/2])
							union(){
							translate([0,0,0])
								boxSquareRound(partWidth+.5+PNW,partWidth/2-3+PNW,2*partZ);
							}
					if(numberPartHeight==3)
						translate([placeElementX,0,partZ-clearance/2])
							union(){
							translate([0,+(partWidth/2+PNW*numberWall)/2,0])
								boxSquareRound(partWidth+.5+PNW,partWidth/2-3+PNW,2*partZ);		
							translate([0,-(partWidth/2+PNW*numberWall)/2,0])
								boxSquareRound(partWidth+.5+PNW,partWidth/2-3+PNW,2*partZ);
							}
		}
		bottomCharniereHole(partWidth,partZ,numberPartWidth,numberPartHeight);
		bottomCloseHole(partWidth,partZ,numberPartWidth,numberPartHeight);
		}
		else{
			if (output==1)translate([0,0,2*partZ-1])bottomBox(partWidth,partZ,numberPartWidth,numberPartHeight,PNW*numberWall);
			if (output==6){
			for (i=[1:1:numberPartWidth]){
				if(numberPartHeight%1!=0){
					placeElementX=-realSizeBoxWidth/2+partWidth/2+2*PNW*numberWall+(i-1)*(partWidth+2*PNW*numberWall);
					placeElementY=-realSizeBoxHeight/2+partWidth/2+2*PNW*numberWall-0.5*(partWidth+2*PNW*numberWall)+(partWidth/2+PNW*numberWall)/2;
					translate([placeElementX,placeElementY,partZ-clearance/2])
						boxSquareRound(partWidth+.5+PNW,partWidth/2-3+PNW,2*partZ);
				}
				for (j=[0.5:1:numberPartHeight-numberPartHeight%1]){
					echo ("j",j);
					placeElementX=-realSizeBoxWidth/2+partWidth/2+2*PNW*numberWall+(i-1)*(partWidth+2*PNW*numberWall);
					placeElementY=-realSizeBoxHeight/2+partWidth/2+2*PNW*numberWall+(j-0.5)*(partWidth+2*PNW*numberWall);;
					translate([placeElementX,-placeElementY,partZ-clearance/2])
						boxSquareRound(partWidth+PNW,partWidth+PNW,2*partZ);
				}//endloop
			}//endloop
			}//end 6
			if (output==7){
			for (i=[1:1:numberPartWidth]){
				for (j=[0.5:0.5:numberPartHeight]){
					placeElementX=-realSizeBoxWidth/2+partWidth/2+2*PNW*numberWall+(i-1)*(partWidth+2*PNW*numberWall);
					placeElementY=-realSizeBoxHeight/2+partWidth/2+2*PNW*numberWall+(j-1)*(partWidth+2*PNW*numberWall)+(partWidth/2+PNW*numberWall)/2;
					translate([placeElementX,placeElementY,partZ-clearance/2])
						boxSquareRound(partWidth+.5+PNW,partWidth/2-3+PNW,2*partZ);
				}//endloop
			}//endloop
			}//end 7
		
							
		
				
			topCharniereHole(partWidth,partZ,numberPartWidth,numberPartHeight);
		}
	}
	}
	if (bottom==false){
		topCharniereSphere(partWidth,partZ,numberPartWidth,numberPartHeight);
		topClose(partWidth,partZ,numberPartWidth,numberPartHeight);
	}
	else{
		//bottomCloseHole(partWidth,partZ,numberPartWidth,numberPartHeight,partZ);
	}
}



	
		
			
		