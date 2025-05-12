import 'package:wet_dreams/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wet_dreams/utils/app_texts.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final bool isSecondary;
  final bool isDisabled;
  final double? height;
  final double? width;
  final bool isLoading;
  final String? leading;
  final double padding;
  final double radius;
  final double fontSize;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.leading,
    this.padding = 40,
    this.radius = 99,
    this.isSecondary = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.fontSize = 16,
    this.height = 50,
    this.width = double.infinity,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.radius),
      onTap: widget.isLoading ? null : widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: widget.padding),
        decoration: BoxDecoration(
          color:
              widget.isSecondary
                  ? AppColors.blue[50]
                  : widget.isDisabled
                  ? AppColors.blue.shade300
                  : AppColors.blue.shade500,
          borderRadius: BorderRadius.circular(widget.radius),
          border: widget.isSecondary ? Border.all(color: AppColors.blue) : null,
        ),
        child:
            widget.isLoading
                ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blue[25],
                    strokeWidth: 4,
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    if (widget.leading != null)
                      SvgPicture.asset(
                        widget.leading!,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          widget.isSecondary
                              ? AppColors.blue
                              : AppColors.blue[25]!,
                          BlendMode.srcIn,
                        ),
                      ),
                    Text(
                      widget.text,
                      style: AppTexts.tsmb.copyWith(
                        fontSize: widget.fontSize,
                        color:
                            widget.isSecondary
                                ? AppColors.black
                                : AppColors.blue.shade900,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
