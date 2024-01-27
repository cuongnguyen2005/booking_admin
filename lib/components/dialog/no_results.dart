import 'package:booking/source/typo.dart';
import 'package:flutter/material.dart';

class NoResult extends StatelessWidget {
  const NoResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Image.asset('assets/images/no_result.png'),
          Text('Không tìm thấy kết quả', style: tStyle.MediumBoldBlack()),
          const SizedBox(height: 5),
          Text('Xin vui lòng chọn tìm kiếm khác',
              style: tStyle.BaseRegularBlack()),
        ],
      ),
    );
  }
}
