//CUSTOMIZER VARIABLES 

//radius of bowl
radius = 20 ;

// exponent determines the shape of the profile
p = 2.5;  //Piet Hein
//  p= 4;  // Squircle
// p = 2; //circular
// height of bowl
height= 10;

//wall thickness 
thickness = 2;

//CUSTOMIZER VARIABLES END
e = radius/height;

function length(p)  = sqrt(pow(p[0],2) + pow(p[1],2) );
function unit(p) = p / length(p);

function superellipse (R, p, e, theta) = 
      R * [ e*    pow(abs(sin(theta)),2/p) * sign(sin(theta)),
                     pow(abs(cos(theta)),2/p) * sign(cos(theta)) 
            ] ;

module superellipse_curve (R, p, e=1, thickness=1, sweep=360, n=50) { 
      assign(dth = sweep/n)
        for (i = [0:n-1] ) 
          assign (p1 = superellipse(R,p,e,dth*i),
                      p2 = superellipse(R,p,e,dth*(i+1))
                  ) {
          polygon( [p1, p2,  
                          p2 +  thickness * unit(p2), 
                          p1 +  thickness * unit(p1)] 
                      );
         }
}

$fa=0.01; $fs=0.5;
// translate([0,0,height - thickness  ]) rotate([0,180,0]) // flip for  printing
translate([0,0,radius+thickness]) rotate([180,0,0]) rotate_extrude() 
     superellipse_curve(radius,p,e,thickness,sweep=90);


