declare module "imba_css" {
	interface css$color {
		/** The current color */
		current: 'current';
		/** Clear */
		transparent: 'transparent';
		/** Clear */
		clear: 'clear';
		/** @color hsla(0,0%,0%,1) */
		black: 'hsla(0,0%,0%,1)';
		/** @color hsla(0,0%,100%,1) */
		white: 'hsla(0,0%,100%,1)';
		/** @color hsla(355,100%,97%,1) */
		rose0: 'hsla(355,100%,97%,1)';
		/** @color hsla(355,100%,94%,1) */
		rose1: 'hsla(355,100%,94%,1)';
		/** @color hsla(352,96%,90%,1) */
		rose2: 'hsla(352,96%,90%,1)';
		/** @color hsla(352,95%,81%,1) */
		rose3: 'hsla(352,95%,81%,1)';
		/** @color hsla(351,94%,71%,1) */
		rose4: 'hsla(351,94%,71%,1)';
		/** @color hsla(349,89%,60%,1) */
		rose5: 'hsla(349,89%,60%,1)';
		/** @color hsla(346,77%,49%,1) */
		rose6: 'hsla(346,77%,49%,1)';
		/** @color hsla(345,82%,40%,1) */
		rose7: 'hsla(345,82%,40%,1)';
		/** @color hsla(343,79%,34%,1) */
		rose8: 'hsla(343,79%,34%,1)';
		/** @color hsla(341,75%,30%,1) */
		rose9: 'hsla(341,75%,30%,1)';
		/** @color hsla(327,73%,97%,1) */
		pink0: 'hsla(327,73%,97%,1)';
		/** @color hsla(325,77%,94%,1) */
		pink1: 'hsla(325,77%,94%,1)';
		/** @color hsla(325,84%,89%,1) */
		pink2: 'hsla(325,84%,89%,1)';
		/** @color hsla(327,87%,81%,1) */
		pink3: 'hsla(327,87%,81%,1)';
		/** @color hsla(328,85%,70%,1) */
		pink4: 'hsla(328,85%,70%,1)';
		/** @color hsla(330,81%,60%,1) */
		pink5: 'hsla(330,81%,60%,1)';
		/** @color hsla(333,71%,50%,1) */
		pink6: 'hsla(333,71%,50%,1)';
		/** @color hsla(335,77%,41%,1) */
		pink7: 'hsla(335,77%,41%,1)';
		/** @color hsla(335,74%,35%,1) */
		pink8: 'hsla(335,74%,35%,1)';
		/** @color hsla(335,69%,30%,1) */
		pink9: 'hsla(335,69%,30%,1)';
		/** @color hsla(289,100%,97%,1) */
		fuchsia0: 'hsla(289,100%,97%,1)';
		/** @color hsla(286,100%,95%,1) */
		fuchsia1: 'hsla(286,100%,95%,1)';
		/** @color hsla(288,95%,90%,1) */
		fuchsia2: 'hsla(288,95%,90%,1)';
		/** @color hsla(291,93%,82%,1) */
		fuchsia3: 'hsla(291,93%,82%,1)';
		/** @color hsla(292,91%,72%,1) */
		fuchsia4: 'hsla(292,91%,72%,1)';
		/** @color hsla(292,84%,60%,1) */
		fuchsia5: 'hsla(292,84%,60%,1)';
		/** @color hsla(293,69%,48%,1) */
		fuchsia6: 'hsla(293,69%,48%,1)';
		/** @color hsla(294,72%,39%,1) */
		fuchsia7: 'hsla(294,72%,39%,1)';
		/** @color hsla(295,70%,32%,1) */
		fuchsia8: 'hsla(295,70%,32%,1)';
		/** @color hsla(296,63%,28%,1) */
		fuchsia9: 'hsla(296,63%,28%,1)';
		/** @color hsla(269,100%,98%,1) */
		purple0: 'hsla(269,100%,98%,1)';
		/** @color hsla(268,100%,95%,1) */
		purple1: 'hsla(268,100%,95%,1)';
		/** @color hsla(268,100%,91%,1) */
		purple2: 'hsla(268,100%,91%,1)';
		/** @color hsla(269,97%,85%,1) */
		purple3: 'hsla(269,97%,85%,1)';
		/** @color hsla(270,95%,75%,1) */
		purple4: 'hsla(270,95%,75%,1)';
		/** @color hsla(270,91%,65%,1) */
		purple5: 'hsla(270,91%,65%,1)';
		/** @color hsla(271,81%,55%,1) */
		purple6: 'hsla(271,81%,55%,1)';
		/** @color hsla(272,71%,47%,1) */
		purple7: 'hsla(272,71%,47%,1)';
		/** @color hsla(272,67%,39%,1) */
		purple8: 'hsla(272,67%,39%,1)';
		/** @color hsla(273,65%,31%,1) */
		purple9: 'hsla(273,65%,31%,1)';
		/** @color hsla(250,100%,97%,1) */
		violet0: 'hsla(250,100%,97%,1)';
		/** @color hsla(251,91%,95%,1) */
		violet1: 'hsla(251,91%,95%,1)';
		/** @color hsla(250,95%,91%,1) */
		violet2: 'hsla(250,95%,91%,1)';
		/** @color hsla(252,94%,85%,1) */
		violet3: 'hsla(252,94%,85%,1)';
		/** @color hsla(255,91%,76%,1) */
		violet4: 'hsla(255,91%,76%,1)';
		/** @color hsla(258,89%,66%,1) */
		violet5: 'hsla(258,89%,66%,1)';
		/** @color hsla(262,83%,57%,1) */
		violet6: 'hsla(262,83%,57%,1)';
		/** @color hsla(263,69%,50%,1) */
		violet7: 'hsla(263,69%,50%,1)';
		/** @color hsla(263,69%,42%,1) */
		violet8: 'hsla(263,69%,42%,1)';
		/** @color hsla(263,67%,34%,1) */
		violet9: 'hsla(263,67%,34%,1)';
		/** @color hsla(225,100%,96%,1) */
		indigo0: 'hsla(225,100%,96%,1)';
		/** @color hsla(226,100%,93%,1) */
		indigo1: 'hsla(226,100%,93%,1)';
		/** @color hsla(228,96%,88%,1) */
		indigo2: 'hsla(228,96%,88%,1)';
		/** @color hsla(229,93%,81%,1) */
		indigo3: 'hsla(229,93%,81%,1)';
		/** @color hsla(234,89%,73%,1) */
		indigo4: 'hsla(234,89%,73%,1)';
		/** @color hsla(238,83%,66%,1) */
		indigo5: 'hsla(238,83%,66%,1)';
		/** @color hsla(243,75%,58%,1) */
		indigo6: 'hsla(243,75%,58%,1)';
		/** @color hsla(244,57%,50%,1) */
		indigo7: 'hsla(244,57%,50%,1)';
		/** @color hsla(243,54%,41%,1) */
		indigo8: 'hsla(243,54%,41%,1)';
		/** @color hsla(242,47%,34%,1) */
		indigo9: 'hsla(242,47%,34%,1)';
		/** @color hsla(213,100%,96%,1) */
		blue0: 'hsla(213,100%,96%,1)';
		/** @color hsla(214,94%,92%,1) */
		blue1: 'hsla(214,94%,92%,1)';
		/** @color hsla(213,96%,87%,1) */
		blue2: 'hsla(213,96%,87%,1)';
		/** @color hsla(211,96%,78%,1) */
		blue3: 'hsla(211,96%,78%,1)';
		/** @color hsla(213,93%,67%,1) */
		blue4: 'hsla(213,93%,67%,1)';
		/** @color hsla(217,91%,59%,1) */
		blue5: 'hsla(217,91%,59%,1)';
		/** @color hsla(221,83%,53%,1) */
		blue6: 'hsla(221,83%,53%,1)';
		/** @color hsla(224,76%,48%,1) */
		blue7: 'hsla(224,76%,48%,1)';
		/** @color hsla(225,70%,40%,1) */
		blue8: 'hsla(225,70%,40%,1)';
		/** @color hsla(224,64%,32%,1) */
		blue9: 'hsla(224,64%,32%,1)';
		/** @color hsla(204,100%,97%,1) */
		sky0: 'hsla(204,100%,97%,1)';
		/** @color hsla(204,93%,93%,1) */
		sky1: 'hsla(204,93%,93%,1)';
		/** @color hsla(200,94%,86%,1) */
		sky2: 'hsla(200,94%,86%,1)';
		/** @color hsla(199,95%,73%,1) */
		sky3: 'hsla(199,95%,73%,1)';
		/** @color hsla(198,93%,59%,1) */
		sky4: 'hsla(198,93%,59%,1)';
		/** @color hsla(198,88%,48%,1) */
		sky5: 'hsla(198,88%,48%,1)';
		/** @color hsla(200,98%,39%,1) */
		sky6: 'hsla(200,98%,39%,1)';
		/** @color hsla(201,96%,32%,1) */
		sky7: 'hsla(201,96%,32%,1)';
		/** @color hsla(200,89%,27%,1) */
		sky8: 'hsla(200,89%,27%,1)';
		/** @color hsla(202,80%,23%,1) */
		sky9: 'hsla(202,80%,23%,1)';
		/** @color hsla(183,100%,96%,1) */
		cyan0: 'hsla(183,100%,96%,1)';
		/** @color hsla(185,95%,90%,1) */
		cyan1: 'hsla(185,95%,90%,1)';
		/** @color hsla(186,93%,81%,1) */
		cyan2: 'hsla(186,93%,81%,1)';
		/** @color hsla(186,92%,69%,1) */
		cyan3: 'hsla(186,92%,69%,1)';
		/** @color hsla(187,85%,53%,1) */
		cyan4: 'hsla(187,85%,53%,1)';
		/** @color hsla(188,94%,42%,1) */
		cyan5: 'hsla(188,94%,42%,1)';
		/** @color hsla(191,91%,36%,1) */
		cyan6: 'hsla(191,91%,36%,1)';
		/** @color hsla(192,82%,30%,1) */
		cyan7: 'hsla(192,82%,30%,1)';
		/** @color hsla(194,69%,27%,1) */
		cyan8: 'hsla(194,69%,27%,1)';
		/** @color hsla(196,63%,23%,1) */
		cyan9: 'hsla(196,63%,23%,1)';
		/** @color hsla(166,76%,96%,1) */
		teal0: 'hsla(166,76%,96%,1)';
		/** @color hsla(167,85%,89%,1) */
		teal1: 'hsla(167,85%,89%,1)';
		/** @color hsla(168,83%,78%,1) */
		teal2: 'hsla(168,83%,78%,1)';
		/** @color hsla(170,76%,64%,1) */
		teal3: 'hsla(170,76%,64%,1)';
		/** @color hsla(172,66%,50%,1) */
		teal4: 'hsla(172,66%,50%,1)';
		/** @color hsla(173,80%,40%,1) */
		teal5: 'hsla(173,80%,40%,1)';
		/** @color hsla(174,83%,31%,1) */
		teal6: 'hsla(174,83%,31%,1)';
		/** @color hsla(175,77%,26%,1) */
		teal7: 'hsla(175,77%,26%,1)';
		/** @color hsla(176,69%,21%,1) */
		teal8: 'hsla(176,69%,21%,1)';
		/** @color hsla(175,60%,19%,1) */
		teal9: 'hsla(175,60%,19%,1)';
		/** @color hsla(151,80%,95%,1) */
		emerald0: 'hsla(151,80%,95%,1)';
		/** @color hsla(149,80%,89%,1) */
		emerald1: 'hsla(149,80%,89%,1)';
		/** @color hsla(152,75%,80%,1) */
		emerald2: 'hsla(152,75%,80%,1)';
		/** @color hsla(156,71%,66%,1) */
		emerald3: 'hsla(156,71%,66%,1)';
		/** @color hsla(158,64%,51%,1) */
		emerald4: 'hsla(158,64%,51%,1)';
		/** @color hsla(160,84%,39%,1) */
		emerald5: 'hsla(160,84%,39%,1)';
		/** @color hsla(161,93%,30%,1) */
		emerald6: 'hsla(161,93%,30%,1)';
		/** @color hsla(162,93%,24%,1) */
		emerald7: 'hsla(162,93%,24%,1)';
		/** @color hsla(163,88%,19%,1) */
		emerald8: 'hsla(163,88%,19%,1)';
		/** @color hsla(164,85%,16%,1) */
		emerald9: 'hsla(164,85%,16%,1)';
		/** @color hsla(138,76%,96%,1) */
		green0: 'hsla(138,76%,96%,1)';
		/** @color hsla(140,84%,92%,1) */
		green1: 'hsla(140,84%,92%,1)';
		/** @color hsla(141,78%,85%,1) */
		green2: 'hsla(141,78%,85%,1)';
		/** @color hsla(141,76%,73%,1) */
		green3: 'hsla(141,76%,73%,1)';
		/** @color hsla(141,69%,58%,1) */
		green4: 'hsla(141,69%,58%,1)';
		/** @color hsla(142,70%,45%,1) */
		green5: 'hsla(142,70%,45%,1)';
		/** @color hsla(142,76%,36%,1) */
		green6: 'hsla(142,76%,36%,1)';
		/** @color hsla(142,71%,29%,1) */
		green7: 'hsla(142,71%,29%,1)';
		/** @color hsla(142,64%,24%,1) */
		green8: 'hsla(142,64%,24%,1)';
		/** @color hsla(143,61%,20%,1) */
		green9: 'hsla(143,61%,20%,1)';
		/** @color hsla(78,92%,95%,1) */
		lime0: 'hsla(78,92%,95%,1)';
		/** @color hsla(79,89%,89%,1) */
		lime1: 'hsla(79,89%,89%,1)';
		/** @color hsla(80,88%,79%,1) */
		lime2: 'hsla(80,88%,79%,1)';
		/** @color hsla(81,84%,67%,1) */
		lime3: 'hsla(81,84%,67%,1)';
		/** @color hsla(82,77%,55%,1) */
		lime4: 'hsla(82,77%,55%,1)';
		/** @color hsla(83,80%,44%,1) */
		lime5: 'hsla(83,80%,44%,1)';
		/** @color hsla(84,85%,34%,1) */
		lime6: 'hsla(84,85%,34%,1)';
		/** @color hsla(85,78%,27%,1) */
		lime7: 'hsla(85,78%,27%,1)';
		/** @color hsla(86,68%,22%,1) */
		lime8: 'hsla(86,68%,22%,1)';
		/** @color hsla(87,61%,20%,1) */
		lime9: 'hsla(87,61%,20%,1)';
		/** @color hsla(54,91%,95%,1) */
		yellow0: 'hsla(54,91%,95%,1)';
		/** @color hsla(54,96%,88%,1) */
		yellow1: 'hsla(54,96%,88%,1)';
		/** @color hsla(52,98%,76%,1) */
		yellow2: 'hsla(52,98%,76%,1)';
		/** @color hsla(50,97%,63%,1) */
		yellow3: 'hsla(50,97%,63%,1)';
		/** @color hsla(47,95%,53%,1) */
		yellow4: 'hsla(47,95%,53%,1)';
		/** @color hsla(45,93%,47%,1) */
		yellow5: 'hsla(45,93%,47%,1)';
		/** @color hsla(40,96%,40%,1) */
		yellow6: 'hsla(40,96%,40%,1)';
		/** @color hsla(35,91%,32%,1) */
		yellow7: 'hsla(35,91%,32%,1)';
		/** @color hsla(31,80%,28%,1) */
		yellow8: 'hsla(31,80%,28%,1)';
		/** @color hsla(28,72%,25%,1) */
		yellow9: 'hsla(28,72%,25%,1)';
		/** @color hsla(47,100%,96%,1) */
		amber0: 'hsla(47,100%,96%,1)';
		/** @color hsla(47,96%,88%,1) */
		amber1: 'hsla(47,96%,88%,1)';
		/** @color hsla(48,96%,76%,1) */
		amber2: 'hsla(48,96%,76%,1)';
		/** @color hsla(45,96%,64%,1) */
		amber3: 'hsla(45,96%,64%,1)';
		/** @color hsla(43,96%,56%,1) */
		amber4: 'hsla(43,96%,56%,1)';
		/** @color hsla(37,92%,50%,1) */
		amber5: 'hsla(37,92%,50%,1)';
		/** @color hsla(32,94%,43%,1) */
		amber6: 'hsla(32,94%,43%,1)';
		/** @color hsla(25,90%,37%,1) */
		amber7: 'hsla(25,90%,37%,1)';
		/** @color hsla(22,82%,31%,1) */
		amber8: 'hsla(22,82%,31%,1)';
		/** @color hsla(21,77%,26%,1) */
		amber9: 'hsla(21,77%,26%,1)';
		/** @color hsla(33,100%,96%,1) */
		orange0: 'hsla(33,100%,96%,1)';
		/** @color hsla(34,100%,91%,1) */
		orange1: 'hsla(34,100%,91%,1)';
		/** @color hsla(32,97%,83%,1) */
		orange2: 'hsla(32,97%,83%,1)';
		/** @color hsla(30,97%,72%,1) */
		orange3: 'hsla(30,97%,72%,1)';
		/** @color hsla(27,95%,60%,1) */
		orange4: 'hsla(27,95%,60%,1)';
		/** @color hsla(24,94%,53%,1) */
		orange5: 'hsla(24,94%,53%,1)';
		/** @color hsla(20,90%,48%,1) */
		orange6: 'hsla(20,90%,48%,1)';
		/** @color hsla(17,88%,40%,1) */
		orange7: 'hsla(17,88%,40%,1)';
		/** @color hsla(15,79%,33%,1) */
		orange8: 'hsla(15,79%,33%,1)';
		/** @color hsla(15,74%,27%,1) */
		orange9: 'hsla(15,74%,27%,1)';
		/** @color hsla(0,85%,97%,1) */
		red0: 'hsla(0,85%,97%,1)';
		/** @color hsla(0,93%,94%,1) */
		red1: 'hsla(0,93%,94%,1)';
		/** @color hsla(0,96%,89%,1) */
		red2: 'hsla(0,96%,89%,1)';
		/** @color hsla(0,93%,81%,1) */
		red3: 'hsla(0,93%,81%,1)';
		/** @color hsla(0,90%,70%,1) */
		red4: 'hsla(0,90%,70%,1)';
		/** @color hsla(0,84%,60%,1) */
		red5: 'hsla(0,84%,60%,1)';
		/** @color hsla(0,72%,50%,1) */
		red6: 'hsla(0,72%,50%,1)';
		/** @color hsla(0,73%,41%,1) */
		red7: 'hsla(0,73%,41%,1)';
		/** @color hsla(0,70%,35%,1) */
		red8: 'hsla(0,70%,35%,1)';
		/** @color hsla(0,62%,30%,1) */
		red9: 'hsla(0,62%,30%,1)';
		/** @color hsla(60,9%,97%,1) */
		warmer0: 'hsla(60,9%,97%,1)';
		/** @color hsla(60,4%,95%,1) */
		warmer1: 'hsla(60,4%,95%,1)';
		/** @color hsla(20,5%,90%,1) */
		warmer2: 'hsla(20,5%,90%,1)';
		/** @color hsla(23,5%,82%,1) */
		warmer3: 'hsla(23,5%,82%,1)';
		/** @color hsla(23,5%,63%,1) */
		warmer4: 'hsla(23,5%,63%,1)';
		/** @color hsla(24,5%,44%,1) */
		warmer5: 'hsla(24,5%,44%,1)';
		/** @color hsla(33,5%,32%,1) */
		warmer6: 'hsla(33,5%,32%,1)';
		/** @color hsla(30,6%,25%,1) */
		warmer7: 'hsla(30,6%,25%,1)';
		/** @color hsla(12,6%,15%,1) */
		warmer8: 'hsla(12,6%,15%,1)';
		/** @color hsla(24,9%,10%,1) */
		warmer9: 'hsla(24,9%,10%,1)';
		/** @color hsla(0,0%,98%,1) */
		warm0: 'hsla(0,0%,98%,1)';
		/** @color hsla(0,0%,96%,1) */
		warm1: 'hsla(0,0%,96%,1)';
		/** @color hsla(0,0%,89%,1) */
		warm2: 'hsla(0,0%,89%,1)';
		/** @color hsla(0,0%,83%,1) */
		warm3: 'hsla(0,0%,83%,1)';
		/** @color hsla(0,0%,63%,1) */
		warm4: 'hsla(0,0%,63%,1)';
		/** @color hsla(0,0%,45%,1) */
		warm5: 'hsla(0,0%,45%,1)';
		/** @color hsla(0,0%,32%,1) */
		warm6: 'hsla(0,0%,32%,1)';
		/** @color hsla(0,0%,25%,1) */
		warm7: 'hsla(0,0%,25%,1)';
		/** @color hsla(0,0%,14%,1) */
		warm8: 'hsla(0,0%,14%,1)';
		/** @color hsla(0,0%,9%,1) */
		warm9: 'hsla(0,0%,9%,1)';
		/** @color hsla(0,0%,98%,1) */
		gray0: 'hsla(0,0%,98%,1)';
		/** @color hsla(240,4%,95%,1) */
		gray1: 'hsla(240,4%,95%,1)';
		/** @color hsla(240,5%,90%,1) */
		gray2: 'hsla(240,5%,90%,1)';
		/** @color hsla(240,4%,83%,1) */
		gray3: 'hsla(240,4%,83%,1)';
		/** @color hsla(240,5%,64%,1) */
		gray4: 'hsla(240,5%,64%,1)';
		/** @color hsla(240,3%,46%,1) */
		gray5: 'hsla(240,3%,46%,1)';
		/** @color hsla(240,5%,33%,1) */
		gray6: 'hsla(240,5%,33%,1)';
		/** @color hsla(240,5%,26%,1) */
		gray7: 'hsla(240,5%,26%,1)';
		/** @color hsla(240,3%,15%,1) */
		gray8: 'hsla(240,3%,15%,1)';
		/** @color hsla(240,5%,10%,1) */
		gray9: 'hsla(240,5%,10%,1)';
		/** @color hsla(210,19%,98%,1) */
		cool0: 'hsla(210,19%,98%,1)';
		/** @color hsla(219,14%,95%,1) */
		cool1: 'hsla(219,14%,95%,1)';
		/** @color hsla(220,13%,90%,1) */
		cool2: 'hsla(220,13%,90%,1)';
		/** @color hsla(215,12%,83%,1) */
		cool3: 'hsla(215,12%,83%,1)';
		/** @color hsla(217,10%,64%,1) */
		cool4: 'hsla(217,10%,64%,1)';
		/** @color hsla(220,8%,46%,1) */
		cool5: 'hsla(220,8%,46%,1)';
		/** @color hsla(215,13%,34%,1) */
		cool6: 'hsla(215,13%,34%,1)';
		/** @color hsla(216,19%,26%,1) */
		cool7: 'hsla(216,19%,26%,1)';
		/** @color hsla(214,27%,16%,1) */
		cool8: 'hsla(214,27%,16%,1)';
		/** @color hsla(220,39%,10%,1) */
		cool9: 'hsla(220,39%,10%,1)';
		/** @color hsla(210,40%,98%,1) */
		cooler0: 'hsla(210,40%,98%,1)';
		/** @color hsla(209,40%,96%,1) */
		cooler1: 'hsla(209,40%,96%,1)';
		/** @color hsla(214,31%,91%,1) */
		cooler2: 'hsla(214,31%,91%,1)';
		/** @color hsla(212,26%,83%,1) */
		cooler3: 'hsla(212,26%,83%,1)';
		/** @color hsla(215,20%,65%,1) */
		cooler4: 'hsla(215,20%,65%,1)';
		/** @color hsla(215,16%,46%,1) */
		cooler5: 'hsla(215,16%,46%,1)';
		/** @color hsla(215,19%,34%,1) */
		cooler6: 'hsla(215,19%,34%,1)';
		/** @color hsla(215,24%,26%,1) */
		cooler7: 'hsla(215,24%,26%,1)';
		/** @color hsla(217,32%,17%,1) */
		cooler8: 'hsla(217,32%,17%,1)';
		/** @color hsla(222,47%,11%,1) */
		cooler9: 'hsla(222,47%,11%,1)';
	}

	interface css$enum$font_size {
		/** 10px */
		'xxs': '10px';
		/** 12px */
		'xs': '12px';
		/** 13px */
		'sm-': '13px';
		/** 14px */
		'sm': '14px';
		/** 15px */
		'md-': '15px';
		/** 16px */
		'md': '16px';
		/** 18px */
		'lg': '18px';
		/** 20px */
		'xl': '20px';
		/** 24px */
		'2xl': '24px';
		/** 30px */
		'3xl': '30px';
		/** 36px */
		'4xl': '36px';
		/** 48px */
		'5xl': '48px';
		/** 64px */
		'6xl': '64px';
	}

}

