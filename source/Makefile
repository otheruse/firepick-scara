OPENSCAD:=$(shell which openscad)
TARGET=../stl
DXFTARGET=../dxf

OPENSCAD_SETTINGS=$$fa=2;$$fs=0.3;

EXTRAS=configuration.scad shapes.scad

FILES3D=driveWheelRod.stl driveWheelTube.stl motorMountShort.stl motorMountLong.stl limitSwitchMountL.stl limitSwitchMountP.stl pipeSupportLong.stl pipeSupportShort.stl BearingAdaptor.stl ZMountBottom.stl ZMountTop.stl BedArm.stl ZMountBracket.stl BearingScrew.stl ArmPsiA.stl ArmPsiB.stl ArmThetaA.stl ArmThetaB.stl ShaftCoupling.stl Arm1.stl Arm2.stl ElbowNutSpacer.stl BowdenAdapter.stl ExtruderMount.stl

FILES2D=HeatbedMount.dxf

STLPARTS=$(join $(addsuffix $(TARGET)/, $(dir $(FILES3D))), $(notdir $(FILES3D))) 
DXFPARTS=$(join $(addsuffix $(DXFTARGET)/, $(dir $(FILES2D))), $(notdir $(FILES2D))) 


TARGETS=$(STLPARTS) $(DXFPARTS)

parts : $(TARGET) $(TARGETS)

$(TARGET)/driveWheelRod.stl: driveWheel.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);beltWheelRod(wheel_radius = 75);' $<

$(TARGET)/driveWheelTube.stl: driveWheel.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);beltWheelTube(wheel_radius = 75);' $<

$(TARGET)/motorMountShort.stl: motorMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);MotorMount(Height=50);' $<

$(TARGET)/motorMountLong.stl: motorMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);mirror()MotorMount(Height=70);' $<

$(TARGET)/limitSwitchMountL.stl: limitSwitchHolder.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);limitSwitchHolderL(rod_dia = rod_diameter);' $<

$(TARGET)/limitSwitchMountP.stl: limitSwitchHolder.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);limitSwitchHolderP(rod_dia = rod_diameter);' $<

$(TARGET)/pipeSupportLong.stl: pipeSupport.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);pipeSupportLong();' $<

$(TARGET)/pipeSupportShort.stl: pipeSupport.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);pipeSupportShort();' $<

$(TARGET)/BearingAdaptor.stl: BearingAdaptor.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);BearingAdaptor();' $<

$(TARGET)/ZMountBottom.stl: ZMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ZMountBottom(rodspacing=rodspacing, rodsize = boltDia(rod_diameter));' $<

$(TARGET)/ZMountTop.stl: ZMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ZMountTop(rodspacing=rodspacing, rodsize = boltDia(rod_diameter));' $<

$(TARGET)/BedArm.stl: BedArm.scad BearingMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);BedArm(bearing_diameter = bearing_diameter, bearing_length = bearing_length);' $<

$(TARGET)/ZMountBracket.stl: BedStabilizerBracket.scad BearingMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ZMountBracket(bearing_diameter = bearing_diameter, bearing_length = bearing_length);' $<

$(TARGET)/BearingScrew.stl: BearingScrew.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);BearingScrew(lead = 8);' $<

$(TARGET)/ArmPsiA.stl: ArmPsi.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ArmPsiA();' $<

$(TARGET)/ArmPsiB.stl: ArmPsi.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ArmPsiB();' $<

$(TARGET)/ArmThetaA.stl: ArmTheta.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ArmThetaA();' $<

$(TARGET)/ArmThetaB.stl: ArmTheta.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ArmThetaB();' $<

$(TARGET)/ShaftCoupling.stl: ShaftCoupling.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ShaftCoupling(axis1_dia = drive_rod_diameter, axis2_dia = 5);' $<

$(TARGET)/Arm1.stl: Arms.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);Arm1(arm_length = arm1_length, connector_length = connector_length, connector_dia = Drive_pipe_OD + 12);' $<

$(TARGET)/Arm2.stl: Arms.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);Arm2(arm_length = arm2_length);' $<

$(TARGET)/ElbowNutSpacer.stl: Arms.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ElbowNutSpacer();' $<

$(TARGET)/BowdenAdapter.stl: ExtruderMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);BowdenAdapter();' $<

$(TARGET)/ExtruderMount.stl: ExtruderMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ExtruderMount(base_thickness = baseplate_thickness);' $<

$(DXFTARGET)/HeatbedMount.dxf: BedMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);HeatbedMount();' $<


#assembly: $(TARGET) $(TARGET)/assembly.stl

all: parts assembly


$(TARGET) :
	mkdir -p $(TARGET)

$(DXFTARGET) :
	mkdir -p $(TARGET)

#$(TARGET)/%.stl : %.scad $(EXTRAS)
#	@echo "Processing $@"
#	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);$(subst $(TARGET)/,,$(subst .stl,();,$@))' $<


clean :
	rm -f $(TARGETS) $(TARGET)/assembly.stl

