import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DisplayImagesSlider extends StatefulWidget {
  final double height;
  final List animeImage;
  final SwiperController swiperController;

  const DisplayImagesSlider(
      {Key key, this.height, this.animeImage, this.swiperController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DisplayImagesSliderState();
  }
}

class _DisplayImagesSliderState extends State<DisplayImagesSlider> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AspectRatio(
        aspectRatio: 0.7,
        child: Swiper(
          // itemHeight: size.width,
          itemWidth: size.width,
          controller: widget.swiperController,
          itemCount: widget.animeImage.length,
          itemBuilder: (BuildContext context, int index) => AspectRatio(
            aspectRatio: 0.5,
            child: Image.network(
              widget.animeImage[index]["image_url"],
              fit: BoxFit.cover,
            ),
          ),
          autoplay: true,
          pagination: SwiperPagination(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, size.width / 12),
            builder: DotSwiperPaginationBuilder(
                color: Colors.white30,
                activeColor: Colors.white,
                size: 9.0,
                activeSize: 12.0),
          ),
        ));
  }
}
