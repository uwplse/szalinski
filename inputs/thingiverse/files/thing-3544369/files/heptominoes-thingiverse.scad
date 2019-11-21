
/*
Heptominos using Freeman codes

Kit Wallace 2019-04-04
"
*/
//use <../lib/tile_fns.scad>
//overall scale 
scale=30;
//height of base tile = 0 for 2d tiles
base_height=0.3;
//defines the overall base offset/ inset - tune for snug fit
base_offset=0;
//height of border
border_height=0.3;
//thickness of border
border_thickness=0.3;
// polyomino to print 0..34  -1 is all
polyomino=89;
// for chiral shapes : 0 = as given 1 = mirror
mirror=0;

polyominoes=
   ["3011111112333333", "0121111123333330", "0121111233333301", "0121112333333011", "12111233333001", "3011211112333330", "0122111123333300", "0121123333300121", "0121233333001211", "0122333330012111", "2303333001211112", "2303330012111123", "2303300121111233", "2303001211112333", "2300012111123333", "12112333330101", "0122111233333010", "0121233333010121", "2303330101211123", "2303301012111233", "2303010121112333", "0122112333330110", "2303301101211233", "121233330011", "30111211233330", "01221123333001", "01223333001121", "01212112333300", "23033300112112", "23033001121123", "23030011211233", "23000112112333", "3011121112333303", "0121211123333030", "0122111233330301", "0121233330301121", "0122333303011211", "2303330301121112", "2303303011211123", "2303030112111233", "2300301121112333", "3011221112333300", "0122211123333000", "0121233330001221", "0122333300012211", "1232111233330001", "2303330001221112", "2303300012211123", "2303000122111233", "2300001221112333", "0122123333001210", "2303330012101212", "2303300121012123", "2303001210121233", "2300012101212333", "2303330012110122", "2303300121101223", "30300121112323", "2300330012111232", "2300300121112332", "01221233330101", "23033010112123", "3011221123333010", "1232112333301001", "2303301001221123", "2303010012211233", "012223330011", "012122333001", "01211212333030", "01212123330301", "01221233303011", "12321233300101", "23033001012212", "30112121233300", "303001121223", "12330330011212", "23003300112122", "0121121123330330", "0121211233303301", "0122112333033011", "0122333033011121", "3011212112333030", "0122121123330300", "0122333030012121", "2303303001212112", "2303030012121123", "2300300121211233", "0122333030101221", "1232112333030101", "2303303010122112", "2303030101221123", "0122233303011210", "1232333030112101", "2303303011210122", "2303030112101223", "2300301121012233", "1233033030112112", "2300330301121122", "2300301121122303", "3010301121123323", "3011122112333003", "0122333003011221", "1232112333003011", "2303300301122112", "0122233300012210", "1232101223330001", "2300012101222303", "0121212123303030"]
;
// echo(polyominos);
scale(scale)

if (polyomino==-1)   
   for(i=[0:len(polyominoes)-1]) {  
      translate([5*(i%12),-7*floor(i/12)]) {
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
   tile=centre_tile(freeman4_to_points(code));
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

function freeman4_to_points(code,point=[0,0],i=0) =
     i == len(code)
     ?  []
     :  let (m=code[i])
        let (step =
              m=="0" ? [1,0]
             :m=="1" ? [0,1]
             :m=="2" ? [-1,0]
             :m=="3" ? [0,-1]
             :[0,0])
        concat([point],freeman4_to_points(code,point+step,i+1) )
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