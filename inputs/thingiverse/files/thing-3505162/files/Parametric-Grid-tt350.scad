
//thickness of the walls of the honeycomb
wall = .6;

//the radius of the honeycomb holes
hole = 3;

//depth of the honecomb grid
grid_depth = 20;

//thickness of the ring that attaches to flash
ring_depth = 10;

//add grid angle to top
angle_mark = 1; //[1:yes,0:no]

/* [Hidden] */

//width of grid pattern, shouldn't need to change
width = 100;

//height of grid pattern, shouldnt need to change
height = 44;



angle=2*atan((2*(hole-wall))/grid_depth); //calculate grid angle
echo(str("<b>Grid angle = " ,angle,"</b>"));

//Main Body
  union(){
  translate([0,0,grid_depth])      //ring part
    linear_extrude(ring_depth){
    tt350_outline();}
  linear_extrude(grid_depth){     //grid part
    union(){
      tt350_outline();
        intersection(){
          honeycomb_grid(wall,hole,width,height);
          tt350_outside();}
    }
  }
  
//Add the grid angle to the top
  if (angle_mark == 1){
   rotate([90,0,0]) translate([0,3,17.5]) {
   linear_extrude(1)text(str(round(angle)), size = 8, 
     font = "Liberation Sans:style=Bold Italic", halign = "center");}
 }
}


//////////////// - Modules - /////////////////
 
module honeycomb_grid(wall,hole,width,height) {
    xoffset=1.5*(hole-(wall/2));
    yoffset=(sqrt(3)*(hole))-wall;
    xnum=round((width/(2*hole))/2)*2; //keeping even number ensures a rosette
    ynum=round((height/yoffset)/2)*2; //keeping even number ensures a rosette
    for (x=[-(xnum/2):xnum/2]){
        for (y=[-(ynum/2):ynum/2]){
          o=(x % 2)*.5*yoffset;
            translate([x*xoffset,(y*yoffset)+o]){
                difference(){
                circle($fn=6,r=hole);
                circle($fn=6,r=hole-wall);
                }
            }
        }    
    }
}


module tt350_outside(){
polygon(points=[[32.579000,-7.405000],[32.556000,-7.587000],[31.469578,-10.919313],[29.490375,-14.103500],[28.150072,-15.477742],[26.567484,-16.620188],[24.736248,-17.465914],[22.650000,-17.950000],[22.573000,-17.960000],[-22.496000,-17.960000],[-22.649000,-17.950000],[-24.735207,-17.465914],[-26.566344,-16.620188],[-28.148809,-15.477742],[-29.489000,-14.103500],[-31.468156,-10.919313],[-32.555000,-7.587000],[-33.000000,0.494000],[-32.860000,3.930000],[-32.627027,7.712635],[-31.989219,10.729391],[-31.055113,13.066670],[-29.933250,14.810875],[-28.732168,16.048408],[-27.560406,16.865672],[-25.739000,17.585000],[-25.623000,17.611000],[-11.362000,17.960000],[0.000000,17.960000],[11.391000,17.960000],[25.503000,17.614000],[25.622000,17.611000],[25.739000,17.585000],[27.560406,16.865672],[28.732168,16.048408],[29.933250,14.810875],[31.055113,13.066670],[31.989219,10.729391],[32.627027,7.712635],[32.860000,3.930000],[33.000000,0.494000],[32.579000,-7.405000],[32.579000,-7.405000]]);}

module tt350_inside(){
polygon(points=[[31.258000,-7.339000],[30.252625,-10.425000],[28.458250,-13.307750],[27.259211,-14.537086],[25.855750,-15.552625],[24.245477,-16.300039],[22.426000,-16.725000],[0.000000,-16.725000],[-22.426000,-16.725000],[-24.245477,-16.300039],[-25.855750,-15.552625],[-27.259211,-14.537086],[-28.458250,-13.307750],[-30.252625,-10.425000],[-31.258000,-7.339000],[-31.675000,0.502000],[-31.537000,3.905000],[-31.396377,6.833311],[-30.989891,9.317234],[-30.360865,11.383385],[-29.552625,13.058375],[-28.608494,14.368818],[-27.571797,15.341328],[-25.394000,16.379000],[-11.326000,16.725000],[0.000000,16.725000],[11.326000,16.725000],[25.394000,16.379000],[27.571797,15.341344],[28.608494,14.368871],[29.552625,13.058500],[30.360865,11.383629],[30.989891,9.317656],[31.396377,6.833981],[31.537000,3.906000],[31.675000,0.503000],[31.258000,-7.339000],[31.258000,-7.339000]]);}

module tt350_outline(){
difference(){
  tt350_outside();
  tt350_inside();
}}