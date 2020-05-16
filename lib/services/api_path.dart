class APIPath{
  static String job({String uid, String jobId}) => '/user/$uid/jobs/$jobId';
  static String jobs({String uid}) => 'user/$uid/jobs/';
}