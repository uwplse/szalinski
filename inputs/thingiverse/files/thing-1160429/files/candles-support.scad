//smallest ring candles number
nb0=10;         //[4:50]

// smallest ring radius (mm)
r0=40;   // [10:200]   

//  put a candle on center ?   
center_candle = 1; // [0,1]
// don't forget to add 1 to nb0+nb1+nb2 to tally up the candles number

// medium ring candles number. 0 if none. can't be 0 if nb2 > 0
nb1=19;  //[0:50]       
//medium ring radius, not used if no candle on this ring
r1=80;  // [10:300]   

// largest ring candles number. 0 if none
nb2=0;  //[0:50] 
//largest (external) ring radius, not used if no candle on this ring
r2=105;  // [10:400]          


module draw_ring(r, h, nb, larg) {
    difference(){
        cylinder(r=r+larg/2, h=h);
        translate  ([0,0,-epsilon]) cylinder(r=r-larg/2, h=h+2*epsilon);
    }
    for(i = [1 : nb]) {
        translate  ([0,0,h0]) candle(r, i*360/nb);
    }
}



module candle(r, angle) {
    rotate([0,0,angle])  translate ([r,0,0]) {
        r1_loc=larg/2;
        r2_loc=larg_ext/2;
        h1_loc=larg_ext-larg;
        h2_loc=h_support-larg_ext;
        r3_loc= (r2_loc-r1_loc)*h2_loc/h1_loc+r2_loc;
        
        cylinder (r1=r1_loc, r2=r2_loc, h=h1_loc);
        translate  ([0,0,h1_loc])  difference () { 
           cylinder (r1=r2_loc, r2=r3_loc, h=h2_loc);
           cylinder (r1=r2_loc-e, r2=r3_loc-e, h=h2_loc+epsilon);
        }
        translate  ([0,0,h1_loc]) difference () { 
           cylinder (r=r2_loc, h=h_candle);
           translate  ([0,0,-epsilon]) cylinder (r=larg_int/2, h=h_candle+2*epsilon);
        }
    }
}

larg=2.7;      //ring width
h_support=11;  // total thickness


// candle 
// candle walls
larg_int=6;  // to be modified to adapt to your candle radius // at your own risk
larg_ext=larg_int + 0.5; 


larg_max=larg_ext + 3;
h_candle=3.8;  // candle thickness

e=0.2;

h0=2;
epsilon=1;   

$fn=64;



union() {

   
   // draw small ring with candles
    draw_ring(r=r0, h=h0, nb=nb0, larg=larg);

    if (center_candle > 0 )   { // is there a candle on center ?
        draw_ring(r=0, h=h0, nb=1, larg=larg);  // draw it
        // then draw bars between the center and the small ring
        translate ([0,0,h0/2]) { 
            cube( size=[2*r0, larg, h0], center=true);
            rotate([0,0,90])  cube( size=[2*r0, larg, h0], center=true);
        }

    }    

    if (nb1 > 0) {    // medium ring ?
        draw_ring(r=r1, h=h0, nb=nb1, larg=larg);   // draw it with candles
        // then draw bars between this ring and the small one
        translate ([0,0,h0/2])  {
            difference() {
                cube( size=[2*r1, larg, h0], center=true);
                cube( size=[2*r0, larg, h0], center=true);
            }
            rotate([0,0,90])             
                difference() {
                    cube( size=[2*r1, larg, h0], center=true);
                    cube( size=[2*r0, larg, h0], center=true);
            }  
        }
   } 

    if (nb2 > 0) {    // external ring ?
        draw_ring(r=r2, h=h0, nb=nb2, larg=larg);   // draw it with candles
        // then draw bars between this ring and the medium one
        translate ([0,0,h0/2])  {
            difference() {
                cube( size=[2*r2, larg, h0], center=true);
                cube( size=[2*r1, larg, h0], center=true);
            }
            rotate([0,0,90])             
                difference() {
                    cube( size=[2*r2, larg, h0], center=true);
                    cube( size=[2*r1, larg, h0], center=true);
            }  
        }
   }
   
  
    
}





