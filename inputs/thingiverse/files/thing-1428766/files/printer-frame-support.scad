//Supports for Prusa i3 printer.
//By Jkk79.

//
showAssembly=0;//[1:Yes,0:No]
//
part="leg";//[top:Top holder part,leg:Leg part]

//distance between the aluminium frame and the center of the threaded rods at the end of the Y-axis. Mine is 119mm. Adjust this if yours is something else.
frameDistance=119;
//The diameter of the new threaded support rods, M8 default. You can use a smaller one, larger won't fit, and even M5 would be strong enough.
supportRodDiameter=8;
/*[Leg part]*/
//Cut edges off of the leg part. 0=no cuts, no overhang at corners, easier to print.
legChamfer=2;//[0,1,2,3,4]
/*[Top part]*/
//The thickness of the top holder part. You need to replace the M3 screws with at least this much longer M3 screws.
topHolderThickness=6;
//Cut the top holder corners, 0=no cut.
topHolderCorners=5;
//The alignment the top holder should be printed at. Notice: bottom will be cut differently and different parts are at right angle to the print bed.
topHolderPrintAlign=1;//[1:Upside down,2:Right way up]
//The height of the top holder part.  Set to at least 18 if printing the holder right way up to avoid M8 washer intersecting with M3 nut. Also if your Y-axis's end is considerably farther off from the frame than the default, you may need to increase the value.
topHolderHeight=16;//[16:22]

//Adjust if you think you need to.
washerCutDepth=7;//[5:11]


/*[Settings you shouldn't need to change]*/
//The diameter of the threaded rods at the end of the Y-axis. M8 default, so 8mm. You need to swap these to ones that are 370mm long.
yEndRodDiameter=8;
//the width of the leg part.
legWidth=22;
//The thickness of the leg part.
legThickness=18;
//The lower Y-axis end rod center distance from ground.
holeDistance1=10;
//The upper Y-axis end rod center distance from ground.
holeDistance2=30;
//Height of the frame, should be 370mm.
frameHeight=370;
//Screw size. default is M3.
topHolderScrewSize=3;


/*[Hidden]*/
$fn=90;
//The width of the top holder part. 40. For now changing this only breaks things.
topHolderWidth=40;
//Calculated angle of the new support rod.
angle=atan2(frameHeight-holeDistance2,frameDistance+holeDistance2-holeDistance1-10);
//Calculated length of the new support rod.
supportRodLength=sqrt(pow(frameHeight-holeDistance2,2)+pow(frameDistance+holeDistance2-holeDistance1-10,2))+legWidth;
//convexity setting, just so it's easier to switch. 
conv=8;

echo("The angle of the rods: ",angle);
echo("The new support rods need to be at least ",supportRodLength,"mm long");
echo("would be nice to get an echo support for customizer.");
print_part();




if(showAssembly==1){  
   translate([-60,-185,0])%assembly();
}else{}


module print_part(){
    if(part=="top"){
        if(topHolderPrintAlign==1){
            translate([0,0,topHolderHeight])rotate([0,180,0])topHolder();//align 1
        }
        else{
            translate([0,40,0])rotate([0,90-angle,180])topHolder(); //align 2
        }
    }
    else if(part=="leg"){
        rotate([90,0,-90])leg();
    }
}




module leg(){

    difference(){
        union(){
            translate([legWidth/2,legThickness,holeDistance2])rotate([90,0,0])legBend();
            legPart();
            translate([legWidth/2,0,holeDistance2])rotate([0,angle,0]){
                translate([-legWidth/2,0,legWidth/2-legWidth/2]){
                    difference(){
                        legPart();
                        translate([0,0,-legWidth/2]){
                        translate([-1,legThickness/2,holeDistance2])rotate([0,90,0])cylinder(legWidth+2,supportRodDiameter/2+0.2,supportRodDiameter/2+0.2);
                        translate([0,0,holeDistance2+legWidth/2-legChamfer])rotate([0,-45,0])cube([legChamfer*2,20,legChamfer*2]);
                        translate([legWidth,0,holeDistance2+legWidth/2-legChamfer])rotate([0,-45,0])cube([legChamfer*2,20,legChamfer*2]);
                        translate([0,0,holeDistance2+legWidth/2-legChamfer])rotate([45,0,0])cube([legWidth,legChamfer*2,legChamfer*2]);
                        translate([0,legThickness,holeDistance2+legWidth/2-legChamfer])rotate([45,0,0])cube([legWidth,legChamfer*2,legChamfer*2]);
                        }
                    }
                }
            }
        }
        translate([legWidth/2,legThickness+1,holeDistance1])rotate([90,0,0])cylinder(legThickness+2,yEndRodDiameter/2+0.2,yEndRodDiameter/2+0.2);
        translate([legWidth/2,legThickness+1,holeDistance2])rotate([90,0,0])cylinder(legThickness+2,yEndRodDiameter/2+0.2,yEndRodDiameter/2+0.2);
    }
    //translate([legWidth,20,30-tan(angle/2)*legWidth/2])rotate([90,0,0])cylinder(30,2,2); //inner bend intersection.
}

module legPart(){
    linear_extrude(height=holeDistance2,convexity=conv)polygon(points=[[legChamfer,0],[legWidth-legChamfer,0],[legWidth,legChamfer],[legWidth,legThickness-legChamfer],[legWidth-legChamfer,legThickness],[legChamfer,legThickness],[0,legThickness-legChamfer],[0,legChamfer]]);
}
    
module legBend(){    
    difference(){
        rotate_extrude(convexity=conv)polygon(points=[[0,0],[(legWidth/2)-legChamfer,0],[legWidth/2,legChamfer],[legWidth/2,legThickness-legChamfer],[legWidth/2-legChamfer,legThickness],[0,legThickness]]);
    }
}


module topHolder(){

    union(){
        difference(){
            union(){
                //hull(){
                    difference(){
                        cube([topHolderThickness,topHolderWidth,topHolderHeight]);
                        translate([-1,0,topHolderHeight-topHolderCorners])rotate([45,0,0])cube([20,20,20]);   
                        translate([0,topHolderWidth,0])mirror([0,1,0])translate([-1,0,topHolderHeight-topHolderCorners])rotate([45,0,0])cube([20,20,20]);   

            }
                    translate([0,20,topHolderHeight])mirror([0,0,1])hull(){
                    rotate([0,90-angle,0])translate([10,0,0])cylinder(25,10,10);
                    rotate([0,0,0])translate([0,0,0])cylinder(25,10,10);
                    }
               // }//hull
            }
            translate([0,20,topHolderHeight])mirror([0,0,1])rotate([0,90-angle,0])translate([10,0,-5])cylinder(30,supportRodDiameter/2+0.2,supportRodDiameter/2+0.2);             
            translate([0,20,topHolderHeight])mirror([0,0,1])rotate([0,90-angle,0])translate([10,0,0])cylinder(washerCutDepth,9.2,9.2);
                
            translate([-1,10,topHolderHeight-10])rotate([0,90,0])cylinder(20,topHolderScrewSize/2+0.2,topHolderScrewSize/2+0.2);
            translate([-1,30,topHolderHeight-10])rotate([0,90,0])cylinder(20,topHolderScrewSize/2+0.2,topHolderScrewSize/2+0.2);
            hull(){
                translate([topHolderThickness,10,topHolderHeight-10])rotate([0,90,0])cylinder(20,topHolderScrewSize+1.5,topHolderScrewSize+1.5);
                translate([topHolderThickness,10,0])rotate([0,90,0])cylinder(20,topHolderScrewSize+1.5,topHolderScrewSize+1.5);
                translate([topHolderThickness,0,topHolderHeight-10])rotate([0,90,0])cylinder(20,topHolderScrewSize+1.5,topHolderScrewSize+1.5);
                translate([topHolderThickness,0,0])rotate([0,90,0])cylinder(20,topHolderScrewSize+1.5,topHolderScrewSize+1.5);
                
            }
            hull(){
                translate([topHolderThickness,30,topHolderHeight-10])rotate([0,90,0])cylinder(20,topHolderScrewSize+1.5,topHolderScrewSize+1.5);
                translate([topHolderThickness,30,0])rotate([0,90,0])cylinder(20,topHolderScrewSize+1.5,topHolderScrewSize+1.5);
                translate([topHolderThickness,40,topHolderHeight-10])rotate([0,90,0])cylinder(20,topHolderScrewSize+1.5,topHolderScrewSize+1.5);
                translate([topHolderThickness,40,0])rotate([0,90,0])cylinder(20,topHolderScrewSize+1.5,topHolderScrewSize+1.5);
            }
           
           if(topHolderPrintAlign==1){
               translate([topHolderThickness,-1,0])rotate([0,-90+angle,0])mirror([0,0,1])cube([40,topHolderWidth+2,40]);//bottom cutter
              translate([-1,0,-20])rotate([0,0,0])cube([40,topHolderWidth,20]);//bottom cutter 2
            }
            else{
               translate([0,-1,0])rotate([0,-90+angle,0])mirror([0,0,1])translate([-5,0,0])cube([40,topHolderWidth+2,40]); //alternative bottom cutter
            }

            translate([-10,0,topHolderHeight])rotate([0,0,0])cube([40,40,20]);//top cutter
            
            translate([-40,0,-20])rotate([0,0,0])cube([40,40,60]);//back cutter
            

        }
    }
}


module assembly(){
    color("lime")translate([0,0,frameHeight-topHolderHeight])rotate([0,0,0])topHolder();
    color("lime")translate([0,370-topHolderWidth,frameHeight-topHolderHeight])rotate([0,0,0])topHolder();
    color("lime")translate([frameDistance-legWidth/2,topHolderWidth/2-legThickness/2,0])rotate([0,0,0])leg(); 
    color("lime")translate([frameDistance-legWidth/2,370-topHolderWidth/2-legThickness/2,0])rotate([0,0,0])leg();

    %difference(){
        translate([-6,0,0])cube([6,370,frameHeight]);
        translate([-7,55,35])cube([8,370-55-55,frameHeight-40-35]);
        }
    color("yellow")translate([0,topHolderWidth/2,frameHeight])mirror([0,0,0])rotate([0,90+angle,0])translate([-10,0,0])cylinder(supportRodLength,supportRodDiameter/2 ,supportRodDiameter/2);
    color("yellow")translate([0,370-topHolderWidth/2,frameHeight])mirror([0,0,0])rotate([0,90+angle,0])translate([-10,0,0])cylinder(supportRodLength,4,4); //m8 rod
    color("khaki")translate([frameDistance,0,holeDistance1])rotate([-90,0,0])cylinder(370,yEndRodDiameter/2,yEndRodDiameter/2);
    color("khaki")translate([frameDistance,0,holeDistance2])rotate([-90,0,0])cylinder(370,yEndRodDiameter/2,yEndRodDiameter/2);
    %translate([frameDistance-legWidth/2,100-legThickness/2,0])cube([legWidth,legThickness,50]);
    %translate([frameDistance-legWidth/2,370-100-legThickness/2,0])cube([legWidth,legThickness,50]);
    
    %translate([frameDistance-335-legWidth/2,100-legThickness/2,0])cube([legWidth,legThickness,50]);
    %translate([frameDistance-335-legWidth/2,370-100-legThickness/2,0])cube([legWidth,legThickness,50]);
    %translate([frameDistance-335,82.5,holeDistance1])rotate([-90,0,0])cylinder(205,4,4);
    %translate([frameDistance-335,82.5,holeDistance2])rotate([-90,0,0])cylinder(205,4,4);
        
    %translate([frameDistance+21,100,holeDistance2-holeDistance1])rotate([0,-90,0])cylinder(380,5,5);
    %translate([frameDistance+21,370-100,holeDistance2-holeDistance1])rotate([0,-90,0])cylinder(380,5,5);
        
    %translate([frameDistance+8,100,48])rotate([0,-90,0])cylinder(350,4,4);
    %translate([frameDistance+8,370-100,48])rotate([0,-90,0])cylinder(350,4,4);
        
}


