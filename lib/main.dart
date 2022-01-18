import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/button_widget.dart';

void main() => runApp(const App());

class App extends StatelessWidget 
{
	const App({Key? key}) : super(key: key);

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) 
	{
		return MaterialApp(
			title: 'Flutter App',
			theme: ThemeData(
				primarySwatch: Colors.blueGrey,
			),
			home: const HomePage(title: 'Countdown'),
		);
	}
}

class HomePage extends StatefulWidget 
{
	const HomePage({Key? key, required this.title}) : super(key: key);

	final String title;

	@override
	State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> 
{
	static const maxSeconds = 10;
	int seconds = maxSeconds;
	Timer? timer;

	@override
	Widget build(BuildContext context) 
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
				centerTitle: true,
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						buildTimer(),
						const SizedBox(height: 50),
						buildButtons(),
					],
				),
			),
		);
	}

	Widget buildButtons()
	{
		final bool isRunning = timer == null ? false : timer!.isActive;
		final bool isCompleted = seconds == 0 || seconds == maxSeconds;

		if (isRunning || !isCompleted)
		{
			return Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					ButtonWidget(
						name: isRunning ? 'Pause' : 'Resume',
						onClicked: () 
						{ 
							if (isRunning)
							{
								stopTimer(reset: false); 
							}
							else
							{
								startTimer(reset: false);
							}
						},
					),
					const SizedBox(width: 12),
					ButtonWidget(
						name: 'Reset',
						onClicked: () { stopTimer(); },
					),
				],
			);
		}

		return ButtonWidget(
			name: 'Start',
			onClicked: () { startTimer(reset: true); }
		);
	}

	Widget buildTimer()
	{
		return SizedBox(
			width : 100,
			height: 100,
			child: Stack(
				fit: StackFit.expand,
				children: [
					Center(child: buildTime()),
					CircularProgressIndicator(
						value: 1 - seconds / maxSeconds,
						valueColor: const AlwaysStoppedAnimation(Colors.blueGrey),
						backgroundColor: Colors.grey[300],
						strokeWidth: 5,
					),
				],
			)
		);
	}

	Widget buildTime()
	{
		if (seconds == 0)
		{
			return const Icon(Icons.done, color: Colors.blueGrey, size: 80);
		}

		return Text('$seconds', style: Theme.of(context).textTheme.headline2);
	}

	void startTimer({bool reset = true})
	{
		if (reset)
		{
			resetTimer();
		}

		timer = Timer.periodic(const Duration(seconds: 1), (_) 
		{
			if (seconds > 0)
			{
				setState(() => seconds--);
			}
			else
			{
				stopTimer(reset: false);
			}
		});
	}

	void stopTimer({bool reset = true})
	{
		if (reset)
		{
			resetTimer();
		}
		//timer?.cancel();
		setState(() => timer?.cancel());
	}

	void resetTimer() => setState(() => seconds = maxSeconds);
}
