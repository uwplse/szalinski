With=10;
Height=6;
Thickness=2;
Number=5;
//First bridge length
First_length=10;
//Increment between each bridge
Increment=15;


for(i=[0:Number-1])
{
	translate([0,i*(With+10),0])cube([With,With,Height]);
	translate([With+First_length+i*Increment,i*(With+10),0])cube([With,With,Height]);
	translate([With,i*(With+10),Height-Thickness])cube([First_length+i*Increment,With,Thickness]);
}