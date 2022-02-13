import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_pic/common/constants.dart';
import 'package:pick_pic/l10n/test_res.dart';
import 'package:pick_pic/states/provider/photo/photo_list_provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'components/photo_item.dart';

final showAppBarProvider = StateProvider((ref) => true);
final showCancelProvider = StateProvider((ref) => false);

/// a photo image list page
/// get from https://unsplash.com/

class PhotoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PhotoListState();
}

class PhotoListState extends State<PhotoListPage>
    with AutomaticKeepAliveClientMixin {
  PhotoListState({Key? key});

  /// photo list ScrollController
  static late ScrollController _scrollController;
  static late bool needLoadMore;

  /// scroll state
  bool isScrollingDown = false;

  /// control TextField focus
  static late FocusNode _focusNode;

  /// last data list length
  int oldLength = 0;

  /// the last item index in screen
  int curLastIndex = 0;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_focusListener);
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void didUpdateWidget(PhotoListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildBody(),
    );
  }

  /// main widget
  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _buildHideAbleAppBar(),
          Expanded(
            child: _buildPhotoList(),
          ),
        ],
      ),
    );
  }

  /// scroll auto hide appBar
  Widget _buildHideAbleAppBar() {
    return Consumer(
      builder: (context, watch, _) {
        return Container(
          // width: MediaQuery.of(context).size.width,
          child: AnimatedContainer(
            width: MediaQuery.of(context).size.width -
                (watch(showCancelProvider).state ? 50 : 0),
            height: watch(showAppBarProvider).state ? bigSize : 10.0,
            duration: Duration(milliseconds: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.only(right: smallPadding, top: smallPadding),
                    child: TextField(
                      focusNode: _focusNode,
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onSubmitted: (value) {
                        context.read(photoProvider.notifier).refresh(value);
                      },
                    ),
                  ),
                ),
                // Spacer(),
                watch(showCancelProvider).state
                    ? _buildCancelButton()
                    : Container()
              ],
            ),
          ),
        );
      },
    );
  }

  /// TextField focus dismiss
  Widget _buildCancelButton() {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: smallPadding),
        child: Text(
          'cancel',
          style: TextStyle(
              fontSize: mediumText,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
      ),
    );
  }

  Widget _buildPhotoList() {
    return Consumer(
      builder: (context, watch, _) {
        // photo listView state
        final isLoadMoreError = watch(photoProvider).isLoadMoreError;
        final isLoadMoreDone = watch(photoProvider).isLoadMoreDone;
        final isLoading = watch(photoProvider).isLoading;
        final photos = watch(photoProvider).photos;
        oldLength = photos?.length ?? 0;
        if (photos == null) {
          if (isLoading == false) {
            //  NONE
            return _buildNoneWidget(context);
          }
          // Loading Large
          return _buildLoadingWidget(context);
        }
        return NotificationListener(
          onNotification: (t) {
            if (t is ScrollEndNotification && needLoadMore) {
              context.read(photoProvider.notifier).loadMore();
              needLoadMore = false;
            }

            return false;
          },
          child: WaterfallFlow.builder(
              itemCount: photos.length + 1,
              controller: _scrollController,
              cacheExtent: MediaQuery.of(context).size.height * 2,
              gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                viewportBuilder: (int firstIndex, int lastIndex) {
                  curLastIndex = lastIndex;
                },
                lastChildLayoutTypeBuilder: (index) => index == photos.length
                    ? LastChildLayoutType.fullCrossAxisExtent
                    : LastChildLayoutType.none,
              ),
              itemBuilder: (BuildContext context, int i) {
                if (i == photos.length) {
                  if (isLoadMoreDone) {
                    return Center(
                      child: Text(''),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).shadowColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  );
                }
                return PhotoItem(i, photos[i]);
              }),
        );
      },
    );
  }

  /// if need loading then show
  Widget _buildLoadingWidget(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  /// if none then show
  Widget _buildNoneWidget(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        '${TextResource.listNone(context)}',
        style: Theme.of(context).textTheme.headline2,
      )),
    );
  }

  /// get current focus state
  void _focusListener() {
    context.read(showCancelProvider).state = _focusNode.hasFocus;
  }

  /// listen scroll state
  /// use for loadMore
  void _scrollListener() {
    _focusNode.unfocus();
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    // use for loadMore
    // judge by current currentScroll distance
    if (currentScroll > maxScroll &&
        !context.read(photoProvider).isLoading &&
        _scrollController.position.extentAfter == 0) {
      if (curLastIndex >= context.read(photoProvider).photos!.length - 2) {
        needLoadMore = true;
      }
    }
    // use for hide appBar
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!isScrollingDown) {
        isScrollingDown = true;
        context.read(showAppBarProvider).state = false;
      }
    }

    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (isScrollingDown) {
        isScrollingDown = false;
        context.read(showAppBarProvider).state = true;
        setState(() {});
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
