import 'package:entrance_test/src/constants/color.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    Key? key,
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.iconSource,
    this.icon,
    this.iconSize,
    required this.onClick,
    required this.textLabel,
    this.side,
  }) : super(key: key);

  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final String? iconSource;
  final IconData? icon;
  final double? iconSize;
  final Function onClick;
  final String textLabel;
  final BorderSide? side;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: borderColor != null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(width: 1.5, color: borderColor!),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        side: side,
      ),
      onPressed: () {
        onClick();
      },
      icon: (iconSource != null)
          ? Image.asset(
              iconSource ?? "",
              height: iconSize ?? 24,
              width: iconSize ?? 24,
            )
          : icon != null
              ? Icon(icon, size: iconSize ?? 24)
              : const SizedBox.shrink(),
      label: Text(
        textLabel,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  var onClick;
  bool isDisabled;
  String title;
  Color? color;
  Color? textColor;
  IconData? icn;

  PrimaryButton(
      {Key? key,
      required this.onClick,
      required this.isDisabled,
      this.color,
      this.textColor,
      this.icn,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding:
            const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 14)),
        backgroundColor: isDisabled
            ? MaterialStatePropertyAll(gray200)
            : MaterialStatePropertyAll(color),
        elevation: MaterialStatePropertyAll(isDisabled ? 0 : null),
      ),
      onPressed: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: isDisabled ? boldGreyText : TextStyle(color: textColor),
          ),
          if (icn != null) const SizedBox(width: 10),
          if (icn != null)
            Icon(
              icn,
              size: 20,
              color: isDisabled ? grayText : white,
            )
        ],
      ),
    );
  }
}

class ItemSelectDayWidget extends StatelessWidget {
  const ItemSelectDayWidget({
    super.key,
    required this.size,
    required this.label,
    required this.status,
    required this.tap,
  });

  final Size size;
  final String label;
  final bool status;
  final Future<void> Function() tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: tap,
        child: SizedBox(
          width: size.width,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: gray900,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white,
                    border: Border.all(
                        width: status ? 4 : 2,
                        color: status ? primary : gray600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
