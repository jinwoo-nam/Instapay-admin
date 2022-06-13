import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_info.dart';

class FranchiseeInfoDataSource {
  Future<Result<FranchiseeInfo>> getFranchiseeInfo() async {
    return Result.success(franchiseeInfoList);
  }
}

FranchiseeInfo franchiseeInfoList = FranchiseeInfo(
  title: '장나라 팬클럽',
  category: '개인 사업자',
  ceoName: '배재광',
  businessNumber: '1122111080',
  id: 'yuki@instapay.kr',
  contractDate: '2017-05-17 15:25:33',
  typeOfBusiness: '--',
  address: '서울 특별시 강남구 영동대로 85길 38 진성빌딩',
  bankAccount: '우리은행 1005503862118',
  nameOfBankUser: '배제광',
  typeOfTrade: '',
);
