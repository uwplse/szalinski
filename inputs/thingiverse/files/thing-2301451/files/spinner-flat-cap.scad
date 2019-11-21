// minimal diameter of cap, for default 2/3 of outer bearing dimension
dMin  = 19;
// thickness of cap
tCap  = 1.6;
// model of bearing
model = 608;
// quantity
qty   = 2;
// tolerance > 0 for snug fit
o     = 0.03;   
// true for slot
slot  = true;

dIn   = bearingDimensions(model)[0]+o;
dOut  = bearingDimensions(model)[1];
h     = bearingDimensions(model)[2];


$fn   = 100;
zero  = 0.001;

wRim  = 0.1*(dOut-dIn);
tRim  = 0.5;

m     = ceil(sqrt(qty));
n     = ceil(qty/m);

d     = max(dMin, dOut*2/3);
w     = tCap/3/sin(60);

echo(dIn,dOut,h,d);

many_caps();

module many_caps()
{
for(x=[0:m-1],y=[0:n-1])
  translate([x*(d+1),y*(d+1),h/2+tCap+tRim]) rotate([180,0,0]) flat_cap();
}


module flat_cap()
{
  difference()
  {  union()
     {  
      translate([0,0,o])        cylinder(d1=dIn-w, d2=dIn, h=tCap/3);
      translate([0,0,o+tCap/3]) cylinder(d=dIn, h=h/2-tCap/3-o);
     }
     if(slot)
     {
       translate([-w/4,-dIn/2-zero,o-zero]) 
          cube([w/2,dIn+2*zero,h/2-o]);
       translate([-dIn/2-zero,-w/4,o-zero]) 
          cube([dIn+2*zero,w/2,h/2-o]); 
     }
  }
  translate([0,0,h/2])               cylinder(d=dIn+2*wRim, h=tRim);
  translate([0,0,h/2+tRim])          cylinder(d1=d-w,d2=d, h=tCap/3);
  translate([0,0,h/2+tRim+tCap/3])   cylinder(d=d, h=tCap/3);
  translate([0,0,h/2+tRim+tCap*2/3]) cylinder(d1=d,d2=d-1.5*w, h=tCap/3);
}


// Bearing dimensions
// model == XXX ? [inner dia, outer dia, width]:
function bearingDimensions(model,mm=1) =
  model == 606      ? [ 6*mm, 17*mm,  6*mm ]:
  model == 607      ? [ 7*mm, 19*mm,  6*mm ]:
  model == 608      ? [ 8*mm, 22*mm,  7*mm ]:
  model == 609      ? [ 9*mm, 24*mm,  7*mm ]:
  model == 623      ? [ 3*mm, 10*mm,  4*mm ]:
  model == 624      ? [ 4*mm, 13*mm,  5*mm ]:
  model == 625      ? [ 5*mm, 16*mm,  5*mm ]:
  model == 626      ? [ 6*mm, 19*mm,  6*mm ]:
  model == 627      ? [ 7*mm, 22*mm,  7*mm ]:
  model == 628      ? [ 8*mm, 24*mm,  8*mm ]:
  model == 629      ? [ 9*mm, 26*mm,  8*mm ]:
  model == 683      ? [ 3*mm, 7 *mm,  2*mm ]:
  model == 688      ? [ 8*mm, 16*mm,  4*mm ]:
  model == 689      ? [ 9*mm, 17*mm,  5*mm ]:
  model == 696      ? [ 6*mm, 15*mm,  5*mm ]:
  model == 697      ? [ 7*mm, 17*mm,  5*mm ]:
  model == 698      ? [ 8*mm, 19*mm,  6*mm ]:
  model == 6000     ? [10*mm, 26*mm,  8*mm ]:
  model == 6001     ? [12*mm, 28*mm,  8*mm ]:
  model == 6003     ? [17*mm, 35*mm, 10*mm ]:
  model == 6005     ? [25*mm, 47*mm, 12*mm ]:
  model == 6801     ? [12*mm, 21*mm,  5*mm ]:
  model == 6804     ? [20*mm, 32*mm,  7*mm ]:
  model == 6805     ? [25*mm, 37*mm,  7*mm ]:
  model == 6901     ? [12*mm, 24*mm,  6*mm ]:
  model == 6902     ? [15*mm, 28*mm,  7*mm ]:
  model == 6903     ? [17*mm, 30*mm,  7*mm ]:
  model == 6904     ? [20*mm, 37*mm,  9*mm ]:
  model == 6905     ? [25*mm, 42*mm,  9*mm ]:
  model == 6906     ? [30*mm, 47*mm,  9*mm ]:
  model == 6908     ? [40*mm, 62*mm, 12*mm ]:
  model == 18       ? [ 8*mm, 22*mm,  7*mm ]:
  model == 27       ? [ 7*mm, 22*mm,  7*mm ]:
  model == 29       ? [ 9*mm, 26*mm,  8*mm ]:
  model == 101      ? [12*mm, 28*mm,  8*mm ]:
  model == 103      ? [17*mm, 35*mm, 10*mm ]:
  model == 105      ? [25*mm, 47*mm, 12*mm ]:
  model == 200      ? [10*mm, 30*mm,  9*mm ]:
  model == 201      ? [12*mm, 32*mm, 10*mm ]:
  model == 80016    ? [ 6*mm, 17*mm,  6*mm ]:
  model == 80017    ? [ 7*mm, 19*mm,  6*mm ]:
  model == 80018    ? [ 8*mm, 22*mm,  7*mm ]:
  model == 80019    ? [ 9*mm, 24*mm,  7*mm ]:
  model == 80023    ? [ 3*mm, 10*mm,  4*mm ]:
  model == 80024    ? [ 4*mm, 13*mm,  5*mm ]:
  model == 80025    ? [ 5*mm, 16*mm,  5*mm ]:
  model == 80026    ? [ 6*mm, 19*mm,  6*mm ]:
  model == 80027    ? [ 7*mm, 22*mm,  7*mm ]:
  model == 80028    ? [ 8*mm, 24*mm,  8*mm ]:
  model == 80029    ? [ 9*mm, 26*mm,  8*mm ]:
  model == 80100    ? [10*mm, 26*mm,  8*mm ]:
  model == 180016   ? [ 6*mm, 17*mm,  6*mm ]:
  model == 180017   ? [ 7*mm, 19*mm,  6*mm ]:
  model == 180018   ? [ 8*mm, 22*mm,  7*mm ]:
  model == 180019   ? [ 9*mm, 24*mm,  7*mm ]:
  model == 180023   ? [ 3*mm, 10*mm,  4*mm ]:
  model == 180024   ? [ 4*mm, 13*mm,  5*mm ]:
  model == 180025   ? [ 5*mm, 16*mm,  5*mm ]:
  model == 180026   ? [ 6*mm, 19*mm,  6*mm ]:
  model == 180027   ? [ 7*mm, 22*mm,  7*mm ]:
  model == 180028   ? [ 8*mm, 24*mm,  8*mm ]:
  model == 180029   ? [ 9*mm, 26*mm,  8*mm ]:
  model == 180100   ? [10*mm, 26*mm,  8*mm ]:
  model == 180101   ? [12*mm, 28*mm,  8*mm ]:
  model == 180102   ? [15*mm, 32*mm,  9*mm ]:
  model == 180103   ? [17*mm, 35*mm, 10*mm ]:
  model == 180104   ? [20*mm, 42*mm, 12*mm ]:
  model == 180200   ? [10*mm, 30*mm,  9*mm ]:
  model == 180201   ? [12*mm, 32*mm, 10*mm ]:
  model == 1000083  ? [ 3*mm,  7*mm,  2*mm ]:
  model == 1000088  ? [ 8*mm, 16*mm,  4*mm ]:
  model == 1000096  ? [ 6*mm, 15*mm,  5*mm ]:
  model == 1000097  ? [ 7*mm, 17*mm,  5*mm ]:
  model == 1000098  ? [ 8*mm, 19*mm,  6*mm ]:
  model == 1000801  ? [12*mm, 21*mm,  5*mm ]:
  model == 1000804  ? [20*mm, 32*mm,  7*mm ]:
  model == 1000805  ? [25*mm, 37*mm,  7*mm ]:
  model == 1000900  ? [10*mm, 22*mm,  6*mm ]:
  model == 1000901  ? [12*mm, 24*mm,  6*mm ]:
  model == 1000902  ? [15*mm, 28*mm,  7*mm ]:
  model == 1000903  ? [17*mm, 30*mm,  7*mm ]:
  model == 1000904  ? [20*mm, 37*mm,  9*mm ]:
  model == 1000905  ? [25*mm, 42*mm,  9*mm ]:
  model == 1000906  ? [30*mm, 47*mm,  9*mm ]:
  model == 1000908  ? [40*mm, 62*mm, 12*mm ]:
                      [ 8*mm, 22*mm,  7*mm ]; // this is the default


