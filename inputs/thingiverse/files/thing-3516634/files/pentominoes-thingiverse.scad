/*
Pentominos using Freeman codes

Kit Wallace 2019-03-17

*/
//use <../lib/tile_fns.scad>
//overall scale 
scale=20;
//height of base tile = 0 for 2d tiles
base_height=0.5;
//defines the overall base offset/ inset - tune for snug fit
base_offset=0;
//height of border
border_height=0.3;
//thickness of border
border_thickness=0.2;
// polyomino to print 0..11  -1 = all
pentomino=-1;
// for chiral shapes : 0 = as given 1 = mirror
mirror=0;

pentominoes=[
    "030101212323",
    "0000122223",
    "033010121223",
    "333000122112",
    "000121123323",
    "333001210122",
    "303030112122",
    "033001211223",
    "000012212323",
    "000101223223",
    "000012221233",
    "0011123233"
    ];
// echo(pentominos);
scale(scale)

if (pentomino==-1)   
   for(i=[0:len(pentominoes)-1]) {  
      translate([5*(i%4),4*floor(i/4)]) {
         code=pentominoes[i];
         print_polyomino(code);
      }
   }
else {
    c = pentominoes[pentomino];
    if (mirror==0)
       print_polyomino(c);
    else { mc=mirror_code(c);
           print_polyomino(mc);
        } 
    } 
 

module print_polyomino(code) {    
   tile=centre_tile(freeman4_to_tile(code));
//   echo(tile);
   if (base_height >0)
   union() {
      linear_extrude(height=base_height)
        offset(delta=base_offset)
          polygon(tile);
      translate([0,0,base_height])
        linear_extrude(height=border_height)
        difference(){
            offset(delta=base_offset)
                polygon(tile);
            offset(delta=-border_thickness)
               polygon(tile);       
        }
    } 
   else 
     difference() {
        offset(delta=base_offset)
         polygon(tile);  
        offset(delta=-border_thickness)
         polygon(tile);  

     } 
}

function freeman4_to_tile(code,point=[0,0],i=0) =
     i == len(code)
     ?  []
     :  let (m=code[i])
        let (diff =
              m=="0" ? [1,0]
             :m=="1" ? [0,1]
             :m=="2" ? [-1,0]
             :m=="3" ? [0,-1]
             :[0,0])
        let (next = point + diff)
        concat([point],freeman4_to_tile(code,next,i+1) )
     ;


function mirror_code(code,i=0) =
    i <len(code)
     ? let(m=code[i])
       let(c=
           m=="0" ? "2"
         : m=="2" ? "0"
         : m)
       str(c,mirror_code(code,i+1))
     :"";
   
function v_sum(v,i=0)=
    i<len(v)
      ? v[i]+v_sum(v,i+1)
      : [0,0] ;
         
function centre_tile(t) =
    let(c = v_sum(t) / len(t))
    [for (p=t) p-c];