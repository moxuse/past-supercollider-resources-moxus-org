// Mon Oct  2 16:13:31 2006


// inaf ______ 16:14:21.845 ________________________________________________

~publicout = {
	Klank.ar(`[Array.series(5,100,20),nil,Array.rand(5,0,1,0.1)],WhiteNoise.ar(0.1)*0.01)
	};


// kubota ______ 16:14:30.5649 ________________________________________________

~publicout = { Impulse.ar([1100, 1110], 0, 0.1) };


// mori ______ 16:16:1.1062 ________________________________________________

~out = { SinOsc.ar([1100, 1010], 0, 0.1) };


// kubota ______ 16:16:48.9249 ________________________________________________

~publicout = { StandardL.ar(SampleRate.ir * StandardL.ar(SampleRate.ir), MouseX.kr(0.8, 1.2), mul:0.1) ! 2 };


// kubota ______ 16:17:43.6847 ________________________________________________

~publicout = { AudioIn.ar(1) };


// kubota ______ 16:17:48.5323 ________________________________________________

~publicout = { AudioIn.ar(1.5) };


// inaf ______ 16:18:4.4845 ________________________________________________

~publicout = {Crackle.ar(TExpRand.ar(0.1,1.8,Impulse.ar(10)),mul:0.5)};


// inaf ______ 16:18:39.7709 ________________________________________________

~publicout = {Crackle.ar(TExpRand.ar(0.1,1.8,Impulse.ar(10)),mul:0.5)};


// kubota ______ 16:19:19.1649 ________________________________________________

~publicout = { FBSineL.ar(SampleRate.ir, 1, MouseX.kr(0, 2), 1, 1, mul:0.1) ! 2};


// mori ______ 16:19:55.7852 ________________________________________________

~out = { SinOsc.ar([1100, 1010], 0, 0.1) };


// kubota ______ 16:21:5.6271 ________________________________________________

~publicout = NodeProxy.new;


// kubota ______ 16:21:45.5863 ________________________________________________

~publicout = { StandardL.ar(SampleRate.ir * StandardL.ar(SampleRate.ir), MouseX.kr(0.8, 1.2), mul:0.1) ! 2 };


// mori ______ 16:21:49.7582 ________________________________________________

~out = { SinOsc.ar([1100, 1010], 0, 0.1) };


// inaf ______ 16:22:2.2055 ________________________________________________

~publicout = NodeProxy.new;


// inaf ______ 16:22:10.6319 ________________________________________________

~publicout = NodeProxy.new;


// inaf ______ 16:22:30.6638 ________________________________________________

~publicout = NodeProxy.new;


// inaf ______ 16:22:33.5038 ________________________________________________

~publicout = NodeProxy.new;


// kubota ______ 16:22:37.4318 ________________________________________________

~publicout = NodeProxy.new;


// inaf ______ 16:22:39.6438 ________________________________________________

~publicout = NodeProxy.new;


// mori ______ 16:22:51.4495 ________________________________________________

~out = { SinOsc.ar([1100, 1010], 0, 0.3) };


// mori ______ 16:22:55.5174 ________________________________________________

~out = { SinOsc.ar([12100, 13010], 0, 0.3) };


// kubota ______ 16:24:29.4635 ________________________________________________

~publicout = { Impulse.ar([1100, 1110], 0, 0.1) };


// kubota ______ 16:25:32.0641 ________________________________________________

~publicout = { FBSineL.ar(SampleRate.ir, 1, 2, 1, 1, mul:0.1) ! 2};


// inaf ______ 16:27:26.7037 ________________________________________________

~fg2 = {EnvGen.kr(Env.perc,Impulse.kr(1),doneAction:1)*SinOsc.ar([50,50],mul:0.5)};


// mori ______ 16:27:44.8578 ________________________________________________

~publicout = {
	Klank.ar(`[Array.series(5,100,20),nil,Array.rand(5,0,1,0.1)],WhiteNoise.ar(0.1)*0.01)
	};


// inaf ______ 16:28:2.4055 ________________________________________________

~publicout = {EnvGen.kr(Env.perc,Impulse.kr(1),doneAction:1)*SinOsc.ar([50,50],mul:0.5)};


// kubota ______ 16:29:7.3829 ________________________________________________

~publicout = { QuadN.ar(SampleRate.ir - (r[¥publicout].ar.abs * 1000), [LFNoise1.ar(100, 0.01, 3.58), LFNoise1.ar(100, 0.01, 3.58)].neg, [LFNoise1.ar(100, 0.01, 3.58), LFNoise1.ar(100, 0.01, 3.58)], 0, [1.0, 1.0].rand) };



// inaf ______ 16:29:8.3522 ________________________________________________

~publicout = {|freq=10,amp=0.5,lv=0.01,hv=2,prate=10|
        var ss,sn;
        ss=Crackle.ar(TExpRand.ar(lv,hv,Impulse.ar(freq))).clip(-1,1);
        sn=DelayN.ar(ss*(-1),1,prate/(Server.local.sampleRate));
        (BPF.ar(sn+ss,2000,0.1,8))*[amp,amp];
        };


// kubota ______ 16:29:28.7509 ________________________________________________

~publicout = { QuadN.ar(SampleRate.ir - (q[¥publicout].ar.abs * 1000), [LFNoise1.ar(100, 0.01, 3.58), LFNoise1.ar(100, 0.01, 3.58)].neg, [LFNoise1.ar(100, 0.01, 3.58), LFNoise1.ar(100, 0.01, 3.58)], 0, [1.0, 1.0].rand) };


// mori ______ 16:30:13.9298 ________________________________________________

~out = {Impulse.ar(12,0,1)};


// kubota ______ 16:30:18.0027 ________________________________________________

~publicout = { FBSineL.ar(SampleRate.ir, 1, 2, 1, 1, mul:0.1) ! 2};


// kubota ______ 16:32:1.2423 ________________________________________________

~publicout = { FBSineL.ar(SampleRate.ir, 1, 2, 1, 1, mul:0.1) ! 2};


// kubota ______ 16:32:19.3026 ________________________________________________

~publicout = NodeProxy.new;


// kubota ______ 16:33:33.5625 ________________________________________________

~publicout = {AllpassC.ar(p[¥publicout],0.5,{[0.2.rand,0.2.rand]},0.02)};


// kubota ______ 16:33:43.1841 ________________________________________________

~publicout = {AllpassC.ar(q[¥publicout],0.5,{[0.2.rand,0.2.rand]},0.02)};


// kubota ______ 16:34:7.642 ________________________________________________

~publicout = { Impulse.ar([1100, 1110], 0, 0.1) };


// kubota ______ 16:34:14.082 ________________________________________________

~publicout = { HenonN.ar(SampleRate.ir, MouseX.kr(1.2, 1.4), MouseY.kr(0.2, 0.3), mul:0.1) ! 2 };


// inaf ______ 16:35:10.0825 ________________________________________________

~publicout = {|freq=1000,amp=0.08,scale=1|
	Klank.ar(`[Array.series(5,400,50),nil,Array.rand(5,0.1,0.5)],
	LFNoise2.ar(freq,mul:0.1),scale)*amp;
	};


// kubota ______ 16:35:30.9618 ________________________________________________

~publicout = { FBSineL.ar(SampleRate.ir, 1, 2, 1, 1, mul:0.1) ! 2};


// kubota ______ 16:36:51.4225 ________________________________________________

~publicout = { QuadN.ar(SampleRate.ir - (q[¥publicout].ar.abs * 1000), [LFNoise1.ar(100, 0.01, 3.58), LFNoise1.ar(100, 0.01, 3.58)].neg, [LFNoise1.ar(100, 0.01, 3.58), LFNoise1.ar(100, 0.01, 3.58)], 0, [1.0, 1.0].rand) };


// inaf ______ 16:37:16.9615 ________________________________________________

~publicout = {|freq=1000,amp=0.08,scale=1|
	Klank.ar(`[Array.series(5,400,50),nil,Array.rand(5,0.1,0.5)],
	p[¥publicout].ar(1)*0.05,scale)*amp;
	};


// inaf ______ 16:37:24.007 ________________________________________________

~publicout = {|freq=1000,amp=0.08,scale=1|
	Klank.ar(`[Array.series(5,400,50),nil,Array.rand(5,0.1,0.5)],
	p[¥publicout].ar(1)*0.1,scale)*amp;
	};


// inaf ______ 16:37:32.0261 ________________________________________________

~publicout = {|freq=1000,amp=0.08,scale=1|
	Klank.ar(`[Array.series(5,400,50),nil,Array.rand(5,0.1,0.5)],
	p[¥publicout].ar(1)*0.05,scale)*amp;
	};


// kubota ______ 16:37:50.9442 ________________________________________________

~publicout = { AudioIn.ar(1.5) };


// inaf ______ 16:38:19.8041 ________________________________________________

~publicout = {|freq=1000,amp=0.08,scale=1|
	Klank.ar(`[Array.series(5,400,50),nil,Array.rand(5,0.1,0.5)],
	p[¥publicout].ar(1)*0.05,scale)*amp;
	};

