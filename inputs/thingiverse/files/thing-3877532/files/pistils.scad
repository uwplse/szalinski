
for (ro=[0:120:360])
    rotate ([0,0,ro])
{
    //translate ([50,0,-60])
    linear_extrude 
    (height=100, 
    center= true,twist=60,
    slices=10)
        
    translate ([-80,11,0])
    circle(r=8,$fn=48);
  
    rotate ([3,00,68]) 
    translate ([60,60,55])
    sphere(r=18,$fa=10,$fs=1);
    }
    
for (ro=[45:60:405])
    rotate ([0,0,ro])
{
    translate ([100,0,-60])
    linear_extrude 
    (height=100, 
    center= true,twist=60,
    slices=10)
        
    translate ([-100,20,0])
    circle(r=10,$fn=48);
  
    rotate ([0,0,75]) 
    translate ([88,78,0])
    sphere(r=20,$fa=10,$fs=1);
    }
    
    for (ro=[0:120:360])
    rotate ([0,0,ro])
{
    translate ([50,5,30])
     
    linear_extrude 
    (height=80, 
    center= true,twist=-40,
    slices=10)
    
    rotate ([0,0,240])       
    translate ([-40,00,0])
    circle(r=6,$fn=48);
  
    rotate ([0,0,0]) 
    translate ([42,40,80])
    sphere(r=16,$fa=10,$fs=1);
    }
    
for (ro=[15:60:360])
    rotate ([0,170,ro])
{
    translate ([40,-60,148])
     
    linear_extrude 
    (height=75, 
    center= true,twist=-150,
    slices=10)
    
    rotate ([10,20,0])       
    translate ([-35,44,0])
    circle(r=10,$fn=48);
  
    rotate ([0,180,-5]) 
    translate ([70,40,-200])
    sphere(r=16,$fa=10,$fs=1);
    }
    
    translate ([00,0,-110])
    rotate_extrude(convexity = 10)
translate([18, 0, -0])
circle(r = 10);
    
