character = "\u9F98";   //accepts standard openscad input
blockSize = 10;
blockFont = "SimSun";   //must be font on computer
for (i=[0:len(character)-1]){ 
    printingBlock(substr(character,i,1), size=blockSize, index=i);
}
module printingBlock(char, size=30, index) {
    translate([size*1.1*index, 0, 0]){
        union() {
            translate([0,0,size/8]) cube([size,size,size/4], center=true);
            
            translate([0,0,size*3/8]) {
                rotate([0,180,0]){
                linear_extrude(height=size/4, convexity=4)
                    text(char, 
                         size=size*22/30,
                         font=blockFont,
                         halign="center",
                         valign="center");
                }
            }
        }
    }
}
function substr(data, i, length=0) = (length == 0) ? _substr(data, i, len(data)) : _substr(data, i, length+i);
function _substr(str, i, j, out="") = (i==j) ? out : str(str[i], _substr(str, i+1, j, out));
$fn=250;