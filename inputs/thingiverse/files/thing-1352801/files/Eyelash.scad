// DiGiorgio Studant No18 2004
//  Width: 52
//  FirstCordOffset: 4
//  CordStep: 9
// Giannini Estudos Feito a mão
//  Width: 48
//  FirstCordOffset: 2.5
//  CordStep: 8.6


CordDiameter = 1.4;
FirstCordOffset = 2.5;
CordStep = 8.6;
Width = 48;
Height=10;
Depth=5;
TextOffsetX = 14;
TextOffsetZ = 4;
FontSize = 5;
Text = "Rafael";

rotate(a=[90,0,0]){
    difference(){
        cube([Width,Depth,Height]);
        for(d = [0:5]){
            translate([FirstCordOffset+CordStep*d,7,Height-0.5]){
                desv = (d==3 ? 4.5 : (d==2 ? -4.5 : 0));
                rotate(a=[90,0,desv])
                    hull(){
                        cylinder(d=CordDiameter,h=Depth*2,$fn=50);
                        translate([0,2,0]) 
                            cylinder(d=CordDiameter,h=Depth*2,$fn=50);
                    }
            }
        }
        translate([TextOffsetX,0.5,TextOffsetZ])
            rotate(a=[90,0,0])
                linear_extrude(2) 
                    text(Text,FontSize);
    }
}