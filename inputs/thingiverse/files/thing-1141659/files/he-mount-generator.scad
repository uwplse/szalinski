// Roadfeldt - Hot End Mount Generator
//
/*
  Copyright (C)2015-2017 Chris Roadfeldt <chris@roadfeldt.com>

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
//
// Includes E3D Chimera openscad design by Author: Professional 3D - Jons Collasius from Germany/Hamburg
// URL Professional 3D: http://professional3d.de
// http://www.thingiverse.com/thing:1018787
//
// Includes E3D Cyclops openscad design by Author: Professional 3D - Jons Collasius from Germany/Hamburg
// URL Professional 3D: http://professional3d.de
// http://www.thingiverse.com/thing:1018957
//
// Includes E3D V6 openscad design by Author: Professional 3D - Jons Collasius from Germany/Hamburg
// URL Professional 3D: http://professional3d.de
// http://www.thingiverse.com/thing:548237
//
// Includes E3D V6 w/ Volcano openscad design by Author: Professional 3D - Jons Collasius from Germany/Hamburg
// URL Professional 3D: http://professional3d.de
// http://www.thingiverse.com/thing:862716
//
// Includes Lulzbot Hexagon Hot End openscad design by andreas.thorn@gmail.com -- This model is inaccurate according to lulzbot documentation. Mount is correct.
// https://www.youmagine.com/designs/hexagon-hotend-visualization

// Which hotend are we importing? Can only use one at a time, Jons uses the same variable
// and module names and openscad doesn't support conditionally import as far as I can tell.
//use<e3d_v6_chimera.scad>;
//use<e3d_vulcano_chimera.scad>;
//use<e3d_cyclops.scad>;
//use<e3d_v6_all_metall_hotend.scad>;
use<e3d_v6_volcano_all_metall_hotend.scad>;
use<Hexagon-102.scad>;

// Bring in the basic delta fan designs I created for visualization.
use<delta_blower_fans.scad>;

/* [Features] */

// What type of Carriage do you use / need?
carriage = "cbot"; // [cbot:C Bot style, prusai3:Prusa i3]

// Which hot end is in use. Ensure you enter height from top of mount to tip of nozzle if you select generic J Head.
hotend = "e3d_v6_vol"; // [chimera_v6:Chimera Dual V6, chimera_vol:Chimera Dual Volcano, cyclops:Cyclops, e3d_v6:E3D V6, e3d_v6_vol:E3D V6 w/ Volcano, jhead_mkv:J Head Mark V, hexagon:Hexagon, gen_jhead:Generic J Head]

// Where should the hot end mount be positioned vertically? Optimized changes the mount height to increase vertical build height as much as possible. Universal keeps the mount height the same for all hot ends allow for easier interchange.
hotendOpt = "optimize"; // [ optimize:Optimized, universal:Universal]

// What style of extruder are you using?
extruder = "titan"; // [bowden:Bowden, titan:E3D Titan, carl_direct:Carl Feniak Direct Drive - Not ready yet.]

// What type of fan duct should be made?
fanDuctStyle = "simple"; // [simple:Simple single outlet]

// Which Z Probe type is in use. Select Servo here if you want to if you Servo Bracket selected above, otherwise it won't appear.
servoInduct = "induct"; // [servo:Servo w/ Arm, induct:Inductive / Capacitive Sensor, bltouch:BL Touch, none:Neither/None]

// Which side should the z probe be on? Be mindful of clearance with fan mount.
// If you choose a titan extruder, this will be overridden to left.
zProbeSide = "left"; // [right:Right of hot end., left:Left of hot end.]

// Which side should the fan mount to? Be mindful of Z probe clearance.
printFanSide = "left"; // [left:Left side of hot end., right:Right side of hot end., none:No print cooling fan.]

// Should the fan outlet point towards the left or the right? Be mindful of Z probe clearance.
printFanDirection = "right"; // [left:Fan outlet to the left, right:Fan outlet to right]

// Should the nut traps be closed, so printing support is not needed? This will mean the holes with nut traps will be closed with .1mm amount of material which will need to be removed prior to use.
boltHoleSupportFix = 1; // [ 1:Yes, 0:No]

// Should the parts be exploded, do this before producing the stl file. You will still receive a single STL file with all the parts, but they will be separated so you can split them up with Cura or NetFabb. Select no if you want to see the parts fit together as they would on the printer. Selecting no will NOT produce a valid STL for printing as the parts will be inseparable.
explodeParts = 1; // [1:Yes, 0:No]

/* [Prusa i3] */

// Which part should be displayed.
// xcar = X Carriage mount
// serv = Servo Bracket
// fanm = Fan Mount
// fant = Fan Bracket
// duct = Fan Duct
// mag = Magnetic Z Probe mount
// zpro = Z Probe arm used with servo
// jhead_col = J Head style collar
// bltouch = BL Touch mount
// all = All parts

// Which Prusa i3 part should be exported.
prusai3Which = "all"; // [hotm:Back Plane & Cold / Hot End  Mount, jhead_col: J Head Style Collar, servo:Servo Bracket, fanm:Fan Mount, fant:Fan Bracket, duct:Fan Duct, zarm:Z Probe Servo Arm, induct:Inductive / Capacitive Sensor, bltouch:BL Touch, all:All Parts ] 

// How wide to make the X Carriage back plane.
xMountWidth = 40;

// How high to make the X Carriage back plane. Affects both X Carriage and servo mount.
xMountHeight = 40;

// How deep the overall X Back Plane should be.
xMountDepth = 5;

// The radius of the rounded X Back Plane corners.
xMountCornerRadius = 4;

// How wide to make the X Carriage nut traps, point to point, not flat to flat.
xMountNutDiameter = 8.8;

// How deep to make the X Carriage nut traps.
xMountNutDepth = 3.8;

// How wide to make the X Carriage bolt shaft holes.
xMountBoltDiameter = 4.5;

// Distance between mounting bolt holes in the horizontal direction
xMountHoleWidth = 23;

// Distance between mounting bolt holes in the vertical direction
xMountHoleHeight = 23;

// How wide to make the tab the cooling fan hangs off of.
prusai3FanTabWidth = 8;

// How far out should the tab the cooling fan hangs off of be. Must be above 0.
prusai3FanTabDepth = 4;

// Degrees the fan mount is rotated in the vertical.
prusai3FanTabVerticalAngle = 0;

// Degrees the fan mount is rotated in the horizontal. Affects fan duct only.
prusai3FanTabHorizontalAngle = 0;

// How large to make the bolt hole that the fan bracket will bolt to.
prusai3FanTabHole = 3.5;

// How much material should be around the fan bracket screw.
prusai3FanTabMat = 2;

// How wide the nubs on each side of the fan mount tab should be.
prusai3FanTabNubWidth = 4;

// How deep the fan bracket should be.
prusai3FanBracketDepth = 3;

// How much vertical offset should be added / removed for a titan mount.
prusai3TitanVertOffset = 15;

/* [C Bot Carriage] */

// Which part should be displayed.
// hotm = Carriage side with hot end
// carrside = Carriage side opposite hot end side. This one is for accessories.
// serv = Servo Bracket
// fanm = Fan Mount
// fant = Fan Bracket
// duct = Fan Duct
// mag = Magnetic Z Probe mount
// zarm = Z Probe arm used with servo
// jhead_col = J Head style collar
// induct = Inductive Sensor Mount
// xbump = X Endstop Bumper
// bltouch = BL Touch mount
// all = All parts

// Which C Bot part should be exported.
cBotWhich = "all"; // [hotm:Carriage with Cold / Hot End  Mount, carrside: Carriage Side, jhead_col:J Head Style Collar, belth:Belt Holder, servo:Servo Bracket, fant:Fan Mount Bracket, fanm:Fan Mount, duct:Fan Duct, zarm:Z Probe Servo Arm, induct:Inductive / Capacitive Sensor, xbump:X Endstop Bumper, bltouch:BL Touch, all:All Parts] 

// Do you want a carriage mount axis limit switch?
cBotXAxisSwitch = "yl99"; // [yl99:YL-99, keyes:Keyes, gen:Generic Mini Switch, none:None]

// Which side should have the endstop mount?
cBotXAxisSwitchSide = "acc"; // [he:Hot End, acc:Accessory, both:Both]

// Which carriage should the probe mout on?
cBotProbeCarriage = "he"; // [he:Hot End Carriage, acc:Accessory Carriage]

// How deep into the carriage should the switch be recessed?
cBotXAxisSwitchDepth = 1;

// How far should the switch stick out from the carriage?
cBotXAxisSwitchOffset = 2;

// How far in should the cutout for the through hole cavity be?
cBotXAxisSwitchTHOffset = 2.5;

// Minimum width of carriage, will be increased if needed.
cBotCarriageMinWidth = 40;

// Should the carriage have 3 or 4 wheels?
cBotNumberOfCarriageWheels = "4"; // [3:Three Wheels, 4:Four Wheels]

// Amount of material around screw holes for carriage idler wheels.
cBotCarriageIdlerScrewMat = 3.3;

// Height of XY Bar .
cBotXYBarHeight = 40;

// Distance between wheel centres to add to height of XY bar (10mm for solid v-wheels, Unknown for mini wheels).
cBotWheelOffsetFromBar = 10;

// Depth of carriage.
cBotCarriageDepth = 5;

// Diameter of screw holes for carriage idler wheels.
cBotCarriageIdlerScrewDiameter = 5.2;

// Diameter of screw holes for carriage eccentric spacer.
cBotCarriageEccentricSpacerScrewDiameter = 7.2;

// Diameter of screw holes that mounts back plane to carriage.
cBotCarriageMountScrewDiameter = 4.2;

// Horizontal distance of screw holes for back plane mount. Not used if hot end mount is integrated.
cBotCarriageMountScrewHorizontalDistance = 30;

// Vertical distance of screw holes for back plane mount. Not used if hot end mount is integrated.
cBotCarriageMountScrewVerticalDistance = 30;

// Vertical position of back plane mount from bottom of carriage. Not used if hot end mount is integrated.
cBotBackMountVertPosition = 40;

// Vertical position of fan bracket.
cBotFanMountPos = 25;

// Vertical position of accessory mount holes. Offset from top and bottom respectively.
cBotAccessoryMountPos = 7;

// Vertical position of cable tie locations. Offset from top down.
cBotCableTieVerticalPos = 4.5;

// Vertical distance of cable tie locations. Offset from top down.
cBotCableTieVerticalDistance = 15;

// How many rows of cable tie cut outs should there be?
cBotCableTieVerticalCount = 3;

// How many columns of cable tie cut outs should there be?
cBotCableTieHorizontalCount = 3;

// How much to shrink the horizontal spacing of the cable ties?
cBotCableTieHorizontalOffset = 5;

// How much vertical offset should be added / removed for the titan mount?
cBotTitanVertOffset = -12;

/* [Hot End Settings] */

// How far out to offset the Hot End from the rear of the mount.
heDepthOffset = 0.0; // Not needed, but kept just in case.

// Hot end mount height offset. Positive number = higher, negative = lower.
heHeightOffset = 0;

// Thickness of Chimera mount vertical brace.
chiBraceThickness = 4;

// How thick the Chimera mount top plate should be.
chiMountHeight = 5;

// Enter height in millimeters from the top of the J Head mount, usually that is the top of the cold end itself. The top of the mount is 3.7 mm from the top of the inner groove of the J Head mount.
genJHeadHeight = 0;

// J Head adjustments. How much to adjust the J Head mount. Really dependent on your printer. Print a calibration cube and enter the adjustments in size here. These are mm and will be added to their respective parameters. eg; you want to make the height of the collar in the middle smaller by .2mm, enter -.2 in innerCollarHeightAdjustment. If you want to make that same collar a larger hole by .2mm, enter .2 in innerCollarDiameterAdjustment.

upperCollarDiameterAdjustment = .1;
upperCollarHeightAdjustment = .15;
innerCollarDiameterAdjustment = .2;
innerCollarHeightAdjustment = -0.3;
lowerCollarDiameterAdjustment = .1;
lowerCollarHeightAdjustment = .15;

/* [Print Cooling Fan] */

// How thick the fan mount should be.
fanMountThickness = 4;

// Diameter of the hole for the screws that hold the fan on to the mount.
fanMountScrewDiameter = 4.5;

// Amount of material around the fan screw holes.
fanMountScrewMat = 3;

// X,Y coordinates of holes for fan screw relative to the center of the fan.
fanMountScrews = [[-16,17],[21,20],[12,-17],[-22,-18]]; // 51x15

// Dimensions of the fan. Width, depth, height when looking at it from the side.
fanDimensions = [51,15,51];

// Outside dimensions of fan outlet
fanDuctConnectSize = [20, 15.4, 15.4];

// Offset from center of fan body to center of fan tab. Left / Right, Forward / Back, Up / Down. Usually only need Left / Right.
fanMountOffset = [2,0,0];

// Offset the center of the fan blower in relation to the overall fan body. Usually negative value of fanMountOffset.
fanCenterOffset = [-2,0,0];

// Diameter of fan opening. If your fan has air intakes on both sides, enter the diameter of that opening here.
fanIntakeDiameter = 20;

// How much clearance between the fan mount nubs and the fan tab. Too much of a gap and the fan mount will not snug up properly.
fanTabNubClear = .1;

// How far below the bottom of the fan should the bowl of the duct be.
fanDuctBowlDepth = 5;

// How thick should the exterior walls of the fan duct be?
fanDuctThickness = 1;

// How thick should the interior walls of the fan duct be?
fanDuctInternalThickness = .8;

// How far the fan duct should overlap the inside edge of the fan itself when connected.
fanDuctOverlap = 2;

// How far the fan duct should overlap the outside edge of the fan itself when connected.
fanDuctOutsideOverlap = 2;

// How far below the nozzle should the fan outlet point?
fanDuctOutletOffset = 0;

// Offset from the nozzles where the fan duct outlets should be placed. Leave named variables in place.
fanDuctOutletNozzleOffsetL = [16,3]; // [0] X distance from nozzle for start of duct opening, fanDuctThickness will be subtracted from this [1] Z distance from nozzle tip. + up, - down
simpleFanDuctOutletNozzleOffsetL = [12,1.5]; // [0] X distance from nozzle for start of duct opening, fanDuctThickness will be subtracted from this [1] Z distance from nozzle tip. + up, - down

// Size of air chamber around fan duct ring.
fanDuctAirChamberSize = [5,1.5]; // [0] X width of internal portion of air chamber, [1] Z height of internal portion of air chamber.

// Size of the fan duct outlets.
fanDuctOutletSize = [8,4]; // [0] Number of outlets, will be spread out equally. [1] Size of outlets.
simpleFanDuctOutletSize = [25,.1,4];

// Length of runner before Simple Fan Duct Nozzle
simpleFanDuctRunnerLength = 0;

// Extra vertical offset from nozzle.
simpleFanDuctRunnerOffset = 0;

/* [Z Probe / Servo] */

// How high should the probe extension be for the Prusa i3 carriage? Normally full height to avoid issues with endstops and other parts of printer.
probeExtHeight = "full"; // [full:Full Height of X Carriage, minimum:Minimum required to support probe mount]

// How much of a gap from the edge of the X Carriage back plane to the inside of the servo mount.
probeExtWidth = 25;

// How wide the servo body is when held vertical and mount holes on top and bottom with output facing away.
servoWidth = 12;

// How tall the servo body is held in the same orientation as servoWidth.
servoHeight = 23.5;

// How tall the servo mounting bracket is. Held in the same orientation as servoWidth.
servoMountPlateHeight = 32;

// Center to center distance for mounting screws on servo.
servoScrewDistance = 28;

// Diameter of screws holes used for mounting servo. Should be slighty smaller than screw.
servoScrewDiameter = 1.5;

// How much material should exist around the servo and servo mount screws.
servoBracketMat = 1.5;

// Diameter of screw holes used for mount bracket that the hold servo bracket.
servoBracketScrewDiameter = 3.5;

// Size of hole for nut trap for servo bracket. Point to point, not flat to flat.
servoBracketNutDiameter = 6.5;

// Depth of hole for nut trap for servo bracket.
servoBracketNutDepth = 2.4;

// Depth of the servo bracket base.
servoBracketBaseDepth = 2;

// Offset of servo mount from the bracket. Allows for C Bot bracket screws to clear. Keep in mind the fan mount probably needs to be adjusted as well so servo and fan mount and fan duct don't interfere with each other.
servoBracketOffset = 1;

// Distance between center of servo motor output and side of the servo body.
servoCenterOffset = 5;

// Diameter of whole the servo fits through to mount the arm.
servoShaftDiameter = 6.2;

// Diameter of servo hat where it connects to the servo motor.
servoHatTopDiameter = 6.2;

// Length of servo hat.
servoHatLength = 19;

// Diameter of servo hat at the opposite end of the servo mount, the tip of the servo hat.
servoHatTipDiameter = 4.2;

// Depth the servo hat should recess into the Z Probe Arm.
servoHatRecessDepth = 2;

// Thickness of the Z Probe arm.
zProbeThickness = 4;

// Diameter of Z Probe switch mounting screws.
zProbeScrewDiameter = 2;

// Distance between Z Probe switch mount screws.
zProbeScrewDistance = 10;

// Distance from servo bracket to Z Probe Arm, purely for visualizing how the arm fits in the space provided.
zProbeArmOffset = 4;

// How much material should around the holes in the arm.
zProbeArmMat = 2;

// Distance between the switch mount holes and the side with the switch.
zProbeSwitchHeight = 7.5;

// Distance below nozzle you want the switch to trigger, roughly, depends on switch activation point.
zProbeSwitchActivationDistance = 5;

/* [Inductive / Capacitive Sensor] */

// Distance between hot end mount and side of induct mount. Only applicable to Prusa i3.
inductMountDistance = 8;

// Diameter of sensor.
inductDiameter = 12.6;

// Amount of material around sensor, account for nuts and washers around the sensor.
inductMat = 5;

// Height of mount plate above nozzle tip. This is over written if universal mount height is selected.
inductPlateHeight = 25;

// How much extra should be added to the carriage width to provide clearance for the inductive mount bracket.
inductBracketExtra = 6;

/* [ Generic Probe Mount Variables ] */

// Offset of mount from back of X Carriage back plane.
probeOffset = 0;

// Thickness of sensor mount plate.
probePlateThickness = 3;

// Depth of back plate of probe mount.
probeBracketDepth = 3;

// Height of sensor mount braces.
probeBraceHeight = 20;

// Width of braces.
probeBraceWidth = 3;

// Diameter of screws that hold bracket on.
probeBracketScrewDiameter = 3.2;

// Diameter of nuts that hold bracket on.
probeBracketNutDiameter = 6.5;

// Depth of hole for nut trap for probe sensor bracket.
probeBracketNutDepth = 2.4;

// Mount inductive or BL Touch sensor with a removable bracket?
probeMountBracketed = 1; // [0:No, 1:Yes]

/* [Prusa i3 Carriage Advanced] */

// Variables used for calculations and not normally change variables..
xMountBoltDepth = (xMountDepth - xMountNutDepth); // How deep the X Carriage bolt shafts hole are.
xMountHoleWidthOffset = (xMountWidth - (xMountHoleWidth /2));
xMountHoleHeightOffset = (xMountHeight - (xMountHoleHeight /2));

/* [Chimera / Cyclops Advanced] */

// Variables for E3D Chimera / Cyclops
chiColdHeight = 30;
chiColdDepth = 16;
chiScrewHole = 3.2; // Size of hole for screws that mount the Chimera Cold End.
chiBowdenHole = 8.2; // Size of hole for bowden tube fittings.
chiHEPosUD = (carriage == "prusai3" ? 15 : 20);
chiBraceLength = chiColdDepth; // Length of brace for chimera mount in the horizontal. From back plane towards the front.
chiBraceHeight = (chiColdHeight / 2) - (carriage == "prusai3" ? (chiHEPosUD - (chiColdHeight / 2) < xMountCornerRadius ? xMountCornerRadius - (chiHEPosUD - (chiColdHeight / 2)) : 0) : 0);
chiWidth = 31; // Width of Chimera is 30, use 31 to account for 3d printer material overage. Use 30.5 for cnc.
chiMountDepth = (heDepthOffset + 20); // How far out the Chimera mount top plate should be.
chiMountWidth = (chiBraceThickness * 2) + chiWidth; // The width of the Chimera mount top plate.
chiScrewHoleHeight = chiMountHeight + .2; // How tall to make the Chimera mount screw holes.
chiScrewLocs = [[(chiMountWidth / 2) - 8.5, chiMountDepth - (heDepthOffset + 15)],
		[(chiMountWidth / 2), chiMountDepth - (heDepthOffset + 3)],
		[(chiMountWidth / 2) + 8.5, chiMountDepth - (heDepthOffset + 15)]]; // X,Y locations for Chimera mount screw holes.
chiBowdenHoleHeight = chiMountHeight + .2; // How tall to make the Bowden tube fitting holes.
chiBowdenLocs = [[(chiMountWidth / 2) - 9, chiMountDepth - (heDepthOffset + 6)],
		 [(chiMountWidth / 2) + 9, chiMountDepth - (heDepthOffset + 6)]]; // X,Y locations for Bowden tube fitting holes.
chiV6NozzleL = [[6,-6,-49.6],[24,-6,-49.6]]; // Location of Chimera V6 Nozzles in relation to top rear left corner of cold end.
chiVolNozzleL = [[6,-6,-59.6],[24,-6,-59.6]]; // Location of Chimera Volcano nozzles in relation to the top rear left corner of cold end.
cycNozzleL = [[15,-6,-50.1]]; // Location of Cyclops nozzle in relation to the top rear left corner of cold end.
chiCBotProbePos = 1; // Mounting position of probe mounts for the E3D Chimera on the C-Bot carriage.

/* [J Head Mount Advanced */

// Variables for J Head Mount
jHeadWidth = 26;
jHeadUpperCollarDiameter = upperCollarDiameterAdjustment + 16;
jHeadUpperCollarHeight = upperCollarHeightAdjustment + (hotend == "hexagon" ? 4.7 :
							(hotend == "jhead_mkv" ? 4.76 :
							 3.7));
jHeadInnerCollarDiameter = innerCollarDiameterAdjustment + 12;
jHeadInnerCollarHeight =  innerCollarHeightAdjustment + (hotend == "hexagon" ? 4.5 :
							 (hotend == "jhead_mkv" ? 4.64 :
							  6));
jHeadLowerCollarDiameter = lowerCollarDiameterAdjustment + 16;
jHeadLowerCollarHeight = lowerCollarHeightAdjustment + (hotend == "hexagon" ? 4.6 : 3);
jHeadMountHeight = jHeadUpperCollarHeight + jHeadInnerCollarHeight + jHeadLowerCollarHeight;
jHeadHEPosUD = (carriage == "prusai3" ? 14 : (hotendOpt == "universal" ? 21 : (
						   hotend == "e3d_v6" ? 21 :
						   (hotend == "jhead_mkv" ? 11 :
						    (hotend == "generic_jhead" ? 11 :
						     (hotend == "hexagon" ? 14 : 21))))));
jHeadMountWidth = 36;
jHeadCollarCornerRadius = 3;
jHeadMountBoltDiameter = 3.2;
jHeadMountNutDiameter = 6.5;
jHeadMountNutDepth = 2.4;
jHeadFanScrewOffset = 5;
jHeadMountScrewHorizontalOffset = (jHeadWidth / 4);
jHeadMountScrewVerticalOffset = (jHeadMountHeight / 2);
jHeadCBotProbePos = 2; // Mounting position of probe mounts for J-Head mount based hotends on the C-Bot carriage.

/* [Hidden] */
// If the hotend is a chimera / cyclops based one, force extruder to be bowden and fan duct style to be classic..
realExtruder = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops") ? "bowden" : extruder;
realFanDuctStyle = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops") ? "classic" : fanDuctStyle;
echo("realFanDuctStyle", realFanDuctStyle);

// Depth from center of hotend to face of carriage.
jHeadMountDepth = 28.5; // Do not change this value, the direct drive extruders require this to be placed here and OpenSCAD programming makes it nearly impossible to auto adjust.

// Height of c-Bot carriage. 

 cBot3WheelHeight = cBotXYBarHeight + (cBotWheelOffsetFromBar * 2) + (cBotCarriageIdlerScrewMat * 2) + (cBotCarriageIdlerScrewDiameter /2) + (cBotCarriageEccentricSpacerScrewDiameter /2);
 cBot4WheelHeight = cBotXYBarHeight + (cBotWheelOffsetFromBar * 2) + (cBotCarriageIdlerScrewMat * 2) + (cBotCarriageIdlerScrewDiameter);
 cBotCarriageHeight = (cBotNumberOfCarriageWheels == "3") ? cBot3WheelHeight : cBot4WheelHeight;
 echo ("carriage height:",cBotCarriageHeight);

 /* [E3D V6 Advanced] */

// Variables for E3D V6
v6NozzleL = [[0, 0, -62]]; // This must be a vector of vectors. If only one nozzle, enter x,y,z in [[ ]]
v6VolNozzleL = [[0,0,-70.5]]; // This must be a vector of vectors. If only one nozzle, enter x,y,z in [[ ]]

/* [J Head Mark V Advanced] */

// Variables for J Head Mark V
jheadMkVNozzleL = [[0, 0, -51]]; // This must be a vector of vectors. If only one nozzle, enter x,y,z in [[ ]]

/* [Hexagon Advanced] */

// Variables for Hexagon Hot End
hexagonNozzleL = [[0, 0, -55]]; // This must be a vector of vectors. If only one nozzle, enter x,y,z in [[ ]]

/* [Generic J Head Advanced] */

// Variables for Generic J Head Hot End
genericJHeadNozzleL = [[0, 0, -genJHeadHeight]]; // This must be a vector of vectors. If only one nozzle, enter x,y,z in [[ ]]

/* [E3D Titan Extruder Advanced] */

// Variables for E3D Titan extruder.
e3dTitanMountMat = 4; // How much material should be around the face of the mount.
e3dTitanMountCornerRadius = 4; // The radius of the corners for the mounting plate.
e3dTitanMountBraceWidth = 2; // Width of the brace that stabilizes the E3D Titan and Stepper.
e3dTitanMountBraceHeight = 5; // Height of brace.
e3dTitanMountLowerOverlap = 15; // Amount the brace overlaps the main carriage.

// Should a cut out be made for the extruder stepper?
extruderStepper = "normal"; // [normal:Typical size, non-pancake, pancake:Pancake]

/* [Hidden] */

// E3D Titan settings
e3dTitanOffset = [11.1,13.5]; // This is offset of the filament path. 0 - From center of stepper shaft, 1 - From face of carrier / mount. Do not change.
e3dTitanMountThickness = 7; // Only use the 7mm mount spacing. This allows for easier printing and provides a better thermal mass to reduce warping due to stepper overheating.
e3dTitanFilamentSideBodyOffset = 4; // How much longer to make the mount on the side nearest the filament path.

// Collision switch variables
ylSwitchDimensions = [[25.5,5,15],[7.25,11.5,3.2,6.5,2.4]]; //[x,y,z],[hole x, hole z, hole d, nut dia, nut depth],[hole.....
keyesSwitchDimensions = [[26.5,10,22],[3.5,18.5,3.2,6.5,2.4],[3.5,3.5,3.2,6.5,2.4]];
genSwitchDimensions = [[10.5,7,21],[2.5,5.5,2.5,4,1.8],[2.5,15.5,2.5,4,1.8]];
cBotXAxisSwitchDimensions = (cBotXAxisSwitch == "yl99" ? ylSwitchDimensions :
			     (cBotXAxisSwitch == "keyes" ? keyesSwitchDimensions :
				  (cBotXAxisSwitch == "gen" ? genSwitchDimensions : [])));
// Display parts offset
partsOffset = [0,10,0];

// Generic Hot End Variables
heNozzleL = (hotend == "chimera_v6" ? chiV6NozzleL
	     : (hotend == "chimera_vol" ? chiVolNozzleL
		: (hotend == "cyclops" ? cycNozzleL
		   : (hotend == "e3d_v6" ? v6NozzleL
		      : (hotend == "e3d_v6_vol" ? v6VolNozzleL
			 : (hotend == "jhead_mkv" ? jheadMkVNozzleL
			    : (hotend == "hexagon" ? hexagonNozzleL
			       : (hotend == "gen_jhead" ? genericJHeadNozzleL
				  : [[0]])))))))); // This must be a vector of vectors. If only one nozzle, enter x,y,z in [[ ]]

// Variables for BLTouch
blPlateOuterRadius = 4; // Radius of outer circles of the mount.
blPlateInnerDiameter = 3.2; // Diameter of outer circles used to mount the BL Touch.
blPlateCenterDiameter = 4.5; // Diameter of inner circle for wires.
blPlateRectDimensions = [8,11.54]; // Width, Depth of rectangle at center of plate.
blPlateInnerDistance = 9; // Distance from center of BL Touch to center of outer mounting holes.
blMountWidth = (blPlateOuterRadius + blPlateInnerDistance) * 2; // Overall width to consider when placing the BL Touch mounting bracket.
blMountDistance = 10; // Extra distance from other components.
blPlateHeight = 45; // The target height from the tip of the of the nozzle for the mount.
bltouchBracketExtra = 2; // How much extra should be added to the carriage to provide clearance for the bltouch mount bracket.

// Nema 17 Stepper Dimension variables.
nema17CenterDiameter = 22.4; // Diameter of hole for center of Nema 17 Stepper. Spec is 22, but added a little buffer.
nema17MountHoleLocs = [[-15.5,15.5],[15.5,15.5],[-15.5,-15.5],[15.5,-15.5]]; // Offsets from center of shaft to mounting holes, top left, top right, bottom left, bottom right.
nema17MountHoleDiameter = 3; // Diameter of mounting hole.
nema17OuterOffset= 21.15; // Offset of outside edges from center of shaft. Only need single value due to Nema 17 being square and shaft in center.

// Prusa i3 variant carriage specific positioning variables.
prusai3FanBarWidth = prusai3FanTabWidth + (prusai3FanTabNubWidth * 2) + (fanTabNubClear * 2);
prusai3FanTabHeight = chiMountHeight;
prusai3FanScrewOffset = (((prusai3FanTabHole / 2) + prusai3FanTabMat) - prusai3FanTabHeight);
prusai3RealFanTabVerticalAngle = printFanSide == "left" ?
     - prusai3FanTabVerticalAngle :
     prusai3FanTabVerticalAngle;
prusai3ChiMountL = [((xMountWidth / 2) - (chiMountWidth / 2)),
		    - (xMountDepth + chiMountDepth),
		    chiHEPosUD + heHeightOffset]; // Position of Chimera Mount.
prusai3ChiAnchorL = [((xMountWidth / 2) - (chiWidth / 2)),
		    - (xMountDepth + heDepthOffset),
		    prusai3ChiMountL[2]]; // Position of Chimera Mount Anchor point.
prusai3JHeadMountL =  [((xMountWidth / 2) - (jHeadMountWidth / 2)),
		    - (xMountDepth + jHeadMountDepth + heDepthOffset),
		    jHeadHEPosUD + heHeightOffset]; // Position of J Head Mount.
prusai3JHeadAnchorL = [(xMountWidth / 2),
		    - (xMountDepth + (jHeadMountDepth / 2) + heDepthOffset),
		    prusai3JHeadMountL[2] + jHeadMountHeight]; // Position of J Head Anchor point..

prusai3HEMountL = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops")
     ? prusai3ChiMountL
     : (hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead")
     ? prusai3JHeadMountL
     : 0;
prusai3HEAnchorL = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops")
     ? prusai3ChiAnchorL
     : (hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead")
     ? prusai3JHeadAnchorL
     : 0;
prusai3ChiFanScrewL = [printFanSide == "left" ?
		       prusai3ChiMountL[0] + (sin(prusai3RealFanTabVerticalAngle) * ((prusai3FanTabHole / 2) + prusai3FanTabMat + prusai3FanTabDepth)) :
		       prusai3ChiMountL[0] + chiMountWidth + (sin(prusai3RealFanTabVerticalAngle) * ((prusai3FanTabHole / 2) + prusai3FanTabMat + prusai3FanTabDepth)),
		       prusai3ChiMountL[1] - (cos(prusai3RealFanTabVerticalAngle) * ((prusai3FanTabHole / 2) + prusai3FanTabMat + prusai3FanTabDepth)),
		       prusai3ChiMountL[2] + (prusai3FanTabHole / 2) + prusai3FanTabMat]; // Offset of the center of the fan mount screw from prusai3FanTabL
prusai3JHeadFanScrewL = [prusai3JHeadMountL[0] + (jHeadMountWidth / 2) + (sin(prusai3RealFanTabVerticalAngle) * ((prusai3FanTabHole / 2) + prusai3FanTabMat + prusai3FanTabDepth)),
		      prusai3JHeadMountL[1] - prusai3FanBracketDepth - (cos(prusai3RealFanTabVerticalAngle) * ((prusai3FanTabHole / 2) + prusai3FanTabMat + prusai3FanTabDepth)),
		      prusai3JHeadMountL[2] + (jHeadMountHeight / 2) + ((prusai3FanTabHeight / 2) + prusai3FanScrewOffset)]; // Offset of the center of the fan mount screw from prusai3FanTabL
prusai3FanScrewL = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops")
     ? prusai3ChiFanScrewL
     : (hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead")
     ? prusai3JHeadFanScrewL
     : 0;
prusai3DuctConnectL = fan_duct_connect(prusai3FanScrewL, prusai3FanTabHorizontalAngle, prusai3RealFanTabVerticalAngle, fanDimensions, fanCenterOffset, fanMountOffset, fanMountThickness, prusai3FanTabHole, prusai3FanTabMat, fanDuctConnectSize);

/* [C Bot Carriage Advanced] */

// Variables for C Bot Carriage.
cBotCarriageSideDistance = 20;
cBotTopHoleLength = 2;
cBotTopHoleAngle = 4.1;
cBotTopHoleDepth = 6;
cBotMountScrewDepth = cBotCarriageDepth - 2.5;
cBotBeltDepth = 3;
cBotBeltToothHeight = 1;
cBotBeltToothSpacing = 2;
cBotBeltToothLength = 10;
cBotBeltLength = 13;
cBotBeltHeight = 7;
cBotBeltBottomPos = 7; // Distance from center of carriage side.
cBotBeltTopPos = 6; // Distance from center of carriage side.
cBotBeltScrewDiameter = 3.2;
cBotBeltScrewDistance = 3;
cBotBeltScrewNutDiameter = 6.5;
cBotBeltScrewNutDepth = 2.4;
cBotBeltHolderHeight = 19;
cBotBeltHolderDepth = 3;
cBotBeltHolderNubDepth = 2;
cBotBeltHolderNubHeight = 6.2;
cBotBeltHolderCornerRadius = 1;
cBotCenterHoleDiameter = 25;
cBotCenterHoleWidth = 30;
cBotCarriageCornerRadius = (cBotCarriageIdlerScrewDiameter / 2) + cBotCarriageIdlerScrewMat;
cBotFanTabVerticalAngle = 0;
cBotFanTabHorizontalAngle = 0;
cBotRealFanTabVerticalAngle = printFanSide == "left" ?
     cBotFanTabVerticalAngle :
     - cBotFanTabVerticalAngle;
cBotFanMountDistance = 10;
cBotFanBracketWidth = 20;
cBotFanBracketHeight = 8;
cBotFanBracketDepth = 3;
cBotFanTabHeight = 8;
cBotFanTabWidth = 5;
cBotFanTabDepth = 4;
cBotFanTabAngle = 0;
cBotFanTabHole = 3.2;
cBotFanTabMat = 2;
cBotXBumperHeight = 10; // Total Height of bumper.
cBotXBumperWidth = 14; // How wide to make the bumper.
cBotXBumperDepth = 3; // How thick to make the bumper.
cBotXBumperHolePos = [10,5]; // Where the hole is in relation to the bottom of the bumper.

/* [Hidden] */
realZProbeSide = (realExtruder == "titan" ? "left" : zProbeSide);
inductMountWidth = inductDiameter + (probeBraceWidth * 2) + (inductMat * 2);
cBotProbePos = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops") ? chiCBotProbePos : jHeadCBotProbePos; // Used the correct location of the probe mount based on hotend type.
heMountWidth = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops")
     ? chiMountWidth
     : (hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead")
     ? jHeadMountWidth
     : 0;
cBotTempCarriageWidth = heMountWidth + (cBotCarriageIdlerScrewDiameter * 2) + (cBotCarriageIdlerScrewMat * 4) +
					     (servoInduct == "servo" ? servoHeight :
					    (servoInduct == "induct" ? inductMountWidth + inductBracketExtra:
					     (servoInduct == "bltouch" ? blMountWidth + bltouchBracketExtra:
					    0)));
cBotCarriageWidth = (cBotCarriageMinWidth > cBotTempCarriageWidth ? cBotCarriageMinWidth : cBotTempCarriageWidth);
cBotFanBarWidth = cBotFanTabWidth + (cBotFanTabWidth * 2) + (fanTabNubClear * 2);
cBotFanScrewL = [printFanSide == "left" ? cBotCarriageWidth - (fanDimensions[0] / 2) :
		 (fanDimensions[0] / 2),
		 cBotCarriageSideDistance + cBotCarriageDepth + cBotFanBracketDepth + cBotFanTabDepth + (cBotFanTabHole / 2) + cBotFanTabMat,
		 cBotFanMountPos];
cBotFanScrewOffset = 0;
cBotTempDuctConnectL = fan_duct_connect(cBotFanScrewL, cBotFanTabHorizontalAngle, cBotRealFanTabVerticalAngle, fanDimensions, fanCenterOffset, fanMountOffset, fanMountThickness, cBotFanTabHole, cBotFanTabMat, fanDuctConnectSize, true);
cBotDuctConnectL = [cBotTempDuctConnectL[1],cBotTempDuctConnectL[0]];
cBotChiMountL = [(realZProbeSide == "right" ? (cBotBeltLength + 2) :
		  (cBotCarriageWidth - (cBotBeltLength + chiMountWidth + 2))),
		 - (cBotCarriageDepth + chiMountDepth),
		 chiHEPosUD + heHeightOffset];
cBotChiAnchorL = [cBotChiMountL[0] + ((chiMountWidth - chiWidth) / 2),
		  - (cBotCarriageDepth + heDepthOffset),
		    cBotChiMountL[2]]; // Position of Chimera Mount.
cBotJHeadMountL = [(realZProbeSide == "right" ? (cBotBeltLength + 2) :
		  (cBotCarriageWidth - (cBotBeltLength + jHeadMountWidth + 2))),
		   - (cBotCarriageDepth + jHeadMountDepth + heDepthOffset),
		   jHeadHEPosUD + heHeightOffset];
cBotJHeadAnchorL = [cBotJHeadMountL[0] + (jHeadMountWidth / 2),
		    - (cBotCarriageDepth + (jHeadMountDepth / 2) + heDepthOffset),
		    cBotJHeadMountL[2] + jHeadMountHeight]; // Position of E3D V6 Mount.
cBotHEMountL = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops")
     ? cBotChiMountL
     : (hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead")
     ? cBotJHeadMountL
     : 0;
cBotHEAnchorL = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops")
     ? cBotChiAnchorL
     : (hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead")
     ? cBotJHeadAnchorL
     : 0;
cBotCableTieHorizontalDistance = (cBotCarriageWidth / (cBotCableTieHorizontalCount + 1));

// Generic variables that are hot end and carriage dependent.
heMountL = (carriage == "prusai3" ? prusai3HEMountL : (carriage == "cbot" ? cBotHEMountL : 0));
heAnchorL =  (carriage == "prusai3" ? prusai3HEAnchorL : (carriage == "cbot" ? cBotHEAnchorL : 0));
fanScrewL = (carriage == "prusai3" ? prusai3FanScrewL : (carriage == "cbot" ? cBotFanScrewL : 0));
tempDuctConnectL = (carriage == "prusai3" ? prusai3DuctConnectL : (carriage == "cbot" ? cBotDuctConnectL : 0));
ductConnectL = (printFanDirection == "left" ? tempDuctConnectL[0] : tempDuctConnectL[1]);
heMountWidth = (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops")
     ? chiMountWidth
     : (hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead")
     ? jHeadMountWidth
     : 0;

// Generic Z Probe variable logic
probeMountDistance = (servoInduct == "induct" ? inductMountDistance :
		      (servoInduct == "bltouch" ? blMountDistance :
		       0));
probeMountWidth =  (servoInduct == "induct" ? inductMountWidth :
		    (servoInduct == "bltouch" ? blMountWidth :
		     0));
probePlateHeight =  (servoInduct == "induct" ? (hotendOpt == "universal" ? - (heAnchorL[2] + heNozzleL[0][2]) :
						inductPlateHeight) :
		     (servoInduct == "bltouch" ? blPlateHeight :
		      0));
prusai3ProbeMountL = [ realZProbeSide == "right" ?
			heMountL[0] + heMountWidth + probeMountDistance:
			heMountL[0] - (probeMountWidth + probeMountDistance),
			-xMountDepth,
			heAnchorL[2] + heNozzleL[0][2] + probePlateHeight];
cBotProbeMountL = [ realZProbeSide == "right" ?
		     (cBotCarriageWidth / 2) + ((cBotFanMountDistance / 2) + (cBotFanMountDistance * floor((((cBotCarriageWidth - (cBotCarriageIdlerScrewDiameter * 2) - (cBotCarriageIdlerScrewMat * 4)) / cBotFanMountDistance) / 2) - cBotProbePos /* The number after the - sign before this comment indicates position from edge */))) - (probeMountWidth / 2) :
		     (cBotCarriageWidth / 2) - ((cBotFanMountDistance / 2) + (cBotFanMountDistance * floor((((cBotCarriageWidth - (cBotCarriageIdlerScrewDiameter * 2) - (cBotCarriageIdlerScrewMat * 4)) / cBotFanMountDistance) / 2) - cBotProbePos /* The number after the - sign before this comment indicates position from edge. */))) - (probeMountWidth / 2),
		     - cBotCarriageDepth,
		     heAnchorL[2] + heNozzleL[0][2] + probePlateHeight];
probeMountL = (carriage == "prusai3" ? prusai3ProbeMountL : (carriage == "cbot" ? cBotProbeMountL : 0));
carriageDepth = (carriage == "prusai3" ? xMountDepth : cBotCarriageDepth);
echo("probeMountL", probeMountL);
echo("probeMountWidth", probeMountWidth);

// Variables for Fan Duct
fanDuctOutletAngle = atan((fanDuctOutletNozzleOffsetL[1] + fanDuctOutletOffset + fanDuctOutletSize[1]) / fanDuctOutletNozzleOffsetL[0]);
simpleFanDuctOutletAngle = atan((simpleFanDuctOutletNozzleOffsetL[1] + fanDuctOutletOffset + simpleFanDuctOutletSize[1] + (fanDuctThickness * 2)) / simpleFanDuctOutletNozzleOffsetL[0]);
fanDuctConnectRadius = fanDuctConnectSize[2] / 2; // Radius of the bottom of the fan duct below housing.

// Variables for probe extension and servo bracket.
prusai3ServoBracketL = [ realZProbeSide == "right" ?
			 (xMountWidth + probeExtWidth - (servoBracketNutDiameter / 2) - servoBracketMat) :
			 (- probeExtWidth + (servoBracketNutDiameter / 2) + servoBracketMat),
			 -carriageDepth,
			 - (((servoMountPlateHeight + (servoBracketNutDiameter * 2) + (servoBracketMat * 4)) / 2) - (xMountHeight / 2))];
cBotServoBracketL = [realZProbeSide == "right" ?
		     (cBotCarriageWidth / 2) + ((cBotFanMountDistance / 2) + (cBotFanMountDistance * floor(((cBotCarriageWidth / cBotFanMountDistance) / 2) -3))) :
		     (cBotCarriageWidth / 2) - ((cBotFanMountDistance / 2) + (cBotFanMountDistance * floor(((cBotCarriageWidth / cBotFanMountDistance) / 2) -3))),
		     - cBotCarriageDepth - servoBracketBaseDepth,
		     - ((servoBracketMat * 2) + servoWidth + ((servoMountPlateHeight - servoHeight) / 2))];
servoBracketL = (carriage == "prusai3" ? prusai3ServoBracketL : cBotServoBracketL);
servoMountL = [-(servoBracketMat + (servoBracketScrewDiameter / 2)),
	       -((servoBracketMat * 2) + servoWidth + servoBracketBaseDepth + (carriage == "cbot" ? - servoBracketOffset : 0)),
	       (servoBracketMat * 2) + servoBracketNutDiameter];
prusai3ServoBracketBotScrewL = [0,0,(servoBracketMat + (servoBracketNutDiameter / 2))];
prusai3ServoBracketTopScrewL = [0,0,(servoBracketMat * 3) + (servoBracketNutDiameter * 1.5) + servoMountPlateHeight];
cBotServoBracketBotScrewL = [realZProbeSide == "right" ?
			     - cBotFanMountDistance :
			     cBotFanMountDistance,
			     servoBracketBaseDepth,
			     -servoBracketL[2] + cBotAccessoryMountPos];
cBotServoBracketTopScrewL = [cBotServoBracketBotScrewL[0],
			     cBotServoBracketBotScrewL[1],
			     cBotServoBracketBotScrewL[2] + cBotAccessoryMountPos];
servoBracketBotScrewL = (carriage == "prusai3" ? prusai3ServoBracketBotScrewL : cBotServoBracketBotScrewL);
servoBracketTopScrewL = (carriage == "prusai3" ? prusai3ServoBracketTopScrewL : cBotServoBracketTopScrewL);

/*cBotServoMountL =  [-(servoBracketMat + (servoBracketScrewDiameter / 2)),
		    -((servoBracketMat * 2) + servoWidth + servoBracketBaseDepth),
		    (servoBracketMat * 2) + servoBracketNutDiameter];
servoMountL = (carriage == "prusai3" ? prusai3ServoMountL : cBotServoMountL);
*/

// Variables for Z Probe
prusai3ZProbeTopL = [realZProbeSide == "right" ?
		     servoBracketL[0] + servoMountL[0] - zProbeArmOffset:
		     servoBracketL[0] - servoMountL[0] + zProbeArmOffset,
		     servoBracketL[1] + servoMountL[1] + servoBracketMat + (servoWidth / 2),
		     servoBracketL[2] + servoMountL[2] + ((servoMountPlateHeight - servoHeight) / 2) + servoCenterOffset];
cBotZProbeTopL = [realZProbeSide == "right" ?
		  servoBracketL[0] + servoMountL[0] - zProbeArmOffset:
		  servoBracketL[0] - servoMountL[0] + zProbeArmOffset,
		  servoBracketL[1] + servoMountL[1] + servoBracketMat + (servoWidth / 2),
		  servoBracketL[2] + servoMountL[2] + ((servoMountPlateHeight - servoHeight) / 2) + servoCenterOffset];
zProbeTopL = (carriage == "prusai3" ? prusai3ZProbeTopL : cBotZProbeTopL);
zProbeBottomL = -zProbeTopL[2] + (heAnchorL[2] + heNozzleL[0][2]) + (servoHatTopDiameter / 2) + zProbeArmMat + zProbeSwitchHeight - zProbeSwitchActivationDistance;

// Toggle that controls if fan is shown.
showFan = true;
showHE = true;

//////////// Prusa i3 Carriage //////////
if (carriage == "prusai3") {
     // X Carriage Mount     
     if(prusai3Which == "hotm" || prusai3Which == "all") {
	  // Spin up the Mount.
	  difference () {
	       union() {
		    // Create the backplane.
		    xback_plane();
		    
		    // Place the hot end mount, need to do here so holes are cut correctly.
		    // Chimera Mount
		    if(hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops") {
			 // Place the Chimera mount
			 translate(heMountL)
			      chimera_mount("below",
					    prusai3RealFanTabVerticalAngle, prusai3FanTabWidth, prusai3FanTabDepth,
					    prusai3FanTabHeight, prusai3FanTabHole, prusai3FanTabMat, printFanSide);
		    }

		    // J Head style mount
		    if(hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead") {
			 // Place the J Head style mount
			 translate(heMountL)
			      jhead_mount(carriageDepth);
		    }
		    
		    // Attach fan tab if needed.
		    if((printFanSide != "none") && (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops")) {
			 translate(fanScrewL)
			      rotate([0,0,prusai3RealFanTabVerticalAngle])
			      fan_tab(prusai3FanScrewOffset,prusai3FanTabWidth,
				      prusai3FanTabDepth,prusai3FanTabHeight,prusai3FanTabHole,prusai3FanTabMat);
		    }
		    
		    // Servo Extension
		    if(servoInduct == "servo") {
			 // Place the servo extension.
			 servo_ext(servoBracketL);
		    }
		    
		    // Inductive / Capacitive / BL Touch Extension
		    if(servoInduct == "induct" || servoInduct == "bltouch") {
			 // Place the Inductive / Capacitive Sensor extension.
			 probe_ext();
		    }
	       }
	       
	       // Cut out the holes needed to mount the back plane to the X Carriage.
	       xback_holes();
	       
	       // Cut out the wholes for the appropriate cold / hot end.
	       if(hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops") {
		    // Cut out the wholes needed to mount and use the Chimera.
		    translate(heMountL)
			 chimera_mount_holes();
	       }
	       
	       // Carve J Head style mount holes, if needed.
	       if(hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead") {
		    translate(heMountL)
			 jhead_holes(carriageDepth);
	       }
	       
	       // Servo Extension Holes
	       if(servoInduct == "servo") {
		    // Cut out the holes for the servo bracket.
		    servo_ext_holes(servoBracketL);
	       }
	  
	       // Inductive / Capacitive / BL Touch Extension
	       if(servoInduct == "induct" || servoInduct == "bltouch") {
		    // Place the Inductive / Capacitive sensor holes.
		    translate(probeMountL)
			 probe_ext_holes(carriageDepth);
	       }
	  }
     }

     // J Head style mount collar
     if((hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead") && (prusai3Which == "jhead_col" || prusai3Which == "all")) {
	  // Place the J Head collar.
	  translate(explodeParts == 1 ? (heMountL - partsOffset) : heMountL)
	       jhead_collar(carriageDepth);
     }
    
     // Display cold / hot end model.
     if((prusai3Which == "hotm" || prusai3Which == "all") && (hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops") && (showHE == true)) {
	  // Place the E3D Chimera fron Jons.
	  translate([((xMountWidth - chiWidth) / 2) + (chiWidth /2),
		     - (carriageDepth + heDepthOffset + 6), // 6 is there to offset the fan in the e3d model, used to line everything up properly
		     heMountL[2] - chiColdHeight])
	       %e3d();
     }

     // Display E3D V6 if needed.
     if((prusai3Which == "hotm" || prusai3Which == "all") && (hotend == "e3d_v6" || hotend == "e3d_v6_vol") && (showHE == true)) {
	  // Place the E3D V6.
	  translate([heMountL[0] + (jHeadMountWidth / 2),
		     heMountL[1] + (jHeadMountDepth / 2),
		     heMountL[2] + 16])
	       rotate([0,180,0])
	       %e3d();
     }

     // Display Hexagon if needed.
     if((prusai3Which == "hotm" || prusai3Which == "all") && (hotend == "hexagon") && (showHE == true)) {
	  // Place the E3D V6.
	  translate([heMountL[0] + (jHeadMountWidth / 2),
		     heMountL[1] + (jHeadMountDepth / 2),
		     heMountL[2] + hexagonNozzleL[0][2] + 12.7])
	       rotate([0,0,0])
	       %hexagon_hotend();
     }

     // Fan Bracket, if needed.
     if((prusai3Which == "fant" || prusai3Which == "all") && (hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead"))  {
	  // Place the fan tab.
	  translate(explodeParts == 1 ? (fanScrewL - (partsOffset * 2)) : fanScrewL)
	       bracket_fan_tab(jHeadMountWidth - (jHeadCollarCornerRadius * 2), prusai3FanBracketDepth, jHeadMountHeight, jHeadMountBoltDiameter,
			       (jHeadMountWidth / 2),
			       prusai3FanTabWidth, prusai3FanTabDepth, prusai3FanTabHeight,
			       prusai3FanTabHole, prusai3FanTabMat, prusai3FanScrewOffset);
     }
     
     // Fan Mount
     if((prusai3Which == "fanm" || prusai3Which == "all") && printFanSide != "none") {
	  // Spin up the Fan Mount.
	  translate(explodeParts == 1 ? (fanScrewL - (partsOffset * 3)) : fanScrewL)
	       rotate([prusai3FanTabHorizontalAngle,0,prusai3RealFanTabVerticalAngle])
	       fan_mount(prusai3FanTabHole, prusai3FanTabMat, prusai3FanTabWidth, fanTabNubClear, fanMountThickness, prusai3FanBarWidth, fanMountOffset, fanCenterOffset, fanMountScrewDiameter, fanMountScrewMat, fanMountScrews, fanIntakeDiameter, printFanDirection);
     }
     
     // Display fan if needed
     if(showFan == true && (prusai3Which == "all" || prusai3Which == "fanm")) {
	  if(printFanDirection == "left") {
	       // Place the fan for reference.
	       translate(explodeParts == 1 ? (fanScrewL - (partsOffset * 3)) : fanScrewL)
		    rotate([prusai3FanTabHorizontalAngle,0,prusai3RealFanTabVerticalAngle])
		    rotate([0,-90,0])
		    translate([fanMountOffset[2],
			       -((prusai3FanTabHole / 2) + prusai3FanTabMat + fanMountThickness + fanMountOffset[1] + fanDimensions[1]),
			       fanMountOffset[0]])
		    %blower_fan_51_15();
	  }
	  else {
	       translate(explodeParts == 1 ? (fanScrewL - (partsOffset * 3)) : fanScrewL)
		    rotate([-prusai3FanTabHorizontalAngle,0,180 + prusai3RealFanTabVerticalAngle])
		    rotate([0,-90,0])
		    translate([fanMountOffset[2],
			       ((prusai3FanTabHole / 2) + prusai3FanTabMat + fanMountThickness + fanMountOffset[1]),
			       fanMountOffset[0]])
		    %blower_fan_51_15();
	  }
     }

     // Display fan duct if needed
     if((prusai3Which == "all" || prusai3Which == "duct") && printFanSide != "none") {
	  // Place the fan duct.
	  translate(explodeParts == 1 ? (fanScrewL - (partsOffset * 3)) : fanScrewL)
	       rotate([prusai3FanTabHorizontalAngle,0,prusai3RealFanTabVerticalAngle])
	       translate(ductConnectL)
	       if (fanDuctStyle == "simple") {
		    difference() {
			 simple_fan_duct(ductConnectL, fanScrewL, heAnchorL, prusai3FanTabHorizontalAngle, prusai3RealFanTabVerticalAngle, printFanDirection, false);		    
			 simple_fan_duct_holes(ductConnectL, fanScrewL, heAnchorL, prusai3FanTabHorizontalAngle, prusai3RealFanTabVerticalAngle, printFanDirection, false);
		    }
	       } else {
		    difference() {
			 round_fan_duct(ductConnectL, fanScrewL, heAnchorL, prusai3FanTabHorizontalAngle, prusai3RealFanTabVerticalAngle, printFanDirection, false);
			 round_fan_duct_holes(ductConnectL, fanScrewL, heAnchorL, prusai3FanTabHorizontalAngle, prusai3RealFanTabVerticalAngle, printFanDirection, false);
		    }
	       }
     }

     // Servo Bracket
     if((prusai3Which == "servo" || prusai3Which == "all") && servoInduct == "servo") {
	  // Place the Servo Bracket.
	  translate(explodeParts == 1 ? (servoBracketL - partsOffset) : servoBracketL)
	       difference() {
	       servo_bracket();
	       
	       servo_bracket_holes();
	  }
     }
     
     // Z Probe Arm
     if((prusai3Which == "zarm" || prusai3Which == "all") && servoInduct == "servo" && servoInduct != "none") {
	  // Place the Z Probe Arm
	  translate(explodeParts == 1 ? (zProbeTopL - partsOffset) : zProbeTopL)
	       difference() {
	       z_probe_arm(zProbeBottomL);
	       
	       z_probe_arm_holes(zProbeBottomL);
	  }
     }

     // Inductive / Capacitive Extension
     if((prusai3Which == "induct" || prusai3Which == "all") && servoInduct == "induct") {
	  // Place the induct mount itself
	  translate(explodeParts == 1 ? (-partsOffset) : [])
	       difference() {
	       // Place the mount.
	       translate(probeMountL)
		    induct_mount(carriageDepth);
	       
	       // Carve out the wholes for the mount.
	       translate(probeMountL)
		    induct_mount_holes();
	  }
     }

     // BL Touch mount
     if((prusai3Which == "bltouch" || prusai3Which == "all") && servoInduct == "bltouch") {
	  // Place the induct mount itself
	  translate(explodeParts == 1 ? (-partsOffset) : [])
	       difference() {
	       // Place the mount.
	       translate(probeMountL)
		    bltouch_mount(carriageDepth);
	  }
     }

     // Place the titan direct extruder if needed.
     if (realExtruder == "titan" && (prusai3Which == "hotm" || prusai3Which == "all")) {
	  translate([heAnchorL[0], -carriageDepth, (xMountHeight + prusai3TitanVertOffset - .01)])
	       e3d_titan_mount();
     }
}

////////// C Bot //////////
if(carriage == "cbot") {
     // Carriage side with hot end mount.
     if(cBotWhich == "hotm" || cBotWhich == "all") {
	  difference() {
	       union() {
		    // Display C Bot Hot End Carriage Side.
		    cbot_carriage_side(true);

		    // Replace material behind the mount.
		    if(hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops") {
			 translate([(cBotCarriageWidth / 2) - (cBotCenterHoleWidth / 2),
				    heMountL[1] + chiMountDepth,
				    heMountL[2]])
			      cube([cBotCenterHoleWidth, carriageDepth, chiMountHeight]);
		    }

		    // Replace material behind the mount.
		    if(hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead") {
			 translate([(cBotCarriageWidth / 2) - (cBotCenterHoleWidth / 2),
				    heMountL[1] + jHeadMountDepth + heDepthOffset,
				    heMountL[2]])
			      cube([cBotCenterHoleWidth, carriageDepth, jHeadMountHeight]);
		    }
	       }

	       // Carve J Head style mount holes, if needed.
	       if(hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead") {
		    translate(heMountL)
			 jhead_holes(carriageDepth);
	       }
	  }
		    
	  // Place the Chimera / Cyclops hot end.
	  if(hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops") {
	       // Place the hot end mount.
	       translate(heMountL) {		    
		    // Place the mount and carve out the wholes.
		    difference() {
			 chimera_mount();
			 
			 chimera_mount_holes();
		    }
		    
		    // Display cold / hot end model.
		    if((hotend == "chimera_v6" || hotend == "chimera_vol" || hotend == "cyclops") && (showHE == true)) {
			 // Place the E3D Chimera fron Jons.
			 translate([(chiWidth / 2) + chiBraceThickness,
				    chiColdDepth - 2, // 6 is there to offset the fan in the e3d model, used to line everything up properly
				    -chiColdHeight])
			      %e3d();
		    }
	       }
	  }
	       
	  // J Head style mount
	  if(hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead") {
	       // Ensure the holes are made in the carriage.
	       difference() {
		    // Place the J Head style mount
		    translate(heMountL)
			 jhead_mount(carriageDepth);

		    cbot_carriage_holes(true);
	       }

	  }

	  // Display E3D V6 if needed.
	  if((hotend == "e3d_v6" || hotend == "e3d_v6_vol") && (showHE == true)){
	       // Place the E3D V6
	       translate([heMountL[0] + (jHeadMountWidth / 2),
			  heMountL[1] + (jHeadMountDepth / 2),
			  heMountL[2] + 16])
		    rotate([0,180,180])
		    %e3d();
	  }

	  // Display Hexagon if needed.
	  if((cBotWhich == "hotm" || cBotWhich == "all") && (hotend == "hexagon") && (showHE == true)) {
	       // Place the E3D V6.
	       translate([heMountL[0] + (jHeadMountWidth / 2),
			  heMountL[1] + (jHeadMountDepth / 2),
			  heMountL[2] + hexagonNozzleL[0][2] + 12.7])
		    rotate([0,0,0])
		    %hexagon_hotend();
	  }
     }
     

     // J Head style mount collar
     if((hotend == "e3d_v6" || hotend == "e3d_v6_vol" || hotend == "jhead_mkv" || hotend == "hexagon" || hotend == "gen_jhead") && (cBotWhich == "jhead_col" || cBotWhich == "all")) {
	  translate(explodeParts == 1 ? (heMountL - partsOffset) : heMountL)
	       jhead_collar(carriageDepth);
     }

     // Opposite side carriage plate.
     if(cBotWhich == "carrside" || cBotWhich == "all") {
	  // Non hot end carriage side.
	  translate([cBotCarriageWidth, cBotCarriageSideDistance, 0])
	       rotate([0, 0, 180])
	       cbot_carriage_side(false);
     }
     
     // Fan Mount Bracket
     if(cBotWhich == "fant" || cBotWhich == "all") {
	  // Place the fan tab.
	  translate(explodeParts == 1 ? (fanScrewL + partsOffset) : fanScrewL)
	       rotate([0, 0, 180])
	       bracket_fan_tab(cBotFanBracketWidth, cBotFanBracketDepth, cBotFanBracketHeight, cBotBeltScrewDiameter,
			       cBotFanMountDistance,
			       cBotFanTabWidth, cBotFanTabDepth, cBotFanTabHeight,
			       cBotFanTabHole, cBotFanTabMat, cBotFanScrewOffset);
     }
     
     // Fan Mount
     if(cBotWhich == "fanm" || cBotWhich == "all") {
	  translate(explodeParts == 1 ? (fanScrewL + (partsOffset * 2)) : fanScrewL)
	       rotate([0, 0, 180])
	       fan_mount(cBotFanTabHole, cBotFanTabMat, cBotFanTabWidth, fanTabNubClear, fanMountThickness, cBotFanBarWidth, fanMountOffset, fanCenterOffset, fanMountScrewDiameter, fanMountScrewMat, fanMountScrews, fanIntakeDiameter, printFanDirection);
     }
     
     // Display fan if needed
     if(showFan == true && (cBotWhich == "all" || cBotWhich == "fanm")) {
	  if(printFanDirection == "left") {
	       // Place the fan for reference..
	       rotate([0,-90,180 + cBotRealFanTabVerticalAngle])
		    translate([explodeParts == 1 ? (fanScrewL[2] + (partsOffset[2] * 2)) : fanScrewL[2],
			       explodeParts == 1 ? -(fanScrewL[1] + (partsOffset[1] * 2)) : -fanScrewL[1],
			       explodeParts == 1 ? (fanScrewL[0] + (partsOffset[0] * 2)) : fanScrewL[0]])
		    rotate([0,0,cBotFanTabHorizontalAngle])
		    translate([fanMountOffset[2],
			       -((cBotFanTabHole / 2) + cBotFanTabMat + fanMountThickness + fanMountOffset[1] + fanDimensions[1]),
			       fanMountOffset[0]])
		    %blower_fan_51_15();
	  }
	  else {
	       rotate([0,-90,cBotRealFanTabVerticalAngle])
		    translate([explodeParts == 1 ? (fanScrewL[2] + (partsOffset[2] * 2)) : fanScrewL[2],
			       explodeParts == 1 ? (fanScrewL[1] + (partsOffset[1] * 2)) : fanScrewL[1],
			       explodeParts == 1 ? -(fanScrewL[0] + (partsOffset[0] * 2)) : -fanScrewL[0]])
		    rotate([0,0,-cBotFanTabHorizontalAngle])
		    translate([fanMountOffset[2],
			       ((cBotFanTabHole / 2) + cBotFanTabMat + fanMountThickness + fanMountOffset[1]),
			       fanMountOffset[0]])
		    %blower_fan_51_15();
	  }
     }
     
     // Display fan duct if needed
     if((cBotWhich == "all" || cBotWhich == "duct") && printFanSide != "none") {
	  // Place the fan duct.
	  translate(explodeParts == 1 ? (fanScrewL + (partsOffset * 2)) : fanScrewL)
	       rotate([cBotFanTabHorizontalAngle,0,cBotFanTabVerticalAngle])
	       translate(ductConnectL)
	       if (fanDuctStyle == "simple") {
		    difference() {
			 simple_fan_duct(ductConnectL, fanScrewL, heAnchorL, cBotFanTabHorizontalAngle, cBotRealFanTabVerticalAngle, printFanDirection, true);
			 simple_fan_duct_holes(ductConnectL, fanScrewL, heAnchorL, cBotFanTabHorizontalAngle, cBotRealFanTabVerticalAngle, printFanDirection, true);
		    }
	       } else {
		    difference() {
			 round_fan_duct(ductConnectL, fanScrewL, heAnchorL, cBotFanTabHorizontalAngle, cBotRealFanTabVerticalAngle, printFanDirection, true);
			 round_fan_duct_holes(ductConnectL, fanScrewL, heAnchorL, cBotFanTabHorizontalAngle, cBotRealFanTabVerticalAngle, printFanDirection, true);
		    }
	       }
     }

     // Inductive / Capacitive Extension
     if((cBotWhich == "induct" || cBotWhich == "all") && servoInduct == "induct") {
	  // Place the induct mount itself
	  difference() {
	       // Place the mount.
	       translate(probeMountBracketed == 1 ?
			 (explodeParts == 1 ? (probeMountL - partsOffset) :
			  probeMountL) :
			 probeMountL)
		    induct_mount(carriageDepth,true);
	       
	       // Carve out the wholes for the mount.
	       translate(probeMountBracketed == 1 ?
			 (explodeParts == 1 ? (probeMountL - partsOffset) :
			  probeMountL) :
			 probeMountL)
		    induct_mount_holes(true);
	  }
     }

     // BL Touch mount
     if((cBotWhich == "bltouch" || cBotWhich == "all") && servoInduct == "bltouch") {
	  // Place the bltouch mount itself
	  difference() {
	       // Place the mount.
	       translate(probeMountBracketed == 1 ?
			 (explodeParts == 1 ? (probeMountL - partsOffset) :
			  probeMountL) :
			 probeMountL)
		    bltouch_mount(carriageDepth,true);
	  }
     }

     // Servo Bracket
     if((cBotWhich == "servo" || cBotWhich == "all") && servoInduct == "servo") {
	  // Place the Servo Bracket.
	  translate(explodeParts == 1 ? (servoBracketL - partsOffset) : servoBracketL)
	       difference() {
	       servo_bracket(true);

	       servo_bracket_holes(true);
	  }
     }

     // Z Probe Arm
     if((cBotWhich == "zarm" || cBotWhich == "all") && servoInduct == "servo" && servoInduct != "none") {
	  // Place the Z Probe Arm
	  translate(explodeParts == 1 ? (zProbeTopL - partsOffset) : zProbeTopL)
	       rotate([-90,0,0])
	       difference() {
	       z_probe_arm(zProbeBottomL);
	       
	       z_probe_arm_holes(zProbeBottomL);
	  }
     }

     // Belt holders.
     if(cBotWhich == "belth" || cBotWhich == "all") {
	  translate([-15,0,0])
	       cbot_belt_holder();
     }

     // X Axis Switch Bumper
     if(cBotWhich == "xbump" || cBotWhich == "all") {
	  translate([-25, 0, 30])
	       cbot_x_bumper();
     }

     // Place the titan direct extruder if needed.
     if (realExtruder == "titan" && (cBotWhich == "hotm" || cBotWhich == "all")) {
	  translate([heAnchorL[0], -carriageDepth, (cBotCarriageHeight + cBotTitanVertOffset - .01)])
	       e3d_titan_mount();
     }
}

//////// Component Modules /////////

// Prusa i3 X Carriage back plane for the mount.
module xback_plane(xw=xMountWidth,
		   xh=xMountHeight,
		   xd=carriageDepth,
		   xc=xMountCornerRadius) {
     // Round out the corners, smoothly
     $fn=100;

     // Create the base X Carriage Back Plane
     hull() {
	  // Create the round edges on left edge. Will take care of round corners on right side later.
	  // Bottom Left, enlarge the mount to accomodate titan extruder if needed.
	  translate([xMountCornerRadius - (realExtruder == "titan" ? ((nema17OuterOffset + e3dTitanOffset[0] + e3dTitanMountMat) - (xMountWidth / 2)) : 0), 0,xMountCornerRadius])
	       rotate([90,0,0])
	       cylinder(r=xMountCornerRadius,h=carriageDepth);
	  // Top Left
	  translate([xMountCornerRadius - (realExtruder == "titan" ? ((nema17OuterOffset + e3dTitanOffset[0] + e3dTitanMountMat) - (xMountWidth / 2)) : 0),0,xMountHeight-xMountCornerRadius])
	       if(realExtruder == "titan") {
		    translate([-xMountCornerRadius,-carriageDepth,0])
		    cube([xMountCornerRadius, carriageDepth, xMountCornerRadius]);
	       }
	       else {
		    rotate([90,0,0])
			 cylinder(r=xMountCornerRadius,h=carriageDepth);
	       }
	  // Bottom Right
	  translate([xMountWidth - xMountCornerRadius,0,xMountCornerRadius])
	       rotate([90,0,0])
	       cylinder(r=xMountCornerRadius,h=carriageDepth);
	  // Top Right
	  translate([xMountWidth - xMountCornerRadius,0,xMountHeight-xMountCornerRadius])
	       rotate([90,0,0])
	       cylinder(r=xMountCornerRadius,h=carriageDepth);
	  translate([xMountCornerRadius,-carriageDepth,0])
	       cube([xMountWidth - (xMountCornerRadius * 2),carriageDepth,xMountHeight]);
     }
}

module xback_holes() {
     lrVec = [(xMountWidth / 2) - (xMountHoleWidth / 2),
	      xMountWidth - ((xMountWidth / 2) - (xMountHoleWidth / 2))];
     udVec = [(xMountHeight / 2) - (xMountHoleHeight / 2),
	      xMountHeight - ((xMountHeight / 2) - (xMountHoleHeight / 2))];

     // Insert the X Carriage bolt holes and nut traps.
     for(lr = lrVec) {
	  for(ud = udVec) {
	       translate([lr,0,ud])
		    rotate([90,90,0])
		    bolt_hole(xMountBoltDiameter,
			      xMountBoltDepth,
			      xMountNutDiameter,
			      carriageDepth);
	  }
     }
}

// Create module for the bolt hole and nut trap.
module bolt_hole(bdia=xMountBoltDiameter,
		 bdep=xMountBoltDepth,
		 ndia=xMountNutDiameter,
		 ndep=xMountNutDepth) {
     union() {
	  // Note we shift the cylinders in the z axis by .1 and make then .2 bigger to avoid coincident faces.
	  // Screw hole
	  translate([0,0,-.2])
	       cylinder(d=bdia,h=bdep + (boltHoleSupportFix == 1 ? 0 : .3),$fn=100);
	  // Nut Trap
	  translate([0,0,bdep])
	       cylinder(d=ndia,h=ndep + .1,$fn=6);
     }
}

// Chimera Cold End Mount
module chimera_mount(bracePos="below", fanTabAngle, fanTabWidth, fanTabDepth, fanTabHeight, fanTabHole, fanTabHoleMat, fanSide) {
     // Create the mount top plate and braces for the Chimera mount plate.
     union() {
	  // Create the top plate to hang the Chimera from.
	  hull() {
	       cube([chiMountWidth, chiMountDepth + .1, chiMountHeight]);

	       // Attach fan tab if needed.
	       if(carriage == "prusai3" && printFanSide != "none") {
		    translate([fanSide == "left" ? 0 : chiMountWidth, 0, 0])
			 rotate([0, 0, fanTabAngle])
			 translate([- (fanTabWidth / 2), - fanTabDepth, 0])
			 cube([fanTabWidth, fanTabDepth, fanTabHeight]);
		    
	       }
	  }	       
	  // Left Brace
	  hull() {
	       // Horizontal
	       translate([0,
			  (chiMountDepth - chiBraceLength),
			  bracePos == "below" ? 0 : chiMountHeight - .1])
		    cube([chiBraceThickness, chiBraceLength + .1, .1]);

	       // Vertical
	       translate([0,
			  chiMountDepth,
			  bracePos == "below" ? -chiBraceHeight : chiMountHeight - .1])
		    cube([chiBraceThickness, .1, chiBraceHeight + .1]);
	  }
	  // Right Brace
	  hull() {
	       // Horizontal
	       translate([chiMountWidth - chiBraceThickness,
			  (chiMountDepth - chiBraceLength),
			  bracePos == "below" ? 0 : chiMountHeight - .1])
		    cube([chiBraceThickness, chiBraceLength + .1, .1]);

	       // Vertical
	       translate([chiMountWidth - chiBraceThickness,
			  chiMountDepth,
			  bracePos == "below" ? -chiBraceHeight : chiMountHeight - .1])
		    cube([chiBraceThickness, .1, chiBraceHeight + .1]);
	  }	  
     }
}

// Holes for Chimera Cold End Mount and Bowden tubes.
module chimera_mount_holes() {
     // Create the holes, which will be remove from the top plate. Could place screw holes in back plane too,
     // but only useful if mount is rotated 90 degrees in Z. This might be tested as it has advantages for fan placement.
     for(i = chiScrewLocs) {
	  // Create the screw hole and move it to the correct location.
	  translate([i[0], i[1], -.1])
	       cylinder(r=(chiScrewHole /2),h=chiScrewHoleHeight, $fn=100);

	  // Create an space for the screw head, used to clear space from the fan tab.
	  translate([i[0], i[1], chiMountHeight])
	       cylinder(r=3, h=5, 0, $fn=100);
     }
     
     for(i = chiBowdenLocs) {
	  // Create the screw hole and move it to the correct location.
	  translate([i[0], i[1], -.1])
	       cylinder(r=(chiBowdenHole /2),h=chiBowdenHoleHeight, $fn=100);
     }
}

// J Head style mount
module jhead_mount(carriageDepth) {
     difference() {
	  // Create the base block which the holes will be carved out of.
	  jhead_base();

	  jhead_holes(carriageDepth);
     }
}


module jhead_base() {
     // Create the base block which the holes will be carved out of.
     translate([0, (jHeadMountDepth / 2), 0])
	  cube([jHeadMountWidth, (jHeadMountDepth / 2) + heDepthOffset + .1, jHeadMountHeight]);

     // Create some supports if needed.
     if (realExtruder == "titan") {
	  // Left Brace
	  hull() {
	       // Horizontal portion
	       translate([0, (jHeadMountDepth / 2), jHeadMountHeight - e3dTitanMountBraceWidth])
		    cube([e3dTitanMountBraceWidth, (jHeadMountDepth / 2) + .1, e3dTitanMountBraceWidth]);

	       //Vertical portion
	       translate([0, jHeadMountDepth, jHeadMountHeight - .1])
		    cube([e3dTitanMountBraceWidth, carriageDepth, e3dTitanMountLowerOverlap]);
	  }

	  // Right Brace
	  hull() {
	       // Horizontal portion
	       translate([jHeadMountWidth - e3dTitanMountBraceWidth, (jHeadMountDepth / 2), jHeadMountHeight - e3dTitanMountBraceWidth])
		    cube([e3dTitanMountBraceWidth, (jHeadMountDepth / 2) + .1, e3dTitanMountBraceWidth]);

	       //Vertical portion
	       translate([jHeadMountWidth - e3dTitanMountBraceWidth, jHeadMountDepth, jHeadMountHeight - .1])
		    cube([e3dTitanMountBraceWidth, carriageDepth, e3dTitanMountLowerOverlap]);
	  }
     }
}

module jhead_collar(carriageDepth) {
     difference() {
	  hull() {
	       // Create the base collar which the holes will be carved out of.
	       translate([jHeadCollarCornerRadius, jHeadCollarCornerRadius, 0])
		    cylinder(r=jHeadCollarCornerRadius, h=jHeadMountHeight, $fn=100);

	       translate([jHeadMountWidth - jHeadCollarCornerRadius, jHeadCollarCornerRadius, 0])
		    cylinder(r=jHeadCollarCornerRadius, h=jHeadMountHeight, $fn=100);
	       
	       translate([0,(jHeadMountDepth / 4),0])
		    cube([jHeadMountWidth, (jHeadMountDepth / 4), jHeadMountHeight]);
	  }
	  
	  // Carve out the holes.
	  jhead_holes(carriageDepth);
     }
}
	  
module jhead_holes(carriageDepth) {
     // Carve out the holes for the mount.
     // Upper collar hole
     translate([(jHeadMountWidth / 2), (jHeadMountDepth / 2), jHeadMountHeight - jHeadUpperCollarHeight])
	  cylinder(d=jHeadUpperCollarDiameter, h=jHeadUpperCollarHeight + .1, $fn=100);

     // Inner collar hole.
     translate([(jHeadMountWidth / 2), (jHeadMountDepth / 2), jHeadMountHeight - jHeadUpperCollarHeight - jHeadInnerCollarHeight - .1])
	  cylinder(d=jHeadInnerCollarDiameter, h=jHeadInnerCollarHeight + .2, $fn=100);

     // Lower collar hole.
     translate([(jHeadMountWidth / 2),
		(jHeadMountDepth / 2),
		jHeadMountHeight - jHeadUpperCollarHeight - jHeadInnerCollarHeight - jHeadLowerCollarHeight - .1])
	  cylinder(d=jHeadLowerCollarDiameter, h=jHeadLowerCollarHeight + .1, $fn=100);
     

     // Left Mounting Screw
     translate([jHeadMountScrewHorizontalOffset,
		-.1,
		jHeadMountScrewVerticalOffset])
	  rotate([-90,0,0])
	  bolt_hole(jHeadMountBoltDiameter, jHeadMountDepth + heDepthOffset + carriageDepth - jHeadMountNutDepth, jHeadMountNutDiameter, jHeadMountNutDepth + .1);

     // Right Mount Screw
     translate([jHeadMountWidth - jHeadMountScrewHorizontalOffset,
		-.1,
		jHeadMountScrewVerticalOffset])
	  rotate([-90,0,0])
	  bolt_hole(jHeadMountBoltDiameter, jHeadMountDepth + heDepthOffset + carriageDepth - jHeadMountNutDepth, jHeadMountNutDiameter, jHeadMountNutDepth + .1);
		
}

// Fan tab items.
module bracket_fan_tab(bracketWidth, bracketDepth, bracketHeight, bracketScrewDiameter, screwDistance,
		       tabWidth, tabDepth, tabHeight, tabHole, tabHoleMat, screwOffset) {
     difference() {
	  union() {
	       // Create the bracket.
	       translate([-(bracketWidth / 2), (tabHole / 2) + tabHoleMat + tabDepth, - (bracketHeight / 2) + screwOffset])
	       cube([bracketWidth, bracketDepth, bracketHeight]);
	       
	       // Add the fan tab.
	       fan_tab(screwOffset, tabWidth, tabDepth + .1, tabHeight, tabHole, tabHoleMat);
	  }

	  // Carve out the holes for the fan tab.
	  fan_tab_holes(tabWidth, tabDepth, tabHeight, tabHole, tabHoleMat);

	  // Carve hole the mount holes.
	  translate([- (screwDistance / 2), (tabHole / 2) + tabHoleMat + tabDepth + bracketDepth + .1, screwOffset])
	       rotate([90,0,0])
	       cylinder(d=bracketScrewDiameter, h=bracketDepth + .2, $fn=100);

	  translate([(screwDistance / 2), (tabHole / 2) + tabHoleMat + tabDepth + bracketDepth + .1, screwOffset])
	       rotate([90,0,0])
	       cylinder(d=bracketScrewDiameter, h=bracketDepth + .2, $fn=100);
     }
}

module fan_tab(screwOffset, tabWidth, tabDepth, tabHeight, tabHole, tabHoleMat) {
     difference() {
	  fan_tab_base(screwOffset, tabWidth, tabDepth, tabHeight, tabHole, tabHoleMat);

	  fan_tab_holes(tabWidth, tabDepth, tabHeight, tabHole, tabHoleMat);
     }
}

module fan_tab_base(screwOffset, tabWidth, tabDepth, tabHeight, tabHole, tabHoleMat) {
     hull() {
	  // Recreate the tab so we can hull to it without hull the whole front and side of Hot End Mount
	  translate([-(tabWidth / 2), (tabHole / 2) + tabHoleMat, - (tabHeight / 2) + screwOffset])
	       cube([tabWidth, tabDepth +.1, tabHeight]);
	  
	  // Create the cylinder for the fan mount screw.
	  rotate([0,90,0])
	       translate([0, 0, -(tabWidth / 2)])
	       cylinder(r=(tabHole / 2) + tabHoleMat, h=tabWidth, $fn=100);
     }
}

module fan_tab_holes(tabWidth, tabDepth, tabHeight, tabHole, tabHoleMat) {
     // Create the cylinder for the fan mount screw.
     rotate([0,90,0])
	  translate([0, 0, -((tabWidth / 2) + .1)])
	  cylinder(d=tabHole, h=tabWidth + .2, $fn=100);
     
     // Carve out the sides of the screw nub.
     rotate([0,90,0])
	  translate([0, 0, - ((tabWidth / 2) + 10)])
	  cylinder(d=tabHole + (tabHoleMat * 2), h=10, $fn=100);
     
     rotate([0,90,0])
	  translate([0, 0, (tabWidth / 2)])
	  cylinder(d=tabHole + (tabHoleMat * 2), h=10, $fn=100);
}

// Servo probe extension
module servo_ext(servoBracketL) {
     // Create the extension for the z Probe Servo.
     hull() {
	  // Bottom outside corner
	  translate([ realZProbeSide == "right" ?
		      servoBracketL[0] - xMountCornerRadius :
		      servoBracketL[0] + xMountCornerRadius,
		      0,xMountCornerRadius])
	       rotate([90,0,0])
	       cylinder(r=xMountCornerRadius, h=carriageDepth, $fn=100);

	  // Top outside corner
	  translate([ realZProbeSide == "right" ?
		      servoBracketL[0] - xMountCornerRadius :
		      servoBracketL[0] + xMountCornerRadius,
		      0,xMountHeight-xMountCornerRadius])
	       rotate([90,0,0])
	       cylinder(r=xMountCornerRadius, h=carriageDepth, $fn=100);
	  
	  translate([ realZProbeSide == "right" ?
		      xMountWidth - probeExtWidth - .1 :
		      -probeExtWidth - .1,
		      -carriageDepth, 0])
	       cube([probeExtWidth + xMountCornerRadius + .1, carriageDepth, xMountHeight]);
     }
     
     // Create the servo bracket tabs.
     hull () {
	  // Bottom
	  translate([servoBracketL[0],
		     servoBracketL[1] + carriageDepth,
		     servoBracketL[2] + servoBracketBotScrewL[2]])
	       rotate([90,0,0])
	       cylinder(r=(servoBracketNutDiameter / 2) + servoBracketMat, h=carriageDepth, $fn=100);

	  // Top
	  translate([servoBracketL[0],
		     servoBracketL[1] + carriageDepth,
		     servoBracketL[2] + servoBracketTopScrewL[2]])
	       rotate([90,0,0])
	       cylinder(r=(servoBracketNutDiameter / 2) + servoBracketMat, h=carriageDepth, $fn=100);
     }
}

module servo_ext_holes(servoBracketL) {
     // Create the holes needed for the z probe extension.
     // Bottom
     translate(servoBracketL + servoBracketBotScrewL)
	  rotate([-90,0,0])
	  bolt_hole(servoBracketScrewDiameter, carriageDepth - servoBracketNutDepth, servoBracketNutDiameter, servoBracketNutDepth);

     // Top
     translate(servoBracketL + servoBracketTopScrewL)
	  rotate([-90,0,0])
	  bolt_hole(servoBracketScrewDiameter, carriageDepth - servoBracketNutDepth, servoBracketNutDiameter, servoBracketNutDepth);
}

// Fan Mount for Blower / Centrifugal Fan
module fan_mount(tabHole, tabHoleMat, tabWidth, tabClear, thickness, barWidth, mountOffset, centerOffset, fanScrewDiameter, fanScrewMat, fanScrews, intakeDiameter, fanDirection) {
     difference() {
	  union() {
	       // Create mount nub and connection to fan mount.
	       fan_mount_nub(tabHole, tabHoleMat, thickness, barWidth);
	       
	       // Spin up the base..
	       if(fanDirection == "right") {
		    fan_mount_base(tabHole, tabHoleMat, thickness, barWidth, mountOffset, fanScrewDiameter, fanScrewMat, fanScrews);
	       }
	       else {
		    translate([0,- (tabHole + (tabHoleMat * 2) + thickness),0])
			 rotate([0,0,180])
			 fan_mount_base(tabHole, tabHoleMat, thickness, barWidth, mountOffset, fanScrewDiameter, fanScrewMat, fanScrews);
	       }
	  }
	  // Remove the center of the nub.
	  fan_mount_nub_holes(tabHole, tabHoleMat, tabWidth, tabClear, barWidth);
	  
	  // Remove the holes and gaps.
	  if(fanDirection == "right") {
	       fan_mount_holes(tabHole, tabHoleMat, thickness, mountOffset, centerOffset, fanScrewDiameter, fanScrewMat, fanScrews, intakeDiameter);
	  }
	  else {
	       translate([0,- (tabHole + (tabHoleMat * 2) + thickness),0])
		    rotate([0,0,180])
		    fan_mount_holes(tabHole, tabHoleMat, thickness, mountOffset, centerOffset, fanScrewDiameter, fanScrewMat, fanScrews, intakeDiameter);
	  }
     }
}

module fan_mount_nub(tabHole, tabHoleMat, thickness, barWidth) {
     // Create the cylinder and cube that we hull with so have something to have the mount off of.
     hull() {
	  // Create the nub cylinder.
	  rotate([0,90,0])
	       cylinder(r=(tabHole / 2) + tabHoleMat, h=barWidth, center=true, $fn=100);
	  
	  // This is what we will hull to, to merge the nubs to the rest of the fan mount.
	  translate([0,
		     -((tabHole / 2) + tabHoleMat + (thickness / 2)),
		     0])
	       cube([barWidth,thickness,tabHole + (tabHoleMat * 2)], center=true);
     }
}
    
module fan_mount_base(tabHole, tabHoleMat, thickness, barWidth, mountOffset, fanScrewDiameter, fanScrewMat, fanScrews) {
     hull() {
	  translate([0,
		     -((tabHole / 2) + tabHoleMat + (thickness / 2)),
		     0])
	       cube([barWidth,thickness,tabHole + (tabHoleMat * 2)], center=true);

	  // Create the fan mount.
	  for(fs = fanScrews) {
	       fan_screw_hole_single(tabHole,
				     tabHoleMat,
				     fanScrewDiameter + fanScrewMat,
				     thickness,
				     thickness,
				     fs[0] + .1 + mountOffset[0],
				     mountOffset[1],
				     fs[1] + mountOffset[2]);
	  }
     }
}

module fan_mount_nub_holes(tabHole, tabHoleMat, tabWidth, tabClear, barWidth) {
     // Remove the fan tab to create the separate nubs.
     rotate([0,90,0])
	  cylinder(r=(tabHole / 2) + tabHoleMat + tabClear, h=tabWidth + (tabClear * 2), center=true, $fn=100);

     // Carve out the screw / bolt hole.
     rotate([0,90,0])
	  cylinder(d=tabHole, h=(barWidth + .2), center=true, $fn=100);
}

module fan_mount_holes(tabHole, tabHoleMat, thickness, mountOffset, centerOffset, fanScrewDiameter, fanScrewMat, fanScrews, intakeDiameter) {
     // Carve out the fan mounting holes
     for(fs = fanScrews) {
	  fan_screw_hole_single(tabHole,
				tabHoleMat,
				fanScrewDiameter,
				thickness,
				thickness + .2,
				fs[0] + .1 + mountOffset[0],
				mountOffset[1],
				fs[1] + mountOffset[2]);
     }
     
     // Cut out opening for air intake. Leave legs for securing mount to fan tab.
     translate([centerOffset[0] + mountOffset[0],
		-((tabHole / 2) + tabHoleMat) + centerOffset[1] + mountOffset[1] +.1,
		centerOffset[2] + mountOffset[2]])
	  difference() {
	  rotate([90,0,0])
	       rotate_extrude($fn=200) {
	       translate([9,0,0])
		    difference() {
		    square([(intakeDiameter / 2), thickness + .2]);
		    
		    translate([-2,2,0])
			 circle(r=3);
		    
		    translate([(intakeDiameter / 2) + 2,2,0])
			 circle(r=3);
	       }
	  }

	  // Need to move the legs back, otherwise they end up twice as far as they should be
	  // fan_screw_hole_single moves them as well as the translate above.
	  translate([0, (tabHole / 2) + tabHoleMat, 0]) {
	       for(fs = fanScrews) {
		    hull() {
			 fan_screw_hole_single(tabHole,
					       tabHoleMat,
					       fanScrewDiameter + fanScrewMat,
					       thickness,
					       thickness + .2,
					       0,
					       -.1,
					       0);
			 fan_screw_hole_single(tabHole,
					       tabHoleMat,
					       fanScrewDiameter + fanScrewMat,
					       thickness,
					       thickness + .2,
					       fs[0] + mountOffset[0],
					       mountOffset[1],
					       fs[1] + mountOffset[2]);
		    }
	       }
	  }
     }
}

module fan_screw_hole_single(tabHole, tabHoleMat, diameter, thickness, height, x, y, z) {
     rotate([90,0,0])
	  translate([x,
		     z,
		     (tabHole / 2) + tabHoleMat + (thickness / 2) + y])
	  cylinder(d=diameter,h=height,$fn=100,center=true);
}

// Simple Fan Duct
module simple_fan_duct(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDirection, reverseY=false) {
     // Simple fan duct to get something working for now.
     // Create the connection to the fan.
     translate([-fanDuctThickness, -fanDuctThickness, 0])
	  difference() {
	  cube([fanDuctConnectSize[0] + (fanDuctThickness * 2),
		fanDuctConnectSize[1] + (fanDuctThickness * 2),
		fanDuctOutsideOverlap]);

	  hull() {
	       translate([-.1,
			  -.1,
			  ((fanDirection == "left" && reverseY == true) || (fanDirection == "right" && reverseY == false)) ? fanDuctOverlap
			      : fanDuctOutsideOverlap])
		    cube([.1, fanDuctConnectSize[1] + (fanDuctThickness * 2) + .2,
			  ((fanDirection == "left" && reverseY == true) || (fanDirection == "right" && reverseY == false)) ? fanDuctOutsideOverlap
			  : fanDuctOverlap]);
	       
	       translate([(fanDuctConnectSize[0] + (fanDuctThickness * 2)),
			  -.1,
			  ((fanDirection == "left" && reverseY == true) || (fanDirection == "right" && reverseY == false)) ? fanDuctOutsideOverlap
			  : fanDuctOverlap])
		    cube([.1, fanDuctConnectSize[1] + (fanDuctThickness * 2) + .2,
			  ((fanDirection == "left" && reverseY == true) || (fanDirection == "right" && reverseY == false)) ? fanDuctOverlap
			  : fanDuctOutsideOverlap]);
	  }
     }
     
     hull() {
	  // Recreate the body of the fan shroud so we can hull to it.
	  translate([-fanDuctThickness, -fanDuctThickness, 0])
	       cube([fanDuctConnectSize[0] + (fanDuctThickness * 2),
		     fanDuctConnectSize[1] + (fanDuctThickness * 2),
		     .1]);

	  // Round out the bottom a bit
	  translate([-fanDuctThickness,
		     fanDuctConnectRadius,
		     - (fanDuctBowlDepth - fanDuctConnectRadius) - fanDuctConnectRadius - fanDuctThickness])
	       difference() {
	       rotate([0,90,0])
		    cylinder(r=(fanDuctConnectRadius + fanDuctThickness), h=fanDuctConnectSize[0] + (fanDuctThickness * 2),$fn=100);
	       
	       translate([- .1, - (fanDuctConnectRadius + 2.5), 0])
		    cube([fanDuctConnectSize[0] + (fanDuctThickness * 2) + .2, (fanDuctConnectRadius * 2) + 5, fanDuctConnectRadius + fanDuctThickness + 5]);
	  }
	  // Create the connection to the outlets.
	  simple_fan_duct_nozzle_connect(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, false, reverseY);
     }

     // Connect the nozzle connect to the nozzles.
     hull() {
	  // Create the connection to the outlets.
	  simple_fan_duct_nozzle_connect(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, false, reverseY);
	  // Create the outlets.
	  simple_fan_duct_nozzle(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, false, reverseY);
     }
}

module simple_fan_duct_holes(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDirection, reverseY=false) {
     // Carve out the inside part of connection to the fan.
     translate([0, 0, -fanDuctThickness - .1])
	  cube([fanDuctConnectSize[0],
		fanDuctConnectSize[1],
		fanDuctOutsideOverlap + fanDuctThickness + .2]);
     hull() {
	  // Recreate the body of the fan shroud so we can hull to it.
	  translate([0,0, -fanDuctThickness - .1])
	       cube([fanDuctConnectSize[0],
		     fanDuctConnectSize[1],
		     .2]);

	  // Round out the bottom a bit
	  translate([0,
		     fanDuctConnectRadius,
		     - (fanDuctBowlDepth - fanDuctConnectRadius) - fanDuctConnectRadius])
	       difference() {
	       rotate([0,90,0])
		    cylinder(r=fanDuctConnectRadius, h=fanDuctConnectSize[0],$fn=100);
	       
	       translate([- .1, - (fanDuctConnectRadius + 2.5), 0])
		    cube([fanDuctConnectSize[0] + .2, (fanDuctConnectRadius * 2) + 5, fanDuctConnectRadius + 5]);
	  }
	  // Create the connection to the outlets.
	  simple_fan_duct_nozzle_connect(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, true, reverseY);
     }

     // Connect the nozzle connect to the nozzles.
     hull() {
	  // Create the connection to the outlets.
	  simple_fan_duct_nozzle_connect(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, true, reverseY);
	  // Create the outlets.
	  simple_fan_duct_nozzle(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, true, reverseY);
     }
}

module simple_fan_duct_nozzle_connect(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, interior=false, reverseY=false) {
     // Loop through the nozzles, create duct for each one.
     for(a=[0: 1: len(heNozzleL) - 1]) {
	  // Start the process of placing the nozzles in the correct place. Split up to keep things simpler to understand for now.
	  echo("ductConnectL", ductConnectL);
	  echo("heAnchorL", heAnchorL);
	  echo("fanDuctOutletNozzleOffsetL", fanDuctOutletNozzleOffsetL);
	  echo("reverseY", reverseY);
	  echo("heNozzleL",heNozzleL[a]);
	  echo("heNozzleL", heNozzleL);
	  translate(-ductConnectL)
	       rotate([-tabHorizontalAngle,0,0])
	       rotate([0,0,-tabVerticalAngle])
	       translate(-fanScrewL)
	       translate(heAnchorL)
	       translate(heNozzleL[a]) {
	       translate([0,
			  (reverseY == false ? - simpleFanDuctOutletNozzleOffsetL[0] - simpleFanDuctRunnerLength: simpleFanDuctOutletNozzleOffsetL[0] + simpleFanDuctRunnerLength),
			  simpleFanDuctOutletNozzleOffsetL[1] + ((simpleFanDuctOutletSize[2] / 2) + fanDuctThickness) + simpleFanDuctRunnerOffset])
		    rotate([(reverseY == false ? - simpleFanDuctOutletAngle : simpleFanDuctOutletAngle), 0, 0])
		    cube([simpleFanDuctOutletSize[0] + (interior ? 0 : (fanDuctThickness * 2)),
			  simpleFanDuctOutletSize[1] + (interior ? .01 : 0),
			  simpleFanDuctOutletSize[2] + (interior ? 0 : (fanDuctThickness * 2))], center=true);
	  }
     }
}

module simple_fan_duct_nozzle(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, interior=false, reverseY=false) {
     // Loop through the nozzles, create duct for each one.
     for(a=[0: 1: len(heNozzleL) - 1]) {
	  // Start the process of placing the nozzles in the correct place. Split up to keep things simpler to understand for now.
	  echo("ductConnectL", ductConnectL);
	  echo("heAnchorL", heAnchorL);
	  echo("fanDuctOutletNozzleOffsetL", fanDuctOutletNozzleOffsetL);
	  echo("fanDuctOutletSize", fanDuctOutletSize);
	  echo("fanDuctOutletOffset", fanDuctOutletOffset);
	  echo("reverseY", reverseY);
	  echo("heNozzleL",heNozzleL[a]);
	  echo("heNozzleL", heNozzleL);
	  echo("fanDuctOutletAngle", fanDuctOutletAngle);
	  translate(-ductConnectL)
	       rotate([-tabHorizontalAngle,0,0])
	       rotate([0,0,-tabVerticalAngle])
	       translate(-fanScrewL)
	       translate(heAnchorL)
	       translate(heNozzleL[a]) {
	       // Rotate the duct outlets to point to the correct spot.
	       // Edge nearest nozzle
	       translate([0,
			  (reverseY == false ? - simpleFanDuctOutletNozzleOffsetL[0] : simpleFanDuctOutletNozzleOffsetL[0]),
			  simpleFanDuctOutletNozzleOffsetL[1] + ((simpleFanDuctOutletSize[2] / 2) + fanDuctThickness)])
		    rotate([(reverseY == false ? - simpleFanDuctOutletAngle : simpleFanDuctOutletAngle), 0, 0])
		    cube([simpleFanDuctOutletSize[0] + (interior ? 0 : (fanDuctThickness * 2)),
			  simpleFanDuctOutletSize[1] + (interior ? .01 : 0),
			  simpleFanDuctOutletSize[2] + (interior ? 0 : (fanDuctThickness * 2))], center=true);
	  }
     }
}

// Round Fan Duct
module round_fan_duct(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDirection, reverseY=false) {
echo("fanDirection:",fanDirection);
echo("reverseY",reverseY);
     translate([-fanDuctThickness, -fanDuctThickness, 0])
	  difference() {
	  cube([fanDuctConnectSize[0] + (fanDuctThickness * 2),
		fanDuctConnectSize[1] + (fanDuctThickness * 2),
		fanDuctOutsideOverlap]);

	  hull() {
	       translate([-.1,
			  -.1,
			  ((fanDirection == "left" && reverseY == true) || (fanDirection == "right" && reverseY == false)) ? fanDuctOverlap
			      : fanDuctOutsideOverlap])
		    cube([.1, fanDuctConnectSize[1] + (fanDuctThickness * 2) + .2,
			  ((fanDirection == "left" && reverseY == true) || (fanDirection == "right" && reverseY == false)) ? fanDuctOutsideOverlap
			  : fanDuctOverlap]);
	       
	       translate([(fanDuctConnectSize[0] + (fanDuctThickness * 2)),
			  -.1,
			  ((fanDirection == "left" && reverseY == true) || (fanDirection == "right" && reverseY == false)) ? fanDuctOutsideOverlap
			  : fanDuctOverlap])
		    cube([.1, fanDuctConnectSize[1] + (fanDuctThickness * 2) + .2,
			  ((fanDirection == "left" && reverseY == true) || (fanDirection == "right" && reverseY == false)) ? fanDuctOverlap
			  : fanDuctOutsideOverlap]);
	  }
     }
     
     hull() {
	  // Recreate the body of the fan shroud so we can hull to it.
	  translate([-fanDuctThickness, -fanDuctThickness, 0])
	       cube([fanDuctConnectSize[0] + (fanDuctThickness * 2),
		     fanDuctConnectSize[1] + (fanDuctThickness * 2),
		     .1]);

	  // Round out the bottom a bit
	  translate([-fanDuctThickness,
		     fanDuctConnectRadius,
		     - (fanDuctBowlDepth - fanDuctConnectRadius) - fanDuctConnectRadius - fanDuctThickness])
	       difference() {
	       rotate([0,90,0])
		    cylinder(r=(fanDuctConnectRadius + fanDuctThickness), h=fanDuctConnectSize[0] + (fanDuctThickness * 2),$fn=100);
	       
	       translate([- .1, - (fanDuctConnectRadius + 2.5), 0])
		    cube([fanDuctConnectSize[0] + (fanDuctThickness * 2) + .2, (fanDuctConnectRadius * 2) + 5, fanDuctConnectRadius + fanDuctThickness + 5]);
	  }
	  // Create the connection to the outlets.
	  round_fan_duct_nozzle_connect(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, false, reverseY);
     }
     // Create the outlets.
     round_fan_duct_nozzle(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, false, reverseY);
}

module round_fan_duct_holes(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDirection, reverseY=false) {
     // Carve out the inside part of connection to the fan.
     translate([0, 0, -fanDuctThickness - .1])
	  cube([fanDuctConnectSize[0],
		fanDuctConnectSize[1],
		fanDuctOutsideOverlap + fanDuctThickness + .2]);
     hull() {
	  // Recreate the body of the fan shroud so we can hull to it.
	  translate([0,0, -fanDuctThickness - .1])
	       cube([fanDuctConnectSize[0],
		     fanDuctConnectSize[1],
		     .2]);

	  // Round out the bottom a bit
	  translate([0,
		     fanDuctConnectRadius,
		     - (fanDuctBowlDepth - fanDuctConnectRadius) - fanDuctConnectRadius])
	       difference() {
	       rotate([0,90,0])
		    cylinder(r=fanDuctConnectRadius, h=fanDuctConnectSize[0],$fn=100);
	       
	       translate([- .1, - (fanDuctConnectRadius + 2.5), 0])
		    cube([fanDuctConnectSize[0] + .2, (fanDuctConnectRadius * 2) + 5, fanDuctConnectRadius + 5]);
	  }
	  // Create the connection to the outlets.
	  round_fan_duct_nozzle_connect(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, true, reverseY);
     }

     // Create the outlets.
     round_fan_duct_nozzle(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, true, reverseY);
}

module round_fan_duct_nozzle_connect(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, interior=false, reverseY=false) {
     // Build array of points for the duct connector.
     // First array is line of cylinders for connector to fan, first element in array is angle, set that to zero so there is no rotation, want a line.
     dca = [ for (a=[0:30:180]) let (x = (fanDuctOutletNozzleOffsetL[0] + fanDuctAirChamberSize[0] + fanDuctThickness + (interior ? 0 : fanDuctThickness) - (fanDuctInternalThickness / 2) -
					  ((((fanDuctOutletNozzleOffsetL[0] + fanDuctAirChamberSize[0] + fanDuctThickness - (fanDuctInternalThickness / 2) + (interior ? 0 : fanDuctThickness)) * 2) / 180) * a)),
				     y = (fanDuctOutletNozzleOffsetL[0] + fanDuctAirChamberSize[0] + (fanDuctThickness * 2) + (interior ? -.1 : 0)),
				     z = (fanDuctOutletNozzleOffsetL[1] + (interior ? fanDuctThickness : 0))) [0,x,y,z]];
     // Build array for part that connects to air chamber in duct.
     dcb = [ for (a=[0:30:180]) let (x = (fanDuctOutletNozzleOffsetL[0] + fanDuctAirChamberSize[0] + fanDuctThickness + (interior ? 0 : fanDuctThickness) - (fanDuctInternalThickness /2)),
				     y = 0,
				     z = (fanDuctOutletNozzleOffsetL[1] + (interior ? fanDuctThickness : 0))) [a,x,y,z]];
     dc = concat(dca,dcb);
     
     // Build matrix of points to hull together to create the connection from the air chamber to the fan connector.
     dcMat = [[0,6]];

     // Loop through the nozzles, create duct for each one.
     for(a=[0: 1: len(heNozzleL) - 1]) {
	  // Start the process of placing the nozzles in the correct place. Split up to keep things simpler to understand for now.
	  echo("ductConnectL", ductConnectL);
	  echo("heAnchorL", heAnchorL);
	  echo("fanDuctOutletNozzleOffsetL", fanDuctOutletNozzleOffsetL);
	  echo("reverseY", reverseY);
	  echo("heNozzleL",heNozzleL[a]);
	  echo("heNozzleL", heNozzleL);
	  translate(-ductConnectL)
	       rotate([-tabHorizontalAngle,0,0])
	       rotate([0,0,-tabVerticalAngle])
	       translate(-fanScrewL)
	       translate(heAnchorL)
	       translate(heNozzleL[a]) {
	       // Determine what style of fan duct we are making.
	       // Create the connector for the duct from the fan.
	       // Rotate depending on the orientation of the duct to fan.
	       rotate([0,0,(reverseY ? 0 : 180)])
		    for (a=dcMat) {
			 // Create the connector by hull from the edge of the interior of the air duct chamber to a line of cylinders on the edge of the duct.
			 hull() {
			      for (b=a) {
				   // Rotate around the duct to create the other cylinder and thus the connection to the duct connector from the air chamber.
				   rotate([0,0,dc[b][0]])
					translate([dc[b][1],dc[b][2],dc[b][3]])
					cylinder(d=fanDuctInternalThickness,h=(fanDuctAirChamberSize[1] + (interior ? 0 : (fanDuctThickness * 2))), $fn=100);
			      }
			 }
		    }
	  }
     }
}

module round_fan_duct_nozzle(ductConnectL, fanScrewL, heAnchorL, tabHorizontalAngle, tabVerticalAngle, fanDuctThickness, interior=false, reverseY=false) {
     // Corner positions for nozzle outlet.
     //  b------------a
     //  |c----------d|
     //  ||          ||
     //  ||          ||
     //  ||          ||
     //  ||          ||
     //  ||          ||
     //  |3----------4|
     //  1------------2

     nb = [
	  [0, 0], // 1
	  [fanDuctAirChamberSize[0] + (fanDuctThickness * 2), 0] // 2
	  ];
     ni = [
	  [fanDuctThickness, fanDuctThickness], // 3
	  [fanDuctAirChamberSize[0] + fanDuctThickness, fanDuctThickness] // 4
	  ];
     
     // Build array of points to round out top of air chamber.
     act = [ for (a = [0:180]) let (x = ((fanDuctAirChamberSize[0] / 2) + fanDuctThickness) + (((fanDuctAirChamberSize[0] / 2) + fanDuctThickness) * cos(a)),
				    y = (fanDuctAirChamberSize[1] + (fanDuctThickness * 2)) + (((fanDuctAirChamberSize[0] / 2) + fanDuctThickness) * sin(a))) [x,y]];
     aci = [ for (a = [0:180]) let (x = ((fanDuctAirChamberSize[0] / 2) + fanDuctThickness) + ((fanDuctAirChamberSize[0] / 2) * cos(a)),
				    y = (fanDuctAirChamberSize[1] + (fanDuctThickness * 2)) + ((fanDuctAirChamberSize[0] / 2) * sin(a))) [x,y]];
     
     // Build array of points for the duct connector.
     // First array is line of cylinders for connector to fan, first element in array is angle, set that to zero so there is no rotation, want a line.
     dca = [ for (a=[0:30:180]) let (x = (fanDuctOutletNozzleOffsetL[0] + fanDuctAirChamberSize[0] + fanDuctThickness + (interior ? 0 : fanDuctThickness) - (fanDuctInternalThickness / 2) -
					  ((((fanDuctOutletNozzleOffsetL[0] + fanDuctAirChamberSize[0] + fanDuctThickness - (fanDuctInternalThickness / 2) + (interior ? 0 : fanDuctThickness)) * 2) / 180) * a)),
				     y = (fanDuctOutletNozzleOffsetL[0] + fanDuctAirChamberSize[0] + (fanDuctThickness * 2) + (interior ? .1 : 0)),
				     z = (fanDuctOutletNozzleOffsetL[1] + (interior ? fanDuctThickness : 0))) [0,x,y,z]];
     // Build array for part that connects to air chamber in duct.
     dcb = [ for (a=[0:30:180]) let (x = (fanDuctOutletNozzleOffsetL[0] + fanDuctAirChamberSize[0] + fanDuctThickness + (interior ? 0 : fanDuctThickness) - (fanDuctInternalThickness / 2)),
				     y = 0,
				     z = (fanDuctOutletNozzleOffsetL[1] + (interior ? fanDuctThickness : 0))) [a,x,y,z]];
     dc = concat(dca,dcb);
     
     // Build matrix of points to hull together to create the connection from the air chamber to the fan connector.
     dcMat = [[7,8,0,1],[8,9,1,2],[9,10,2,3],[10,11,3,4],[11,12,4,5],[12,13,5,6]];
     
     // Which part of the duct connector should remain. This is meant to create a wedge in the middle to distribute the air pressure more equally.
     dcWedgeMat = [[9,3],[3,11],[8,1],[12,5]];
     
     // Build final array of points for nozzle polygon.
     nz = concat(nb,act,[nb[0]],ni,aci,[ni[0]]);
     echo("act", act);
     echo("aci", aci);
     echo("nb", nb);
     echo("ni", ni);
     echo("dca", dca);
     echo("dcb", dcb);
     echo("dc", dc);
     echo("dcMat", dcMat);
     
     // Loop through the nozzles, create duct for each one.
     for(a=[0: 1: len(heNozzleL) - 1]) {
	  // Start the process of placing the nozzles in the correct place. Split up to keep things simpler to understand for now.
	  echo("ductConnectL", ductConnectL);
	  echo("heAnchorL", heAnchorL);
	  echo("fanDuctOutletNozzleOffsetL", fanDuctOutletNozzleOffsetL);
	  echo("fanDuctOutletSize", fanDuctOutletSize);
	  echo("fanDuctOutletOffset", fanDuctOutletOffset);
	  echo("reverseY", reverseY);
	  echo("heNozzleL",heNozzleL[a]);
	  echo("heNozzleL", heNozzleL);
	  echo("fanDuctOutletAngle", fanDuctOutletAngle);
	  translate(-ductConnectL)
	       rotate([-tabHorizontalAngle,0,0])
	       rotate([0,0,-tabVerticalAngle])
	       translate(-fanScrewL)
	       translate(heAnchorL)
	       translate(heNozzleL[a]) {
	       // Create the air duct, skip if this an interior pass.
	       if (! interior) {
		    // Create the air chamber.
		    rotate_extrude(angle=360,$fn=200) {
			 translate(fanDuctOutletNozzleOffsetL)
			      polygon(points = nz);
		    }
	       }
		    
	       // Create the connector for the duct from the fan.
	       // Rotate depending on the orientation of the duct to fan.
	       for (a=dcMat) {
		    // Create the connector by hull from the edge of the interior of the air duct chamber to a line of cylinders on the edge of the duct.
		    difference() {
			 hull() {
			      for (b=a) {
				   // Rotate around the duct to create the other cylinder and thus the connection to the duct connector from the air chamber.
				   rotate([0,0,dc[b][0]])
					translate([dc[b][1],dc[b][2],dc[b][3]])
					cylinder(d=fanDuctInternalThickness,h=(fanDuctAirChamberSize[1] + (interior ? 0 : (fanDuctThickness * 2))), $fn=100);
			      }
			 }
			 
			 // Don't remove the internal wedge portion.
			 if (interior) {
			      for (c=dcWedgeMat) {
				   hull() {
					for (d=c) {
					     // Rotate around the duct to create the other cylinder and thus the connection to the duct connector from the air chamber.
					     rotate([0,0,dc[d][0]])
						  translate([dc[d][1],dc[d][2],dc[d][3]])
						  cylinder(d=fanDuctInternalThickness,h=(fanDuctAirChamberSize[1] + (interior ? 0 : (fanDuctThickness * 2))), $fn=100);
					}
				   }
			      }
			 }
		    }
	       }
	  }
     }
}    

// Servo Bracket
module servo_bracket(cbot=false) {
     // Check if we are building bracket for prusa i3 or cbot.
     if(cbot == true) {
	  // Build bracket for cbot.
	  union() {
	       // Create the top and bottom mounting holes.
	       hull () {
		    // Bottom
		    translate(servoBracketBotScrewL)			       
			 rotate([90,0,0])
			 cylinder(r=(cBotBeltScrewDiameter / 2) + servoBracketMat, h=servoBracketBaseDepth, $fn=100);
		    
		    // Top
		    translate(servoBracketTopScrewL)			       
			 rotate([90,0,0])
			 cylinder(r=(cBotBeltScrewDiameter / 2) + servoBracketMat, h=servoBracketBaseDepth, $fn=100);

		    // Connection to servo bracket.
		    translate([servoMountL[0],
			       0,
			       servoMountL[2]])
			 cube([(servoBracketMat * 2) + servoBracketScrewDiameter,
			       servoBracketBaseDepth,
			       servoMountPlateHeight]);
	       }
	       
	       // Create the servo enclosure.
	       rotate([0,0,0])
		    translate(servoMountL)
		    servo_mount();
	  }
     }
     else {
	  union() {
	       // Create the top and bottom mounting holes.
	       hull () {
		    // Bottom
		    translate(servoBracketBotScrewL)			       
			 rotate([90,0,0])
			 cylinder(r=(servoBracketScrewDiameter / 2) + servoBracketMat, h=servoBracketBaseDepth, $fn=100);
		    
		    // Top
		    translate(servoBracketTopScrewL)			       
			 rotate([90,0,0])
			 cylinder(r=(servoBracketScrewDiameter / 2) + servoBracketMat, h=servoBracketBaseDepth, $fn=100);
	       }	       
	  }

	  // Create the servo enclosure.
	  translate(servoMountL)
	       servo_mount();
     }
}

module servo_bracket_holes(cbot=false) {
     // Check if we are building a bracket for prusa i3 or cbot.
     if(cbot == true) {
	  // Carve out holes for cbot.
	  // Bottom
	  translate([servoBracketBotScrewL[0],
		     servoBracketBotScrewL[1] + .1,
		     servoBracketBotScrewL[2]])			       
	       rotate([90,0,0])
	       cylinder(d=cBotBeltScrewDiameter, h=servoBracketBaseDepth + .2, $fn=100);
	  
	  // Top
	  translate([servoBracketTopScrewL[0],
		     servoBracketTopScrewL[1] + .1,
		     servoBracketTopScrewL[2]])
	       rotate([90,0,0])
	       cylinder(d=cBotBeltScrewDiameter, h=servoBracketBaseDepth + .2, $fn=100);
	  
	  // Carve out the holes for the servo mount.
	  rotate([0,0,0])
	  translate([servoMountL[0],
		     servoMountL[1] + (servoBracketMat + (servoWidth / 2)),
		     servoMountL[2]])
	       servo_mount_holes();

     }
     else {
	  // Create the holes needed for the bracket mount and servo.
	  // Bottom
	  translate([servoBracketBotScrewL[0],
		     servoBracketBotScrewL[1] +.1,
		     servoBracketBotScrewL[2]])
	       rotate([90,0,0])
	       cylinder(d=servoBracketScrewDiameter, h=servoBracketBaseDepth + .2, $fn=100);
	  
	  // Top
	  translate([servoBracketTopScrewL[0],
		     servoBracketTopScrewL[1] +.1,
		     servoBracketTopScrewL[2]])
	       rotate([90,0,0])
	       cylinder(d=servoBracketScrewDiameter, h=servoBracketBaseDepth + .2, $fn=100);
	  
	  // Carve out the holes for the servo mount.
	  translate([servoMountL[0],
		     servoMountL[1] + (servoBracketMat + (servoWidth / 2)),
		     servoMountL[2]])
	       servo_mount_holes();

     }
}

module servo_mount() {
     // Spin up a cube that we will punch a hole in for servo later.
     cube([(servoBracketMat * 2) + servoBracketScrewDiameter,
	   (servoBracketMat * 2) + servoWidth + .1 + (carriage == "cbot" ? servoBracketOffset : 0),
	   servoMountPlateHeight]);
}

module servo_mount_holes(cbot=false) {
     // Servo hole
     translate([-.1,
		- (servoWidth / 2),
		(servoMountPlateHeight / 2) - (servoHeight / 2)])
	  cube([(servoBracketMat * 2) + servoBracketScrewDiameter + .2,
		servoWidth,
		servoHeight]);
     
     // Servo Screw Holes
     // Bottom
     translate([-.1,
		0,
		(servoMountPlateHeight / 2) - (servoScrewDistance / 2)])
	  rotate([-90,0,-90])
	  cylinder(d=servoScrewDiameter,h=((servoBracketMat * 2) + servoBracketScrewDiameter + .2), $fn=100);
     
     // Top
     translate([-.1,
		0,
		(servoMountPlateHeight / 2) + (servoScrewDistance / 2)])
	  rotate([-90,0,-90])
	  cylinder(d=servoScrewDiameter,h=((servoBracketMat * 2) + servoBracketScrewDiameter + .2), $fn=100);
}

// Z Probe Arm
module z_probe_arm(zpl) {
     // Create a couple of cylinders, hull them together to create the servo arm.
     hull() {
	  // Create the top of the Z Probe Arm
	  translate([-(zProbeThickness / 2),0,0])
	       rotate([0,90,0])
	       cylinder(r=(servoHatTopDiameter / 2) + zProbeArmMat, h=zProbeThickness, $fn=100);
	  
	  // Create the bottom of the Z Probe Arm
	  translate([-(zProbeThickness / 2),0,zpl])
	       rotate([0,90,0])
	       cylinder(r=(servoHatTopDiameter / 2) + zProbeArmMat, h=zProbeThickness, $fn=100);
     }

     // Create the switch mount.
     hull() {
	  // Recreate the bottom of the Z Probe Arm so we can hull to it.
	  translate([-(zProbeThickness / 2),0,zpl])
	       rotate([0,90,0])
	       cylinder(r=(servoHatTopDiameter / 2) + zProbeArmMat, h=zProbeThickness, $fn=100);

	  // Create the cylinders for the switch mount.
	  for(b=[0:1]) {
	       translate([-(zProbeThickness / 2),
			  b==0 ? -(zProbeScrewDistance / 2) :
			  (zProbeScrewDistance / 2),
			  zpl - (servoHatTopDiameter / 2)])
		    rotate([0,90,0])
		    cylinder(r=(zProbeScrewDiameter / 2) + zProbeArmMat, h=zProbeThickness, $fn=100);
	  }
     }	       
}

module z_probe_arm_holes(zpl) {
     // Create the servo shaft whole.
     translate([- (zProbeThickness / 2) - .1,0,0])
	  rotate([0,90,0])
	  cylinder(r=(servoShaftDiameter / 2), h=zProbeThickness + .2, $fn=100);
     
     // Create the servo hat recess.
     hull() {
	  // Create the servo hat recess, top first.
	  translate([((realZProbeSide == "right" && carriage == "prusai3") ||
		      (realZProbeSide == "left" && carriage == "cbot")) ?
		     - servoHatRecessDepth - .1 :
		     (zProbeThickness / 2) - servoHatRecessDepth,
		     0,
		     0])
	       rotate([0,90,0])
	       cylinder(r=(servoHatTopDiameter / 2), h=servoHatRecessDepth + .1, $fn=100);
	  
	  // Create the bottom of servo hat recess.
	  translate([((realZProbeSide == "right" && carriage == "prusai3") ||
		      (realZProbeSide == "left" && carriage == "cbot")) ?
		     - servoHatRecessDepth - .1 :
		     (zProbeThickness / 2) - servoHatRecessDepth,
		     0
		     ,- (servoHatLength - (servoHatTopDiameter / 2) - (servoHatTipDiameter / 2))])
	       rotate([0,90,0])
	       cylinder(r=(servoHatTipDiameter / 2), h=servoHatRecessDepth + .1, $fn=100);
     }

     // Create the holes that mount the switch.
     // Create the cylinders for the switch mount.
     for(b=[0:1]) {
	  translate([-(zProbeThickness / 2) - .1,
		     b==0 ? -(zProbeScrewDistance / 2) :
		     (zProbeScrewDistance / 2),
		     zpl - (servoHatTopDiameter / 2)])
	       rotate([0,90,0])
	       cylinder(r=(zProbeScrewDiameter / 2), h=zProbeThickness + .2, $fn=100);
     }
}

// Inductive / Capacitive / BL Touch extension
module probe_ext() {
     // Create the extension for the inductive / capacitive / BL Touch sensor.
     hull() {
	  // Bottom corner of X Carriage back plane.
	  translate([ realZProbeSide == "right" ?
		      xMountWidth - xMountCornerRadius
		      : xMountCornerRadius,
		      0,xMountCornerRadius])
	       rotate([90,0,0])
	       cylinder(r=xMountCornerRadius, h=carriageDepth, $fn=100);

	  // Top corner of X Carriage back plane.
	  translate([ realZProbeSide == "right" ?
		      xMountWidth - xMountCornerRadius
		      : xMountCornerRadius,
		      0,xMountHeight - xMountCornerRadius])
	       rotate([90,0,0])
	       cylinder(r=xMountCornerRadius, h=carriageDepth, $fn=100);

	  // Probe extension top outside corner.
	  translate([ realZProbeSide == "right" ?
		      heMountL[0] + heMountWidth + probeMountDistance + probeMountWidth - (probeExtHeight == "full" ? xMountCornerRadius : (probeBraceWidth / 2)):
		      heMountL[0] - (probeMountDistance + probeMountWidth - (probeExtHeight == "full" ? xMountCornerRadius : (probeBraceWidth / 2))),
		      0,
		      (probeExtHeight == "full" ?
		       xMountHeight - xMountCornerRadius :
		       heAnchorL[2] + heNozzleL[0][2] + probePlateHeight + probePlateThickness + probeBraceHeight - (probeBraceWidth / 2))])
	       rotate([90,0,0])
	       cylinder(d=(probeExtHeight == "full" ? (xMountCornerRadius * 2) : probeBraceWidth), h=carriageDepth, $fn=100);

	  // Probe extension top inside corner.
	  translate([ realZProbeSide == "right" ?
		      heMountL[0] + heMountWidth + probeMountDistance + (probeBraceWidth / 2):
		      heMountL[0] - probeMountDistance - (probeBraceWidth / 2),
		      0,
		      heAnchorL[2] + heNozzleL[0][2] + probePlateHeight + probePlateThickness + probeBraceHeight - (probeBraceWidth / 2)])
	       rotate([90,0,0])
	       cylinder(d=probeBraceWidth, h=carriageDepth, $fn=100);

	  // Probe mount bottom outside corner.
	  translate([ realZProbeSide == "right" ?
		      heMountL[0] + heMountWidth + probeMountDistance + probeMountWidth - (probeBraceWidth / 2):
		      heMountL[0] - (probeMountDistance + probeMountWidth - (probeBraceWidth / 2)),
		      0,
		      heAnchorL[2] + heNozzleL[0][2] + probePlateHeight + (probeBraceWidth / 2)])
	       rotate([90,0,0])
	       cylinder(d=probeBraceWidth, h=carriageDepth, $fn=100);

	  // Probe mount bottom inside corner.
	  translate([ realZProbeSide == "right" ?
		      heMountL[0] + heMountWidth + probeMountDistance + (probeBraceWidth / 2):
		      heMountL[0] - probeMountDistance - (probeBraceWidth / 2),
		      0,
		      heAnchorL[2] + heNozzleL[0][2] + probePlateHeight + (probeBraceWidth / 2)])
	       rotate([90,0,0])
	       cylinder(d=probeBraceWidth, h=carriageDepth, $fn=100);
     }
}

module induct_mount(carriageDepth,cbot=false) {
     hull() {
	  // Induct mount top right corner.
	  translate([ probeMountWidth - (probeBraceWidth / 2),
		      -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
		      cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) + (probeBraceWidth / 2) :
		      probePlateThickness + probeBraceHeight - (probeBraceWidth / 2)])
	       rotate([-90,0,0])
	       cylinder(d=probeBraceWidth, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  
	  // Induct mount top left corner.
	  translate([ (probeBraceWidth / 2),
		      -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
		      cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) + (probeBraceWidth / 2) :
		      probePlateThickness + probeBraceHeight - (probeBraceWidth / 2)])
	       rotate([-90,0,0])
	       cylinder(d=probeBraceWidth, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  
	  // Induct bracket bottom right corner.
	  translate([ probeMountWidth - (probeBraceWidth / 2),
		      -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
		      (probePlateThickness / 2)])
	       rotate([-90,0,0])
	       cylinder(d=probePlateThickness, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  
	  // Induct bracket bottom left corner.
	  translate([ (probeBraceWidth / 2),
		      -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
		      (probePlateThickness / 2)])
	       rotate([-90,0,0])
	       cylinder(d=probePlateThickness, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
     }
     
     // Create mounting plate
     // This will stick out a bit further than expected to accomodate the desire to have inductMat flat around the induct sensor and still have round corner.
     hull() {
	  // Induct mount bottom right.
	  hull() {
	       translate([ probeMountWidth - (probeBraceWidth / 2),
		     - (probeMountBracketed == 0 ? 0 : probeBracketDepth) - (probeOffset + (inductDiameter / 2) + inductMat),
			   (probePlateThickness / 2)])
		    sphere(d=probePlateThickness, $fn=100);
	       
	       translate([ probeMountWidth - (probeBraceWidth / 2),
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   (probePlateThickness / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probePlateThickness, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  }
	  
	  // Induct mount bottom left.
	  hull() {
	       translate([ (probeBraceWidth / 2),
		     - (probeMountBracketed == 0 ? 0 : probeBracketDepth) - (probeOffset + (inductDiameter / 2) + inductMat),
			   (probePlateThickness / 2)])
		    sphere(d=probePlateThickness, $fn=100);
	       
	       translate([ (probeBraceWidth / 2),
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   (probePlateThickness / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probePlateThickness, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  }

	  // Create mount for the inductive sensor itself.
	  translate([(probeMountWidth / 2),
		     - (probeMountBracketed == 0 ? 0 : probeBracketDepth) - (probeOffset + (inductDiameter / 2) + inductMat),
		     (probePlateThickness / 2)])
	       minkowski() {
	       cylinder(d=(inductDiameter + inductMat), h=.0000000001, $fn=100);
	       sphere(d=probePlateThickness, $fn=100, center=true);
	  }

     }
     
     // Create braces
     // This will stick out a bit further than expected to accomodate the desire to have inductMat flat around the induct sensor and still have round corner.
     hull() {
	  // Induct mount top right corner.
	  translate([ probeMountWidth - (probeBraceWidth / 2),
		      -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
		      cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) + (probeBraceWidth / 2) :
		      probePlateThickness + probeBraceHeight - (probeBraceWidth / 2)])
	       sphere(d=probeBraceWidth, $fn=100);
	  
	  // Induct mount bottom right corner.
	  hull() {
	       translate([ probeMountWidth - (probeBraceWidth / 2),
			   - (probeMountBracketed == 0 ? 0 : probeBracketDepth) - (probeOffset + (inductDiameter / 2) + inductMat),
			   (probeBraceWidth / 2)])
		    sphere(d=probeBraceWidth, $fn=100);
	       
	       translate([ probeMountWidth - (probeBraceWidth / 2),
				-(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   (probeBraceWidth / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probeBraceWidth, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  }
     }
     
     // Induct mount top left corner.
     hull() {
	  translate([ (probeBraceWidth / 2),
		      -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
		      cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) + (probeBraceWidth / 2) :
		      probePlateThickness + probeBraceHeight - (probeBraceWidth / 2)])
	       sphere(d=probeBraceWidth, $fn=100);
	  
	  // Induct mount bottom left corner.
	  hull() {
	       translate([ (probeBraceWidth / 2),
			   - (probeMountBracketed == 0 ? 0 : probeBracketDepth) - (probeOffset + (inductDiameter / 2) + inductMat),
			   (probeBraceWidth / 2)])
		    sphere(d=probeBraceWidth, $fn=100);
	       
	       translate([ (probeBraceWidth / 2),
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   (probeBraceWidth / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probeBraceWidth, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  }
     }
}

module probe_ext_holes(carriageDepth) {
     // Create the holes needed for the z probe extension.
     // First create the mounting holes if needed.
     if (probeMountBracketed == 1) {
	  // Create the mounting screw holes in the bracket and X Carriage back plane.
	  translate([(probeMountWidth / 2),
		     0,
		     probePlateThickness + (probeBracketScrewDiameter * 1.5)])
	       rotate([-90,0,0])
	       bolt_hole(probeBracketScrewDiameter, (carriageDepth - probeBracketNutDepth), probeBracketNutDiameter, probeBracketNutDepth);
	  
	  translate([(probeMountWidth / 2),
		     0,
		     probePlateThickness + probeBraceHeight - (probeBracketScrewDiameter * 1.5)])
	       rotate([-90,0,0])
	       bolt_hole(probeBracketScrewDiameter, (carriageDepth - probeBracketNutDepth), probeBracketNutDiameter, probeBracketNutDepth);
     }
}

module induct_mount_holes(cbot=false) {
     // Create the holes needed for the z probe extension.
     // First create the mounting holes if needed.
     if (probeMountBracketed == 1) {
	  // Create the mounting screw holes in the bracket and X Carriage back plane.
	  translate([(probeMountWidth / 2),
		     - (probeBracketDepth + .1),
		     cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + cBotAccessoryMountPos :
		     probePlateThickness + (probeBracketScrewDiameter * 1.5)])
	       rotate([-90,0,0])
	       cylinder(d=(cbot == true ? cBotBeltScrewDiameter : probeBracketScrewDiameter), h=probeBracketDepth + .2, $fn=100);
	  
	  translate([(probeMountWidth / 2),
		     - (probeBracketDepth + .1),
		     cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) :
		     probePlateThickness + probeBraceHeight - (probeBracketScrewDiameter * 1.5)])
	       rotate([-90,0,0])
	       cylinder(d=(cbot == true ? cBotBeltScrewDiameter : probeBracketScrewDiameter), h=probeBracketDepth + .2, $fn=100);
     }
     
     // Carve out the whole for the inductive sensor itself.
     translate([(probeMountWidth / 2),
		- (probeMountBracketed == 0 ? 0 : probeBracketDepth) - (probeOffset + (inductDiameter / 2) + inductMat),
		- .1])
	  cylinder(d=inductDiameter, h=probePlateThickness + .2, $fn=100);
}

// Cable tie hole creator.
module cable_tie(height, width, radius) {
     rotate_extrude()
	  translate([radius, 0, 0])
	  square([width, height]);
}

// Functions to return position variables.
// Fan Duct starting location, left fan orientation in first vector, right in second. This is offset from prusai3FanScrewL. Does NOT take angles into account.
function fan_duct_connect(tabScrewL, horizontalAngle, verticalAngle, dimensions, centerOffset, mountOffset, mountThickness, tabHole, tabHoleMat, ductConnectSize, reverseY=false)
= [[- (dimensions[0] * .25) - (ductConnectSize[0] / 2) - fanDuctThickness - centerOffset[0] - mountOffset[0],
    reverseY == false ? - ((tabHole / 2) + tabHoleMat + dimensions[1] + centerOffset[1] + mountOffset[1] + mountThickness) :
			   ((tabHole / 2) + tabHoleMat + centerOffset[1] + mountOffset[1] + mountThickness),
    - (dimensions[2] / 2) + centerOffset[2] + mountOffset[2]],
   [(dimensions[0] * .25) - (ductConnectSize[0] / 2) + fanDuctThickness + centerOffset[0] + mountOffset[0],
    reverseY == false ? - ((tabHole / 2) + tabHoleMat + dimensions[1] + centerOffset[1] + mountOffset[1] + mountThickness) :
			   ((tabHole / 2) + tabHoleMat + centerOffset[1] + mountOffset[1] + mountThickness),
    - (dimensions[2] / 2) + centerOffset[2] + mountOffset[2]]];
     
// C Bot modules
module cbot_carriage_side(heSide=false) {
	echo("heSide", heSide);
	echo("Number of wheels on carriage", cBotNumberOfCarriageWheels);
   
	if (cBotNumberOfCarriageWheels == "3")
		{
			 difference(){
				cbot_carriage_base();  // Create the base.
				
				union(){
					cbot_carriage_three_holes();  
					cBot_cut_other_holes(heSide);
				}
			 }	
		} else
		{
		difference(){
				union(){
					cbot_carriage_base();
					cbot_carriage_wheel_bolt_angle_plates();}  // Create the base.
				{union(){
					cbot_carriage_holes();  // Then remove the holes.
					cBot_cut_other_holes(heSide);}
				}
			}
		}
}

module cbot_carriage_base() {
     // Base C Bot XY Carriage side.
     translate([cBotCarriageCornerRadius, 0, cBotCarriageCornerRadius])
	  hull() 
		{
		  // Create the top left corner.
		  translate([0, 0, cBotCarriageHeight - (cBotCarriageCornerRadius * 2)])
			   rotate([90,0,0])
			   cylinder(r=cBotCarriageCornerRadius, h=carriageDepth, $fn=100);
		  // Create the top right Corner
		  translate([cBotCarriageWidth - (cBotCarriageCornerRadius * 2), 0, cBotCarriageHeight - (cBotCarriageCornerRadius * 2)])
			   rotate([90,0,0])
			   cylinder(r=cBotCarriageCornerRadius, h=carriageDepth, $fn=100);
		  // Create the bottom left corner.
		  rotate([90,0,0])
			   cylinder(r=cBotCarriageCornerRadius, h=carriageDepth, $fn=100);
		  // Create the bottom right corner
		  translate([cBotCarriageWidth - (cBotCarriageCornerRadius * 2), 0, 0])
			   rotate([90,0,0])
			   cylinder(r=cBotCarriageCornerRadius, h=carriageDepth, $fn=100);
		}
}
module cbot_carriage_wheel_bolt_angle_plates(){
   // Create angle portion of top left corner.
     translate([cBotCarriageCornerRadius, 0, cBotCarriageHeight - cBotCarriageCornerRadius])
	  difference() 
		{
		  hull() {
			   rotate([90,0,0])
				cylinder(r=cBotCarriageCornerRadius, h=cBotTopHoleDepth, $fn=100);
			   translate([0, 0, -cBotTopHoleLength])
				rotate([90,0,0])
				cylinder(r=cBotCarriageCornerRadius, h=cBotTopHoleDepth, $fn=100);
		  }
		  hull() {
			   translate([-cBotCarriageCornerRadius, -cBotTopHoleDepth - (cBotTopHoleDepth - carriageDepth) - .1, cBotCarriageCornerRadius])
				cube([(cBotCarriageCornerRadius * 2) + .2, (cBotTopHoleDepth - carriageDepth) + .1, .1]);
			   translate([-cBotCarriageCornerRadius, -carriageDepth - (cBotTopHoleDepth - carriageDepth) - .1, -cBotCarriageCornerRadius - cBotTopHoleLength])
				cube([(cBotCarriageCornerRadius * 2) + .2, (cBotTopHoleDepth - carriageDepth) + .1, .1]);
		  }
		}
     // Create angle portion of top right corner
     translate([cBotCarriageWidth - cBotCarriageCornerRadius, 0, cBotCarriageHeight - cBotCarriageCornerRadius])
	  difference() 
		{
		  hull() {
			   rotate([90,0,0])
				cylinder(r=cBotCarriageCornerRadius, h=cBotTopHoleDepth, $fn=100);
			   translate([0, 0, -cBotTopHoleLength])
				rotate([90,0,0])
				cylinder(r=cBotCarriageCornerRadius, h=cBotTopHoleDepth, $fn=100);
				}		
		  hull() {
			   translate([-cBotCarriageCornerRadius, -cBotTopHoleDepth - (cBotTopHoleDepth - carriageDepth) - .1, cBotCarriageCornerRadius])
				cube([(cBotCarriageCornerRadius * 2) + .2, (cBotTopHoleDepth - carriageDepth) + .1, .1]);
			   translate([-cBotCarriageCornerRadius, -carriageDepth - (cBotTopHoleDepth - carriageDepth) - .1, -cBotCarriageCornerRadius - cBotTopHoleLength])
				cube([(cBotCarriageCornerRadius * 2) + .2, (cBotTopHoleDepth - carriageDepth) + .1, .1]);
				}
		}	
}
module cbot_carriage_holes() {
     // Remove the holes for the corners.
     // Bottom left.
     translate([cBotCarriageCornerRadius, .1, cBotCarriageCornerRadius])
	  rotate([90, 0, 0])
	  cylinder(d=cBotCarriageIdlerScrewDiameter, h=carriageDepth + .2, $fn=100);
     // Bottom right.
     translate([cBotCarriageWidth - cBotCarriageCornerRadius, .1, cBotCarriageCornerRadius])
	  rotate([90, 0, 0])
	  cylinder(d=cBotCarriageIdlerScrewDiameter, h=carriageDepth + .2, $fn=100);
     // Top left.
     translate([cBotCarriageCornerRadius, .1, cBotCarriageHeight - cBotCarriageCornerRadius])
	  hull() {
	  rotate([90,0,0])
	       cylinder(d=cBotCarriageIdlerScrewDiameter, h=cBotTopHoleDepth + .2, $fn=100);
	  translate([0, 0, -cBotTopHoleLength])
	       rotate([90,0,0])
	       cylinder(d=cBotCarriageIdlerScrewDiameter, h=cBotTopHoleDepth + .2, $fn=100);
     }
     // Top right.
     translate([cBotCarriageWidth - cBotCarriageCornerRadius, .1, cBotCarriageHeight - cBotCarriageCornerRadius])
	  hull() {
	  rotate([90,0,0])
	       cylinder(d=cBotCarriageIdlerScrewDiameter, h=cBotTopHoleDepth + .2, $fn=100);
	  translate([0, 0, -cBotTopHoleLength])
	       rotate([90,0,0])
	       cylinder(d=cBotCarriageIdlerScrewDiameter, h=cBotTopHoleDepth + .2, $fn=100);
     }
}
module cbot_carriage_three_holes() {
echo("cbot_carriage_three_holes");
     // Remove the holes for the carriage wheels.
	 // Bottom, Middle with eccentric spacer.
	 translate([cBotCarriageWidth/2,.1,(cBotCarriageEccentricSpacerScrewDiameter/2)+cBotCarriageIdlerScrewMat ])//cBotCarriageCornerRadius])
		rotate([90,0,0])
		cylinder(d=cBotCarriageEccentricSpacerScrewDiameter, h=carriageDepth + .2, $fn=100);
     // Top left.
     translate([cBotCarriageCornerRadius, .1, cBotCarriageHeight - cBotCarriageCornerRadius])
	  hull() 
		{
		  rotate([90,0,0])
			   cylinder(d=cBotCarriageIdlerScrewDiameter, h=cBotTopHoleDepth + .2, $fn=100);
		}
     // Top right.
     translate([cBotCarriageWidth - cBotCarriageCornerRadius, .1, cBotCarriageHeight - cBotCarriageCornerRadius])
	  hull() 
		{
		  rotate([90,0,0])
			   cylinder(d=cBotCarriageIdlerScrewDiameter, h=cBotTopHoleDepth + .2, $fn=100);
		 }
}
/*     // Cut out the big oval in the middle.
     difference() {
	  translate([(cBotCarriageWidth / 2), .1, (cBotCarriageHeight / 2)])
	       rotate([90, 0, 0])
	       resize([cBotCenterHoleWidth,0,0])
	       cylinder(d=cBotCenterHoleDiameter, carriageDepth + .2, $fn=100);
	  // Leave a bar for the fan mount if needed.
	  if(! heSide) {
	       translate([0, -carriageDepth, cBotFanMountPos - (cBotFanBracketHeight * .75)])
		    cube([cBotCarriageWidth, carriageDepth, (cBotFanBracketHeight * 1.5)]);
	  }
     }
*/     
module cBot_cut_other_holes(heSide=false){
	// Cut out the belt holder and holes.
    // Top belt cutout
     translate([-.1, -cBotBeltDepth, ((cBotCarriageHeight / 2) + cBotBeltTopPos)])
	  cbot_belt_cutout();
     // Bottom belt cutout
     translate([cBotCarriageWidth + .1, -cBotBeltDepth, ((cBotCarriageHeight / 2) - cBotBeltBottomPos)])
	  rotate([0, 180, 0])
	  cbot_belt_cutout();
     // Don't cut out fan holes on side with hot end.
     if(heSide == false) {
	  // Cutout mounting holes for the fan mount. This can be easily made repeatable by replace the multipliers with j and i.
	  // Left side
	  translate([cBotCarriageWidth - fanScrewL[0] - (cBotFanMountDistance / 2), -carriageDepth, cBotFanMountPos])
	       rotate([-90,0,0])
	       bolt_hole(cBotBeltScrewDiameter, carriageDepth - cBotBeltScrewNutDepth, cBotBeltScrewNutDiameter, cBotBeltScrewNutDepth);
	  // Right side
	  translate([cBotCarriageWidth - fanScrewL[0] + (cBotFanMountDistance / 2), -carriageDepth, cBotFanMountPos])
	       rotate([-90,0,0])
	       bolt_hole(cBotBeltScrewDiameter, carriageDepth - cBotBeltScrewNutDepth, cBotBeltScrewNutDiameter, cBotBeltScrewNutDepth);
     }
     // Carve out some cable tie locations.
     for(j=[cBotCableTieHorizontalDistance : cBotCableTieHorizontalDistance : cBotCarriageWidth - cBotCableTieHorizontalDistance]) {
	  for(i=[0 : 1 : cBotCableTieVerticalCount - 1]) {
	       if(((cBotXAxisSwitch == "keyes" || cBotXAxisSwitch == "yl99") &&
		   (((cBotXAxisSwitchSide == "acc" || cBotXAxisSwitchSide == "both") && heSide == false) ||
		    ((cBotXAxisSwitchSide == "he" || cBotXAxisSwitchSide == "both") && heSide == true)) &&
		  (i == 1 || i == 2) && (j >= (cBotCableTieHorizontalDistance * 3))) ||
		    ( i == 2 && (j == cBotCableTieHorizontalDistance * 2))) {
		    // Don't carve out this cable tie, it is under the switch.
	       } else {
		    translate([ j,
				-8,
				cBotCarriageHeight - cBotCableTieVerticalPos - (cBotCableTieVerticalDistance * i)])
			 cable_tie(3,1.2,4.5);
	       }
	  }
     }
     // Carve out some bolt holes for mounting various things.
	 
	 
     for(j=[0 : 1 : ((cBotCarriageWidth / cBotFanMountDistance) / 2) -2]) {
	  for(i=[1 : 1 : 2]) {
	       // Left side
		translate([(cBotCarriageWidth / 2) - ((cBotFanMountDistance / 2) + (cBotFanMountDistance * j)),
			  -carriageDepth,
			  cBotAccessoryMountPos * i])
		    rotate([-90,0,0])
			if((cBotNumberOfCarriageWheels == "3") && (j==0) && (i==1)){
			//dont make the hole near the centre hole for the wheel.
			} else {
			 bolt_hole(cBotBeltScrewDiameter, carriageDepth - cBotBeltScrewNutDepth, cBotBeltScrewNutDiameter, cBotBeltScrewNutDepth);
	       translate([(cBotCarriageWidth / 2) - ((cBotFanMountDistance / 2) + (cBotFanMountDistance * j)),
			  -carriageDepth,
			  cBotCarriageHeight - (cBotAccessoryMountPos * i)])
		    rotate([-90,0,0])
		    bolt_hole(cBotBeltScrewDiameter, carriageDepth - cBotBeltScrewNutDepth, cBotBeltScrewNutDiameter, cBotBeltScrewNutDepth);
			}
		   

	       // Right side
	       translate([(cBotCarriageWidth / 2) + ((cBotFanMountDistance / 2) + (cBotFanMountDistance * j)),
			  -carriageDepth,
			  cBotAccessoryMountPos * i])
		    rotate([-90,0,0])
			if((cBotNumberOfCarriageWheels == "3") && (j==0) && (i==1)){
			//dont make the hole near the centre hole for the wheel.
			} else {
		    bolt_hole(cBotBeltScrewDiameter, carriageDepth - cBotBeltScrewNutDepth, cBotBeltScrewNutDiameter, cBotBeltScrewNutDepth);
			}
	       if((cBotXAxisSwitch == "keyes") &&  (i >= 2) && (j >= 1))  {
		    // Don't carve out this accessory hole, it is under the switch.
		    } else {
		    translate([(cBotCarriageWidth / 2) + ((cBotFanMountDistance / 2) + (cBotFanMountDistance * j)),
			       -carriageDepth,
			       cBotCarriageHeight - (cBotAccessoryMountPos * i)])
			 rotate([-90,0,0])
			 bolt_hole(cBotBeltScrewDiameter, carriageDepth - cBotBeltScrewNutDepth, cBotBeltScrewNutDiameter, cBotBeltScrewNutDepth);
	       }
	  }
     }
     // Carve out a space for the Axis endstop if needed.
     if(cBotXAxisSwitch != "none" &&
	((heSide == true && (cBotXAxisSwitchSide == "he" || cBotXAxisSwitchSide == "both")) ||
	(heSide == false && (cBotXAxisSwitchSide == "acc" || cBotXAxisSwitchSide == "both")))) {
	  // Carve out a space for the switch.
	  translate([cBotCarriageWidth - cBotXAxisSwitchDimensions[0][0] + cBotXAxisSwitchOffset,
		     -(carriageDepth - cBotXAxisSwitchDepth + cBotXAxisSwitchDimensions[0][1]),
		     ((cBotCarriageHeight / 2) - cBotBeltBottomPos + cBotBeltScrewDistance + (cBotBeltScrewNutDiameter / 2))]) {
	       cube(cBotXAxisSwitchDimensions[0]);
	       // Carve out a space for through hole solder points, if needed.
	       if(cBotXAxisSwitch == "yl99" || cBotXAxisSwitch == "keyes") {
		    hull() {
			 translate([cBotXAxisSwitchTHOffset,
				    cBotXAxisSwitchDimensions[0][1],
				    (cBotXAxisSwitchDimensions[0][2] / 2) - 4])
			      sphere(r=1.5, $fn=100);
			 translate([cBotXAxisSwitchTHOffset,
				    cBotXAxisSwitchDimensions[0][1],
				    (cBotXAxisSwitchDimensions[0][2] / 2) + 4])
			      sphere(r=1.5, $fn=100);
		    }
		    // Carve out some space for the solder pads near the switch.
		    for(i=[-5:5:5]) {
			 hull() {
			      translate([cBotXAxisSwitchDimensions[0][0] - 11,
					 cBotXAxisSwitchDimensions[0][1],
					 (cBotXAxisSwitchDimensions[0][2] / 2) + i])
				   sphere(r=1.4, $fn=100);
			      translate([cBotXAxisSwitchDimensions[0][0] - 7,
					 cBotXAxisSwitchDimensions[0][1],
					 (cBotXAxisSwitchDimensions[0][2] / 2) + i])
				   sphere(r=1.4, $fn=100);
			 }
		    }
		    // Carve out a space for the switch itself.
		    translate([cBotXAxisSwitchDimensions[0][0] - 7,
			       cBotXAxisSwitchDimensions[0][1] -.1,
			       (cBotXAxisSwitchDimensions[0][2] / 2) - 6.65])
			 cube([7,1.4 + .1,13.3]);
	       }
	       // Carve out the mounting holes
	       for(i=[1:1:len(cBotXAxisSwitchDimensions)-1]) {
		    translate([cBotXAxisSwitchDimensions[i][0],
			       cBotXAxisSwitchDimensions[0][1],
			       cBotXAxisSwitchDimensions[i][1]])
			 rotate([-90,0,0])
			 bolt_hole(cBotXAxisSwitchDimensions[i][2],
				   (carriageDepth - cBotXAxisSwitchDepth -
				    cBotXAxisSwitchDimensions[i][4]),
				   cBotXAxisSwitchDimensions[i][3],
				   cBotXAxisSwitchDimensions[i][4]);
	       }	       
	  }
     }

     // Carve out space for the titan mount, if needed.
     if ((realExtruder == "titan" && heSide == true) || (realExtruder == "titan" && heSide == false && extruderStepper != "pancake")) {
	  translate([(heSide == true ? heAnchorL[0] : cBotCarriageWidth - heAnchorL[0]), - carriageDepth - .01, (cBotCarriageHeight + cBotTitanVertOffset)])
	       translate([(heSide == true ? -(nema17OuterOffset + e3dTitanOffset[0]) : - (nema17OuterOffset - e3dTitanOffset[0])),0,0])
	       cube([(nema17OuterOffset * 2) , carriageDepth + .02, (nema17OuterOffset * 2)]);
     }
}

module cbot_belt_cutout() {
     // Belt cutout
     linear_extrude(height=cBotBeltHeight) {
	  for(i=[0 : cBotBeltToothSpacing : (cBotBeltToothLength - cBotBeltToothSpacing)]) {
	       translate([i +.1, 0, 0])
		    polygon([[-cBotBeltToothHeight, - (cBotBeltToothHeight * 2)],[0, 0],[cBotBeltToothSpacing, - (cBotBeltToothHeight * 2)]]);
	       translate([i + .1 + (cBotBeltToothSpacing / 2), 0, 0])
		    polygon([[-cBotBeltToothHeight, - (cBotBeltToothHeight * 2)],[(cBotBeltToothSpacing / 2), 0], [cBotBeltToothSpacing, - (cBotBeltToothHeight * 2)]]);
	  }
	  
	  translate([cBotBeltToothLength + .1, 0, 0])
	       polygon([[0,0],[(cBotBeltLength - cBotBeltToothLength) + .1,-(carriageDepth - cBotBeltDepth + .1)],[-1,-(carriageDepth - cBotBeltDepth)]]);
     }
     
     translate([-.1, - (carriageDepth - cBotBeltDepth +.1), 0])
	  cube([cBotBeltToothLength, (carriageDepth - cBotBeltDepth - cBotBeltToothHeight) + .1, cBotBeltHeight]);
	  
     // Belt holder mounting holes.
     translate([(cBotBeltToothLength / 2), -(carriageDepth - cBotBeltDepth), -cBotBeltScrewDistance])
	  rotate([-90,0,0])
	  bolt_hole(cBotBeltScrewDiameter, carriageDepth - cBotBeltScrewNutDepth, cBotBeltScrewNutDiameter, cBotBeltScrewNutDepth);

     translate([(cBotBeltToothLength / 2), -(carriageDepth - cBotBeltDepth),  cBotBeltHeight + cBotBeltScrewDistance])
	  rotate([-90,0,0])
	  bolt_hole(cBotBeltScrewDiameter, carriageDepth - cBotBeltScrewNutDepth, cBotBeltScrewNutDiameter, cBotBeltScrewNutDepth);
}

module cbot_belt_holder() {
     difference() {
	  // Create the base
	  cbot_belt_holder_base();

	  // Create the holes
	  cbot_belt_holder_holes();
     }
}

module cbot_belt_holder_base() {
     // Create the base object
     translate([cBotBeltHolderCornerRadius, 0, cBotBeltHolderCornerRadius])
	  hull() {
	  // Bottom left
	  rotate([90,0,0])
	       cylinder(r=cBotBeltHolderCornerRadius, h=cBotBeltHolderDepth, $fn=100);

	  // Bottom right
	  translate([cBotBeltToothLength - (cBotBeltHolderCornerRadius * 2), 0, 0])
	       rotate([90,0,0])
	       cylinder(r=cBotBeltHolderCornerRadius, h=cBotBeltHolderDepth, $fn=100);

	  // Top Left
	  translate([0, 0, cBotBeltHolderHeight - (cBotBeltHolderCornerRadius * 2)])
	       rotate([90,0,0])
	       cylinder(r=cBotBeltHolderCornerRadius, h=cBotBeltHolderDepth, $fn=100);

	  // Top right
	  translate([cBotBeltToothLength - (cBotBeltHolderCornerRadius * 2), 0, cBotBeltHolderHeight - (cBotBeltHolderCornerRadius * 2)])
	       rotate([90,0,0])
	       cylinder(r=cBotBeltHolderCornerRadius, h=cBotBeltHolderDepth, $fn=100);
     }

     // Create the nub that holds the belt.
     translate([cBotBeltHolderCornerRadius,
		-cBotBeltHolderDepth + .1,
		(cBotBeltHolderHeight / 2)])
	  hull() {
	  // Bottom left
	  translate([0, 0, - (cBotBeltHolderNubHeight / 2) + cBotBeltHolderCornerRadius])
	       rotate([90, 0, 0])
	       cylinder(r=cBotBeltHolderCornerRadius, h=cBotBeltHolderNubDepth + .1, $fn=100);
		    
	  // Bottom right
	  translate([cBotBeltToothLength - (cBotBeltHolderCornerRadius * 2), 0, - (cBotBeltHolderNubHeight / 2) + cBotBeltHolderCornerRadius])
	       rotate([90, 0, 0])
	       cylinder(r=cBotBeltHolderCornerRadius, h=cBotBeltHolderNubDepth + .1, $fn=100);
		    
	  // Top left
	  translate([0, 0, (cBotBeltHolderNubHeight / 2) - cBotBeltHolderCornerRadius])
	       rotate([90, 0, 0])
	       cylinder(r=cBotBeltHolderCornerRadius, h=cBotBeltHolderNubDepth + .1, $fn=100);
		    
	  // Top right
	  translate([cBotBeltToothLength - (cBotBeltHolderCornerRadius * 2), 0, (cBotBeltHolderNubHeight / 2) - cBotBeltHolderCornerRadius])
	       rotate([90, 0, 0])
	       cylinder(r=cBotBeltHolderCornerRadius, h=cBotBeltHolderNubDepth + .1, $fn=100);
     }
}

module cbot_belt_holder_holes() {
     // Belt holder mounting holes.
     translate([(cBotBeltToothLength / 2),
		+.1,
		(cBotBeltHolderHeight / 2) - ((cBotBeltHeight / 2) + cBotBeltScrewDistance)])
	  rotate([90,0,0])
	  cylinder(d=cBotBeltScrewDiameter, h=cBotBeltHolderDepth + .2, $fn=100);
     
     translate([(cBotBeltToothLength / 2),
		+.1,
		(cBotBeltHolderHeight / 2) + ((cBotBeltHeight / 2) + cBotBeltScrewDistance)])
	  rotate([90,0,0])
	  cylinder(d=cBotBeltScrewDiameter, h=cBotBeltHolderDepth + .2, $fn=100);
}

module cbot_x_bumper() {
     // Small bumper for the carriage mounted X Axis Switch.
     difference() {
	  cube([cBotXBumperWidth, cBotXBumperDepth, cBotXBumperHeight]);
	  
	  translate([cBotXBumperHolePos[0], cBotXBumperDepth + .1, cBotXBumperHolePos[1]])
	       rotate([90,0,0])
	       cylinder(d=cBotCarriageIdlerScrewDiameter, h=cBotXBumperDepth + .2, $fn=100);
     }
}

module e3d_titan_mount() {
     // This creates the mount for the E3D Titan extruder.
     // First create a large cube that is built to the size of the Nema 17 plus e3dTitanMountMat.
     // Then remove the center portion where the Nema 17 will mount and recreate that portion to the specs
     // for the Nema 17.
     // Move everything around so position point is X - center of filament path, Y - face of mount on Titan side.
     translate([-(nema17OuterOffset + e3dTitanOffset[0] + e3dTitanMountMat),0,-1])
	  difference() {
	  hull() {
	       // Lower left corner
	       translate([0, 0, (carriage == "prusai3" ? -prusai3TitanVertOffset : 0)])
		    cube([1, (carriageDepth + heDepthOffset), 1]);
	       
	       // Upper left corner
	       translate([e3dTitanMountCornerRadius,
			  0,
			  (nema17OuterOffset * 2) - e3dTitanMountCornerRadius + 1]) 
		    rotate([-90,0,0])
		    cylinder(r=e3dTitanMountCornerRadius, h=(carriageDepth + heDepthOffset), $fn=100);
	       
	       // Lower right corner
	       translate([((nema17OuterOffset * 2) + (e3dTitanMountMat * 2)) + e3dTitanFilamentSideBodyOffset - 1, 0, (carriage == "prusai3" ? -prusai3TitanVertOffset : 0)])
		    cube([1, (carriageDepth + heDepthOffset), 1]);
	       
	       // Upper right corner
	       translate([(nema17OuterOffset * 2) + (e3dTitanMountMat * 2) + e3dTitanFilamentSideBodyOffset - e3dTitanMountCornerRadius,
			  0,
			  (nema17OuterOffset * 2) - e3dTitanMountCornerRadius + 1])
		    rotate([-90,0,0])
		    cylinder(r=e3dTitanMountCornerRadius, h=(carriageDepth + heDepthOffset), $fn=100);
	  }
     
	  // Now remove the center where the titan and Nema 17 will be.
	  translate([e3dTitanMountMat, -.1, 5])
	       cube([(nema17OuterOffset * 2) + e3dTitanFilamentSideBodyOffset, (carriageDepth + .2), (nema17OuterOffset * 2)]);
     }
     
     // Create the bracing.
     translate([-(nema17OuterOffset + e3dTitanOffset[0] + e3dTitanMountMat),0,-.01]) {
	  // Left side brace
	  hull() {
	       // Lower left base.
	       translate([0, 0, - (e3dTitanMountLowerOverlap + (carriage == "prusai3" ? prusai3TitanVertOffset : 0))])
		    cube([e3dTitanMountBraceWidth, .01, .01]);
	       
	       // Lower left raised.
	       translate([0, -e3dTitanMountBraceHeight + 3,  - (e3dTitanMountLowerOverlap + (carriage == "prusai3" ? prusai3TitanVertOffset : 0)) + 5])
		    rotate([0,90,0])
		    cylinder(r=1.5, h=e3dTitanMountBraceWidth, $fn=100);
	       
	       // Upper left base.
	       translate([0,0,(nema17OuterOffset * 2) - e3dTitanMountCornerRadius - .5])
		    cube([e3dTitanMountBraceWidth, .01, .01]);
	       
	       // Upper left raised.
	       translate([0, -e3dTitanMountBraceHeight + 3, (nema17OuterOffset * 2) - e3dTitanMountCornerRadius - 5.5])
		    rotate([0,90,0])
		    cylinder(r=1.5, h=e3dTitanMountBraceWidth, $fn=100);
	  }

	  // Right side brace
	  hull() {
	       // Lower right base.
	       translate([(nema17OuterOffset * 2) + (e3dTitanMountMat * 2) + e3dTitanFilamentSideBodyOffset - e3dTitanMountBraceWidth,
			  0,- (e3dTitanMountLowerOverlap + (carriage == "prusai3" ? prusai3TitanVertOffset : 0))])
		    cube([e3dTitanMountBraceWidth, .01, .01]);
	       
	       // Lower right raised.
	       translate([(nema17OuterOffset * 2) + (e3dTitanMountMat * 2) + e3dTitanFilamentSideBodyOffset - e3dTitanMountBraceWidth,
			  -e3dTitanMountBraceHeight + 3, - (e3dTitanMountLowerOverlap + (carriage == "prusai3" ? prusai3TitanVertOffset : 0)) + 5])
		    rotate([0,90,0])
		    cylinder(r=1.5, h=e3dTitanMountBraceWidth, $fn=100);
	       
	       // Upper right base.
	       translate([(nema17OuterOffset * 2) + (e3dTitanMountMat * 2) + e3dTitanFilamentSideBodyOffset - e3dTitanMountBraceWidth,
			  0,(nema17OuterOffset * 2) - e3dTitanMountCornerRadius - .5])
		    cube([e3dTitanMountBraceWidth, .01, .01]);
	       
	       // Upper right raised.
	       translate([(nema17OuterOffset * 2) + (e3dTitanMountMat * 2) + e3dTitanFilamentSideBodyOffset - e3dTitanMountBraceWidth,
			  -e3dTitanMountBraceHeight + 3, (nema17OuterOffset * 2) - e3dTitanMountCornerRadius - 5.5])
		    rotate([0,90,0])
		    cylinder(r=1.5, h=e3dTitanMountBraceWidth, $fn=100);
	  }
     }

     // Create the face the Titan and Nema 17 will attach to.
     difference() {
	  translate([-(nema17OuterOffset + e3dTitanOffset[0] + .01), carriageDepth - e3dTitanMountThickness , 0])
	       cube([(nema17OuterOffset * 2) + e3dTitanFilamentSideBodyOffset + .02, e3dTitanMountThickness, (nema17OuterOffset * 2) + .02]);

	  // Carve out the holes for the Nema 17 mount.
	  // First position ourselves in the center of the face. All other offsets
	  // are from center of Nema 17 output shaft.
	  translate([-e3dTitanOffset[0], carriageDepth - e3dTitanMountThickness, nema17OuterOffset]) {
	       for (i= nema17MountHoleLocs) {
		    translate([i[0],-.1,i[1]]) {
			 rotate([-90,0,0])
			      cylinder(d=nema17MountHoleDiameter, h=(e3dTitanMountThickness + .2), $fn=200);
		    }
	       }
	       
	       // Carve out the center for the Nema 17 shaft and center raised portion.
	       translate([0,-.1,0])
		    rotate([-90,-.1,0])
		    cylinder(d=nema17CenterDiameter, h=(e3dTitanMountThickness + .2), $fn=200);
		    }
     }     
}

module bltouch_mount(carriageDepth,cbot=false) {
     // Create the mounting back plate.
     difference() {
	  hull() {
	       // Induct mount top right corner.
	       translate([ probeMountWidth - (probeBraceWidth / 2) - blPlateOuterRadius,
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) + (probeBraceWidth / 2) :
			   probePlateThickness + probeBraceHeight - (probeBraceWidth / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probeBraceWidth, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	       
	       // Induct mount top left corner.
	       translate([ (probeBraceWidth / 2) + blPlateOuterRadius,
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) + (probeBraceWidth / 2) :
			   probePlateThickness + probeBraceHeight - (probeBraceWidth / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probeBraceWidth, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	       
	       // Induct bracket bottom right corner.
	       translate([ probeMountWidth - (probeBraceWidth / 2) - blPlateOuterRadius,
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   (probePlateThickness / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probePlateThickness, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	       
	       // Induct bracket bottom left corner.
	       translate([ (probeBraceWidth / 2) + blPlateOuterRadius,
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   (probePlateThickness / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probePlateThickness, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  }

	  // Create the mounting holes if needed.
	  if (probeMountBracketed == 1) {
	       // Create the mounting screw holes in the bracket and X Carriage back plane.
	       translate([(probeMountWidth / 2),
			  - (probeBracketDepth + .1),
			  cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + cBotAccessoryMountPos :
			  probePlateThickness + (probeBracketScrewDiameter * 1.5)])
		    rotate([-90,0,0])
		    cylinder(d=(cbot == true ? cBotBeltScrewDiameter : probeBracketScrewDiameter), h=probeBracketDepth + .2, $fn=100);
	       
	       translate([(probeMountWidth / 2),
			  - (probeBracketDepth + .1),
			  cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) :
			  probePlateThickness + probeBraceHeight - (probeBracketScrewDiameter * 1.5)])
		    rotate([-90,0,0])
		    cylinder(d=(cbot == true ? cBotBeltScrewDiameter : probeBracketScrewDiameter), h=probeBracketDepth + .2, $fn=100);
	  }
     }
     
     // Create mounting plate
     translate([ (probeMountWidth / 2),
		 -((blPlateRectDimensions[1] / 2) + ( probeMountBracketed == 0 ? 0 : probeBracketDepth) + probeOffset),
		 0])
     difference() {
	  hull() {
	       // Create the mounting plate
	       translate([-(probeMountWidth / 2) + (probeBraceWidth / 2) + blPlateOuterRadius,
			  (blPlateRectDimensions[1] / 2) + probeOffset,
			  (probePlateThickness / 2)])
		    sphere(d=probePlateThickness, $fn=100);

	       translate([(probeMountWidth / 2) - (probeBraceWidth / 2) - blPlateOuterRadius,
			  (blPlateRectDimensions[1] / 2) + probeOffset,
			  (probePlateThickness / 2)])
		    sphere(d=probePlateThickness, $fn=100);
	       
	       translate([-(blPlateRectDimensions[0] / 2), -(blPlateRectDimensions[1] / 2), 0])
		    cube([blPlateRectDimensions[0], blPlateRectDimensions[1], probePlateThickness]);
	       
	       translate([- blPlateInnerDistance, 0, 0])
		    cylinder(r=blPlateOuterRadius, h=probePlateThickness, $fn=100);
	       
	       translate([blPlateInnerDistance, 0, 0])
		    cylinder(r=blPlateOuterRadius, h=probePlateThickness, $fn=100);
	  }

	  // Cut out the center hole
	  translate([0, 0, -.1])
	       cylinder(d=blPlateCenterDiameter, h=(probePlateThickness + .2), $fn=100);

	  // Cut out the outer holes
	  translate([- blPlateInnerDistance, 0, -.1])
	       cylinder(d=blPlateInnerDiameter, h=(probePlateThickness + .2), $fn=100);
	  
	  translate([blPlateInnerDistance, 0, -.1])
	       cylinder(d=blPlateInnerDiameter, h=(probePlateThickness + .2), $fn=100);
     }
     
     // Create braces
     hull() {
	  // Probe mount top right corner.
	       translate([ (probeMountWidth /2) + (blPlateInnerDistance / 2),
		      -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) + (probeBraceWidth / 2) :
			   probePlateThickness + probeBraceHeight - (probeBraceWidth / 2)])
	       rotate([-90,0,0])
	       sphere(d=probeBraceWidth, $fn=100);
	  
	  // Probe mount bottom right corner and forward point.
	  hull() {
	       // Forward point
	       translate([ (probeMountWidth /2) + (blPlateInnerDistance / 2),
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth) - ((blPlateRectDimensions[1] / 2) + probeOffset),
			   (probeBraceWidth / 2)])
		    sphere(d=probeBraceWidth, $fn=100);

	       // Rear point
	       translate([ (probeMountWidth /2) + (blPlateInnerDistance / 2),
				-(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   (probeBraceWidth / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probeBraceWidth, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  }
     }
     
     // Probe mount top left corner.
     hull() {
	       translate([ (probeMountWidth /2) - (blPlateInnerDistance / 2),
		      -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   cbot == true ? -(heAnchorL[2] + heNozzleL[0][2] + probePlateHeight) + (cBotAccessoryMountPos * 2) + (probeBraceWidth / 2) :
			   probePlateThickness + probeBraceHeight - (probeBraceWidth / 2)])
	       rotate([-90,0,0])
	       sphere(d=probeBraceWidth, $fn=100);
	  
	  // Probe mount bottom left corner and forward point.
	  hull() {
	       // Forward point
	       translate([ (probeMountWidth /2) - (blPlateInnerDistance / 2),
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth) - ((blPlateRectDimensions[1] / 2) + probeOffset),
			   (probeBraceWidth / 2)])
		    sphere(d=probeBraceWidth, $fn=100);
	       // Rear point
	       translate([ (probeMountWidth /2) - (blPlateInnerDistance / 2),
			   -(probeMountBracketed == 0 ? 0 : probeBracketDepth),
			   (probeBraceWidth / 2)])
		    rotate([-90,0,0])
		    cylinder(d=probeBraceWidth, h=(probeMountBracketed == 0 ? carriageDepth : probeBracketDepth), $fn=100);
	  }
     }
}
