import 'package:flutter/material.dart';

class MenuIconWidget extends StatefulWidget {
  final Color color;
  final String menuName;
  final IconData icon;
  final VoidCallback onTap;

  const MenuIconWidget({
    super.key,
    required this.color,
    required this.menuName,
    required this.icon,
    required this.onTap,
  });

  @override
  State<MenuIconWidget> createState() => _MenuIconWidgetState();
}

class _MenuIconWidgetState extends State<MenuIconWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          width: size.width * 0.3,
          height: size.width * 0.3,
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 7,
                  offset: const Offset(5, 9),
                ),
              ]),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: 55.0,
                ),
                Text(
                  widget.menuName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
