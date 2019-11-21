// 3.5 inch Drive to 5.25 inch Front Bay Bracket Adapter 
// Part 1: Chassis

tb=5;                      //thickness of the bezel
sf=0.006;                // shrinkage factor (ABS shrinks approximatly 0.5%-0.7% when it cools) 

h3=25.4;                 //hight of 3.5" unit (25.4-26.1)
w3=101.6*(1+sf);              //width of 3.5" unit
l3=147*(1+sf);                  //lenght of 3.5" unit
h5=41.53;              //hight of 5.25" unit
w5=146.05*(1+sf);           //width of 5.25" unit
l5=l3;                     //lenght of 5.25" unit (max standard allows 202.8mm)
th=2.5;                  //thickness of the walls
lift=(h5-h3)/2;        //how high 3.5" unit is positioned from the bottom

ho1l5=47.4*(1+sf);                 //distance of first 5.25" unit holes from front
ho2l5=79.25*(1+sf)+ho1l5;   //distance of first 5.25" unit holes from front
ho1h5=10;                  //distance of lower 5.25" unit holes from bottom
ho2h5=21.84;             //distance of higher 5.25" unit holes from bottom

ho1l3=25*(1+sf);                   //distance of 3.5" unit holes from front of bezel 
ho2l3=85*(1+sf);                   //distance of 3.5" unit holes from front of bezel  
ho3l3=115*(1+sf);                 //distance of 3.5" unit holes from front of bezel  

hoh3=5;                 //distance of 3.5" unit holes from bottom (3.6, 5, 6.35)

rod=3;                   // thickmess of bottom support rods
d5=1.5;                 //radius of 5.25" unit holes
d5s=3.5;               //thickness of support plastic around 5.25" unit holes
d5sl=8;                 //screw lenght support plastic around 5.25" unit holes
d3=1.5;                 //radius of 3.5" unit holes
sd=5;                    //radius of screwdriwer holes
f=30;                     // $fn=


difference() {
        union() {
            // 5.25" chassis wall's:
            translate([-(w5/2)+(th/2),l5/2,h5/2]) cube ([th,l5,h5], center=true);
            translate([(w5/2)-(th/2),l5/2,h5/2]) cube ([th,l5,h5], center=true);
            
            // support plastic for 5.25" chassis wall's holes:
            translate([-(w5/2)+4,ho1l5,(ho2h5+d5s)/2]) cube([d5sl,2*d5s,ho2h5+d5s], center=true);
            translate([-(w5/2)+4,ho2l5,(ho2h5+d5s)/2]) cube([d5sl,2*d5s,ho2h5+d5s], center=true);
            translate([(w5/2)-4,ho1l5,(ho2h5+d5s)/2]) cube([d5sl,2*d5s,ho2h5+d5s], center=true);
            translate([(w5/2)-4,ho2l5,(ho2h5+d5s)/2]) cube([d5sl,2*d5s,ho2h5+d5s], center=true);
            
            // bottom rods:
            translate([0,ho1l5,lift/2]) cube([w5,rod,lift], center=true);
            translate([0,ho2l5,lift/2]) cube([w5,rod,lift], center=true);
            translate([0,rod/2,lift/2]) cube([w5,rod,lift], center=true);
            translate([0,l5/2,lift/2]) rotate([0,0,45]) cube([(w3+rod)*sqrt(2),rod,lift], center=true);
            translate([0,l5/2,lift/2]) rotate([0,0,-45]) cube([(w3+rod)*sqrt(2),rod,lift], center=true);
           
            // 3.5" chassis wall's:
            translate([-(w3/2)-(th/2),l3/2,(h3+(h5-h3)/2)/2]) cube ([th,l3,h3+(h5-h3)/2], center=true);
            translate([(w3/2)+(th/2),l3/2,(h3+(h5-h3)/2)/2]) cube ([th,l3,h3+(h5-h3)/2], center=true);
            
            // front & back plates:
            translate([(w5/2)-(w5-w3)/4,l3-th/2,(h3+(h5-h3)/2)/2]) cube([(w5-w3)/2,th,h3+(h5-h3)/2], center=true);
            translate([-(w5/2)+(w5-w3)/4,l3-th/2,(h3+(h5-h3)/2)/2]) cube([(w5-w3)/2,th,h3+(h5-h3)/2], center=true);
            translate([(w5/2)-(w5-w3)/4,th/2,h5/2]) cube([(w5-w3)/2,th,h5], center=true);
            translate([-(w5/2)+(w5-w3)/4,th/2,h5/2]) cube([(w5-w3)/2,th,h5], center=true);
            
            // front bezel mount:
            translate([-62,4,h5/2]) cube([12,8,h5], center=true);
            translate([62,4,h5/2]) cube([12,8,h5], center=true);
            
            }  // union
            
            // 5.25" unit screw holes:
            translate([-(w5/2),ho1l5,ho2h5]) rotate([0,90,0]) cylinder((w5-w3)/2,d5,d5, center=true, $fn=f);
            translate([-(w5/2),ho2l5,ho2h5]) rotate([0,90,0]) cylinder((w5-w3)/2,d5,d5, center=true, $fn=f);
            translate([(w5/2),ho1l5,ho2h5]) rotate([0,90,0]) cylinder((w5-w3)/2,d5,d5, center=true, $fn=f);
            translate([(w5/2),ho2l5,ho2h5]) rotate([0,90,0]) cylinder((w5-w3)/2,d5,d5, center=true, $fn=f);
            translate([-(w5/2),ho1l5,ho1h5]) rotate([0,90,0]) cylinder((w5-w3)/2,d5,d5, center=true, $fn=f);
            translate([-(w5/2),ho2l5,ho1h5]) rotate([0,90,0]) cylinder((w5-w3)/2,d5,d5, center=true, $fn=f);
            translate([(w5/2),ho1l5,ho1h5]) rotate([0,90,0]) cylinder((w5-w3)/2,d5,d5, center=true, $fn=f);
            translate([(w5/2),ho2l5,ho1h5]) rotate([0,90,0]) cylinder((w5-w3)/2,d5,d5, center=true, $fn=f);
             
            // 3.5" unit screw holes:
            translate([0,ho1l3-tb,hoh3+lift]) rotate([0,90,0]) cylinder(w5+2,d3,d3, center=true, $fn=f);
            translate([0,ho2l3-tb,hoh3+lift]) rotate([0,90,0]) cylinder(w5+2,d3,d3, center=true, $fn=f);
            translate([0,ho3l3-tb,hoh3+lift]) rotate([0,90,0]) cylinder(w5+2,d3,d3, center=true, $fn=f);
            
            // 3.5" unit screw driver access holes:
            translate([-(w5/2)+0.01,ho1l3-tb,hoh3+lift]) rotate([0,90,0]) cylinder(th*2,sd,sd, center=true, $fn=f);
            translate([-(w5/2)+0.01,ho2l3-tb,hoh3+lift]) rotate([0,90,0]) cylinder(th*2,sd,sd, center=true, $fn=f);        
            translate([-(w5/2)+0.01,ho3l3-tb,hoh3+lift]) rotate([0,90,0]) cylinder(th*2,sd,sd, center=true, $fn=f);        
            translate([(w5/2)-0.01,ho1l3-tb,hoh3+lift]) rotate([0,90,0]) cylinder(th*2,sd,sd, center=true, $fn=f);
            translate([(w5/2)-0.01,ho2l3-tb,hoh3+lift]) rotate([0,90,0]) cylinder(th*2,sd,sd, center=true, $fn=f);
            translate([(w5/2)-0.01,ho3l3-tb,hoh3+lift]) rotate([0,90,0]) cylinder(th*2,sd,sd, center=true, $fn=f);  
              
            // bezel mount holes:
            translate([-62,5,h5-7]) rotate([90,0,0]) cylinder(12,4.05,4.05, center=true, $fn=f);
            translate([62,5,h5-7]) rotate([90,0,0]) cylinder(12,4.05,4.05, center=true, $fn=f);
            translate([-62,5,7]) rotate([90,0,0]) cylinder(12,4.05,4.05, center=true, $fn=f);
            translate([62,5,7]) rotate([90,0,0]) cylinder(12,4.05,4.05, center=true, $fn=f);
             
            // cut of some material on the top:
            translate([-(w5/2),40,60]) rotate([0,90,0]) cylinder(2*th+0.02,30,30, center=true, $fn=f);
            translate([-(w5/2),110,60]) rotate([0,90,0]) cylinder(2*th+0.02,30,30, center=true, $fn=f);
            translate([-(w5/2),75,45]) cube([2*th+0.02,70,30], center=true);
            translate([(w5/2),40,60]) rotate([0,90,0]) cylinder(2*th+0.02,30,30, center=true, $fn=f);
            translate([(w5/2),110,60]) rotate([0,90,0]) cylinder(2*th+0.02,30,30, center=true, $fn=f);
            translate([(w5/2),75,45]) cube([2*th+0.02,70,30], center=true);
            translate([-(w3/2),40,50]) rotate([0,90,0]) cylinder(2*th+0.02,30,30, center=true, $fn=f);
            translate([-(w3/2),110,50]) rotate([0,90,0]) cylinder(2*th+0.02,30,30, center=true, $fn=f);
            translate([-(w3/2),75,35]) cube([2*th+0.02,70,30], center=true);
            translate([(w3/2),40,50]) rotate([0,90,0]) cylinder(2*th+0.02,30,30, center=true, $fn=f);
            translate([(w3/2),110,50]) rotate([0,90,0]) cylinder(2*th+0.02,30,30, center=true, $fn=f);
            translate([(w3/2),75,35]) cube([2*th+0.02,70,30], center=true);
       
             //printing tension release in 5.25 wall
            translate([(w5/2)-0.01,8,16]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f);
            translate([(w5/2)-0.01,8,33]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f);
            translate([(w5/2)-0.01,8,24.5]) cube([th*2,1,17], center=true);          
            translate([(w5/2)-0.01,68,8]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f); 
            translate([(w5/2)-0.01,68,23]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f);
            translate([(w5/2)-0.01,68,15.5]) cube([th*2,1,15], center=true);           
            translate([(w5/2)-0.01,137,8]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f); 
            translate([(w5/2)-0.01,137,33]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f);
            translate([(w5/2)-0.01,137,20.5]) cube([th*2,1,25], center=true);
            translate([(-w5/2)+0.01,8,16]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f);
            translate([(-w5/2)+0.01,8,33]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f);
            translate([(-w5/2)+0.01,8,24.5]) cube([th*2,1,17], center=true);          
            translate([(-w5/2)+0.01,68,8]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f); 
            translate([(-w5/2)+0.01,68,23]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f);
            translate([(-w5/2)+0.01,68,15.5]) cube([th*2,1,15], center=true);           
            translate([(-w5/2)+0.01,137,8]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f); 
            translate([(-w5/2)+0.01,137,33]) rotate([0,90,0]) cylinder(th*2,3,3, center=true, $fn=f);
            translate([(-w5/2)+0.01,137,20.5]) cube([th*2,1,25], center=true);
            
            //printing tension release in 3.5 wall
            translate([(w3/2),12,8]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f);
            translate([(w3/2),12,25]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f);
            translate([(w3/2),12,16.5]) cube([th*2+0.02,1,17], center=true);          
            translate([(w3/2),72,8]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f); 
            translate([(w3/2),72,13]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f);     
            translate([(w3/2),137,8]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f); 
            translate([(w3/2),137,24]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f);
            translate([(w3/2),137,16.5]) cube([th*2+0.02,1,17], center=true);
            translate([(-w3/2),12,8]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f);
            translate([(-w3/2),12,25]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f);
            translate([(-w3/2),12,16.5]) cube([th*2+0.02,1,17], center=true);          
            translate([(-w3/2),72,8]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f); 
            translate([(-w3/2),72,13]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f);          
            translate([(-w3/2),137,8]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f); 
            translate([(-w3/2),137,24]) rotate([0,90,0]) cylinder(th*2+0.02,3,3, center=true, $fn=f);
            translate([(-w3/2),137,16.5]) cube([th*2+0.02,1,17], center=true);     
            
                        }    // difference

