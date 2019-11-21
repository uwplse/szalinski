//The thinnist step (mm)
FirstStepZ = 0.5;
//Step thickness increments (mm)
StepIncrementZ = 0.5;
//Number of Steps
Steps = 6;
//Step Width (mm)
StepX = 12.0;
//Step Length (mm)
StepY = 12.0;
//depth of engraved text label (mm)
TextDepth =0.4;
LastStepZ = StepIncrementZ*Steps;


for ( z = [FirstStepZ:StepIncrementZ:LastStepZ]){
  translate([StepX*Steps*z/LastStepZ -StepX,0,0]){
    difference(){
      translate([0, -StepY/2, 0]){
        cube([StepX, StepY, z], center=false);
      }
      translate([StepX/2, 0, z-TextDepth]){
        linear_extrude(TextDepth+0.01){
          rotate([0, 0, -90]){
            text(str(z), font = "Liberation Sans", valign="center", halign="center", size=5);
          }
        }
      }
    }
  }
}


