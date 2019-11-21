/*

    Conoids as a ruled surface


*/

Outer_N=3; 
Inner_N=3;  
Height=10;
Outer_Radius=30;
Inner_Radius=0;   // classic coniod has Inner_radius of 0 
Inner_Ratio=1;   // scales the inner axis
Thickness=2;
// render quality 
Steps=200;  // around object
Sides=10;   // slice


function norm(v) =
    pow(v.x*v.x + v.y*v.y + v.z*v.z,0.5);

module orient_to(origin, normal) {   
      translate(origin)
      rotate([0, 0, atan2(normal.y, normal.x)]) 
      rotate([0, atan2(sqrt(pow(normal.x, 2)+pow(normal.y, 2)),normal.z), 0])
      children();
}

module slice(x,thickness) {
    pa = f(x);
    pb = g(x);
    length = norm(pb-pa);
    orient_to(pa,pb-pa)
        cylinder(r=thickness,h=length);   
};

module ruled_surface(limit,step,thickness=1) {
 for (x=[0:step:limit])
  hull() {
      slice(x,thickness);
      slice(x+step,thickness);
  }
};


function plucker(theta) =sin(theta);  
function wallis(theta,a=1,b=1,c=5) = c * sqrt(a*a-b*b*pow(cos(theta),2));
function helicoid(theta,s) = s * theta;

function conoid(theta) = plucker(theta);

function fa(theta) = [Outer_Radius * cos(theta),
                 Outer_Radius * sin(theta), 
                 Height * conoid(Outer_N*theta)];
function f(x) = fa(x*360);

function ga(theta) = [Inner_Radius*cos(theta),
                 Inner_Radius*sin(theta),
                 Inner_Ratio*Height * conoid(Inner_N*theta)];
function g(x) = ga(x*360);

$fn= Sides;
ruled_surface(1,1/Steps,Thickness);
