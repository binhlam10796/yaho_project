import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:yaho/core/models/mapper/contact.dart';
import 'package:yaho/utils/extension/extension_string.dart';

class ContactItemGrid extends StatelessWidget {
  final Contact contact;
  const ContactItemGrid({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: GridTileBar(
          backgroundColor: ColorManager.brightBlueColor.withOpacity(0.5),
          title: Text(
            "${contact.firstName ?? ""} ${contact.lastName ?? ""}"
                .toCapitalized(),
            style: getTextBoldStyle(
              fontSize: FontSize.s16,
              color: ColorManager.contentColor,
            ),
          ),
          subtitle: Text(
            contact.email ?? "",
            style: getTextRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.contentColor,
            ),
          ),
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: contact.avatar ?? "",
        imageBuilder: (context, imageProvider) => Container(
          width: AppSize.s100,
          height: AppSize.s100,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.none),
          ),
        ),
        placeholder: (context, url) => const Icon(Icons.person_pin_outlined),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
