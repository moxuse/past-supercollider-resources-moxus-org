
(
	s.boot;
	MIDIIn.connect;
	~nodeID=1001;
	s.waitForBoot({var doc, txt;
		"o.k".postln;

		s.sendMsg("/b_allocRead",10,"sounds/soz25_m.wav");
		s.sendMsg("/b_allocRead",30,"sounds/soz29_m.wav");


		SynthDef("orz",{arg pos;
			var trate, dur, src;

			src=Pulse.ar(pos.midicps,0.5,0.4);
			Out.ar(0,src.dup);
		}
		).store;
		SynthDef("takeOff",{arg pos,bufnum=10;
			var trate, dur, src;
			trate =  LinLin.kr(pos,0,102,3,20);
			dur = 4 / trate;
			src=RLPF.ar(TGrains.ar(2, Impulse.ar(trate), bufnum, LinLin.kr(pos,0,102,1,1.75), LinLin.kr(pos,0,102,BufDur.kr(bufnum),120), dur, 0, 1),LinLin.kr(pos,0,102,50,12000));
			Out.ar(0,src);
		}
		).store;


		s.sendMsg(9,"takeOff",1001,0,1,1);

		//midi value mapping
		MIDIIn.noteOff = { arg src, chan, num, vel;

			[chan,num,vel].postln;
			s.sendMsg("/n_set",~nodeID,"pos",num);

			 };

		//document keybord in

		doc = Document.current;
		doc.keyDownAction_({
			 arg view,char,modifiers,unicode,keycode;

			if( unicode == 97,{
				"soz20.aif".postln;
				if( ~nodeID == 1002,{
				s.sendMsg( "/s_new", "takeOff", 1001, 4, 1002);
				~nodeID=1001;
				});
				s.sendMsg("/n_set",1001,"bufnum",10);
				});
			if( unicode == 115,{
				s.sendMsg( "/s_new", "orz", 1002, 4, 1001);
				~nodeID=1002;
			});
			if( unicode == 100,{
				if( ~nodeID == 1002,{
				s.sendMsg( "/s_new", "takeOff", 1001, 4, 1002);
				~nodeID=1001;
				});
				"soz14.wav".postln;
				s.sendMsg("/n_set",1001,"bufnum",30);
			});

		});

	});
sd)

s.sendMsg("/g_freeAll",1);MIDIIn.disconnect;







































