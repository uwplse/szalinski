//created by ivanchaos
//this is a test thing for dissolvable material dual-extrusion
//change the "gap" value according to your printer's nozzle diameter for suitable test object. 



cubeEdgeSize = 5;
sectionHeight=2.5;
pivotPillarSize =5;
gap=0.4;	//measured in mm


difference(){
translate([-cubeEdgeSize/2-gap-pivotPillarSize,-cubeEdgeSize/2-gap-pivotPillarSize,-sectionHeight*0.5])cube([cubeEdgeSize+2*pivotPillarSize,cubeEdgeSize+2*pivotPillarSize,sectionHeight]);
cylinder(sectionHeight,pivotPillarSize+gap,pivotPillarSize+gap,true);}
union(){
cylinder(sectionHeight*3+gap*2,pivotPillarSize,pivotPillarSize,true);



rotate([0,0,45])translate([-cubeEdgeSize/2-pivotPillarSize,-cubeEdgeSize/2-pivotPillarSize,sectionHeight*0.5+gap])cube([cubeEdgeSize+2*pivotPillarSize,cubeEdgeSize+2*pivotPillarSize,sectionHeight]);

rotate([0,0,45])translate([-cubeEdgeSize/2-pivotPillarSize,-cubeEdgeSize/2-pivotPillarSize,-sectionHeight*1.5-gap])cube([cubeEdgeSize+2*pivotPillarSize,cubeEdgeSize+2*pivotPillarSize,sectionHeight]);
}