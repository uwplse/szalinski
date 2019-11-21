//Size of main square root
Function_Size = 10;//[2:20]

//Location of axis of rotation
Axis = 5;//[0:10]

//Position of axis
Axis_Position = 0;//[0:Below the root function,1: Above the root function]

//Angle that the function is cut at
Cut_Angle = 270; //[90,180,270,360]

//Controls whether a secondary square root is subtracted
Secondary_Function_Active = 1;//[1:on,0:off]

//Size of secondary function as % of full function
Secondary_Function_Size = 50;//[0:10:90]



integralDifference(
    maxVal = Function_Size,
    innerVal = (Secondary_Function_Active==1)?(Function_Size*Secondary_Function_Size/100):0,
    stepsPerUnit=30,
    axisLoc=Axis,
    angle = Cut_Angle,
    above = (Axis_Position==1));

module integralDifference(maxVal = 10, innerVal = 5,stepsPerUnit = 30, axisLoc = 0, angle = 360, above = false){
    difference(){
        3dsqrootPie(maxVal,stepsPerUnit,axisLoc,angle,above);
        translate([0,0,-.01])
        3dsqrootPie(innerVal,stepsPerUnit,above?axisLoc+(sqrt(maxVal)-sqrt(innerVal))+.01:axisLoc,angle,above);
    }
}


module 3dsqrootPie(maxVal = 10, stepsPerUnit = 30, axisLoc = 0, angle = 360, above = false){
    difference(){
        3dsqroot(maxVal,stepsPerUnit,above?-(sqrt(maxVal)+axisLoc+.01):axisLoc);
        translate([0,0,-.01])
        differenceShape(((maxVal+abs(axisLoc))*5),(360-angle));
    }
}

module differenceShape(extents = 10, angle = 180){
    if(angle > 0){
        granularity = angle/10;
        for(i=[0:granularity:angle-granularity]){
            hull(){
                rotate([0,0,i])
                    cube([extents,.1,extents]);
                rotate([0,0,i+granularity])
                    cube([extents,.1,extents]);
            }
        }
    }
}
    

//3dsqroot(maxVal = 10, axisLoc = 5);
module 3dsqroot(maxVal = 10, stepsPerUnit = 30, axisLoc = 0){
rotate_extrude($fn = stepsPerUnit*maxVal)translate([axisLoc,maxVal])rotate(-90)sqroot(maxVal,stepsPerUnit);
}
module sqroot(maxVal = 10,stepsPerUnit = 100){
    root = 
    [for(i = [0:(1/stepsPerUnit):maxVal])[i,sqrt(i)]];
    polygon(concat(root,[[maxVal,0]]));
}