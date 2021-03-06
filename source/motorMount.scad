include <shapes.scad>
include <configuration.scad>

module MotorBody(MotorH = 50, MotorW = 42){
	translate([0,0,MotorH/2])
		intersection(){
			cube([MotorW*1.285,MotorW*1.285,MotorH],center=true);
			rotate([0,0,45])
				cube([MotorW,MotorW,MotorH],center=true);
		}

}

module Motor(MotorH = 50, MotorW = 42) {
    rotate([0,0,45])MotorBody(MotorH = MotorH, MotorW = MotorW);
    translate([0,0,MotorH])cylinder(d=22, h=1);
    translate([0,0,MotorH])cylinder(d=5, h=22);
}

module MotorMount(Height = 50, Mheight = 48){

	if (Height < Mheight+2)
	{
		echo ("Help");
	}	
	
	rotate([0,90,0])
	{
		difference(){
			
			union() {
				MotorBody(Height + 4, 44+10);
                // base plates
                hull() {
				translate([0,28,0])
					cylinder(r=20,h=4);
				translate([0,-28,0])
					cylinder(r=20,h=4);
                }
                // Support structure
				intersection(){
                    support_width = 3;
					union(){
                        // Not printable
//						translate([10,-32,25])
//							rotate([0,0,-45])
//								cube([13,support_width,50],center=true);
//						translate([10,32,25])
//							rotate([0,0,45])
//								cube([13,support_width,50],center=true);
						mirror()
				  			translate([10,-32,25])
								rotate([0,0,-45])
									cube([13,support_width,50],center=true);
		
						mirror()
				  			translate([10,32,25])
								rotate([0,0,45])
									cube([13,support_width,50],center=true);
					}

					cylinder(r1=40, r2=29, h=50);
				}

			}
			translate([0,0,0])MotorBody(Height, 44);
            // slice bottom off
			translate([65,0,25])cube([100,100,100],center=true);
            // slice top off
			translate([-78,0,25])cube([100,100,100],center=true);
            // Motor screw holes
            for (a=[0:90:180]) {
                rotate([0,0,a])translate([0,22,Height - 5])cylinder(h=10,d=m3_dia);
            }
            // Mount screw hole
			translate([0,-40, 0])cylinder(h=10,d=m3_dia);
            // mount screw slot
            rotate([0,0,90])translate([0,0,-1])linear_extrude(6)arc(w=m3_dia, r=40, angle=27);
            // Motor center opening
			translate([0,0,Height - 5])cylinder(h=10,d=23);
			
            // Take edges off large opening
			translate([15,0,Height/2])cube([10,37,Height],center=true);
           // Take edged off small opening
			translate([-30,0,Height/2])cube([10,10,Height],center=true);

		}
	} 

}

//Motor();
//$fa=3;
//$fs=0.3;
//MotorMount(Height=50);
//mirror()MotorMount(Height=70);