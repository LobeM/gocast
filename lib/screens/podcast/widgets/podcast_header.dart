import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/widgets/blured_image.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class PodcastHeader extends StatelessWidget {
  final PodcastModel podcast;

  const PodcastHeader({Key key, this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (podcast == null) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Container(color: kWhite),
      );
    }
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        BluredImage(podcast.imageUrl),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: kPaddingS, bottom: kPaddingS),
              child: Container(
                height: 120,
                width: 120,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.white),
                child: CachedNetworkImage(
                  imageUrl: podcast.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kPaddingS),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: kPaddingS),
                      child: StrutText(
                        podcast.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .bold
                            .w600
                            .copyWith(color: kWhite),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(kFormFieldsRadius)),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: kWhite),
                                  Text(
                                    L10n.of(context).subscribe,
                                    style: TextStyle(color: kWhite),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(
                                Radius.circular(kFormFieldsRadius)),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.public_sharp,
                              color: kWhite,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(
                                Radius.circular(kFormFieldsRadius)),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              color: kWhite,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
