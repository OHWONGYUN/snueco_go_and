enum CollegeType {
  engineering('공과대학'),
  humanities('인문대학'),
  socialSciences('사회과학대학'),
  naturalSciences('자연과학대학'),
  medicine('의과대학'),
  nursing('간호대학'),
  business('경영대학'),
  education('사범대학'),
  fineArts('미술대학'),
  music('음악대학'),
  pharmacy('약학대학'),
  humanEcology('생활과학대학'),
  agriculturalLifeSciences('농업생명과학대학'),
  veterinaryMedicine('수의과대학'),
  others('기타');

  final String text;
  const CollegeType(this.text);
}
