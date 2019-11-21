$fn = 90;
zero=  0.001;

o   =  0.4;         // допуск по дырке под подшипник
                    
dB  = 22.0+o;       // внешний диаметр подшипника
hB  =  7.0;         // толщина подшипника
                    
n   =  4;           // кол-во подшипников от 1 до 7
angle = 360/(n-1);  // угол между подшипниками

dBt = dB+hB/2;      // расстояние между центрами подшиников
dBo = dB+hB;        // диаметр тора для подшиника

// дырка под подшипник
module bearing(d)
{  
   translate([0,0,-zero]) cylinder(d=d, h=hB+2*zero); 
}

// тор
module toroid(d) 
{ 
  translate([0,0,hB/2]) rotate_extrude(convexity = 10) translate([(d-hB)/2, 0, 0]) circle(d=hB); 
}

// цилиндр с вырезанным тором
module antitoroid(d) 
{ 
   difference() { cylinder(d=d, h=hB);  toroid(d+hB);} 
}

// зеркалирование
module double() 
{
   children();   
   mirror() children(); 
}


// часть спиннера
module part()
{ 
  toroid(dBo);
  translate([0,dBt,  0]) toroid(dBo); 
  
  translate([0,dBt/2,0]) double() 
  difference()
  {  x =tan(60)*dBt/2;
     linear_extrude(height=hB) polygon([[0,-dBt/2],[x,0],[0,dBt/2]]);
     translate([x,0,-zero]) scale([1,1,1.001]) antitoroid(dBo);
  }  
}

// спиннер целиком
module spinner()
{  
   difference()
   {  for(a=[0:angle:360-angle])  rotate([0,0,a-90]) part();
      
      bearing(dB);
      for(a=[90-angle:angle:450-angle])  translate([sin(a)*dBt,cos(a)*dBt,0]) bearing(dB);
   }
}   

 
spinner();

