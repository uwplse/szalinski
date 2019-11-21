//TODAS LAS MEDIDAS SON EN MM


difference()
{
//-- square([largo,ancho],center bool) 
// linear_extrude(10)  para darle altura en el eje z 
linear_extrude(9)square([49.7,2],true);

//tomamos en cuenta 1mm del ancho del palo
color ("gray")cylinder (r=18.8,h=9,$fn=600);

}

difference()
{
//-- translate([x,y,z]) 
linear_extrude(9)translate([-1,-24.85,0]) square([2,49.7],false);

color ("gray")cylinder (r=18.8,h=9,$fn=600);

}

difference()
{
//-- rotate([x,y,z]) en degrease 
linear_extrude(9)rotate([0,0,45]) translate([-1,-24.85,,0])square([2,49.7],false);
color ("gray")cylinder (r=18.8,h=9,$fn=600);

}

difference()
{
linear_extrude(9)rotate([0,0,135]) translate([-1,-24.85,,0])square([2,49.7],false);
color ("gray")cylinder (r=18.8,h=9,$fn=600);

}


difference()
{
linear_extrude(9)rotate([0,0,22.5]) translate([-1,-24.85,,0])square([2,49.7],false);
color ("gray")cylinder (r=18.8,h=9,$fn=600);

}


difference()
{
linear_extrude(9)rotate([0,0,67.5]) translate([-1,-24.85,0])square([2,49.7],false);
color ("gray")cylinder (r=18.8,h=9,$fn=600);

}


difference()
{
linear_extrude(9)rotate([0,0,112.5]) translate([-1,-24.85,,0])square([2,49.7],false);
color ("gray")cylinder (r=18.8,h=9,$fn=600);

}

difference()
{
linear_extrude(9)rotate([0,0,157.5]) translate([-1,-24.85,,0])square([2,49.7],false);
color ("gray")cylinder (r=18.8,h=9,$fn=600);

}
// scale([x,y,z])

//cylinder (radio,altura);
//diference ()  es una funcion para restar
difference()
{
color ("blue")cylinder (r=22.4,h=9,$fn=1000); //cilindro externo ARO2
color ("gray")cylinder (r=18.8,h=9,$fn=1000);
//color ("green")cylinder (r=3.82,h=9);//hueco interno ARO1

}


