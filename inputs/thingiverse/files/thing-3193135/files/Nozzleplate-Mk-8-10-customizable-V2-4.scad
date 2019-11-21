/*nozzle plate for Mk8 or Mk10 nozzles (Mk8, Ultimaker 2, Creality CR-10, Ender 2, Wanhao D6)

20181102 P. de Graaff
20181122 text optional cut out or sublime
20181123 microswiss
*/

//Material
Text = "PLA";
nozzle= "Mk10"; //[Mk8:Mk8,Mk10:Mk10]
number = 4;   //[2:1:6]
cut_out="no";//[yes:YES,no:NO] 
MicroSwiss="yes";//[yes:YES,no:NO]
size_1="2";
size_2="4";
size_3="6";
size_4="8";
size_5="";
size_6="";
sizes=[size_1,size_2,size_3,size_4,size_5,size_6];

if (nozzle == "Mk8"){   
    difference(){
        minkowski(){
            cube([len(Text)*8+number*10+2.5,10,10]);
            sphere(0.5);
        }
        for (i=[0:number-1]){
            translate([len(Text)*8+5+i*10+0.5,5,-1])cylinder(d=6,h=20,$fn=50);
            translate([len(Text)*8+5+i*10+0.5,0.8,5])rotate([90,0,0])linear_extrude(height = 2,convexity=4)
            text(sizes[i], size = 4, font ="Arial",halign="center",valign="center", $fn = 100);
        }
      //Text
     translate([2,1,9])linear_extrude(height = 2,convexity=4)
      text(Text, size = 8, font ="Arial", $fn = 100);
    }
}
if (nozzle == "Mk10"){
 //echo(nozzle);   
    difference(){
        minkowski(){
            translate([0,-1,0])cube([len(Text)*8+number*12+3,12,10]);
            sphere(0.5);
        }
        for (i=[0:number-1]){
            if (MicroSwiss == "yes")translate([len(Text)*8+6+i*12+0.5,5,8])cylinder(d=7.7,h=20,$fn=50);
            translate([len(Text)*8+6+i*12+0.5,5,-1])cylinder(d=7.3,h=20,$fn=50);
            translate([len(Text)*8+6+i*12+0.5,0,5])rotate([90,0,0])linear_extrude(height = 3,convexity=4)
            text(sizes[i], size = 4, font ="Arial",halign="center",valign="center", $fn = 100);
        }
        //Text
     translate([2,1,9])linear_extrude(height = 2,convexity=4)
      text(Text, size = 8, font ="Arial", $fn = 100);
    }
}
if (cut_out == "no"){
     translate([2,1,9])linear_extrude(height = 2.5,convexity=4)
      text(Text, size = 8, font ="Arial", $fn = 100);
}