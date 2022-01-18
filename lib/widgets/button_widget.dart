import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget
{
	final String name;
	final VoidCallback onClicked;

	final Color textColor;
	final Color bgColor;

	const ButtonWidget({
		Key? key, 
		required this.name,
		this.textColor = Colors.white,
		this.bgColor   = Colors.blueGrey,
		required this.onClicked
	}) : super(key: key);

	@override
	Widget build(BuildContext context)
	{
		return ElevatedButton(
			style: ElevatedButton.styleFrom(
				primary: bgColor,
				padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
			),
			onPressed: onClicked, 
			child: Text(
				name, 
				style: TextStyle(fontSize: 20, color: textColor)
			),
		);
	}
}