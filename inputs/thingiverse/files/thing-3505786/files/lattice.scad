length = 200;
width = 120;
height = 100;
thickness = 3;
holegap = 5;
holesize = 10;
epi = 0.01*1;
//calc space for grid
//gap needs to be translated to vertical offset
gapo = sqrt(2*pow(holegap,2));
holesizeo = sqrt(2*pow(holesize,2));
//now calculate how many we can fit on and the offset to get them central
vl = floor((length-2*thickness)/(gapo+holesizeo));
vh = floor((height-2*thickness)/(gapo+holesizeo));
vw = floor((width-2*thickness)/(gapo+holesizeo));
lo = (length - (vl*(gapo+holesizeo)))/2;
ho = (height - (vh*(gapo+holesizeo)))/2;
wo = (width - (vw*(gapo+holesizeo)))/2;

//echo (vl,vh,vw,lo,ho,wo);

difference(){
    difference() 
        {
            translate(v=[0,0,0]) 
                cube(size=[length,width,height], center=false);
            translate(v=[thickness,thickness,thickness+epi]) 
                cube(size=[length-(thickness*2),width-(thickness*2),height-thickness], center=false);
        }
    union()
    {
        for (i=[1:vl],j=[1:vh])
        {
            valz = ho+((gapo+holesizeo)/2)+(((j-1)*(gapo+holesizeo)));
            valx = lo+((i-1)*(gapo+holesizeo))+(holesizeo+gapo)/2;

                translate([valx,0-epi,valz])
                rotate([90,45,180])
                {
                    cube(size=[holesize,holesize,2*(width+2*epi)],center=true);
                    //echo(i,j,valx,valz);
                }
            

        }
        for (i=[1:vl-1],j=[1:vh-1])
        {
            valz = ho+(holesizeo+gapo)+(((j-1)*(gapo+holesizeo)));
            valx = lo+((i)*(gapo+holesizeo));

                translate([valx,0-epi,valz])
                rotate([90,45,180])
                {
                    cube(size=[holesize,holesize,2*(width+2*epi)],center=true);
                    //echo(i,j,valx,valz);
                }

        }  
        for (i=[1:vw],j=[1:vh])
        {
            valz = ho+((gapo+holesizeo)/2)+(((j-1)*(gapo+holesizeo)));
            valy = wo+((i-1)*(gapo+holesizeo));

                translate([0-epi,valy+(holesizeo+gapo)/2,valz])
                rotate([90,45,90])
                {
                    cube(size=[holesize,holesize,2*(length+2*epi)],center=true);
                    //echo(i,j,valx,valz);
                }
        }
        for (i=[1:vw-1],j=[1:vh-1])
        {
            valz = ho+(holesizeo+gapo)+(((j-1)*(gapo+holesizeo)));
            valy = wo+((i)*(gapo+holesizeo))-((holesizeo+gapo)/2);

                translate([0-epi,valy+(holesizeo+gapo)/2,valz])
                rotate([90,45,90])
                {
                    cube(size=[holesize,holesize,2*(length+2*epi)],center=true);
                    //echo(i,j,valx,valz);
                }
        }        
    }
}