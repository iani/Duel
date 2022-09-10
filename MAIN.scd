Project.gui;

Duel.initialize;

// NOTE: It is not needed to disable OscGroups any more.
// Any player can initiate Duel.newgame.
// This is broadcast to all other players.
// So to start a new game ONLY ONE USER NEEDS TO RUN Duel.newgame.
Duel.newgame;


/* Executing tactics */

~tactic.(0, {{ Pan2.ar(Dust.ar(20), -0.7) } +> \phoenix });
~tactic.(1, {{ Pan2.ar(SinOsc.ar(LFNoise0.ar(50, 100)), -0.7) } +> \phoenix });
~tactic.(2, {{ Pan2.ar(PinkNoise.ar(0.1), -0.7) } +> \phoenix });
~tactic.(3, {{ Pan2.ar(SinOsc.ar(10000, 0, LFPulse.ar(1, 0, 0.01)), -0.7) } +> \phoenix });
~tactic.(4, {{ Pan2.ar(SinOsc.ar(LFPulse.ar(20, 0, 0.5, 100, 50), 0, 0.2), -0.7) } +> \phoenix });
~tactic.(5, {{ } +> \phoenix });

\phoenix.stop(5);

~tactic.(0, {{ Pan2.ar(Dust.ar(20), 0.7) } +> \albatross });
~tactic.(1, {{ Pan2.ar(SinOsc.ar(LFNoise0.ar(50, 100)), 0.7) } +> \albatross });
~tactic.(2, {{ Pan2.ar(PinkNoise.ar(0.1), 0.7) } +> \albatross });
~tactic.(3, {{ Pan2.ar(SinOsc.ar(10000, 0, LFPulse.ar(1, 0, 0.01)), 0.7) } +> \albatross });
~tactic.(4, {{ Pan2.ar(SinOsc.ar(LFPulse.ar(20, 0, 0.5, 100, 50), 0, 0.2), 0.7) } +> \albatross });
~tactic.(5, {{ } +> \albatross });

\albatross.stop(5);

//: FOR THE END


Server.killAll;