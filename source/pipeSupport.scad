include <shapes.scad>
include <configuration.scad>
include <MCAD/teardrop.scad>


module pipeSupport(PipeID = 26, PipeOD = 32, target_x = 0, target_y = 0, target_z=1, pipe = false, port = false){

    pipeLength = 420;
	distance = sqrt (pow(target_x,2)+pow(target_y,2)+pow(target_z,2));
    base_distance = sqrt (pow(target_x,2)+pow(target_y,2));
	echo ("Distance: ", distance);
    base_height = (distance-pipeLength)/2;
	
	angle = asin ( base_distance / distance);
    dir_angle = atan2(target_x, target_x);
    echo("Angle: ", angle, "dir_angle: ", dir_angle);
 
	difference(){
		union(){
            // bottom
			cylinder(r=(PipeID+2)/2, h=6);
			rotate([0,0,dir_angle])rotate([0,angle,0])translate([0,0,base_height]){
				
				difference(){
					union(){
                        // base
						translate([0,0,-30])cylinder(r=(PipeOD)/2, h=30);
					
					// shaft body
						cylinder(r=(PipeID)/2, h=35);
						translate([0,0,35])
							cylinder(r1 = (PipeID)/2, r2=PipeID/2-1, h=3);	

					// Rib anchor
						translate([0,0,30])
							rotate_extrude(convexity = 10)
								translate([(PipeID)/2-1.5,0,0])
									circle(r=2);	

							translate([0,0,15])
							rotate_extrude(convexity = 10)
								translate([(PipeID)/2-1.5,0,0])
									circle(r=2);	
						
					}
					translate([0,0,-30])
						cylinder(r=(PipeID-5)/2, h=75); 
				}
				
			}
		}
			
		
		// m4 trapped nut
		translate([0,0,3])
			cylinder(d=m4_nut_dia, h=16, $fn=6);
			
		// M4 bolt	
		cylinder(d=m4_dia,h=10);
        
        // slice off bottom
		translate([0,0,-40])
			cylinder(r= PipeOD, h=40);

		if (port == true){
			translate([0,0,0])
				rotate([0,0,225])
					translate([PipeID/2,0,base_height-5])
						teardrop(5, PipeID, 90);
						

		}
		
	}

	if (pipe == true){
		rotate([0,0,dir_angle])rotate([0,angle,0])
			translate([0,0,base_height])
			%cylinder(r=PipeOD/2, h=pipeLength);
	}

}

module pipeSupportLong() {
    pipeSupport(PipeID = PVC_pipe_ID-0.8, PipeOD = PVC_pipe_OD, target_x = 130, target_y = 130, target_z=420, pipe = false, port = true);
}

module pipeSupportShort() {
    pipeSupport(PVC_pipe_ID-0.8, PipeOD = PVC_pipe_OD, target_x = 0, target_y = 160, target_z=420, pipe = false, port = false);
}

//pipeSupportShort();
//translate([160,0,420])rotate([0,0,180])mirror([0,0,1])pipeSupport(PVC_pipe_ID-0.8, PipeOD = PVC_pipe_OD, target_x = 0, target_y = 160, target_z=420, pipe = true, port = false);
//
//pipeSupportLong();
//translate([130,130,420])rotate([0,0,180])mirror([0,0,1])pipeSupport(PipeID = PVC_pipe_ID-0.8, PipeOD = PVC_pipe_OD, target_x = 130, target_y = 130, target_z=420, pipe = true, port = true);
