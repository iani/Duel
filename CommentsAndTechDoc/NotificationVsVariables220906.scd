
\something.changed(\whatAspectChanged, text .... more stuff);

notif.notifier // the notifier that chnaged
notif.listener // the listener that reacts
//
~turnTxt.addNotifier(\duel, \turnText, { |notif, value|
	notif.listener.string = value;
})
// is the same as
~turnTxt.addNotifier(\duel, \turnText, { |notif, value|
	~turnTxt.string = value;
})
// in this case
notif.listener == ~turnTxt

// Long code (variables are a disadvantage and should be kept to minimum)
~button = Button();
~button.states_([
					["Disable OscGroups"],
					["Enable OscGroups"]
				])
~button.action_({ | me |
					myself.perform([
						\enable,
						\disable
					][me.value]);
				})
~button.addNotifier(this, \status, { | n |
					// "Checking OscGroups gui status button".postln;
					// n.notifier.postln;
			postf(
				"osc groups enabled? %\n",
			OscGroups.isEnabled
					);
					if (OscGroups.isEnabled) {
						~button.value = 0
					}{
						~button.value = 1
					}
				}),

// SHORT CODE == BETTER
// NO variables !!!!
	Button()
				.states_([
					["Disable OscGroups"],
					["Enable OscGroups"]
				])
				.action_({ | me |
					myself.perform([
						\enable,
						\disable
					][me.value]);
				})
				.addNotifier(this, \status, { | n |
					// "Checking OscGroups gui status button".postln;
					// n.notifier.postln;
					postf(
						"osc groups enabled? %\n",
						n.notifier.isEnabled
					);
					if (n.notifier.isEnabled) {
						n.listener.value = 0
					}{
						n.listener.value = 1
					}
				}),
