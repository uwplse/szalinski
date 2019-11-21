//Number of records slots in base *MAX OF 10*
numRecords=6;
//Smooth Rod Diameter 
rodDiameter=8;

module bottom(){
cylinder(r1=50, r2=40, h=20);

}
module base()
{
if (numRecords>10)
{
echo("Please choose a number less than 10");
}
else{
difference()
{
bottom();
for (x= [0:360/numRecords:360])
{ 
rotate([0,0,x]) translate([30,0,17.5]) cube([40,2,25],center=true);
translate([0,0,5])cylinder(r=rodDiameter/2, h=125);
}
}
}
}

base();
