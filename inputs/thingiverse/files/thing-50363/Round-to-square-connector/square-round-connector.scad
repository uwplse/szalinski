// inside  or outside sizing
inside= 2;  // [1:inside, 2:outside]

// wall thickness
thickness = 2 ;

// length of side of square section
square_side = 15;  //

// length of square section 
square_length = 10; //

// length of transition section
transition_length = 20; //

// diameter of round section
round_diameter = 20;  //

// length of round section 
round_length = 10;


// no of steps in the transition  - large is quite slow
layers= 10;

// --------------- functions and modules 
function normal (p1,p2) = [ p1[1] - p2[1], p2[0] - p1[0] ] ;
function length(p)  =  sqrt(pow(p[0],2) + pow(p[1],2));
function unit_normal(p1,p2) = normal(p1,p2) / length(normal(p1,p2));
function interpolate(a, b, ratio) = a + (b - a) * ratio;

function superellipse (R, p, e, theta) = 
      R * [pow(abs(cos(theta)),2/p) * sign(cos(theta)),
           e * pow(abs(sin(theta)),2/p) * sign(sin(theta)) 
          ] ;

module superellipse_curve (R, p, e=1, thickness=1, sweep=360, n=50) { 
      assign(dth = sweep/n)
        for (i = [0:n-1] ) 
          assign (p1 = superellipse(R,p,e,dth*i),
                  p2 = superellipse(R,p,e,dth*(i+1))
                  )
          assign (nv =  thickness * unit_normal(p1,p2)  ) 
            polygon( 
                  [p1,p2,p2+nv,p1+nv] );
}

module tube(r1, r2, length, p1, p2, thickness, steps) {
//
     for (i=[0:steps-1]) 
        assign (ratio = i /steps)
        assign (radius = interpolate(r1, r2, ratio),
                    p = interpolate(p1,p2,ratio),
                    l = interpolate(0, length, ratio)
                   )
        translate([0, 0, l]) 
           linear_extrude(height= length /steps)
               superellipse_curve(radius,p,1,thickness);
}

square_r= square_side * sin(45)  + (inside==1 ? thickness : 0); 
round_r= round_diameter /2 + (inside==1 ? thickness : 0) ;

echo (square_r, round_r);

// make it
$fa=0.01; $fs=2;
union() {
          // square section
         tube(square_r,square_r, square_length,1,1,thickness,1); 
         // transition
         translate([0,0,square_length])  
                tube(square_r,round_r,transition_length,1,2,thickness,layers);  
          // round section
          translate([0,0,square_length + transition_length]) 
                tube(round_r,round_r,round_length,2,2,thickness,1); 
   }

