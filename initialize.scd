~chef = 1;		// Start the game from Chef X (0) or Y (1)
~round = 0;
OscGroups.enable;
//:
{
	Server.default waitForBoot: {
		SenseData().setxyz(1, 2, 3, 4, 5, 6, 7, 8);
		Duel.controlBusMonitor;
		Server.default.record;
	}
}.defer(1.0); 