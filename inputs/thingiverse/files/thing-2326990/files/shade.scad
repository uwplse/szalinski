small_diameter=116;
large_diameter=140;
thickness=1;
inset=2;
height=55;

rotate_extrude($fn=200)
  sketch();

module sketch() {
  small_half=small_diameter/2;
  large_half=large_diameter/2;
  polygon([
    [-(small_half-thickness),0],
    [-small_half,0],
    [-small_half,inset],
    [-large_half,height+inset],
    [-(large_half-thickness),height+inset],
    [-(small_half-thickness),inset],    
  ]);
}