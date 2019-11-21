

difference(){
rotate_extrude($fn=200)
polygon( points=[[0,0],[16.5,0],[13,12],[13 ,30],[5,40],[0,40]] );
union(){
rotate_extrude($fn=30)
polygon( points=[[0,-1],[15.5,-1],[10,12],[10 ,27],[4,38],[0,38]] );
    
   //Nozzle openings
   translate([2,0,-1])cylinder(h =60 ,d =1, centr = true);       
  translate([-2,0,-1])cylinder(h =60, d =1, centr = true);    
   translate([2,2,-1])cylinder(h =60 ,d =1, centr = true);       
  translate([2,-2,-1])cylinder(h =60, d =1, centr = true);   
   translate([-2,2,-1])cylinder(h =60 ,d =1, centr = true);       
  translate([-2,-2,-1])cylinder(h =60, d =1,  centr = true);  
  //hole in sink tip  
   for (i = [1:12]){
rotate([85,0,30*i])translate([0,30.5,0])
cylinder(h =35, d =1.2, centr = true);}
  for (i = [1:12]){
rotate([85,0,30*i])translate([0,34,0])
cylinder(h =35, d =1.2, centr = true);}

//screw thread 
for (i = [1:360]){

rotate([90,0,5*i])translate([13,13+0.06*i,0])
cylinder(h =2.2, d =3, $fn=60, centr = true);
}
    
    
}}