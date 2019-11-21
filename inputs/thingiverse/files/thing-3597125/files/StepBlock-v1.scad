//The thinnist step
FirstStepZ = 0.4;
//Step thickness increments
StepIncrementZ = 0.4;
//The thickest step.  This must be a multiple of StepIncrementZ + FirstStepZ
LastStepZ = 2.4;
//Step Width
StepX = 12.0;
//Step Length
StepY = 12.0;
//depth of engraved text label
TextDepth =0.4;

Steps = (LastStepZ/FirstStepZ);

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


