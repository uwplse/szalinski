// paper size
size=50;

thickness=.6; // paper thickness
thickfold=.2; // thickness at folding lines

tam2=size/2;
tam4=size/4;
tam8=size/8;
3tam8=3*tam8;
stam2=sqrt(2)*tam2;
stam4=sqrt(2)*tam4;

module corte(transx,transy,dir,rot,size,pliegues) {
  translate([transx,transy,dir*thickfold]) rotate(rot) 
      cube([size,1.5*pliegues*thickness,thickness],center=true);
}

module hoja() { 
  difference() {
    cube([size,size,thickness],center=true);

    corte(0,+tam4,+1,[0,0,0],tam2,2);
    corte(0,-tam4,+1,[0,0,0],tam2,1);
    corte(tam4,0,+1,[0,0,90],tam2,2);
    corte(-tam4,0,+1,[0,0,90],tam2,1);

    corte(+3tam8,-3tam8,+1,[0,0,-45],stam4,1);
    corte(-3tam8,+3tam8,+1,[0,0,-45],stam4,1);
    corte(-3tam8,-3tam8,+1,[0,0,45],stam4,2);
    
    corte(0,0,-1,[0,0,45],stam2,1);  
    corte(-3tam8,tam8,-1,[0,0,45],stam4,1);  
    corte(+tam8,-3tam8,-1,[0,0,45],stam4,1);  
    corte(+tam4,tam4,-1,[0,0,-45],stam2,1);
    corte(+3tam8,3tam8,-1,[0,0,45],stam4,3);

  }
}

hoja();
