width=40;
length=14;
height=16.5;

socket_width=27;
socket_height=5;
socket_length=7;

cube_length=11;
cube_height=11;

mount_width=4.5;
mount_height=4.5;
mount_length=2.5;
mount_r=1.05;

nozzle_height=3.5;
nozzle_width=15;

wall_width=0.9;
thin_wall=0.5;

stena=(cube_length-socket_length)/2;

$fn=150;

module mount(w, l, h, r) {
  // mount na sroubek levy
  
  hole_offset= 0.5;
  
  difference() {
    cube([w,l,h], center=true);
    
    translate([0,0,hole_offset])
    rotate([90,0,0])
    cylinder(r=r,h=l, center=true);
    
    // zaobleni
    translate([0,0,h/2])
    difference() {
      translate([w/4,0,-h/4])
      cube([w/2,l,h/2], center=true);
      
      translate([0,0,-h/2])
      scale([w/h,1,1])
      rotate([90,0,0])
      cylinder(r=h/2,h=l, center=true);
    }
  }
}

module body() {
  difference() {
    union(){
      // vnejsi kostka
      translate([cube_length/2,0,0])
      cube([width-cube_length,cube_length,cube_height],false);
      
      // levy kruhovy okraj
      translate([cube_length/2,cube_length/2,0])
      cylinder(h=cube_height, r=cube_length/2);
      
      // pravy kruhovy okraj
      translate([width-cube_length/2,cube_length/2,0])
      cylinder(h=cube_height, r=cube_length/2);
      
      // mount na sroubek levy
      translate([mount_width/2,cube_length/2,cube_height+mount_height/2])
      mount(mount_width, mount_length, mount_height, mount_r);
      
      // mount na sroubek pravy
      translate([width-mount_width/2,cube_length/2,cube_height+mount_height/2])
      mirror([1,0,0])
      mount(mount_width, mount_length, mount_height, mount_r);
      
      // tenky socket na vetracek
      translate([(width-socket_width)/2-thin_wall,(cube_length-socket_length)/2-thin_wall,cube_height])
      cube([socket_width+2*thin_wall,socket_length+2*thin_wall,5]);
    }

    // spodni vyrez na trysku
    translate([width/2,cube_length-stena/2,wall_width+socket_length/2])
    cube([width-cube_length-stena,stena,socket_length], center=true);
       
        
    // vnitrni kvadr s kulatou hranou pro vyrez
    translate([(width-socket_width)/2,(cube_length-socket_length)/2,socket_length/2+wall_width])
    union(){
      cube([socket_width,socket_length,height-socket_length/2]);
      
      translate([0,socket_length/2,-socket_length/2])
      cube([socket_width,socket_length/2,socket_length]);
      
      translate([0,socket_length/2,0])
      rotate([0,90,0])
      cylinder(h=socket_width, r=socket_length/2);
    }
  }
}

module nozzle(w,ws,l) {
  
  // w sirka trysky u tela
  // ws sirka trysky vepredu
  // l delka trysky
  
  // a zbytek do trojuhelnik, jehoz vyska je l+a
  // c delka sikme strany trysky
  // alpha uhel mezi sikmou stranou a zakladnou
  
  c=sqrt(l*l+pow(w/2-ws/2,2));
  alpha=asin(l/c);
  
  echo("Delka strany c=",c);
  echo("Uhel alpha=",alpha);
  
  a=(ws*sin(alpha))/(2*sin(90-alpha));
  
  triangle_solid_bottom =[
    [-w/2,0],
    [+w/2,0],
    [0,l+a]];
  
  triangle_solid_top =[
    [-w/2+w/2/(l+a)*(socket_length/2-stena/2),socket_length/2-stena/2],
    [w/2-w/2/(l+a)*(socket_length/2-stena/2),socket_length/2-stena/2],
    [0,l+a]];
        
  triangle_paths =[[0,1,2]];
  
  difference() {
    union() {
      // spodni trojuhelnik
      linear_extrude(height = wall_width, convexity = 10)
      polygon(triangle_solid_bottom,triangle_paths,10);
      
      // vrchni trjuhelnik
      #translate([0,0,wall_width+nozzle_height])
      linear_extrude(height = wall_width, convexity = 10)
      polygon(triangle_solid_top,triangle_paths,10);
        

      // kulata stena tela k trysce
      translate([0,socket_length/2-stena/2,wall_width+nozzle_height+socket_length/2])
      intersection(){
        rotate([0,90,0])
        difference(){
          cylinder(r=socket_length/2,h=width-cube_length,center=true);
          r_mensi=(socket_length-stena)/2;
          scale([(r_mensi+(stena/2-wall_width))/r_mensi,1,1])
          cylinder(r=r_mensi,h=width-cube_length,center=true);
        }
        
        translate([0,-socket_length/4,-socket_length/4])
        cube([width-cube_length,socket_length/2,socket_length/2], center=true);
      }
      
      difference(){
        // bocni steny a podpery
        for (i =[
              [-1.0,wall_width],
              [-0.6,thin_wall],
              [ 0.0,thin_wall],
              [ 0.6,thin_wall],
              [ 1.0,wall_width]
          ]){
          c=sqrt(l*l+pow(abs(i[0])*(w/2-ws/2),2));
          alpha=asin(l/c);
          translate([i[0]*(ws/2),l,wall_width+nozzle_height/2+socket_length/4])
          rotate([0,0,i[0]*(90-alpha)])
          translate([-i[0]*i[1]/2,-c/2+thin_wall/2,0])
          cube([i[1],c+thin_wall,nozzle_height+socket_length/2], center=true);
        }
        
        // zadni orez podper
        #translate([-w/2,-stena,wall_width])
        cube([w,stena,socket_length/2+socket_length/4]);
      }
      
      // oble sklopeni trysky
      translate([0,l-wall_width-nozzle_height/2,0])
      intersection() {
      translate([0,0,wall_width+nozzle_height/2])
      rotate([0,90,0])
      difference() {
          cylinder(h=ws+thin_wall, r=wall_width+nozzle_height/2,center=true);
          cylinder(h=ws+thin_wall, r=nozzle_height/2,center=true);
      }
      
      translate([-width/2,0,wall_width+nozzle_height/2])
      cube([width,2*wall_width+nozzle_height,wall_width+nozzle_height/2]);
      }
    }
    
    // orez podper valcovy
    r_mensi=(socket_length-stena)/2;
    translate([0,socket_length/2-stena/2,wall_width+nozzle_height+socket_length/2])
    rotate([0,90,0])
    scale([(r_mensi+(stena/2-wall_width))/r_mensi,1,1])
    cylinder(r=r_mensi,h=width-cube_length,center=true);
    
    // vrchni orez podper
    translate([-w/2,socket_length/2-stena/2,2*wall_width+nozzle_height])
    cube([w,l,socket_length/2]);
    
    // kvadr pro useknuti spodku trysky
    translate([-width/2,l-wall_width-nozzle_height/2,0])
    rotate([-45,0,0])
    cube([width,a+wall_width+nozzle_height/2,a+wall_width+nozzle_height/2]);
    
    // valec pro useknuti vrsku trysky
    translate([-width/2,l-wall_width-nozzle_height/2,0])
    difference() {
      translate([0,0,wall_width+nozzle_height/2])
      cube([width,a+wall_width+nozzle_height/2,wall_width+nozzle_height/2]);
      
      translate([width/2,0,wall_width+nozzle_height/2])
      rotate([0,90,0])
      cylinder(h=width, r=wall_width+nozzle_height/2,center=true);
    }
    
    // pravy bocni orez
    translate([ws/2,l,wall_width/2+nozzle_height/2+socket_length/4])
    rotate([0,0,90-alpha])
    translate([wall_width,-c,0])
    cube([2*wall_width,2*c,wall_width+nozzle_height+socket_length/2], center=true);
    
    // levy bocni orez
    translate([-ws/2,l,wall_width/2+nozzle_height/2+socket_length/4])
    rotate([0,0,-90+alpha])
    translate([-wall_width,-c,0])
    cube([2*wall_width,2*c,wall_width+nozzle_height+socket_length/2], center=true);
  }
}



module tryska() {
  body();
  
  translate([width/2,cube_length,0])
  nozzle(width-cube_length,nozzle_width,length);
}

translate([0,0,0])
tryska();