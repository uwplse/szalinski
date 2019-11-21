/* [General] */
Thickness = 1;
ModuleSideSizeTop=20;
ModuleSideSizeBottom=10;
ModuleHeight = 30;
NumberModulesX = 3;
NumberModulesY = 4;

/* [Water] */
ScapeHole = "false"; //[true, false]
ScapeHoleDiameter = 1.5;
IrrigationSystem = "true"; //[true, false]
IrrigationSystemSize = 2.4;
IrrigationSystemThickness = 0.7;

/* [HIDDEN] */
sqr2 = sqrt(2);
$fn=30;

vase();

module vase(){
    tkDiv = 4;
    stepX = ModuleSideSizeTop-Thickness/tkDiv;
    stepY = ModuleSideSizeTop-Thickness/tkDiv;
    for(x=[0:NumberModulesX-1])
        for(y=[0:NumberModulesY-1])
            translate([x*stepX,
                       y*stepY])
                modulo();
    if(IrrigationSystem == "true"){
        translate([Thickness/2/tkDiv,0,-IrrigationSystemThickness/2])
        for(x=[1:NumberModulesX-1])
            translate([x*stepX-IrrigationSystemSize/2-
                        ModuleSideSizeTop/2,
                       -ModuleSideSizeTop/2,ModuleHeight])
                difference(){
                    iySize = NumberModulesY*stepY+Thickness/tkDiv;
                    cube([IrrigationSystemSize,
                          iySize,
                          IrrigationSystemSize]);
                    translate([IrrigationSystemThickness,
                               IrrigationSystemThickness,
                               IrrigationSystemThickness])
                        cube([IrrigationSystemSize-IrrigationSystemThickness*2,
                              iySize-IrrigationSystemThickness*2,
                              IrrigationSystemSize]);
                    for(y=[0:NumberModulesY-1]){
                        translate([-IrrigationSystemSize/2,
                                  y*(ModuleSideSizeTop-Thickness/2)+ModuleSideSizeTop/2,
                                  IrrigationSystemThickness]) 
                            cube([IrrigationSystemSize*2,Thickness,IrrigationSystemSize*2]);
                    }
                }
    }
}
module modulo(){
    rotate(a=[0,0,45]) difference(){ 
        cylinder(d1=ModuleSideSizeBottom*sqr2,d2=ModuleSideSizeTop*sqr2,h=ModuleHeight,$fn=4);
        translate([0,0,Thickness]) 
            cylinder(d1=(ModuleSideSizeBottom-Thickness*2)*sqr2,
                     d2=(ModuleSideSizeTop-Thickness*2)*sqr2,h=ModuleHeight,$fn=4);
        if(ScapeHole == "true"){
            cylinder(d=ScapeHoleDiameter,h=Thickness*3,center=true);
        }
    }
}