//Sliced Integral Sphere by TechboyCR- Abraham Pineda Zelaya.
//Base on the work of professor Dr.Tomas de Camino publish on this link:
//    https://medium.com/@TomasDeCamino/descubriendo-la-integral-c6549f17ee7a
// The OpenScad representation of the formula propose by professor de Camino for the base length is: "sqrt(pow(rS,2)-pow(((i*rS)/seg),2))"

Radius = 120; //Radio del cilindro base
Number_Of_Segments = 60; //Cantidad de cilindros en representacion

//echo("Sliced Integral Sphere");

for(i = [0:1:Number_Of_Segments])
    translate([0,0,Radius/Number_Of_Segments*i])

    cylinder(Radius/Number_Of_Segments,sqrt(pow(Radius,2)-pow(((i*Radius)/Number_Of_Segments),2)),sqrt(pow(Radius,2)-pow(((i*Radius)/Number_Of_Segments),2)));
