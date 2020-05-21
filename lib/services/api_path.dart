class APIPath{
  static String job({String uid, String jobId}) => '/user/$uid/jobs/$jobId';
  static String jobs({String uid}) => 'user/$uid/jobs/';
  static String entry({String uid, String entryId}) => 'user/$uid/entries/$entryId';
  static String entries({String uid}) => 'user/$uid/entries';
}