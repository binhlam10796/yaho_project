import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:yaho/core/models/mapper/contact.dart';
import 'package:yaho/utils/extension/extension_string.dart';

class ContactItemList extends StatelessWidget {
  final Contact contact;
  const ContactItemList({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: contact.avatar ?? "",
        imageBuilder: (context, imageProvider) => Container(
          width: AppSize.s48,
          height: AppSize.s48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => const Icon(Icons.person_pin_outlined),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(
        "${contact.firstName ?? ""} ${contact.lastName ?? ""}".toCapitalized(),
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
    );
  }
}
