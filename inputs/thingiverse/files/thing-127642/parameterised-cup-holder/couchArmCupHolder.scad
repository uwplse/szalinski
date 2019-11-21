chairArmWidth=130;
cupHolderLength=100;
cupHolderHeight=90;
widthOfCupHolder=10;
curveRadius=7;
smoothingAmount=10;
diameterOfCup=90;
module cupHolderBase(){
difference(){
hull(){
for(i=[1:smoothingAmount]){
translate([curveRadius-curveRadius*sin(i*90/smoothingAmount),0,0])cube([(cupHolderHeight+2*widthOfCupHolder-curveRadius+2*curveRadius*sin(i*90/smoothingAmount)),cupHolderLength,(cupHolderHeight-curveRadius+curveRadius*cos(i*90/smoothingAmount))]);
}
}
hull(){
for(i=[1:smoothingAmount]){
translate([widthOfCupHolder+curveRadius-curveRadius*sin(i*90/smoothingAmount),-10,-10])cube([(cupHolderHeight-curveRadius+2*curveRadius*sin(i*90/smoothingAmount)),cupHolderLength+20,(cupHolderHeight-widthOfCupHolder-curveRadius+10+curveRadius*cos(i*90/smoothingAmount))]);
}
}
}
}
difference(){
cupHolderBase();

translate([(chairArmWidth-widthOfCupHolder)/2,cupHolderLength/2,cupHolderHeight-widthOfCupHolder/2])cylinder(r=diameterOfCup/2,h=smoothingAmount/2);
}