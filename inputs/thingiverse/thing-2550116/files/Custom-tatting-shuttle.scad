/* 
 * Copyleft 2012 Sergio García-Cuevas González
 * 
 * This work is licensed under the Creative Commons
 * Attribution-ShareAlike 3.0 Unported License.
 * To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/3.0/
 * or send a letter to Creative Commons,
 * 444 Castro Street, Suite 900, Mountain View,
 * California, 94041, USA.
 */

/*
 * Tattting shuttle
 * 
 * This tatting shuttle consists of a couple of streamlined shells
 * enclosing a bobbin.  The shells are separated at theirs tips
 * by a small gap and the bobbin has a hole (the eye) for threading.
 * 
 * There are several geometrical parameters.  All distances are measured
 * in millimeters.
 * 
 *   - shuttle_length: length of the shuttle measured from tip to tip;
 *   - shuttle_height: height of the shuttle;
 *   - shuttle_width: width of the shuttle;
 *   - shell_thickness: thickness of the shells;
 *   - gap: distance between shells at the tips of the shuttle;
 *   - bobbin_width: width of the bobbin;
 *   - bobbin_height: height of the bobbin;
 *   - eye_diameter: diameter of the eye;
 *   - half_model: if true, build just one half of the model.
 */

/* Jon's Notes:
 * First... I love this tatting shuttle design.  I wanted to turn
 * this into a customizer so others could make custom sized bobbins
 * This is not my design, I merely made it better.
 */

/*[Parameters]*/
//Length of the shuttle measured from tip to tip
shuttle_length = 50; 

//Height of the shuttle
shuttle_height = 17; 

//Width of the shuttle
shuttle_width = shuttle_length * (2 - sqrt (3)); 

//Thickness of shell
shell_thickness = 1; 
//Distance between shells at the tips of the shuttle
gap = 0.5; 
//Width of the bobbin (Center)
bobbin_width = 4; 
//Length of bobbin (Center)
bobbin_length = 6; 
//Diameter of the eye hole;
eye_diameter = 4; 

/*[Hidden]*/
half_model = false;
$fn = 0;
$fa = 5;
$fs = 0.1;

intersection ()
{
  /* Planform */
  assign (planform_radius = shuttle_width / 4
                          + shuttle_length * shuttle_length / 4 / shuttle_width)
  {
    intersection ()
    {
      translate (v = [0, -planform_radius + shuttle_width / 2, 0])
      {
        cylinder (r = planform_radius,
                  h = 2 * shuttle_height,
                  center = true);
      }
      translate (v = [0, planform_radius - shuttle_width / 2, 0])
      {
        cylinder (r = planform_radius, h = 2 * shuttle_height, center = true);
      }
    }
  }
  /* Body */
  assign (shell_radius = (shuttle_height - gap) / 4
                       + shuttle_length * shuttle_length
                         / 4 / (shuttle_height - gap))
  {
    union ()
    {
      /* Bobbin */
      intersection ()
      {
        translate (v = [0, 0, -shell_radius - gap / 2 + shuttle_height / 2])
        {
          sphere (r = shell_radius);
        }
        translate (v = [0, 0, shell_radius + gap / 2 - shuttle_height / 2])
        {
          sphere (r = shell_radius);
        }
        difference ()
        {
          scale (v = [bobbin_length, bobbin_width, shuttle_height])
          {
            cylinder (r = 0.5, h = 1, center = true);
          }
          rotate (a = [90, 0, 0])
          {
            cylinder (r = eye_diameter / 2,
                      h = bobbin_width * 2,
                      center = true);
          }
        }
      }
      /* Upper shell */
      intersection ()
      {
        translate (v = [0, 0, -shell_radius + shuttle_height / 2])
        {
          difference ()
          {
            sphere (r = shell_radius);
            sphere (r = shell_radius - shell_thickness);
          }
        }
        translate (v = [-shuttle_length, -shuttle_length, gap / 2])
        {
          cube (size = [2 * shuttle_length,
                        2 * shuttle_length,
                        shuttle_height]);
        }
      }
      /* Lower shell */
      intersection ()
      {
        translate (v = [0, 0, shell_radius - shuttle_height / 2])
        {
          difference ()
          {
            sphere (r = shell_radius);
            sphere (r = shell_radius - shell_thickness);
          }
        }
        translate (v = [-shuttle_length,
                        -shuttle_length,
                        -shuttle_height - gap / 2])
        {
          cube (size = [2 * shuttle_length,
                        2 * shuttle_length,
                        shuttle_height]);
        }
      }
    }
  }
  if (half_model)
  {
    translate (v = [-shuttle_length, 0, -shuttle_height])
    {
      cube (size = [2 * shuttle_length,
                    shuttle_width,
                    2 * shuttle_height]);
    }
  }
  else
  {
    cube (size = [2 * shuttle_length,
                  2 * shuttle_width,
                  2 * shuttle_height],
          center = true);
  }
}
