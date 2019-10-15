difference(){
union (){
cylinder (r=4,h=5, center=true, $fn=50);
rotate ([0,45,0]){cylinder (r=4,h=20, center=true, $fn=50);}
rotate ([0,-45,0]){cylinder (r=4,h=20, center=true, $fn=50);}
rotate ([0,90,0]){cylinder (r=4,h=20, center=true, $fn=50);}
rotate ([0,180,0]){cylinder (r=4,h=20, center=true, $fn=50);}
rotate ([90,0,0]){cylinder (r=4,h=7, center=true, $fn=50);}
}
union (){
cylinder (r=1.5,h=6, center=true, $fn=50);
rotate ([0,45,0]){cylinder (r=1.5,h=21, center=true, $fn=50);}
rotate ([0,-45,0]){cylinder (r=1.5,h=21, center=true, $fn=50);}
rotate ([0,90,0]){cylinder (r=1.5,h=21, center=true, $fn=50);}
rotate ([0,180,0]){cylinder (r=1.5,h=21, center=true, $fn=50);}
rotate ([90,0,0]){cylinder (r=1.5,h=8, center=true, $fn=50);}
}
}