import 'package:flutter/material.dart';

class MenuIconWidget extends StatefulWidget {
  final Color color;
  final String menuName;
  final IconData icon;

  const MenuIconWidget({
    super.key,
    required this.color,
    required this.menuName,
    required this.icon,
  });

  @override
  State<MenuIconWidget> createState() => _MenuIconWidgetState();
}

class _MenuIconWidgetState extends State<MenuIconWidget> {
  void menuOnTap() {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.3,
      height: size.width * 0.3,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      child: GestureDetector(
        onTap: menuOnTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 50.0,
            ),
            Text(
              widget.menuName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
