// Willem Geertsma 2017
//preview[view:north east, tilt:right]
// number of pegs this makes the width of the part 5 + 40*number offpegs
number_of_pegs= 3;
//user_defined_length = 80 ;

Width = 40;
option = 0; // [0:hooks, 1:Pliers, 2:Screwdrivers,3:drill_set(not working yet),4:holder]
rounded_edge = 0; // [0:false, 1:true]
//radius of the edge only when rounded edge: true
main_radius = 5;
/* [hook] */
Width_between_hooks = 2;
Width_Hook = 3.8;
Chamfered_Back = 1; // [0:false, 1:true]
// work in process
Auto_center = 0; // [0:false, 1:true]

/* [pliers] */
shape = 1; // [0:Rectangle, 1:Rounded Rectangle, 2: Circle]
Length_plier = 30 ;
thickness_plier = 15 ;

// radius for Rounded Rectangle and Circle (in rounded Rectangle use a small radius)
radius = 4;
// number of cut out
number_pliers =2;
// the starting point for the first cut out
start = 7.5 ;
// The offzet between the cut out
offzet = 40;

/* [text] */
// enable text
txt = 1; // [0:false, 1:true]
text = "Breadboard wires";
size = 8 ;
//text offzet in mm
text_offset = 0;
 /* [holder] */
 wall_thickness =2;
/* [Hidden] */
// vaste variable
 hoogte  = 12;
dikte_bord = 5; // dikte van haak gelijk aan dikte bordt


       lengte = (number_of_pegs-1)*40 +5; 
       aantal_haakjes = round((lengte - Width_Hook)/ (Width_Hook+Width_between_hooks)) ;
       start_offzet =  Width_Hook +(lengte -(((aantal_haakjes-1)*(Width_Hook+Width_between_hooks)+(Width_Hook*2))+ Width_Hook) );
      // aantal_tangen =  lengte /  (thickness_plier+5) ;
       



difference(){
     if (option== 2){
         if(rounded_edge == 0 ){
         cube([lengte,Width,25]);
         }
         else{
             union() {
                                roundedcube(lengte,Width,25,main_radius);
                                cube ([main_radius,main_radius,25]);
                                translate([lengte-5,0,0])
                                cube ([main_radius,main_radius,25]);   
                  }    
         }
         
       }

         else
         {
             if(rounded_edge == 0 ){
       cube([lengte,Width,12]);  
             }
             else
             {
                  union() {
                            roundedcube(lengte,Width,12,main_radius);
                            cube ([main_radius,main_radius,25]);
                            translate([lengte-5,0,0])
                            cube ([main_radius,main_radius,25]);   
                  } 
             }
             
         }
         


    //uitsparringen voor het bord
translate([0,dikte_bord,0])
cube([lengte,dikte_bord,9]);
 
 for (i=[0:number_of_pegs-1]) {   // uitsparingen voor haakjes
   translate([i*40+5,0,0]) 
   cube([35.5,dikte_bord*2,hoogte]);
 }
 translate([4.5,0,0]) 
   cube([35.5,dikte_bord*2,hoogte]);
 

// haakjes
 if (option== 0){
  
translate([0,20,5])
cube([lengte,Width-30,8]);
translate([0,Width-10,5])
 rotate([45, 0, 0]) 
 cube([lengte,10,10]); 
     

translate([0,Width-7,0])
rotate([-45, 0, 0]) 
cube([lengte,10,10]);
 if (Chamfered_Back == 1){
     translate([0,13,12])
 rotate([-45, 0, 0]) 
 cube([lengte,10,10]); 
 }
 if (Chamfered_Back == 0){
 translate([0,13,5])
 cube([lengte,10,10]); 
 }
 

 if ( Auto_center == 0){
 for (i=[0:aantal_haakjes -1]) {  
       translate([i*(Width_Hook+Width_between_hooks)+Width_Hook,13,0]) 
        cube([Width_between_hooks,Width-10,hoogte]);
   }  
  }
  if ( Auto_center == 1){
 for (i=[1:aantal_haakjes -1]) {  
       translate([i*(Width_Hook+Width_between_hooks)+start_offzet,13,0]) 
        cube([Width_between_hooks,Width-10,hoogte]);
   }  
  } 

}
// tang
 if (option== 1){
   for (i=[0:number_pliers-1]) {   

       if (shape == 0){
              translate([i*offzet+start,10+((Width-10-thickness_plier)/2),0]) 
            cube([ Length_plier,thickness_plier,hoogte]);  
       }
        if (shape == 1){
               translate([i*offzet+start,10+((Width-10-thickness_plier)/2),0]) 
            roundedcube( Length_plier,thickness_plier,hoogte,radius);  
       }
      if (shape == 2){ 
             translate([i*offzet+start,10+((Width-10)/2),0]) 
          cylinder( 80,radius,radius,true);
}
 }
 }
 if (option== 2){

translate([0,Width,10])
rotate([70, 0, 0]) 
     cube([lengte,50,50]);


translate([0,Width-7,0])
rotate([-45, 0, 0]) 
     cube([lengte,10,10]);
 for (i=[0:number_of_holes-1]) {
  translate([i*15+12,Width/2-5,0])
rotate([-10, 0, 0]) 
  cylinder(  50, 2.5, 2.5,true);
 }
 for (i=[0:number_of_holes-1]) {
  translate([i*15+12,Width/2+10,0])
rotate([-10, 0, 0]) 
  cylinder(  50, 2.5, 2.5,true);
 }
}
  if (option== 4){
      translate([wall_thickness,dikte_bord*3,wall_thickness])
 roundedcube(lengte-wall_thickness*2,Width-dikte_bord*3 -wall_thickness,25,main_radius);
      }
  
translate([0,0,12]) 
 cube([lengte,dikte_bord*2,13]); 
}

 if (txt== 1){ 
    
      if (option== 2){
        translate([0,dikte_bord*2,25-5])
        cube([lengte,3,15]);
        translate([0, dikte_bord*2, 0])
        rotate([-90, 180, 0]) 
        linear_extrude(height = 4)
        translate([-lengte+text_offset, 22, 0])
        text(text,size);
 }
 else{
        translate([0,dikte_bord*2,hoogte-5])
        cube([lengte,3,20]);
        translate([0, dikte_bord*2, 0])
        rotate([-90, 180, 0]) 
        linear_extrude(height = 4)
        translate([-lengte+text_offset, hoogte+2, 0])
        text(text,size);
 }
 }
 module roundedcube(xdim ,ydim ,zdim,rdim){
hull(){
translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);

translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
}
}
