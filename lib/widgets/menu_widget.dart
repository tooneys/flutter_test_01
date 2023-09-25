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
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(-1, 10),
              ),
            ]
          ),
          child: Container(
            padding: EdgeInsets.all(5),
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
        ),
      ),
    );
  }
}
