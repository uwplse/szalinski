/*

Random crystal generator for Thingiverse Customizer

Fernando Jerez 2016

*/

// This is only to force Customizer create many files. Changes doesnt matter. Just click CREATE THING
part = "one"; // [one:Crystal #1, two:Crystal #2, three:Crystal #3, four:Crystal #4,five:Crystal #5,six:Crystal #6,seven:Crystal #7,eight:Crystal #8,nine:Crystal #9,ten:Crystal #10]

/* [Hidden] */
crystalrock();
 



module crystalrock(){
    union(){
        semisphere(5,$fn=6);
        for(i=[1:50]){
            angleX = 45;
            angleY = 45;
            g1=rands(-angleX,angleX,1)[0];
            g2=rands(-angleY,angleY,1)[0];
        
            lados=6; 
            radio1=rands(1,2,1)[0];
            radio2=rands(1.1,1.6,1)[0]*radio1;
            radio3 = rands(0,0.5,1)[0]*radio2;
            altura=radio1*rands(1,2,1)[0]*5*(0.5+pow((abs(cos(g1)*cos(g2))),4));
            pico=rands(0.1,0.3,1)[0]*altura;    
        
            rotate([g1,g2,0])
            translate([0,0,3])
            crystal(lados,radio1,radio2,radio3,altura,pico);
        }
    }
}




module crystal(lados,radio1,radio2,radio3,altura,pico){
    cylinder(r1=radio1,r2=radio2,h=altura,$fn=lados);
    translate([0,0,altura])
    cylinder(r1=radio2,r2=radio3,h=pico,$fn=lados);
    
}

module semisphere(r){
    difference(){
        sphere(r); 
        translate([0,0,-r]) cube([2*r,2*r,2*r],center = true);
    }
}