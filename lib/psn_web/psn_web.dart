import 'package:c115/psn_web/psn_web_con.dart';
import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_page/psn_root_page.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnWeb extends PsnRootPage<PsnWebCon>{
  @override
  PsnWebCon onCon() => PsnWebCon();

  @override
  String bgName() => "bg1";

  @override
  Widget onCreate() => Column(
    children: [
      _titleWidget(),
      Expanded(child: WebViewWidget(controller: psnCon.webViewController))
    ],
  );

  _titleWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.only(bottom: 36.h),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/top_bg.webp'),
        fit: BoxFit.fill,
      ),
    ),
    child: SafeArea(
      top: true,
      child: SizedBox(
        width: double.infinity,
        height: 85.h,
        child: Stack(
          children: [
            PsnClick(
              onTap: (){
                PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
              },
              child: PsnImageWidget(name: "icon_back",width: 130.w,height: 85.h,),
            ),
            Align(
              child: PsnTextWidget(text: psnCon.title, size: 40.sp, color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}