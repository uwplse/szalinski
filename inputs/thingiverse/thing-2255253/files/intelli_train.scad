$fn=50;

// modification of duplo figure leg for locomotive engineer
module driver()
{
  difference()
  {
    union()
    {
      cube([3,4.4,5.6],center=true);
      translate([0,0,-2.8])
        cylinder(d=3.5,h=5.4+5.6);
    }
    translate([0,0,-.6])
      cube([1.8,100,5.6],center=true);
  }
}


// intellitrain tiles
module tile(pos=0,len=1)
{
  Lsegment=31.5;
  L=Lsegment*3;
  W=25;
  gr=1.4;
  up=5.2-gr;
  down=4;
  space=32;
  
  Lbar1=12;
  Lbar2=25;
  Lbar3=38;
  Lbar4=50;
  
  lentab=[[1,Lbar1],[2,Lbar2],[3,Lbar3],[4,Lbar4]];
  
  off_axis=5;
  barW1=5;
  barW2=3;
  
  module bar(L=Lbar4)
  {
    hull()
    {
      cube([L+20,barW1,.01],center=true);
      translate([0,0,up])
        cube([L,barW2,.01],center=true);
    }
  }
    
  translate([0,0,-(down+gr)/2])
  {
    difference()
    {
      cube([L+9,W,down+gr],center=true);
      translate([0,0,-gr])
      {
        for(i=[-1,1])
          translate([i*Lsegment,0,0])
            cube([Lsegment+3,1000,down+gr],center=true);
        cube([Lsegment-9,1000,down+gr],center=true);
      }
    }
  }
  translate([0,-off_axis,0])
    bar();
  if( len>0 )
  {
    ll=lookup(len,lentab);
    translate([pos*(Lbar4-ll)/2,off_axis,0])
      bar(ll);
  }
}

//driver();

module tile_reverse(){  tile( 0,0);  }
module tile_station(){  tile(-1,1);  }
module tile_horn()   {  tile( 0,1);  }
module tile_shop()   {  tile( 1,1);  }
module tile_wash()   {  tile(-1,2);  }
module tile_cargo()  {  tile( 0,2);  }
module tile_tunnel() {  tile( 1,2);  }
module tile_notuse1(){  tile(-1,3);  }
module tile_fuel()   {  tile( 0,3);  }
module tile_notuse2(){  tile( 1,3);  }
module tile_stop()   {  tile( 0,4);  }

//tile_reverse();
//tile_station();
//tile_horn();
//tile_shop();
//tile_wash(); 
//tile_cargo();
//tile_tunnel();
//tile_fuel();
//tile_stop();


module alltiles(n=[0:1:8])
{
  alltiles_tab = [
    [ 0, 0 ],
    [-1, 1 ],
    [ 0, 1 ],
    [ 1, 1 ],
    [-1, 2 ],
    [ 0, 2 ],
    [ 1, 2 ],
    //[-1, 3 ],
    [ 0, 3 ],
    //[ 1, 3 ],
    [ 0, 4 ]
  ];

  for( nn=n )
  {
    i=alltiles_tab[nn];
    translate([0,nn*26,0])
      tile(i[0],i[1]);
  }
}

alltiles();
