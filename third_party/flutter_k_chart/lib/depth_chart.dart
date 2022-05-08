import 'dart:math';

import 'package:flutter/material.dart';
import 'chart_style.dart';
import 'entity/depth_entity.dart';

class DepthChart extends StatefulWidget {
  final List<DepthEntity> bids, asks;

  DepthChart(this.bids, this.asks);

  @override
  _DepthChartState createState() => _DepthChartState();
}

class _DepthChartState extends State<DepthChart> {
  Offset pressOffset;
  bool isLongPress = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        pressOffset = details.globalPosition;
        isLongPress = true;
        setState(() {});
      },
      onLongPressMoveUpdate: (details) {
        pressOffset = details.globalPosition;
        isLongPress = true;
        setState(() {});
      },
      onTap: () {
        if (isLongPress) {
          isLongPress = false;
          setState(() {});
        }
      },
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: DepthChartPainter(
            widget.bids, widget.asks, pressOffset, isLongPress),
      ),
    );
  }
}

class DepthChartPainter extends CustomPainter {
  //买入//卖出
  List<DepthEntity> mBuyData, mSellData;
  Offset pressOffset;
  bool isLongPress;

  double mPaddingBottom = 18.0;
  double mWidth = 0.0,
      mDrawHeight = 0.0,
      mDrawWidth = 0.0,
      mBuyPointWidth,
      mSellPointWidth;

  //最大的委托量
  double mMaxVolume, mMultiple;

  //右侧绘制个数
  int mLineCount = 4;

  Path mBuyPath, mSellPath;

  //买卖出区域边线绘制画笔  //买卖出取悦绘制画笔
  Paint mBuyLinePaint, mSellLinePaint, mBuyPathPaint, mSellPathPaint, gridPaint;

  DepthChartPainter(
      this.mBuyData, this.mSellData, this.pressOffset, this.isLongPress) {
    mBuyLinePaint ??= Paint()
      ..isAntiAlias = true
      ..color = ChartColors.depthBuyColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    mSellLinePaint ??= Paint()
      ..isAntiAlias = true
      ..color = ChartColors.depthSellColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    mBuyPathPaint ??= Paint()
      ..isAntiAlias = true
      ..color = ChartColors.depthBuyColor.withOpacity(0.2);
    mSellPathPaint ??= Paint()
      ..isAntiAlias = true
      ..color = ChartColors.depthSellColor.withOpacity(0.2);
    mBuyPath ??= Path();
    mSellPath ??= Path();
    gridPaint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..strokeWidth = 0.5
      ..color = ChartColors.gridColor;
    init();
  }

  void init() {
    if (mBuyData == null ||
        mSellData == null ||
        mBuyData.isEmpty ||
        mSellData.isEmpty) return;
    mMaxVolume = mBuyData.first.amount;
    mMaxVolume = max(mMaxVolume, mSellData.last.amount);
    mMaxVolume = mMaxVolume * 1.05;
    mMultiple = mMaxVolume / mLineCount;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (mBuyData == null ||
        mSellData == null ||
        mBuyData.isEmpty ||
        mSellData.isEmpty) return;
    mWidth = size.width;
    mDrawWidth = mWidth / 2;
    mDrawHeight = size.height - mPaddingBottom;
//    canvas.drawColor(Colors.black, BlendMode.color);
    canvas.save();

    drawGrid(canvas);

    //绘制买入区域
    drawBuy(canvas);
    //绘制卖出区域
    drawSell(canvas);

    //绘制界面相关文案
    drawText(canvas);

    canvas.restore();
  }

  void drawGrid(Canvas canvas) {
    final int gridRows = mLineCount, gridColumns = 4;
    double rowSpace = mDrawHeight * 0.95 / gridRows;
    for (int i = 0; i <= gridRows; i++) {
      canvas.drawLine(Offset(0, rowSpace * i + mDrawHeight * 0.05),
          Offset(mWidth, rowSpace * i + mDrawHeight * 0.05), gridPaint);
    }
    double columnSpace = mWidth / gridColumns;
    for (int i = 0; i <= columnSpace; i++) {
      canvas.drawLine(Offset(columnSpace * i, 0),
          Offset(columnSpace * i, mDrawHeight), gridPaint);
    }
  }

  void drawBuy(Canvas canvas) {
    mBuyPointWidth =
        (mDrawWidth / (mBuyData.length - 1 == 0 ? 1 : mBuyData.length - 1));
    mBuyPath.reset();
    double x;
    double y;
    for (int i = 0; i < mBuyData.length; i++) {
      if (i == 0) {
        mBuyPath.moveTo(0, getY(mBuyData[0].amount));
      }
      y = getY(mBuyData[i].amount);

      if (i >= 1) {
        canvas.drawLine(
            Offset(mBuyPointWidth * (i - 1), getY(mBuyData[i - 1].amount)),
            Offset(mBuyPointWidth * i, y),
            mBuyLinePaint);
      }
      if (i != mBuyData.length - 1) {
        mBuyPath.quadraticBezierTo(mBuyPointWidth * i, y,
            mBuyPointWidth * (i + 1), getY(mBuyData[i + 1].amount));
      }

      x = mBuyPointWidth * i;

      if (i == mBuyData.length - 1) {
        mBuyPath.quadraticBezierTo(
            mBuyPointWidth * i, y, mBuyPointWidth * i, mDrawHeight);
        mBuyPath.quadraticBezierTo(
            mBuyPointWidth * i, mDrawHeight, 0, mDrawHeight);
        mBuyPath.close();
      }
    }
    canvas.drawPath(mBuyPath, mBuyPathPaint);
  }

  void drawSell(Canvas canvas) {
    mSellPointWidth =
        (mDrawWidth / (mSellData.length - 1 == 0 ? 1 : mSellData.length - 1));
    mSellPath.reset();
    double x;
    double y;
    for (int i = 0; i < mSellData.length; i++) {
      if (i == 0) {
        mSellPath.moveTo(mDrawWidth, getY(mSellData[0].amount));
      }
      y = getY(mSellData[i].amount);
      if (i >= 1) {
        canvas.drawLine(
            Offset((mSellPointWidth * (i - 1)) + mDrawWidth,
                getY(mSellData[i - 1].amount)),
            Offset((mSellPointWidth * i) + mDrawWidth, y),
            mSellLinePaint);
      }
      if (i != mSellData.length - 1) {
        mSellPath.quadraticBezierTo(
            (mSellPointWidth * i) + mDrawWidth,
            y,
            (mSellPointWidth * (i + 1)) + mDrawWidth,
            getY(mSellData[i + 1].amount));
      }
      x = (mSellPointWidth * i) + mDrawWidth;

      if (i == mSellData.length - 1) {
        mSellPath.quadraticBezierTo(
            mWidth, y, (mSellPointWidth * i) + mDrawWidth, mDrawHeight);
        mSellPath.quadraticBezierTo((mSellPointWidth * i) + mDrawWidth,
            mDrawHeight, mDrawWidth, mDrawHeight);
        mSellPath.close();
      }
    }
    canvas.drawPath(mSellPath, mSellPathPaint);
  }

  int mLastPosition;

  String centerNumber(List<DepthEntity> datas) {
    final isEvenNumbers = datas.length % 2 == 0;
    final halfLength = datas.length ~/ 2;
    return isEvenNumbers
        ? ((datas[halfLength - 1].price + datas[halfLength].price) / 2)
            .toStringAsFixed(2)
        : (datas[halfLength].price).toStringAsFixed(2);
  }

  void drawText(Canvas canvas) {
    double value;
    String str;
    for (int j = 0; j < mLineCount; j++) {
      value = mMaxVolume - mMultiple * j;
      str = value.toStringAsFixed(2);
      var tp = getTextPainter(str);
      tp.layout();
      tp.paint(
          canvas,
          Offset(mWidth - tp.width - 5,
              mDrawHeight / mLineCount * j + tp.height / 2));
    }
    var startText = mBuyData.first.price.toStringAsFixed(2);
    TextPainter startTP = getTextPainter(startText);
    startTP.layout();
    startTP.paint(canvas, Offset(0, getBottomTextY(startTP.height)));

    // var leftCenter =
    //     ((mBuyData.last.price + mBuyData.first.price) / 2).toStringAsFixed(2);
    var leftCenter = centerNumber(mBuyData);
    TextPainter leftCenterTP = getTextPainter(leftCenter);
    leftCenterTP.layout();
    leftCenterTP.paint(
        canvas,
        Offset(mDrawWidth / 2 - leftCenterTP.width / 2,
            getBottomTextY(leftCenterTP.height)));

    var center =
        ((mBuyData.last.price + mSellData.first.price) / 2).toStringAsFixed(2);
    TextPainter centerTP = getTextPainter(center);
    centerTP.layout();
    centerTP.paint(
        canvas,
        Offset(
            mDrawWidth - centerTP.width / 2, getBottomTextY(centerTP.height)));

    // var rightCenter =
    //     ((mSellData.last.price + mSellData.first.price) / 2).toStringAsFixed(2);
    var rightCenter = centerNumber(mSellData);
    TextPainter rightCenterTP = getTextPainter(rightCenter);
    rightCenterTP.layout();
    rightCenterTP.paint(
        canvas,
        Offset(mWidth - mDrawWidth / 2 - rightCenterTP.width / 2,
            getBottomTextY(rightCenterTP.height)));

    var endText = mSellData.last.price.toStringAsFixed(2);
    TextPainter endTP = getTextPainter(endText);
    endTP.layout();
    endTP.paint(
        canvas, Offset(mWidth - endTP.width, getBottomTextY(endTP.height)));

    if (isLongPress == true) {
      if (pressOffset.dx <= mDrawWidth) {
        int index =
            _indexOfTranslateX(pressOffset.dx, 0, mBuyData.length, getBuyX);
        drawSelectView(canvas, index, true);
      } else {
        int index =
            _indexOfTranslateX(pressOffset.dx, 0, mSellData.length, getSellX);
        drawSelectView(canvas, index, false);
      }
    }
  }

  Paint selectPaint = Paint()
    ..isAntiAlias = true
    ..color = ChartColors.markerBgColor;
  Paint selectBorderPaint = Paint()
    ..isAntiAlias = true
    ..color = ChartColors.markerBorderColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5;

  void drawSelectView(Canvas canvas, int index, bool isLeft) {
    DepthEntity entity = isLeft ? mBuyData[index] : mSellData[index];
    double dx = isLeft ? getBuyX(index) : getSellX(index);

    double radius = 8.0;
    if (dx < mDrawWidth) {
      canvas.drawCircle(Offset(dx, getY(entity.amount)), radius / 3,
          mBuyLinePaint..style = PaintingStyle.fill);
      canvas.drawCircle(Offset(dx, getY(entity.amount)), radius,
          mBuyLinePaint..style = PaintingStyle.stroke);
    } else {
      canvas.drawCircle(Offset(dx, getY(entity.amount)), radius / 3,
          mSellLinePaint..style = PaintingStyle.fill);
      canvas.drawCircle(Offset(dx, getY(entity.amount)), radius,
          mSellLinePaint..style = PaintingStyle.stroke);
    }

    //画底部
    TextPainter priceTP =
        getTextPainter(entity.price.toStringAsFixed(2), Colors.white);
    priceTP.layout();
    double left;
    if (dx <= priceTP.width / 2) {
      left = 0;
    } else if (dx >= mWidth - priceTP.width / 2) {
      left = mWidth - priceTP.width;
    } else {
      left = dx - priceTP.width / 2;
    }
    Rect bottomRect = Rect.fromLTRB(left - 3, mDrawHeight + 3,
        left + priceTP.width + 3, mDrawHeight + mPaddingBottom);
    canvas.drawRect(bottomRect, selectPaint);
    canvas.drawRect(bottomRect, selectBorderPaint);
    priceTP.paint(
        canvas,
        Offset(bottomRect.left + (bottomRect.width - priceTP.width) / 2,
            bottomRect.top + (bottomRect.height - priceTP.height) / 2));
    //画左边
    TextPainter amountTP =
        getTextPainter(entity.amount.toStringAsFixed(2), Colors.white);
    amountTP.layout();
    double y = getY(entity.amount);
    double rightRectTop;
    if (y <= amountTP.height / 2) {
      rightRectTop = 0;
    } else if (y >= mDrawHeight - amountTP.height / 2) {
      rightRectTop = mDrawHeight - amountTP.height;
    } else {
      rightRectTop = y - amountTP.height / 2;
    }
    Rect rightRect = Rect.fromLTRB(mWidth - amountTP.width - 6,
        rightRectTop - 3, mWidth, rightRectTop + amountTP.height + 3);
    canvas.drawRect(rightRect, selectPaint);
    canvas.drawRect(rightRect, selectBorderPaint);
    amountTP.paint(
        canvas,
        Offset(rightRect.left + (rightRect.width - amountTP.width) / 2,
            rightRect.top + (rightRect.height - amountTP.height) / 2));
  }

  ///二分查找当前值的index
  int _indexOfTranslateX(double translateX, int start, int end, Function getX) {
    if (end == start || end == -1) {
      return start;
    }
    if (end - start == 1) {
      double startValue = getX(start);
      double endValue = getX(end);
      return (translateX - startValue).abs() < (translateX - endValue).abs()
          ? start
          : end;
    }
    int mid = start + (end - start) ~/ 2;
    double midValue = getX(mid);
    if (translateX < midValue) {
      return _indexOfTranslateX(translateX, start, mid, getX);
    } else if (translateX > midValue) {
      return _indexOfTranslateX(translateX, mid, end, getX);
    } else {
      return mid;
    }
  }

  double getBuyX(int position) => position * mBuyPointWidth;

  double getSellX(int position) => position * mSellPointWidth + mDrawWidth;

  getTextPainter(String text, [Color color = ChartColors.depthTextColor]) =>
      TextPainter(
          text: TextSpan(
              text: "$text", style: TextStyle(color: color, fontSize: 10)),
          textDirection: TextDirection.ltr);

  double getBottomTextY(double textHeight) =>
      (mPaddingBottom - textHeight) / 2 + mDrawHeight;

  double getY(double volume) =>
      mDrawHeight - (mDrawHeight) * volume / mMaxVolume;

  @override
  bool shouldRepaint(DepthChartPainter oldDelegate) {
//    return oldDelegate.mBuyData != mBuyData ||
//        oldDelegate.mSellData != mSellData ||
//        oldDelegate.isLongPress != isLongPress ||
//        oldDelegate.pressOffset != pressOffset;
    return true;
  }
}
