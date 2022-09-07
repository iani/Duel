/*  7 Sep 2022 11:09
Chat and local evaluation window


*/

\chat.window.view.layout_(
	VLayout(
		Button().states_([["Send: "]])
		.action_({ \chat.changed(\send) }),
		TextField().minHeight_(100).addNotifier(\chat, \send, { | n |
			"sending:".postln;
			n.listener.string.postln;
			OscGroups.broadcast(\chatMessage, n.listener.string);
		}),
		StaticText().string_("Received: "),
		TextField().minHeight_(100),
		Button().states_([["Run locally: "]])
		.action_({ \chat.changed(\runlocally) }),
		TextField().minHeight_(100).addNotifier(\chat, \runlocally, { | n |
			"evaluating locally:".postln;
			n.listener.string.postln;
			OscGroups.runLocally({ n.listener.string.interpret })
		})
	)
);