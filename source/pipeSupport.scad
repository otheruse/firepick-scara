include <shapes.scad>
include <configuration.scad>
include <MCAD/teardrop.scad>


module pipeSupport(PipeID = 26, PipeOD = 32, target_x = 0, target_y = 0, target_z=1, pipe = false, port = false){

	PipeLength = sqrt (pow(target_x,2)+pow(target_y,2)+pow(target_z,2));
	echo (PipeLength);
	//hyp = sqrt( pow(target_x,2) + pow(target_z,2));
	//echo(hyp);
	

	deg_x = asin ( target_x / PipeLength);
	deg_y = -asin ( target_y / PipeLength) ;

	difference(){
		union(){
            // bottom
			cylinder(r=(PipeID+2)/2, h=5, $fn = 100);
			rotate([deg_y,deg_x,0]){
				
				difference(){
					union(){
                        // base
						translate([0,0,-10])cylinder(r=(PipeOD)/2, h=20);
					
					// shaft body
						cylinder(r=(PipeID)/2, h=35);
						translate([0,0,35])
							cylinder(r1 = (PipeID)/2, r2=PipeID/2-1, h=3);	

					// Rib anchor
						translate([0,0,30])
							rotate_extrude(convexity = 10, $fn = 100)
								translate([(PipeID)/2-1.5,0,0])
									circle(r=2, $fn = 20);	

							translate([0,0,15])
							rotate_extrude(convexity = 10, $fn = 100)
								translate([(PipeID)/2-1.5,0,0])
									circle(r=2, $fn = 20);	
						
					}
					translate([0,0,-5])
						cylinder(r=(PipeID-5)/2, h=45, $fn=100); 
				}
				
			}
		}
			
		
		// m4 trapped nut
		translate([0,0,3])
			cylinder(d=m4_nut_dia, h=5, $fn=6);
			
		// M4 bolt	
		cylinder(d=m4_dia,h=10, $fn = 20);
        
        // slice off bottom
		translate([0,0,-10])
			cylinder(r= PipeID, h=20, center = true);

		if (port == true){
			translate([0,0,0])
				rotate([0,0,225])
					translate([PipeID/2,0,6])
						teardrop(5, PipeID/1.8, 90);
						

		}
		
	}

	if (pipe == true){
		rotate([deg_y, deg_x, 0])
			translate([0,0,10])
			%cylinder(r=PipeOD/2, h=PipeLength-20);
	}

}

module pipeSupportLong() {
    pipeSupport(PipeID = PVC_pipe_ID-1, PipeOD = PVC_pipe_OD, target_x = 130, target_y = 130, target_z=420, pipe = false, port = true);
}

module pipeSupportShort() {
    pipeSupport(PVC_pipe_ID-1, PipeOD = PVC_pipe_OD, target_x = 70, target_y = 150, target_z=420, pipe = false, port = false);
}
