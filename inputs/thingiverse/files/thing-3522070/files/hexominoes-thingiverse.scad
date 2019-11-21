/*
Hexominos using Freeman codes

Kit Wallace 2019-03-27

*/
//use <../lib/tile_fns.scad>
//overall scale 
scale=30;
//height of base tile = 0 for 2d tiles
base_height=0.5;
//defines the overall base offset/ inset - tune for snug fit
base_offset=0;
//height of border
border_height=0.3;
//thickness of border
border_thickness=0.2;
// polyomino to print 0..34  -1 = all
polyomino=-1;
// for chiral shapes : 0 = as given 1 = mirror
mirror=0;

polyominoes=[
    "33333301111112",
    "33333011110122",
    "33333011101212",
    "33333011012112",
    "33330111011232",
    "333301101122",
    "33330101210122",
    "33330012110122",
    "333301011212",
    "33330111001222",
    "33330110012212",
    "30333011101222",
    "30330111012232",
    "30301110122332",
    "230011101223332",
    "30301101212332",
    "30330110121232",
    "33301100121232",
    "33300121011232",
    "33301101112332",
    "333010111232",
    "3330011122",
    "30330110112322",
    "303301011222",
    "30301101123232",
    "33301100112322",
    "33301101012232",
    "33301103011222",
    "33301001123212",
    "33030101123212",
    "33010110122332",
    "333000121212",
    "330010121232",
    "330010112322",
    "33010101123232"
    
    ];
// echo(polyominos);
scale(scale)

if (polyomino==-1)   
   for(i=[0:len(polyominoes)-1]) {  
      translate([5*(i%7),-6*floor(i/7)]) {
         code=polyominoes[i];
         print_polyomino(code);
      }
   }
else {
    c = polyominoes[polyomino];
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