//CUSTOMIZABLE STAR PARAMETERS
/*[Text Parameters]*/
//Insert text, better in capital letters
text= "Exp3nd";
text_size = 10;
myfont = "Arial:style=black";//Para cambiar la fuente vamos a Ayuda>Font List. Nos sale un despegable y arrastramos la fuente que queramos. Para cambiar a negrita poner black, para poner normarl, regular


/*[Star Parameters]*/

//Number of star points
N=5;
//Star inner radius
ri=25;
//Star outer radius
ro=50;

/*[Box Parameters]*/

//Width
ancho = 70;
//High
alto= 12;
//Box High position
posicion= 4;

/*[Pattern Parameters]*/

//Pattern Type
sides = 3; //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]

//Pattern_radius
r= 5; //[4:22]

//Pattern_thickness
th=0.8;


module parametric_star(N, h, ri, re) {

  module tipstar(n) {
     i1 =  [ri*cos(-360*n/N+360/(N*2)), ri*sin(-360*n/N+360/(N*2))];
    e1 = [re*cos(-360*n/N), re*sin(-360*n/N)];
    i2 = [ri*cos(-360*(n+1)/N+360/(N*2)), ri*sin(-360*(n+1)/N+360/(N*2))];
    polygon([ i1, e1, i2]);
  }
    linear_extrude(height=1) //Altura del borde de la estrella estaba puesto =h
    union() {
      for (i=[0:N-1]) {
         tipstar(i);
      }
      rotate([0,0,360/(2*N)]) circle(r=ri+ri*0.01,$fn=N);
    }
}
module honeycomb(w,l,h,r,rmod,th,sides)
{
	columns = l/(r*3)+1;
	rows = w/(r*sqrt(3)/2*2);

	translate([-w/2,l/2,0])
		rotate([0,0,-90])
			for(i = [0:rows]){
				
				translate([0,r*sqrt(3)/2*i*2,0])
				//scale([1*(1+(i/10)),1,1])
					for(i = [0:columns]){
						translate([r*i*3,0,0])
							for(i = [0:1]){
								translate([r*1.5*i,r*sqrt(3)/2*i,0])
									rotate([0,0,honeycomb_rotation])
									difference(){
										if(sides < 5){
											cylinder(height = h, r = r+th+(r*rmod/50), center = true, $fn = sides);
										} else {
											cylinder(height = h, r = r+(r*rmod/50), center = true, $fn = sides);
										}
										cylinder(height = h+1, r = r-th+(r*rmod/50), center = true, $fn = sides);
									}
							}
					}
			}
}
//Customizable star code
union(){
difference(){
            rotate([0,0,90])
            //modulo estrella_bien();
                    union(){    
                        intersection(){
                        parametric_star(N,1,ri,ro);
                        honeycomb(200,200,3,r,1,th,sides);
                                      }
                        //modulo estrella(N,1,ri,ro);
                        union(){
                                    difference(){
                                    scale([1.1,1.1,1])
                                    parametric_star(N, 1, ri, ro);
                                    parametric_star(N, 1, ri, ro);
                                            }
                                    //modulo arandela(3, h);
                                    translate([ro+7,0,0])
                                    difference(){
                                        cylinder(r=3/0.7, h=1, $fn=100);
                                        cylinder(r=3/1.5, h=1*10, $fn=100, center=true);
                                                }
                               }
                            }                 
                rotate([0,0,90])
                translate([(posicion+(alto/2)),0,0])
                cube([alto,ancho,1], center=true);
 
            }       
               //TEXTO
                translate([-(ancho/2)+2,posicion+0.2,0])
                linear_extrude(1) //Altura texto
                text(
                     text, 
                     size = text_size, 
                     font = myfont
                );
            
                //BASE
                rotate([0,0,90])    
                translate([posicion,0,0.5])
                color("red")cube([1.2,ancho,1], center=true);
                //LADO DCHA
                rotate([0,0,90])
                translate([posicion-0.5,(-ancho/2),0])
                color("blue")cube([alto+1,1.2,1]);
                //ARRIBA
                rotate([0,0,90])
                translate([posicion+alto,0,0.5])
                color("black")cube([1.2,ancho,1], center=true);
                //LADO IZQDA
                rotate([0,0,90])
                translate([(posicion+(alto/2)),(ancho/2),0.5])
                color("white")cube([alto+1,1.2,1], center =true);
}