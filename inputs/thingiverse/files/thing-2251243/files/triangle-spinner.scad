o    = 0.1;   // tolerance for holes
t    = 3;     // thick

// smoothness
dOx  = 1;  // 50 for spinner # 1     15 for spinner #2
dOz  = 20; // 5  for spinner # 1     15 for spinner #2

model= 608; // bearing model

dIn  = bearingDimensions(model)[0];
dOut = bearingDimensions(model)[1];
h    = bearingDimensions(model)[2];

r    = dOut+t;

$fn  = 100;
zero = 0.001;


spinner();


module spinner()
{
   difference()
   {
      dTri = 4*dOut+6*t;
      kxy  = dTri/2/(dTri/2+dOx+dOz);
      kz   = h/(2*h+dOz);
   
      rotate([0,0,-30]) 
        scale([kxy,kxy,kz])
           minkowski()
           {  
              cylinder(d=dTri, h=h, center=true, $fn=3);
              cylinder(d=dOx, h=h, center=true);
              sphere(d=dOz);
           }
      
      union()
      {
         cylinder(d=dOut+o, h=h+zero, center=true);
         
         for(a=[0:120:240])
            translate([r*sin(a),r*cos(a),0])
               cylinder(d=dOut+o, h=h+zero, center=true);
         
         for(a=[60:120:300])
            translate([r*sin(a),r*cos(a),0])
               cyl(dOut, h+zero, dOz/3);
      }      
   }
}


module cyl(d,h,o)
{
   cylinder(d=d,h=h,center=true);
   split(h,o) antitoroid(d+o,o);
}  


module split(h,o,big=100)
{
  translate([0,0,h/2-o/2])
  difference()
  { children();
    translate([0,0,-o/4-zero]) cube([big,big,o/2+zero],center=true);
  } 
  
  translate([0,0,-h/2+o/2])
  difference()
  { children();
    translate([0,0,o/4]) cube([big,big,o/2+zero],center=true);
  } 
  
}

module toroid(d,h) 
{ 
   rotate_extrude(convexity = 10) translate([(d-h)/2, 0, 0]) circle(d=h); 
}

module antitoroid(d,h,o) 
{ 
   difference() { cylinder(d=d, h=h, center=true);  toroid(d+h, h);} 
}


function bearingDimensions(model) =
  model == 606      ? [6, 17, 6    ]:
  model == 607      ? [7, 19, 6    ]:
  model == 608      ? [8, 22, 7    ]:
  model == 609      ? [9, 24, 7    ]:
  model == 623      ? [3, 10, 4    ]:
  model == 624      ? [4, 13, 5    ]:
  model == 625      ? [5, 16, 5    ]:
  model == 626      ? [6, 19, 6    ]:
  model == 627      ? [7, 22, 7    ]:
  model == 628      ? [8, 24, 8    ]:
  model == 629      ? [9, 26, 8    ]:
  model == 683      ? [3, 7 , 2    ]:
  model == 688      ? [8, 16, 4    ]:
  model == 689      ? [9, 17, 5    ]:
  model == 697      ? [7, 17, 5    ]:
  model == 6000     ? [10, 26, 8   ]:
  model == 6001     ? [12, 28, 8   ]:
  model == 6003     ? [17, 35, 10  ]:
  model == 6005     ? [25, 47, 12  ]:
  model == 6801     ? [12, 21, 5   ]:
  model == 6804     ? [20, 32, 7   ]:
  model == 6805     ? [25, 37, 7   ]:
  model == 6901     ? [12, 24, 6   ]:
  model == 6902     ? [15, 28, 7   ]:
  model == 6903     ? [17, 30, 7   ]:
  model == 6904     ? [20, 37, 9   ]:
  model == 6905     ? [25, 42, 9   ]:
  model == 6906     ? [30, 47, 9   ]:
  model == 6908     ? [40, 62, 12  ]:
  model == 18       ? [8, 22, 7    ]:
  model == 27       ? [7, 22, 7    ]:
  model == 29       ? [9, 26, 8    ]:
  model == 101      ? [12, 28, 8   ]:
  model == 103      ? [17, 35, 10  ]:
  model == 105      ? [25, 47, 12  ]:
  model == 200      ? [10, 30, 9   ]:
  model == 201      ? [12, 32, 10  ]:
  model == 80016    ? [6, 17, 6    ]:
  model == 80017    ? [7, 19, 6    ]:
  model == 80018    ? [8, 22, 7    ]:
  model == 80019    ? [9, 24, 7    ]:
  model == 80023    ? [3, 10, 4    ]:
  model == 80024    ? [4, 13, 5    ]:
  model == 80025    ? [5, 16, 5    ]:
  model == 80026    ? [6, 19, 6    ]:
  model == 80027    ? [7, 22, 7    ]:
  model == 80028    ? [8, 24, 8    ]:
  model == 80029    ? [9, 26, 8    ]:
  model == 80100    ? [10, 26, 8   ]:
  model == 180016   ? [6, 17, 6    ]:
  model == 180017   ? [7, 19, 6    ]:
  model == 180018   ? [8, 22, 7    ]:
  model == 180019   ? [9, 24, 7    ]:
  model == 180023   ? [3, 10, 4    ]:
  model == 180024   ? [4, 13, 5    ]:
  model == 180025   ? [5, 16, 5    ]:
  model == 180026   ? [6, 19, 6    ]:
  model == 180027   ? [7, 22, 7    ]:
  model == 180028   ? [8, 24, 8    ]:
  model == 180029   ? [9, 26, 8    ]:
  model == 180100   ? [10, 26, 8   ]:
  model == 180101   ? [12, 28, 8   ]:
  model == 180102   ? [15, 32, 9   ]:
  model == 180103   ? [17, 35, 10  ]:
  model == 180104   ? [20, 42, 12  ]:
  model == 180200   ? [10, 30, 9   ]:
  model == 180201   ? [12, 32, 10  ]:
  model == 1000083  ? [3, 7 , 2    ]:
  model == 1000088  ? [8, 16, 4    ]:
  model == 1000096  ? [6, 15, 5    ]:
  model == 1000097  ? [7, 17, 5    ]:
  model == 1000098  ? [8, 19, 6    ]:
  model == 1000801  ? [12, 21, 5   ]:
  model == 1000804  ? [20, 32, 7   ]:
  model == 1000805  ? [25, 37, 7   ]:
  model == 1000900  ? [10, 22, 6   ]:
  model == 1000901  ? [12, 24, 6   ]:
  model == 1000902  ? [15, 28, 7   ]:
  model == 1000903  ? [17, 30, 7   ]:
  model == 1000904  ? [20, 37, 9   ]:
  model == 1000905  ? [25, 42, 9   ]:
  model == 1000906  ? [30, 47, 9   ]:
  model == 1000908  ? [40, 62, 12  ]:
                      [8, 22, 7]; // this is the default
