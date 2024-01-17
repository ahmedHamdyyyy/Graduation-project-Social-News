const String baseUrl = 'https://awful-underwear-toad.cyclic.app/';
// 'https://finalupdate.onrender.com/';
//auth
String get loginEP => 'users/login'; //post
String get logoutEP => 'users/logout'; //del
String get registerEP => 'users/register'; //post
String get confirmCodeEP => 'users/confirm-user'; //post
String get updatePasswordEP => 'users/update-password'; //post
String get resetPasswordEP => 'users/reset-password'; //get
String get confirmEmailEP => 'users/reset-code'; //post
String get forgetPasswordEP => 'users/forget-password'; //post
//user
String getUserEP(String id) => 'users/get-user/$id'; //put
String updateUserEP(String id) => 'users/update-user/$id'; //put
String deleteUserEP(String id) => 'users/delete-user/$id'; //delete
String followUserEP(String id) => 'users/$id/follow'; //put
String unfollowUserEP(String id) => 'users/$id/unfollow'; //put
String getFollowersEP(String id) => 'users/$id/get_followers'; //put
String getFollowingsEP(String id) => 'users/$id/get_following'; //put
//posts
String get addPostEP => 'posts/create-post/'; //post
String editPostEP(String id) => 'posts/update-post/$id'; //put
String deletePostEP(String id) => 'posts/delete-post/$id'; //delete
String reactPostEP(String id) => 'posts/react-post/$id/like'; //put
String getPostEP(String id) => 'posts/get-post/$id'; //get
String getUserPostEP(String id) => 'posts/get-user-post/$id'; //get
String get getGlobalPostsEP => 'posts/get-all-post'; //get
String get getLocalPostsEP => 'posts/get-local-post'; //get
String get getGeneratedPostsEP => 'posts/send_genetated_post/'; //get
String getGeneratedPostPostsEP(String id) => 'posts/get_generated_posts/$id'; //get
//comments
String get addCommentEP => 'comments/add-comment'; //post
String getPostCommentsEP(String id) => 'comments/get-post-comments/$id'; //get
String updateCommentEP(String id) => 'comments/update-comments/$id'; //put
String deleteCommentEP(String id) => 'comments/delete/$id'; //delete
String reactCommentEP(String id) => 'comments/react-comment/$id/like'; //put
//map
String get getMapPointsEP => 'posts/get_map_point/';
String get getMapPointPostsEP => 'posts/get_points_posts/';
//search
String get searchUserEP => 'users/search'; //post
String get searchPostEP => 'posts/search-post'; //post
//token
String get refreshTokenEP => 'users/refresh_token'; //post
String get testTokenEP => 'users/test'; //get
